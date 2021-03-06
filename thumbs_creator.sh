#!/bin/bash

old_IFS=$IFS
IFS=$'\n'
rm -rf thumbs
mkdir thumbs
printf "### 点击小图标可跳转至ICNS原图  /  Click on the thumbnail to access the ICNS file  \n****  \n\n" >> thumbs/thumbs.md
cd icons
num=`ls *.icns|wc -l`
for i in `ls *.icns`
do
	sips -Z 64 -s format jpeg $i --out ../thumbs/${i%.*}.jpg
	iconName=${i%.*}
	urlName=$(echo ${i%.*}|sed 's/ /%20/g')
	echo '[!['$iconName'.jpg](./'$urlName'.jpg "'$iconName'")](../icons/'$urlName'.icns)' >> ../thumbs/thumbs.md
	echo '['$iconName'](../icons/'$urlName'.icns)  ' >> ../thumbs/textlist.md
done
cd ..
echo '[当前共有 '$num' 个图标]/[There are '$num' icons now]' >> README.md
IFS=$old_IFS
git add *
read -p "请输入commit信息: " commit
git commit -m "$commit"
git push origin master
echo "已完成!"
