From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 17 Jun 2021 18:55:56 +0800
Subject: [LTP] [PATCH 3/3 v2] getrusage: Cleanup and bugfix for getrusage03
In-Reply-To: <20210617105556.130869-1-xieziyao@huawei.com>
References: <20210617105556.130869-1-xieziyao@huawei.com>
Message-ID: <20210617105556.130869-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Remove fork_malloc(), which is covered by inherit_fork{1, 2}().
2. Double the value of DELTA_MAX for machines with 64k pages, e.g. ppc64le.
3. Convert getrusage03 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Report PASS/FAIL from child processes.
2. Print more details in output.
3. Cleanup and correct some format.

 .../kernel/syscalls/getrusage/getrusage03.c   | 398 +++++-------------
 .../kernel/syscalls/getrusage/getrusage03.h   |  33 ++
 .../syscalls/getrusage/getrusage03_child.c    | 196 +++------
 3 files changed, 195 insertions(+), 432 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.h

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 125acfc64..f72f908dc 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -1,353 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * getrusage03 - test ru_maxrss behaviors in struct rusage
- *
- * This test program is backported from upstream commit:
- * 1f10206cf8e945220f7220a809d8bfc15c21f9a5, which fills ru_maxrss
- * value in struct rusage according to rss hiwater mark. To make sure
- * this feature works correctly, a series of tests are executed in
- * this program.
- *
  * Copyright (C) 2011  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * Copyright (C) 2021 Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
  *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
+ * Test ru_maxrss behaviors in struct rusage.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * This test program is backported from upstream commit: 1f10206cf8e9, which
+ * fills ru_maxrss value in struct rusage according to rss hiwater mark. To
+ * make sure this feature works correctly, a series of tests are executed in
+ * this program.
  */
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/resource.h>
-#include <sys/time.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>

-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include <stdio.h>

-char *TCID = "getrusage03";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "getrusage03.h"

-#define DELTA_MAX	10240
+#define TESTBIN "getrusage03_child"

 static struct rusage ru;
 static long maxrss_init;
-static int retval, status;
-static pid_t pid;
-
-static void inherit_fork(void);
-static void inherit_fork2(void);
-static void fork_malloc(void);
-static void grandchild_maxrss(void);
-static void zombie(void);
-static void sig_ign(void);
-static void exec_without_fork(void);
-static void check_return(int status, char *pass_msg, char *fail_msg);
-static int is_in_delta(long value);
-static void consume(int mega);
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);

-	setup();
+static const char *const resource[] = {
+	TESTBIN,
+	NULL,
+};

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		tst_resm(TINFO, "allocate 100MB");
-		consume(100);
+static void inherit_fork1(void)
+{
+	SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
+	maxrss_init = ru.ru_maxrss;

-		inherit_fork();
-		inherit_fork2();
-		fork_malloc();
-		grandchild_maxrss();
-		zombie();
-		sig_ign();
-		exec_without_fork();
-	}
-	cleanup();
-	tst_exit();
-}
+	if (!SAFE_FORK()) {
+		SAFE_GETRUSAGE(RUSAGE_SELF, &ru);

-/* Testcase #01: fork inherit
- * expect: initial.self ~= child.self */
-static void inherit_fork(void)
-{
-	tst_resm(TINFO, "Testcase #01: fork inherit");
-
-	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
-	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
-
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
-	case 0:
-		maxrss_init = ru.ru_maxrss;
-		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
-		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
-		exit(is_in_delta(maxrss_init - ru.ru_maxrss));
-	default:
-		break;
+		if (is_in_delta(maxrss_init - ru.ru_maxrss))
+			tst_res(TPASS, "initial.self ~= child.self");
+		else
+			tst_res(TFAIL, "child.self = %li, expected %li",
+				ru.ru_maxrss, maxrss_init);
+		exit(0);
 	}
-
-	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
-	check_return(WEXITSTATUS(status), "initial.self ~= child.self",
-		     "initial.self !~= child.self");
+	tst_reap_children();
 }

