From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2017 11:22:39 +0800
Subject: [LTP] [RFC PATCH 13/13] mem/tunable: convert to new API
In-Reply-To: <20170328032239.11917-13-liwang@redhat.com>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170328032239.11917-2-liwang@redhat.com>
 <20170328032239.11917-3-liwang@redhat.com>
 <20170328032239.11917-4-liwang@redhat.com>
 <20170328032239.11917-5-liwang@redhat.com>
 <20170328032239.11917-6-liwang@redhat.com>
 <20170328032239.11917-7-liwang@redhat.com>
 <20170328032239.11917-8-liwang@redhat.com>
 <20170328032239.11917-9-liwang@redhat.com>
 <20170328032239.11917-10-liwang@redhat.com>
 <20170328032239.11917-11-liwang@redhat.com>
 <20170328032239.11917-12-liwang@redhat.com>
 <20170328032239.11917-13-liwang@redhat.com>
Message-ID: <20170328032239.11917-14-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/tunable/max_map_count.c     | 104 ++++++----------
 testcases/kernel/mem/tunable/min_free_kbytes.c   | 111 +++++++----------
 testcases/kernel/mem/tunable/overcommit_memory.c | 150 +++++++++--------------
 3 files changed, 140 insertions(+), 225 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 75a5098..0436fb9 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -1,4 +1,18 @@
 /*
+ * Copyright (C) 2012-2017  Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * Description:
+ *
  * The program is designed to test max_map_count tunable file
  *
  * The kernel Documentation say that:
@@ -24,32 +38,8 @@
  * ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0   [vsyscall]
  *
  * so we ignore this line during /proc/[pid]/maps reading.
- *
- * ********************************************************************
- * Copyright (C) 2012 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- *
- * ********************************************************************
  */
+
 #define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/mman.h>
@@ -60,47 +50,19 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/utsname.h>
-#include "test.h"
 #include "mem.h"
 
 #define MAP_COUNT_DEFAULT	1024
 #define MAX_MAP_COUNT		65536L
 
-char *TCID = "max_map_count";
-int TST_TOTAL = 1;
-
 static long old_max_map_count;
 static long old_overcommit;
 static struct utsname un;
 
