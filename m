From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 16 Dec 2020 10:01:18 +0000
Subject: [LTP] [RFC PATCH 2/5] CGroup API rewrite
In-Reply-To: <20201216100121.16683-1-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
Message-ID: <20201216100121.16683-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This builds on the work done by Li Wang, but with many additions and
changes. Instead of always creating a new CGroup mount, it scans the
current CGroup configuration and tries to use what is presently
available.

This is because remounting a CGroup rebinds an existing CGroup root to
a new mount point. If any of the mount options are different from the
current mount then the operation will fail. Most setups already have
CGroups mounted, but the CGroup configurations vary a lot.

So we have a choice of:

A) Expect a particular configuration and refuse to run
   otherwise
B) Expect no CGroups and mount them
C) Try to use what is available
D) (C) and try to mount them if nothing is present
E) (C), (D) and try to cleanup what we created

(A) and (B) are more simple for the LTP library, but require our users
to do more work, perhaps a lot more. Depending on the test
environment; disabling or reconfiguring CGroups may be
difficult. Because many tests require CGroups to expose a bug in other
subsystems (e.g. the memory subsystem), I do not think (A) and (B) are
viable options. They may be acceptable for testing core CGroup
features where a pristine system is required (e.g. first mount), but
that is not the current focus of these changes.

(C) is probably the simplest viable option, but this tries to
implement (E). Mounting the CGroups if none are available simplifies
testing within environments like Rapido where testing is done in the
recovery console and no CGroups are mounted by the system manager. On
the other hand it is quite simple for the user to mount some CGroups.

Mounting is relatively simple so does not add much complexity, however
cleaning up the mounts is broken so possibly we should only
attempt (C) or (D). It appears that the test process has some references to
the mount struct and so it can not be removed by the test, but I am
partly guessing. Using MNT_DETACH at least allows the directory to be
removed, but it's not clear if the root is eventually destroyed. It
appears that a separate process (i.e. the umount command) can properly
remove the mount and the CGroup is destroyed, but this is still not
fully clear without more tracing.

To allow tests to be run in parallel this also creates a new leaf
CGroup for each test. These are collected under the LTP trunk CGroup
which also contains a drain leaf CGroup. The library will create the
LTP CGroup if it is not present, but also the user can pre-create it
and grant write access to non-root users. This way tests which require
CGroups do not automatically require admin privileges. Please see the
comments within the code for more info.

This does not contain a declarative interface for tests to specify
CGroup options, like for e.g.

struct tst_test_ test = {
       .cgroups = {
       		{ SET, "memory.max", "10000" }
		{ SET, "cpuset.foo", "bar" }
		{ MOVE_CURRENT, NULL, NULL }
	},
	...
};

However something like this should be easy to add once enough tests
have been converted to the new API.
---
 include/tst_cgroup.h | 103 ++++-
 lib/tst_cgroup.c     | 960 ++++++++++++++++++++++++++++---------------
 2 files changed, 701 insertions(+), 362 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index bfd848260..4c3eb483a 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -2,46 +2,105 @@
 /*
  * Copyright (c) 2020 Red Hat, Inc.
  * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ * Copyright (c) 2020 Richard Palethorpe <rpalethorpe@suse.com>
  */
 
 #ifndef TST_CGROUP_H
 #define TST_CGROUP_H
 
-#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
-#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
-
 enum tst_cgroup_ver {
 	TST_CGROUP_V1 = 1,
 	TST_CGROUP_V2 = 2,
 };
 
 enum tst_cgroup_ctrl {
-	TST_CGROUP_MEMCG = 1,
+	TST_CGROUP_MEMORY = 1,
 	TST_CGROUP_CPUSET = 2,
-	/* add cgroup controller */
+};
+#define TST_CGROUP_MAX TST_CGROUP_CPUSET
+
+/* The level of CGroup cleanup which will be attempted after the
+ * test. When running tests in parallel you should select
+ * TST_CGORUP_CLEANUP_{TEST,NONE}. Note that we only try to cleanup
+ * CGroups we mounted/created in the current test.
+ */
+enum tst_cgroup_cleanup {
+	/* Unmount the CGroup roots */
+	TST_CGROUP_CLEANUP_ROOT,
+	/* Cleanup up test CGroups and the overall LTP CGroup */
+	TST_CGROUP_CLEANUP_LTP,
+	/* Cleanup up individual test CGroups */
+	TST_CGROUP_CLEANUP_TEST,
+	/* Don't drain or delete any groups, including the individual
+	 * test CGroups
+	 */
+	TST_CGROUP_CLEANUP_NONE,
 };
 
-enum tst_cgroup_ver tst_cgroup_version(void);
+/* Used to specify CGroup hierarchy configuration options, allowing a
+ * test to request a particular CGroup structure.
+ *
+ * It is expected this will expand to include options for changing
+ * things such as the cgroup names, threading, inheritance etc.
+ */
+struct tst_cgroup_opts {
+	/* Only try to mount V1 CGroup controllers. This will not
+	 * prevent V2 from being used if it is already mounted, it
+	 * only indicates that we should mount V1 controllers if
+	 * nothing is present. By default we try to mount V2 first. */
+	int only_mount_v1:1;
+	enum tst_cgroup_cleanup cleanup;
+};
 
-/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
-void tst_cgroup_umount(const char *cgroup_dir);
+/* Search the system for mounted cgroups and available
+ * controllers. Called automatically by tst_cgroup_require.
+ */
+void tst_cgroup_scan(void);
+/* Print the config detected by tst_cgroup_scan */
+void tst_cgroup_print_config(void);
 
