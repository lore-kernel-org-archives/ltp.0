From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jul 2017 16:22:59 +0800
Subject: [LTP] [PATCH v3 02/15] mem/oom: convert to new API
In-Reply-To: <20170718082312.3946-1-liwang@redhat.com>
References: <20170718082312.3946-1-liwang@redhat.com>
Message-ID: <20170718082312.3946-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/oom/oom01.c |  82 ++++++++++---------------
 testcases/kernel/mem/oom/oom02.c |  82 +++++++++----------------
 testcases/kernel/mem/oom/oom03.c | 109 +++++++++++++--------------------
 testcases/kernel/mem/oom/oom04.c |  97 +++++++++++------------------
 testcases/kernel/mem/oom/oom05.c | 129 ++++++++++++++++-----------------------
 5 files changed, 191 insertions(+), 308 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index e39394b..955642c 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -7,27 +7,19 @@
  * behaviours. It simply increase the memory consumption 3G each time
  * until all the available memory is consumed and OOM is triggered.
  *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Copyright (C) 2010-2017  Red Hat, Inc.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
@@ -35,53 +27,41 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "oom01";
-int TST_TOTAL = 1;
-
-int main(int argc, char *argv[])
+static void verify_oom(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 #if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	setup();
+	/* we expect mmap to fail before OOM is hit */
+	set_sys_tune("overcommit_memory", 2, 1);
+	oom(NORMAL, 0, ENOMEM, 0);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	/* with overcommit_memory set to 0 or 1 there's no
+	 * guarantee that mmap fails before OOM */
+	set_sys_tune("overcommit_memory", 0, 1);
+	oom(NORMAL, 0, ENOMEM, 1);
 
-		/* we expect mmap to fail before OOM is hit */
-		set_sys_tune("overcommit_memory", 2, 1);
-		oom(NORMAL, 0, ENOMEM, 0);
-
-		/* with overcommit_memory set to 0 or 1 there's no
-		 * guarantee that mmap fails before OOM */
-		set_sys_tune("overcommit_memory", 0, 1);
-		oom(NORMAL, 0, ENOMEM, 1);
-
-		set_sys_tune("overcommit_memory", 1, 1);
-		testoom(0, 0, ENOMEM, 1);
-	}
-	cleanup();
-	tst_exit();
+	set_sys_tune("overcommit_memory", 1, 1);
+	testoom(0, 0, ENOMEM, 1);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	overcommit = get_sys_tune("overcommit_memory");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", overcommit, 0);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_oom,
+};
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 8bbb18a..dab8874 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -7,26 +7,17 @@
  * behaviours. It simply increase the memory consumption 3G each time
  * until all the available memory is consumed and OOM is triggered.
  *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Copyright (C) 2010-2017  Red Hat, Inc.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
 
 #include "config.h"
