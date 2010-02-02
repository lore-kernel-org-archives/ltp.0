Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Nc96O-0001e9-Fy
	for ltp-list@lists.sourceforge.net; Tue, 02 Feb 2010 03:06:56 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nc96M-0002VT-R8
	for ltp-list@lists.sourceforge.net; Tue, 02 Feb 2010 03:06:56 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.10])
	by out07.sjc.mx.trendmicro.com (Postfix) with ESMTP id A061BB7A450
	for <ltp-list@lists.sourceforge.net>;
	Tue,  2 Feb 2010 03:06:48 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1BF639582D
	for <ltp-list@lists.sourceforge.net>;
	Tue,  2 Feb 2010 03:06:46 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Feb 2010 12:06:45 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 2 Feb 2010 12:06:45 +0900
Message-ID: <000601caa3b4$c096ceb0$41c46c10$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] 2010-02-01 cvs "make clean" problem (Rapidly)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,


"2010-02-01 cvs" may break system, I think.

If this information was my mistake, please forgive me.
But I have duty of the report.


I tried "make clean" with 2010-02-01 cvs in RHEL5.4 system.
(Archecture : x86 and ia64)
But it failed as follows:
------------
[...]
rm: cannot remove
`//sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map': Operation not
permitted
rm: cannot remove
`//sys/devices/system/cpu/cpu0/cache/index0/number_of_sets': Operation not
permitted
rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/size':
Operation not permitted
rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/attributes':
Operation not permitted
rm: cannot remove
`//sys/devices/system/cpu/cpu0/cache/index0/ways_of_associativity':
Operation not permitted
rm: cannot remove
`//sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size': Operation
not permitted
rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/level':
Operation not permitted
rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/type':
Operation not permitted
rm: cannot remove `//sys/devices/system/cpu/cpu0/online': Operation not
permitted
rm: cannot remove `//sys/devices/platform/bluetooth/bus': Operation not
permitted
rm: cannot remove `//sys/devices/platform/bluetooth/subsystem': Operation
not permitted
rm: cannot remove `//sys/devices/platform/bluetooth/modalias': Operation not
permitted
rm: cannot remove `//sys/devices/platform/bluetooth/power/wakeup': Operation
not permitted
rm: cannot remove `//sys/devices/platform/bluetooth/power/state': Operation
not permitted
rm: cannot remove `//sys/devices/platform/bluetooth/uevent': Operation not
permitted
rm: cannot remove `//sys/devices/platform/power/wakeup': Operation not
permitted
rm: cannot remove `//sys/devices/platform/power/state': Operation not
permitted
rm: cannot remove `//sys/devices/platform/uevent': Operation not permitted
rm: cannot remove directory `//sys/fs': Operation not permitted
rm: cannot remove directory `//root': Device or resource busy
rm: cannot remove `//proc/mpt/ioc1/summary': Operation not permitted
rm: cannot remove `//proc/mpt/ioc1/info': Operation not permitted
rm: cannot remove `//proc/mpt/ioc0/summary': Operation not permitted
rm: cannot remove `//proc/mpt/ioc0/info': Operation not permitted
rm: cannot remove `//proc/mpt/version': Operation not permitted
rm: cannot remove `//proc/mpt/summary': Operation not permitted
rm: cannot remove `//proc/scsi/sg/version': Operation not permitted
[...]
rm: cannot remove `//proc/30971/limits': Permission denied
rm: cannot remove `//proc/30971/coredump_filter': Permission denied
rm: cannot remove `//proc/30971/io': Permission denied
rm: cannot remove directory `//dev/shm': Device or resource busy
rm: cannot remove `//dev/pts/2': Operation not permitted
rm: cannot remove `//dev/pts/1': Operation not permitted
rm: cannot remove `//dev/pts/0': Operation not permitted
rm: cannot remove directory `//boot/efi': Device or resource busy
rm: cannot remove directory `//home': Device or resource busy
rm: cannot remove directory `//net': Device or resource busy
rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/statd': Operation not
permitted
rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/portmap': Operation
not permitted
rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/nfs': Operation not
permitted
rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/mount': Operation not
permitted
rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/lockd': Operation not
permitted
rm: cannot remove directory `//var/crash': Device or resource busy
rm: cannot remove directory `//misc': Device or resource busy
make: *** [clean_install_dir] Error 1
------------

After that, I noticed that some commands ("ls", "who", "top" etc.) 
became invalid.
And the system was not able to reboot.

In above log, "make clean" seems to be going to delete "/proc/..." and
"/sys/...".


I tried once again in VMWare RHEL4.8(x86) system for confirmation.
"make clean" failed, and "/root" directory disappeared.
------------
[root@RHEL4-8 ltp-2010-02-01]# pwd
/home/LTP/ltp-2010-02-01
[root@RHEL4-8 ltp-2010-02-01]# ls -ltr /
total 170
drwxr-xr-x    2 root root  4096 Aug 13  2004 srv
drwxr-xr-x    2 root root  4096 Aug 13  2004 mnt
drwxr-xr-x    2 root root  4096 Aug 13  2004 initrd
drwxr-xr-x    2 root root  4096 Apr 10  2009 misc
drwxr-xr-x    2 root root  4096 Oct 21 17:08 selinux
drwxr-xr-x    4 root root  1024 Oct 21 17:11 boot
drwxr-xr-x   23 root root  4096 Oct 21 17:27 var
drwxr-xr-x    3 root root  4096 Oct 21 17:27 tftpboot
drwx------    2 root root 16384 Oct 22 02:02 lost+found
drwxr-xr-x    2 root root  4096 Oct 22 09:43 bin
drwxr-xr-x    2 root root 12288 Dec 18 12:44 sbin
drwxr-xr-x   15 root root  4096 Jan 12 19:27 usr
drwxr-xr-x   12 root root  4096 Jan 19 10:10 lib
drwxr-xr-x    3 root root  4096 Feb  1 10:22 opt
drwxr-xr-x    4 root root  4096 Feb  1 11:38 home
drwxr-xr-x    4 root root  4096 Feb  2 11:46 media
drwxr-xr-x   96 root root 12288 Feb  2 11:46 etc
drwxr-xr-x    8 root root  6520 Feb  2 11:46 dev
drwxr-x---   14 root root  4096 Feb  2 11:48 root
drwxrwxrwt   10 root root  4096 Feb  2 11:48 tmp
dr-xr-xr-x  109 root root     0 Feb  2  2010 proc
drwxr-xr-x    9 root root     0 Feb  2  2010 sys
[root@RHEL4-8 ltp-2010-02-01]# ls -ltr /opt/ltp
total 2056
drwxr-xr-x  3 root root    4096 Feb  1 10:22 share
drwxr-xr-x  2 root root    4096 Feb  1 10:22 testscripts
drwxr-xr-x  4 root root    4096 Feb  1 10:22 testcases
-rwxr-xr-x  1 root root    2603 Feb  1 10:24 ver_linux
-rwxr-xr-x  1 root root   10193 Feb  1 10:24 runltplite.sh
-rwxr-xr-x  1 root root   38054 Feb  1 10:24 runltp
-rwxr-xr-x  1 root root   22819 Feb  1 10:24 runalltests.sh
drwxr-xr-x  2 root root    4096 Feb  1 10:24 bin
-rw-r--r--  1 root root      13 Feb  1 10:24 Version
-rwxr-xr-x  1 root root    4645 Feb  1 10:24 IDcheck.sh
drwxr-xr-x  2 root root    4096 Feb  1 10:24 results
drwxr-xr-x  2 root root    4096 Feb  1 10:24 output
-rw-r--r--  1 root root 1977717 Feb  1 11:39 cvs0201-20100201.txt
drwxr-xr-x  2 root root    4096 Feb  1 17:20 runtest
[root@RHEL4-8 ltp-2010-02-01]# make clean
make -C "runtest" \
         -f "/home/LTP/ltp-2010-02-01/runtest/Makefile" clean
make[1]: Entering directory `/home/LTP/ltp-2010-02-01/runtest'
rm -f -f  *.o *.pyc
make[1]: Leaving directory `/home/LTP/ltp-2010-02-01/runtest'
make -C "testscripts" \
         -f "/home/LTP/ltp-2010-02-01/testscripts/Makefile" clean
[...]
make[1]: Entering directory `/home/LTP/ltp-2010-02-01/lib'
rm -f -f libltp.a *.o *.pyc
make[1]: Leaving directory `/home/LTP/ltp-2010-02-01/lib'
make -C include -f "/home/LTP/ltp-2010-02-01/include/Makefile" clean
make[1]: Entering directory `/home/LTP/ltp-2010-02-01/include'
rm -f -f  *.o *.pyc
make[1]: Leaving directory `/home/LTP/ltp-2010-02-01/include'
rm -f -Rf "/"
rm: cannot remove `//sys/module/parport_pc/sections/.strtab': Operation not
permitted
rm: cannot remove `//sys/module/parport_pc/sections/.symtab': Operation not
permitted
rm: cannot remove `//sys/module/parport_pc/sections/.module_sig': Operation
not permitted
rm: cannot remove `//sys/module/parport_pc/sections/.bss': Operation not
permitted
rm: cannot remove
`//sys/module/parport_pc/sections/.gnu.linkonce.this_module': Operation not
permitted
[...]
rm: cannot remove `//sys/block/sda/sda1/start': Operation not permitted
rm: cannot remove `//sys/block/sda/sda1/dev': Operation not permitted
rm: `//sys/block/sda/device' changed dev/ino: Operation not permitted
make: *** [clean_install_dir] Error 1
[root@RHEL4-8 ltp-2010-02-01]# echo $?
2
[root@RHEL4-8 ltp-2010-02-01]# ls -ltr /opt/ltp
total 2056
drwxr-xr-x  3 root root    4096 Feb  1 10:22 share
drwxr-xr-x  2 root root    4096 Feb  1 10:22 testscripts
drwxr-xr-x  4 root root    4096 Feb  1 10:22 testcases
-rwxr-xr-x  1 root root    2603 Feb  1 10:24 ver_linux
-rwxr-xr-x  1 root root   10193 Feb  1 10:24 runltplite.sh
-rwxr-xr-x  1 root root   38054 Feb  1 10:24 runltp
-rwxr-xr-x  1 root root   22819 Feb  1 10:24 runalltests.sh
drwxr-xr-x  2 root root    4096 Feb  1 10:24 bin
-rw-r--r--  1 root root      13 Feb  1 10:24 Version
-rwxr-xr-x  1 root root    4645 Feb  1 10:24 IDcheck.sh
drwxr-xr-x  2 root root    4096 Feb  1 10:24 results
drwxr-xr-x  2 root root    4096 Feb  1 10:24 output
-rw-r--r--  1 root root 1977717 Feb  1 11:39 cvs0201-20100201.txt
drwxr-xr-x  2 root root    4096 Feb  1 17:20 runtest
[root@RHEL4-8 ltp-2010-02-01]# ls -ltr /
total 154
drwxr-xr-x    2 root root  4096 Aug 13  2004 srv
drwxr-xr-x    2 root root  4096 Aug 13  2004 mnt
drwxr-xr-x    2 root root  4096 Aug 13  2004 initrd
drwxr-xr-x    2 root root  4096 Oct 21 17:08 selinux
drwxr-xr-x    4 root root  1024 Oct 21 17:11 boot
drwxr-xr-x   23 root root  4096 Oct 21 17:27 var
drwxr-xr-x    3 root root  4096 Oct 21 17:27 tftpboot
drwx------    2 root root 16384 Oct 22 02:02 lost+found
drwxr-xr-x    2 root root  4096 Oct 22 09:43 bin
drwxr-xr-x    2 root root 12288 Dec 18 12:44 sbin
drwxr-xr-x   15 root root  4096 Jan 12 19:27 usr
drwxr-xr-x   12 root root  4096 Jan 19 10:10 lib
drwxr-xr-x    3 root root  4096 Feb  1 10:22 opt
drwxr-xr-x    4 root root  4096 Feb  1 11:38 home
drwxr-xr-x    4 root root  4096 Feb  2 11:46 media
drwxr-xr-x   96 root root 12288 Feb  2 11:46 etc
drwxr-xr-x    8 root root  6520 Feb  2 11:46 dev
drwxrwxrwt   10 root root  4096 Feb  2 11:48 tmp
dr-xr-xr-x  109 root root     0 Feb  2  2010 proc
drwxr-xr-x    9 root root     0 Feb  2  2010 sys
[root@RHEL4-8 ltp-2010-02-01]# uname -a
Linux RHEL4-8.localdomain 2.6.9-89.ELsmp #1 SMP Mon Apr 20 10:34:33 EDT 2009
i686 i686 i386 GNU/Linux
[root@RHEL4-8 ltp-2010-02-01]#
------------

"make clean" is going to delete a "/" directory obviously.




Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
