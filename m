From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  2 Mar 2021 15:25:07 +0000
Subject: [LTP] [RFC PATCH v2 4/7] Add new CGroups API library tests
In-Reply-To: <20210302152510.15116-1-rpalethorpe@suse.com>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
Message-ID: <20210302152510.15116-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/newlib_tests/.gitignore     |  2 +
 lib/newlib_tests/test21.c       | 43 +++++++---------
 lib/newlib_tests/tst_cgroup01.c | 51 +++++++++++++++++++
 lib/newlib_tests/tst_cgroup02.c | 87 +++++++++++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 25 deletions(-)
 create mode 100644 lib/newlib_tests/tst_cgroup01.c
 create mode 100644 lib/newlib_tests/tst_cgroup02.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6c2612259..98611e65d 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -16,6 +16,8 @@ test15
 test16
 tst_capability01
 tst_capability02
+tst_cgroup01
+tst_cgroup02
 tst_device
 tst_safe_fileops
 tst_res_hexd
diff --git a/lib/newlib_tests/test21.c b/lib/newlib_tests/test21.c
index f29a2f702..e939463d7 100644
--- a/lib/newlib_tests/test21.c
+++ b/lib/newlib_tests/test21.c
@@ -8,54 +8,47 @@
  * Tests tst_cgroup.h APIs
  */
 
+#include <stdlib.h>
+
 #include "tst_test.h"
 #include "tst_cgroup.h"
 
-#define PATH_CGROUP1 "/mnt/liwang1"
-#define PATH_CGROUP2 "/mnt/liwang2"
 #define MEMSIZE 1024 * 1024
 
+static const struct tst_cgroup *cg;
+
 static void do_test(void)
 {
 	pid_t pid = SAFE_FORK();
 
 	switch (pid) {
 	case 0:
-		tst_cgroup_move_current(PATH_CGROUP1);
-		tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, MEMSIZE);
-		tst_cgroup_mem_set_maxswap(PATH_CGROUP1, MEMSIZE);
-
-		tst_cgroup_move_current(PATH_CGROUP2);
-
-	break;
+		SAFE_CGROUP_PRINTF(&cg->cgroup.procs, "%d", getpid());
+		SAFE_CGROUP_PRINTF(&cg->memory.max, "%d", MEMSIZE);
+		if (TST_CGROUP_HAS(&cg->memory.swap))
+			SAFE_CGROUP_PRINTF(&cg->memory.swap.max, "%d", MEMSIZE);
+		exit(0);
+		break;
 	default:
-		tst_cgroup_move_current(PATH_TMP_CG_CST);
-
-		tst_cgroup_move_current(PATH_TMP_CG_MEM);
-		tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
-		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, MEMSIZE);
+		SAFE_CGROUP_PRINTF(&cg->cgroup.procs, "%d", getpid());
 	break;
 	}
 
