Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peppe.cavallaro@st.com>) id 1N5i6P-0002MZ-5S
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 15:48:53 +0000
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127])
	by 29vjzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5i6E-0007An-Pb
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 15:48:48 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E23B194
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Nov 2009 15:48:31 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B353F15A0
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Nov 2009 15:48:31 +0000 (GMT)
Message-ID: <4AF1A24C.8020503@st.com>
Date: Wed, 04 Nov 2009 16:48:28 +0100
From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010607010704040804000802"
Subject: [LTP] [PATCH] compiling realtime tests for SH.
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
--------------010607010704040804000802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hoping somebody will find useful it.

Regards
Peppe

--------------010607010704040804000802
Content-Type: text/x-patch;
 name="ltp-full-20090731-sh_RT.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ltp-full-20090731-sh_RT.patch"

[PATCH] compiling realtime tests for SH.

This patch adds the atomi_add() define for __sh__;
ltp realtime tests seem to show that it works.

The patch also moves the tsc macros form the librttest.h
to another header file (named libtsc.h).

Without this I got the following error and no tests were built.

 [snip]
 In file included from librttest.c:43:
 ../include/librttest.h:127:2: error: #error 
 ../include/librttest.h:169:2: error: #error 
 In file included from librttest.c:43:
 ../include/librttest.h: In function ���atomic_add���:
 [snip]

The tsc macros header is only included in the following tests
(thus where necessary):

 o async_handler_tsc.c
 o preempt_timing.c
 o rdtsc-latency.c

Note1: instead of touching the make process the patch allows to build
the tests above also for architecture that do not support tsc, yet.
These tests will fail at run-time with ENOTSUP. A warning will
appear while compiling as well.
hmm, I do know if it is the right solution but it's simple and
a good starting point for me.

Note2: I've just started running this part of the ltp on stlinux
targets so I cannot provide results and I don't know which
tests will fail.

Note3: realtime tests continues to build and apparently work on i386.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

diff -urN ltp-full-20090731/testcases/realtime.orig/func/async_handler/async_handler_tsc.c ltp-full-20090731/testcases/realtime/func/async_handler/async_handler_tsc.c
--- ltp-full-20090731/testcases/realtime.orig/func/async_handler/async_handler_tsc.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/func/async_handler/async_handler_tsc.c	2009-11-04 15:39:21.000000000 +0100
@@ -45,6 +45,7 @@
 #include <pthread.h>
 #include <librttest.h>
 #include <libstats.h>
+#include <libtsc.h>
 
 #define HANDLER_PRIO 98
 #define SIGNAL_PRIO 99
@@ -190,6 +191,11 @@
 int main(int argc, char *argv[])
 {
 	int signal_id, handler_id;
+
+#ifdef TSC_UNSUPPORTED
+	printf("Error: test cannot be executed on an arch wihout TSC.\n");
+	return ENOTSUP;
+#endif
 	setup();
 
 	rt_init("h", parse_args, argc, argv);
diff -urN ltp-full-20090731/testcases/realtime.orig/func/measurement/preempt_timing.c ltp-full-20090731/testcases/realtime/func/measurement/preempt_timing.c
--- ltp-full-20090731/testcases/realtime.orig/func/measurement/preempt_timing.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/func/measurement/preempt_timing.c	2009-11-04 15:39:26.000000000 +0100
@@ -52,7 +52,7 @@
 #include <sys/mman.h>
 #include <stdint.h>
 #include <librttest.h>
-
+#include <libtsc.h>
 
 #define ITERATIONS 1000000ULL
 #define INTERVALS 10
@@ -86,6 +86,12 @@
 	struct sched_param param;
 	cpu_set_t mask;
 	int err;
+
+#ifdef TSC_UNSUPPORTED
+	printf("Error: test cannot be executed on an arch wihout TSC.\n");
+	return ENOTSUP;
+#endif
+
 	max = avg = 0;
 	min = -1;
 	setup();
diff -urN ltp-full-20090731/testcases/realtime.orig/func/measurement/rdtsc-latency.c ltp-full-20090731/testcases/realtime/func/measurement/rdtsc-latency.c
--- ltp-full-20090731/testcases/realtime.orig/func/measurement/rdtsc-latency.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/func/measurement/rdtsc-latency.c	2009-11-04 15:38:49.000000000 +0100
@@ -44,6 +44,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <librttest.h>
+#include <libtsc.h>
 
 #define ITERATIONS 1000000
 
@@ -101,6 +102,12 @@
 	unsigned long long deltas[ITERATIONS];
 	unsigned long long max, min, avg, tsc_a, tsc_b, tsc_period;
 	struct sched_param param;
+
+#ifdef TSC_UNSUPPORTED
+	printf("Error: test cannot be executed on an arch wihout TSC.\n");
+	return ENOTSUP;
+#endif
+
 	setup();
 
 	rt_init("h",parse_args,argc,argv);
diff -urN ltp-full-20090731/testcases/realtime.orig/include/librttest.h ltp-full-20090731/testcases/realtime/include/librttest.h
--- ltp-full-20090731/testcases/realtime.orig/include/librttest.h	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/include/librttest.h	2009-11-04 14:21:22.000000000 +0100
@@ -36,6 +36,7 @@
  *      2006-May-09: improved command line argument handling
  *      2007-Jul-12: Added latency tracing functions -- Josh Triplett
  *      2007-Jul-26: Renamed to librttest.h -- Josh Triplett
+ *      2009-Nov-4: TSC macros within another header -- Giuseppe Cavallaro
  *
  *****************************************************************************/
 
@@ -96,36 +97,7 @@
 #define thread_quit(T) (((T)->flags) & THREAD_QUIT)
 
 #define PRINT_BUFFER_SIZE (1024*1024*4)
-
-/* TSC macros */
 #define ULL_MAX 18446744073709551615ULL // (1 << 64) - 1
-#if defined(__i386__)
-#define rdtscll(val) __asm__ __volatile__("rdtsc" : "=A" (val))
-#elif defined(__x86_64__)
-#define rdtscll(val)					\
-	do {						\
-		uint32_t low, high;			\
-		__asm__ __volatile__ ("rdtsc" : "=a" (low), "=d" (high)); \
-		val = (uint64_t)high << 32 | low;	\
-	} while(0)
-#elif defined(__powerpc__)
-#if defined(__powerpc64__)	/* 64bit version */
-#define rdtscll(val)					\
-	do {								\
-		__asm__ __volatile__ ("mfspr %0, 268" : "=r" (val));	\
-	} while(0)
-#else	/*__powerpc__ 32bit version */
-#define rdtscll(val)							\
-	 do {								\
-		uint32_t tbhi, tblo ;					\
-		__asm__ __volatile__ ("mftbu %0" : "=r" (tbhi));	\
-		__asm__ __volatile__ ("mftbl %0" : "=r" (tblo));	\
-		val = 1000 * ((uint64_t) tbhi << 32) | tblo;		\
-	} while(0)
-#endif
-#else
-#error
-#endif
 
 extern pthread_mutex_t _buffer_mutex;
 extern char * _print_buffer;
@@ -135,7 +107,7 @@
 
 /* function prototypes */
 
-/* atomic_add - add integer to atomic variable
+/* atomic_add - add integer to atomic variable and returns a value.
  * i: integer value to add
  * v: pointer of type atomic_t
  */
@@ -165,6 +137,20 @@
 	: "cc", "memory");
 
 	return t;