-/* To move current process PID to the mounted cgroup tasks */
-void tst_cgroup_move_current(const char *cgroup_dir);
+/* Read from a controller file in the test's default CGroup. Use
+ * tst_cgroup_require to ensure the specified controller is active on
+ * the test's default CGroup
+ */
+#define SAFE_CGROUP_READ(type, path, buf, nbyte) \
+	safe_cgroup_printf(__FILE__, __LINE__, (type), (path), (buf), (nbyte))
 
-/* To set cgroup controller knob with new value */
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+			 enum tst_cgroup_ctrl type,
+			 const char *path, char *buf, size_t nbyte);
 
-/* Set of functions to set knobs under the memory controller */
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
-int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
+/* Print to a control file in the test's default CGroup */
+#define SAFE_CGROUP_PRINTF(type, path, fmt, ...) \
+	safe_cgroup_printf(__FILE__, __LINE__, (type), (path), (fmt), __VA_ARGS__)
 
-/* Set of functions to read/write cpuset controller files content */
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz);
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename,
-	const char *buf);
+void safe_cgroup_printf(const char *file, const int lineno,
+			enum tst_cgroup_ctrl type,
+			const char *path, const char *fmt, ...)
+			__attribute__ ((format (printf, 5, 6)));
+
+/* Ensure the specified controller is available in the test's default
+ * CGroup, mounting/enabling it if necessary */
+void tst_cgroup_require(enum tst_cgroup_ctrl type,
+			const struct tst_cgroup_opts *options);
+
+/* Tear down any CGroups created by calls to tst_cgroup_require */
+void tst_cgroup_cleanup(const struct tst_cgroup_opts *options);
+
+/* Move the current process to the test's default CGroup */
+void tst_cgroup_move_current(enum tst_cgroup_ctrl type);
+
+/* Set of functions to set knobs under the test's default memory
+ * controller.
+ */
+void tst_cgroup_mem_set_maxbytes(size_t memsz);
+int  tst_cgroup_mem_swapacct_enabled(void);
+void tst_cgroup_mem_set_maxswap(size_t memsz);
+
+/* Set of functions to read/write the test's default cpuset controller
+ * files content.
+ */
+void tst_cgroup_cpuset_read_files(const char *name, char *buf, size_t nbyte);
+void tst_cgroup_cpuset_write_files(const char *name, const char *buf);
 
 #endif /* TST_CGROUP_H */
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 96c9524d2..87c980a56 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -2,453 +2,733 @@
 /*
  * Copyright (c) 2020 Red Hat, Inc.
  * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ * Copyright (c) 2020 Richard Palethorpe <rpalethorpe@suse.com>
  */
 
 #define TST_NO_DEFAULT_MAIN
 
 #include <stdio.h>
-#include <stdlib.h>
+#include <mntent.h>
 #include <sys/mount.h>
-#include <fcntl.h>
-#include <unistd.h>
 
 #include "tst_test.h"
-#include "tst_safe_macros.h"
-#include "tst_safe_stdio.h"
+#include "lapi/fcntl.h"
+#include "lapi/mount.h"
 #include "tst_cgroup.h"
-#include "tst_device.h"
 
-static enum tst_cgroup_ver tst_cg_ver;
-static int clone_children;
+/* At most we can have one cgroup V1 tree for each controller and one
+ * (empty) v2 tree.
+ */
+#define TST_CGROUP_MAX_TREES (TST_CGROUP_MAX + 1)
+
+/* CGroup tree */
+struct tst_cgroup_root {
+	enum tst_cgroup_ver ver;
+	/* Mount path */
+	char path[PATH_MAX/2];
+	/* Subsystems (controllers) bit field */
+	uint32_t ss_field;
+
+	/* Path FDs for use with openat syscalls */
+	/* Mount directory */
+	int mnt_dir;
+	/* LTP CGroup directory, contains drain and test dirs */
+	int ltp_dir;
+	/* Drain CGroup, see tst_cgroup_cleanup */
+	int drain_dir;
+	/* CGroup for current test */
+	int tst_dir;
+
+	int we_mounted_it:1;
+	int we_created_ltp_dir:1;
+	/* cpuset is in compatability mode */
+	int no_prefix:1;
+};
+
+/* 'ss' stands for subsystem which is the same as 'controller' */
+struct tst_cgroup_ss {
+	enum tst_cgroup_ctrl indx;
+	const char *name;
+	struct tst_cgroup_root *tree;
+};
+
+struct tst_cgroup_features {
+	const char *memory_max_name;
+	const char *memory_max_swap_name;
+	int memory_has_kmem:1;
+	int memory_has_swap:1;
+};
+
+/* Always use first item for unified hierarchy */
+static struct tst_cgroup_root trees[TST_CGROUP_MAX_TREES + 1];
+
+static struct tst_cgroup_ss css[TST_CGROUP_MAX + 1] = {
+	{ TST_CGROUP_MEMORY, "memory", NULL },
+	{ TST_CGROUP_CPUSET, "cpuset", NULL },
+};
+
+static const struct tst_cgroup_opts default_opts = { 0 };
+static struct tst_cgroup_features features;
+
+static const char *ltp_cgroup_dir = "ltp";
+static const char *ltp_cgroup_drain_dir = "drain";
+static char test_cgroup_dir[PATH_MAX/4];
+static const char *ltp_mount_prefix = "/tmp/cgroup_";
+static const char *ltp_v2_mount = "unified";
 