-/* Testcase #02: fork inherit (cont.)
- * expect: initial.children ~= 100MB, child.children = 0 */
 static void inherit_fork2(void)
 {
-	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);

-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
 	if (is_in_delta(ru.ru_maxrss - 102400))
-		tst_resm(TPASS, "initial.children ~= 100MB");
+		tst_res(TPASS, "initial.children ~= 100MB");
 	else
-		tst_resm(TFAIL, "initial.children !~= 100MB");
-
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork #2");
-	case 0:
-		SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-		tst_resm(TINFO, "child.children = %ld", ru.ru_maxrss);
-		exit(ru.ru_maxrss == 0);
-	default:
-		break;
-	}
+		tst_res(TFAIL, "initial.children = %li, expected %i",
+			ru.ru_maxrss, 102400);

-	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
-	check_return(WEXITSTATUS(status), "child.children == 0",
-		     "child.children != 0");
-}
+	if (!SAFE_FORK()) {
+		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);

-/* Testcase #03: fork + malloc
- * expect: initial.self + 50MB ~= child.self */
-static void fork_malloc(void)
-{
-	tst_resm(TINFO, "Testcase #03: fork + malloc");
-
-	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
-	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
-
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork #3");
-	case 0:
-		maxrss_init = ru.ru_maxrss;
-		tst_resm(TINFO, "child allocate +50MB");
-		consume(50);
-		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
-		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
-		exit(is_in_delta(maxrss_init + 51200 - ru.ru_maxrss));
-	default:
-		break;
+		if (!ru.ru_maxrss)
+			tst_res(TPASS, "child.children == 0");
+		else
+			tst_res(TFAIL, "child.children = %li, expected %i",
+				ru.ru_maxrss, 0);
+		exit(0);
 	}
-
-	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
-	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
-		     "initial.self + 50MB !~= child.self");
+	tst_reap_children();
 }

-/* Testcase #04: grandchild maxrss
- * expect: post_wait.children ~= 300MB */
 static void grandchild_maxrss(void)
 {
-	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
-
-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
-
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork #4");
-	case 0:
-		retval = system("getrusage03_child -g 300");
-		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
-			tst_brkm(TBROK | TERRNO, cleanup, "system");
-		exit(0);
-	default:
-		break;
-	}
-
-	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
-	if (WEXITSTATUS(status) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "child exit status is not 0");
+	if (!SAFE_FORK())
+		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
+			    "grand_consume", "300", NULL);
+	tst_reap_children();
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);

-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
 	if (is_in_delta(ru.ru_maxrss - 307200))
-		tst_resm(TPASS, "child.children ~= 300MB");
+		tst_res(TPASS, "child.children ~= 300MB");
 	else
-		tst_resm(TFAIL, "child.children !~= 300MB");
+		tst_res(TFAIL, "child.children = %li, expected %i",
+			ru.ru_maxrss, 307200);
 }

-/* Testcase #05: zombie
- * expect: initial ~= pre_wait, post_wait ~= 400MB */
 static void zombie(void)
 {
-	tst_resm(TINFO, "Testcase #05: zombie");
-
-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 	maxrss_init = ru.ru_maxrss;

-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK, cleanup, "fork #5");
-	case 0:
-		retval = system("getrusage03_child -n 400");
-		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
-			tst_brkm(TBROK | TERRNO, cleanup, "system");
-		exit(0);
-	default:
-		break;
-	}
+	pid_t pid = SAFE_FORK();

-	sleep(1);		/* children become zombie */
-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "pre_wait.children = %ld", ru.ru_maxrss);
+	if (!pid)
+		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
+			    "consume", "400", NULL);
+
+	TST_PROCESS_STATE_WAIT(pid, 'Z', 0);
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 	if (is_in_delta(ru.ru_maxrss - maxrss_init))
-		tst_resm(TPASS, "initial.children ~= pre_wait.children");
+		tst_res(TPASS, "initial.children ~= pre_wait.children");
 	else
