Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PGR7N-0002Lj-Mt
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 06:58:45 +0000
Received: from out21.sjc.mx.trendmicro.com ([216.99.131.78])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGR7L-0001CX-Uh
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 06:58:45 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.77])
	by out21.sjc.mx.trendmicro.com (Postfix) with ESMTP id E31E3980415
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 06:58:37 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 3C3CD114B83C
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 06:58:36 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 15:58:34 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 11 Nov 2010 15:58:34 +0900
Message-ID: <000001cb816d$dbdec820$939c5860$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About "realtime" build failure
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

Build error occured with recent git "ltp-a997c94.tar.gz".
This failure was caused by "realtime" as follows:
------------
[root@RHEL48-LTP-x86 LTP]# less gitMMDD-makeYYYYMMDD.txt
[...]
make[1]: Entering directory `/home/LTP/ltp-a997c94/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o cloner.o cloner.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o dataascii.o dataascii.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o databin.o databin.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o datapid.o datapid.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o file_lock.o file_lock.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o forker.o forker.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o get_high_address.o get_high_address.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o get_path.o get_path.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o libtestsuite.o libtestsuite.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../include
-I../include  -
c -o open_flags.o open_flags.c
...skipping...
p-a997c94/testcases/realtime/include -I../../../../include
-I../../../../include
   -L/home/LTP/ltp-a997c94/testcases/realtime/lib -L../../../../lib
async_handl
er.c   -lrealtime -lpthread -lrt -lm -o async_handler
In file included from async_handler.c:42:
/home/LTP/ltp-a997c94/testcases/realtime/include/librttest.h: In function
`atomi
c_add':
/home/LTP/ltp-a997c94/testcases/realtime/include/librttest.h:117: warning:
impli
cit declaration of function `__sync_add_and_fetch'
/home/LTP/ltp-a997c94/testcases/realtime/lib/librealtime.a(librttest.o)(.tex
t+0x
1a7): In function `create_thread':
/home/LTP/ltp-a997c94/testcases/realtime/lib/../include/librttest.h:117:
undefin
ed reference to `__sync_add_and_fetch'
collect2: ld returned 1 exit status
make[4]: *** [async_handler] Error 1
make[4]: Leaving directory
`/home/LTP/ltp-a997c94/testcases/realtime/func/async_
handler'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/LTP/ltp-a997c94/testcases/realtime/func'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-a997c94/testcases/realtime'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-a997c94/testcases'
make: *** [testcases-all] Error 2
------------

I confirmed that above error is dissolved by following revision:
------------
[root@RHEL48-LTP-x86 ltp-dev-20101111]# diff -u testcases/Makefile.org
testcases/Makefile
--- testcases/Makefile.org      2010-11-11 14:20:07.000000000 +0900
+++ testcases/Makefile  2010-11-11 14:21:25.000000000 +0900
@@ -37,7 +37,7 @@
 # original list of disabled items...
 # XXX (garrcoop): kdump was in this list.
 # XXX (garrcoop): open_hpi_testsuite was in this list.
-ifeq ($(UCLINUX),1)
+ifneq ($(UCLINUX),1)
 FILTER_OUT_DIRS                += realtime
 endif

------------

Is realtime necessary? 
Please revise it if there is not problem.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
