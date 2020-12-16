From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 16 Dec 2020 10:01:19 +0000
Subject: [LTP] [RFC PATCH 3/5] CGroup API tests
In-Reply-To: <20201216100121.16683-1-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
Message-ID: <20201216100121.16683-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrite of existing test and new test for the CGroups API.
---
 lib/newlib_tests/.gitignore   |  1 +
 lib/newlib_tests/test21.c     | 30 +++++------------
 lib/newlib_tests/tst_cgroup.c | 61 +++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 22 deletions(-)
 create mode 100644 lib/newlib_tests/tst_cgroup.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6c2612259..799f088ba 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -16,6 +16,7 @@ test15
 test16
 tst_capability01
 tst_capability02
+tst_cgroup
 tst_device
 tst_safe_fileops
 tst_res_hexd
diff --git a/lib/newlib_tests/test21.c b/lib/newlib_tests/test21.c
index f29a2f702..4d40c2e1e 100644
--- a/lib/newlib_tests/test21.c
+++ b/lib/newlib_tests/test21.c
@@ -11,8 +11,6 @@
 #include "tst_test.h"
 #include "tst_cgroup.h"
 
-#define PATH_CGROUP1 "/mnt/liwang1"
-#define PATH_CGROUP2 "/mnt/liwang2"
 #define MEMSIZE 1024 * 1024
 
 static void do_test(void)
@@ -21,19 +19,16 @@ static void do_test(void)
 
 	switch (pid) {
 	case 0:
-		tst_cgroup_move_current(PATH_CGROUP1);
-		tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, MEMSIZE);
-		tst_cgroup_mem_set_maxswap(PATH_CGROUP1, MEMSIZE);
-
-		tst_cgroup_move_current(PATH_CGROUP2);
-
+		tst_cgroup_move_current(TST_CGROUP_MEMORY);
+		tst_cgroup_mem_set_maxbytes(MEMSIZE);
+		tst_cgroup_mem_set_maxswap(MEMSIZE);
 	break;
 	default:
-		tst_cgroup_move_current(PATH_TMP_CG_CST);
+		tst_cgroup_move_current(TST_CGROUP_CPUSET);
 
-		tst_cgroup_move_current(PATH_TMP_CG_MEM);
-		tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
-		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, MEMSIZE);
+		tst_cgroup_move_current(TST_CGROUP_MEMORY);
+		tst_cgroup_mem_set_maxbytes(MEMSIZE);
+		tst_cgroup_mem_set_maxswap(MEMSIZE);
 	break;
 	}
 
@@ -42,20 +37,11 @@ static void do_test(void)
 
 static void setup(void)
 {
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
-
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
 }
 
 static void cleanup(void)
 {
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
-	tst_cgroup_umount(PATH_CGROUP1);
-
-	tst_cgroup_umount(PATH_TMP_CG_CST);
-	tst_cgroup_umount(PATH_CGROUP2);
 }
 
 static struct tst_test test = {
diff --git a/lib/newlib_tests/tst_cgroup.c b/lib/newlib_tests/tst_cgroup.c
new file mode 100644
index 000000000..e4e7d8f28
--- /dev/null
+++ b/lib/newlib_tests/tst_cgroup.c
@@ -0,0 +1,61 @@
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
+struct tst_cgroup_opts cgopts;
+
+static void do_test(void)
+{
+	char buf[BUFSIZ];
+	pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		tst_cgroup_mem_set_maxbytes((1UL << 24) - 1);
+		tst_cgroup_mem_set_maxswap(1UL << 31);
+		tst_cgroup_move_current(TST_CGROUP_MEMORY);
+
+		tst_cgroup_cpuset_read_files("mems", buf, sizeof(buf));
+		tst_cgroup_cpuset_write_files("mems", buf);
+		tst_cgroup_move_current(TST_CGROUP_CPUSET);
+
+		tst_res(TPASS, "Cgroup mount test");
+	}
+
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	cgopts.only_mount_v1 = !!only_mount_v1,
+	cgopts.cleanup =
+		no_cleanup ? TST_CGROUP_CLEANUP_NONE : TST_CGROUP_CLEANUP_ROOT;
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
+	tst_cgroup_cleanup(&cgopts);
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
2.29.2

