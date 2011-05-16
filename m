Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QLzMc-0005cV-K8
	for ltp-list@lists.sourceforge.net; Mon, 16 May 2011 15:05:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QLzMb-0003w9-BI
	for ltp-list@lists.sourceforge.net; Mon, 16 May 2011 15:05:42 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4GF5Zsm016358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 16 May 2011 11:05:35 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 16 May 2011 23:05:28 +0800
Message-Id: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [syscalls] getrusage03: test ru_maxrss
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


getrusage03 - test ru_maxrss behaviors in struct rusage

This test program is backported from upstream commit:
1f10206cf8e945220f7220a809d8bfc15c21f9a5, which fills ru_maxrss
value in struct rusage according to rss hiwater mark. To make sure
this feature works correctly, a series of tests are executed in
this program.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/syscalls                                  |    1 +
 testcases/kernel/syscalls/getrusage/child.c       |  165 ++++++++++
 testcases/kernel/syscalls/getrusage/getrusage03.c |  341 +++++++++++++++++++++
 3 files changed, 507 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/child.c
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.c


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-syscalls-getrusage03-test-ru_maxrss.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-getrusage03-test-ru_maxrss.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 4294d07..7989764 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -399,6 +399,7 @@ get_robust_list01 get_robust_list01
 
 getrusage01 getrusage01
 getrusage02 getrusage02
+getrusage03 getrusage03
 
 getsid01 getsid01
 getsid02 getsid02
