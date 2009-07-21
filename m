Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MT56x-00042E-Lh
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 02:29:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT56q-0000ek-8o
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 02:29:47 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 2A976170160
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 10:50:56 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n6L32qd6016805
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 11:02:52 +0800
Received: from [127.0.0.1] (unknown [10.167.141.76])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id E0D44D402F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 10:30:42 +0800 (CST)
Message-ID: <4A6527B6.7070602@cn.fujitsu.com>
Date: Tue, 21 Jul 2009 10:28:06 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix to set the signal handler of SIGINT in
	mq_timedreceive01
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

The test case mq_timedreceive01 does not register the signal
handler of SIGINT, so the problam will be terminated by SIGINT
from child process.

This patch fixed the problem.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index dadc38d..beeb298 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -106,6 +106,14 @@ extern void cleanup() {
         tst_exit();
 }
 
+/*
+ * sighandler()
+ */
+void sighandler(int sig)
+{
+        return;
+}
+
 /* Local  Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -126,6 +134,7 @@ extern void cleanup() {
 /******************************************************************************/
 void setup() {
         /* Capture signals if any */
+        signal(SIGINT, sighandler);
         /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();
@@ -432,17 +441,6 @@ EXIT:
         return result;
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
-
 
 
 /*





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
