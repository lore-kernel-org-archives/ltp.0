Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NUI3W-0002pW-7x
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 11:03:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUI3U-0008Ln-7T
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 11:03:30 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 00E7F17012B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Jan 2010 19:03:18 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o0BB2vGJ015150
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 19:02:57 +0800
Received: from [10.167.141.106] (unknown [10.167.141.106])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id DAEDFD46DB
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Jan 2010 19:04:12 +0800 (CST)
Message-ID: <4B4B0575.1090501@cn.fujitsu.com>
Date: Mon, 11 Jan 2010 19:03:17 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuset_syscall_test: delete '0x' from hex string
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
To: ltp-list <ltp-list@lists.sourceforge.net>

By the latest ltp version, the following fail message outputted on my x86_64 box.
------------
TEST 5: CPUSET CONTROLLER TESTING
TEST STARTED: Please avoid using system while this test executes
...
cpuset05    8  TFAIL  :  Result(/proc/<pid>/status) = "", expect = "0")
cpuset05    9  TFAIL  :  Result(/proc/<pid>/status) = "", expect = "1")
cpuset05   10  TFAIL  :  Result(/proc/<pid>/status) = "", expect = "default")
------------

The reason is:
1, '0x' wasn't deleted from a hex string's head.
   e.g. 7f343c900000 is expected ,but 0x7f343c900000 outputted.
2, a wrong '\b' was used in a grep command.

This patch fix the upper problem. Now the message is:
------------
cpuset05    7  TPASS  :  Cpuset vs systemcall test succeeded.
cpuset05    8  TPASS  :  Cpuset vs systemcall test succeeded.
cpuset05    9  TPASS  :  Cpuset vs systemcall test succeeded.
cpuset05   10  TPASS  :  Cpuset vs systemcall test succeeded.
------------

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
diff -urpN ltp-full-20091231.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh ltp-full-20091231/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
--- ltp-full-20091231.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh	2009-06-23 10:09:11.000000000 -0400
+++ ltp-full-20091231/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh	2010-01-11 18:42:59.000000000 -0500
@@ -178,7 +178,8 @@ test7()
 {
 	do_syscall_test 0 0 --mbind=1 0 || return 1
 	memory_addr="$(cat $TEST_OUTPUT)"
-	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
+	memory_addr=${memory_addr##*0x}
+	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "0" || return 1
@@ -193,7 +194,8 @@ test8()
 {
 	do_syscall_test 0 0-1 --mbind=1 0 || return 1
 	memory_addr="$(cat $TEST_OUTPUT)"
-	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
+	memory_addr=${memory_addr##*0x}
+	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "0"
@@ -208,7 +210,8 @@ test9()
 {
 	do_syscall_test 0 0-1 --mbind=6 0 || return 1
 	memory_addr="$(cat $TEST_OUTPUT)"
-	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
+	memory_addr=${memory_addr##*0x}
+	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "1"
@@ -223,7 +226,8 @@ test10()
 {
 	do_syscall_test 0 0 --mbind=6 1 || return 1
 	memory_addr="$(cat $TEST_OUTPUT)"
-	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
+	memory_addr=${memory_addr##*0x}
+	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "default"

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
