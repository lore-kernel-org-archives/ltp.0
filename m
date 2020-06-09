From: Li Wang <liwang@redhat.com>
Date: Tue,  9 Jun 2020 17:50:59 +0800
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
Message-ID: <20200609095102.21153-1-liwang@redhat.com>
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
    v3 --> v4
        * remove tst_cgroup_mnt/new_path
        * tst_cgroup_get_path() return a pointer to new_path
        * add tst_cgroup_cpuset_read/write_files()

 doc/test-writing-guidelines.txt |  44 ++++
 include/tst_cgroup.h            |  39 +++
 include/tst_test.h              |   1 +
 lib/newlib_tests/test21.c       |  76 ++++++
 lib/tst_cgroup.c                | 420 ++++++++++++++++++++++++++++++++
 5 files changed, 580 insertions(+)
 create mode 100644 include/tst_cgroup.h
 create mode 100644 lib/newlib_tests/test21.c
 create mode 100644 lib/tst_cgroup.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 93ca506d9..42b360da0 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2053,6 +2053,50 @@ the prefix field of file pointed by path equals to the value passed to this func
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
+	tst_cgroup_move_current(PATH_TMP_CG_MEM);
+	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
+
+	// do test under cgroup
+	...
+}
+
+static void setup(void)
+{
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+}
+
+static void cleanup(void)
+{
+	tst_cgroup_umount(PATH_TMP_CG_MEM);
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
index 000000000..0bc73b542
--- /dev/null
+++ b/include/tst_cgroup.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Red Hat, Inc.
+ * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ */
+
+#ifndef TST_CGROUP_H
+#define TST_CGROUP_H
+
+#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
+#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
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
+enum tst_cgroup_ver tst_cgroup_version(void);
+
+void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
+void tst_cgroup_umount(const char *cgroup_dir);
+
+void tst_cgroup_move_current(const char *cgroup_dir);
+void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
+
+void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
+int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
+void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
+
+void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename, char *retbuf);
+void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf);
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
diff --git a/lib/newlib_tests/test21.c b/lib/newlib_tests/test21.c
new file mode 100644
index 000000000..c3fa5584e
--- /dev/null
+++ b/lib/newlib_tests/test21.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Red Hat, Inc.
+ * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ */
+
+/*
+ * Tests tst_cgroup.h APIs
+ */
+
+#include "tst_test.h"
+#include "tst_cgroup.h"
+
+#define PATH_CGROUP1 "/mnt/liwang1"
+#define PATH_CGROUP2 "/mnt/liwang2"
+#define MEMSIZE 1024 * 1024
+
+static void do_test(void)
+{
+	/* we should assign one or more memory nodes to cpuset.mems
+	 * and cpuset.cpus, otherwise, echo $$ > tasks gives ?no space
+	 * left on device? when trying to use cpuset.
+	 *
+	 * Or, setting cgroup.clone_children to 1 can help in automatically
+	 * inheriting memory and node setting from parent cgroup when
+	 * a child cgroup is created.
+	 */
+	tst_cgroup_set_knob(PATH_TMP_CG_CST, "../cgroup.clone_children", 1);
+
+	pid_t pid = SAFE_FORK();
+
+	switch (pid) {
+	case 0:
+		tst_cgroup_move_current(PATH_CGROUP1);
+		tst_cgroup_mem_set_maxbytes(PATH_CGROUP1, MEMSIZE);
+		tst_cgroup_mem_set_maxswap(PATH_CGROUP1, MEMSIZE);
+
+		tst_cgroup_move_current(PATH_CGROUP2);
+
+	break;
+	default:
+		tst_cgroup_move_current(PATH_TMP_CG_CST);
+
+		tst_cgroup_move_current(PATH_TMP_CG_MEM);
+		tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
+		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, MEMSIZE);
+	break;
+	}
+
+	tst_res(TPASS, "Cgroup mount test");
+}
+
+static void setup(void)
+{
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_CGROUP1);
+
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_CGROUP2);
+}
+
+static void cleanup(void)
+{
+	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	tst_cgroup_umount(PATH_CGROUP1);
+
+	tst_cgroup_umount(PATH_TMP_CG_CST);
+	tst_cgroup_umount(PATH_CGROUP2);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
new file mode 100644
index 000000000..f918e7e85
--- /dev/null
+++ b/lib/tst_cgroup.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Red Hat, Inc.
+ * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_stdio.h"
+#include "tst_cgroup.h"
+#include "tst_device.h"
+
+static enum tst_cgroup_ver tst_cg_ver;
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
+static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
+{
+	if (tst_is_mounted(mnt_path))
+		goto out;
+
+	SAFE_MKDIR(mnt_path, 0777);
+	if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
+		if (errno == ENODEV) {
+			if (rmdir(mnt_path) == -1)
+				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
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
+static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	if (!tst_is_mounted(mnt_path))
+		return;
+
+	/* Move all processes in task(v2: cgroup.procs) to its parent node. */
+	if (tst_cg_ver & TST_CGROUP_V1)
+		sprintf(s, "%s/tasks", mnt_path);
+	if (tst_cg_ver & TST_CGROUP_V2)
+		sprintf(s, "%s/cgroup.procs", mnt_path);
+
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_res(TWARN | TERRNO, "open %s", s);
+
+	if (tst_cg_ver & TST_CGROUP_V1)
+		snprintf(s_new, BUFSIZ, "%s/tasks", new_path);
+	if (tst_cg_ver & TST_CGROUP_V2)
+		snprintf(s_new, BUFSIZ, "%s/cgroup.procs", new_path);
+
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
+	if (tst_cg_ver & TST_CGROUP_V1)
+		tst_res(TINFO, "Cgroup v1 unmount success");
+	if (tst_cg_ver & TST_CGROUP_V2)
+		tst_res(TINFO, "Cgroup v2 unmount success");
+}
+
+struct tst_cgroup_path {
+	char *mnt_path;
+	char *new_path;
+	struct tst_cgroup_path *next;
+};
+
+static struct tst_cgroup_path *tst_cgroup_paths;
+
+static void tst_cgroup_set_path(const char *cgroup_dir)
+{
+	char cgroup_new_dir[PATH_MAX];
+	struct tst_cgroup_path *tst_cgroup_path, *a;
+
+	if (!cgroup_dir)
+		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
+
+	sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
+
+	/* To store cgroup path in the 'path' list */
+	tst_cgroup_path = SAFE_MMAP(NULL, (sizeof(struct tst_cgroup_path)),
+			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	tst_cgroup_path->mnt_path = SAFE_MMAP(NULL, (strlen(cgroup_dir) + 1),
+			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	tst_cgroup_path->new_path = SAFE_MMAP(NULL, (strlen(cgroup_new_dir) + 1),
+			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (!tst_cgroup_paths) {
+		tst_cgroup_paths = tst_cgroup_path;
+	} else {
+		a = tst_cgroup_paths;
+		do {
+			if (!a->next) {
+				a->next = tst_cgroup_path;
+				break;
+			}
+			a = a->next;
+		} while (a);
+	}
+
+	sprintf(tst_cgroup_path->mnt_path, "%s", cgroup_dir);
+	sprintf(tst_cgroup_path->new_path, "%s", cgroup_new_dir);
+}
+
+static char *tst_cgroup_get_path(const char *cgroup_dir)
+{
+	struct tst_cgroup_path *a;
+
+	if (!tst_cgroup_paths)
+		return NULL;
+
+	a = tst_cgroup_paths;
+
+	while (strcmp(a->mnt_path, cgroup_dir) != 0){
+		if (!a->next) {
+			tst_res(TINFO, "%s is not found", cgroup_dir);
+			return NULL;
+		}
+		a = a->next;
+	};
+
+	return a->new_path;
+}
+
+static void tst_cgroup_del_path(const char *cgroup_dir)
+{
+	struct tst_cgroup_path *a, *b;
+
+	if (tst_cgroup_paths)
+		return;
+
+	a = b = tst_cgroup_paths;
+
+	while (strcmp(b->mnt_path, cgroup_dir) != 0) {
+		if (!b->next) {
+			tst_res(TINFO, "%s is not found", cgroup_dir);
+			return;
+		}
+		a = b;
+		b = b->next;
+	};
+
+	if (b == tst_cgroup_paths)
+		tst_cgroup_paths = b->next;
+	else
+		a->next = b->next;
+
+	SAFE_MUNMAP(b->mnt_path, sizeof(b->mnt_path));
+	SAFE_MUNMAP(b->new_path, sizeof(b->new_path));
+	SAFE_MUNMAP(b, sizeof(b));
+}
+
+void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir)
+{
+	char *cgroup_new_dir;
+	char knob_path[PATH_MAX];
+
+	tst_cg_ver = tst_cgroup_version();
+
+	tst_cgroup_set_path(cgroup_dir);
+	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+
+	if (tst_cg_ver & TST_CGROUP_V1) {
+		switch(ctrl) {
+		case TST_CGROUP_MEMCG:
+			tst_cgroup1_mount("memcg", "memory", cgroup_dir, cgroup_new_dir);
+		break;
+		case TST_CGROUP_CPUSET:
+			tst_cgroup1_mount("cpusetcg", "cpuset", cgroup_dir, cgroup_new_dir);
+		break;
+		default:
+			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
+		}
+	}
+
+	if (tst_cg_ver & TST_CGROUP_V2) {
+		tst_cgroup2_mount(cgroup_dir, cgroup_new_dir);
+
+		switch(ctrl) {
+		case TST_CGROUP_MEMCG:
+			sprintf(knob_path, "%s/cgroup.subtree_control", cgroup_dir);
+			SAFE_FILE_PRINTF(knob_path, "%s", "+memory");
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
+void tst_cgroup_umount(const char *cgroup_dir)
+{
+	char *cgroup_new_dir;
+
+	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
+	tst_cgroup_del_path(cgroup_dir);
+}
+
+void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value)
+{
+	char *cgroup_new_dir;
+	char knob_path[PATH_MAX];
+
+	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	sprintf(knob_path, "%s/%s", cgroup_new_dir, knob);
+	SAFE_FILE_PRINTF(knob_path, "%ld", value);
+}
+
+void tst_cgroup_move_current(const char *cgroup_dir)
+{
+	if (tst_cg_ver & TST_CGROUP_V1)
+		tst_cgroup_set_knob(cgroup_dir, "tasks", getpid());
+
+	if (tst_cg_ver & TST_CGROUP_V2)
+		tst_cgroup_set_knob(cgroup_dir, "cgroup.procs", getpid());
+}
+
+void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz)
+{
+	if (tst_cg_ver & TST_CGROUP_V1)
+		tst_cgroup_set_knob(cgroup_dir, "memory.limit_in_bytes", memsz);
+
+	if (tst_cg_ver & TST_CGROUP_V2)
+		tst_cgroup_set_knob(cgroup_dir, "memory.max", memsz);
+}
+
+int tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir)
+{
+	char *cgroup_new_dir;
+	char knob_path[PATH_MAX];
+
+	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+
+	if (tst_cg_ver & TST_CGROUP_V1) {
+		sprintf(knob_path, "%s/%s",
+				cgroup_new_dir, "/memory.memsw.limit_in_bytes");
+
+		if ((access(knob_path, F_OK) == -1)) {
+			if (errno == ENOENT)
+				tst_res(TCONF, "memcg swap accounting is disabled");
+			else
+				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
+		} else {
+			return 1;
+		}
+	}
+
+	if (tst_cg_ver & TST_CGROUP_V2) {
+		sprintf(knob_path, "%s/%s",
+				cgroup_new_dir, "/memory.swap.max");
+
+		if ((access(knob_path, F_OK) == -1)) {
+			if (errno == ENOENT)
+				tst_res(TCONF, "memcg swap accounting is disabled");
+			else
+				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
+		} else {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz)
+{
+	if (tst_cg_ver & TST_CGROUP_V1)
+		tst_cgroup_set_knob(cgroup_dir, "memory.memsw.limit_in_bytes", memsz);
+
+	if (tst_cg_ver & TST_CGROUP_V2)
+		tst_cgroup_set_knob(cgroup_dir, "memory.swap.max", memsz);
+}
+
+void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename, char *retbuf)
+{
+	int fd;
+	char *cgroup_new_dir;
+	char knob_path[PATH_MAX];
+
+	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+
+	/*
+	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
+	 * please see Documentation/cgroups/cpusets.txt from kernel src
+	 * for details
+	 */
+	sprintf(knob_path, "%s/%s", cgroup_new_dir, filename);
+	fd = open(knob_path, O_RDONLY);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			sprintf(knob_path, "%s/cpuset.%s",
+					cgroup_new_dir, filename);
+			fd = SAFE_OPEN(knob_path, O_RDONLY);
+		} else
+			tst_brk(TBROK | TERRNO, "open %s", knob_path);
+	}
+
+	if (read(fd, retbuf, sizeof(retbuf)) < 0)
+		tst_brk(TBROK | TERRNO, "read %s", knob_path);
+
+	close(fd);
+}
+
+void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf)
+{
+	int fd;
+	char *cgroup_new_dir;
+	char knob_path[PATH_MAX];
+
+	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+
+	/*
+	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
+	 * please see Documentation/cgroups/cpusets.txt from kernel src
+	 * for details
+	 */
+	sprintf(knob_path, "%s/%s", cgroup_new_dir, filename);
+	fd = open(knob_path, O_WRONLY);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			sprintf(knob_path, "%s/cpuset.%s", cgroup_new_dir, filename);
+			fd = SAFE_OPEN(knob_path, O_WRONLY);
+		} else
+			tst_brk(TBROK | TERRNO, "open %s", knob_path);
+	}
+
+	SAFE_WRITE(1, fd, buf, strlen(buf));
+
+	close(fd);
+}
-- 
2.21.1

