Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NpI4m-0005Yq-NA
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 09:19:36 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpI4k-0005Iu-JS
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 09:19:36 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 0E258211251
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 09:19:23 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 60EB03DD02B
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 09:19:22 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 18:19:20 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 10 Mar 2010 18:19:20 +0900
Message-ID: <000a01cac032$c4126c80$4c374580$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "check_for_unshare.c" build failed
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


I tried to build LTP modules from following git:

   "Fix make filed,, reported by Shi Weihua <shiwh@cn.fujitsu.com>"
   (ltp-dev-c962f51674b971496e14ac4be0cc75da98b75fca.tar.gz)

But I failed to build "check_for_unshare.c" in RHEL5.4 system 
(2.6.18-164.el5).

------------
<...>
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include
-I../../../include   -L../../../lib  check_for_unshare.c   -o
check_for_unshare
/tmp/ccWzyOQO.o: In function `main':
/home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
are.c:40: undefined reference to `dlopen'
/home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
are.c:46: undefined reference to `dlerror'
/home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
are.c:47: undefined reference to `dlsym'
/home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
are.c:48: undefined reference to `dlerror'
/home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
are.c:53: undefined reference to `dlclose'
/home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
are.c:42: undefined reference to `dlerror'
collect2: ld returned 1 exit status
make[3]: *** [check_for_unshare] Error 1
<...>
------------


I think that "-ldl" is needed in options.
I tried to build using "-ldl" option and succeeded.

------------
[root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# gcc -g -O2 -g -O2 -ldl
-fno-strict-aliasi
ng -pipe -Wall  -I../../../include -I../../../include   -L../../../lib
check_for_unshare.
c   -o check_for_unshare
[root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# echo $?
0
[root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# ll
total 60
-rw-rw-r-- 1 root root  1396 Mar 10 01:23 Makefile
-rw-rw-r-- 1 root root  1386 Mar 10 01:23 Makefile.inc
-rw-rw-r-- 1 root root  3286 Mar 10 01:23 README
-rw-rw-r-- 1 root root  1451 Mar 10 01:23 TEST_PLAN.txt
-rwxr-xr-x 1 root root 10805 Mar 10 15:18 check_for_unshare
-rw-rw-r-- 1 root root  1634 Mar 10 01:23 check_for_unshare.c
-rwxrwxr-x 1 root root  1712 Mar 10 01:23 container_test.sh
drwxrwxr-x 2 root root  4096 Mar 10 10:42 libclone
drwxrwxr-x 2 root root  4096 Mar 10 01:23 mqns
drwxrwxr-x 2 root root  4096 Mar 10 01:23 netns
drwxrwxr-x 2 root root  4096 Mar 10 01:23 pidns
drwxrwxr-x 2 root root  4096 Mar 10 01:23 sysvipc
drwxrwxr-x 2 root root  4096 Mar 10 01:23 utsname
[root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]#
------------


How about changing Makefile as follows?

============
--- ./testcases/kernel/containers/Makefile      2010-03-10
01:23:25.000000000 +0900
+++ ./testcases/kernel/containers/Makefile.new  2010-03-10
15:27:20.000000000 +0900
@@ -28,6 +28,8 @@

 LIB                    := -ld

+CFLAGS                  += -ldl
+
 INSTALL_TARGETS                := *.sh

 $(LIBDIR):
============


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
