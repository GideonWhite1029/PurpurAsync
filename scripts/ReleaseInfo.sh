sha1() {
  sha1sum $1 | awk '{print $1}'
}

md5() {
  md5sum $1 | awk '{print $1}'
}

prop() {
  grep "${1}" gradle.properties | cut -d'=' -f2 | sed 's/\r//'
}

commitid=$(git log --pretty='%h' -1)
mcversion=$(prop mcVersion)
gradleVersion=$(prop version)
preVersion=$(prop preVersion)
tagid="$mcversion-$commitid"
jarName="purpurasync-$mcVersion.jar"
purpurasyncid="PurpurAsync-$commitid"
releaseinfo="releaseinfo.md"
make_latest=$([ $preVersion = "true" ] && echo "false" || echo "true")

rm -f $releaseinfo

mv build/libs/PurpurAsync-paperclip-$gradleVersion-reobf.jar $jarName
echo "name=$purpurasyncid" >> $GITHUB_ENV
echo "tag=$tagid" >> $GITHUB_ENV
echo "jar=$jarName" >> $GITHUB_ENV
echo "info=$releaseinfo" >> $GITHUB_ENV
echo "pre=$preVersion" >> $GITHUB_ENV
echo "make_latest=$make_latest" >> $GITHUB_ENV

echo "$purpurasyncid [![download](https://img.shields.io/github/downloads/GideonWhite1029/PurpurAsync/$tagid/total?color=0)](https://github.com/GideonWhite1029/PurpurAsync/releases/download/$tagid/$jarName)" >> $releaseinfo
echo "=====" >> $releaseinfo
echo "" >> $releaseinfo
if [ $preVersion = "true" ]; then
  echo "> This is an early, experimental build. It is only recommended for usage on test servers and should be used with caution." >> $releaseinfo
  echo "> **Backups are mandatory!**" >> $releaseinfo
  echo "" >> $releaseinfo
fi
echo "### Commit Message" >> $releaseinfo

number=$(git log --oneline master ^`git describe --tags --abbrev=0` | wc -l)
echo "$(git log --pretty='> [%h] %s' -$number)" >> $releaseinfo

echo "" >> $releaseinfo
echo "### Checksum" >> $releaseinfo
echo "| File | $jarName |" >> $releaseinfo
echo "| ---- | ---- |" >> $releaseinfo
echo "| MD5 | `md5 $jarName` |" >> $releaseinfo
echo "| SHA1 | `sha1 $jarName` |" >> $releaseinfo