diff --git a/testcases/kernel/syscalls/getrusage/child.c b/testcases/kernel/syscalls/getrusage/child.c
new file mode 100644
index 0000000..4f81241
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/child.c
@@ -0,0 +1,165 @@
+/*
+ * child.c - a child program executed by getrusage03
+ *
+ * Copyright (C) 2011  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "child_proc ";
+int TST_TOTAL = 1;
+
+#define DELTA_MAX	10240
+
+static int opt_consume, opt_grand, opt_show, opt_self, opt_child;
+static char *consume_str, *grand_consume_str, *self_str, *child_str;
+
+option_t child_options[] = {
+	{ "n:", &opt_consume, &consume_str },
+	{ "g:", &opt_grand,   &grand_consume_str },
+	{ "v",  &opt_show,    NULL },
+	{ "s:", &opt_self,    &self_str },
+	{ "l:", &opt_child,   &child_str }
+};
+
+static void usage(void);
+static void consume(int mega);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	pid_t pid;
+	long maxrss_self, maxrss_children, delta;
+	struct rusage ru;
+	char *msg;
+
+	msg = parse_opts(argc, argv, child_options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		if (opt_consume) {
+			tst_resm(TINFO, "child allocate %sMB", consume_str);
+			consume(atol(consume_str));
+		}
+
+		if (opt_grand) {
+			tst_resm(TINFO, "grandchild allocate %sMB",
+				grand_consume_str);
+			switch (pid = fork()) {
+			case -1:
+				tst_brkm(TBROK, cleanup, "fork");
+			case 0:
+				consume(atol(grand_consume_str));
+				exit(0);
+			default:
+				break;
+			}
+			while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
+				if (WEXITSTATUS(pid) != 0)
+					tst_brkm(TBROK|TERRNO, cleanup,
+						"child exit status is not 0");
+		}
+
+		if (opt_show) {
+			if (getrusage(RUSAGE_SELF, &ru) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"exec getrusage");
+			maxrss_self = ru.ru_maxrss;
+			if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"exec getrusage");
+			maxrss_children = ru.ru_maxrss;
+			tst_resm(TINFO, "exec.self = %ld, exec.children = %ld",
+					maxrss_self, maxrss_children);
+			if (opt_self) {
+				delta = maxrss_self - atol(self_str);
+				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+					tst_resm(TPASS,
+						"initial.self ~= exec.self");
+				else
+					tst_resm(TFAIL,
+						"initial.self !~= exec.self");
+			}
+			if (opt_child) {
+				delta = maxrss_children - atol(child_str);
+				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+					tst_resm(TPASS,
+						"initial.children ~= exec.children");
+				else
+					tst_resm(TFAIL,
+						"initial.children !~= exec.children");
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void usage(void)
+{
+	printf("  -n      consume size (MB)\n");
+	printf("  -g      grandchild consume size (MB)\n");
+	printf("  -v      verbose mode, show rusage info\n");
+	printf("  -s      compare rusage_self.maxrss with given number\n");
+	printf("  -l      compare rusage_children.maxrss with given number\n");
+}
+
+static void consume(int mega)
+{
+	size_t sz;
+	void *ptr;
+
+	sz  = mega * 1024 * 1024;
+	ptr = malloc(sz);
+	memset(ptr, 0, sz);
+}
+
+static void setup()
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+static void cleanup()
+{
+	TEST_CLEANUP;
+}
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
new file mode 100644
index 0000000..c1d8108
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -0,0 +1,341 @@
+/*
+ * getrusage03 - test ru_maxrss behaviors in struct rusage
+ *
+ * This test program is backported from upstream commit:
+ * 1f10206cf8e945220f7220a809d8bfc15c21f9a5, which fills ru_maxrss
+ * value in struct rusage according to rss hiwater mark. To make sure
+ * this feature works correctly, a series of tests are executed in
+ * this program.
+ *
+ * Copyright (C) 2011  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "getrusage03";
+int TST_TOTAL = 7, Tst_count;
+
+#define DELTA_MAX	10240
+#define ERR(x) perror(x), cleanup(), exit(-1);
+
+static struct rusage ru;
+static long maxrss_init;
+
+static void check_return(int status, char *pass_msg, char *fail_msg);
+static void consume(int mega);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	long delta;
+	int retval;
+	pid_t pid;
+	char *msg;
+	long maxrss_self, maxrss_child;
+	char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		tst_resm(TINFO, "allocate 100MB");
+		consume(100);
+
+		/* Testcase #01: fork inherit
+		 * expect: initial.self ~= child.self */
+		tst_resm(TINFO, "Testcase #01: fork inherit");
+		if (getrusage(RUSAGE_SELF, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #1");
+		tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
+
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
+		case 0:
+			maxrss_init = ru.ru_maxrss;
+			if (getrusage(RUSAGE_SELF, &ru) == -1)
+				ERR("child: getrusage #1");
+			printf("%-8s %4d  TINFO  :  child.self = %ld\n",
+				"child_proc ", 0, ru.ru_maxrss);
+			delta = maxrss_init - ru.ru_maxrss;
+			retval = (delta >= -DELTA_MAX &&
+				delta <= DELTA_MAX) ? 0 : 1;
+			exit(retval);
+		default:
+			break;
+		}
+		while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
+			check_return(WEXITSTATUS(pid),
+				"initial.self ~= child.self",
+				"initial.self !~= child.self");
+
+		/*
+		 * Testcase #02: fork inherit (cont.)
+		 * expect: initial.children ~= 100MB,
+		 *         child.children = 0
+		 */
+		tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #2");
+		tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+		delta = ru.ru_maxrss - 102400;
+		if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+			tst_resm(TPASS, "initial.children ~= 100MB");
+		else
+			tst_resm(TFAIL, "initial.children !~= 100MB");
+
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #2");
+		case 0:
+			if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+				ERR("child: getrusage #2");
+			printf("%-8s %4d  TINFO  :  child.children = %ld\n",
+				"child_proc ", 0, ru.ru_maxrss);
+			retval = (ru.ru_maxrss == 0) ? 0 : 1;
+			exit(retval);
+		default:
+			break;
+		}
+		while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
+			check_return(WEXITSTATUS(pid),
+				"child.children == 0",
+				"child.children != 0");
+
+		/* Testcase #03: fork + malloc
+		 * expect: initial.self + 50MB ~= child.self */
+		tst_resm(TINFO, "Testcase #03: fork + malloc");
+		if (getrusage(RUSAGE_SELF, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #3");
+		tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
+
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #3");
+		case 0:
+			maxrss_init = ru.ru_maxrss;
+			printf("%-8s %4d  TINFO  :  child allocate +50MB\n",
+				"child_proc ", 0);
+			consume(50);
+			if (getrusage(RUSAGE_SELF, &ru) == -1)
+				ERR("child getrusage #3");
+			printf("%-8s %4d  TINFO  :  child.self = %ld\n",
+				"child_proc ", 0, ru.ru_maxrss);
+			delta = maxrss_init + 51200 - ru.ru_maxrss;
+			retval = (delta >= -DELTA_MAX &&
+				delta <= DELTA_MAX) ? 0 : 1;
+			exit(retval);
+		default:
+			break;
+		}
+		while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
+			check_return(WEXITSTATUS(pid),
+				"initial.self + 50MB ~= child.self",
+				"initial.self + 50MB !~= child.self");
+
+		/* Testcase #04: grandchild maxrss
+		 * expect: post_wait.children ~= 300MB */
+		tst_resm(TINFO, "Testcase #04: grandchild maxrss");
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #4");
+		tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #4");
+		case 0:
+			retval = system("./child -g 300");
+			if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
+				ERR("system");
+			exit(0);
+		default:
+			break;
+		}
+		while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
+			if (WEXITSTATUS(pid) != 0)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"child exit status is not 0");
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"post_wait getrusage #4");
+		tst_resm(TINFO, "post_wait.children = %ld",
+			ru.ru_maxrss);
+		delta = ru.ru_maxrss - 307200;
+		if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+			tst_resm(TPASS, "child.children ~= 300MB");
+		else
+			tst_resm(TFAIL, "child.children !~= 300MB");
+
+		/* Testcase #05: zombie
+		 * expect: initial ~= pre_wait, post_wait ~= 400MB */
+		tst_resm(TINFO, "Testcase #05: zombie");
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #5");
+		tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+		maxrss_init = ru.ru_maxrss;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK, cleanup, "fork #5");
+		case 0:
+			retval = system("./child -n 400");
+			if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
+				ERR("system");
+			exit(0);
+		default:
+			break;
+		}
+		sleep(1); /* children become zombie */
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"pre_wait getrusage #5");
+		tst_resm(TINFO, "pre_wait.children = %ld", ru.ru_maxrss);
+		delta = ru.ru_maxrss - maxrss_init;
+		if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+			tst_resm(TPASS,
+				"initial.children ~= pre_wait.children");
+		else
+			tst_resm(TFAIL,
+				"initial.children !~= pre_wait.children");
+		while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
+			if (WEXITSTATUS(pid) != 0)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"child exit status is not 0");
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"post_wait getrusage #5");
+		tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
+		delta = ru.ru_maxrss - 409600;
+		if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+			tst_resm(TPASS, "post_wait.children ~= 400MB");
+		else
+			tst_resm(TFAIL, "post_wait.children !~= 400MB");
+
+		/* Testcase #06: SIG_IGN
+		 * expect: initial ~= after_zombie */
+		tst_resm(TINFO, "Testcase #06: SIG_IGN");
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #6");
+		tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+		signal(SIGCHLD, SIG_IGN);
+		maxrss_init = ru.ru_maxrss;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK, cleanup, "fork #6");
+		case 0:
+			retval = system("./child -n 500");
+			if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
+				ERR("system");
+			exit(0);
+		default:
+			break;
+		}
+		sleep(1); /* children become zombie */
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"after_zombie getrusage #6");
+		tst_resm(TINFO, "after_zombie.children = %ld",
+			ru.ru_maxrss);
+		delta = ru.ru_maxrss - maxrss_init;
+		if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+			tst_resm(TPASS,
+				"initial.children ~= after_zombie.children");
+		else
+			tst_resm(TFAIL,
+				"initial.children !~= after_zombie.children");
+		signal(SIGCHLD, SIG_DFL);
+
+		/* Testcase #07: exec without fork
+		 * expect: initial ~= fork */
+		tst_resm(TINFO, "Testcase #07: exec without fork");
+		if (getrusage(RUSAGE_SELF, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #7");
+		maxrss_self = ru.ru_maxrss;
+		if (getrusage(RUSAGE_CHILDREN, &ru) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "getrusage #7");
+		maxrss_child = ru.ru_maxrss;
+		tst_resm(TINFO, "initial.self = %ld, initial.children = %ld",
+				maxrss_self, maxrss_child);
+		sprintf(str_maxrss_self, "%ld", maxrss_self);
+		sprintf(str_maxrss_child, "%ld", maxrss_child);
+		if (execl("./child", "child", "-v",
+				"-s", str_maxrss_self,
+				"-l", str_maxrss_child, NULL) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "execl");
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void check_return(int status, char *pass_msg, char *fail_msg)
+{
+	switch (status) {
+	case 0:
+		tst_resm(TPASS, "%s", pass_msg);
+		break;
+	case 1:
+		tst_resm(TFAIL, "%s", fail_msg);
+		break;
+	default:
+		tst_resm(TFAIL, "child exit status is %d", status);
+		break;
+	}
+}
+
+static void consume(int mega)
+{
+	size_t sz;
+	void *ptr;
+
+	sz  = mega * 1024 * 1024;
+	ptr = malloc(sz);
+	memset(ptr, 0, sz);
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



