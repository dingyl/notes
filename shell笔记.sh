#!/bin/bash
shell中应用文件
	source filename = . filename
	如果是通过sh filename方式执行,脚本中的filename应该是绝对路径,否则找不到
	

Linux主机间建立信任关系，无ssh密码登陆主机的问题
	Linux主机A和主机B间可以建立信任关系，使主机A可以无密码ssh登陆主机B. 

	A主机上执行
		ssh-keygen -t rsa -b 1024 
		也可以使用 
		ssh-keygen -t dsa -b 1024
		  此时会在主目录下生成 .ssh目录，cd进入~/.ssh目录
		  执行 cat id_rsa.pub 将显示结果复制 (也可以使用cat id_dsa.pub，这个一般有现成的) 
	B主机上进入主目录下的~/.ssh ，如果没有，则执行ssh-keygen生成。 
		将复制的结果粘贴到B主机.ssh目录下的authorized_keys文件的最后一行 
		ok，信任关系建立了，在主机A上执行 ssh user@B 第一次执行，会提示一个确认,选择yes回车,结果不用输入密码，登录成功！ 
	
	其中有三点需要注意的地方，如果已经按照以上方法做了，还是不可以，那就比照下边三条对比一下：
		authorized_keys 文件必须是600权限(也就是-rw——-)或者644
		.ssh目录必须是700权限(也就是drwx——)
		/home/work目录 必须是 755权限 即drwxr-xr-x
		chmod 755 work
		  很多时候 /home/user 目录权限是777，不是755，怎么都不行，信任关系建不起来，最后把/home/user目录的权限由777改成755才能解决。


同步linux服务时间
	ntpdate -u ntp.api.bz//上海时间

cat > a.txt  在命令行下往一个文件中添加内容
shell脚本创建文件
cat > b.txt << DDD
this is a test
dfjldsfjlsjf
fsdlfjsdklfj
jgldsjgl
dingdsfsd
fjvmlxjdfsf
DDD

基本知识
	/dev/shm/ 目录是利用内存虚拟出来的存储空间，因此在这个目录下新建的任何数据，访问速度都是分厂快速的。同样，由于在内存当中，下次开机时就消失了
	cp -R /usr  /backup/usr.bak 2> /bak.error   当备份信息出错时，将错误信息导入到bak.error文件中
	gpg主要用于邮件加密，保证完整性（）和不可否认性(签名)
	环境变量的设置
	编辑 ～/.bash_profile
	添加export LIBRARY_PATH=/home/dir    //添加一个环境变量.表示库的搜索路径。
	ll -\
	l
	上面的命令相当于 ll -l 只是将一行数据用\来分割，放在两行进行输入
	安全方面的日志
	/var/log   
		messages  
		secure  wtmp   