-static int tst_cgroup_check(const char *cgroup)
+#define tst_for_each_v1_root(t) \
+	for ((t) = trees + 1; (t)->ver; (t)++)
+#define tst_for_each_root(t) \
+	for ((t) = trees[0].ver ? trees : trees + 1; (t)->ver; (t)++)
+#define tst_for_each_css(ss) for ((ss) = css; (ss)->indx; (ss)++)
+
+static int tst_cgroup_v2_mounted(void)
 {
-	char line[PATH_MAX];
-	FILE *file;
-	int cg_check = 0;
-
-	file = SAFE_FOPEN("/proc/filesystems", "r");
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, cgroup) != NULL) {
-			cg_check = 1;
-			break;
-		}
-	}
-	SAFE_FCLOSE(file);
+	return !!trees[0].path[0];
+}
+
+static struct tst_cgroup_ss *tst_cgroup_get_ss(enum tst_cgroup_ctrl type)
+{
+	return &css[type - 1];
+}
 
-	return cg_check;
+static int tst_cgroup_ss_on_v2(const struct tst_cgroup_ss *ss)
+{
+	return ss->tree->ver == TST_CGROUP_V2;
 }
 
-enum tst_cgroup_ver tst_cgroup_version(void)
+void tst_cgroup_print_config(void)
 {
-        enum tst_cgroup_ver cg_ver;
+	struct tst_cgroup_root *t;
+	struct tst_cgroup_ss *ss;
 
-        if (tst_cgroup_check("cgroup2")) {
-                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
-                        cg_ver = TST_CGROUP_V1;
-                else
-                        cg_ver = TST_CGROUP_V2;
+	tst_res(TINFO, "Detected Controllers:");
 
-                goto out;
-        }
+	tst_for_each_css(ss) {
+		t = ss->tree;
 
-        if (tst_cgroup_check("cgroup"))
-                cg_ver = TST_CGROUP_V1;
+		if (!t)
+			continue;
 
-        if (!cg_ver)
-                tst_brk(TCONF, "Cgroup is not configured");
+		tst_res(TINFO, "\t%.10s %s @ %s:%s",
+			ss->name,
+			t->no_prefix ? "[noprefix]" : "",
+			t->ver == TST_CGROUP_V1 ? "V1" : "V2",
+			t->path);
+	}
 
-out:
-        return cg_ver;
+	if (!(features.memory_has_kmem || features.memory_has_swap))
+		return;
+
+	tst_res(TINFO, "Detected Feature flags: %s%s",
+		features.memory_has_kmem ? "kmem " : "",
+		features.memory_has_swap ? "swap" : "");
 }
 
-static void tst_cgroup1_mount(const char *name, const char *option,
-			const char *mnt_path, const char *new_path)
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+		      enum tst_cgroup_ctrl type,
+		      const char *path, char *buf, size_t nbyte)
 {
-	char knob_path[PATH_MAX];
-	if (tst_is_mounted(mnt_path))
-		goto out;
-
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v1 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
-	}
+	return safe_file_readat(file, lineno,
+				tst_cgroup_get_ss(type)->tree->tst_dir,
+				path, buf, nbyte);
+}
 
-	/*
-	 * We should assign one or more memory nodes to cpuset.mems and
-	 * cpuset.cpus, otherwise, echo $$ > tasks gives ?ENOSPC: no space
-	 * left on device? when trying to use cpuset.
-	 *
-	 * Or, setting cgroup.clone_children to 1 can help in automatically
-	 * inheriting memory and node setting from parent cgroup when a
-	 * child cgroup is created.
-	 */
-	if (strcmp(option, "cpuset") == 0) {
-		sprintf(knob_path, "%s/cgroup.clone_children", mnt_path);
-		SAFE_FILE_SCANF(knob_path, "%d", &clone_children);
-		SAFE_FILE_PRINTF(knob_path, "%d", 1);
-	}
-out:
-	SAFE_MKDIR(new_path, 0777);
+void safe_cgroup_printf(const char *file, const int lineno,
+			enum tst_cgroup_ctrl type,
+			const char *path, const char *fmt, ...)
+{
+	struct tst_cgroup_ss *ss = tst_cgroup_get_ss(type);
+	va_list va;
 
-	tst_res(TINFO, "Cgroup(%s) v1 mount at %s success", option, mnt_path);
+	va_start(va, fmt);
+	safe_file_vprintfat(file, lineno, ss->tree->tst_dir, path, fmt, va);
+	va_end(va);
 }
 
-static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
+void tst_cgroup_move_current(enum tst_cgroup_ctrl type)
 {
-	if (tst_is_mounted(mnt_path))
-		goto out;
-
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v2 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
-	}
-
-out:
-	SAFE_MKDIR(new_path, 0777);
+	if (tst_cgroup_ss_on_v2(tst_cgroup_get_ss(type)))
+		SAFE_CGROUP_PRINTF(type, "cgroup.procs", "%d", getpid());
+	else
+		SAFE_CGROUP_PRINTF(type, "tasks", "%d", getpid());
+}
 
-	tst_res(TINFO, "Cgroup v2 mount at %s success", mnt_path);
+void tst_cgroup_mem_set_maxbytes(size_t memsz)
+{
+	SAFE_CGROUP_PRINTF(TST_CGROUP_MEMORY,
+			   features.memory_max_name, "%zu", memsz);
 }
 
