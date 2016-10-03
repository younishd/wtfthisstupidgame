#!/bin/bash
## Pack löve game for win32
git archive -o wtfthisgame.love --format=zip -9 HEAD
wget 'https://bitbucket.org/rude/love/downloads/love-0.10.1-win32.zip'
unzip 'love-0.10.1-win32.zip'
mkdir wtfthisgame-win32
cp -v love-0.10.1-win32/{*.dll,license.txt} wtfthisgame-win32/
cat love-0.10.1-win32/love.exe wtfthisgame.love > wtfthisgame-win32/wtfthisgame.exe
zip -r -9 wtfthisgame-win32.zip wtfthisgame-win32
mv -v wtfthisgame-win32.zip bin/
rm -rfv wtfthisgame-win32 love-0.10.1-win32 love-0.10.1-win32.zip
echo 'done.'