常用shell命令
	ulimit -a 用来查看所有的限制
	cat /proc/filesystems 查看系统支持的文件系统
	命令别名设置
		alias l='ls -l'  	添加别名
		unalias l			删除别名
	df 列出文件系统的整体磁盘使用量 df -h
	du 评估文件系统的磁盘使用量
		du -sh /etc 
	mount -t vfat /dev/sdb1 /mnt	挂载文件
	umount /mnt						卸载文件
	umask 022 设置umask的值
	umask -S 显示默认的文件权限
	md5sum file   计算一个文件的md5值

	diff file1 file2 比较两个文件的区别
	uniq  将重复的干掉
	cut -d: -f1 /etc/passwd  以:作为分割符  f指定获取第几列的数据
	匹配一个单词
		\<s.*k\>
		a\{18\} a重复18次
	sort
		sort -t: +2(第三列)  -n(以数字的方式排序) /etc/passwd   实验未通过 +2不识别
		sort -n -r反向排序
	wc
		wc /etc/passwd
		-l行数   -w单词数     -c字符数 
		38        58         1793 /etc/passwd
		
	ls /etc/ -l | tee bbb | wc -l        用来将内容保存到bbb文件中
	du | sort -n -r | head -n3 | cut -f2  cut默认的分隔符是tab键
	
	文件重定向
		> 正确输出重定向，会将文件先清空。
		> b  创建一个b文件，或者清空一个文件
		2>  将错误的消息重定向，先将文件清空
		>> 重定向追加到文件的内容后面
		> test1 2>&1将正确和错误的消息都重定向到一个文件中
		
	ctrl+D 完成编辑
	
	简单字母转换
		tr "a-z" "A-Z"  将小写转换为大写
		tr "a-z" "A-Z" < /etc/passwd  将文件中的小写转换为大写
		tr '"a-m""n-z"' '"A-M""N-Z"'
		
	!$  刚才操作的文件
	uname -a  查看当前系统的相关信息
	free -m 查看内存
	clear 清理屏幕
	echo $PS1
	history -c 清理掉命令历史
	!213  调用213号历史指令
	!! 上一个命令
	!$ 上一个命令的最后一个参数
	$$ shell脚本的进程id号
	echo $?  返回上一个命令的返回值  如果为0表示返回值是true
	$aaa  aaa变量的值
	{}表示枚举
	touch {a,b,c}-{1,2,3} 将创建9个文件
	touch a b 创建了两个 a b文件
	touch "a b" 创建了一个文件
	echo `ls`  执行命令ls
	;用来分隔多个命令
	echo hello;ls /home/ding
	dmesg 检查引导硬件的识别启动过程
	ab sorry hello  当输入sorry后将会自动将其转化为hello
	unab sorry 取消ab的定义
	whatis ls
	apropos ls 获取命令的功能简介
	watch -n1 ls -l    实时跟踪一个命令的执行结果
	visudo 权限精细化
	getconf WORD_BIT   获取当前系统是的位数

系统用户文件
	/etc/passwd
	mysql:x:503:503::/home/mysql:/sbin/nologin
	用户名 密码位 用户id 组id 文本描述  目录  默认shell

	/etc/shadow
	ding:$6$ETDekzQeoI7oRIkI$ttrsGqysFIQeRVnGqg90xLtO7ieTriEPTE3kTLQiSOVQnS68ifOwgvLC6A98208zxwBVelJpJMqc4jcOCzljW0:16463:0:99999:7:::
	grub-md5-crypt对grub进行设置密码

find文件查找
	find /etc/ -size +1323023  -a -size  -3002340 -a -name init* -a -type f  -o -atime +5 -user root -exec ls -l {} \;
	find /etc/ -inum 12
	find /etc/ -perm +4000
grep文件内容操作
	grep -v(反向显示，不包含的显示出来) -A5(上面五行) -B5(下面五行) fdemo /etc/passwd | cut -d: -f7
	grep -v '^$' 去掉空行
	grep -rn include ./
	mac下
	grep include -rn ./
	获取遍历当前文件夹下的所有文件中包含include字符的文件的名称和所在的行号
	grep -l只显示目录 -R整个目录
	
网络测试 命令
	用telnet来检测 具体的端口来检测具体的协议
		telnet www.baidu.com 80            http协议
	
	压力测试
		模拟1000个客户端进行共进行1000次的查询   专业的测试方法
			ab -c 1000 -n 1000 http://www.sina.com.cn/   来进行压力测试 -c -n 的先后次序不能错  后面的/不能缺少
		模拟200个用户总共发送100000次请
			ab -n 100000 -c 200 127.0.0.1:80/
	查看网络通路
		traceroute www.baidu.com    依据icmp协议
		mtr 是综合性的查看网络连通性。显示到目标ip经过的所有ip的丢包率和延迟状态
		mtr www.baidu.com   用来查看通路
	system top vmstat netstat
		top 命令用来查询系统的内存 cpu  虚拟内存的使用情况
		vmstat 看到整个机器的CPU,内存,IO的使用情况
		
	ping 用来测试丢包率和连通性
	ping -s1024 -c4 www.baidu.com  依据icmp协议
	ping 192.168.3.0 -b  发布一个广播包
	
	抓包工具
		iptraf tcpdump wireshark    用来查看是不是服务器的丢包率比较高
	逆地址解析
		arping ip  用来查看是否是有中了arp病毒的网关，导致其它电脑冒充网关 导致有多个网关回应
		arp -s ip macAddress 绑定网关的地址
		arp -a
		arp -d ip