-	tst_res(TPASS, "Cgroup mount test");
+	tst_reap_children();
+	tst_res(TPASS, "Cgroup test");
 }
 
 static void setup(void)
 {
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
-
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
+	/* Omitting the below causes a warning */
+	/* tst_cgroup_require(TST_CGROUP_CPUSET, NULL); */
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
+	cg = tst_cgroup_get_default();
 }
 
 static void cleanup(void)
 {
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
-	tst_cgroup_umount(PATH_CGROUP1);
-
-	tst_cgroup_umount(PATH_TMP_CG_CST);
-	tst_cgroup_umount(PATH_CGROUP2);
+	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
diff --git a/lib/newlib_tests/tst_cgroup01.c b/lib/newlib_tests/tst_cgroup01.c
new file mode 100644
index 000000000..36cf065cb
--- /dev/null
+++ b/lib/newlib_tests/tst_cgroup01.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 SUSE LLC */
+
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_cgroup_core.h"
+
+static char *only_mount_v1;
+static char *no_cleanup;
+static struct tst_option opts[] = {
+	{"v", &only_mount_v1, "-v\tOnly try to mount CGroups V1"},
+	{"n", &no_cleanup, "-n\tLeave CGroups created by test"},
+	{NULL, NULL, NULL},
+};
+struct tst_cgroup_opts cgopts;
+
+static void do_test(void)
+{
+	tst_res(TPASS, "pass");
+}
+
+static void setup(void)
+{
+	cgopts.only_mount_v1 = !!only_mount_v1,
+
+	tst_cgroup_scan();
+	tst_cgroup_print_config();
+
+	tst_cgroup_require(TST_CGROUP_MEMORY, &cgopts);
+	tst_cgroup_print_config();
+	tst_cgroup_require(TST_CGROUP_CPUSET, &cgopts);
+	tst_cgroup_print_config();
+}
+
+static void cleanup(void)
+{
+	if (no_cleanup) {
+		tst_res(TINFO, "no cleanup");
+	} else {
+		tst_res(TINFO, "cleanup");
+		tst_cgroup_cleanup();
+	}
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = opts,
+};
diff --git a/lib/newlib_tests/tst_cgroup02.c b/lib/newlib_tests/tst_cgroup02.c
new file mode 100644
index 000000000..9799b2dfd
--- /dev/null
+++ b/lib/newlib_tests/tst_cgroup02.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 SUSE LLC */
+
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_cgroup.h"
+
+static char *only_mount_v1;
+static char *no_cleanup;
+static struct tst_option opts[] = {
+	{"v", &only_mount_v1, "-v\tOnly try to mount CGroups V1"},
+	{"n", &no_cleanup, "-n\tLeave CGroups created by test"},
+	{NULL, NULL, NULL},
+};
+static struct tst_cgroup_opts cgopts;
+static const struct tst_cgroup *cg;
+static const struct tst_cgroup *cg_drain;
+static struct tst_cgroup *cg_child;
+
+static void do_test(void)
+{
+	char buf[BUFSIZ];
+	size_t mem;
+
+	if (cg->memory.ver != TST_CGROUP_V1)
+		SAFE_CGROUP_PRINT(&cg->cgroup.subtree_control, "+memory");
+	if (cg->cpuset.ver != TST_CGROUP_V1)
+		SAFE_CGROUP_PRINT(&cg->cgroup.subtree_control, "+cpuset");
+
+	cg_child = tst_cgroup_mk(cg, "child");
+	if (!SAFE_FORK()) {
+		SAFE_CGROUP_PRINTF(&cg_child->cgroup.procs, "%d", getpid());
+
+		SAFE_CGROUP_SCANF(&cg_child->memory.current, "%zu", &mem);
+		tst_res(TPASS, "child/memory.current = %zu", mem);
+		SAFE_CGROUP_PRINTF(&cg_child->memory.max, "%zu", (1UL << 24) - 1);
+		SAFE_CGROUP_PRINTF(&cg_child->memory.swap.max, "%zu", 1UL << 31);
+
+		SAFE_CGROUP_READ(&cg_child->cpuset.mems, buf, sizeof(buf));
+		tst_res(TPASS, "child/cpuset.mems = %s", buf);
+		SAFE_CGROUP_PRINT(&cg_child->cpuset.mems, buf);
+
+		exit(0);
+	}
+
+	SAFE_CGROUP_PRINTF(&cg_child->cgroup.procs, "%d", getpid());
+	SAFE_CGROUP_SCANF(&cg->memory.current, "%zu", &mem);
+	tst_res(TPASS, "memory.current = %zu", mem);
+
+	tst_reap_children();
+	SAFE_CGROUP_PRINTF(&cg_drain->cgroup.procs, "%d", getpid());
+	cg_child = tst_cgroup_rm(cg_child);
+}
+
+static void setup(void)
+{
+	cgopts.only_mount_v1 = !!only_mount_v1,
+
+	tst_cgroup_scan();
+	tst_cgroup_print_config();
+
+	tst_cgroup_require(TST_CGROUP_MEMORY, &cgopts);
+	tst_cgroup_require(TST_CGROUP_CPUSET, &cgopts);
+
+	cg = tst_cgroup_get_default();
+	cg_drain = tst_cgroup_get_drain();
+}
+
+static void cleanup(void)
+{
+	if (cg_child) {
+		SAFE_CGROUP_PRINTF(&cg_drain->cgroup.procs, "%d", getpid());
+		cg_child = tst_cgroup_rm(cg_child);
+	}
+	if (!no_cleanup)
+		tst_cgroup_cleanup();
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.options = opts,
+	.forks_child = 1,
+};
-- 
2.30.0