-		tst_resm(TFAIL, "initial.children !~= pre_wait.children");
-
-	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
-	if (WEXITSTATUS(status) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "child exit status is not 0");
+		tst_res(TFAIL, "pre_wait.children = %li, expected %li",
+			ru.ru_maxrss, maxrss_init);

-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
+	tst_reap_children();
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 	if (is_in_delta(ru.ru_maxrss - 409600))
-		tst_resm(TPASS, "post_wait.children ~= 400MB");
+		tst_res(TPASS, "post_wait.children ~= 400MB");
 	else
-		tst_resm(TFAIL, "post_wait.children !~= 400MB");
+		tst_res(TFAIL, "post_wait.children = %li, expected %i",
+			ru.ru_maxrss, 409600);
 }

-/* Testcase #06: SIG_IGN
- * expect: initial ~= after_zombie */
 static void sig_ign(void)
 {
-	tst_resm(TINFO, "Testcase #06: SIG_IGN");
-
-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
-	signal(SIGCHLD, SIG_IGN);
+	SAFE_SIGNAL(SIGCHLD, SIG_IGN);
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 	maxrss_init = ru.ru_maxrss;

-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK, cleanup, "fork #6");
-	case 0:
-		retval = system("getrusage03_child -n 500");
-		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
-			tst_brkm(TBROK | TERRNO, cleanup, "system");
-		exit(0);
-	default:
-		break;
-	}
+	pid_t pid = SAFE_FORK();
+
+	if (!pid)
+		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
+			    "consume", "500", NULL);

-	sleep(1);		/* children become zombie */
-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	tst_resm(TINFO, "after_zombie.children = %ld", ru.ru_maxrss);
+	TST_PROCESS_EXIT_WAIT(pid, 0);
+	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 	if (is_in_delta(ru.ru_maxrss - maxrss_init))
-		tst_resm(TPASS, "initial.children ~= after_zombie.children");
+		tst_res(TPASS, "initial.children ~= after_zombie.children");
 	else
-		tst_resm(TFAIL, "initial.children !~= after_zombie.children");
-	signal(SIGCHLD, SIG_DFL);
-}
+		tst_res(TFAIL, "after_zombie.children = %li, expected %li",
+			ru.ru_maxrss, maxrss_init);

-/* Testcase #07: exec without fork
- * expect: initial ~= fork */
-static void exec_without_fork(void)
-{
-	char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
-	long maxrss_self, maxrss_child;
-
-	tst_resm(TINFO, "Testcase #07: exec without fork");
-
-	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
-	maxrss_self = ru.ru_maxrss;
-	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-	maxrss_child = ru.ru_maxrss;
-	tst_resm(TINFO, "initial.self = %ld, initial.children = %ld",
-		 maxrss_self, maxrss_child);
-
-	sprintf(str_maxrss_self, "%ld", maxrss_self);
-	sprintf(str_maxrss_child, "%ld", maxrss_child);
-	if (execlp("getrusage03_child", "getrusage03_child", "-v",
-		   "-s", str_maxrss_self, "-l", str_maxrss_child, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "execlp");
+	SAFE_SIGNAL(SIGCHLD, SIG_DFL);
 }

-static int is_in_delta(long value)
+static void inherit_exec(void)
 {
-	return (value >= -DELTA_MAX && value <= DELTA_MAX);
-}
+	if (!SAFE_FORK()) {
+		char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];

-static void check_return(int status, char *pass_msg, char *fail_msg)
-{
-	switch (status) {
-	case 1:
-		tst_resm(TPASS, "%s", pass_msg);
-		break;
-	case 0:
-		tst_resm(TFAIL, "%s", fail_msg);
-		break;
-	default:
-		tst_resm(TFAIL, "child exit status is %d", status);
-		break;
+		SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
+		sprintf(str_maxrss_self, "%ld", ru.ru_maxrss);
+		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
+		sprintf(str_maxrss_child, "%ld", ru.ru_maxrss);
+
+		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
+			    "compare", str_maxrss_self, str_maxrss_child, NULL);
 	}
+	tst_reap_children();
 }