@@ -36,64 +27,49 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include "numa_helper.h"
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "oom02";
-int TST_TOTAL = 1;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
-int main(int argc, char *argv[])
+static void verify_oom(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 #if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	tst_res(TINFO, "OOM on MPOL_BIND mempolicy...");
+	testoom(MPOL_BIND, 0, ENOMEM, 1);
 
-		tst_resm(TINFO, "OOM on MPOL_BIND mempolicy...");
-		testoom(MPOL_BIND, 0, ENOMEM, 1);
+	tst_res(TINFO, "OOM on MPOL_INTERLEAVE mempolicy...");
+	testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
 
-		tst_resm(TINFO, "OOM on MPOL_INTERLEAVE mempolicy...");
-		testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
-
-		tst_resm(TINFO, "OOM on MPOL_PREFERRED mempolicy...");
-		testoom(MPOL_PREFERRED, 0, ENOMEM, 1);
-	}
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "OOM on MPOL_PREFERRED mempolicy...");
+	testoom(MPOL_PREFERRED, 0, ENOMEM, 1);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	if (!is_numa(NULL, NH_MEMS, 2))
-		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
+		tst_brk(TCONF, "The case need a NUMA system.");
 
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", overcommit, 0);
 }
 
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_oom,
+};
+
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 879fdae..b384e2b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -7,107 +7,82 @@
  * behaviours. It simply increase the memory consumption 3G each time
  * until all the available memory is consumed and OOM is triggered.
  *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Copyright (C) 2010-2017  Red Hat, Inc.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include "numa_helper.h"
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "oom03";
-int TST_TOTAL = 1;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
-int main(int argc, char *argv[])
+static void verify_oom(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 #if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
+	SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
 
-		SAFE_FILE_PRINTF(cleanup, MEMCG_PATH_NEW "/tasks",
-				 "%d", getpid());
-		SAFE_FILE_PRINTF(cleanup, MEMCG_LIMIT, "%ld", TESTMEM);
+	testoom(0, 0, ENOMEM, 1);
 
-		testoom(0, 0, ENOMEM, 1);
-
-		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
-			if (errno == ENOENT)
-				tst_resm(TCONF,
-					 "memcg swap accounting is disabled");
-			else
-				tst_brkm(TBROK | TERRNO, cleanup, "access");
-		} else {
-			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT,
-					 "%ld", TESTMEM);
-			testoom(0, 1, ENOMEM, 1);
-		}
+	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
+		if (errno == ENOENT)
+			tst_res(TCONF,
+				"memcg swap accounting is disabled");
+		else
+			tst_brk(TBROK | TERRNO, "access");
+	} else {
+		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
+		testoom(0, 1, ENOMEM, 1);
+	}
 
-		/* OOM for MEMCG with mempolicy */
-		if (is_numa(cleanup, NH_MEMS, 2)) {
-			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
-			testoom(MPOL_BIND, 0, ENOMEM, 1);
-			testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
-			testoom(MPOL_PREFERRED, 0, ENOMEM, 1);
-		}
+	/* OOM for MEMCG with mempolicy */
+	if (is_numa(NULL, NH_MEMS, 2)) {
+		tst_res(TINFO, "OOM on MEMCG & mempolicy...");
+		testoom(MPOL_BIND, 0, ENOMEM, 1);
+		testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
+		testoom(MPOL_PREFERRED, 0, ENOMEM, 1);
 	}
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", overcommit, 0);
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_oom,
+};
+
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 4829d95..8043097 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -7,26 +7,17 @@
  * behaviours. It simply increase the memory consumption 3G each time
  * until all the available memory is consumed and OOM is triggered.
  *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Copyright (C) 2010-2017  Red Hat, Inc.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
 
 #include "config.h"
@@ -36,59 +27,38 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include "numa_helper.h"
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "oom04";
-int TST_TOTAL = 1;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
-int main(int argc, char *argv[])
+static void verify_oom(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 #if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		tst_resm(TINFO, "OOM on CPUSET...");
+	tst_res(TINFO, "OOM on CPUSET...");
+	testoom(0, 0, ENOMEM, 1);
+
+	if (is_numa(NULL, NH_MEMS, 2)) {
+		/*
+		 * Under NUMA system, the migration of cpuset's memory
+		 * is in charge of cpuset.memory_migrate, we can write
+		 * 1 to cpuset.memory_migrate to enable the migration.
+		 */
+		write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+		tst_res(TINFO, "OOM on CPUSET with mem migrate:");
 		testoom(0, 0, ENOMEM, 1);
-
-		if (is_numa(cleanup, NH_MEMS, 2)) {
-			/*
-			 * Under NUMA system, the migration of cpuset's memory
-			 * is in charge of cpuset.memory_migrate, we can write
-			 * 1 to cpuset.memory_migrate to enable the migration.
-			 */
-			write_cpuset_files(CPATH_NEW,
-					   "memory_migrate", "1");
-			tst_resm(TINFO, "OOM on CPUSET with mem migrate:");
-			testoom(0, 0, ENOMEM, 1);
-		}
 	}
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
 	int memnode, ret;
 
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	if (!is_numa(NULL, NH_MEMS, 1))
-		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
 
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
@@ -103,20 +73,25 @@ void setup(void)
 	 */
 	ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
 	if (ret < 0)
-		tst_brkm(TBROK, cleanup, "Failed to get a memory node "
-				      "using get_allowed_nodes()");
+		tst_brk(TBROK, "Failed to get a memory node "
+			      "using get_allowed_nodes()");
 	write_cpusets(memnode);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", overcommit, 0);
 	umount_mem(CPATH, CPATH_NEW);
 }
 
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_oom,
+};
+
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index ccf456f..600e8d9 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -7,26 +7,17 @@
  * behaviours. It simply increase the memory consumption 3G each time
  * until all the available memory is consumed and OOM is triggered.
  *
