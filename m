Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NIssr-0007it-EZ
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 23:57:21 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NIssj-0001U3-Gs
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 23:57:21 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Dec 2009 08:57:02 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 11 Dec 2009 08:57:01 +0900
Message-ID: <000001ca79f4$7869a110$693ce330$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "libevent01" test failure with ltp-2009-12-10 cvs
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

I got following message when I ran test of "libevent01" with 
ltp-2009-12-10 cvs.

------------
sh: run_libevent.sh: command not found
------------

This occured because "run_libevent.sh" was not installed under the 
"/opt/ltp" directory, I think.

Certainly, this test successed when I copied 
"${LTPROOT}/testcases/kernel/syscalls/libevent/run_libevent.sh" file 
to the "/opt/ltp/testcases/bin" directory.

So, I want to suggest the following revision:

1. Install "run_libevent.sh" to under the "/opt/ltp/testcases/bin" 
   directory by default.
  (I don't know how to revise Makefile etc.)

2. Apply the following patch to "run_libevent.sh".

============
--- run_libevent.sh	2009-11-20 04:08:36.000000000 +0900
+++ run_libevent.sh.new	2009-12-10 16:44:02.000000000 +0900
@@ -31,7 +31,7 @@
 	tst_resm TCONF "You need to be root to run these tests"
 	TST_EXIT=0
 else
-	"$LTPROOT/testcases/bin/tests/test-libevent.sh"
+	"$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
 	TST_EXIT=$?
 fi
 tst_cleanup
============


Regards--

-Tomonori MItani



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
