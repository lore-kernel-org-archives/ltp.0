Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peppe.cavallaro@st.com>) id 1N9zDb-0004HY-Ug
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 10:53:59 +0000
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149])
	by 72vjzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9zDU-00034R-Qo
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 10:53:59 +0000
Message-ID: <4B012F2A.9090404@st.com>
Date: Mon, 16 Nov 2009 11:53:30 +0100
From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
MIME-Version: 1.0
References: <4AF1A24C.8020503@st.com>	
	<1257788356.7677.68.camel@subratamodak.linux.ibm.com>	
	<20091112141814.4599b83a@sripathi.in.ibm.com>
	<4AFD0D82.6050302@st.com>
	<1258359220.5677.33.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1258359220.5677.33.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------070803080200010003000801"
Subject: Re: [LTP] [PATCH] compiling realtime tests for SH.
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, amrith <amrith@linux.ibm.com>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>, Sripathi Kodi <sripathik@linux.vnet.ibm.com>

This is a multi-part message in MIME format.
--------------070803080200010003000801
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Subrata Modak wrote:
>>>> In my opinion this patch would have been better split into 2
>>>> parts: one that separates out TSC parts and the other that adds atomic
>>>> functions for SH. That would make changelogs easier to search through
>>>> in future.
> if you like I can resend the patch splitted into two parts.
> Let me know.
> 
>> Yah, Please do so. I will do separate check-ins with separate LOG
>> messages.

Hi Subrata,
in attachment the two patches.

Regards
Peppe

> 
>> Regards--
>> Subrata
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAksBLyoACgkQ2Xo3j31MSSIMfgCgn3qXNrOd/2mhyeri3loHGoBg
u1IAoIhbksE6wEIRWLYoIMGhQBZGF1dj
=QsPg
-----END PGP SIGNATURE-----

--------------070803080200010003000801
Content-Type: text/x-patch;
 name="ltp-full-20090731-SH-atomic_add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="ltp-full-20090731-SH-atomic_add.patch"

[PATCH (1/2)] add atomi_add() define for __sh__.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

--- ltp-full-20090731/testcases/realtime.orig/include/librttest.h	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/include/librttest.h	2009-11-16 11:27:23.000000000 +0100
@@ -135,7 +135,7 @@ extern double pass_criteria;
 
 /* function prototypes */
 
-/* atomic_add - add integer to atomic variable
+/* atomic_add - add integer to atomic variable and returns a value.
  * i: integer value to add
  * v: pointer of type atomic_t
  */
@@ -165,6 +165,20 @@ static inline int atomic_add(int i, atom
 	: "cc", "memory");
 
 	return t;
+#elif defined(__sh__)
+	unsigned long t;
+
+	__asm__ __volatile__ (
+"1:	 movli.l @%2, %0	\n"
+"	 add     %1, %0		\n"
+"	 movco.l %0, @%2	\n"
+"	 bf      1b		\n"
+"       synco			\n"
+	: "=&z" (t)
+	: "r" (i), "r" (&v->counter)
+	: "t");
+
+	return t;
 #else
 #error
 #endif

--------------070803080200010003000801
Content-Type: text/x-patch;
 name="ltp-full-20090731-tsc_splitted.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ltp-full-20090731-tsc_splitted.patch"

[PATCH (2/2)] splitting the tsc support.

The patch moves the tsc macros form the librttest.h
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

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

diff -uprN ltp-full-20090731/testcases/realtime.orig/func/async_handler/async_handler_tsc.c ltp-full-20090731/testcases/realtime/func/async_handler/async_handler_tsc.c
--- ltp-full-20090731/testcases/realtime.orig/func/async_handler/async_handler_tsc.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/func/async_handler/async_handler_tsc.c	2009-11-16 11:38:43.000000000 +0100
@@ -45,6 +45,7 @@
 #include <pthread.h>
 #include <librttest.h>
 #include <libstats.h>
+#include <libtsc.h>
 
 #define HANDLER_PRIO 98
 #define SIGNAL_PRIO 99
@@ -190,6 +191,11 @@ void *signal_thread(void *arg)
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
diff -uprN ltp-full-20090731/testcases/realtime.orig/func/measurement/preempt_timing.c ltp-full-20090731/testcases/realtime/func/measurement/preempt_timing.c
--- ltp-full-20090731/testcases/realtime.orig/func/measurement/preempt_timing.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/func/measurement/preempt_timing.c	2009-11-16 11:38:43.000000000 +0100
@@ -52,7 +52,7 @@
 #include <sys/mman.h>
 #include <stdint.h>
 #include <librttest.h>
-
+#include <libtsc.h>
 
 #define ITERATIONS 1000000ULL
 #define INTERVALS 10
@@ -86,6 +86,12 @@ int main(int argc, char *argv[])
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
diff -uprN ltp-full-20090731/testcases/realtime.orig/func/measurement/rdtsc-latency.c ltp-full-20090731/testcases/realtime/func/measurement/rdtsc-latency.c
--- ltp-full-20090731/testcases/realtime.orig/func/measurement/rdtsc-latency.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/func/measurement/rdtsc-latency.c	2009-11-16 11:38:43.000000000 +0100
@@ -44,6 +44,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <librttest.h>
+#include <libtsc.h>
 
 #define ITERATIONS 1000000
 
@@ -101,6 +102,12 @@ int main(int argc, char *argv[])
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
diff -uprN ltp-full-20090731/testcases/realtime.orig/include/librttest.h ltp-full-20090731/testcases/realtime/include/librttest.h
--- ltp-full-20090731/testcases/realtime.orig/include/librttest.h	2009-11-16 11:33:20.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/include/librttest.h	2009-11-16 11:40:11.000000000 +0100
@@ -36,6 +36,7 @@
  *      2006-May-09: improved command line argument handling
  *      2007-Jul-12: Added latency tracing functions -- Josh Triplett
  *      2007-Jul-26: Renamed to librttest.h -- Josh Triplett
+ *      2009-Nov-4: TSC macros within another header -- Giuseppe Cavallaro
  *
  *****************************************************************************/
 
@@ -96,36 +97,7 @@ typedef struct { volatile int counter; }
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
diff -uprN ltp-full-20090731/testcases/realtime.orig/include/libtsc.h ltp-full-20090731/testcases/realtime/include/libtsc.h
--- ltp-full-20090731/testcases/realtime.orig/include/libtsc.h	1970-01-01 01:00:00.000000000 +0100
+++ ltp-full-20090731/testcases/realtime/include/libtsc.h	2009-11-16 11:38:43.000000000 +0100
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

--------------070803080200010003000801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------070803080200010003000801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070803080200010003000801--

