From: Li Wang <liwang@redhat.com>
Date: Wed, 27 May 2020 11:14:27 +0800
Subject: [LTP] [PATCH v1 1/4] lib: add new cgroup test API
Message-ID: <20200527031430.22144-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Many of our LTP tests need Control Group in the configuration,
this patch makes cgroup unified mounting at setup phase to be
possible. The method?is extracted from mem.h with the purpose
of?extendible for further developing, and trying?to compatible
the current two versions of cgroup,

It's hard to make all APIs be strictly consistent because there
are many differences between v1 and v2. But it?capsulate the detail
of cgroup mounting in high-level functions, which will be easier
to use cgroup without considering too much technical thing.? ?

Btw, test get passed on RHEL7(x86_64), RHEL8(ppc64le), Fedora32(x86_64).

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    RFC --> V1:
      * hide cgroup mount/umount with internal functions:
    	static void tst_cgroup1_mount(const char *name, ...)
    	static void tst_cgroup1_umount(const char *name, ...)
    	static void tst_cgroup2_mount(const char *name, ...)
    	static void tst_cgroup2_umount(const char *name, ...)
    
      * export unified cgroup APIs to LTP test users:
    	void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl);
    	void tst_cgroup_umount(enum tst_cgroup_ctrl ctrl);
    	void tst_cgroup_move_current(enum tst_cgroup_ctrl ctrl);
    	void tst_cgroup_mem_set_maxbytes(long memsz);
    	void tst_cgroup_mem_set_maxswap(long memsz);

 doc/test-writing-guidelines.txt |  43 +++++
 include/tst_cgroup.h            |  45 ++++++
 include/tst_test.h              |   1 +
 lib/tst_cgroup.c                | 270 ++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+)
 create mode 100644 include/tst_cgroup.h
 create mode 100644 lib/tst_cgroup.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 93ca506d9..514739fa6 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2053,6 +2053,49 @@ the prefix field of file pointed by path equals to the value passed to this func
 Also having a similar api pair TST_ASSERT_FILE_INT/STR(path, prefix, val) to assert
 the field value of file.
 
+2.2.36 Using Control Group
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+Some of LTP tests need Control Group in their configuration, tst_cgroup.h provides
+APIs to make cgroup unified mounting at setup phase to be possible. The method?is
+extracted from mem.h with the purpose of?extendible for further developing, and
+trying to compatible the current two versions of cgroup.
+
+Considering there are many differences between cgroup v1 and v2, here we capsulate
+the detail of cgroup mounting in high-level functions, which will be easier to use
+cgroup without caring about too much technical thing.? ?
+
+Also, we do cgroup mount/umount work for the different hierarchy automatically.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static void run(void)
+{
+	...
+
+	tst_cgroup_mem_set_maxbytes(MEMSIZE);
+
+	// do test under cgroup
+	...
+}
+
+static void setup(void)
+{
+	tst_cgroup_mount(TST_CGROUP_MEMCG);
+}
+
+static void cleanup(void)
+{
+	tst_cgroup_umount(TST_CGROUP_MEMCG);
+}
+
+struct tst_test test = {
+	.test_all = run,
+	...
+};
+
+-------------------------------------------------------------------------------
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
new file mode 100644
index 000000000..c6790f762
--- /dev/null
+++ b/include/tst_cgroup.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Red Hat, Inc.
+ */
+
+#ifndef TST_CGROUP_H
+#define TST_CGROUP_H
+
+#define PATH_SYS_CGROUP		"/sys/fs/cgroup"
+
+enum tst_cgroup_ver {
+	TST_CGROUP_V1 = 1,
+	TST_CGROUP_V2 = 2,
+};
+
+enum tst_cgroup_ctrl {
+	TST_CGROUP_MEMCG = 1,
+	TST_CGROUP_CPUSET = 2,
+	/* add cgroup controller */
+};
+
+/* cgroup v1 */
+#define PATH_TMP_CG1_MEM	"/tmp/cgroup1_mem"
+#define PATH_TMP_CG1_CST	"/tmp/cgroup1_cpuset"
+#define PATH_CG1_MEM_LTP	PATH_TMP_CG1_MEM "/ltp"
+#define PATH_CG1_CST_LTP	PATH_TMP_CG1_CST "/ltp"
+#define PATH_MEMORY_LIMIT	PATH_CG1_MEM_LTP "/memory.limit_in_bytes"
+#define PATH_MEMORY_SW_LIMIT	PATH_CG1_MEM_LTP "/memory.memsw.limit_in_bytes"
+/* cgroup v1 */
+
+/* cgroup v2 */
+#define PATH_TMP_CGROUP2	"/tmp/cgroup2"	/* cgroup v2 has only single hierarchy */
+#define PATH_TMP_CG2_LTP	PATH_TMP_CGROUP2 "/ltp"
+#define PATH_MEMORY_MAX		PATH_TMP_CG2_LTP "/memory.max"
+#define PATH_MEMORY_SW_MAX	PATH_TMP_CG2_LTP "/memory.swap.max"
+/* cgroup v2 */
+
+enum tst_cgroup_ver tst_cgroup_version(void);
+void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl);
+void tst_cgroup_umount(enum tst_cgroup_ctrl ctrl);
+void tst_cgroup_move_current(enum tst_cgroup_ctrl ctrl);
+void tst_cgroup_mem_set_maxbytes(long memsz);
+void tst_cgroup_mem_set_maxswap(long memsz);
+
+#endif /* TST_CGROUP_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index 5bedb4f6f..b84f7b9dd 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -39,6 +39,7 @@
 #include "tst_capability.h"
 #include "tst_hugepage.h"
 #include "tst_assert.h"