-static void consume(int mega)
-{
-	size_t sz;
-	void *ptr;
+void (*testfunc_list[])(void) = {
+	inherit_fork1, inherit_fork2, grandchild_maxrss,
+	zombie, sig_ign, inherit_exec
+};

-	sz = mega * 1024 * 1024;
-	ptr = SAFE_MALLOC(cleanup, sz);
-	memset(ptr, 0, sz);
+static void run(unsigned int i)
+{
+	testfunc_list[i]();
 }

 static void setup(void)
 {
-	/* Disable test if the version of the kernel is less than 2.6.32 */
-	if ((tst_kvercmp(2, 6, 32)) < 0) {
-		tst_resm(TCONF, "This ru_maxrss field is not supported");
-		tst_brkm(TCONF, NULL, "before kernel 2.6.32");
-	}
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	consume_mb(100);
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+	.resource_files = resource,
+	.min_kver = "2.6.32",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "1f10206cf8e9"},
+	},
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testfunc_list),
+};
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
new file mode 100644
index 000000000..f1bbe9be5
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2011  Red Hat, Inc.
+ * Copyright (C) 2021 Xie Ziyao <xieziyao@huawei.com>
+ */
+
+#ifndef LTP_GETRUSAGE03_H
+#define LTP_GETRUSAGE03_H
+
+#include "tst_test.h"
+
+#define DELTA_MAX 20480
+
+static void consume_mb(int consume_nr)
+{
+	void *ptr;
+	size_t size;
+	unsigned long vmswap_size;
+
+	size = consume_nr * 1024 * 1024;
+	ptr = SAFE_MALLOC(size);
+	memset(ptr, 0, size);
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmSwap: %lu", &vmswap_size);
+	if (vmswap_size > 0)
+		tst_brk(TBROK, "VmSwap is not zero");
+}
+
+static int is_in_delta(long value)
+{
+	return (value >= -DELTA_MAX && value <= DELTA_MAX);
+}
+
+#endif //LTP_GETRUSAGE03_H
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
index 972c38e4e..e8252084f 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -1,168 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * getrusage03_child.c - a child program executed by getrusage03
- *
  * Copyright (C) 2011  Red Hat, Inc.
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
+ * Copyright (C) 2021 Xie Ziyao <xieziyao@huawei.com>
  */
-#include <sys/types.h>
-#include <sys/resource.h>
-#include <sys/time.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <limits.h>
-
-#include "test.h"
-#include "safe_macros.h"

-char *TCID = "getrusage03_child";
-int TST_TOTAL = 1;
-
-#define DELTA_MAX	10240
+/*\
+ * [Description]
+ *
+ * Child program executed by getrusage03.
+ */

-static int opt_consume, opt_grand, opt_show, opt_self, opt_child;
-static char *consume_str, *grand_consume_str, *self_str, *child_str;
+#define TST_NO_DEFAULT_MAIN

-option_t child_options[] = {
-	{"n:", &opt_consume, &consume_str},
-	{"g:", &opt_grand, &grand_consume_str},
-	{"v", &opt_show, NULL},
-	{"s:", &opt_self, &self_str},
-	{"l:", &opt_child, &child_str},
-	{NULL, NULL, NULL}
-};
+#include <stdlib.h>

