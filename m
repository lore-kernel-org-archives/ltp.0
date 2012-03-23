Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SB5Eh-0001P0-HI
	for ltp-list@lists.sourceforge.net; Fri, 23 Mar 2012 14:12:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SB5Ed-0000eX-FO
	for ltp-list@lists.sourceforge.net; Fri, 23 Mar 2012 14:12:59 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 23 Mar 2012 22:12:38 +0800
Message-Id: <5d69c51b5c6d10f19b2b49332418ae6771e34a3f.1332511710.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.6"
Subject: [LTP]  [PATCH v2] mm/tunable: add a new testcase min_free_kbytes
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
--------------1.7.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The tune is used to control free memory, and system always
reserve > min_free_kbytes memory at least.

Since the tune is not too large or too little, which will
lead to the system hang, so I choose two cases, and test them
on all overcommit_memory policy (0, 1, 2), at the same time,
compare the current free memory with the tunable value
repeatedly.

a) default min_free_kbytes with all overcommit memory policy
b) half of mem_free with all overcommit memory policy

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                                     |    2 +
 testcases/kernel/mem/tunable/min_free_kbytes.c |  237 ++++++++++++++++++++++++
 2 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/tunable/min_free_kbytes.c

thanks caspar's suggestions, I updated the patch.
v1 -> v2:
   1) using sig_handler to control the check_monitor thread,
   2) moved tst_* funcs in child,
   3) catch the return value in eatup_mem().

--------------1.7.7.6
Content-Type: text/x-patch;
	name="0001-mm-tunable-add-a-new-testcase-min_free_kbytes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-tunable-add-a-new-testcase-min_free_kbytes.patch"

diff --git a/runtest/mm b/runtest/mm
index be3b342..2dd66f0 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -98,3 +98,5 @@ overcommit_memory overcommit_memory -R 100
 overcommit_memory overcommit_memory -R 200
 
 max_map_count max_map_count -i 10
+
+min_free_kbytes min_free_kbytes
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
new file mode 100644
index 0000000..a69e129
--- /dev/null
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -0,0 +1,237 @@
+/*
+ * The case is designed to test min_free_kbytes tunable.
+ *
+ * The tune is used to control free memory, and system always
+ * reserve min_free_kbytes memory at least.
+ *
+ * Since the tune is not too large or too little, which will
+ * lead to the system hang, so I choose two cases, and test them
+ * on all overcommit_memory policy, at the same time, compare
+ * the current free memory with the tunable value repeatedly.
+ *
+ * a) default min_free_kbytes with all overcommit memory policy
+ * b) half of mem_free with all overcommit memory policy
+ *
+ ********************************************************************
+ * Copyright (C) 2012 Red Hat, Inc.
+ *
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
+ *
+ * ********************************************************************
+ */
+
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "test.h"
+#include "usctest.h"
+#include "mem.h"
+
+#define MAP_SIZE (1UL<<20)
+
+volatile int end;
+char *TCID = "min_free_kbytes";
+int TST_TOTAL = 1;
+static unsigned long default_tune;
+static unsigned long orig_overcommit;
+static unsigned long total_mem;
+
+static void test_tune(unsigned long overcommit_policy);
+static int eatup_mem(unsigned long overcommit_policy);
+static void check_monitor(void);
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, pid, status;
+	struct sigaction sa;
+
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "sigemptyset");
+	sa.sa_flags = 0;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "sigaction");
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR -s %s", msg);
+	setup();
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+
+	case 0:
+		/* startup the check monitor */
+		check_monitor();
+		exit(0);
+	}
+
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		test_tune(2);
+		test_tune(0);
+		test_tune(1);
+	}
+
+
+	if (kill(pid, SIGUSR1) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "kill %d", pid);
+	if (waitpid(pid, &status, WUNTRACED|WCONTINUED)  == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL,
+		    "check_monitor child exit with status: %d", status);
+
+	cleanup();
+	tst_exit();
+}
+
+static void test_tune(unsigned long overcommit_policy)
+{
+	int status;
+	int pid[2];
+	int ret, i;
+	unsigned long tune, memfree;
+
+	set_sys_tune("overcommit_memory", overcommit_policy, 1);
+
+	for (i = 0; i < 2; i++) {
+		/* case1 */
+		if (i == 0)
+			set_sys_tune("min_free_kbytes", default_tune, 1);
+		/* case2 */
+		else {
+			memfree = read_meminfo("MemFree:");
+			tune = memfree / 2;
+			set_sys_tune("min_free_kbytes", tune, 1);
+		}
+
+		fflush(stdout);
+		switch (pid[i] = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			ret = eatup_mem(overcommit_policy);
+			exit(ret);
+		}
+
+		if (waitpid(pid[i], &status, WUNTRACED|WCONTINUED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+		if (overcommit_policy == 2) {
+			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+				tst_resm(TFAIL,
+				    "child unexpectedly failed: %d", status);
+		} else {
+			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+				tst_resm(TFAIL,
+				    "child unexpectedly failed: %d", status);
+		}
+	}
+}
+
+static int eatup_mem(unsigned long overcommit_policy)
+{
+	int map_count, i;
+	int ret = 0;
+	unsigned long memfree;
+	void **addrs;
+
+	map_count = total_mem * KB / MAP_SIZE;
+	addrs = (void **)malloc(map_count * sizeof(void *));
+	if (addrs == NULL) {
+		perror("malloc");
+		return -1;
+	}
+
+	memfree = read_meminfo("MemFree:");
+	printf("memfree is %lu kB before eatup mem\n", memfree);
+	for (i = 0; i < map_count; i++) {
+		addrs[i] = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
+		    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+		if (addrs[i] == MAP_FAILED) {
+			if (overcommit_policy != 2 || errno != ENOMEM) {
+				perror("mmap");
+				ret = -1;
+			}
+			break;
+		}
+		memset(addrs[i], i, MAP_SIZE);
+	}
+	memfree = read_meminfo("MemFree:");
+	printf("memfree is %lu kB after eatup mem\n", memfree);
+
+	return ret;
+}
+
+static void check_monitor(void)
+{
+	unsigned long tune;
+	unsigned long memfree;
+
+	while (end) {
+		memfree = read_meminfo("MemFree:");
+		tune = get_sys_tune("min_free_kbytes");
+
+		if (memfree < tune) {
+			tst_resm(TINFO, "MemFree is %lu kB, "
+			    "min_free_kbytes is %lu kB", memfree, tune);
+			tst_resm(TFAIL, "MemFree < min_free_kbytes");
+		}
+
+		sleep(2);
+	}
+}
+
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
+{
+	end = 1;
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	total_mem = read_meminfo("MemTotal:") + read_meminfo("SwapTotal:");
+
+	default_tune = get_sys_tune("min_free_kbytes");
+	orig_overcommit = get_sys_tune("overcommit_memory");
+}
+
+void cleanup(void)
+{
+	set_sys_tune("min_free_kbytes", default_tune, 0);
+	set_sys_tune("overcommit_memory", orig_overcommit, 0);
+
+	TEST_CLEANUP;
+}

--------------1.7.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--------------1.7.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7.6--



