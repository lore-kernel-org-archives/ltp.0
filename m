Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1Nf99j-00031d-Vc
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 09:46:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nf99i-0005Pg-96
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 09:46:47 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 1BECE1700BD
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Feb 2010 17:46:35 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o1A9jnuB024555
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Feb 2010 17:45:49 +0800
Received: from [10.167.141.106] (unknown [10.167.141.106])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 22399D47CB
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Feb 2010 17:48:07 +0800 (CST)
Message-ID: <4B728073.3070209@cn.fujitsu.com>
Date: Wed, 10 Feb 2010 17:46:27 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] timers: support clockid of
	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: ltp-list <ltp-list@lists.sourceforge.net>

mainline commit da15cfdae03351c689736f8d142618592e3cebc3
 (subject: time: Introduce CLOCK_REALTIME_COARSE)
added two clocks (CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE) in
2.6.32-rc1, but it has not been responded in ltp. then, the following
error message occured.
-----
clock_gettime03    3  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
clock_gettime03    4  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
timer_create04    1  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
timer_create04    2  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
-----

Following patch fixed this bug. and, passed on 2.6.32-rc1, 2.6.33-rc6, 2.6.23.1-42.fc8.

Signed-off-by: Shi Weihua<shiwh@cn.fujitsu.com>
---
--- testcases/kernel/timers/include/common_timers.h.orig	2010-02-10 16:44:56.000000000 -0500
+++ testcases/kernel/timers/include/common_timers.h	2010-02-10 17:33:25.000000000 -0500
@@ -28,12 +28,20 @@
 #ifndef CLOCK_MONOTONIC_RAW
 #define CLOCK_MONOTONIC_RAW 4
 #endif
+#ifndef CLOCK_REALTIME_COARSE
+#define CLOCK_REALTIME_COARSE 5
+#endif
+#ifndef CLOCK_MONOTONIC_COARSE
+#define CLOCK_MONOTONIC_COARSE 6
+#endif
 clock_t clock_list[] = {
 	CLOCK_REALTIME,
 	CLOCK_MONOTONIC,
 	CLOCK_PROCESS_CPUTIME_ID,
 	CLOCK_THREAD_CPUTIME_ID,
 	CLOCK_MONOTONIC_RAW,
+	CLOCK_REALTIME_COARSE,
+	CLOCK_MONOTONIC_COARSE,
 };
 #define MAX_CLOCKS (sizeof(clock_list) / sizeof(*clock_list))
 
@@ -50,6 +58,10 @@ const char *get_clock_str(const int cloc
 		return "CLOCK_THREAD_CPUTIME_ID";
 	case CLOCK_MONOTONIC_RAW:
 		return "CLOCK_MONOTONIC_RAW";
+	case CLOCK_REALTIME_COARSE:
+		return "CLOCK_REALTIME_COARSE";
+	case CLOCK_MONOTONIC_COARSE:
+		return "CLOCK_MONOTONIC_COARSE";
 	default:
 		return "CLOCK_!?!?!?";
 	}

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