端口扫描
	nmap
		nmap 192.168.41.128  端口扫描
		nmap -p1-65535 ip    指定端口范围进行扫描
		
	ethtool eth0  用来检测是否插网线
	
	netstat
		-a (all)显示所有选项，默认不显示LISTEN相关
		-t (tcp)仅显示tcp相关选项
		-u (udp)仅显示udp相关选项
		-n 拒绝显示别名，能显示数字的全部转化成数字。
		-l 仅列出有在 Listen (监听) 的服務状态
		-p 显示建立相关链接的程序名  //需要提升权限才能显示程序名称
		-r 显示路由信息，路由表
		-e 显示扩展信息，例如uid等
		-s 按各个协议进行统计
		-c 每隔一个固定时间，执行该netstat命令。
		
		netstat -antup  查看监听端口的状态    LISTEN tcp协议
		netstat -antup | wc -l  查看当前有多少的连接请求
		常用
			netstat -tunpl | grep :20001 查看固定端口是否有监听程序
		
		根据连接状态，判断是否遭受攻击
			如果实际的连接数来自于同一个ip表示来自 cc攻击
			establish 状态表明连接正常，或者遭受cc攻击
			syn-flood ddos攻击   洪水攻击
	route =  netstat -r   路由表

计划任务
	at  一次性计划任务
		​at [ -f 文件名 ]  时间   将文件中的任务导入进来
		at < 最好是绝对路径at.script 9:00 2/2/11
		at -d   删除队列中的任务
		at -l  查看队列中的任务
			时间绝对计时
			midnight  noon  teattime
			hh:mm [today]
			hh:mm tomorrow
			hh:mm MM/DD/YY
			相对计时
			now + n minutes
			now + n hours
			now + n days
			at  now + 5 minutes

	crontab
		crontab -l  显示
		crontab -r  删除
		crontab -e  编辑
		时间知道的都填上，不知道的就用*来代替
		分钟  小时 天  月   星期   命令/脚本
		   0    4    *    *    *
			0    18   *    *    2,5      每周二和周五     /etc/bin/wall【用命令的程序路径】  /etc/issue   广播信息
			*/2  每隔2分钟    
					12-14  12点到14点
									3-6,9-12   3月到6月和9月到12月

用户管理
	查看用户和组 
		id  name
	查看用户的详细信息
		finger  name
	添加用户
		useradd name -d /home/name -s /bin/bash
	删除用户
		userdel name
	设置或者修改密码
		passwd ding  
	删除用户密码
		passwd -d ding
	查看用户密码信息
		passwd -S ding  
	锁定用户
		passwd -l ding | usermod -L ding
	解锁用户
		passwd -u ding | usermod -U ding 
	添加组
		groupadd softadm
	向用户组中添加用户
		gpasswd -a group user
		usermod -G group user
	改变目录的所属组
		chgrp softadm /software
		
权限管理
	给组赋予权限
		chmod g+w /software
		
hwclock 获取当前的硬件时间
	hwclock --set --date="9/22/96 23:45:24"		
	
grub 命令
	e 编辑当前的菜单启动项
	c 进入当前的grub的命令行方式
	b 启动当前的菜单项
	d 删除当前行
	ESC 返回grub启动菜单界面，取消对当前菜单项的所有修改


文件查看
	xxd /bin/ls  二进制查看
	hexdump /bin/ls 十六进制查看
	od /test   以二进制形式显示一个可执行文件
	od -t c 以ascii方式显示一个可执行文件
	od -t oCc 以八进制显示，并和ascii的值对照
	tail -f /var/log/messages    跟踪文件的变化，文件变化了，就变化
	head -n3  显示前三行  tail more cat

