Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SAbb8-0003Nr-DA
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 06:34:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAbb7-0007J9-Cf
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 06:34:10 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Thu, 22 Mar 2012 14:35:06 +0800
Message-Id: <87ae50f292bc2e82ecdd1fefe2db0dd41d6026a4.1332395878.git.zliu@redhat.com>
Subject: [LTP]  [PATCH] mm/tunable: add a new testcase min_free_kbytes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

The case is designed to test min_free_kbytes tunable file.

The tune is used to control free memory, and system always
reserve min_free_kbytes memory at least.

Since the tune is not too large or too little, which will
lead to the system hang, so I choose two cases, and test them
on all overcommit_memory policy, at the same time, compare
the current free memory with the tunable value repeatedly.

a) default min_free_kbytes with all overcommit memory policy
b) half of mem_free with all overcommit memory policy

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                                     |    2 +
 testcases/kernel/mem/tunable/min_free_kbytes.c |  222 ++++++++++++++++++++++++
 2 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/tunable/min_free_kbytes.c

I have tested on RHEL6.2, it's fine, log like this:
<<<test_start>>>
tag=min_free_kbytes stime=1332315788
cmdline="min_free_kbytes"
contacts=""
analysis=exit
<<<test_output>>>
min_free_kbytes    0  TINFO  :  set overcommit_memory to 2
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 90112
min_free_kbytes    0  TINFO  :  MemFree is 15397328 kB before eatup mem
min_free_kbytes    0  TINFO  :  MemFree is 151964 kB after eatup mem
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 90112
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 7999962
min_free_kbytes    0  TINFO  :  MemFree is 15999924 kB before eatup mem
min_free_kbytes    0  TINFO  :  MemFree is 8044308 kB after eatup mem
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 90112
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 7999962
min_free_kbytes    0  TINFO  :  set overcommit_memory to 0
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 90112
Child[26301] is killed by SIGKILL signal.
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 8002878
Child[27570] is killed by SIGKILL signal.
min_free_kbytes    0  TINFO  :  set overcommit_memory to 1
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 90112
Child[28782] is killed by SIGKILL signal.
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 8003788
Child[30056] is killed by SIGKILL signal.
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 90112
min_free_kbytes    0  TINFO  :  set overcommit_memory to 0

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
index 0000000..722a56a
--- /dev/null
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -0,0 +1,222 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include "test.h"
+#include "usctest.h"
+#include "../include/mem.h"
+
+#define MAP_SIZE (1UL<<20)
+
+char *TCID = "min_free_kbytes";
+int TST_TOTAL = 1;
+static unsigned long default_tune;
+static unsigned long orig_overcommit;
+static unsigned long total_mem;
+
+static void test_tune(unsigned long overcommit_policy);
+static void eatup_mem();
+static void check_monitor(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR -s %s", msg);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		test_tune(2);
+		test_tune(0);
+		test_tune(1);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void test_tune(unsigned long overcommit_policy)
+{
+	int status;
+	int pid[2];
+	unsigned long tune, memfree;
+
+	set_sys_tune("overcommit_memory", overcommit_policy, 1);
+
+	fflush(stdout);
+	switch (pid[0] = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+
+	case 0:
+		/* startup the check monitor */
+		check_monitor();
+	}
+
+	fflush(stdout);
+	switch (pid[1] = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+
+		/* case1 */
+		set_sys_tune("min_free_kbytes", default_tune, 1);
+		eatup_mem();
+
+		/* case2 */
+		memfree = read_meminfo("MemFree:");
+		tune = memfree / 2;
+		set_sys_tune("min_free_kbytes", tune, 1);
+		eatup_mem();
+
+		exit(0);
+	}
+
+	if (waitpid(pid[1], &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+	/* send SIGKILL to end up check_monitor thread */
+	if (kill(pid[0], SIGKILL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "kill %d", pid[0]);
+	if (waitpid(pid[0], &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup,
+		    "check_monitor thread didn't end up");
+}
+
+static void eatup_mem()
+{
+	int map_count, i;
+	int status, pid;
+	unsigned long memfree;
+	void **addrs;
+
+	map_count = total_mem * KB / MAP_SIZE;
+	addrs = (void **)malloc(map_count * sizeof(void *));
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	case 0:
+		memfree = read_meminfo("MemFree:");
+		tst_resm(TINFO, "MemFree is %lu kB before eatup mem", memfree);
+
+		for (i = 0; i < map_count; i++) {
+			addrs[i] = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
+			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (addrs[i] == MAP_FAILED) {
+				map_count = i - 1;
+				break;
+			}
+
+			memset(addrs[i], i, MAP_SIZE);
+		}
+
+		memfree = read_meminfo("MemFree:");
+		tst_resm(TINFO, "MemFree is %lu kB after eatup mem", memfree);
+
+		for (i = 0; i < map_count; i++)
+			if (munmap(addrs[i], MAP_SIZE) != 0)
+				tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+		free(addrs);
+		exit(0);
+	default:
+		if (waitpid(pid, &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+			if (WIFSIGNALED(status)
+			    && WTERMSIG(status) == SIGKILL)
+				printf("Child[%d] is killed by "
+				    "SIGKILL signal.\n", pid);
+			else
+				tst_resm(TFAIL, "Child[%d] "
+				    "failed unexpectedly", pid);
+		}
+	}
+}
+
+static void check_monitor(void)
+{
+	unsigned long tune;
+	unsigned long memfree;
+
+	while (1) {
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
+void cleanup()
+{
+	set_sys_tune("min_free_kbytes", default_tune, 0);
+	set_sys_tune("overcommit_memory", orig_overcommit, 0);
+
+	TEST_CLEANUP;
+}
-- 
1.7.7.6


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
