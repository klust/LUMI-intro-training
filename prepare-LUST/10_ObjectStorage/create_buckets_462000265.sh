#! /usr/bin/env bash

if [ $# -ne 1 ]
then
   echo "This script needs an argument: The training project that needs access to some objects."
   exit
fi
project="$1"

# Uncomment on LUMI, but when doing this on your laptop you won't have
# this module and may not even have the module command. 
# module try-load lumio

# Go to the directory with this script
cd $(dirname $0)

s3cmd -c ~/.s3cfg-lumi-462000265 --acl-public  mb s3://intro-training.public
s3cmd -c ~/.s3cfg-lumi-462000265 --acl-private mb s3://intro-training.private

s3cmd -c ~/.s3cfg-lumi-462000265 --acl-public  put buckets/training.public/public-in-public.txt    s3://intro-training.public
s3cmd -c ~/.s3cfg-lumi-462000265 --acl-private put buckets/training.public/private-in-public.txt   s3://intro-training.public
s3cmd -c ~/.s3cfg-lumi-462000265 --acl-public  put buckets/training.private/public-in-private.txt  s3://intro-training.private
s3cmd -c ~/.s3cfg-lumi-462000265 --acl-private put buckets/training.private/private-in-private.txt s3://intro-training.private

s3cmd -c ~/.s3cfg-lumi-462000265 --acl-public  put buckets/training.public/HTML/public.html   s3://intro-training.public/HTML/
s3cmd -c ~/.s3cfg-lumi-462000265 --acl-private put buckets/training.private/HTML/private.html s3://intro-training.private/HTML/

s3cmd -c ~/.s3cfg-lumi-462000265 --acl-private put buckets/training.public/HTML/shared.html  s3://intro-training.public/HTML/
s3cmd -c ~/.s3cfg-lumi-462000265 --acl-private put buckets/training.private/HTML/shared.html s3://intro-training.private/HTML/

s3cmd -c ~/.s3cfg-lumi-462000265 setacl --acl-grant="read:$project\$$project" s3://intro-training.public/HTML/shared.html
s3cmd -c ~/.s3cfg-lumi-462000265 setacl --acl-grant="read:$project\$$project" s3://intro-training.private/HTML/shared.html

set -x
s3cmd -c ~/.s3cfg-lumi-462000265 ls
s3cmd -c ~/.s3cfg-lumi-462000265 ls s3://intro-training.public
s3cmd -c ~/.s3cfg-lumi-462000265 ls s3://intro-training.private
set +x
