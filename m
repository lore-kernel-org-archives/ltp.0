Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <wangyong2009@cn.fujitsu.com>) id 1MWM1j-0003bu-4P
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:09:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWM1Z-0007RY-L7
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:09:50 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id CD756170140
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 09:32:24 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n6U1X2eB023646
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 09:33:02 +0800
Received: from [127.0.0.1] (unknown [10.167.141.67])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id B485CD406F
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 09:34:05 +0800 (CST)
Message-ID: <4A70F86E.50608@cn.fujitsu.com>
Date: Thu, 30 Jul 2009 09:33:34 +0800
From: Wang Yong <wangyong2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]   [PATCH] Fix failure of the utimensat01 test
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
To: LTP <ltp-list@lists.sourceforge.net>

The error handling for "RW" opt of run_test brought about error results.
This patch fixed that.

Signed-off-by: WangYong <wangyong2009@cn.fujitsu.com>

diff -Nurp a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh	2009-07-28 16:23:39.000000000 +0800
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh	2009-07-28 17:32:26.000000000 +0800
@@ -260,22 +260,22 @@ echo "Testing read-only file, owned by s
 echo
 
 echo "***** Testing times==NULL case *****"
-run_test "" 400 "" "" SUCCESS y y
+run_test -W "" 400 "" "" SUCCESS y y
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
-run_test "" 400 "" "0 n 0 n" SUCCESS y y
+run_test -W "" 400 "" "0 n 0 n" SUCCESS y y
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
-run_test "" 400 "" "0 o 0 o" SUCCESS n n
+run_test -W "" 400 "" "0 o 0 o" SUCCESS n n
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
-run_test "" 400 "" "0 n 0 o" SUCCESS y n
+run_test -W "" 400 "" "0 n 0 o" SUCCESS y n
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
-run_test "" 400 "" "0 o 0 n" SUCCESS n y
+run_test -W "" 400 "" "0 o 0 n" SUCCESS n y
 
 echo "***** Testing times=={ x, y } case *****"
-run_test "" 400 "" "1 1 1 1" SUCCESS y y
+run_test -W "" 400 "" "1 1 1 1" SUCCESS y y
 
 echo "============================================================"
 
@@ -284,22 +284,22 @@ echo "Testing read-only file, not owned 
 echo
 
 echo "***** Testing times==NULL case *****"
-run_test root 400 "" "" EACCES
+run_test -RW root 400 "" "" EACCES
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
-run_test root 400 "" "0 n 0 n" EACCES
+run_test -RW root 400 "" "0 n 0 n" EACCES
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
-run_test root 400 "" "0 o 0 o" SUCCESS n n
+run_test -RW root 400 "" "0 o 0 o" SUCCESS n n
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
-run_test root 400 "" "0 n 0 o" EPERM
+run_test -RW root 400 "" "0 n 0 o" EPERM
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
-run_test root 400 "" "0 o 0 n" EPERM
+run_test -RW root 400 "" "0 o 0 n" EPERM
 
 echo "***** Testing times=={ x, y } case *****"
-run_test root 400 "" "1 1 1 1" EPERM
+run_test -RW root 400 "" "1 1 1 1" EPERM
 
 echo "============================================================"
 




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
