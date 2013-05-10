Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UajRj-0003Qj-6I
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:16:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UajRT-0004k7-2y
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:16:59 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4A9GbCb026440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 10 May 2013 05:16:37 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 10 May 2013 17:13:59 +0800
Message-Id: <71bc1b8f9f8808c10356d054f400eef1fea52098.1368177082.git.zliu@redhat.com>
In-Reply-To: <25673a6d4dd7b2b6cd5ccf23308706256cd3c49c.1368177082.git.zliu@redhat.com>
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
	<25673a6d4dd7b2b6cd5ccf23308706256cd3c49c.1368177082.git.zliu@redhat.com>
In-Reply-To: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
Subject: [LTP] [PATCH 3/3] mem/ksm06: add a new case to test
	merge_across_nodes sysfs knob
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
To: LTP List <ltp-list@lists.sourceforge.net>

Kernel commit 90bd6fd31c8097(ksm: allow trees per NUMA node)
introduced a new ksm sysfs knob /sys/kernel/mm/ksm/merge_across_nodes,
which makes NUMA awareness KSM.

The case is designed to check whether KSM can merge the same shared
pages distributed on different numa nodes.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                         |   3 +
 testcases/kernel/mem/include/mem.h |   2 +
 testcases/kernel/mem/ksm/ksm06.c   | 136 +++++++++++++++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c     |  77 ++++++++++++++++++++-
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm06.c

diff --git a/runtest/mm b/runtest/mm
index 7c7abf1..a39becd 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -70,6 +70,9 @@ ksm03_1 ksm03 -u 128
 ksm04 ksm04
 ksm04_1 ksm04 -u 128
 ksm05 ksm05 -I 10
+ksm06 ksm06
+ksm06_1 ksm06 -n 10
+ksn06_2 ksm06 -n 10000
 
 cpuset01 cpuset01 -I 3600
 
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index e31783e..342166e 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -46,6 +46,8 @@ void testoom(int mempolicy, int lite);
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
 
+void test_ksm_merge_across_nodes(unsigned long nr_pages);
+
 /* THP */
 
 #define PATH_THP		"/sys/kernel/mm/transparent_hugepage/"
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
new file mode 100644
index 0000000..346a9b4
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2013 Linux Test Project
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
+ */
+
+/*
+ * The case is designed to test new sysfs boolean knob
+ * /sys/kernel/mm/ksm/merge_across_nodes, which was introduced by
+ * commit 90bd6fd31c8097ee (ksm: allow trees per NUMA node).
+ * when merge_across_nodes is set to zero only pages from the same
+ * node are merged, otherwise pages from all nodes can be merged
+ * together.
+ */
+
+#include "config.h"
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <fcntl.h>
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "numa_helper.h"
+#include "test.h"
+#include "safe_macros.h"
+#include "usctest.h"
+#include "mem.h"
+
+char *TCID = "ksm06";
+int TST_TOTAL = 1;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+
+static int run;
+static int sleep_millisecs;
+static int merge_across_nodes;
+static int n_flag;
+static unsigned long nr_pages;
+
+static char *n_opt;
+option_t options[] = {
+	{ "n:", &n_flag, &n_opt },
+	{ NULL, NULL, NULL }
+};
+static void usage(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, &usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PASING ERROR - %s", msg);
+	if (n_flag)
+		nr_pages = SAFE_STRTOUL(NULL, n_opt, 0, ULONG_MAX);
+	else
+		nr_pages = 100;
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		test_ksm_merge_across_nodes(nr_pages);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
+		tst_brkm(TCONF, NULL, "no merge_across_nodes sysfs knob");
+
+	if (!is_numa(NULL))
+		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
+
+	/* save the current value */
+	SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &run);
+	SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+			"%d", &merge_across_nodes);
+	SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
+			"%d", &sleep_millisecs);
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+			 "%d", merge_across_nodes);
+	SAFE_FILE_PRINTF(NULL, PATH_KSM "sleep_millisecs",
+			 "%d", sleep_millisecs);
+	SAFE_FILE_PRINTF(NULL, PATH_KSM "run", "%d", run);
+
+	TEST_CLEANUP;
+}
+
+static void usage(void)
+{
+	printf("  -n x    Allocate x pages memory per node\n");
+}
+
+#else /* no NUMA */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+}
+#endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 1232b4f..7cda3c5 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -96,7 +96,7 @@ static void set_global_mempolicy(int mempolicy)
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
-	unsigned int num_nodes, *nodes;
+	int num_nodes, *nodes;
 	int ret;
 
 	if (mempolicy) {
@@ -467,6 +467,81 @@ void create_same_memory(int size, int num, int unit)
 				 WEXITSTATUS(status));
 }
 
+void test_ksm_merge_across_nodes(unsigned long nr_pages)
+{
+	char **memory;
+	int i, ret;
+	int num_nodes, *nodes;
+	unsigned long length;
+	unsigned long pagesize;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
+
+	ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
+	if (ret != 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes_arr");
+	if (num_nodes < 2) {
+		tst_resm(TINFO, "need NUMA system support");
+		free(nodes);
+		return;
+	}
+
+	pagesize = sysconf(_SC_PAGE_SIZE);
+	length = nr_pages * pagesize;
+
+	memory = (char **)malloc(num_nodes * sizeof(char *));
+	for (i = 0; i < num_nodes; i++) {
+		memory[i] = mmap(NULL, length, PROT_READ|PROT_WRITE,
+			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+		if (memory[i] == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+		if (madvise(memory[i], length, MADV_MERGEABLE) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+		clean_node(nmask);
+		set_node(nmask, nodes[i]);
+		/*
+		 * Use mbind() to make sure each node contains
+		 * length size memory.
+		 */
+		ret = mbind(memory[i], length, MPOL_BIND, nmask, MAXNODES, 0);
+		if (ret == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mbind");
+#endif
+
+		memset(memory[i], 10, length);
+	}
+
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
+			 nr_pages * num_nodes);
+	/*
+	 * merge_across_nodes setting can be changed only when there
+	 * are no ksm shared pages in system, so set run 2 to unmerge
+	 * pages first, then to 1 after changing merge_across_nodes,
+	 * to remerge according to the new setting.
+	 */
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	wait_ksmd_done();
+	tst_resm(TINFO, "Start to test KSM with merge_across_nodes=1");
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "merge_across_nodes", "1");
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
+	group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
+		    nr_pages * num_nodes);
+
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	wait_ksmd_done();
+	tst_resm(TINFO, "Start to test KSM with merge_across_nodes=0");
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "merge_across_nodes", "0");
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
+	group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
+		    0, 0, 0, nr_pages * num_nodes);
+
+	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	wait_ksmd_done();
+}
+
 void check_ksm_options(int *size, int *num, int *unit)
 {
 	if (opt_size) {
-- 
1.7.11.7


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
