#!/bin/bash
export VERSION=$(grep '# color' colormake.pl |cut -f3 -d\ )
git tag -f $VERSION

mkdir -p tmp
ln -s $(pwd) tmp/colormake-$VERSION
(cd tmp && tar chvfz colormake-$VERSION.tar.gz colormake-$VERSION \
                     --exclude=tmp --exclude=.git --exclude=*.tar.gz)

ln README tmp/README.txt

mv tmp/*.tar.gz .
rm -rf tmp

echo
echo 'Press ENTER to push to github and Klaki... [CTRL+C to abort]'
read
scp colormake-$VERSION.tar.gz *.txt \
    bre@klaki.net:public_html/programs/colormake/
git push