+#include "tst_cgroup.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
new file mode 100644
index 000000000..4228f2730
--- /dev/null
+++ b/lib/tst_cgroup.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Red Hat, Inc.
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <stdio.h>
+#include <sys/mount.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_stdio.h"
+#include "tst_cgroup.h"
+#include "tst_device.h"
+
+static int tst_cgroup_check(const char *cgroup)
+{
+	char line[PATH_MAX];
+	FILE *file;
+	int cg_check = 0;
+
+	file = SAFE_FOPEN("/proc/filesystems", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, cgroup) != NULL) {
+			cg_check = 1;
+			break;
+		}
+	}
+	SAFE_FCLOSE(file);
+
+	return cg_check;
+}
+
+enum tst_cgroup_ver tst_cgroup_version(void)
+{
+	if (tst_cgroup_check("cgroup2")) {
+		if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
+			return TST_CGROUP_V1;
+		else
+			return TST_CGROUP_V2;
+	}
+
+	if (tst_cgroup_check("cgroup"))
+		return TST_CGROUP_V1;
+
+	tst_brk(TCONF, "Cgroup is not configured");
+}
+
+/* cgroup v1 */
+static void tst_cgroup1_mount(const char *name, const char *option,
+			const char *mnt_path, const char *new_path)
+{
+	if (tst_is_mounted(mnt_path))
+		goto out;
+
+	SAFE_MKDIR(mnt_path, 0777);
+	if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
+		if (errno == ENODEV) {
+			if (rmdir(mnt_path) == -1)
+				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
+			tst_brk(TCONF,
+				 "Cgroup v1 is not configured in kernel");
+		}
+		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	}
+
+out:
+	SAFE_MKDIR(new_path, 0777);
+
+	tst_res(TINFO, "Cgroup(%s) v1 mount at %s success", option, mnt_path);
+}
+
+static void tst_cgroup1_umount(const char *mnt_path, const char *new_path)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	if (!tst_is_mounted(mnt_path))
+		return;
+
+	/* Move all processes in task to its parent node. */
+	sprintf(s, "%s/tasks", mnt_path);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_res(TWARN | TERRNO, "open %s", s);
+
+	snprintf(s_new, BUFSIZ, "%s/tasks", new_path);
+	fp = fopen(s_new, "r");
+	if (fp == NULL)
+		tst_res(TWARN | TERRNO, "fopen %s", s_new);
+	if ((fd != -1) && (fp != NULL)) {
+		while (fgets(value, BUFSIZ, fp) != NULL)
+			if (write(fd, value, strlen(value) - 1)
+			    != (ssize_t)strlen(value) - 1)
+				tst_res(TWARN | TERRNO, "write %s", s);
+	}
+	if (fd != -1)
+		close(fd);
+	if (fp != NULL)
+		fclose(fp);
+	if (rmdir(new_path) == -1)
+		tst_res(TWARN | TERRNO, "rmdir %s", new_path);
+	if (umount(mnt_path) == -1)
+		tst_res(TWARN | TERRNO, "umount %s", mnt_path);
+	if (rmdir(mnt_path) == -1)
+		tst_res(TWARN | TERRNO, "rmdir %s", mnt_path);
+
+	tst_res(TINFO, "Cgroup v1 unmount success");
+}
+/* cgroup v1 */
+
+/* cgroup v2 */
+static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
+{
+	if (tst_is_mounted(mnt_path))
+		goto out;
+
+	SAFE_MKDIR(mnt_path, 0777);
+	if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
+		if (errno == ENODEV) {
+			if (rmdir(mnt_path) == -1)
+				tst_res(TWARN | TERRNO, "rmdir %s failed",
+					 mnt_path);
+			tst_brk(TCONF,
+				 "Cgroup v2 is not configured in kernel");
+		}
+		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	}
+
+out:
+	SAFE_MKDIR(new_path, 0777);
+
+	tst_res(TINFO, "Cgroup v2 mount at %s success", mnt_path);
+}
+
+static void tst_cgroup2_umount(const char *mnt_path, const char *new_path)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	if (!tst_is_mounted(mnt_path))
+		return;
+
+	/* Move all processes in cgroup.procs to its parent node. */
+	sprintf(s, "%s/cgroup.procs", mnt_path);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_res(TWARN | TERRNO, "open %s", s);
+
+	snprintf(s_new, BUFSIZ, "%s/cgroup.procs", new_path);
+	fp = fopen(s_new, "r");
+	if (fp == NULL)
+		tst_res(TWARN | TERRNO, "fopen %s", s_new);
+	if ((fd != -1) && (fp != NULL)) {
+		while (fgets(value, BUFSIZ, fp) != NULL)
+			if (write(fd, value, strlen(value) - 1)
+			    != (ssize_t)strlen(value) - 1)
+				tst_res(TWARN | TERRNO, "write %s", s);
+	}
+	if (fd != -1)
+		close(fd);
+	if (fp != NULL)
+		fclose(fp);
+	if (rmdir(new_path) == -1)
+		tst_res(TWARN | TERRNO, "rmdir %s", new_path);
+	if (umount(mnt_path) == -1)
+		tst_res(TWARN | TERRNO, "umount %s", mnt_path);
+	if (rmdir(mnt_path) == -1)
+		tst_res(TWARN | TERRNO, "rmdir %s", mnt_path);
+
+	tst_res(TINFO, "Cgroup v2 unmount success");
+}
+/* cgroup v2 */
+
+static enum tst_cgroup_ver tst_cg_ver;
+
+void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl)
+{
+	tst_cg_ver = tst_cgroup_version();
+
+	if (tst_cg_ver & TST_CGROUP_V1) {
+		switch(ctrl) {
+		case TST_CGROUP_MEMCG:
+			tst_cgroup1_mount("memcg", "memory", PATH_TMP_CG1_MEM, PATH_CG1_MEM_LTP);
+		break;
+		case TST_CGROUP_CPUSET:
+			tst_cgroup1_mount("cpusetcg", "cpuset", PATH_TMP_CG1_CST, PATH_CG1_CST_LTP);
+		break;
+		default:
+			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
+		}
+	}
+
+	if (tst_cg_ver & TST_CGROUP_V2) {
+		tst_cgroup2_mount(PATH_TMP_CGROUP2, PATH_TMP_CG2_LTP);
+
+		switch(ctrl) {
+		case TST_CGROUP_MEMCG:
+			SAFE_FILE_PRINTF(PATH_TMP_CGROUP2 "/cgroup.subtree_control", "%s", "+memory");
+		break;
+		case TST_CGROUP_CPUSET:
+			tst_brk(TCONF, "Cgroup v2 hasn't achieve cpuset subsystem");
+		break;
+		default:
+			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
+		}
+	}
+}
+
+void tst_cgroup_umount(enum tst_cgroup_ctrl ctrl)
+{
+	if (tst_cg_ver & TST_CGROUP_V1) {
+		switch(ctrl) {
+		case TST_CGROUP_MEMCG:
+			tst_cgroup1_umount(PATH_TMP_CG1_MEM, PATH_CG1_MEM_LTP);
+		break;
+		case TST_CGROUP_CPUSET:
+			tst_cgroup1_umount(PATH_TMP_CG1_CST, PATH_CG1_CST_LTP);
+		break;
+		default:
+			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
+		}
+	}
+
+	if (tst_cg_ver & TST_CGROUP_V2)
+		tst_cgroup2_umount(PATH_TMP_CGROUP2, PATH_TMP_CG2_LTP);
+}
+
+void tst_cgroup_move_current(enum tst_cgroup_ctrl ctrl)
+{
+	if (tst_cg_ver & TST_CGROUP_V1) {
+		switch(ctrl) {
+		case TST_CGROUP_MEMCG:
+			SAFE_FILE_PRINTF(PATH_CG1_MEM_LTP "/tasks", "%d", getpid());
+		break;
+		case TST_CGROUP_CPUSET:
+			SAFE_FILE_PRINTF(PATH_CG1_CST_LTP "/tasks", "%d", getpid());
+		break;
+		default:
+			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
+		}
+	}
+
+	if (tst_cg_ver & TST_CGROUP_V2)
+		SAFE_FILE_PRINTF(PATH_TMP_CG2_LTP "/cgroup.procs", "%d", getpid());
+}
+
+void tst_cgroup_mem_set_maxbytes(long memsz)
+{
+	tst_cgroup_move_current(TST_CGROUP_MEMCG);
+
+	if (tst_cg_ver & TST_CGROUP_V1)
+		SAFE_FILE_PRINTF(PATH_CG1_MEM_LTP "/memory.limit_in_bytes", "%ld", memsz);
+
+	if (tst_cg_ver & TST_CGROUP_V2)
+		SAFE_FILE_PRINTF(PATH_TMP_CG2_LTP "/memory.max", "%ld", memsz);
+}
+
+void tst_cgroup_mem_set_maxswap(long memsz)
+{
+	tst_cgroup_move_current(TST_CGROUP_MEMCG);
+
+	if (tst_cg_ver & TST_CGROUP_V1)
+		SAFE_FILE_PRINTF(PATH_CG1_MEM_LTP "/memory.memsw.limit_in_bytes", "%ld", memsz);
+	if (tst_cg_ver & TST_CGROUP_V2)
+		SAFE_FILE_PRINTF(PATH_TMP_CG2_LTP "/memory.swap.max", "%ld", memsz);
+}
-- 
2.21.1

