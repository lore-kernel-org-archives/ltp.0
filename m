From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jul 2017 16:23:01 +0800
Subject: [LTP] [PATCH v3 04/15] mem/ksm: convert to new API
In-Reply-To: <20170718082312.3946-1-liwang@redhat.com>
References: <20170718082312.3946-1-liwang@redhat.com>
Message-ID: <20170718082312.3946-5-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Recast ksm_options structure to support parameter transfer.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h |   9 ++-
 testcases/kernel/mem/ksm/ksm01.c   |  88 ++++++++++---------------
 testcases/kernel/mem/ksm/ksm02.c   | 123 ++++++++++++++---------------------
 testcases/kernel/mem/ksm/ksm03.c   |  90 ++++++++++---------------
 testcases/kernel/mem/ksm/ksm04.c   | 121 ++++++++++++++--------------------
 testcases/kernel/mem/ksm/ksm05.c   | 130 +++++++++++++++----------------------
 testcases/kernel/mem/ksm/ksm06.c   | 105 ++++++++++--------------------
 testcases/kernel/mem/lib/mem.c     |  16 ++---
 8 files changed, 266 insertions(+), 416 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 377cc55..bada549 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -44,6 +44,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
 
+char *opt_numstr, *opt_sizestr, *opt_unitstr;
+
+void create_same_memory(int size, int num, int unit);
+void check_ksm_options(int *size, int *num, int *unit);
 void save_max_page_sharing(void);
 void restore_max_page_sharing(void);
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
@@ -58,11 +62,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages);
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
 
 void write_memcg(void);
-void create_same_memory(int size, int num, int unit);
-int  opt_num, opt_size, opt_unit;
-char *opt_numstr, *opt_sizestr, *opt_unitstr;
-void check_ksm_options(int *size, int *num, int *unit);
-void ksm_usage(void);
 
 /* cpuset/memcg */
 
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 824881c..849d4d4 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -1,4 +1,16 @@
 /*
+ * Copyright (C) 2010-2017  Red Hat, Inc.
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
  * Kernel Samepage Merging (KSM)
  *
  * Basic tests were to start several programs with same and different
@@ -31,28 +43,6 @@
  * - Change run setting to 2 - unmerging.
  * - Check ksm statistics and verify the content.
  * - Change run setting to 0 - stop.
- *
- * Copyright (C) 2010  Red Hat, Inc.
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
  */
 
 #include <sys/types.h>
@@ -66,45 +56,29 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "ksm01";
-int TST_TOTAL = 1;
-
 static int merge_across_nodes;
 
-option_t ksm_options[] = {
-	{"n:", &opt_num, &opt_numstr},
-	{"s:", &opt_size, &opt_sizestr},
-	{"u:", &opt_unit, &opt_unitstr},
+static struct tst_option ksm_options[] = {
+	{"n:", &opt_numstr,  "-n       Number of processes"},
+	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
+	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
 	{NULL, NULL, NULL}
 };
 
-int main(int argc, char *argv[])
+static void verify_ksm(void)
 {
-	int lc;
 	int size = 128, num = 3, unit = 1;
 
-	tst_parse_opts(argc, argv, ksm_options, ksm_usage);
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		check_ksm_options(&size, &num, &unit);
-		create_same_memory(size, num, unit);
-	}
-	cleanup();
-	tst_exit();
+	check_ksm_options(&size, &num, &unit);
+	create_same_memory(size, num, unit);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+		tst_brk(TCONF, "KSM configuration is not enabled");
 
 	save_max_page_sharing();
 
@@ -116,16 +90,13 @@ void setup(void)
 	 * it is enabled before testing.
 	 */
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
 				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
-
-	tst_sig(FORK, DEF_HANDLER, NULL);
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
@@ -133,3 +104,14 @@ void cleanup(void)
 
 	restore_max_page_sharing();
 }