-static void usage(void);
-static void consume(int mega);
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
+#include "getrusage03.h"

 int main(int argc, char *argv[])
 {
-	int lc;
+	if (argc < 3)
+		tst_brk(TFAIL, "argc is %d, expected more than two", argc);
+
 	pid_t pid;
-	long maxrss_self, maxrss_children, delta;
-	long consume_nr, grand_consume_nr, self_nr, child_nr;
 	struct rusage ru;
+	long maxrss_self, maxrss_children;
+	long consume_nr, grand_consume_nr, self_nr, child_nr;

-	tst_parse_opts(argc, argv, child_options, usage);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	tst_reinit();

-		if (opt_consume) {
-			consume_nr = SAFE_STRTOL(cleanup,
-						 consume_str, 0, LONG_MAX);
-			tst_resm(TINFO, "child allocate %ldMB", consume_nr);
-			consume(consume_nr);
-		}
+	if (!strcmp(argv[1], "consume")) {
+		consume_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
+		consume_mb(consume_nr);
+	} else if (!strcmp(argv[1], "grand_consume")) {
+		grand_consume_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);

-		if (opt_grand) {
-			grand_consume_nr = SAFE_STRTOL(cleanup,
-						       grand_consume_str, 0,
-						       LONG_MAX);
-			tst_resm(TINFO, "grandchild allocate %ldMB",
-				 grand_consume_nr);
-			switch (pid = fork()) {
-			case -1:
-				tst_brkm(TBROK, cleanup, "fork");
-			case 0:
-				consume(grand_consume_nr);
-				exit(0);
-			default:
-				break;
-			}
-			while (waitpid(-1, &pid, WUNTRACED | WCONTINUED) > 0)
-				if (WEXITSTATUS(pid) != 0)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "child exit status is not 0");
+		pid = fork();
+		if (pid == -1)
+			tst_brk(TBROK, "fork failed");
+		else if (pid == 0) {
+			consume_mb(grand_consume_nr);
+			exit(0);
 		}

-		if (opt_show) {
-			SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
-			maxrss_self = ru.ru_maxrss;
-			SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
-			maxrss_children = ru.ru_maxrss;
-			tst_resm(TINFO, "exec.self = %ld, exec.children = %ld",
-				 maxrss_self, maxrss_children);
-			if (opt_self) {
-				self_nr = SAFE_STRTOL(cleanup,
-						      self_str, 0, LONG_MAX);
-				delta = maxrss_self - self_nr;
-				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
-					tst_resm(TPASS,
-						 "initial.self ~= exec.self");
-				else
-					tst_resm(TFAIL,
-						 "initial.self !~= exec.self");
-			}
-			if (opt_child) {
-				child_nr = SAFE_STRTOL(cleanup,
-						       child_str, 0, LONG_MAX);
-				delta = maxrss_children - child_nr;
-				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
-					tst_resm(TPASS,
-						 "initial.children ~= exec.children");
-				else
-					tst_resm(TFAIL,
-						 "initial.children !~= exec.children");
-			}
-		}
+		tst_reap_children();
+	} else if (!strcmp(argv[1], "compare")) {
+		self_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
+		child_nr = SAFE_STRTOL(argv[3], 0, LONG_MAX);
+
+		SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
+		maxrss_self = ru.ru_maxrss;
+		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
+		maxrss_children = ru.ru_maxrss;
+
+		if (is_in_delta(maxrss_self - self_nr))
+			tst_res(TPASS, "initial.self ~= exec.self");
+		else
+			tst_res(TFAIL, "initial.self !~= exec.self");
+
+		if (is_in_delta(maxrss_children - child_nr))
+			tst_res(TPASS, "initial.children ~= exec.children");
+		else
+			tst_res(TFAIL, "initial.children !~= exec.children");
 	}

-	cleanup();
-	tst_exit();
-}
-
-static void usage(void)
-{
-	printf("  -n NUM  consume NUM MB size\n");
-	printf("  -g NUM  grandchild consume NUM MB size\n");
-	printf("  -v      verbose mode, show rusage info\n");
-	printf("  -s NUM  compare rusage_self.maxrss with given NUM\n");
-	printf("  -l NUM  compare rusage_children.maxrss with given NUM\n");
-}
-
-static void consume(int mega)
-{
-	size_t sz;
-	void *ptr;
-
-	sz = mega * 1024 * 1024;
-	ptr = SAFE_MALLOC(cleanup, sz);
-	memset(ptr, 0, sz);
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
+	return 0;
 }
--
2.17.1

