Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NfqIC-0004ak-C0
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 07:50:24 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NfqIA-0002yn-0k
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 07:50:23 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.6])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 3EF36211019
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Feb 2010 07:50:09 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 8B2903DD01A
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Feb 2010 07:50:08 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 16:50:06 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 12 Feb 2010 16:50:06 +0900
Message-ID: <000001caabb7$fe895b60$fb9c1220$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "pidns17" problem in "2010-02-11" cvs
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

I tried to test with "2010-02-11" cvs in RHEL5.4 system.
But the test brings termination of connection.

I examined the phenomenon and discovered that "pidns17" test made 
accident and sshd stopped after the test.


I had some problems.

1. I think that "tst_exit()" must be added last of "cleanup()"
   function.
============
--- ./testcases/kernel/containers/pidns/pidns17.c       2009-12-07
05:55:16.000000000 +0900
+++ ./testcases/kernel/containers/pidns/pidns17.c.new   2010-02-12
16:26:31.000000000 +0900
@@ -104,7 +104,6 @@

        /* cleanup and exit */
        CLEANUP();
-       tst_exit();
 }

 /***********************************************************************
@@ -136,7 +135,6 @@

        /* cleanup and exit */
        CLEANUP();
-       tst_exit();
 }      /* End main */

 /*
@@ -147,4 +145,5 @@
 {
        /* Clean the test testcase as LTP wants*/
        TEST_CLEANUP;
+       tst_exit();
 }
============

After revision, connection termination didn't occur.


2. I cannot understand the purpose that "kill()" function whose 
   first parameter is "-1" is called.
------------
        if (kill(-1, SIGUSR1) == -1) {
                tst_resm(TBROK | TERRNO, "cinit: kill(-1, SIGUSR1) failed");
                CLEANUP();
        }
------------

If kill()'s first option is "-1", "man kill" says that
"All processes with pid larger than 1 will be signaled."

Therefore, not only the "sshd" but also the other processes were 
affected, I think.


I'm glad if I could get some opinions.


Thank you--


-Tomonori Mitani




------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