+
+static struct tst_test test = {
+	.tid = "ksm01",
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = ksm_options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ksm,
+	.min_kver = "2.6.32",
+};
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 6274f8a..eeebfef 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -1,5 +1,17 @@
 /*
- * Kernel Samepage Merging (KSM) for NUMA
+ * Copyright (C) 2010-2017  Red Hat, Inc.
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
+ * Kernel Samepage Merging (KSM)
  *
  * Basic tests were to start several programs with same and different
  * memory contents and ensure only to merge the ones with the same
@@ -31,28 +43,6 @@
  * - Change run setting to 2 - unmerging.
  * - Check ksm statistics and verify the content.
  * - Change run setting to 0 - stop.
- *
- * Copyright (C) 2010  Red Hat, Inc.
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
  */
 
 #include "config.h"
@@ -66,60 +56,45 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "ksm02";
-int TST_TOTAL = 1;
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
 
 static int merge_across_nodes;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-option_t ksm_options[] = {
-	{"n:", &opt_num, &opt_numstr},
-	{"s:", &opt_size, &opt_sizestr},
-	{"u:", &opt_unit, &opt_unitstr},
+static struct tst_option ksm_options[] = {
+	{"n:", &opt_numstr,  "-n       Number of processes"},
+	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
+	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
 	{NULL, NULL, NULL}
 };
 
-int main(int argc, char *argv[])
+static void verify_ksm(void)
 {
-	int lc;
 	int size = 128, num = 3, unit = 1;
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
-	tst_parse_opts(argc, argv, ksm_options, ksm_usage);
-
-	node = get_a_numa_node(tst_exit);
+	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		check_ksm_options(&size, &num, &unit);
-
-		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
-			if (errno != ENOSYS)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "set_mempolicy");
-			else
-				tst_brkm(TCONF, cleanup,
-					 "set_mempolicy syscall is not "
-					 "implemented on your system.");
-		}
-		create_same_memory(size, num, unit);
-
-		write_cpusets(node);
-		create_same_memory(size, num, unit);
+	check_ksm_options(&size, &num, &unit);
+
+	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
+		if (errno != ENOSYS)
+			tst_brk(TBROK | TERRNO, "set_mempolicy");
+		else
+			tst_brk(TCONF, "set_mempolicy syscall is not "
+				 "implemented on your system.");
 	}
-	cleanup();
-	tst_exit();
+	create_same_memory(size, num, unit);
+
+	write_cpusets(node);
+	create_same_memory(size, num, unit);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
@@ -130,30 +105,32 @@ void cleanup(void)
 	umount_mem(CPATH, CPATH_NEW);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+		tst_brk(TCONF, "KSM configuration is not enabled");
 	save_max_page_sharing();
 
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
 				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
 }
 
+static struct tst_test test = {
+	.tid = "ksm02",
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = ksm_options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ksm,
+	.min_kver = "2.6.32",
+};
+
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 979222a..9fd5aac 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -1,4 +1,16 @@
 /*
+ * Copyright (C) 2010-2017  Red Hat, Inc.
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
  * Kernel Samepage Merging (KSM) for Memory Resource Controller
  *
  * Basic tests were to start several programs with same and different
@@ -31,28 +43,6 @@
  * - Change run setting to 2 - unmerging.
  * - Check ksm statistics and verify the content.
  * - Change run setting to 0 - stop.
- *
- * Copyright (C) 2010  Red Hat, Inc.
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
  */
 
 #include <sys/types.h>
@@ -66,61 +56,42 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "ksm03";
-int TST_TOTAL = 1;
-
 static int merge_across_nodes;
 