-static long count_maps(pid_t pid);
-static void max_map_count_test(void);
-
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		max_map_count_test();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	if (access(PATH_SYSVM "max_map_count", F_OK) != 0)
-		tst_brkm(TBROK | TERRNO, NULL,
+		tst_brk(TBROK | TERRNO,
 			 "Can't support to test max_map_count");
 
 	old_max_map_count = get_sys_tune("max_map_count");
@@ -108,10 +70,10 @@ void setup(void)
 	set_sys_tune("overcommit_memory", 2, 1);
 
 	if (uname(&un) != 0)
-		tst_brkm(TBROK | TERRNO, NULL, "uname error");
+		tst_brk(TBROK | TERRNO, "uname error");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", old_overcommit, 0);
 	set_sys_tune("max_map_count", old_max_map_count, 0);
@@ -162,7 +124,7 @@ static long count_maps(pid_t pid)
 	snprintf(buf, BUFSIZ, "/proc/%d/maps", pid);
 	fp = fopen(buf, "r");
 	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", buf);
+		tst_brk(TBROK | TERRNO, "fopen %s", buf);
 	while (getline(&line, &len, fp) != -1) {
 		/* exclude vdso and vsyscall */
 		if (filter_map(line))
@@ -210,24 +172,24 @@ static void max_map_count_test(void)
 	while (max_maps <= max_iters) {
 		set_sys_tune("max_map_count", max_maps, 1);
 
-		switch (pid = tst_fork()) {
+		switch (pid = fork()) {
 		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
+			tst_brk(TBROK | TERRNO, "fork");
 		case 0:
 			while (mmap(NULL, 1, PROT_READ,
 				    MAP_SHARED | MAP_ANONYMOUS, -1, 0)
 			       != MAP_FAILED) ;
 			if (raise(SIGSTOP) != 0)
-				tst_brkm(TBROK | TERRNO, tst_exit, "raise");
+				tst_brk(TBROK | TERRNO, "raise");
 			exit(0);
 		default:
 			break;
 		}
 		/* wait child done mmap and stop */
 		if (waitpid(pid, &status, WUNTRACED) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+			tst_brk(TBROK | TERRNO, "waitpid");
 		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, cleanup, "child did not stopped");
+			tst_brk(TBROK, "child did not stopped");
 
 		map_count = count_maps(pid);
 		/* Note max_maps will be exceeded by one for
@@ -236,18 +198,26 @@ static void max_map_count_test(void)
 		 * writing this COMMENT!
 		*/
 		if (map_count == (max_maps + 1))
-			tst_resm(TPASS, "%ld map entries in total "
+			tst_res(TPASS, "%ld map entries in total "
 				 "as expected.", max_maps);
 		else
-			tst_resm(TFAIL, "%ld map entries in total, but "
+			tst_res(TFAIL, "%ld map entries in total, but "
 				 "expected %ld entries", map_count, max_maps);
 
 		/* make child continue to exit */
 		if (kill(pid, SIGCONT) != 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "kill");
+			tst_brk(TBROK | TERRNO, "kill");
 		if (waitpid(pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+			tst_brk(TBROK | TERRNO, "waitpid");
 
 		max_maps = max_maps << 1;
 	}
 }
+
+static struct tst_test test = {
+	.tid = "max_map_count",
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = max_map_count_test,
+};
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 493c37e..721962b 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -1,4 +1,18 @@
 /*
+ * Copyright (C) 2012-2017  Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * Description:
+ *
  * The case is designed to test min_free_kbytes tunable.
  *
  * The tune is used to control free memory, and system always
@@ -12,31 +26,6 @@
  * a) default min_free_kbytes with all overcommit memory policy
  * b) 2x default value with all overcommit memory policy
  * c) 5% of MemFree or %2 MemTotal with all overcommit memory policy
- *
- ********************************************************************
- * Copyright (C) 2012 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- *
- * ********************************************************************
  */
 
 #include <sys/types.h>
@@ -47,14 +36,11 @@
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include "test.h"
 #include "mem.h"
 
 #define MAP_SIZE (1UL<<20)
 
 volatile int end;
-char *TCID = "min_free_kbytes";
-int TST_TOTAL = 1;
 static unsigned long default_tune;
 static unsigned long orig_overcommit;
 static unsigned long total_mem;
@@ -64,25 +50,21 @@ static int eatup_mem(unsigned long overcommit_policy);
 static void check_monitor(void);
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
 
-int main(int argc, char *argv[])
+static void min_free_kbytes_test(void)
 {
-	int lc, pid, status;
+	int pid, status;
 	struct sigaction sa;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 	sa.sa_handler = sighandler;
 	if (sigemptyset(&sa.sa_mask) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigemptyset");
+		tst_brk(TBROK | TERRNO, "sigemptyset");
 	sa.sa_flags = 0;
 	if (sigaction(SIGUSR1, &sa, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigaction");
-
-	setup();
+		tst_brk(TBROK | TERRNO, "sigaction");
 
 	switch (pid = fork()) {
 	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+		tst_brk(TBROK | TERRNO, "fork");
 
 	case 0:
 		/* startup the check monitor */
@@ -90,24 +72,19 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		test_tune(2);
-		test_tune(0);
-		test_tune(1);
-	}
+	test_tune(2);
+	test_tune(0);
+	test_tune(1);
 
 	if (kill(pid, SIGUSR1) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "kill %d", pid);
+		tst_brk(TBROK | TERRNO, "kill %d", pid);
 	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		tst_brk(TBROK | TERRNO, "waitpid");
 	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_resm(TFAIL,
+		tst_res(TFAIL,
 			 "check_monitor child exit with status: %d", status);
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "min_free_kbytes test pass");
 }
 
 static void test_tune(unsigned long overcommit_policy)
@@ -140,18 +117,18 @@ static void test_tune(unsigned long overcommit_policy)
 		fflush(stdout);
 		switch (pid[i] = fork()) {
 		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
+			tst_brk(TBROK | TERRNO, "fork");
 		case 0:
 			ret = eatup_mem(overcommit_policy);
 			exit(ret);
 		}
 
 		if (waitpid(pid[i], &status, WUNTRACED | WCONTINUED) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+			tst_brk(TBROK | TERRNO, "waitpid");
 
 		if (overcommit_policy == 2) {
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_resm(TFAIL,
+				tst_res(TFAIL,
 					 "child unexpectedly failed: %d",
 					 status);
 		} else if (overcommit_policy == 1) {
@@ -160,25 +137,25 @@ static void test_tune(unsigned long overcommit_policy)
 			{
 				if (total_mem < 3145728UL)
 #endif
-					tst_resm(TFAIL,
+					tst_res(TFAIL,
 						 "child unexpectedly failed: %d",
 						 status);
 #if __WORDSIZE == 32
 				/* in 32-bit system, a process allocate about 3Gb memory@most */
 				else
-					tst_resm(TINFO, "Child can't allocate "
+					tst_res(TINFO, "Child can't allocate "
 						 ">3Gb memory in 32bit system");
 			}
 #endif
 		} else {
 			if (WIFEXITED(status)) {
 				if (WEXITSTATUS(status) != 0) {
-					tst_resm(TFAIL, "child unexpectedly "
+					tst_res(TFAIL, "child unexpectedly "
 						 "failed: %d", status);
 				}
 			} else if (!WIFSIGNALED(status) ||
 				   WTERMSIG(status) != SIGKILL) {
-				tst_resm(TFAIL,
+				tst_res(TFAIL,
 					 "child unexpectedly failed: %d",
 					 status);
 			}
@@ -222,9 +199,9 @@ static void check_monitor(void)
 		tune = get_sys_tune("min_free_kbytes");
 
 		if (memfree < tune) {
-			tst_resm(TINFO, "MemFree is %lu kB, "
+			tst_res(TINFO, "MemFree is %lu kB, "
 				 "min_free_kbytes is %lu kB", memfree, tune);
-			tst_resm(TFAIL, "MemFree < min_free_kbytes");
+			tst_res(TFAIL, "MemFree < min_free_kbytes");
 		}
 
 		sleep(2);
@@ -236,25 +213,29 @@ static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
 	end = 1;
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
 	if (get_sys_tune("panic_on_oom")) {
-		tst_brkm(TCONF, NULL,
+		tst_brk(TCONF,
 			"panic_on_oom is set, disable it to run these testcases");
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	total_mem = read_meminfo("MemTotal:") + read_meminfo("SwapTotal:");
 
 	default_tune = get_sys_tune("min_free_kbytes");
 	orig_overcommit = get_sys_tune("overcommit_memory");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("min_free_kbytes", default_tune, 0);
 	set_sys_tune("overcommit_memory", orig_overcommit, 0);
 }
+
+static struct tst_test test = {
+	.tid = "min_free_kbytes",
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = min_free_kbytes_test,
+};
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 79a3034..a1ebd6f 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -1,4 +1,18 @@
 /*
+ * Copyright (C) 2012-2017  Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * Descriptions:
+ *
  * There are two tunables overcommit_memory and overcommit_ratio under
  * /proc/sys/vm/, which can control memory overcommitment.
  *
@@ -49,45 +63,24 @@
  * References:
  * - Documentation/sysctl/vm.txt
  * - Documentation/vm/overcommit-accounting
- *
- * ********************************************************************
- * Copyright (C) 2012 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- *
- * ********************************************************************
  */
 
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <limits.h>
 #include "mem.h"
 
 #define DEFAULT_OVER_RATIO	50L
 #define EXPECT_PASS		0
 #define EXPECT_FAIL		1
 
-char *TCID = "overcommit_memory";
+char *R_opt;
+static struct tst_option options[] = {
+	{"R:", &R_opt, "  -R n    Percentage of overcommitting memory"},
+	{NULL, NULL, NULL}
+};
+
 static long old_overcommit_memory;
 static long old_overcommit_ratio;
 static long overcommit_ratio;
@@ -95,102 +88,64 @@ static long sum_total;
 static long free_total;
 static long commit_limit;
 static long commit_left;
-static int R_flag;
-static char *R_opt;
-option_t options[] = {
-	{"R:", &R_flag, &R_opt},
-	{NULL, NULL, NULL}
-};
 
-static void overcommit_memory_test(void);
 static int heavy_malloc(long size);
 static void alloc_and_check(long size, int expect_result);
-static void usage(void);
 static void update_mem(void);
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, options, &usage);
-
-#if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
-#endif
-
-	if (R_flag)
-		overcommit_ratio = SAFE_STRTOL(NULL, R_opt, 0, LONG_MAX);
-	else
-		overcommit_ratio = DEFAULT_OVER_RATIO;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		overcommit_memory_test();
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-void setup(void)
+static void setup(void)
 {
 	long mem_total, swap_total;
 	struct rlimit lim;
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
 	if (access(PATH_SYSVM "overcommit_memory", F_OK) == -1 ||
 	    access(PATH_SYSVM "overcommit_ratio", F_OK) == -1)
-		tst_brkm(TCONF, NULL, "The system "
+		tst_brk(TCONF, "The system "
 			 "can't support to test %s", TCID);
 
+	if (R_opt)
+		overcommit_ratio = SAFE_STRTOL(R_opt, 0, LONG_MAX);
+	else
+		overcommit_ratio = DEFAULT_OVER_RATIO;
+
 	old_overcommit_memory = get_sys_tune("overcommit_memory");
 	old_overcommit_ratio = get_sys_tune("overcommit_ratio");
 
 	mem_total = read_meminfo("MemTotal:");
-	tst_resm(TINFO, "MemTotal is %ld kB", mem_total);
+	tst_res(TINFO, "MemTotal is %ld kB", mem_total);
 	swap_total = read_meminfo("SwapTotal:");
-	tst_resm(TINFO, "SwapTotal is %ld kB", swap_total);
+	tst_res(TINFO, "SwapTotal is %ld kB", swap_total);
 	sum_total = mem_total + swap_total;
 
 	commit_limit = read_meminfo("CommitLimit:");
-	tst_resm(TINFO, "CommitLimit is %ld kB", commit_limit);
+	tst_res(TINFO, "CommitLimit is %ld kB", commit_limit);
 
-	SAFE_GETRLIMIT(NULL, RLIMIT_AS, &lim);
+	SAFE_GETRLIMIT(RLIMIT_AS, &lim);
 
 	if (lim.rlim_cur != RLIM_INFINITY) {
 		lim.rlim_cur = RLIM_INFINITY;
 		lim.rlim_max = RLIM_INFINITY;
 
-		tst_resm(TINFO, "Increasing RLIM_AS to INFINITY");
+		tst_res(TINFO, "Increasing RLIM_AS to INFINITY");
 
-		SAFE_SETRLIMIT(NULL, RLIMIT_AS, &lim);
+		SAFE_SETRLIMIT(RLIMIT_AS, &lim);
 	}
 
 	set_sys_tune("overcommit_ratio", overcommit_ratio, 1);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", old_overcommit_memory, 0);
 	set_sys_tune("overcommit_ratio", old_overcommit_ratio, 0);
 }
 
-static void usage(void)
-{
-	printf("  -R n    Percentage of overcommitting memory\n");
-}
-
 static void overcommit_memory_test(void)
 {
+
+#if __WORDSIZE == 32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+#endif
 	/* start to test overcommit_memory=2 */
 	set_sys_tune("overcommit_memory", 2, 1);
 
@@ -224,11 +179,11 @@ static int heavy_malloc(long size)
 
 	p = malloc(size * KB);
 	if (p != NULL) {
-		tst_resm(TINFO, "malloc %ld kB successfully", size);
+		tst_res(TINFO, "malloc %ld kB successfully", size);
 		free(p);
 		return 0;
 	} else {
-		tst_resm(TINFO, "malloc %ld kB failed", size);
+		tst_res(TINFO, "malloc %ld kB failed", size);
 		return 1;
 	}
 }
@@ -243,18 +198,18 @@ static void alloc_and_check(long size, int expect_result)
 	switch (expect_result) {
 	case EXPECT_PASS:
 		if (result == 0)
-			tst_resm(TPASS, "alloc passed as expected");
+			tst_res(TPASS, "alloc passed as expected");
 		else
-			tst_resm(TFAIL, "alloc failed, expected to pass");
+			tst_res(TFAIL, "alloc failed, expected to pass");
 		break;
 	case EXPECT_FAIL:
 		if (result != 0)
-			tst_resm(TPASS, "alloc failed as expected");
+			tst_res(TPASS, "alloc failed as expected");
 		else
-			tst_resm(TFAIL, "alloc passed, expected to fail");
+			tst_res(TFAIL, "alloc passed, expected to fail");
 		break;
 	default:
-		tst_brkm(TBROK, cleanup, "Invaild numbler parameter: %d",
+		tst_brk(TBROK, "Invaild numbler parameter: %d",
 			 expect_result);
 	}
 }
@@ -274,10 +229,19 @@ static void update_mem(void)
 		commit_left = commit_limit - committed;
 
 		if (commit_left < 0) {
-			tst_resm(TINFO, "CommitLimit is %ld, Committed_AS"
+			tst_res(TINFO, "CommitLimit is %ld, Committed_AS"
 				 " is %ld", commit_limit, committed);
-			tst_brkm(TBROK, cleanup, "Unexpected error: "
+			tst_brk(TBROK, "Unexpected error: "
 				 "CommitLimit < Committed_AS");
 		}
 	}
 }
+
+static struct tst_test test = {
+	.tid = "overcommit_memory",
+	.needs_root = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = overcommit_memory_test,
+};
-- 
2.9.3

