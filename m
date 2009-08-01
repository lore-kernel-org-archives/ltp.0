Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MX7Xt-0003bV-3x
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2009 05:54:17 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MX7Xo-0007Lb-Ju
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2009 05:54:17 +0000
Received: by pxi28 with SMTP id 28so1325257pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 22:54:06 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 31 Jul 2009 22:54:06 -0700
Message-ID: <364299f40907312254v36646209j35c0dc79498b9568@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] export needed variables in test_dma_thread_diotest7.sh
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
To: LTP list <ltp-list@lists.sourceforge.net>

Several required tst_res(3) variables weren't being exported prior to
test execution, as noted in the following message:

gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ tail -n 15
/scratch/ltp-install4/output/output.test_dma_thread_diotest7.log
Reading file 99.
Reading file 100.

Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
export TCID=<test name>
export TST_TOTAL=<Total Number of Tests >
export TST_COUNT=<Test case number>

(null)      1  PASS  :  Test Passed
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=153 termination_type=exited termination_id=0 corefile=no
cutime=596 cstime=4341
<<<test_end>>>

This fixes that.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: ./testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh,v
retrieving revision 1.3
diff -u -r1.3 test_dma_thread_diotest7.sh
--- ./testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh 18 Apr
2009 18:53:21 -0000      1.3
+++ ./testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh 1 Aug
2009 05:51:55 -0000
@@ -20,6 +20,10 @@
 ##
        ##
 ################################################################################

+export TCID=dma_thread_diotest7
+export TST_TOTAL=3
+export TST_COUNT=3
+
 tst_resm TINFO "Generating Test Files"
 ./dma_thread_diotest7

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
