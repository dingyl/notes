#安装依赖
yum -y install perl readline-devel pcre-devel gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libmcrypt libmcrypt-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel zlib-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers libedit libedit-devel

#安装的时候不要在挂载目录,可以将文件复制到本地进行安装

1.安装libiconv
对文本进行编码间的转换，用它来处理中文各种编码之间的转换。
#tar zxvf libiconv-1.14.tar.gz
#cd libiconv-1.14/
#这里指定目录方便编译php的时候引用
#./configure --prefix=/usr/local/
#make
#make install
cd ../

2.安装libmcrypt 实现加密功能的库。
# tar zxvf libmcrypt-2.5.8.tar.gz
# cd libmcrypt-2.5.8/
# ./configure
# make
# make install
# /sbin/ldconfig
# 注：这里不要退出去了。
# cd libltdl/
# ./configure --enable-ltdl-install
# make
# make install
# cd http://www.cnblogs.com/

3. 安装mhash(哈稀函数库)
# tar jxf mhash-0.9.9.9.tar.bz2 
# cd mhash-0.9.9.9/
# ./configure
# make
# make install
# cd ../

#为下面安装mcrypt做准备
ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
ln -s /usr/local/lib/libmhash.a /usr/lib/libmhash.a
ln -s /usr/local/lib/libmhash.la /usr/lib/libmhash.la
ln -s /usr/local/lib/libmhash.so /usr/lib/libmhash.so
ln -s /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
ln -s /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1

4. 安装mcrypt
# tar zxvf mcrypt-2.6.8.tar.gz
# cd mcrypt-2.6.8/
# /sbin/ldconfig
#./configure
# make
# make install
# cd ../

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
mkdir /usr/local/redis
wget http://download.redis.io/releases/redis-3.0.2.tar.gz
tar xzf redis-3.0.2.tar.gz
cd redis-3.0.2
make
cp src/redis-benchmark /usr/local/redis/bin/
cp src/redis-check-aof /usr/local/redis/bin/
cp src/redis-check-rdb /usr/local/redis/bin/
cp src/redis-cli /usr/local/redis/bin/      
cp src/redis-server /usr/local/redis/bin/
cp redis.conf /usr/local/redis/conf/

#postgres安装
wget https://ftp.postgresql.org/pub/source/v9.3.5/postgresql-9.3.5.tar.gz
tar zxf postgresql-9.3.5.tar.gz
cd postgresql-9.3.5
./configure --prefix=~/src/postgres/
make
sudo make install

#php7安装
tar -zxvf php-7.1.4.tar.gz
cd php-7.1.4
#不支持--with-mysql
./configure --prefix=/usr/local/php/ --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pgsql=/usr/local/pgsql/ --with-pdo-pgsql=/usr/local/pgsql/ --with-config-file-path=/usr/local/php/etc --with-config-file-scan-dir=/usr/local/php/conf.d --enable-fpm --with-fpm-user=ding --with-fpm-group=ding  --with-mcrypt --enable-zip --enable-mbstring --enable-fpm --enable-opcache  --with-curl --with-libedit  --enable-pcntl   --enable-sysvmsg  --with-zlib-dir   --with-gd --with-jpeg-dir  --with-png-dir --with-freetype-dir --with-iconv=/usr/local/  --enable-bcmath
make
sudo make install
cp php.ini-development /usr/local/php/etc/
cp php.ini-production /usr/local/php/etc/ 

#ssdb安装
mkdir /usr/local/redis
unzip master
cd ssdb-master
make clean
make
cp ssdb-server /usr/local/ssdb/bin/
cp ssdb.conf /usr/local/ssdb/conf/
cp -R ./api/ /usr/loca/ssdb/
cp ssdb-* /usr/local/ssdb/bin/
cp -R ssdb_cli/ /usr/local/ssdb/bin/


#mysql安装
yum -y install cmake
groupadd mysql
useradd -r -g mysql mysql


#设置编译参数

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/usr/local/etc/ -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci  

make install  

#参数解释
-DCMAKE_INSTALL_PREFIX=dir_name 设置mysql安装目录 
-DMYSQL_UNIX_ADDR=file_name 设置监听套接字路径，这必须是一个绝对路径名。默认为/tmp/mysql.sock 
-DDEFAULT_CHARSET=charset_name 设置服务器的字符集。
缺省情况下，MySQL使用latin1的（CP1252西欧）字符集。cmake/character_sets.cmake文件包含允许的字符集名称列表。 
-DDEFAULT_COLLATION=collation_name 设置服务器的排序规则。 
-DWITH_INNOBASE_STORAGE_ENGINE=1 
-DWITH_ARCHIVE_STORAGE_ENGINE=1
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 
-DWITH_PERFSCHEMA_STORAGE_ENGINE=1 存储引擎选项：
MyISAM，MERGE，MEMORY，和CSV引擎是默认编译到服务器中，并不需要明确地安装。
静态编译一个存储引擎到服务器，使用-DWITH_engine_STORAGE_ENGINE= 1
可用的存储引擎值有：ARCHIVE, BLACKHOLE, EXAMPLE, FEDERATED, INNOBASE (InnoDB), PARTITION (partitioning support), 和PERFSCHEMA (Performance Schema) 
-DMYSQL_DATADIR=dir_name 设置mysql数据库文件目录 
-DMYSQL_TCP_PORT=port_num 设置mysql服务器监听端口，默认为3306 
-DENABLE_DOWNLOADS=bool 是否要下载可选的文件。例如，启用此选项（设置为1），cmake将下载谷歌所使用的测试套件运行单元测试。 
