#安装依赖
yum -y install perl readline-devel pcre-devel gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel zlib-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers

#安装包已经下好
#visudo添加用户www可以使用sudo  不需要
#安装nginx
mkdir ~/src/nginx
wget http://nginx.org/download/nginx-1.8.0.tar.gz
tar -zxvf nginx-1.8.0.tar.gz
cd nginx-1.8.0
./configure --prefix=~/src/nginx/
make && make install

#安装redis
mkdir ~/src/redis
wget http://download.redis.io/releases/redis-3.0.2.tar.gz
tar xzf redis-3.0.2.tar.gz
cd redis-3.0.2
make
cp src/redis-benchmark ~/src/redis/bin/
cp src/redis-check-aof ~/src/redis/bin/
cp src/redis-check-rdb ~/src/redis/bin/
cp src/redis-cli ~/src/redis/bin/      
cp src/redis-server ~/src/redis/bin/
cp redis.conf ~/src/redis/conf/

#postgres安装
wget https://ftp.postgresql.org/pub/source/v9.3.5/postgresql-9.3.5.tar.gz
tar zxf postgresql-9.3.5.tar.gz
cd postgresql-9.3.5
./configure --prefix=~/src/postgres/
make
sudo make install


#php7安装 失败
tar -zxvf php-7.1.4.tar.gz
cd php-7.1.4
./configure --prefix=/home/www/src/php/ --with-pgsql=/home/www/src/postgres/ --with-pdo-pgsql --with-openssl=/usr/bin/openssl --with-mcrypt --enable-zip --enable-mbstring --enable-fpm --enable-opcache  --with-curl --with-libedit  --enable-pcntl   --enable-sysvmsg  --with-zlib-dir   --with-gd --with-jpeg-dir  --with-png-dir --with-freetype-dir --with-iconv  --enable-bcmath
make
sudo make install

#ssdb安装  失败
mkdir ~/src/redis
wget --no-check-certificate https://github.com/ideawu/ssdb/archive/master.zip
unzip master
cd ssdb-master
make clean  #执行失败
make