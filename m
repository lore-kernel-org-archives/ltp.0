Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WY6KV-0006DA-Mx
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 04:11:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WY6KR-0000zG-Dh
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 04:11:11 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3A4AfJ6032675
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Apr 2014 12:10:41 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 10 Apr 2014 12:08:45 +0800
Message-ID: <1397102926-2630-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1397102926-2630-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1397102926-2630-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/3] perf_event_open/perf_event_open01.c: cleanup
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

Create ltp-perf_event_open.m4 to determine whether struct perf_event_attr is
defined in <linux/perf_event.h>.

And according to perf_event_open()'s manpage, the official way of knowing
if perf_event_open() support is enabled is checking for the existence
of the file /proc/sys/kernel/perf_event_paranoid, so add this check.

According to this perf_event_open API description, rewrite this test
case to test hardware CPU events.
int perf_event_open(struct perf_event_attr *attr,
        pid_t pid, int cpu, int group_fd,
        unsigned long flags);

Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac                                       |   1 +
 m4/ltp-perf_event_open.m4                          |  47 ++++++
 runtest/syscalls                                   |   2 +
 .../syscalls/perf_event_open/perf_event_open01.c   | 185 +++++++++++++++------
 4 files changed, 187 insertions(+), 48 deletions(-)
 create mode 100644 m4/ltp-perf_event_open.m4

diff --git a/configure.ac b/configure.ac
index 44016e7..161f41c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,5 +175,6 @@ LTP_CHECK_FCHOWNAT
 LTP_CHECK_MKNODAT
 LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
+LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 
 AC_OUTPUT
diff --git a/m4/ltp-perf_event_open.m4 b/m4/ltp-perf_event_open.m4
new file mode 100644
index 0000000..a1084cf
--- /dev/null
+++ b/m4/ltp-perf_event_open.m4
@@ -0,0 +1,47 @@
+dnl
+dnl Copyright (c) 2014 Fujitsu Ltd.
+dnl Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_SYSCALL_PERF_EVENT_OPEN],[dnl
+	AC_MSG_CHECKING([for perf_event_open struct perf_event_attr])
+	save_CPPFLAGS=$CPPFLAGS
+	CPPFLAGS="$CPPFLAGS -I$srcdir/testcases/kernel/include -I$srcdir/include"
+	AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <linux/perf_event.h>
+#include "linux_syscall_numbers.h"
+int main(void) {
+	struct perf_event_attr pe;
+	syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
+	return 0;
+}])],[has_perf_event_attr="yes"])
+
+
+if test "x$has_perf_event_attr" = xyes; then
+	AC_DEFINE(HAVE_PERF_EVENT_ATTR,1,[Define to 1 if you have struct perf_event_attr])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+CPPFLAGS=$save_CPPFLAGS
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..afbded3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1352,3 +1352,5 @@ writev03 writev03
 writev04 writev04
 writev05 writev05
 writev06 writev06
+
+perf_event_open01 perf_event_open01
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 6d7cbc9..5c870f6 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -22,13 +22,13 @@
  * Very simple performance counter testcase.
  * Picked up from: http://lkml.org/lkml/2008/12/5/17
  */
+
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/uio.h>
 #include <linux/unistd.h>
-
 #include <assert.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -36,73 +36,162 @@
 #include <string.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include "config.h"
+#if HAVE_PERF_EVENT_ATTR
+#include <linux/perf_event.h>
+#endif
 