-option_t ksm_options[] = {
-	{"n:", &opt_num, &opt_numstr},
-	{"s:", &opt_size, &opt_sizestr},
-	{"u:", &opt_unit, &opt_unitstr},
+static struct tst_option ksm_options[] = {
+	{"n:", &opt_numstr,  "-n       Number of processes"},
+	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
+	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
 	{NULL, NULL, NULL}
 };
 
-int main(int argc, char *argv[])
+static void verify_ksm(void)
 {
-	int lc;
 	int size = 128, num = 3, unit = 1;
 
-	tst_parse_opts(argc, argv, ksm_options, ksm_usage);
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		check_ksm_options(&size, &num, &unit);
-		write_memcg();
-		create_same_memory(size, num, unit);
-	}
-	cleanup();
-	tst_exit();
+	check_ksm_options(&size, &num, &unit);
+	write_memcg();
+	create_same_memory(size, num, unit);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+		tst_brk(TCONF, "KSM configuration is not enabled");
 
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
 				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
 	save_max_page_sharing();
-
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	tst_sig(FORK, DEF_HANDLER, NULL);
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
@@ -130,3 +101,14 @@ void cleanup(void)
 
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
+
+static struct tst_test test = {
+	.tid = "ksm03",
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = ksm_options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ksm,
+	.min_kver = "2.6.32",
+};
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 4beeed6..29a5e2b 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -1,4 +1,16 @@
 /*
+ * Copyright (C) 2010-2017  Red Hat, Inc.
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
  * Kernel Samepage Merging (KSM) for Memory Resource Controller and NUMA
  *
  * Basic tests were to start several programs with same and different
@@ -31,28 +43,6 @@
  * - Change run setting to 2 - unmerging.
  * - Check ksm statistics and verify the content.
  * - Change run setting to 0 - stop.
- *
- * Copyright (C) 2010  Red Hat, Inc.
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
  */
 
 #include "config.h"
@@ -66,62 +56,47 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "ksm04";
-int TST_TOTAL = 1;
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
 
 static int merge_across_nodes;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-option_t ksm_options[] = {
-	{"n:", &opt_num, &opt_numstr},
-	{"s:", &opt_size, &opt_sizestr},
-	{"u:", &opt_unit, &opt_unitstr},
+static struct tst_option ksm_options[] = {
+	{"n:", &opt_numstr,  "-n       Number of processes"},
+	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
+	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
 	{NULL, NULL, NULL}
 };
 
-int main(int argc, char *argv[])
+static void verify_ksm(void)
 {
-	int lc;
 	int size = 128, num = 3, unit = 1;
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
-	tst_parse_opts(argc, argv, ksm_options, ksm_usage);
-
-	node = get_a_numa_node(tst_exit);
+	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		check_ksm_options(&size, &num, &unit);
+	check_ksm_options(&size, &num, &unit);
 
-		write_memcg();
+	write_memcg();
 
-		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
-			if (errno != ENOSYS)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "set_mempolicy");
-			else
-				tst_brkm(TCONF, cleanup,
-					 "set_mempolicy syscall is not "
-					 "implemented on your system.");
-		}
-		create_same_memory(size, num, unit);
-
-		write_cpusets(node);
-		create_same_memory(size, num, unit);
+	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
+		if (errno != ENOSYS)
+			tst_brk(TBROK | TERRNO, "set_mempolicy");
+		else
+			tst_brk(TCONF, "set_mempolicy syscall is not "
+					"implemented on your system.");
 	}