- * Copyright (C) 2013  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Copyright (C) 2013-2017  Red Hat, Inc.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
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
 
 #include "config.h"
@@ -36,82 +27,63 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include "numa_helper.h"
-#include "test.h"
 #include "mem.h"
 
-char *TCID = "oom05";
-int TST_TOTAL = 1;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
-int main(int argc, char *argv[])
+static void verify_oom(void)
 {
-	int lc;
 	int swap_acc_on = 1;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 #if __WORDSIZE == 32
-	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	setup();
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	tst_res(TINFO, "OOM on CPUSET & MEMCG...");
+	testoom(0, 0, ENOMEM, 1);
 
-		tst_resm(TINFO, "OOM on CPUSET & MEMCG...");
+	/*
+	 * Under NUMA system, the migration of cpuset's memory
+	 * is in charge of cpuset.memory_migrate, we can write
+	 * 1 to cpuset.memory_migrate to enable the migration.
+	 */
+	if (is_numa(NULL, NH_MEMS, 2)) {
+		write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
+				"cpuset.memory_migrate=1");
 		testoom(0, 0, ENOMEM, 1);
+	}
 
-		/*
-		 * Under NUMA system, the migration of cpuset's memory
-		 * is in charge of cpuset.memory_migrate, we can write
-		 * 1 to cpuset.memory_migrate to enable the migration.
-		 */
-		if (is_numa(cleanup, NH_MEMS, 2)) {
-			write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
-			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
-					"cpuset.memory_migrate=1");
-			testoom(0, 0, ENOMEM, 1);
-		}
-
-		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
-			if (errno == ENOENT) {
-				tst_resm(TCONF,
-					 "memcg swap accounting is disabled");
-				swap_acc_on = 0;
-			} else
-				tst_brkm(TBROK|TERRNO, cleanup, "access");
-		}
-
-		if (swap_acc_on) {
-			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
-					"special memswap limitation:");
-			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT, "%ld", TESTMEM);
-			testoom(0, 0, ENOMEM, 1);
-
-			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
-					"disabled memswap limitation:");
-			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT, "-1");
-			testoom(0, 0, ENOMEM, 1);
-		}
+	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
+		if (errno == ENOENT) {
+			tst_res(TCONF,
+					"memcg swap accounting is disabled");
+			swap_acc_on = 0;
+		} else
+			tst_brk(TBROK|TERRNO, "access");
 	}
 
-	cleanup();
-	tst_exit();
+	if (swap_acc_on) {
+		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
+				"special memswap limitation:");
+		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
+		testoom(0, 0, ENOMEM, 1);
+
+		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
+				"disabled memswap limitation:");
+		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "-1");
+		testoom(0, 0, ENOMEM, 1);
+	}
 }
 
 void setup(void)
 {
 	int ret, memnode;
 
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
 	if (!is_numa(NULL, NH_MEMS, 1))
-		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
 
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
@@ -128,8 +100,8 @@ void setup(void)
 	 */
 	ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
 	if (ret < 0)
-		tst_brkm(TBROK, cleanup, "Failed to get a memory node "
-				      "using get_allowed_nodes()");
+		tst_brk(TBROK, "Failed to get a memory node "
+			      "using get_allowed_nodes()");
 	write_cpusets(memnode);
 }
 
@@ -140,9 +112,14 @@ void cleanup(void)
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_oom,
+};
+
 #else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
+	TST_TEST_TCONF("no NUMA development packages installed.");
 #endif
-- 
2.9.3

