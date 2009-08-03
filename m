Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MXn9x-0005zW-5G
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 02:20:21 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXn9o-0004RF-Td
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 02:20:21 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1457135qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Sun, 02 Aug 2009 19:20:07 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 2 Aug 2009 19:20:07 -0700
Message-ID: <364299f40908021920v5b743b6k7a4516b79731de5d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Fix compiler warnings for performance_counter tests
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

This simply fixes some missing declarations and linux_syscall_number.h
cleanup related compiler warnings.

This is ok for commit to HEAD.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/performance_counters/performance_counter01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/performance_counters/performance_counter01.c,v
retrieving revision 1.2
diff -u -r1.2 performance_counter01.c
--- testcases/kernel/performance_counters/performance_counter01.c	23
Jun 2009 14:21:32 -0000	1.2
+++ testcases/kernel/performance_counters/performance_counter01.c	3
Aug 2009 02:19:38 -0000
@@ -50,7 +50,7 @@
 char *TCID     = "performance_counter01"; /* test program identifier.
         */
 int  TST_TOTAL = 1;

-#define cleanup tst_exit /* for now... */
+static void cleanup(void) { /* Stub function. */ }

 int perf_counter_open(int		hw_event_type,
                       unsigned int	hw_event_period,
@@ -71,7 +71,8 @@
 	PERF_COUNT_BRANCH_MISSES,
 };

-int main(void) {
+int
+main(void) {
 	unsigned long long count1, count2;
 	int fd1, fd2, ret;
 	fd1 = perf_counter_open(PERF_COUNT_INSTRUCTIONS, 0, 0, 0, -1);
Index: testcases/kernel/performance_counters/performance_counter02.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/performance_counters/performance_counter02.c,v
retrieving revision 1.2
diff -u -r1.2 performance_counter02.c
--- testcases/kernel/performance_counters/performance_counter02.c	23
Jun 2009 14:21:32 -0000	1.2
+++ testcases/kernel/performance_counters/performance_counter02.c	3
Aug 2009 02:19:38 -0000
@@ -62,6 +62,8 @@
 #include <poll.h>
 #include <unistd.h>
 #include <errno.h>
+#include "config.h"
+#include <sys/prctl.h>
 #include <sys/types.h>
 #include <linux/types.h>
 #include <syscall.h>
@@ -82,7 +84,7 @@
 char *TCID     = "performance_counter02"; /* test program identifier.
         */
 int  TST_TOTAL = 1;                  /* total number of tests in this
file.   */

-#define cleanup tst_exit /* for now... */
+static void cleanup(void) { /* Stub function. */ }

 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -141,6 +143,7 @@
 		asm volatile("" : : "g" (i));
 }

+int
 main(int ac, char **av)
 {
 	int tsk0;
@@ -238,5 +241,5 @@
 	}

 	fprintf(stderr, "test passed\n");
-	exit(0);
+	tst_exit();
 }

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
