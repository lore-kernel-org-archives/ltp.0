Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1ND8E6-0003Ah-Vf
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 03:07:30 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1ND8Dz-0008BV-Ar
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 03:07:30 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Nov 2009 12:07:12 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 25 Nov 2009 12:07:12 +0900
Message-ID: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] mbind01 test failed with after ltp-2009-11-12.tar.gz
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

Following failure occurred in mbind01 when I execute "runltp" using 
ltp-2009-11-12.tar.gz.
Similer failure occured with several recent versions from
ltp-2009-11-17.tar.gz
to ltp-2009-11-24.tar.gz, too.

<error message>
-----------------------------
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case00) START
mbind01     1  TFAIL  :  (case00) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case01) START
mbind01     2  TFAIL  :  (case01) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case02) START
mbind01     3  TFAIL  :  (case02) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case03) START
mbind01     4  TFAIL  :  (case03) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case04) START
mbind01     5  TFAIL  :  (case04) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case05) START
mbind01     6  TFAIL  :  (case05) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case06) START
mbind01     7  TFAIL  :  (case06) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case07) START
mbind01     8  TFAIL  :  (case07) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case08) START
mbind01     9  TFAIL  :  (case08) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case09) START
mbind01    10  TFAIL  :  (case09) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case10) START
mbind01    11  TFAIL  :  (case10) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case00) START
mbind01    12  TFAIL  :  (case00) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case01) START
mbind01    13  TFAIL  :  (case01) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case02) START
mbind01    14  TFAIL  :  (case02) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case03) START
mbind01    15  TFAIL  :  (case03) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case04) START
mbind01    16  TFAIL  :  (case04) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case05) START
mbind01    17  TFAIL  :  (case05) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case06) START
mbind01    18  TFAIL  :  (case06) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case07) START
mbind01    19  TFAIL  :  (case07) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case08) START
mbind01    20  TFAIL  :  (case08) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case09) START
mbind01    21  TFAIL  :  (case09) END: errno=???(38): Function not
implemented
mbind01     0  TINFO  :  (case10) START
mbind01    22  TFAIL  :  (case10) END: errno=???(38): Function not
implemented
-----------------------------


On the other hand, with "ltp-full-20091031", it passed as following message
(My system not supports NUMA).

-----------------------------
mbind01     1  TCONF  :  NUMA support not provided.
-----------------------------


Therefore, this problem seems to be after 2009/11/04 revision, I think.


Following shows revision contribution contents.

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/mbin
d/mbind01.c?view=log

-----------------------------
Revision 1.7
Wed Nov 4 06:18:27 2009 UTC (2 weeks, 6 days ago) by yaberauneya 
Branch: MAIN 
Changes since 1.6: +1 -13 lines 
Diff to previous 1.6 
I was confused, and numaif.h is in fact a header under
testcases/kernel/syscalls/utils. As such:

1. The autoconf test for the header is removed.
2. An appropriate inclusion is added for numa.h in numaif.h
3. Remove overengineered code in get_mempolicy01.c because
linux_syscall_numbers.h handles the unhandled numa syscall numbers.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>


Revision 1.6
Wed Nov 4 04:59:44 2009 UTC (2 weeks, 6 days ago) by yaberauneya 
Branch: MAIN 
Changes since 1.5: +263 -281 lines 
Diff to previous 1.5 
1. Disable the test whenever the appropriate headers and syscalls don't
exist so this will compile on systems without numa and without.
2. Fix the indentation.
3. Use TFAIL | TERRNO instead of all of the ad-hoc (TFAIL ... TERRNO,
strerror(TERRNO)) logic.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
-----------------------------


According to the contribution of these revisions, it is written that 
"Disable the test whenever the appropriate headers and syscalls don't
exist.".
However, when I compare these revisions, the judgement sentence 
whether numa is supported or not is deleted, and the error output sentence
that numa is not supported is deleted.

Following shows the result of compare of "Revision 1.6 and Revision 1.5"
and "Revision 1.7 and Revision 1.6".

<Revision 1.6 and Revision 1.5>
-----------------------------
--- mbind01.c	2009/10/09 17:55:57	1.5
+++ mbind01.c	2009/11/04 04:59:44	1.6
@@ -1,50 +1,51 @@
.
@@ -55,10 +56,12 @@
.
@@ -66,70 +69,72 @@
.
-#if HAS_NUMA_H
 static struct test_case tcase[] = {
.
-#else
-static struct test_case tcase[] = { };
-#endif
.
@@ -261,82 +262,80 @@
.
 static int do_test(struct test_case *tc) {
-#if HAS_NUMA_H
.
-#else
-	return -1;
-#endif
.
@@ -346,47 +345,43 @@
.
-#if HAS_NUMA_H
.
@@ -394,45 +389,32 @@
.
 #else
+int main (void) {
 	tst_resm(TCONF, "NUMA support not provided.");
-#endif
-        cleanup();
 	tst_exit();
 }
+#endif
-----------------------------

<Revision 1.7 and Revision 1.6>
-----------------------------
--- mbind01.c	2009/11/04 04:59:44	1.6
+++ mbind01.c	2009/11/04 06:18:27	1.7
@@ -59,14 +59,11 @@
.
@@ -77,8 +74,6 @@
.
@@ -411,10 +406,3 @@
 	cleanup();
 	tst_exit();
 }
-
-#else
-int main (void) {
-	tst_resm(TCONF, "NUMA support not provided.");
-	tst_exit();
-}
-#endif
-----------------------------

I think that these revisions may contradict the above contribution.
(Please forgive me if my opinion was wrong.)


To revise this problem (error of "Function not implemented") like above 
contribution, it is necessary to judge numa supporting by using "#if
HAS_NUMA_H".
And it is necessary to end with " tst_resm(TCONF, "NUMA support not
provided.") "
when not support, I think.
It is the point same as 2009/10/31 version.


Following shows my revise draft.


============
--- mbind01.c.org	2009-11-24 18:17:27.000000000 +0900
+++ mbind01.c	2009-11-24 16:09:03.000000000 +0900
@@ -176,6 +176,7 @@
  *		      (only we can do is simulate 1-node NUMA)
  */
 
+#if HAS_NUMA_H
 static struct test_case tcase[] = {
 	{ /* case00 */
 		.policy	    = MPOL_DEFAULT,
@@ -246,6 +247,7 @@
 		.err	    = EFAULT,
 	},
 };
+#endif
 
 #define MEM_LENGTH	      (4 * 1024 * 1024)
 /*
@@ -365,6 +367,7 @@
 
 	setup();
 
+#if HAS_NUMA_H
 	int lc, i, ret;		 /* loop counter */
 
 	/* Check looping state if -i option given */
@@ -404,4 +407,9 @@
 	}
 	cleanup();
 	tst_exit();
+
+#else
+	tst_resm(TCONF, "NUMA support not provided.");
+#endif
+
 }
============


Can I get opinion that my revision is right or not?


Thank you--


-Tomonori Mitani



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