-/* Harness Specific Include Files. */
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-
-/* Extern Global Variables */
-extern int tst_count;
-extern char *TESTDIR;		/* temporary dir created by tst_tmpdir() */
-/* Global Variables */
-char *TCID = "performance_counter01";	/* test program identifier.          */
-int TST_TOTAL = 1;
-
-enum hw_event_types {
-	PERF_COUNT_CYCLES,
-	PERF_COUNT_INSTRUCTIONS,
-	PERF_COUNT_CACHE_REFERENCES,
-	PERF_COUNT_CACHE_MISSES,
-	PERF_COUNT_BRANCH_INSTRUCTIONS,
-	PERF_COUNT_BRANCH_MISSES,
+#include "safe_macros.h"
+
+char *TCID = "performance_counter01";
+int TST_TOTAL = 6;
+
+#if HAVE_PERF_EVENT_ATTR
+static void setup(void);
+static void cleanup(void);
+
+static struct test_case_t {
+	const char *name;
+	unsigned long long val;
+} hw_event_types[] = {
+	{ "PERF_COUNT_HW_CPU_CYCLES", PERF_COUNT_HW_CPU_CYCLES },
+	{ "PERF_COUNT_HW_INSTRUCTIONS", PERF_COUNT_HW_INSTRUCTIONS },
+	{ "PERF_COUNT_HW_CACHE_REFERENCES", PERF_COUNT_HW_CACHE_REFERENCES },
+	{ "PERF_COUNT_HW_CACHE_MISSES", PERF_COUNT_HW_CACHE_MISSES },
+	{ "PERF_COUNT_HW_BRANCH_INSTRUCTIONS",
+	  PERF_COUNT_HW_BRANCH_INSTRUCTIONS },
+	{ "PERF_COUNT_HW_BRANCH_MISSES", PERF_COUNT_HW_BRANCH_MISSES },
 };
 
-void cleanup(void)
-{				/* Stub function. */
+static void verify(struct test_case_t *tc);
+static struct perf_event_attr pe;
+
+int main(int ac, char **av)
+{
+	int i, lc;
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			verify(&hw_event_types[i]);
+	}
+
+	cleanup();
+	tst_exit();
 }
 
-int main(void)
+static void setup(void)
 {
+	/*
+	 * According to perf_event_open's manpage, the official way of
+	 * knowing if perf_event_open() support is enabled is checking for
+	 * the existence of the file /proc/sys/kernel/perf_event_paranoid.
+	 */
+	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Kernel doesn't have perf_event support");
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	pe.type = PERF_TYPE_HARDWARE;
+	pe.size = sizeof(struct perf_event_attr);
+	pe.disabled = 1;
+	pe.exclude_kernel = 1;
+	pe.exclude_hv = 1;
+}
+
+
+static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
+		int cpu, int group_fd, unsigned long flags)
+{
+	int ret;
+
+	ret = ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu,
+			  group_fd, flags);
+	return ret;
+}
 
-	unsigned long long count1, count2;
-	int fd1, fd2, ret;
+/* do_work() is copied form performance_counter02.c */
+#define LOOPS	1000000000
 
-	fd1 = ltp_syscall(__NR_perf_event_open,
-		      PERF_COUNT_INSTRUCTIONS, 0, 0, 0, -1);
-	if (fd1 < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Failed to create PERF_COUNT_INSTRUCTIONS fd");
+static void do_work(void)
+{
+	int i;
+
+	for (i = 0; i < LOOPS; ++i)
+		asm volatile ("" : : "g" (i));
+}
+
+static void verify(struct test_case_t *tc)
+{
+	unsigned long long count;
+	int fd, ret;
+
+	pe.config = tc->val;
+
+	TEST(perf_event_open(&pe, 0, -1, -1, 0));
+	if (TEST_RETURN == -1) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "perf_event_open failed unexpectedly");
+		return;
 	}
-	fd2 = ltp_syscall(__NR_perf_event_open,
-		      PERF_COUNT_CACHE_MISSES, 0, 0, 0, -1);
-	if (fd2 < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Failed to create PERF_COUNT_CACHE_MISSES fd");
+
+	fd = TEST_RETURN;
+
+	if (ioctl(fd, PERF_EVENT_IOC_RESET, 0) == -1) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "ioctl set PERF_EVENT_IOC_RESET failed");
 	}
 
-	do {
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) == -1) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "ioctl set PERF_EVENT_IOC_ENABLE failed");
+	}
 
-		ret = read(fd1, &count1, sizeof(count1));
+	do_work();
 
-		if (ret == sizeof(count1)) {
+	if (ioctl(fd, PERF_EVENT_IOC_DISABLE, 0) == -1) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "ioctl set PERF_EVENT_IOC_RESET failed");
+	}
 
-			ret = read(fd2, &count2, sizeof(count2));
+	ret = read(fd, &count, sizeof(count));
+	if (ret == sizeof(count)) {
+		tst_resm(TINFO, "read event counter succeeded, "
+			 "value: %llu", count);
+		tst_resm(TPASS, "test PERF_TYPE_HARDWARE: %s succeeded",
+			 tc->name);
+	} else {
+		tst_resm(TFAIL | TERRNO, "read event counter failed");
+	}
 
-			if (ret == sizeof(count2)) {
-				tst_resm(TINFO,
-					 "counter1 value: %Ld instructions",
-					 count1);
-				tst_resm(TINFO,
-					 "counter2 value: %Ld cachemisses",
-					 count2);
-				sleep(1);
-			}
+	SAFE_CLOSE(cleanup, fd);
 
-		}
+}
 
-	} while (ret == sizeof(unsigned long long));
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
 
-	tst_exit();
+#else
 
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "This system doesn't have "
+		 "header file:<linux/perf_event.h> or "
+		 "no struct perf_event_attr defined");
 }
+#endif
-- 
1.8.2.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