-static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
+int tst_cgroup_mem_swapacct_enabled(void)
 {
-	FILE *fp;
-	int fd;
-	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
-	char knob_path[PATH_MAX];
+	if (!features.memory_has_swap)
+		tst_res(TCONF, "memcg swap accounting is disabled");
 
-	if (!tst_is_mounted(mnt_path))
+	return features.memory_has_swap;
+}
+
+void tst_cgroup_mem_set_maxswap(size_t memsz)
+{
+	if (!features.memory_has_swap)
 		return;
 
-	/* Move all processes in task(v2: cgroup.procs) to its parent node. */
-	if (tst_cg_ver & TST_CGROUP_V1)
-		sprintf(s, "%s/tasks", mnt_path);
-	if (tst_cg_ver & TST_CGROUP_V2)
-		sprintf(s, "%s/cgroup.procs", mnt_path);
-
-	fd = open(s, O_WRONLY);
-	if (fd == -1)
-		tst_res(TWARN | TERRNO, "open %s", s);
-
-	if (tst_cg_ver & TST_CGROUP_V1)
-		snprintf(s_new, BUFSIZ, "%s/tasks", new_path);
-	if (tst_cg_ver & TST_CGROUP_V2)
-		snprintf(s_new, BUFSIZ, "%s/cgroup.procs", new_path);
-
-	fp = fopen(s_new, "r");
-	if (fp == NULL)
-		tst_res(TWARN | TERRNO, "fopen %s", s_new);
-	if ((fd != -1) && (fp != NULL)) {
-		while (fgets(value, BUFSIZ, fp) != NULL)
-			if (write(fd, value, strlen(value) - 1)
-			    != (ssize_t)strlen(value) - 1)
-				tst_res(TWARN | TERRNO, "write %s", s);
-	}
-	if (tst_cg_ver & TST_CGROUP_V1) {
-		sprintf(knob_path, "%s/cpuset.cpus", mnt_path);
-		if (!access(knob_path, F_OK)) {
-			sprintf(knob_path, "%s/cgroup.clone_children", mnt_path);
-			SAFE_FILE_PRINTF(knob_path, "%d", clone_children);
-		}
+	SAFE_CGROUP_PRINTF(TST_CGROUP_MEMORY,
+			   features.memory_max_swap_name, "%zu", memsz);
+}
+
+static void tst_cgroup_cpuset_path(const char *name, char *buf)
+{
+	struct tst_cgroup_ss *ss = tst_cgroup_get_ss(TST_CGROUP_CPUSET);
+	char *path = buf;
+
+	if (!ss->tree->no_prefix) {
+		strcpy(buf, "cpuset.");
+		path += strlen(buf);
 	}
-	if (fd != -1)
-		close(fd);
-	if (fp != NULL)
-		fclose(fp);
-	if (rmdir(new_path) == -1)
-		tst_res(TWARN | TERRNO, "rmdir %s", new_path);
-	if (umount(mnt_path) == -1)
-		tst_res(TWARN | TERRNO, "umount %s", mnt_path);
-	if (rmdir(mnt_path) == -1)
-		tst_res(TWARN | TERRNO, "rmdir %s", mnt_path);
-
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_res(TINFO, "Cgroup v1 unmount success");
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_res(TINFO, "Cgroup v2 unmount success");
+
+	strcpy(path, name);
 }
 
-struct tst_cgroup_path {
-	char *mnt_path;
-	char *new_path;
-	struct tst_cgroup_path *next;
-};
+void tst_cgroup_cpuset_read_files(const char *name, char *buf, size_t nbyte)
+{
+	char path[PATH_MAX/4];
 
-static struct tst_cgroup_path *tst_cgroup_paths;
+	tst_cgroup_cpuset_path(name, path);
+	SAFE_CGROUP_READ(TST_CGROUP_CPUSET, path, buf, nbyte);
+}
 
-static void tst_cgroup_set_path(const char *cgroup_dir)
+void tst_cgroup_cpuset_write_files(const char *name, const char *buf)
 {
-	char cgroup_new_dir[PATH_MAX];
-	struct tst_cgroup_path *tst_cgroup_path, *a;
 
-	if (!cgroup_dir)
-		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
+	char path[PATH_MAX/4];
 
-	sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
+	tst_cgroup_cpuset_path(name, path);
+	SAFE_CGROUP_PRINTF(TST_CGROUP_CPUSET, path, "%s", buf);
+}
 
-	/* To store cgroup path in the 'path' list */
-	tst_cgroup_path = SAFE_MALLOC(sizeof(struct tst_cgroup_path));
-	tst_cgroup_path->mnt_path = SAFE_MALLOC(strlen(cgroup_dir) + 1);
-	tst_cgroup_path->new_path = SAFE_MALLOC(strlen(cgroup_new_dir) + 1);
-	tst_cgroup_path->next = NULL;
+/* Determine if a mounted cgroup hierarchy (tree) is unique and record it if so.
+ *
+ * For CGroups V2 this is very simple as there is only one
+ * hierarchy. We just record which controllers are available and check
+ * if this matches what we read from any previous mounts to verify our
+ * own logic (and possibly detect races).
+ *
+ * For V1 the set of controllers S is partitioned into sets {P_1, P_2,
+ * ..., P_n} with one or more controllers in each partion. Each
+ * partition P_n can be mounted multiple times, but the same
+ * controller can not appear in more than one partition. Usually each
+ * partition contains a single controller, but, for example, cpu and
+ * cpuacct are often mounted together in the same partiion.
+ *
+ * Each controller partition has its own hierarchy/root/tree which we
+ * must track and update independently.
+ */
+static void tst_cgroup_get_tree(const char *type, const char *path, char *opts)
+{
+	struct tst_cgroup_root *t = trees;
+	struct tst_cgroup_ss *c;
+	uint32_t ss_field = 0;
+	int no_prefix = 0;
+	char buf[BUFSIZ];
+	char *tok;
+	int dfd = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
+
+	if (!strcmp(type, "cgroup"))
+		goto v1;
+
+	SAFE_FILE_READAT(dfd, "cgroup.controllers", buf, sizeof(buf));
+
+	for (tok = strtok(buf, " "); tok; tok = strtok(NULL, " ")) {
+		tst_for_each_css(c)
+			ss_field |= (!strcmp(c->name, tok)) << c->indx;
+	}
 
-	if (!tst_cgroup_paths) {
-		tst_cgroup_paths = tst_cgroup_path;
-	} else {
-		a = tst_cgroup_paths;
-		do {
-			if (!a->next) {
-				a->next = tst_cgroup_path;
-				break;
-			}
-			a = a->next;
-		} while (a);
+	if (t->ver && ss_field == t->ss_field)
+		goto discard;
+
+	if (t->ss_field)
+		tst_brk(TBROK, "Available V2 controllers are changing between scans?");
+
+	t->ver = TST_CGROUP_V2;
+
+	goto backref;
+
+v1:
+	for (tok = strtok(opts, ","); tok; tok = strtok(NULL, ",")) {
+		tst_for_each_css(c)
+			ss_field |= (!strcmp(c->name, tok)) << c->indx;
+
+		no_prefix |= !strcmp("noprefix", tok);
+	}
+
+	if (!ss_field)
+		goto discard;
+
+	tst_for_each_v1_root(t) {
+		if (!(ss_field & t->ss_field))
+			continue;
+
+		if (ss_field == t->ss_field)
+			goto discard;
+
+		tst_brk(TBROK,
+			"The intersection of two distinct sets of mounted controllers should be null?"
+			"Check '%s' and '%s'", t->path, path);
 	}
 
-	sprintf(tst_cgroup_path->mnt_path, "%s", cgroup_dir);
-	sprintf(tst_cgroup_path->new_path, "%s", cgroup_new_dir);
+	if (t >= trees + TST_CGROUP_MAX_TREES) {
+		tst_brk(TBROK, "Unique controller mounts have exceeded our limit %d?",
+			TST_CGROUP_MAX_TREES);
+	}
+
+	t->ver = TST_CGROUP_V1;
+
+backref:
+	strcpy(t->path, path);
+	t->mnt_dir = dfd;
+	t->ss_field = ss_field;
+	t->no_prefix = no_prefix;
+
+	tst_for_each_css(c) {
+		if (t->ss_field & (1 << c->indx))
+			c->tree = t;
+	}
+
+	return;
+
+discard:
+	close(dfd);
 }
 
-static char *tst_cgroup_get_path(const char *cgroup_dir)
+void tst_cgroup_scan(void)
 {
-	struct tst_cgroup_path *a;
+	struct mntent *mnt;
+	FILE *f = setmntent("/proc/self/mounts", "r");
 
-	if (!tst_cgroup_paths)
-		return NULL;
+	if (!f)
+		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
 
-	a = tst_cgroup_paths;
+	mnt = getmntent(f);
+	if (!mnt)
+		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
 
-	while (strcmp(a->mnt_path, cgroup_dir) != 0){
-		if (!a->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return NULL;
-		}
-		a = a->next;
-	};
+	do {
+		if (strncmp(mnt->mnt_type, "cgroup", 6))
+			continue;
 
-	return a->new_path;
+		tst_cgroup_get_tree(mnt->mnt_type, mnt->mnt_dir, mnt->mnt_opts);
+	} while ((mnt = getmntent(f)));
 }
 
-static void tst_cgroup_del_path(const char *cgroup_dir)
+static void tst_cgroup_mount_v2(void)
 {
-	struct tst_cgroup_path *a, *b;
+	char path[PATH_MAX];
+	int made_dir = 0;
+
+	sprintf(path, "%s%s", ltp_mount_prefix, ltp_v2_mount);
+
+	if (!mkdir(path, 0777)) {
+		made_dir = 1;
+		goto mount;
+	}
+
+	if (errno == EEXIST)
+		goto mount;
 
-	if (!tst_cgroup_paths)
+	if (errno == EACCES) {
+		tst_res(TINFO | TERRNO,
+			"Lack permission to make %s, premake it or run as root",
+			path);
 		return;
+	}
 
-	a = b = tst_cgroup_paths;
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
 
-	while (strcmp(b->mnt_path, cgroup_dir) != 0) {
-		if (!b->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return;
-		}
-		a = b;
-		b = b->next;
-	};
+mount:
+	if (!mount("cgroup2", path, "cgroup2", 0, NULL)) {
+		tst_res(TINFO, "Mounted V2 CGroups on %s", path);
+		tst_cgroup_scan();
+		trees[0].we_mounted_it = 1;
+		return;
+	}
 
-	if (b == tst_cgroup_paths)
-		tst_cgroup_paths = b->next;
-	else
-		a->next = b->next;
+	tst_res(TINFO | TERRNO, "Could not mount V2 CGroups on %s", path);
 
-	free(b->mnt_path);
-	free(b->new_path);
-	free(b);
+	if (made_dir)
+		SAFE_RMDIR(path);
 }
 
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir)
+static void tst_cgroup_mount_v1(enum tst_cgroup_ctrl type)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
-
-	tst_cg_ver = tst_cgroup_version();
-
-	tst_cgroup_set_path(cgroup_dir);
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-
-	if (tst_cg_ver & TST_CGROUP_V1) {
-		switch(ctrl) {
-		case TST_CGROUP_MEMCG:
-			tst_cgroup1_mount("memcg", "memory", cgroup_dir, cgroup_new_dir);
-		break;
-		case TST_CGROUP_CPUSET:
-			tst_cgroup1_mount("cpusetcg", "cpuset", cgroup_dir, cgroup_new_dir);
-		break;
-		default:
-			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
-		}
+	struct tst_cgroup_ss *ss = tst_cgroup_get_ss(type);
+	char path[PATH_MAX];
+	int made_dir = 0;
+
+	sprintf(path, "%s%s", ltp_mount_prefix, ss->name);
+
+	if (!mkdir(path, 0777)) {
+		made_dir = 1;
+		goto mount;
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		tst_cgroup2_mount(cgroup_dir, cgroup_new_dir);
-
-		switch(ctrl) {
-		case TST_CGROUP_MEMCG:
-			sprintf(knob_path, "%s/cgroup.subtree_control", cgroup_dir);
-			SAFE_FILE_PRINTF(knob_path, "%s", "+memory");
-		break;
-		case TST_CGROUP_CPUSET:
-			tst_brk(TCONF, "Cgroup v2 hasn't achieve cpuset subsystem");
-		break;
-		default:
-			tst_brk(TBROK, "Invalid cgroup controller: %d", ctrl);
-		}
+	if (errno == EEXIST)
+		goto mount;
+
+	if (errno == EACCES) {
+		tst_res(TINFO | TERRNO,
+			"Lack permission to make %s, premake it or run as root",
+			path);
+		return;
 	}
-}
 
-void tst_cgroup_umount(const char *cgroup_dir)
-{
-	char *cgroup_new_dir;
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
-	tst_cgroup_del_path(cgroup_dir);
+mount:
+	if (mount(ss->name, path, "cgroup", 0, ss->name)) {
+		tst_res(TINFO | TERRNO,
+			"Could not mount V1 CGroup on %s", path);
+
+		if (made_dir)
+			SAFE_RMDIR(path);
+		return;
+	}
+
+	tst_res(TINFO, "Mounted V1 %s CGroup on %s", ss->name, path);
+	tst_cgroup_scan();
+	ss->tree->we_mounted_it = 1;
+	if (type == TST_CGROUP_MEMORY) {
+		SAFE_FILE_PRINTFAT(ss->tree->mnt_dir,
+				   "memory.use_hierarchy", "%d", 1);
+	}
 }
 
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value)
+static int tst_cgroup_exists(struct tst_cgroup_ss *ss, const char *path)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	int ret = faccessat(ss->tree->tst_dir, path, F_OK, 0);
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	sprintf(knob_path, "%s/%s", cgroup_new_dir, knob);
-	SAFE_FILE_PRINTF(knob_path, "%ld", value);
+	if (!ret)
+		return 1;
+
+	if (errno == ENOENT)
+		return 0;
+
+	tst_brk(TBROK | TERRNO, "faccessat(%d, %s, F_OK, 0)",
+		ss->tree->tst_dir, path);
+
+	return 0;
 }
 