-	cleanup();
-	tst_exit();
+	create_same_memory(size, num, unit);
+
+	write_cpusets(node);
+	create_same_memory(size, num, unit);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
@@ -133,32 +108,34 @@ void cleanup(void)
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
 	if (access(PATH_KSM, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
+		tst_brk(TCONF, "KSM configuration is not enabled");
 
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
 				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
 	save_max_page_sharing();
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
+static struct tst_test test = {
+	.tid = "ksm04",
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = ksm_options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ksm,
+	.min_kver = "2.6.32",
+};
+
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 59b2683..59c8f4b 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -1,4 +1,16 @@
 /*
+ * Copyright (C) 2011-2017  Red Hat, Inc.
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
  * KSM - NULL pointer dereference in ksm_do_scan() (CVE-2011-2183)
  *
  * This is a testcase from upstream commit:
@@ -29,94 +41,55 @@
  * *) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
  *    distrub the testing as they also change some ksm tunables depends
  *    on current workloads.
- *
- * Copyright (C) 2011  Red Hat, Inc.
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
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/stat.h>
 #include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <signal.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include "test.h"
+#include <errno.h>
+#include "tst_test.h"
 #include "mem.h"
 
-char *TCID = "ksm05";
-int TST_TOTAL = 1;
-
 #ifdef HAVE_MADV_MERGEABLE
 
 static int ksm_run_orig;
-
 static void sighandler(int sig);
 
-int main(int argc, char *argv[])
+static void test_ksm(void)
 {
-	int lc, status, ret;
+	int status, ret;
 	long ps;
 	pid_t pid;
 	void *ptr;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
+	struct sigaction sa;
+
+	memset (&sa, '\0', sizeof(sa));
+	sa.sa_handler = sighandler;
+	sa.sa_flags = 0;
+	TEST(sigaction(SIGSEGV, &sa, NULL));
+	if (TEST_RETURN == -1)
+		tst_brk(TBROK | TRERRNO,
+				"SIGSEGV signal setup failed");
 	ps = sysconf(_SC_PAGESIZE);
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		switch (pid = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	switch (pid = SAFE_FORK()) {
 		case 0:
 			ret = posix_memalign(&ptr, ps, ps);
 			if (ret) {
-				tst_brkm(TBROK, cleanup, "posix_memalign(): %s",
-				         tst_strerrno(ret));
+				tst_brk(TBROK, "posix_memalign(): %s",
+						tst_strerrno(ret));
 			}
 			if (madvise(ptr, ps, MADV_MERGEABLE) < 0)
-				tst_brkm(TBROK | TERRNO, cleanup, "madvise");
+				tst_brk(TBROK | TERRNO, "madvise");
 			*(char *)NULL = 0;	/* SIGSEGV occurs as expected. */
-			exit(0);
 		default:
 			break;
-		}
-		if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_brkm(TBROK, cleanup,
-				 "invalid signal received: %d", status);
 	}
+	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
+		tst_brk(TBROK | TERRNO, "waitpid");
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_brk(TBROK, "invalid signal received: %d", status);
 
-	tst_resm(TPASS, "still alive.");
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "still alive.");
 }
 
 static void sighandler(int sig)
@@ -124,35 +97,34 @@ static void sighandler(int sig)
 	_exit((sig == SIGSEGV) ? 0 : sig);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required.");
-
 	if (access(PATH_KSM, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
-
-	tst_sig(FORK, sighandler, cleanup);
-
-	TEST_PAUSE;
+		tst_brk(TCONF, "KSM configuration is not enabled");
 
 	/* save original /sys/kernel/mm/ksm/run value */
-	SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &ksm_run_orig);
+	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
 
 	/* echo 1 > /sys/kernel/mm/ksm/run */
-	SAFE_FILE_PRINTF(NULL, PATH_KSM "run", "1");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	/* restore /sys/kernel/mm/ksm/run value */
 	FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
 }
