Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <s.ikarashi@jp.fujitsu.com>) id 1MjOGp-0005D8-D3
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2009 02:11:23 +0000
Received: from fgwmail9.fujitsu.co.jp ([192.51.44.39])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MjOGh-00040e-RR
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2009 02:11:23 +0000
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n841ZEgr032489 for <ltp-list@lists.sourceforge.net> (envelope-from
	s.ikarashi@jp.fujitsu.com); Fri, 4 Sep 2009 10:35:14 +0900
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n841ZCeo006021 for <ltp-list@lists.sourceforge.net> (envelope-from
	s.ikarashi@jp.fujitsu.com); Fri, 4 Sep 2009 10:35:13 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C395045DE4E
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 10:35:12 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9FCBA45DE4F
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 10:35:12 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 89220E08001
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 10:35:12 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3970B1DB8040
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 10:35:12 +0900 (JST)
Received: from m106.css.fujitsu.com (m106 [127.0.0.1])
	by m106.s.css.fujitsu.com (Postfix) with ESMTP id 0CEC65B88DC
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 10:35:12 +0900 (JST)
Received: from dune.soft.fujitsu.com (dune.soft.fujitsu.com [10.124.100.185])
	by m106.s.css.fujitsu.com (Postfix) with ESMTP id A0C1B5B88C3
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2009 10:35:11 +0900 (JST)
Message-ID: <4AA06ECF.4040508@jp.fujitsu.com>
Date: Fri, 04 Sep 2009 10:35:11 +0900
From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030505090506070203060008"
Subject: [LTP] [PATCH] fix UNRESOLVED failures of pthread tests in
	open_posix_testsuite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030505090506070203060008
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

I report a couple of "UNRESOLVED" failures of open_posix_testsuite in ltp
and send a patch for them.

I got following failures while executing open_posix_testsuite.

> conformance/interfaces/pthread_setschedparam/5-1: execution: UNRESOLVED: Output: 
> [07:16:29]Test conformance/interfaces/pthread_setschedparam/5-1.c unresolved: got 22 (Invalid argument) on line 152 (Sem_post in signal handler 1)

> conformance/interfaces/pthread_detach/4-3: execution: UNRESOLVED: Output:
> *snip*
> [12:05:38]Test conformance/interfaces/pthread_detach/4-3.c unresolved: got 22 (Invalid argument) on line 157 (Sem_post in signal handler 1)

Both of them have wrong steps of its test preparation:
  1. register signal handlers (just do sem_post()) for SIGUSR1/SIGUSR2.
  2. block those signals
  3. prepare something (sem_init()) for these signal handlers
  4. send signals to itself from sub-threads.

They have a window of not-yet-prepared-for-signals
between step 1 and 2. I think above "UNRESOLVED" failures
(sem_post() before sem_init()) are the result of getting a
signal during this window.
I don't know who sent a signal to them but I guess
neighboring tests are suspects, because number of tests run
concurrently in open_posix_testsuite.

The fix shall be just delaying step 1 to between step 2 and 4,
so I wrote such a patch for both pthread_setschedparam and
pthread_detach. I have confirmed that this UNRESOLVED failure
disappeared with this patch applied.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>

Regards,


--------------030505090506070203060008
Content-Type: text/x-patch;
 name="opt_pthread.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opt_pthread.patch"

Index: ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c,v
retrieving revision 1.3
diff -u -r1.3 4-3.c
--- ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c	3 Jun 2005 16:31:46 -0000	1.3
+++ ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c	4 Sep 2009 00:51:35 -0000
@@ -258,16 +258,6 @@
 	/* Initialize thread attribute objects */
 	scenar_init();
 	
-	/* We need to register the signal handlers for the PROCESS */
-	sigemptyset (&sa.sa_mask);
-	sa.sa_flags = 0;
-	sa.sa_handler = sighdl1;
-	if ((ret = sigaction (SIGUSR1, &sa, NULL)))
-	{ UNRESOLVED(ret, "Unable to register signal handler1"); }
-	sa.sa_handler = sighdl2;
-	if ((ret = sigaction (SIGUSR2, &sa, NULL)))
-	{ UNRESOLVED(ret, "Unable to register signal handler2"); }
-
 	/* We prepare a signal set which includes SIGUSR1 and SIGUSR2 */
 	sigemptyset(&usersigs);
 	ret = sigaddset(&usersigs, SIGUSR1);
@@ -285,6 +275,16 @@
 	{ UNRESOLVED(errno, "Semsig2  init"); }
 	#endif
 
+	/* We need to register the signal handlers for the PROCESS */
+	sigemptyset (&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = sighdl1;
+	if ((ret = sigaction (SIGUSR1, &sa, NULL)))
+	{ UNRESOLVED(ret, "Unable to register signal handler1"); }
+	sa.sa_handler = sighdl2;
+	if ((ret = sigaction (SIGUSR2, &sa, NULL)))
+	{ UNRESOLVED(ret, "Unable to register signal handler2"); }
+
 	if ((ret = pthread_create(&th_work, NULL, test, NULL)))
 	{ UNRESOLVED(ret, "Worker thread creation failed"); }
 	
Index: ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c,v
retrieving revision 1.1
diff -u -r1.1 5-1.c
--- ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c	3 Jun 2005 16:32:47 -0000	1.1
+++ ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c	4 Sep 2009 00:51:35 -0000
@@ -224,23 +224,6 @@
 	/* Initialize output routine */
 	output_init();
 
-	/* We need to register the signal handlers for the PROCESS */
-	sigemptyset ( &sa.sa_mask );
-	sa.sa_flags = 0;
-	sa.sa_handler = sighdl1;
-
-	if ( ( ret = sigaction ( SIGUSR1, &sa, NULL ) ) )
-	{
-		UNRESOLVED( ret, "Unable to register signal handler1" );
-	}
-
-	sa.sa_handler = sighdl2;
-
-	if ( ( ret = sigaction ( SIGUSR2, &sa, NULL ) ) )
-	{
-		UNRESOLVED( ret, "Unable to register signal handler2" );
-	}
-
 	/* We prepare a signal set which includes SIGUSR1 and SIGUSR2 */
 	sigemptyset( &usersigs );
 
@@ -274,6 +257,23 @@
 
 #endif
 
+	/* We need to register the signal handlers for the PROCESS */
+	sigemptyset ( &sa.sa_mask );
+	sa.sa_flags = 0;
+	sa.sa_handler = sighdl1;
+
+	if ( ( ret = sigaction ( SIGUSR1, &sa, NULL ) ) )
+	{
+		UNRESOLVED( ret, "Unable to register signal handler1" );
+	}
+
+	sa.sa_handler = sighdl2;
+
+	if ( ( ret = sigaction ( SIGUSR2, &sa, NULL ) ) )
+	{
+		UNRESOLVED( ret, "Unable to register signal handler2" );
+	}
+
 	me = pthread_self();
 
 	if ( ( ret = pthread_create( &th_work, NULL, test, &me ) ) )

--------------030505090506070203060008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------030505090506070203060008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030505090506070203060008--