-void tst_cgroup_move_current(const char *cgroup_dir)
+static void tst_cgroup_scan_features(enum tst_cgroup_ctrl type)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "tasks", getpid());
+	struct tst_cgroup_ss *ss = tst_cgroup_get_ss(type);
+
+	if (type == TST_CGROUP_MEMORY) {
+		if (ss->tree->ver == TST_CGROUP_V1) {
+			features.memory_max_name = "memory.limit_in_bytes";
+			features.memory_max_swap_name =
+				"memory.memsw.limit_in_bytes";
+		} else {
+			features.memory_max_name = "memory.max";
+			features.memory_max_swap_name = "memory.swap.max";
+		}
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "cgroup.procs", getpid());
+		features.memory_has_kmem =
+			tst_cgroup_exists(ss, "memory.kmem.limit_in_bytes");
+		features.memory_has_swap =
+			tst_cgroup_exists(ss, features.memory_max_swap_name);
+	}
 }
 
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz)
+static void tst_cgroup_copy_cpuset(struct tst_cgroup_root *t)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.limit_in_bytes", memsz);
+	char buf[BUFSIZ];
+	const char *mems = t->no_prefix ? "mems" : "cpuset.mems";
+	const char *cpus = t->no_prefix ? "cpus" : "cpuset.cpus";
+
+
+	SAFE_FILE_READAT(t->mnt_dir, mems, buf, sizeof(buf));
+	SAFE_FILE_PRINTFAT(t->ltp_dir, mems, "%s", buf);
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.max", memsz);
+	SAFE_FILE_READAT(t->mnt_dir, cpus, buf, sizeof(buf));
+	SAFE_FILE_PRINTFAT(t->ltp_dir, cpus, "%s", buf);
 }
 
