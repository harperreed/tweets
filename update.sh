#!/bin/sh
#
# Updates the repo with new tweets.
#
# Assumes that `last-tweet-id` in your root already contains the last tweet ID
# you've made.
set -x

login="harper"
email="harper@nata2.org"

last_id=$(cat last-tweet-id)

madrox --import=twitter --since-id=$last_id --email=$email $login
git merge -s ours $login

last_id=$(curl https://twitter.com/users/show/$login.json --silent | tr ',' "\n" | grep -m1 '"id"' | sed -e 's/"id"://g')
echo $last_id > last-tweet-id
