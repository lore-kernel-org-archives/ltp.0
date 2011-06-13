Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QW6xJ-0007yq-5c
	for ltp-list@lists.sourceforge.net; Mon, 13 Jun 2011 13:13:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QW6xD-0001fY-0Y
	for ltp-list@lists.sourceforge.net; Mon, 13 Jun 2011 13:13:25 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p5DDD8t9030894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jun 2011 09:13:11 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 13 Jun 2011 21:12:38 +0800
Message-Id: <ef44f6feaa6d46350761dae93d997c3f6a3a7e9e.1307968048.git.czhang@redhat.com>
In-Reply-To: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
References: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.5.3"
Subject: [LTP] [PATCH v2] [syscalls] getrusage03: test ru_maxrss
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
--------------1.7.5.3
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
 include/safe_macros.h                              |    5 +
 lib/safe_macros.c                                  |   15 +
 runtest/syscalls                                   |    1 +
 testcases/kernel/syscalls/getrusage/getrusage03.c  |  359 ++++++++++++++++++++
 .../kernel/syscalls/getrusage/getrusage03_child.c  |  183 ++++++++++
 5 files changed, 563 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.c
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03_child.c


--------------1.7.5.3
Content-Type: text/x-patch;
	name="0001-syscalls-getrusage03-test-ru_maxrss.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-getrusage03-test-ru_maxrss.patch"

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 7c99c66..3753b7f 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -58,6 +58,11 @@ struct passwd*	safe_getpwnam(const char *file, const int lineno,
 #define SAFE_GETPWNAM(cleanup_fn, name)	\
 	safe_getpwnam(__FILE__, __LINE__, cleanup_fn, (name))
 
+int     safe_getrusage(const char *file, const int lineno,
+	    void (*cleanup_fn)(void), int who, struct rusage *usage);
+#define SAFE_GETRUSAGE(cleanup_fn, who, usage) \
+	safe_getrusage(__FILE__, __LINE__, (cleanup_fn), (who), (usage))
+
 void*	safe_malloc(const char *file, const int lineno,
 	    void (*cleanup_fn)(void), size_t size);
 #define SAFE_MALLOC(cleanup_fn, size)	\
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index c98376d..11f5fe6 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1,5 +1,6 @@
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <sys/resource.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <libgen.h>
@@ -108,6 +109,20 @@ safe_getpwnam(const char *file, const int lineno, void (*cleanup_fn)(void),
 	return (rval);
 }
 
+int
+safe_getrusage(const char *file, const int lineno, void (*cleanup_fn)(void),
+	    int who, struct rusage *usage)
+{
+	int rval;
+
+	rval = getrusage(who, usage);
+	if (rval == -1)
+		tst_brkm(TBROK|TERRNO, cleanup_fn, "getrusage failed at %s:%d",
+		    file, lineno);
+
+	return rval;
+}
+
 void*
 safe_malloc(const char *file, const int lineno, void (*cleanup_fn)(void),
     size_t size)
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
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
new file mode 100644
index 0000000..79c7508
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -0,0 +1,359 @@
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
+#include "safe_macros.h"
+
+char *TCID = "getrusage03";
+int TST_TOTAL = 1;
+
+#define DELTA_MAX	10240
+
+static struct rusage ru;
+static long maxrss_init;
+static int retval, status;
+static pid_t pid;
+
+static void inherit_fork(void);
+static void inherit_fork2(void);
+static void fork_malloc(void);
+static void grandchild_maxrss(void);
+static void zombie(void);
+static void sig_ign(void);
+static void exec_without_fork(void);
+static void check_return(int status, char *pass_msg, char *fail_msg);
+static int is_in_delta(long value);
+static void consume(int mega);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
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
+		inherit_fork();
+		inherit_fork2();
+		fork_malloc();
+		grandchild_maxrss();
+		zombie();
+		sig_ign();
+		exec_without_fork();
+	}
+	cleanup();
+	tst_exit();
+}
+
+/* Testcase #01: fork inherit
+ * expect: initial.self ~= child.self */
+static void inherit_fork(void)
+{
+	tst_resm(TINFO, "Testcase #01: fork inherit");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
+	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
+	case 0:
+		maxrss_init = ru.ru_maxrss;
+		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
+		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
+		exit(is_in_delta(maxrss_init - ru.ru_maxrss));
+	default:
+		break;
+	}
+
+	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	check_return(WEXITSTATUS(status), "initial.self ~= child.self",
+		    "initial.self !~= child.self");
+}
+
+/* Testcase #02: fork inherit (cont.)
+ * expect: initial.children ~= 100MB, child.children = 0 */
+static void inherit_fork2(void)
+{
+	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+	if (is_in_delta(ru.ru_maxrss - 102400) == 0)
+		tst_resm(TPASS, "initial.children ~= 100MB");
+	else
+		tst_resm(TFAIL, "initial.children !~= 100MB");
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork #2");
+	case 0:
+		SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+		tst_resm(TINFO, "child.children = %ld", ru.ru_maxrss);
+		exit((ru.ru_maxrss == 0) ? 0 : 1);
+	default:
+		break;
+	}
+
+	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	check_return(WEXITSTATUS(status), "child.children == 0",
+		    "child.children != 0");
+}
+
+/* Testcase #03: fork + malloc
+ * expect: initial.self + 50MB ~= child.self */
+static void fork_malloc(void)
+{
+	tst_resm(TINFO, "Testcase #03: fork + malloc");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
+	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork #3");
+	case 0:
+		maxrss_init = ru.ru_maxrss;
+		tst_resm(TINFO, "child allocate +50MB");
+		consume(50);
+		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
+		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
+		exit(is_in_delta(maxrss_init + 51200 - ru.ru_maxrss));
+	default:
+		break;
+	}
+
+	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
+		    "initial.self + 50MB !~= child.self");
+}
+
+/* Testcase #04: grandchild maxrss
+ * expect: post_wait.children ~= 300MB */
+static void grandchild_maxrss(void)
+{
+	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork #4");
+	case 0:
+		retval = system("getrusage03_child -g 300");
+		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
+			tst_brkm(TBROK|TERRNO, cleanup, "system");
+		exit(0);
+	default:
+		break;
+	}
+
+	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (WEXITSTATUS(status) != 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "child exit status is not 0");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
+	if (is_in_delta(ru.ru_maxrss - 307200) == 0)
+		tst_resm(TPASS, "child.children ~= 300MB");
+	else
+		tst_resm(TFAIL, "child.children !~= 300MB");
+}
+
+/* Testcase #05: zombie
+ * expect: initial ~= pre_wait, post_wait ~= 400MB */
+static void zombie(void)
+{
+	tst_resm(TINFO, "Testcase #05: zombie");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+	maxrss_init = ru.ru_maxrss;
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK, cleanup, "fork #5");
+	case 0:
+		retval = system("getrusage03_child -n 400");
+		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
+			tst_brkm(TBROK|TERRNO, cleanup, "system");
+		exit(0);
+	default:
+		break;
+	}
+
+	sleep(1); /* children become zombie */
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "pre_wait.children = %ld", ru.ru_maxrss);
+	if (is_in_delta(ru.ru_maxrss - maxrss_init) == 0)
+		tst_resm(TPASS, "initial.children ~= pre_wait.children");
+	else
+		tst_resm(TFAIL, "initial.children !~= pre_wait.children");
+
+	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (WEXITSTATUS(status) != 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "child exit status is not 0");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
+	if (is_in_delta(ru.ru_maxrss - 409600) == 0)
+		tst_resm(TPASS, "post_wait.children ~= 400MB");
+	else
+		tst_resm(TFAIL, "post_wait.children !~= 400MB");
+}
+
+/* Testcase #06: SIG_IGN
+ * expect: initial ~= after_zombie */
+static void sig_ign(void)
+{
+	tst_resm(TINFO, "Testcase #06: SIG_IGN");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
+	signal(SIGCHLD, SIG_IGN);
+	maxrss_init = ru.ru_maxrss;
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK, cleanup, "fork #6");
+	case 0:
+		retval = system("getrusage03_child -n 500");
+		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
+			tst_brkm(TBROK|TERRNO, cleanup, "system");
+		exit(0);
+	default:
+		break;
+	}
+
+	sleep(1); /* children become zombie */
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	tst_resm(TINFO, "after_zombie.children = %ld", ru.ru_maxrss);
+	if (is_in_delta(ru.ru_maxrss - maxrss_init) == 0)
+		tst_resm(TPASS, "initial.children ~= after_zombie.children");
+	else
+		tst_resm(TFAIL, "initial.children !~= after_zombie.children");
+	signal(SIGCHLD, SIG_DFL);
+}
+
+/* Testcase #07: exec without fork
+ * expect: initial ~= fork */
+static void exec_without_fork(void)
+{
+	char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
+	long maxrss_self, maxrss_child;
+
+	tst_resm(TINFO, "Testcase #07: exec without fork");
+
+	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
+	maxrss_self = ru.ru_maxrss;
+	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+	maxrss_child = ru.ru_maxrss;
+	tst_resm(TINFO, "initial.self = %ld, initial.children = %ld",
+		    maxrss_self, maxrss_child);
+
+	sprintf(str_maxrss_self, "%ld", maxrss_self);
+	sprintf(str_maxrss_child, "%ld", maxrss_child);
+	if (execlp("getrusage03_child", "getrusage03_child", "-v",
+		    "-s", str_maxrss_self,
+		    "-l", str_maxrss_child, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "execlp");
+}
+
+static int is_in_delta(long value)
+{
+	return ((value >= -DELTA_MAX && value <= DELTA_MAX) ? 0 : 1);
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
+	ptr = SAFE_MALLOC(cleanup, sz);
+	if (memset(ptr, 0, sz) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "memset");
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
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
new file mode 100644
index 0000000..6127fd2
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -0,0 +1,183 @@
+/*
+ * getrusage03_child.c - a child program executed by getrusage03
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
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "getrusage03_child";
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
+static long get_long(const char *str);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	pid_t pid;
+	long maxrss_self, maxrss_children, delta;
+	long consume_nr, grand_consume_nr, self_nr, child_nr;
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
+			consume_nr = get_long(consume_str);
+			tst_resm(TINFO, "child allocate %ldMB", consume_nr);
+			consume(consume_nr);
+		}
+
+		if (opt_grand) {
+			grand_consume_nr = get_long(grand_consume_str);
+			tst_resm(TINFO, "grandchild allocate %ldMB",
+				    grand_consume_nr);
+			switch (pid = fork()) {
+			case -1:
+				tst_brkm(TBROK, cleanup, "fork");
+			case 0:
+				consume(grand_consume_nr);
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
+			SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
+			maxrss_self = ru.ru_maxrss;
+			SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
+			maxrss_children = ru.ru_maxrss;
+			tst_resm(TINFO, "exec.self = %ld, exec.children = %ld",
+				    maxrss_self, maxrss_children);
+			if (opt_self) {
+				self_nr = get_long(self_str);
+				delta = maxrss_self - self_nr;
+				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
+					tst_resm(TPASS,
+						"initial.self ~= exec.self");
+				else
+					tst_resm(TFAIL,
+						"initial.self !~= exec.self");
+			}
+			if (opt_child) {
+				child_nr = get_long(child_str);
+				delta = maxrss_children - child_nr;
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
+	printf("  -n NUM  consume NUM MB size\n");
+	printf("  -g NUM  grandchild consume NUM MB size\n");
+	printf("  -v      verbose mode, show rusage info\n");
+	printf("  -s NUM  compare rusage_self.maxrss with given NUM\n");
+	printf("  -l NUM  compare rusage_children.maxrss with given NUM\n");
+}
+
+static void consume(int mega)
+{
+	size_t sz;
+	void *ptr;
+
+	sz  = mega * 1024 * 1024;
+	ptr = SAFE_MALLOC(cleanup, sz);
+	if (memset(ptr, 0, sz) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "memset");
+}
+
+static long get_long(const char *str)
+{
+	long val;
+	char *endptr;
+
+	val = strtol(str, &endptr, 10);
+	if (((val == LONG_MAX || val == LONG_MIN) && errno == ERANGE) ||
+		    (errno != 0 && val == 0))
+		tst_brkm(TBROK|TERRNO, cleanup, "strtol");
+	if (endptr == str)
+		tst_brkm(TBROK, cleanup, "No digits were found.");
+
+	return val;
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

--------------1.7.5.3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
--------------1.7.5.3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.5.3--