文件系统
	文件目录权限
		drwxrwxrwx
		目录
			x   进入目录的权限
			r    显示目录列表的权限
			w     在目录下创建文件和目录的权限，以及文件和目录的删除权限
		文件
			x     二进制文件的可执行权限
			r    文件内容的读取权限（同时可以复制）
			w    文件内容的修改权限（并不能删除）
	修复文件系统
		fsck  根据不同不同的文件系统提供统一的借口
		e2fsck 只用来修复ext2/ext3的文件系统
		badblocks 用来检查设备有没有坏道的
	fdisk 磁盘分区
		mkfs -t ext2 /dev/hdc6  磁盘格式化  这是一个综合命令
		mkfs -t vfat /dev/hdc5  将磁盘格式化为windows可读的格式
		e2lable /dev/hda "dingding" 
	备份数据
		dd if=/dev/sda of=/dev/sdb bs=【指定block的大小，单位/字节】 count=1[指定有多少个bs大小]
		dd if/dev/hdc of=/tmp/mbr.back bs=512 count=1 这样就可以将第一个上去中的mbr和分区表进行备份
		mkisofs -r -v -o test.img  /tmp /home /usr/local     将/tmp /home /usr/local全部备份到镜像文件test.img中
	文件属性
		stat file 查看文件的属性，权限等相关信息，应该是文件的inode信息
		dumpe2fs -hb /dev/sda  查看设备的文件系统中inode 和block信息，对于ext2以上文件系统有用

	文件挂载
		挂载U盘
			我们常见的USB设备格式是：FAT32格式、NFTS格式等。
				ext2 linux目前常用的文件系统
				msdos MS-DOS的fat，就是fat16
				vfat windows98常用的fat32
				nfs 网络文件系统
				iso9660 CD-ROM光盘标准文件系统
				ntfs windows NT 2000的文件系统
				hpfs OS/2文件系统
			挂u盘之前，运行命令cat /proc/partitions,看看现在系统中有哪些分区。
			插上u盘以后，再次运行上述命令，看看多出来什么分区。
			1) 插入U盘
			2) 输入 fdisk -l /dev/sda 查看输出结果，比如我的是这样的：
				# fdisk -l /dev/sda
				Disk /dev/sda: 131 MB, 131104768 bytes
				3 heads, 32 sectors/track, 2667 cylinders
				Units = cylinders of 96 * 512 = 49152 bytes
				Device Boot Start End Blocks Id System
				/dev/sdb1 * 1 2668 128016 6 FAT16
			3) 看了上面的输出就知道U盘所在的设备了，比如我的就是/dev/sdb1，接着便是挂载了
			假设我将U盘挂载到/mnt/usb目录(没有的话，新建)中，就是mount -t msdos /dev/sdb1 /mnt/usb
			如果是fat32
				mount -t vfat /dev/sdb1 /mnt/usb
			如果是ext2格式，就用命令：
				mount -t ext2 /dev/sda1 /mnt/usb
			4) 打开/mnt/usb 就可以看到你的U盘里的东西了！
				cd /mnt/usb
			5) 卸载命令则为：umount  /mnt/usb
		挂载镜像文件
			mount -o loop test.img /mnt 将
		挂载光盘
			vmvare cd设置中需要选中connected
			mount -t iso9660 /dev/cdrom /mnt
		挂载iso镜像文件
			mount -t iso9660 -o loop a.iso /mnt
			mount -t proc none /mnt
		挂载windows下的共享文件
			uid=`id -u www`
			gid=`id -u www`
			mount -t cifs -o username=ding,passwd=93177852,uid=$uid,gid=$gid,file_mode=0777,dir_mode=0777 //192.168.1.4/share /home/www/share/
			mount -t cifs -o username=ding,passwd=93177852,uid=501,gid=501,file_mode=0777,dir_mode=0777 //192.168.0.180/share/ /tmp/share/
			默认文件所有者为root
			mount -t cifs -o username=ding,passwd='pwd'  //192.168.1.101/shares   /var/www/html/       挂载windows|linux下的共享文件

