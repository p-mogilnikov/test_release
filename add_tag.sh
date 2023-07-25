#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -c commit -t tag"
   echo -e "\t-c target commit ID"
   echo -e "\t-t Tag number in the format: vX.X.X"
   exit 1 # Exit script after printing help
}

while getopts "c:t:" opt
do
   case "$opt" in
      c ) commit="$OPTARG" ;;
      t ) tag="$OPTARG" ;;
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$commit" ] || [ -z "$tag" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "$commit"
echo "$tag"dd

git checkout release
git fetch
git pull

git merge $commit

poetry version $tag

git add -u
git commit -a -m "SF $tag version release"
git tag -a "$tag" -m "SF $tag version release"
git push -u origin release
git push origin $tag

git checkout prod
git fetch
git pull
git merge $tag
git push -u origin prod

git request-pull -p "SF $tag version release" release https://github.com/p-mogilnikov/test_release develop