+
+static struct tst_test test = {
+	.tid = "ksm05",
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_ksm,
+	.min_kver = "2.6.32",
+};
+
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no MADV_MERGEABLE found.");
-}
+	TST_TEST_TCONF("no MADV_MERGEABLE found.");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index cc34024..bc61cb3 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -1,25 +1,15 @@
 /*
- * Copyright (C) 2013 Linux Test Project
+ * Copyright (C) 2013-2017  Red Hat, Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -35,6 +25,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#include <limits.h>
 #include <errno.h>
 #include <fcntl.h>
 #if HAVE_NUMAIF_H
@@ -45,92 +36,68 @@
 #include <unistd.h>
 #include <limits.h>
 #include "numa_helper.h"
-#include "test.h"
-#include "safe_macros.h"
 #include "mem.h"
 
-char *TCID = "ksm06";
-int TST_TOTAL = 1;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
 static int run;
 static int sleep_millisecs;
 static int merge_across_nodes;
-static int n_flag;
 static unsigned long nr_pages;
 
-static char *n_opt;
-option_t options[] = {
-	{ "n:", &n_flag, &n_opt },
-	{ NULL, NULL, NULL }
+char *n_opt;
+static struct tst_option ksm_options[] = {
+	{"n:", &n_opt,  "-n x    Allocate x pages memory per node"},
+	{NULL, NULL, NULL}
 };
-static void usage(void);
 
-int main(int argc, char *argv[])
+static void test_ksm(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, options, &usage);
-
-	if (n_flag)
-		nr_pages = SAFE_STRTOUL(NULL, n_opt, 0, ULONG_MAX);
+	if (n_opt)
+		nr_pages = SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
 	else
 		nr_pages = 100;
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		test_ksm_merge_across_nodes(nr_pages);
-	}
-
-	cleanup();
-	tst_exit();
+	test_ksm_merge_across_nodes(nr_pages);
 }
 
-void setup(void)
+static void setup(void)
 {
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
-		tst_brkm(TCONF, NULL, "no merge_across_nodes sysfs knob");
+		tst_brk(TCONF, "no merge_across_nodes sysfs knob");
 
 	if (!is_numa(NULL, NH_MEMS, 2))
-		tst_brkm(TCONF, NULL, "The case needs a NUMA system.");
+		tst_brk(TCONF, "The case needs a NUMA system.");
 
 	/* save the current value */
-	SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &run);
-	SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &run);
+	SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
 			"%d", &merge_across_nodes);
-	SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
+	SAFE_FILE_SCANF(PATH_KSM "sleep_millisecs",
 			"%d", &sleep_millisecs);
 
 	save_max_page_sharing();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	FILE_PRINTF(PATH_KSM "merge_across_nodes",
-			 "%d", merge_across_nodes);
-	FILE_PRINTF(PATH_KSM "sleep_millisecs",
-			 "%d", sleep_millisecs);
+	FILE_PRINTF(PATH_KSM "merge_across_nodes", "%d", merge_across_nodes);
+	FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d", sleep_millisecs);
 	FILE_PRINTF(PATH_KSM "run", "%d", run);
 
 	restore_max_page_sharing();
 }
 
-static void usage(void)
-{
-	printf("  -n x    Allocate x pages memory per node\n");
-}
+static struct tst_test test = {
+	.tid = "ksm06",
+	.needs_root = 1,
+	.options = ksm_options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_ksm,
+};
 
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 053737b..f5d86c7 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -266,9 +266,10 @@ static void check(char *path, long int value)
 	snprintf(fullpath, BUFSIZ, PATH_KSM "%s", path);
 	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
 
-	tst_res(TINFO, "%s is %ld.", path, actual_val);
 	if (actual_val != value)
 		tst_res(TFAIL, "%s is not %ld.", path, value);
+	else
+		tst_res(TPASS, "%s is %ld.", path, actual_val);
 }
 
 static void wait_ksmd_done(void)
@@ -636,12 +637,12 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 
 void check_ksm_options(int *size, int *num, int *unit)
 {
-	if (opt_size) {
+	if (opt_sizestr) {
 		*size = atoi(opt_sizestr);
 		if (*size < 1)
 			tst_brk(TBROK, "size cannot be less than 1.");
 	}
-	if (opt_unit) {
+	if (opt_unitstr) {
 		*unit = atoi(opt_unitstr);
 		if (*unit > *size)
 			tst_brk(TBROK,
@@ -651,7 +652,7 @@ void check_ksm_options(int *size, int *num, int *unit)
 				 "the remainder of division of size by unit is "
 				 "not zero.");
 	}
-	if (opt_num) {
+	if (opt_numstr) {
 		*num = atoi(opt_numstr);
 		if (*num < 3)
 			tst_brk(TBROK,
@@ -659,13 +660,6 @@ void check_ksm_options(int *size, int *num, int *unit)
 	}
 }
 
-void ksm_usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -s      Memory allocation size in MB\n");
-	printf("  -u      Memory allocation unit in MB\n");
-}
-
 /* THP */
 
 /* cpuset/memcg */
-- 
2.9.3