解压缩文件
	tar 
		-z gzip格式
		-j bzip2格式
		-c 打包
		-v 显示打包过程详情
		-f 指定文件
		-x 解压
	tar -zcvf  newfilename dir/		将dir下的所有文件打压到newfilename中
	tar -zxvf   tar.gz    	解压
	tar -jxvf   tar.bz2 

内核参数操作
	/proc/ 中是内核中的相关参数的实际的值
		cat /proc/meminfo   获取内存信息
		cat /proc/partitions  获取分区信息
	参数配置文件
		直接修改/etc/sysctl.conf  来修改内核的一部分相关参数,写到文件中永久有效，但不立即生效
		sysctl -p  让文件中的修改立即生效
	临时修改，立刻生效，但重启后失效
		sysctl -w  net.ipv4.icmp_echo
		用来改内核参数
			/proc/sys目录下的文件是可以写的  这些文件是不能用vi进行编辑的，只能用echo
	导出内核参数
		sysctl -a > /tmp/a.sysctl 将所有可以导出的内核参数导出
	从文件中导入参数设置
		sysctl -p -f /file  将这个文件的设置导入

进程管理
    进程的状态
		S         T        R        D             Z             <            >
		sleep    stop    run        deepsleep    僵尸进程    高优先级    低优先级
	查看进程
		ps a	查看所有终端下程序
		ps x	查看所有非终端程序
		ps u	显示程序的用户名
		ps f	显示层序的父子关系
		ps au 显示所有控制台进程
		ps aux 显示控制台和后台进程
		ps auxf 增加进程的父子关系
	停止进程
		-9表示发送信号9来杀掉进程
		kill -9 pid  强制杀死进程，如果有子进程的话，将会产生僵尸进程
		kill -15 pid 让进程自己自杀,这样进程将会将自己的子进程也杀掉
		kill -19 pid 让进程停止的状态
		kill -18 pid 让进程继续
		
		killall httpd   直接干掉进程的名称
		
		skill ding|httpd  干掉ding用户的所有进程  skill可以直接通过用户名和进程名称来杀掉进程
		skill -9 /dev/pts/0  杀掉登录在pts/0上的登录用户进程
		
		pkill -u username  更精准的杀掉用户进程
		
	设置进程优先级
		-20 - 19  -20为最高优先级   
		nice -n -10 updatedb & 设置进程的优先级
		renice priority -10  如果已经设置过进程的优先级，使用renice来修改进程的优先级
	后台进程
		vi & 使vi在后台运行
		jobs 用来查看后台运行的任务
		kill %1 杀掉第一个任务
		fg %3 让任务3在前台运行起来
		bg %3 让任务3在后台运行
		nohup updatedb & 这样当我退出的时候，这个进程将继续执行。
		
