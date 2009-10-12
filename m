Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1MxHNl-0007fM-3z
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 09:39:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxHNd-0000Ge-3F
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 09:39:57 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 0D5F2170080
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 17:39:40 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n9C9d6N2019903
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Oct 2009 17:39:07 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 9E76C290117
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 17:49:34 +0800 (CST)
Message-ID: <4AD2F942.1090004@cn.fujitsu.com>
Date: Mon, 12 Oct 2009 17:39:14 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ppoll01: Fix to set the signal handler of SIGINT
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

The test case ppoll01 does not register the signal handler
of SIGINT, so the program will be terminated by SIGINT
from child process.

Then, the rest cases will not be tested.

This patch fixed the problem.

Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>
---
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index f76d61f..585297c 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -124,9 +124,17 @@ extern void cleanup() {
 /*              On success - returns 0.                                       */
 /*                                                                            */
 /******************************************************************************/
+/*
+ * sighandler()
+ */
+void sighandler(int sig)
+{
+       return;
+}
 void setup() {
         /* Capture signals if any */
-        /* Create temporary directories */
+       signal(SIGINT, sighandler);
+       /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();
 }
@@ -404,16 +412,6 @@ TEST_END:
 }
 
 
-/*
- * sighandler()
- */
-void sighandler(int sig)
-{
-        if (sig == SIGINT)
-                return;
-        // NOTREACHED
-        return;
-}
 
 
 /*

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