+#elif defined(__sh__)
+	unsigned long t;
+
+	__asm__ __volatile__ (
+"1:	 movli.l @%2, %0	 ! atomic_add_return     \n"
+"	 add     %1, %0				  \n"
+"	 movco.l %0, @%2				 \n"
+"	 bf      1b				      \n"
+"       synco					   \n"
+	: "=&z" (t)
+	: "r" (i), "r" (&v->counter)
+	: "t");
+
+	return t;
 #else
 #error
 #endif
@@ -343,7 +329,6 @@
  */
 int ts_to_nsec(struct timespec *ts, nsec_t *ns);
 
-/* return difference in microseconds */
 unsigned long long tsc_minus(unsigned long long tsc_start, unsigned long long tsc_end);
 
 /* rt_nanosleep: sleep for ns nanoseconds using clock_nanosleep
diff -urN ltp-full-20090731/testcases/realtime.orig/include/libtsc.h ltp-full-20090731/testcases/realtime/include/libtsc.h
--- ltp-full-20090731/testcases/realtime.orig/include/libtsc.h	1970-01-01 01:00:00.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/include/libtsc.h	2009-11-04 15:41:03.000000000 +0100
@@ -0,0 +1,72 @@
+/******************************************************************************
+ *
+ *   Copyright �� International Business Machines  Corp., 2006-2008
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * NAME
+ *       libtsc.h
+ *
+ * DESCRIPTION
+ *
+ * USAGE:
+ *       To be included in some testcases.
+ *
+ * AUTHOR
+ *        Darren Hart <dvhltc@us.ibm.com>
+ *        Giuseppe Cavallaro <peppe.cavallarost.com>
+ *
+ * HISTORY
+ *      It directly comes from the librttest.h (see its HISTORY).
+ *
+ *****************************************************************************/
+
+#undef TSC_UNSUPPORTED
+
+/* TSC macros */
+#if defined(__i386__)
+#define rdtscll(val) __asm__ __volatile__("rdtsc" : "=A" (val))
+#elif defined(__x86_64__)
+#define rdtscll(val)					\
+	do {						\
+		uint32_t low, high;			\
+		__asm__ __volatile__ ("rdtsc" : "=a" (low), "=d" (high)); \
+		val = (uint64_t)high << 32 | low;	\
+	} while (0)
+#elif defined(__powerpc__)
+#if defined(__powerpc64__)	/* 64bit version */
+#define rdtscll(val)					\
+	do {								\
+		__asm__ __volatile__ ("mfspr %0, 268" : "=r" (val));	\
+	} while (0)
+#else	/*__powerpc__ 32bit version */
+#define rdtscll(val)							\
+	 do {								\
+		uint32_t tbhi, tblo ;					\
+		__asm__ __volatile__ ("mftbu %0" : "=r" (tbhi));	\
+		__asm__ __volatile__ ("mftbl %0" : "=r" (tblo));	\
+		val = 1000 * ((uint64_t) tbhi << 32) | tblo;		\
+	} while (0)
+#endif
+#else
+#warning TSC UNSUPPORTED
+/* All tests will be compiled also for the
+ * architecture without TSC support (e.g. SH).
+ * At run-time these will fail with ENOTSUP.
+ */
+#define rdtscll(val)	do {  } while (0)
+#define TSC_UNSUPPORTED
+#endif
+

--------------010607010704040804000802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------010607010704040804000802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010607010704040804000802--