shell编程
	bash配置
		vi ~/.bash_profile  这是bash初始化的目录
	环境变量
		reset 将整个环境重置一下
		set 获取所有的变量
		env 查看所有的全局变量
		export AAA  将AAA编程全局变量，这样子shell就可以访问AAA的值了
		export aaa=fsdf  定义全局变量的值
		PATH=$PATH:/tmp/ddd
		
	#表示注释
	
	在shell脚本声明
		第一个字符非#，表示这是一个bash脚本
		第一个字符是#，但第二个字符不是！，表示这是一个csh脚本
		第一个字符是#，且第二个字符是！后面就是指定脚本的路径了
		bash本身是不支持正则表达式的，但某些命令支持如grep ，awk等命令

	函数声明
		匿名函数
			()用来声明函数的
		命名函数
			aaa()
			{
				
			}
			定义了一个aaa函数

	判断表达式[ expression ]
		字符串测试
			运算符				说明
			string				判断string是否是非空
			-n string			判断string是否是非空
			-z string			判断string是否是空串
			string1 = string2	判断string1和string2是否相等
			string1 != string2	判断string1和string2是否不相等
			[ $USER = root ] 判断是否相等 =号两边空格不能忘记  判断字符串是否相等
			user=root 赋值
		整数测试
			[ num1 op num2 ]
			运算符			说明
			num1 -eq num2	等于
			num1 -ne num2	不等于
			num1 -gt num2	大于
			num1 -ge num2	大于或等于
			num1 -lt num2	小于
			num1 -le num2	小于或等于
			[ $# -eq 0 ]  判断数值是否相等
			
		文件测试
			[  op  file  ]
			运算符	 说明 
			-a file	 file是存在
			-b file	 file是存在，且为块文件
			-c file	 file是存在，且为字符文件
			-d file	 file是存在，切为目录
			-e file	 file是存在，同-a
			-f file	 file存在，且为常规文件
			-s file	 file是否为非空文件
			-L file	 file是否为符号链接
			-r file	 file是否可读
			-w file	 file是否可写
			-x file	 file是否可执行
			[1-9] 表示1-9 正则表达式中的判断
			[ -f /etc/passwd ] 判断/etc/passwd是否是一个文件
			[ -d /oracle/ ] 判断是否是一个目录
		算数表达式
			i=i+10;
			((i=i+10))
			((i=i%10))//取余
			((i=i**10))//求幂

	输入
		read aaa 输入变量值
		read -p "please input your name:" AAA 提示输入变量值
	输出
		echo 
		printf
	调试
		bash -vx ./test.sh  调试执行过程

	选择判断
		read aaa    
		if [ $aaa = ding ];then
				echo "";
		elif [ express ];then
			echo ""
		else
			echo ""
		fi
	switch判断
		read aaa
		case $aaa in
			ding ) 
				echo hello world
				;;
			root )
				echo nice to meet your
				;;
			* )
				echo ksdljf
				;;
		esac
		
	pgrep httpd  返回的是一串pid
	aaa=`pgrep httpd`将执行结果赋值给变量

	for语句
		for i in aaa
			do
				kill -9 $i
			done
		seq 1 100  返回1 到 100 的所有整数
		for i in "`seq 1 9`"
			sleep 1 休息一秒
	while语句
		while [ i -lt 100 ]
			do 
				i=$[$i+1]
				echo -n "$i "
			done
    
    
流处理字符文件
	sed awk 主要用来查找替换
		sed -e 's/root/shrek/g' /etc/passwd  将文件中的root全部替换为shrek  这里面没有改变，只是一个过滤器
		sed -n -e '' 按照后面的规则进行显示 -e 后面添加的是规则
		sed -n -e '/'
		sed -e '/bash/s/demo/ding/g' /etc/passwd  从文件中查找将含有bash的行中的demo字符转换为ding
		sed的链式操作
		sed -e 's/root/shrek/' -e 's/bash/nologin/' /etc/passwd
		chkconfig --list | awk '$1=="httpd"{print $5}'
		chkconfig --list | awk 'BEGIN {iii=0} { if ($5=="3:on") iii+=1 } END {print iii}'
		awk -F : ''  < /etc/passwd        定义以：为分隔符

