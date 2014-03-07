# Bamboo & Puppet Dynamic Environments

Bamboo can watch a git repository for changes, and kick off tests
or deployments.

## Simple Plan

This is a simple build task to watch my repo on github, and create a
Puppet environment for each git tag.  Normally build tasks would create
artifacts and you would use a deployment plan to release.

1. Create a plan.
2. Configure "Source Code Checkout" task to pull from Github.  Go into the Repository Configuration, and under "Advanced options" set "Fetch whole repository" or you won't see tags.
3. Add a new Script task, with contents like:

```
#!/bin/bash

reponame="puppet-gonzo-demo"
gitbase="https://github.com/croomes/${reponame}"
envbase="/etc/puppetlabs/puppet/environments"
srcbase=$(pwd)

for tag in $(git tag -l); do
  tarball="${tag}.tar.gz"
  if [ -d "${envbase}/${tag}" ]; then
    echo "Release exists, skipping ${tag}"
  else
    if wget -nv -O $tarball ${gitbase}/archive/${tarball}; then
      # Extract, and copy contents to Puppet envbase
      (tar zxf "${srcbase}/${tarball}" && \
       mv ${reponame}-${tag} ${envbase}/${tag}) || \
         (echo "ERROR extracting release"; exit 1)
      echo "SUCCESS Created new release ${tag}"
    else
      echo "ERROR downloading release ($?)"
      exit 1
    fi
  fi
done
```

## Build & Deployment Plans

This would be better as you can see where a release has been deployed to, but it will
currently create an environment like 'lab_13' rather than the git tag.  More work
needed to figure this out...

1. Create a plan
2. Configure "Source Code Checkout" task to pull from Github.  Go into the Repository Configuration, and under "Advanced options" set "Fetch whole repository" or you won't see tags.
3. On the plan, Configure artifacts, by creating a definition with "*.tar.gz".
4. Add a new Script task, with contents like:

```
#!/bin/bash

gitbase="https://github.com/croomes/puppet-gonzo-demo"

for tag in $(git tag -l); do
  tarball="${tag}.tar.gz"
  if [ -d "${envbase}/${tag}" ]; then
    echo "Release exists, skipping ${tag}"
  else
    if wget -nv -O $tarball ${gitbase}/archive/${tarball}; then
      echo "SUCCESS Downloaded new release ${tag}"
    else
      echo "ERROR dowloading release ($?)"
      exit 1
    fi
  fi
done
```

5. Create a Deployment project.
6. Create an Environment (e.g. "Lab")
7. Configure Versioning.  Set to "${bamboo.shortPlanKey}_${bamboo.buildNumber}" (TODO: figure out how to pass tag)
8. Configure Task, set artifact to tarball created by the build task.
9. New Task to extract artifact, like:

```
#!/bin/bash

workdir=$(pwd)
tarball=(*.tar.gz)

env="${bamboo.shortPlanKey}_${bamboo.buildNumber}"
env=$(echo $env | sed -e 's/\(.*\)/\L\1/')

mkdir /etc/puppetlabs/puppet/environments/${env} 2>/dev/null

(cd /etc/puppetlabs/puppet/environments/${env} && \
 tar zxf ${workdir}/${tarball}) || \
   (echo "ERROR deploying ${env} ($?)"; exit 1)

echo "SUCCESS, deployed ${env}"
exit 0
```