-int tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir)
+/* Ensure the specified controller is available and contains the LTP group
+ *
+ * First we check if the specified controller has a known mount point,
+ * if not then we scan the system. If we find it then we goto ensuring
+ * the LTP group exists in the hierarchy the controller is using.
+ *
+ * If we can't find the controller, then we try to create it. First we
+ * check if the V2 hierarchy/tree is mounted. If it isn't then we try
+ * mounting it and look for the controller. If it is already mounted
+ * then we know the controller is not available on V2 on this system.
+ *
+ * If we can't mount V2 or the controller is not on V2, then we try
+ * mounting it on its own V1 tree.
+ *
+ * Once we have mounted the controller somehow, we create hierarchy of
+ * cgroups. If we are on V2 we first need to enable the controller for
+ * all subtrees in root. Then we create the following hierarchy.
+ *
+ * ltp -> test_<pid>
+ *
+ * Having a cgroup per test allows tests to be run in parallel. The
+ * LTP group could allow for tests to run with less privileges if it
+ * is pre-setup for us.
+ *
+ * If we are using V1 cpuset then we copy the available mems and cpus
+ * from root to the ltp group and set clone_children on the ltp group
+ * to distribute these settings to the test cgroups. This means the
+ * test author does not have to copy these settings before using the
+ * cpuset.
+ *
+ */
+void tst_cgroup_require(enum tst_cgroup_ctrl type,
+			const struct tst_cgroup_opts *options)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	struct tst_cgroup_ss *ss = tst_cgroup_get_ss(type);
+	struct tst_cgroup_root *t;
+	char path[PATH_MAX];
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	if (!options)
+		options = &default_opts;
 
