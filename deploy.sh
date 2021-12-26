#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e
gitbook build
cd _book 
git init 
git add -A 
git commit -m 'deploy'
git push -f https://github.com/cyw2015/MyStudy.git master:gh-pages