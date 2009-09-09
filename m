Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1MlIbv-0007CF-PQ
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 08:33:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MlIbe-0002LF-4P
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 08:32:55 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id AD0B217012F
	for <ltp-list@lists.sourceforge.net>;
	Wed,  9 Sep 2009 16:32:36 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n898WSGg020907
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 16:32:29 +0800
Received: from localhost.localdomain (unknown [10.167.141.170])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 49747D41FE
	for <ltp-list@lists.sourceforge.net>;
	Wed,  9 Sep 2009 16:33:07 +0800 (CST)
Message-ID: <4AA76861.8080501@cn.fujitsu.com>
Date: Wed, 09 Sep 2009 16:33:37 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuctl of controllers: fix the bug of while loop
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

Here is the right patch.
I'm sorry for my carelessness.

Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>
---
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index 00a25bc..1fb398a 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -82,7 +82,7 @@ extern void cleanup()
 	kill(scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
 	tst_exit();		/* Report exit status*/
 }
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 1bfa187..56ddacc 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -79,7 +79,7 @@ cleanup()
 	tst_exit();		/* Report exit status*/
 }
 
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index e4ce3ad..4f3ddc1 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -79,7 +79,7 @@ cleanup()
 	tst_exit();		  /* Report exit status*/
 }
 
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 15e2b5f..7f184c8 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -78,7 +78,7 @@ cleanup()
 	tst_exit();		  /* Report exit status*/
 }
 
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index ab0a4c9..7d7cc48 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -80,7 +80,7 @@ cleanup()
 	kill (scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
 	tst_exit ();		/* Report exit status*/
 }
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char* argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index 801716d..153a293 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -80,7 +80,7 @@ cleanup()
 }
 
 int migrate_task ();
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char* argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index c4b9978..c21b69c 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -79,7 +79,7 @@ cleanup()
 	tst_exit ();		  /* Report exit status*/
 }
 
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char* argv[])
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index b0a2329..ed00b0d 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -79,7 +79,7 @@ cleanup()
 	tst_exit ();		  /* Report exit status*/
 }
 
-int timer_expired = 0;
+volatile int timer_expired = 0;
 
 int main(int argc, char* argv[])
 {
diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
index 777ff67..e6ab6a0 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
@@ -48,7 +48,8 @@ char fullpath[PATH_MAX];
 char fullpath[1024]; /* Guess */
 #endif
 
-int FLAG, timer_expired;
+int FLAG;
+volatile int timer_expired;
 
 int retval;

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
