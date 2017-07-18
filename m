From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jul 2017 16:23:02 +0800
Subject: [LTP] [PATCH v3 05/15] mm/ksm: move the common code to ksm_common.h
In-Reply-To: <20170718082312.3946-1-liwang@redhat.com>
References: <20170718082312.3946-1-liwang@redhat.com>
Message-ID: <20170718082312.3946-6-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h    |  3 ---
 testcases/kernel/mem/ksm/ksm01.c      | 16 +++---------
 testcases/kernel/mem/ksm/ksm02.c      | 16 +++---------
 testcases/kernel/mem/ksm/ksm03.c      | 15 ++---------
 testcases/kernel/mem/ksm/ksm04.c      | 15 ++---------
 testcases/kernel/mem/ksm/ksm05.c      |  1 -
 testcases/kernel/mem/ksm/ksm_common.h | 48 +++++++++++++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c        | 25 ------------------
 8 files changed, 58 insertions(+), 81 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm_common.h

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index bada549..287f8b3 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -44,10 +44,7 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
 
-char *opt_numstr, *opt_sizestr, *opt_unitstr;
-
 void create_same_memory(int size, int num, int unit);
-void check_ksm_options(int *size, int *num, int *unit);
 void save_max_page_sharing(void);
 void restore_max_page_sharing(void);
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 849d4d4..ce96983 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -57,21 +57,10 @@
 #include <string.h>
 #include <unistd.h>
 #include "mem.h"
-
-static int merge_across_nodes;
-
-static struct tst_option ksm_options[] = {
-	{"n:", &opt_numstr,  "-n       Number of processes"},
-	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
-	{NULL, NULL, NULL}
-};
+#include "ksm_common.h"
 
 static void verify_ksm(void)
 {
-	int size = 128, num = 3, unit = 1;
-
-	check_ksm_options(&size, &num, &unit);
 	create_same_memory(size, num, unit);
 }
 
@@ -82,6 +71,8 @@ static void setup(void)
 
 	save_max_page_sharing();
 
+	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
+
 	/*
 	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
 	 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
@@ -106,7 +97,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ksm01",
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = ksm_options,
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index eeebfef..6fe75d3 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -57,30 +57,19 @@
 #include <stdio.h>
 #include <unistd.h>
 #include "mem.h"
+#include "ksm_common.h"
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
-static int merge_across_nodes;
-
-static struct tst_option ksm_options[] = {
-	{"n:", &opt_numstr,  "-n       Number of processes"},
-	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
-	{NULL, NULL, NULL}
-};
-
 static void verify_ksm(void)
 {
-	int size = 128, num = 3, unit = 1;
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	check_ksm_options(&size, &num, &unit);
-
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 		if (errno != ENOSYS)
 			tst_brk(TBROK | TERRNO, "set_mempolicy");
@@ -111,6 +100,8 @@ static void setup(void)
 		tst_brk(TCONF, "KSM configuration is not enabled");
 	save_max_page_sharing();
 
+	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
+
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
 		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
 				"%d", &merge_across_nodes);
@@ -121,7 +112,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ksm02",
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = ksm_options,
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 9fd5aac..51cc923 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -57,21 +57,10 @@
 #include <string.h>
 #include <unistd.h>
 #include "mem.h"
-
-static int merge_across_nodes;
-
-static struct tst_option ksm_options[] = {
-	{"n:", &opt_numstr,  "-n       Number of processes"},
-	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
-	{NULL, NULL, NULL}
-};
+#include "ksm_common.h"
 
 static void verify_ksm(void)
 {
-	int size = 128, num = 3, unit = 1;
-
-	check_ksm_options(&size, &num, &unit);
 	write_memcg();
 	create_same_memory(size, num, unit);
 }
@@ -88,6 +77,7 @@ static void setup(void)
 	}
 
 	save_max_page_sharing();
+	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
@@ -103,7 +93,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ksm03",
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = ksm_options,
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 29a5e2b..1c8bf20 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -57,30 +57,19 @@
 #include <stdio.h>
 #include <unistd.h>
 #include "mem.h"
+#include "ksm_common.h"
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
-static int merge_across_nodes;
-
-static struct tst_option ksm_options[] = {
-	{"n:", &opt_numstr,  "-n       Number of processes"},
-	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
-	{NULL, NULL, NULL}
-};
-
 static void verify_ksm(void)
 {
-	int size = 128, num = 3, unit = 1;
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	check_ksm_options(&size, &num, &unit);
-
 	write_memcg();
 
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
@@ -120,13 +109,13 @@ static void setup(void)
 	}
 
 	save_max_page_sharing();
+	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
 static struct tst_test test = {
-	.tid = "ksm04",
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = ksm_options,
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 59c8f4b..73be1ed 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -116,7 +116,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ksm05",
 	.needs_root = 1,
 	.forks_child = 1,
 	.setup = setup,
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
new file mode 100644
index 0000000..6a682d0
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2017  Red Hat, Inc.
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
+ */
+
+ /*
+  * Parse the ksm0* test options in funcion parse_ksm_options().
+  */
+
+#include "tst_test.h"
+
+int merge_across_nodes;
+
+int size = 128, num = 3, unit = 1;
+char *opt_sizestr, *opt_numstr, *opt_unitstr;
+
+struct tst_option ksm_options[] = {
+	{"n:", &opt_numstr,  "-n       Number of processes"},
+	{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
+	{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
+	{NULL, NULL, NULL}
+};
+
+static inline void parse_ksm_options(char *str_size, int *size,
+		char *str_num, int *num, char *str_unit, int *unit)
+{
+	if(tst_parse_int(str_size, size, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid size '%s'", str_size);
+
+	if(tst_parse_int(str_num, num, 3, INT_MAX))
+		tst_brk(TBROK, "Invalid num '%s'", str_num);
+
+	if(tst_parse_int(str_unit, unit, 1, *size))
+		tst_brk(TBROK, "Invalid unit '%s'", str_unit);
+	if (*size % *unit != 0)
+		tst_brk(TBROK,
+				"the remainder of division of size by unit is "
+				"not zero.");
+}
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f5d86c7..cae6f1b 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -635,31 +635,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	wait_ksmd_done();
 }
 
-void check_ksm_options(int *size, int *num, int *unit)
-{
-	if (opt_sizestr) {
-		*size = atoi(opt_sizestr);
-		if (*size < 1)
-			tst_brk(TBROK, "size cannot be less than 1.");
-	}
-	if (opt_unitstr) {
-		*unit = atoi(opt_unitstr);
-		if (*unit > *size)
-			tst_brk(TBROK,
-				 "unit cannot be greater than size.");
-		if (*size % *unit != 0)
-			tst_brk(TBROK,
-				 "the remainder of division of size by unit is "
-				 "not zero.");
-	}
-	if (opt_numstr) {
-		*num = atoi(opt_numstr);
-		if (*num < 3)
-			tst_brk(TBROK,
-				 "process number cannot be less 3.");
-	}
-}
-
 /* THP */
 
 /* cpuset/memcg */
-- 
2.9.3