软件安装

	安装
		rpm -i filename.rpm  自动解压rpm包安装文件，并安装到缺省目录下（参数i使进入安装模式）
	软件卸载
		rpm -e   [package name]   卸载软件
		rpm -e sudo  卸载sudo软件包
		rpm -e --nodeps samba 不考虑依赖性强行卸载
	rpm 安装
		rpm -ivh --force  xxx.rpm 强制重装
		rpm -qa 查看所有安装的包
		rpm -ql samba 查询具体的包 以及包的所有信息
		rpm -q samba 查询mysqld软件包安装信息
		--excludedocs	不安装软件包文档文件
		大多数安装包都不允许改变安装路径
		--prefix=PATH	将软件包安装到指定的路径下
		--test			只是测试安装，并不实际安装,看有没有相依赖的软件包
		rpm -ivh samba  安装软件
		rpm -ivh --replacepkgs --replacefiles samba 覆盖安装
		
	编译安装
		wget http://mirrors.hust.edu.cn/apache//httpd/httpd-2.2.29.tar.gz  下载源码
		tar zxvf httpd-2.2.29.tar.gz  解压源码
		cd httpd
		./configure --prefix=/usr/local/httpd --with-mpm=worker 指定安装位置
		make 编译
		make install  安装
		
	yum依赖安装
		yum的配置
			yum软件仓库配置
				/etc/yum.repos.d/*.repo  文件中配置
			vim /etc/yum.conf
			cachedir=/var/cache/yum设置安装包的下载存储地址
		yum -y install softname   自动解析依赖，进行安装，yum安装的是rpm包，并不是源码安装
		yum remove mysqld
		yum默认安装位置
			执行文件在/usr/bin/softname
			配置文件在/etc/softname/confnamecd 
			
		yum光盘安装软件
			1，虚拟机中添加光盘镜像
			2，将光盘设备挂载到/media/cdrom/目录
				mkdir -p /media/cdrom
				mount /dev/cdrom /media/cdrom
			3,编辑yum仓库的配置文件
				自定义仓库
				vim /etc/yum.repos.d/rhel7.repo
				[rhel7]
				name=rhel7
				baseurl=file:///media/cdrom
				enabled=1
				gpgcheck=0
			4,安装apache
				yum install httpd
			5,运行服务，并设置开机启动
				systemctl start httpd
				systemctl enable httpd
			6,浏览器访问
			
vim配置	
	vim全局配置
		vim /etc/vimrc 添加内容
	用户配置
		vim ~/.vimrc 
		
	:syntax on 高亮显示
	:set nu  设置行号
	:set nonu   取消行号
	:! ifconfig  执行当前系统所在环境的指令
	:r !ifconfig  将当前系统所在的指令执行结果插入到当前行的后面
	:set encoding=utf-8  //设置vim的文件编码
	:set fileencodings=utf-8
	:language messages zh_CN.utf-8
	:map <F5> <ESC>:w<CR>
	
	vim快捷键定义
		:map ctrl+v+p  I#<ESC> 
		:map ^P I#<ESC>  在行首插入#后返回命令模式  
		快捷键为ctrl+p
	2.在用户目录建立.vimrc
		[root@localhost ~]#vim vimrc
	3.配置.vimrc文件加入
		syntax on
		set tabstop=4
		set softtabstop=4
	2）设置缩进的空格数为4
		set shiftwidth=4
	3）设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取 消设置：
		set autoindent
	4）设 置使用 C/C++ 语言的自动缩进方式：
		set cindent
	5）设置C/C++语言的具体缩进方式：(这一句在修改的时候会有一点问题，可以删去)
		set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
	6）如果想在左侧显示文本的行号，可以用以下语句：
		set nu

	三种工作模式
		命令行模式（默认刚进入时的模式）
		插入模式i a o   按esc键将退出插入模式，转到命令行模式。在命令行模式中shift+：wq 将保存退出
		编辑模式  在命令行模式中shift+： 进入到编辑模式 ，
		
	操作命令
		w保存修改
		w new_filename
		wq 保存退出
		q!不保存修改退出
		wq！强制保存退出
		ctrl+z 强制退出
		shift+ZZ 在编辑模式下快速保存退出
		：n  //设定行号，直接转到相应的行数
		
		插入命令
			a 在光标后附加文本
			A 在本行行末附加文本
			i 在光标前插入文本
			I 在本行开始插入文本
			o 在光标下插入新行
			O 在光标上插入新行
			
		定位命令
			h 方向左键
			j 方向下键
			k 方向上键
			l 方向右键
			$ 移至行尾
			0 移至行首
			H 移至屏幕上端
			M 移至屏幕中央
			L 移至屏幕下端
			移动到下一个词w，移动到上一个词b
			
		删除字符 
			x  删除光标所在处字符
			nx删除光标所在处n个字符
			dd 剪切光标所在行
			:1,2d  1到2行删除
			:1,2>>  1到2行缩进
			d+G  从当前行后面的都删除
			n1,n2d   n1行到n2行之间的所有行将被删除

		复制剪切
			yy，Y复制当前行
			nyy，nY复制当前行以下的n行
			p 粘贴在当前光标所在行下或行上
			
		搜索和替换
			:set ignoreacase  忽略大小写，查找
			:/string    再按n键查找下个字符
			:%s/old/new/g  全文替换所指定字符串
			:n1,n2s/old/new/g在一定范围内替换指定字符串
			:n1,n2s/old/new/c在一定范围内替换指定字符串 将会有确认项弹出

	u  取消上一步的操作
文件共享
	linux加载windows共享文件
		mount -t cifs -o username=ding,passwd='pwd'  //192.168.1.101/shares   /var/www/html/       挂载windows|linux下的共享文件

	window下加载linux共享文件
		samba设置
			vim /etc/samba/smb.conf
	linux之间传输文件
		scp 
			-p指定文件属性
			-r复制目录
			-P(指定端口)
			scp -r /home/* root@192.168.0.254:/home/ding		完全备份
		rsync 
			配置文件
				vim /etc/xinetd.d/rsync
				disable = no //开启服务
			重启服务
				service xinetd restart
			-a保留原文件的时间戳
			-z显示详细信息
			-v压缩
			-r递归
			-H保持文件硬链接
			-e ssh使用ssh加密传输
			--progress 显示传输过程
			--delete	删除目标备份没有的文件
			rsync -azvr centos/ /home/ding/test/ 将centos下的文件全都cp到test下
			rsync -azvr centos/ ding@192.168.253.129:/home/ding/test/	备份
			rsync -arHz --delete name@ip:/dir localhost   增量备份

	应用
		完全备份远程服务器到本地，相互之间添加主机信任
		添加计划任务
		/usr/bin/scp -rp webadmin@ip:/path /localpath

设置linux系统的启动模式
	vim /etc/inittab 

linux开机启动项设置
	1：利用命令行chkconfig命令进行设置
	简要说明一下chkconfig命令的使用方法
	--list:将目前的各项服务状态栏显示出来
	--level:设置某个服务在该LEVEL下启动或者关闭
	单独查看某一服务是否开机启动的命令：chkconfig --list 服务名
	单独开启某一服务的命令：chkconfig 服务名 on
	单独关闭某一服务的命令：chkconfig 服务名 off
	查看某一服务的状态：/etc/intd.d/ 服务名 status
	chkconfig --level 235 httpd on 设置在运行级别为2或3或5时启动

	2: vi	/etc/rc.local添加需要shell脚本内容
	
网络的设置
	vim /etc/sysconfig/network-scripts/ifcfg-eth0
	
	DEVICE=eth0
	HWADDR=00:0C:29:06:B2:1C
	TYPE=Ethernet
	UUID=b225e458-686a-4bab-a096-81c0b60bac8c
	ONBOOT=yes                                                                  
	NM_CONTROLLED=yes
	BOOTPROTO=dhcp
	
防火墙规则
	iptables设置
		iptables -L 查看防火墙是否设置了规则
		iptables -F 将所有规则清掉
		iptables -t nat -L 
		/etc/rc.d/init.d/iptables save 保存设置到配置文件/etc/sysconfig/iptables
	selinux设置
		getsebool -a | grep samba  查看所有验证设置
		setsebool -P samba_enable_home_dirs on  开启目录权限
		vi /etc/selinux/config
		seslinux  修改配置文件  为Disabled
		sestatus  查看seslinux的状态

系统语言设置
	/etc/profile.d/lang.sh
	
日期命令date
	date "+%Y-%m-%d %H:%M:%S" 日期时间
	date "+%Z"  时区
	date "+%A"  星期几