-	if (tst_cg_ver & TST_CGROUP_V1) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.memsw.limit_in_bytes");
+	if (ss->tree)
+		goto ltpdir;
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+	tst_cgroup_scan();
+
+	if (ss->tree)
+		goto ltpdir;
+
+	if (!tst_cgroup_v2_mounted() && !options->only_mount_v1)
+		tst_cgroup_mount_v2();
+
+	if (ss->tree)
+		goto ltpdir;
+
+	tst_cgroup_mount_v1(type);
+
+	if (!ss->tree) {
+		tst_brk(TCONF,
+			"%s controller required, but not available", ss->name);
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.swap.max");
+ltpdir:
+	t = ss->tree;
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+	if (tst_cgroup_ss_on_v2(ss)) {
+		tst_file_printfat(t->mnt_dir, "cgroup.subtree_control",
+				  "+%s", ss->name);
 	}
 
-	return 0;
+	sprintf(path, "%s/%s", t->path, ltp_cgroup_dir);
+
+	if (!mkdir(path, 0777)) {
+		t->we_created_ltp_dir = 1;
+		goto draindir;
+	}
+
+	if (errno == EEXIST)
+		goto draindir;
+
+	if (errno == EACCES) {
+		tst_brk(TCONF | TERRNO,
+			"Lack permission to make %s; premake it or run as root",
+			path);
+	}
+
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
+draindir:
+	if (!t->ltp_dir)
+		t->ltp_dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
+
+	if (tst_cgroup_ss_on_v2(ss)) {
+		SAFE_FILE_PRINTFAT(t->ltp_dir, "cgroup.subtree_control",
+				   "+%s", ss->name);
+	} else {
+		SAFE_FILE_PRINTFAT(t->ltp_dir, "cgroup.clone_children",
+				   "%d", 1);
+
+		if (type == TST_CGROUP_CPUSET)
+			tst_cgroup_copy_cpuset(t);
+	}
+
+	sprintf(path, "%s/%s/%s",
+		t->path, ltp_cgroup_dir, ltp_cgroup_drain_dir);
+
+	if (!mkdir(path, 0777) || errno == EEXIST)
+		goto testdir;
+
+	if (errno == EACCES) {
+		tst_brk(TCONF | TERRNO,
+			"Lack permission to make %s; grant access or run as root",
+			path);
+	}
+
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
+testdir:
+	if (!t->drain_dir)
+		t->drain_dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
+
+	if (!test_cgroup_dir[0])
+		sprintf(test_cgroup_dir, "test-%d", getpid());
+
+	sprintf(path, "%s/%s/%s",
+		ss->tree->path, ltp_cgroup_dir, test_cgroup_dir);
+
+	if (!mkdir(path, 0777) || errno == EEXIST)
+		goto scan;
+
+	if (errno == EACCES) {
+		tst_brk(TCONF | TERRNO,
+			"Lack permission to make %s; grant access or run as root",
+			path);
+	}
+
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
+scan:
+	if (!t->tst_dir)
+		t->tst_dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY);
+
+	tst_cgroup_scan_features(type);
 }
 
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz)
+static void tst_cgroup_drain(enum tst_cgroup_ver ver, int source, int dest)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.memsw.limit_in_bytes", memsz);
+	char buf[BUFSIZ];
+	char *tok;
+	const char *fname = ver == TST_CGROUP_V1 ? "tasks" : "cgroup.procs";
+	int fd, ret;
+
+	SAFE_FILE_READAT(source, fname, buf, sizeof(buf));
+
+	fd = SAFE_OPENAT(dest, fname, O_WRONLY);
+	for (tok = strtok(buf, "\n"); tok; tok = strtok(NULL, "\n")) {
+		ret = dprintf(fd, "%s", tok);
+
+		if (ret < (int)strlen(tok))
+			tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
+	}
+	SAFE_CLOSE(fd);
+}
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.swap.max", memsz);
+static void close_path_fds(struct tst_cgroup_root *t)
+{
+	if (t->tst_dir > 0)
+		SAFE_CLOSE(t->tst_dir);
+	if (t->ltp_dir > 0)
+		SAFE_CLOSE(t->ltp_dir);
+	if (t->drain_dir > 0)
+		SAFE_CLOSE(t->drain_dir);
+	if (t->mnt_dir > 0)
+		SAFE_CLOSE(t->mnt_dir);
 }
 
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz)
+/* Maybe remove CGroups used during testing and clear our data
+ *
+ * This will never remove CGroups we did not create to allow tests to
+ * be run in parallel (see enum tst_cgroup_cleanup).
+ *
+ * Each test process is given its own unique CGroup. Unless we want to
+ * stress test the CGroup system. We should at least remove these
+ * unique test CGroups.
+ *
+ * We probably also want to remove the LTP parent CGroup, although
+ * this may have been created by the system manager or another test
+ * (see notes on parallel testing).
+ *
+ * On systems with no initial CGroup setup we may try to destroy the
+ * CGroup roots we mounted so that they can be recreated by another
+ * test. Note that successfully unmounting a CGroup root does not
+ * necessarily indicate that it was destroyed.
+ *
+ * The ltp/drain CGroup is required for cleaning up test CGroups when
+ * we can not move them to the root CGroup. CGroups can only be
+ * removed when they have no members and only leaf or root CGroups may
+ * have processes within them. As test processes create and destroy
+ * their own CGroups they must move themselves either to root or
+ * another leaf CGroup. So we move them to drain while destroying the
+ * unique test CGroup.
+ *
+ * If we have access to root and created the LTP CGroup we then move
+ * the test process to root and destroy the drain and LTP
+ * CGroups. Otherwise we just leave the test process to die in the
+ * drain, much like many a unwanted terrapin.
+ *
+ * Finally we clear any data we have collected on CGroups. This will
+ * happen regardless of whether anything was removed.
+ */
+void tst_cgroup_cleanup(const struct tst_cgroup_opts *opts)
 {
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
-
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-
-	/*
-	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
-	 * please see Documentation/cgroups/cpusets.txt from kernel src
-	 * for details
-	 */
-	sprintf(knob_path, "%s/%s", cgroup_new_dir, filename);
-	fd = open(knob_path, O_RDONLY);
-	if (fd == -1) {
-		if (errno == ENOENT) {
-			sprintf(knob_path, "%s/cpuset.%s",
-					cgroup_new_dir, filename);
-			fd = SAFE_OPEN(knob_path, O_RDONLY);
-		} else
-			tst_brk(TBROK | TERRNO, "open %s", knob_path);
+	struct tst_cgroup_root *t;
+	struct tst_cgroup_ss *ss;
+
+	if (!opts)
+		opts = &default_opts;
+
+	if (opts->cleanup == TST_CGROUP_CLEANUP_NONE)
+		goto clear_data;
+
+	tst_for_each_root(t) {
+		if (!t->tst_dir)
+			continue;
+
+		tst_cgroup_drain(t->ver, t->tst_dir, t->drain_dir);
+		SAFE_UNLINKAT(t->ltp_dir, test_cgroup_dir, AT_REMOVEDIR);
 	}
 
-	memset(retbuf, 0, retbuf_sz);
-	if (read(fd, retbuf, retbuf_sz) < 0)
-		tst_brk(TBROK | TERRNO, "read %s", knob_path);
+	if (opts->cleanup == TST_CGROUP_CLEANUP_TEST)
+		goto clear_data;
 
-	close(fd);
-}
+	tst_for_each_root(t) {
+		if (!t->we_created_ltp_dir)
+			continue;
 
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf)
-{
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
-
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-
-	/*
-	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
-	 * please see Documentation/cgroups/cpusets.txt from kernel src
-	 * for details
-	 */
-	sprintf(knob_path, "%s/%s", cgroup_new_dir, filename);
-	fd = open(knob_path, O_WRONLY);
-	if (fd == -1) {
-		if (errno == ENOENT) {
-			sprintf(knob_path, "%s/cpuset.%s", cgroup_new_dir, filename);
-			fd = SAFE_OPEN(knob_path, O_WRONLY);
-		} else
-			tst_brk(TBROK | TERRNO, "open %s", knob_path);
+		tst_cgroup_drain(t->ver, t->drain_dir, t->mnt_dir);
+		SAFE_UNLINKAT(t->ltp_dir, ltp_cgroup_drain_dir, AT_REMOVEDIR);
+		SAFE_UNLINKAT(t->mnt_dir, ltp_cgroup_dir, AT_REMOVEDIR);
+	}
+
+	if (opts->cleanup == TST_CGROUP_CLEANUP_LTP)
+		goto clear_data;
+
+	tst_for_each_css(ss) {
+		if (!tst_cgroup_ss_on_v2(ss) || !ss->tree->we_mounted_it)
+			continue;
+
+		SAFE_FILE_PRINTFAT(ss->tree->mnt_dir, "cgroup.subtree_control",
+				   "-%s", ss->name);
+	}
+
+	tst_for_each_root(t)
+		close_path_fds(t);
+
+	tst_for_each_root(t) {
+		if (!t->we_mounted_it)
+			continue;
+
+		/* This probably does not result in the CGroup root
+		 * being destroyed */
+		if (umount2(t->path, MNT_DETACH))
+			continue;
+
+		SAFE_RMDIR(t->path);
 	}
 
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+clear_data:
+	tst_for_each_css(ss)
+		memset(ss, 0, sizeof(*ss));
+
+	tst_for_each_root(t) {
+		close_path_fds(t);
+		memset(t, 0, sizeof(*t));
+	}
 
-	close(fd);
+	memset(&features, 0, sizeof(features));
 }
-- 
2.29.2

