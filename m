Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NMcXY-0004Sh-S7
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 07:18:48 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NMcXP-0003XY-KB
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 07:18:48 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Dec 2009 16:18:30 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 21 Dec 2009 16:18:30 +0900
Message-ID: <000301ca820d$cc428e20$64c7aa60$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] =?iso-2022-jp?b?Im5hbm9zbGVlcHswMhskQiFBGyhCMDR9IiB0ZXN0?=
	=?iso-2022-jp?b?Y2FzZSBmYWlsZWQ=?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

I found that "nanosleep{02〜04}" testcase failed like follow example.
----------
nanosleep02    1  TFAIL  :  child process exited abnormally
----------

In ${LTPROOT}/testcases/kernel/syscalls/nanosleep/nanosleep{02〜04}.c, 
WEXITSTATUS(status) is used to judge whether child process did exit 
normally.
But WEXITSTATUS macro is used only when WIFEXITED macro returned "true".
So, it cannot get the correct results and it terminated with the above
error. 

To solve this problem, I thought that we had better use WIFEXITED macro
instead of the WEXITSTATUS macro.
Here are patches to fix these problem:
============
--- nanosleep02.c	2009-11-02 22:57:17.000000000 +0900
+++ nanosleep02.c.new	2009-12-21 14:15:19.000000000 +0900
@@ -162,10 +162,10 @@
 
 		/* Wait for child to execute */
 		wait(&status);
-		if (WEXITSTATUS(status) == 0) {
+		if (WIFEXITED(status)) {
 			tst_resm(TPASS, "Functionality of nanosleep() "
 				 "is correct");
-		} else if (WEXITSTATUS(status) == 1) {
+		} else if (!WIFEXITED(status)) {
 			tst_resm(TFAIL, "child process exited abnormally");
 		}
 	}			/* End for TEST_LOOPING */

============

============
--- nanosleep03.c	2009-11-02 22:57:17.000000000 +0900
+++ nanosleep03.c.new	2009-12-21 15:03:52.000000000 +0900
@@ -143,10 +143,10 @@
 
 		/* Wait for child to execute */
 		wait(&status);
-		if (WEXITSTATUS(status) == 0) {
+		if (WIFEXITED(status)) {
 			tst_resm(TPASS, "nanosleep() fails, interrupted"
 				 " by signal, error:%d", EINTR);
-		} else if (WEXITSTATUS(status) == 1) {
+		} else if (!WIFEXITED(status)) {
 			tst_resm(TFAIL, "child process exited abnormally");
 		}
 	}			/* End for TEST_LOOPING */

============

============
--- nanosleep04.c	2009-11-02 22:57:17.000000000 +0900
+++ nanosleep04.c.new	2009-12-21 15:04:24.000000000 +0900
@@ -147,10 +147,10 @@
 
 		/* Wait for child to execute */
 		wait(&status);
-		if (WEXITSTATUS(status) == 0) {
+		if (WIFEXITED(status)) {
 			tst_resm(TPASS, "nanosleep() fails, invalid pause "
 				 "time, error:%d", EINVAL);
-		} else if (WEXITSTATUS(status) == 1) {
+		} else if (!WIFEXITED(status)) {
 			tst_resm(TFAIL, "child process exited abnormally");
 		}
 	}			/* End for TEST_LOOPING */
============



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
