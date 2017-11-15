# Home Dir


### Install

```
cd ~
git init
git remote add origin https://github.com/mateusan/home-dir
git pull origin master
#git fetch --all
#git reset --hard origin/master
```

or

```
cd ~
wget git reset https://github.com/mateusan/home-dir/archive/master.zip -O home-dir.zip;
unzip home-dir.zip;
mv -fv home-dir-master/* .;
mv -fv home-dir-master/.* .;
rm -rf home-dir.zip home-dir-master/;
```

