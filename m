Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1MQGib-0005cG-3P
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 08:17:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQGiW-0002iS-1t
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 08:17:01 +0000
Message-ID: <4A5AED18.2090201@cn.fujitsu.com>
Date: Mon, 13 Jul 2009 16:15:20 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] Fix "make clean"'s failure in case cpuset
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

In case cpuset, the file cpuset_syscall_test.o was not deleted after "make clean".
The following patch fixed this problem.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile	2009-06-23 10:18:17.000000000 -0400
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile	2009-07-13 12:24:01.000000000 -0400
@@ -8,7 +8,8 @@ all:cpuset_syscall_test
 cpuset_syscall_test: %: %.o $(LIBOBJECTS)
 
 clean:
-	rm -rf cpuset_syscall_test
+	rm -rf cpuset_syscall_test cpuset_syscall_test.o
+	rm -f $(LIBOBJECTS)
 
 install:
 	@set -e; \




------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
