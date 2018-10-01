#!/bin/bash

if [ "$1" = "-h" -o "$1" = "--help" ]
  then
  echo "Build packages in the hax folder."
  echo "E.g. to build pilatch/flip put a module in hax/pilatch/flip"
  echo "You can also pass package author/package pairs to download them."
  echo "E.g. ./build.sh elm/json pilatch/flip"
  exit 1
fi

set -e

cd `dirname $0`
here=`pwd`
export ELM_HOME=$here

build() {
  local author_package=$1 # should be in the format author/package
  local repo=https://github.com/$author_package.git

  cd hax

  local author_package_tuple=(${author_package//\// })

  if [ ! -e $author_package ]
    then
    mkdir -p ${author_package_tuple[0]}
    cd $_
    git clone $repo || return 1
    cd ..
  fi

  cd $author_package
  local version=`cat elm.json | jq -e .version | tr -d '"'`
  rm -rf ./elm-stuff
  elm make --docs=documentation.json
  cd $here

  local target_module=0.19.0/package/$author_package
  local target_dir=$target_module/$version
  rm -rf $target_dir
  mkdir -p $target_dir
  cp -r hax/$author_package/* $target_dir

  cd app
  rm -rf ./elm-stuff
  elm make src/Increment.elm --output=../index.html --debug
  cd $here

  local number_of_versions=`ls $target_module | wc -w | tr -d '[:space:]'`

  if [ $number_of_versions -gt 1 ]
    then
    echo ""
    echo "[WARNING] $number_of_versions versions of $author_package were found at $target_module:"
    ls $target_module
    echo "Your modified code may not be compiled in."
    echo "Consider modifying the version in $package/elm.json"
  fi
}

cd hax
author_packages=`find . -maxdepth 2 -mindepth 2 | sed 's@^./@@'`
cd $here

echo Building: $author_packages $@
echo

# Look for local things to build
for author_package in $author_packages
do
  build $author_package
done

# Download thingies
for author_package in $@
do
  build $author_package
done
