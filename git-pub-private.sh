#! /bin/bash

# save our current locatio
ROOT=`pwd`

# Build directories that will contain the local and remote
# repositories.
# In actual usage the remote repositories will be on
# a Git repo hosting web site (e.g. GitHub)
mkdir local remote

# create local public and private repo
## public
cd $ROOT/local
mkdir public
cd public
mkdir dir1 dir2
date > dir1/pub-1-1.txt
date > dir1/pub-1-2.txt
date > dir2/pub-2-1.txt
git init
git add -A
git commit -m "public: Initial commit"

## private (will contain public as a submodule)
cd $ROOT/local
mkdir private
cd private
mkdir my-dir
date > my-dir/priv-1-1.txt
date > my-dir/priv-1-2.txt
git init
git add -A
git commit -m "private: Initial commit"

# Create the remote repositories
cd $ROOT
git clone --bare local/public remote/public.git
git clone --bare local/private remote/private.git

# Add the remote to the local repos
cd $ROOT/local/public
git remote add origin $ROOT/remote/public.git

cd $ROOT/local/private
git remote add origin $ROOT/remote/private.git


# make public a submodule of private
cd $ROOT/local/private
git submodule add $ROOT/remote/public.git

## The submodule function:
##    - Clones the submodule under the current directory and by
##      default checks out the master branch.
##    - Adds the submodule's clone path to the ".gitmodules"
##      file and adds this file to the index, ready to be
##      committed.
##    - Adds the submodule's current commit ID to the index,
##      ready to be committed.

## commit the change
git commit -am "Add public submodule"
## and push to the remote
## --set-upstream is only need the first time
git push --set-upstream origin master

# Make a change to the public repo and update
# the submodule in private
cd $ROOT/local/public
date >> dir1/pub-1-1.txt
git commit -am "Make a change to dir1/pub-1-1.txt"
git push --set-upstream origin master

cd $ROOT/local/private/public
# if you look with
# git log
# you will see that the submodule is behind the
# public repo.
# To bring it up to data do:
git pull

# Now we want to make a change in the public submodule
# of the private repo and push that change to the
# remote public repo
cd $ROOT/local/private/public
date >> dir2/pub-2-1.txt
git commit -am "Making a change to pub-2-1.txt"
git push

# Now we can update the local public repo
cd $ROOT/local/public/
git pull
