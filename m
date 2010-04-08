Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NznOj-0007pN-5C
	for ltp-list@lists.sourceforge.net; Thu, 08 Apr 2010 08:47:37 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NznOf-0004Qj-9o
	for ltp-list@lists.sourceforge.net; Thu, 08 Apr 2010 08:47:34 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.28])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id E00F1239C66
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Apr 2010 08:47:26 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 6BC981D787D
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Apr 2010 08:47:26 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Apr 2010 17:47:23 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 8 Apr 2010 17:47:23 +0900
Message-ID: <000301cad6f8$1b9b0c60$52d12520$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] [PATCH] fix "eventfd01" test
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


I tried "eventfd01" test in my system.
This test failed with TWARN (return code:4) :

------------
  eventfd01    1  TCONF  :  2.6.22 or greater kernel required
  eventfd01    2  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    3  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    4  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    5  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    6  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    7  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    8  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    9  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01   10  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01   11  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01   12  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01   13  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01   14  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01   15  TCONF  :  Remaining cases not appropriate for
configuration
  eventfd01    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal
attempted
------------

My system's kernel level is 2.6.18-164.el5
Therefore this test rejected:

------< eventfd01.c - main() >------
        if (tst_kvercmp(2, 6, 22) < 0)
                tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
required");
------------

But, this "tst_brkm()" called "cleanup()".
"tst_rmdir()" is called in "cleanup()", and this checked "TESTDIR":

------< tst_tmpdir.c - tst_rmdir() >------
   /*
    * Check that TESTDIR is not NULL.
    */
   if ( TESTDIR == NULL ) {
      tst_resm(TWARN, "%s: TESTDIR was NULL; no removal attempted",
               FN_NAME);
      return;
   }
------------

This TWARN caused FAIL.
"TESTDIR" is NULL because the test didn't start.

I think that "cleanup()" doesn't have to be called in this case.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c     2010-04-01
15:23:10.000000000 +0900
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c     2010-04-08
17:16:35.000000000 +0900
@@ -728,8 +728,10 @@
        /* capture signals */
        tst_sig(FORK, DEF_HANDLER, cleanup);

-       if (tst_kvercmp(2, 6, 22) < 0)
-               tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
required");
+       if (tst_kvercmp(2, 6, 22) < 0) {
+               tst_brkm(TCONF, NULL, "2.6.22 or greater kernel required");
+               tst_exit();
+       }

        /* Create a temporary directory & chdir there */
        tst_tmpdir();
============


Thank you--

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
