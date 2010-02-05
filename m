Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NdHfJ-0002fi-4y
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 06:27:41 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NdHfH-0006X1-OR
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 06:27:41 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.6])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 74B2F239A0B
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Feb 2010 06:27:30 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 0774E114B83A
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Feb 2010 06:27:29 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Feb 2010 15:27:28 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 5 Feb 2010 15:27:27 +0900
Message-ID: <000701caa62c$4971b140$dc5513c0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "stime01" problem
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

I noticed that "stime01" test let system-clock be faster than right time.

"stime01.c" is going to set system-clock by calling "stime()" function
with "new_time" variable.
It gets "curr_time" by "time()" function, and sets "curr_time + 10sec" 
in "new_time".
But after the test, It doesn't restore system-clock.

Therefore, system-clock is set faster than right time about 10 seconds
after "stime01" test.
If this test is repeated many times, the system-clock advances for the 
number of test times.
And, if system is rebooted, hardware-clock will be wrong.

How about following patch? 
============
--- stime01.c.org       2009-03-23 22:36:07.000000000 +0900
+++ stime01.c   2010-02-05 14:02:59.000000000 +0900
@@ -70,6 +70,7 @@
 #include <sys/types.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <sys/time.h>
 #include <time.h>
 #include <string.h>
 #include <sys/stat.h>
@@ -83,6 +84,7 @@
 char *TCID = "stime01";                /* Test program identifier.    */
 int TST_TOTAL = 1;             /* Total number of test cases. */
 extern int Tst_count;          /* Test Case counter for tst_* routines */
+struct timeval first_tv;       /* system's current time in micro-seconds */
 time_t curr_time;              /* system's current time in seconds */
 time_t new_time;               /* system's new time */
 time_t tloc;                   /* argument var. for time() */
@@ -193,6 +195,11 @@

        /* Get the system's new time */
        new_time = curr_time + INCR_TIME;
+
+       /* Get the current time in microsecond */
+       if (gettimeofday(&first_tv, NULL) != 0)
+               tst_brkm(TBROK, cleanup,
+                       "gettimeofday() failed to get current time,
errno=%d", errno);
 }                              /* End setup() */

 /*
@@ -202,6 +209,10 @@
  */
 void cleanup()
 {
+       /* restore current time */
+       if (settimeofday(&first_tv, NULL) != 0)
+               tst_brkm(TBROK, cleanup,
+                       "settimeofday() failed to restore current time,
errno=%d", errno);
        /*
         * print timing stats if that option was specified.
         * print errno log if that option was specified.
============

We should consider that "test time" must be added in the "current time".
But the test time is so short that we can ignore it.
I repeated "for" block of stime() and time() 10,000 times, but it 
needed less than 1 second.


Thank you--


-Tomonori Mitani



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
