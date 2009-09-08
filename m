Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1MkwmS-0008Uv-Qn
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 09:14:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MkwmK-0003LX-KN
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 09:14:28 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 8A84F170141
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Sep 2009 17:14:01 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n889DsKd023467
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Sep 2009 17:13:54 +0800
Received: from localhost.localdomain (unknown [10.167.141.170])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 8D719D41E4
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Sep 2009 17:14:25 +0800 (CST)
Message-ID: <4AA62094.7060505@cn.fujitsu.com>
Date: Tue, 08 Sep 2009 17:15:00 +0800
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

When running the ltp tool by "./runltp -f controllers",
I found "while" loop cannot stop in following files of
cpuctl test.

File list:
cpuctl_def_task01.c
cpuctl_def_task02.c
cpuctl_def_task03.c
cpuctl_def_task04.c
cpuctl_test01.c
cpuctl_test02.c
cpuctl_test03.c
cpuctl_test04.c

Key code:
timer_expired=0;
while(!timer_expired)
	f=sqrt(f*f);

Reason:
During the compilation of these files, gcc's O2 mechanism
  causes the change of variable "timer_expired" to be omitted,
hence the loop, "while(!timer_expired) f=sqrt(f*f);" cannot
get out from itself.

Change the type of "timer_expired" from "int" to "volatile int"
to fix this bug.

By the way, it is necessary to modify the file,
ltp-full-xxxxxxxx/testcases/kernel/controllers/libcontrollers/
libcontrollers.h for compilation.


Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>
---
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index 00a25bc..1fb398a 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -82,7 +82,7 @@ extern void cleanup()
         kill(scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
         tst_exit();             /* Report exit status*/
  }
-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char *argv[])
  {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 1bfa187..56ddacc 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -79,7 +79,7 @@ cleanup()
         tst_exit();             /* Report exit status*/
  }

-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char *argv[])
  {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index e4ce3ad..4f3ddc1 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -79,7 +79,7 @@ cleanup()
         tst_exit();               /* Report exit status*/
  }

-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char *argv[])
  {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 15e2b5f..7f184c8 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -78,7 +78,7 @@ cleanup()
         tst_exit();               /* Report exit status*/
  }

-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char *argv[])
  {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index ab0a4c9..7d7cc48 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -80,7 +80,7 @@ cleanup()
         kill (scriptpid, SIGUSR1);/* Inform the shell to do cleanup*/
         tst_exit ();            /* Report exit status*/
  }
-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char* argv[])
  {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
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
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index c4b9978..c21b69c 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -79,7 +79,7 @@ cleanup()
         tst_exit ();              /* Report exit status*/
  }

-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char* argv[])
  {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c 
b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index b0a2329..ed00b0d 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -79,7 +79,7 @@ cleanup()
         tst_exit ();              /* Report exit status*/
  }

-int timer_expired = 0;
+volatile int timer_expired = 0;

  int main(int argc, char* argv[])
  {
diff --git 
a/testcases/kernel/controllers/libcontrollers/libcontrollers.h 
b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
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
