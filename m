From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 28 Apr 2021 15:27:15 +0100
Subject: [LTP] [PATCH v4 2/6] Add new CGroups APIs
In-Reply-To: <20210428142719.8065-1-rpalethorpe@suse.com>
References: <20210428142719.8065-1-rpalethorpe@suse.com>
Message-ID: <20210428142719.8065-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Complete rewrite of the CGroups API which provides two layers of
indirection between the test author and the SUT's CGroup
configuration.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_cgroup.h |  179 +++++-
 include/tst_test.h   |    1 -
 lib/tst_cgroup.c     | 1266 +++++++++++++++++++++++++++++++-----------
 3 files changed, 1103 insertions(+), 343 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index bfd848260..cbc28f3ac 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -2,46 +2,179 @@
 /*
  * Copyright (c) 2020 Red Hat, Inc.
  * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+/*\
+ * [DESCRIPTION]
+ *
+ * The LTP CGroups API tries to present a consistent interface to the
+ * many possible CGroup configurations a system could have.
+ *
+ * You may ask; "Why don't you just mount a simple CGroup hierarchy,
+ * instead of scanning the current setup?". The short answer is that
+ * it is not possible unless no CGroups are currently active and
+ * almost all of our users will have CGroups active. Even if
+ * unmounting the current CGroup hierarchy is a reasonable thing to do
+ * to the sytem manager, it is highly unlikely the CGroup hierarchy
+ * will be destroyed. So users would be forced to remove their CGroup
+ * configuration and reboot the system.
+ *
+ * The core library tries to ensure an LTP CGroup exists on each
+ * hierarchy root. Inside the LTP group it ensures a 'drain' group
+ * exists and creats a test group for the current test. In the worst
+ * case we end up with a set of hierarchies like the follwoing. Where
+ * existing system-manager-created CGroups have been omitted.
+ *
+ * 	(V2 Root)	(V1 Root 1)	...	(V1 Root N)
+ * 	    |		     |			     |
+ *	  (ltp)		   (ltp)	...	   (ltp)
+ *	 /     \	  /	\		  /	\
+ *  (drain) (test-n) (drain)  (test-n)  ...  (drain)  (test-n)
+ *
+ * V2 CGroup controllers use a single unified hierarchy on a single
+ * root. Two or more V1 controllers may share a root or have their own
+ * root. However there may exist only one instance of a controller.
+ * So you can not have the same V1 controller on multiple roots.
+ *
+ * It is possible to have both a V2 hierarchy and V1 hierarchies
+ * active at the same time. Which is what is shown above. Any
+ * controllers attached to V1 hierarchies will not be available in the
+ * V2 hierarchy. The reverse is also true.
+ *
+ * Note that a single hierarchy may be mounted multiple
+ * times. Allowing it to be accessed at different locations. However
+ * subsequent mount operations will fail if the mount options are
+ * different from the first.
+ *
+ * The user may pre-create the CGroup hierarchies and the ltp CGroup,
+ * otherwise the library will try to create them. If the ltp group
+ * already exists and has appropriate permissions, then admin
+ * privileges will not be required to run the tests.
+ *
+ * Because the test may not have access to the CGroup root(s), the
+ * drain CGroup is created. This can be used to store processes which
+ * would otherwise block the destruction of the individual test CGroup
+ * or one of its descendants.
+ *
+ * The test author may create child CGroups within the test CGroup
+ * using the CGroup Item API. The library will create the new CGroup
+ * in all the relevant hierarchies.
+ *
+ * There are many differences between the V1 and V2 CGroup APIs. If a
+ * controller is on both V1 and V2, it may have different parameters
+ * and control files. Some of these control files have a different
+ * name, but similar functionality. In this case the Item API uses
+ * the V2 names and aliases them to the V1 name when appropriate.
+ *
+ * Some control files only exist on one of the versions or they can be
+ * missing due to other reasons. The Item API allows the user to check
+ * if the file exists before trying to use it.
+ *
+ * Often a control file has almost the same functionality between V1
+ * and V2. Which means it can be used in the same way most of the
+ * time, but not all. For now this is handled by exposing the API
+ * version a controller is using to allow the test author to handle
+ * edge cases. (e.g. V2 memory.swap.max accepts "max", but V1
+ * memory.memsw.limit_in_bytes does not).
  */
 
 #ifndef TST_CGROUP_H
 #define TST_CGROUP_H
 
-#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
-#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
+#include <sys/types.h>
 
+/* CGroups Kernel API version */
 enum tst_cgroup_ver {
 	TST_CGROUP_V1 = 1,
 	TST_CGROUP_V2 = 2,
 };
 
-enum tst_cgroup_ctrl {
-	TST_CGROUP_MEMCG = 1,
-	TST_CGROUP_CPUSET = 2,
-	/* add cgroup controller */
+/* Used to specify CGroup hierarchy configuration options, allowing a
+ * test to request a particular CGroup structure.
+ */
+struct tst_cgroup_opts {
+	/* Only try to mount V1 CGroup controllers. This will not
+	 * prevent V2 from being used if it is already mounted, it
+	 * only indicates that we should mount V1 controllers if
+	 * nothing is present. By default we try to mount V2 first. */
+	int only_mount_v1:1;
 };
 
-enum tst_cgroup_ver tst_cgroup_version(void);
+/* A Control Group in LTP's aggregated hierarchy */
+struct tst_cgroup_group;
+
+/* Search the system for mounted cgroups and available
+ * controllers. Called automatically by tst_cgroup_require.
+ */
+void tst_cgroup_scan(void);
+/* Print the config detected by tst_cgroup_scan */
+void tst_cgroup_print_config(void);
+
+/* Ensure the specified controller is available in the test's default
+ * CGroup, mounting/enabling it if necessary */
+void tst_cgroup_require(const char *ctrl_name,
+			const struct tst_cgroup_opts *options);
+
+/* Tear down any CGroups created by calls to tst_cgroup_require */
+void tst_cgroup_cleanup(void);
+
+/* Get the default CGroup for the test. It allocates memory (in a
+ * guarded buffer) so should always be called from setup
+ */
+const struct tst_cgroup_group *tst_cgroup_get_test_group(void);
+/* Get the shared drain group. Also should be called from setup */
+const struct tst_cgroup_group *tst_cgroup_get_drain_group(void);
+/* Create a descendant CGroup */
+struct tst_cgroup_group *
+tst_cgroup_group_mk(const struct tst_cgroup_group *parent,
+		    const char *name);
+/* Remove a descendant CGroup */
+struct tst_cgroup_group *tst_cgroup_group_rm(struct tst_cgroup_group *cg);
+
+
+#define TST_CGROUP_VER(cg, ctrl_name) \
+	tst_cgroup_ver(__FILE__, __LINE__, (cg), (ctrl_name))
+
+enum tst_cgroup_ver tst_cgroup_ver(const char *file, const int lineno,
+				   const struct tst_cgroup_group *cg,
+				   const char *ctrl_name);
+
+#define SAFE_CGROUP_HAS(cg, file_name) \
+	safe_cgroup_has(__FILE__, __LINE__, (cg), (file_name))
+
+int safe_cgroup_has(const char *file, const int lineno,
+		    const struct tst_cgroup_group *cg, const char *file_name);
+
+#define SAFE_CGROUP_READ(cg, file_name, out, len)			\
+	safe_cgroup_read(__FILE__, __LINE__,				\
+			 (cg), (file_name), (out), (len))
+
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+			 const struct tst_cgroup_group *cg,
+			 const char *file_name,
+			 char *out, size_t len);
+
+#define SAFE_CGROUP_PRINTF(cg, file_name, fmt, ...)			\
+	safe_cgroup_printf(__FILE__, __LINE__,				\
+			   (cg), (file_name), (fmt), __VA_ARGS__)
 
-/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
-void tst_cgroup_umount(const char *cgroup_dir);
+#define SAFE_CGROUP_PRINT(cg, file_name, str)				\
+	safe_cgroup_printf(__FILE__, __LINE__, (cg), (file_name), "%s", (str))
 
-/* To move current process PID to the mounted cgroup tasks */
-void tst_cgroup_move_current(const char *cgroup_dir);
+void safe_cgroup_printf(const char *file, const int lineno,
+			const struct tst_cgroup_group *cg,
+			const char *file_name,
+			const char *fmt, ...)
+			__attribute__ ((format (printf, 5, 6)));
 
-/* To set cgroup controller knob with new value */
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
+#define SAFE_CGROUP_SCANF(cg, file_name, fmt, ...)			\
+	safe_cgroup_scanf(__FILE__, __LINE__,				\
+			  (cg), (file_name), (fmt), __VA_ARGS__)
 
-/* Set of functions to set knobs under the memory controller */
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
-int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
+void safe_cgroup_scanf(const char *file, const int lineno,
+		       const struct tst_cgroup_group *cg, const char *file_name,
+		       const char *fmt, ...)
+		       __attribute__ ((format (scanf, 5, 6)));
 
-/* Set of functions to read/write cpuset controller files content */
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz);
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename,
-	const char *buf);
 
 #endif /* TST_CGROUP_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index 4eee6f897..6ad355506 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -39,7 +39,6 @@
 #include "tst_capability.h"
 #include "tst_hugepage.h"
 #include "tst_assert.h"
-#include "tst_cgroup.h"
 #include "tst_lockdown.h"
 #include "tst_fips.h"
 #include "tst_taint.h"
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 96c9524d2..3467c821e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -2,453 +2,1081 @@
 /*
  * Copyright (c) 2020 Red Hat, Inc.
  * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
  */
 
 #define TST_NO_DEFAULT_MAIN
 
 #include <stdio.h>
+#include <stddef.h>
 #include <stdlib.h>
+#include <mntent.h>
 #include <sys/mount.h>
-#include <fcntl.h>
-#include <unistd.h>
 
 #include "tst_test.h"
-#include "tst_safe_macros.h"
-#include "tst_safe_stdio.h"
+#include "lapi/fcntl.h"
+#include "lapi/mount.h"
+#include "lapi/mkdirat.h"
+#include "tst_safe_file_at.h"
 #include "tst_cgroup.h"
-#include "tst_device.h"
 
-static enum tst_cgroup_ver tst_cg_ver;
-static int clone_children;
+struct cgroup_root;
 
-static int tst_cgroup_check(const char *cgroup)
+/* A node in a single CGroup hierarchy. It exists mainly for
+ * convenience so that we do not have to traverse the CGroup structure
+ * for frequent operations.
+ *
+ * This is actually a single-linked list not a tree. We only need to
+ * traverse from leaf towards root.
+ */
+struct cgroup_dir {
+	const char *dir_name;
+	const struct cgroup_dir *dir_parent;
+
+	/* Shortcut to root */
+	const struct cgroup_root *dir_root;
+
+	/* Subsystems (controllers) bit field. Only controllers which
+	 * were required and configured for this node are added to
+	 * this field. So it may be different from root->css_field.
+	 */
+	uint32_t ctrl_field;
+
+	/* In general we avoid having sprintfs everywhere and use
+	 * openat, linkat, etc.
+	 */
+	int dir_fd;
+
+	int we_created_it:1;
+};
+
+/* The root of a CGroup hierarchy/tree */
+struct cgroup_root {
+	enum tst_cgroup_ver ver;
+	/* A mount path */
+	char mnt_path[PATH_MAX];
+	/* Subsystems (controllers) bit field. Includes all
+	 * controllers found while scanning this root.
+	 */
+	uint32_t ctrl_field;
+
+	/* CGroup hierarchy: mnt -> ltp -> {drain, test -> ??? } We
+	 * keep a flat reference to ltp, drain and test for
+	 * convenience.
+	 */
+
+	/* Mount directory */
+	struct cgroup_dir mnt_dir;
+	/* LTP CGroup directory, contains drain and test dirs */
+	struct cgroup_dir ltp_dir;
+	/* Drain CGroup, see cgroup_cleanup */
+	struct cgroup_dir drain_dir;
+	/* CGroup for current test. Which may have children. */
+	struct cgroup_dir test_dir;
+
+	int we_mounted_it:1;
+	/* cpuset is in compatability mode */
+	int no_cpuset_prefix:1;
+};
+
+/* Controller sub-systems */
+enum cgroup_ctrl_indx {
+	CTRL_MEMORY = 1,
+	CTRL_CPUSET = 2,
+};
+#define CTRLS_MAX CTRL_CPUSET
+
+/* At most we can have one cgroup V1 tree for each controller and one
+ * (empty) v2 tree.
+ */
+#define ROOTS_MAX (CTRLS_MAX + 1)
+
+/* Describes a controller file or knob
+ *
+ * The primary purpose of this is to map V2 names to V1
+ * names.
+ */
+struct cgroup_file {
+	/* Canonical name. Is the V2 name unless an item is V1 only */
+	const char *file_name;
+	/* V1 name or NULL if item is V2 only */
+	const char *file_name_v1;
+
+	/* The controller this item belongs to or zero for
+	 * 'cgroup.<item>'.
+	 */
+	enum cgroup_ctrl_indx ctrl_indx;
+};
+
+/* Describes a Controller or subsystem
+ *
+ * Internally the kernel seems to call controllers subsystems and uses
+ * the abbreviations subsys and css.
+ */
+struct cgroup_ctrl {
+	/* Userland name of the controller (e.g. 'memory' not 'memcg') */
+	const char *ctrl_name;
+	/* List of files belonging to this controller */
+	struct cgroup_file *files;
+	/* Our index for the controller */
+	enum cgroup_ctrl_indx ctrl_indx;
+
+	/* Runtime; hierarchy the controller is attached to */
+        struct cgroup_root *ctrl_root;
+	/* Runtime; whether we required the controller */
+	int we_require_it:1;
+};
+
+struct tst_cgroup_group {
+	const char *group_name;
+	/* Maps controller ID to the tree which contains it. The V2
+	 * tree is at zero even if it contains no controllers.
+	 */
+	struct cgroup_dir *dirs_by_ctrl[ROOTS_MAX];
+	/* NULL terminated list of trees */
+	struct cgroup_dir *dirs[ROOTS_MAX + 1];
+};
+
+/* Always use first item for unified hierarchy */
+struct cgroup_root roots[ROOTS_MAX + 1];
+
+/* Lookup tree for item names. */
+typedef struct cgroup_file files_t[];
+
+static files_t cgroup_ctrl_files = {
+	/* procs exists on V1, however it was read-only until kernel v3.0. */
+	{ "cgroup.procs", "tasks", 0 },
+	{ "cgroup.subtree_control", NULL, 0 },
+	{ "cgroup.clone_children", "clone_children", 0 },
+	{ }
+};
+
+static files_t memory_ctrl_files = {
+	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
+	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
+	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
+	{ "memory.swap.current", "memory.memsw.usage_in_bytes", CTRL_MEMORY },
+	{ "memory.swap.max", "memory.memsw.limit_in_bytes", CTRL_MEMORY },
+	{ "memory.kmem.usage_in_bytes", "memory.kmem.usage_in_bytes", CTRL_MEMORY },
+	{ "memory.kmem.limit_in_bytes", "memory.kmem.usage_in_bytes", CTRL_MEMORY },
+	{ }
+};
+
+static files_t cpuset_ctrl_files = {
+	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
+	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
+	{ "cpuset.memory_migrate", "cpuset.memory_migrate", CTRL_CPUSET },
+	{ }
+};
+
+static struct cgroup_ctrl controllers[] = {
+	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
+	[CTRL_MEMORY] = {
+		"memory", memory_ctrl_files, CTRL_MEMORY, NULL, 0
+	},
+	[CTRL_CPUSET] = {
+		"cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
+	},
+	{ }
+};
+
+static const struct tst_cgroup_opts default_opts = { 0 };
+
+/* We should probably allow these to be set in environment
+ * variables */
+static const char *ltp_cgroup_dir = "ltp";
+static const char *ltp_cgroup_drain_dir = "drain";
+static char test_cgroup_dir[PATH_MAX/4];
+static const char *ltp_mount_prefix = "/tmp/cgroup_";
+static const char *ltp_v2_mount = "unified";
+
+#define first_root				\
+	(roots[0].ver ? roots : roots + 1)
+#define for_each_root(r)			\
+	for ((r) = first_root; (r)->ver; (r)++)
+#define for_each_v1_root(r)			\
+	for ((r) = roots + 1; (r)->ver; (r)++)
+#define for_each_ctrl(ctrl)			\
+	for ((ctrl) = controllers + 1; (ctrl)->ctrl_name; (ctrl)++)
+
+/* Controller items may only be in a single directory tree. So when
+ * (ss) > 0 we only loop once.
+ */
+#define for_each_dir(cg, ctrl, t)					\
+	for ((t) = (ctrl) ? (cg)->dirs_by_ctrl + (ctrl) : (cg)->dirs;	\
+	     *(t);							\
+	     (t) = (ctrl) ? (cg)->dirs + ROOTS_MAX : (t) + 1)
+
+static int has_ctrl(uint32_t ctrl_field, const struct cgroup_ctrl *ctrl)
 {
-	char line[PATH_MAX];
-	FILE *file;
-	int cg_check = 0;
+	return !!(ctrl_field & (1 << ctrl->ctrl_indx));
+}
 
-	file = SAFE_FOPEN("/proc/filesystems", "r");
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, cgroup) != NULL) {
-			cg_check = 1;
-			break;
-		}
+static void add_ctrl(uint32_t *ctrl_field, const struct cgroup_ctrl *ctrl)
+{
+	*ctrl_field |= 1 << ctrl->ctrl_indx;
+}
+
+struct cgroup_root *tst_cgroup_root_get(void)
+{
+	return roots[0].ver ? roots : roots + 1;
+}
+
+static int cgroup_v2_mounted(void)
+{
+	return !!roots[0].ver;
+}
+
+static int cgroup_v1_mounted(void)
+{
+	return !!roots[1].ver;
+}
+
+static int cgroup_mounted(void)
+{
+	return cgroup_v2_mounted() || cgroup_v1_mounted();
+}
+
+static int cgroup_ctrl_on_v2(const struct cgroup_ctrl *ctrl)
+{
+	return ctrl->ctrl_root && ctrl->ctrl_root->ver == TST_CGROUP_V2;
+}
+
+int cgroup_dir_mk(const struct cgroup_dir *parent,
+		  const char *dir_name,
+		  struct cgroup_dir *new)
+{
+	char *dpath;
+
+	new->dir_root = parent->dir_root;
+	new->dir_name = dir_name;
+	new->dir_parent = parent;
+	new->ctrl_field = parent->ctrl_field;
+	new->we_created_it = 0;
+
+	if (!mkdirat(parent->dir_fd, dir_name, 0777)) {
+		new->we_created_it = 1;
+		goto opendir;
+	}
+
+	if (errno == EEXIST)
+		goto opendir;
+
+	dpath = tst_decode_fd(parent->dir_fd);
+
+	if (errno == EACCES) {
+		tst_brk(TCONF | TERRNO,
+			"Lack permission to make '%s/%s'; premake it or run as root",
+			dpath, dir_name);
+	} else {
+		tst_brk(TBROK | TERRNO,
+			"mkdirat(%d<%s>, '%s', 0777)",
+			parent->dir_fd, dpath, dir_name);
 	}
-	SAFE_FCLOSE(file);
 
-	return cg_check;
+	return -1;
+opendir:
+	new->dir_fd = SAFE_OPENAT(parent->dir_fd, dir_name,
+				  O_PATH | O_DIRECTORY);
+
+	return 0;
 }
 
-enum tst_cgroup_ver tst_cgroup_version(void)
+void tst_cgroup_print_config(void)
 {
-        enum tst_cgroup_ver cg_ver;
+	struct cgroup_root *root;
+	struct cgroup_ctrl *ctrl;
+
+	tst_res(TINFO, "Detected Controllers:");
 
-        if (tst_cgroup_check("cgroup2")) {
-                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
-                        cg_ver = TST_CGROUP_V1;
-                else
-                        cg_ver = TST_CGROUP_V2;
+	for_each_ctrl(ctrl) {
+		root = ctrl->ctrl_root;
 
-                goto out;
-        }
+		if (!root)
+			continue;
 
-        if (tst_cgroup_check("cgroup"))
-                cg_ver = TST_CGROUP_V1;
+		tst_res(TINFO, "\t%.10s %s @ %s:%s",
+			ctrl->ctrl_name,
+			root->no_cpuset_prefix ? "[noprefix]" : "",
+			root->ver == TST_CGROUP_V1 ? "V1" : "V2",
+			root->mnt_path);
+	}
+}
+
+static struct cgroup_ctrl *cgroup_find_ctrl(const char *ctrl_name)
+{
+	struct cgroup_ctrl *ctrl = controllers;
 
-        if (!cg_ver)
-                tst_brk(TCONF, "Cgroup is not configured");
+	while (ctrl->ctrl_name && strcmp(ctrl_name, ctrl->ctrl_name))
+		ctrl++;
 
-out:
-        return cg_ver;
+	if (!ctrl->ctrl_name)
+		ctrl = NULL;
+
+	return ctrl;
 }
 
-static void tst_cgroup1_mount(const char *name, const char *option,
-			const char *mnt_path, const char *new_path)
+/* Determine if a mounted cgroup hierarchy is unique and record it if so.
+ *
+ * For CGroups V2 this is very simple as there is only one
+ * hierarchy. We just record which controllers are available and check
+ * if this matches what we read from any previous mount points.
+ *
+ * For V1 the set of controllers S is partitioned into sets {P_1, P_2,
+ * ..., P_n} with one or more controllers in each partion. Each
+ * partition P_n can be mounted multiple times, but the same
+ * controller can not appear in more than one partition. Usually each
+ * partition contains a single controller, but, for example, cpu and
+ * cpuacct are often mounted together in the same partiion.
+ *
+ * Each controller partition has its own hierarchy (root) which we
+ * must track and update independently.
+ */
+static void cgroup_root_scan(const char *mnt_type,
+			     const char *mnt_dir,
+			     char *mnt_opts)
 {
-	char knob_path[PATH_MAX];
-	if (tst_is_mounted(mnt_path))
-		goto out;
+	struct cgroup_root *root = roots;
+	const struct cgroup_ctrl *const_ctrl;
+	struct cgroup_ctrl *ctrl;
+	uint32_t ctrl_field = 0;
+	int no_prefix = 0;
+	char buf[BUFSIZ];
+	char *tok;
+	int mnt_dfd = SAFE_OPEN(mnt_dir, O_PATH | O_DIRECTORY);
+
+	if (!strcmp(mnt_type, "cgroup"))
+		goto v1;
+
+	SAFE_FILE_READAT(mnt_dfd, "cgroup.controllers", buf, sizeof(buf));
+
+	for (tok = strtok(buf, " "); tok; tok = strtok(NULL, " ")) {
+		if ((const_ctrl = cgroup_find_ctrl(tok)))
+			add_ctrl(&ctrl_field, const_ctrl);
+	}
 
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v1 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	if (root->ver && ctrl_field == root->ctrl_field)
+		goto discard;
+
+	if (root->ctrl_field)
+		tst_brk(TBROK, "Available V2 controllers are changing between scans?");
+
+	root->ver = TST_CGROUP_V2;
+
+	goto backref;
+
+v1:
+	for (tok = strtok(mnt_opts, ","); tok; tok = strtok(NULL, ",")) {
+		if ((const_ctrl = cgroup_find_ctrl(tok)))
+			add_ctrl(&ctrl_field, const_ctrl);
+
+		no_prefix |= !strcmp("noprefix", tok);
 	}
 
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
+	if (!ctrl_field)
+		goto discard;
+
+	for_each_v1_root(root) {
+		if (!(ctrl_field & root->ctrl_field))
+			continue;
+
+		if (ctrl_field == root->ctrl_field)
+			goto discard;
+
+		tst_brk(TBROK,
+			"The intersection of two distinct sets of mounted controllers should be null?"
+			"Check '%s' and '%s'", root->mnt_path, mnt_dir);
+	}
+
+	if (root >= roots + ROOTS_MAX) {
+		tst_brk(TBROK,
+			"Unique controller mounts have exceeded our limit %d?",
+			ROOTS_MAX);
 	}
-out:
-	SAFE_MKDIR(new_path, 0777);
 
-	tst_res(TINFO, "Cgroup(%s) v1 mount at %s success", option, mnt_path);
+	root->ver = TST_CGROUP_V1;
+
+backref:
+	strcpy(root->mnt_path, mnt_dir);
+	root->mnt_dir.dir_root = root;
+	root->mnt_dir.dir_name = root->mnt_path;
+	root->mnt_dir.dir_fd = mnt_dfd;
+	root->ctrl_field = ctrl_field;
+	root->no_cpuset_prefix = no_prefix;
+
+	for_each_ctrl(ctrl) {
+		if (has_ctrl(root->ctrl_field, ctrl))
+			ctrl->ctrl_root = root;
+	}
+
+	return;
+
+discard:
+	close(mnt_dfd);
 }
 
-static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
+void tst_cgroup_scan(void)
 {
-	if (tst_is_mounted(mnt_path))
-		goto out;
+	struct mntent *mnt;
+	FILE *f = setmntent("/proc/self/mounts", "r");
 
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v2 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	if (!f) {
+		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
+		return;
 	}
 
-out:
-	SAFE_MKDIR(new_path, 0777);
+	mnt = getmntent(f);
+	if (!mnt) {
+		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
+		return;
+	}
+
+	do {
+                if (strncmp(mnt->mnt_type, "cgroup", 6))
+			continue;
 
-	tst_res(TINFO, "Cgroup v2 mount at %s success", mnt_path);
+		cgroup_root_scan(mnt->mnt_type, mnt->mnt_dir, mnt->mnt_opts);
+	} while ((mnt = getmntent(f)));
 }
 
-static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
+static void cgroup_mount_v2(void)
 {
-	FILE *fp;
-	int fd;
-	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
-	char knob_path[PATH_MAX];
+	char mnt_path[PATH_MAX];
+
+	sprintf(mnt_path, "%s%s", ltp_mount_prefix, ltp_v2_mount);
+
+	if (!mkdir(mnt_path, 0777)) {
+		roots[0].mnt_dir.we_created_it = 1;
+		goto mount;
+	}
+
+	if (errno == EEXIST)
+		goto mount;
 
-	if (!tst_is_mounted(mnt_path))
+	if (errno == EACCES) {
+		tst_res(TINFO | TERRNO,
+			"Lack permission to make %s, premake it or run as root",
+			mnt_path);
 		return;
+	}
 
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
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", mnt_path);
+	return;
+
+mount:
+	if (!mount("cgroup2", mnt_path, "cgroup2", 0, NULL)) {
+		tst_res(TINFO, "Mounted V2 CGroups on %s", mnt_path);
+		tst_cgroup_scan();
+		roots[0].we_mounted_it = 1;
+		return;
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
-}
-
-struct tst_cgroup_path {
-	char *mnt_path;
-	char *new_path;
-	struct tst_cgroup_path *next;
-};
 
-static struct tst_cgroup_path *tst_cgroup_paths;
+	tst_res(TINFO | TERRNO, "Could not mount V2 CGroups on %s", mnt_path);
+
+	if (roots[0].mnt_dir.we_created_it) {
+		roots[0].mnt_dir.we_created_it = 0;
+		SAFE_RMDIR(mnt_path);
+	}
+}
 
-static void tst_cgroup_set_path(const char *cgroup_dir)
+static void cgroup_mount_v1(struct cgroup_ctrl *ctrl)
 {
-	char cgroup_new_dir[PATH_MAX];
-	struct tst_cgroup_path *tst_cgroup_path, *a;
+	char mnt_path[PATH_MAX];
+	int made_dir = 0;
 
-	if (!cgroup_dir)
-		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
+	sprintf(mnt_path, "%s%s", ltp_mount_prefix, ctrl->ctrl_name);
 
-	sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
+	if (!mkdir(mnt_path, 0777)) {
+		made_dir = 1;
+		goto mount;
+	}
 
-	/* To store cgroup path in the 'path' list */
-	tst_cgroup_path = SAFE_MALLOC(sizeof(struct tst_cgroup_path));
-	tst_cgroup_path->mnt_path = SAFE_MALLOC(strlen(cgroup_dir) + 1);
-	tst_cgroup_path->new_path = SAFE_MALLOC(strlen(cgroup_new_dir) + 1);
-	tst_cgroup_path->next = NULL;
+	if (errno == EEXIST)
+		goto mount;
 
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
+	if (errno == EACCES) {
+		tst_res(TINFO | TERRNO,
+			"Lack permission to make %s, premake it or run as root",
+			mnt_path);
+		return;
+	}
+
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", mnt_path);
+	return;
+
+mount:
+	if (mount(ctrl->ctrl_name, mnt_path, "cgroup", 0, ctrl->ctrl_name)) {
+		tst_res(TINFO | TERRNO,
+			"Could not mount V1 CGroup on %s", mnt_path);
+
+		if (made_dir)
+			SAFE_RMDIR(mnt_path);
+		return;
 	}
 
-	sprintf(tst_cgroup_path->mnt_path, "%s", cgroup_dir);
-	sprintf(tst_cgroup_path->new_path, "%s", cgroup_new_dir);
+	tst_res(TINFO, "Mounted V1 %s CGroup on %s", ctrl->ctrl_name, mnt_path);
+	tst_cgroup_scan();
+	if (!ctrl->ctrl_root)
+		return;
+
+        ctrl->ctrl_root->we_mounted_it = 1;
+	ctrl->ctrl_root->mnt_dir.we_created_it = made_dir;
+
+	if (ctrl->ctrl_indx == CTRL_MEMORY) {
+		SAFE_FILE_PRINTFAT(ctrl->ctrl_root->mnt_dir.dir_fd,
+				   "memory.use_hierarchy", "%d", 1);
+	}
 }
 
-static char *tst_cgroup_get_path(const char *cgroup_dir)
+static void cgroup_copy_cpuset(const struct cgroup_root *root)
 {
-	struct tst_cgroup_path *a;
+	char knob_val[BUFSIZ];
+	int i;
+	const char *n0[] = {"mems", "cpus"};
+	const char *n1[] = {"cpuset.mems", "cpuset.cpus"};
+	const char **fname = root->no_cpuset_prefix ? n0 : n1;
+
+	for (i = 0; i < 2; i++) {
+		SAFE_FILE_READAT(root->mnt_dir.dir_fd,
+				 fname[i], knob_val, sizeof(knob_val));
+		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+				   fname[i], "%s", knob_val);
+	}
+}
 
-	if (!tst_cgroup_paths)
-		return NULL;
+/* Ensure the specified controller is available.
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
+ * Once we have mounted the controller somehow, we create a hierarchy
+ * of cgroups. If we are on V2 we first need to enable the controller
+ * for all children of root. Then we create hierarchy described in
+ * tst_cgroup.h.
+ *
+ * If we are using V1 cpuset then we copy the available mems and cpus
+ * from root to the ltp group and set clone_children on the ltp group
+ * to distribute these settings to the test cgroups. This means the
+ * test author does not have to copy these settings before using the
+ * cpuset.
+ *
+ */
+void tst_cgroup_require(const char *ctrl_name,
+			const struct tst_cgroup_opts *options)
+{
+	const char *const cgsc = "cgroup.subtree_control";
+	struct cgroup_ctrl *ctrl = cgroup_find_ctrl(ctrl_name);
+	struct cgroup_root *root;
+
+	if (!options)
+		options = &default_opts;
+
+	if (ctrl->we_require_it) {
+		tst_res(TWARN, "Duplicate tst_cgroup_require(%s, )",
+			ctrl->ctrl_name);
+	}
+	ctrl->we_require_it = 1;
+
+	if (ctrl->ctrl_root)
+		goto mkdirs;
+
+	tst_cgroup_scan();
+
+	if (ctrl->ctrl_root)
+		goto mkdirs;
 
-	a = tst_cgroup_paths;
+	if (!cgroup_v2_mounted() && !options->only_mount_v1)
+		cgroup_mount_v2();
 
-	while (strcmp(a->mnt_path, cgroup_dir) != 0){
-		if (!a->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return NULL;
+	if (ctrl->ctrl_root)
+		goto mkdirs;
+
+	cgroup_mount_v1(ctrl);
+
+	if (!ctrl->ctrl_root) {
+		tst_brk(TCONF,
+			"'%s' controller required, but not available",
+			ctrl->ctrl_name);
+		return;
+	}
+
+mkdirs:
+	root = ctrl->ctrl_root;
+	add_ctrl(&root->mnt_dir.ctrl_field, ctrl);
+
+	if (cgroup_ctrl_on_v2(ctrl)) {
+		if (root->we_mounted_it) {
+			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
+					   cgsc, "+%s", ctrl->ctrl_name);
+		} else {
+			tst_file_printfat(root->mnt_dir.dir_fd,
+					  cgsc, "+%s", ctrl->ctrl_name);
 		}
-		a = a->next;
-	};
+	}
+
+	if (!root->ltp_dir.dir_fd)
+		cgroup_dir_mk(&root->mnt_dir, ltp_cgroup_dir, &root->ltp_dir);
+	else
+		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;
+
+	if (cgroup_ctrl_on_v2(ctrl)) {
+		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+				   cgsc, "+%s", ctrl->ctrl_name);
+	} else {
+		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+				   cgsc, "%d", 1);
+
+		if (ctrl->ctrl_indx == CTRL_CPUSET)
+			cgroup_copy_cpuset(root);
+	}
+
+	cgroup_dir_mk(&root->ltp_dir, ltp_cgroup_drain_dir, &root->drain_dir);
 
-	return a->new_path;
+	sprintf(test_cgroup_dir, "test-%d", getpid());
+	cgroup_dir_mk(&root->ltp_dir, test_cgroup_dir, &root->test_dir);
 }
 
-static void tst_cgroup_del_path(const char *cgroup_dir)
+static void cgroup_drain(enum tst_cgroup_ver ver, int source_dfd, int dest_dfd)
 {
-	struct tst_cgroup_path *a, *b;
+	char pid_list[BUFSIZ];
+	char *tok;
+	const char *file_name = ver == TST_CGROUP_V1 ? "tasks" : "cgroup.procs";
+	int fd;
+	ssize_t ret;
 
-	if (!tst_cgroup_paths)
+	ret = SAFE_FILE_READAT(source_dfd, file_name,
+			       pid_list, sizeof(pid_list));
+	if (ret < 0)
 		return;
 
-	a = b = tst_cgroup_paths;
+	fd = SAFE_OPENAT(dest_dfd, file_name, O_WRONLY);
+	if (fd < 0)
+		return;
 
-	while (strcmp(b->mnt_path, cgroup_dir) != 0) {
-		if (!b->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return;
-		}
-		a = b;
-		b = b->next;
-	};
+	for (tok = strtok(pid_list, "\n"); tok; tok = strtok(NULL, "\n")) {
+		ret = dprintf(fd, "%s", tok);
 
-	if (b == tst_cgroup_paths)
-		tst_cgroup_paths = b->next;
-	else
-		a->next = b->next;
+		if (ret < (ssize_t)strlen(tok))
+			tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
+	}
+	SAFE_CLOSE(fd);
+}
 
-	free(b->mnt_path);
-	free(b->new_path);
-	free(b);
+static void close_path_fds(struct cgroup_root *root)
+{
+	if (root->test_dir.dir_fd > 0)
+		SAFE_CLOSE(root->test_dir.dir_fd);
+	if (root->ltp_dir.dir_fd > 0)
+		SAFE_CLOSE(root->ltp_dir.dir_fd);
+	if (root->drain_dir.dir_fd > 0)
+		SAFE_CLOSE(root->drain_dir.dir_fd);
+	if (root->mnt_dir.dir_fd > 0)
+		SAFE_CLOSE(root->mnt_dir.dir_fd);
 }
 
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir)
+/* Maybe remove CGroups used during testing and clear our data
+ *
+ * This will never remove CGroups we did not create to allow tests to
+ * be run in parallel.
+ *
+ * Each test process is given its own unique CGroup. Unless we want to
+ * stress test the CGroup system. We should at least remove these
+ * unique per test CGroups.
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
+void tst_cgroup_cleanup(void)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	struct cgroup_root *root;
+	struct cgroup_ctrl *ctrl;
 
-	tst_cg_ver = tst_cgroup_version();
+	if (!cgroup_mounted())
+		goto clear_data;
 
-	tst_cgroup_set_path(cgroup_dir);
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	for_each_root(root) {
+		if (!root->test_dir.dir_name)
+			continue;
 
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
+		cgroup_drain(root->ver,
+			     root->test_dir.dir_fd, root->drain_dir.dir_fd);
+		SAFE_UNLINKAT(root->ltp_dir.dir_fd, root->test_dir.dir_name,
+			      AT_REMOVEDIR);
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		tst_cgroup2_mount(cgroup_dir, cgroup_new_dir);
+	for_each_root(root) {
+		if (!root->ltp_dir.we_created_it)
+			continue;
+
+		cgroup_drain(root->ver,
+			     root->drain_dir.dir_fd, root->mnt_dir.dir_fd);
+
+		if (root->drain_dir.dir_name) {
+			SAFE_UNLINKAT(root->ltp_dir.dir_fd,
+				      root->drain_dir.dir_name, AT_REMOVEDIR);
+		}
 
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
+		if (root->ltp_dir.dir_name) {
+			SAFE_UNLINKAT(root->mnt_dir.dir_fd,
+				      root->ltp_dir.dir_name, AT_REMOVEDIR);
 		}
 	}
+
+	for_each_ctrl(ctrl) {
+		if (!cgroup_ctrl_on_v2(ctrl) || !ctrl->ctrl_root->we_mounted_it)
+			continue;
+
+		SAFE_FILE_PRINTFAT(ctrl->ctrl_root->mnt_dir.dir_fd,
+				   "cgroup.subtree_control",
+				   "-%s", ctrl->ctrl_name);
+	}
+
+	for_each_root(root) {
+		if (!root->we_mounted_it)
+			continue;
+
+		/* This probably does not result in the CGroup root
+		 * being destroyed */
+		if (umount2(root->mnt_path, MNT_DETACH))
+			continue;
+
+		SAFE_RMDIR(root->mnt_path);
+	}
+
+clear_data:
+	for_each_ctrl(ctrl) {
+		ctrl->ctrl_root = NULL;
+		ctrl->we_require_it = 0;
+	}
+
+	for_each_root(root)
+		close_path_fds(root);
+
+	memset(roots, 0, sizeof(roots));
 }
 
-void tst_cgroup_umount(const char *cgroup_dir)
+static void cgroup_group_init(struct tst_cgroup_group *cg,
+			      const char *group_name)
 {
-	char *cgroup_new_dir;
+	memset(cg, 0, sizeof(*cg));
+	cg->group_name = group_name;
+}
+
+static void cgroup_group_add_dir(struct tst_cgroup_group *cg,
+				 struct cgroup_dir *dir)
+{
+	const struct cgroup_ctrl *ctrl;
+	int i;
+
+	if (dir->dir_root->ver == TST_CGROUP_V2)
+		cg->dirs_by_ctrl[0] = dir;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
-	tst_cgroup_del_path(cgroup_dir);
+	for_each_ctrl(ctrl) {
+		if (has_ctrl(dir->ctrl_field, ctrl))
+			cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
+	}
+
+	for (i = 0; cg->dirs[i]; i++);
+	cg->dirs[i] = dir;
 }
 
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value)
+struct tst_cgroup_group *
+tst_cgroup_group_mk(const struct tst_cgroup_group *parent,
+		    const char *group_name)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	struct tst_cgroup_group *cg;
+	struct cgroup_dir *const *dir;
+	struct cgroup_dir *new_dir;
+
+	cg = SAFE_MALLOC(sizeof(*cg));
+	cgroup_group_init(cg, group_name);
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	sprintf(knob_path, "%s/%s", cgroup_new_dir, knob);
-	SAFE_FILE_PRINTF(knob_path, "%ld", value);
+	for_each_dir(parent, 0, dir) {
+		new_dir = SAFE_MALLOC(sizeof(*new_dir));
+		cgroup_dir_mk(*dir, group_name, new_dir);
+		cgroup_group_add_dir(cg, new_dir);
+	}
+
+	return cg;
 }
 
-void tst_cgroup_move_current(const char *cgroup_dir)
+struct tst_cgroup_group *tst_cgroup_group_rm(struct tst_cgroup_group *cg)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "tasks", getpid());
+	struct cgroup_dir **dir;
+
+	for_each_dir(cg, 0, dir) {
+		close((*dir)->dir_fd);
+		SAFE_UNLINKAT((*dir)->dir_parent->dir_fd,
+			      (*dir)->dir_name,
+			      AT_REMOVEDIR);
+		free(*dir);
+	}
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "cgroup.procs", getpid());
+	free(cg);
+	return NULL;
 }
 
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz)
+/* Traverse the item tree to find an item. */
+static const struct cgroup_file *cgroup_file_find(const char *file,
+						  const int lineno,
+						  const char *file_name)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.limit_in_bytes", memsz);
+	const struct cgroup_file *cfile;
+	const struct cgroup_ctrl *ctrl;
+	char ctrl_name[32];
+	const char *mem_name;
+	size_t len = MIN(sizeof(ctrl_name) - 1, strcspn(file_name, "."));
+
+	memcpy(ctrl_name, file_name, len);
+	ctrl_name[len] = '\0';
+
+	ctrl = cgroup_find_ctrl(ctrl_name);
+
+	if (!ctrl) {
+		tst_brk_(file, lineno, TBROK,
+			 "Did not find controller '%s'\n", ctrl_name);
+		return NULL;
+	}
+
+	file_name += len + 1;
+
+	for (cfile = ctrl->files; cfile->file_name; cfile++) {
+		mem_name = cfile->file_name + len + 1;
+
+		if (!strcmp(file_name, mem_name))
+			break;
+	}
+
+	if (!cfile->file_name) {
+		tst_brk_(file, lineno, TBROK,
+			 "Did not find '%s' in '%s'\n",
+			 file_name, ctrl->ctrl_name);
+		return NULL;
+	}
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.max", memsz);
+	return cfile;
 }
 
-int tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir)
+enum tst_cgroup_ver tst_cgroup_ver(const char *file, const int lineno,
+				    const struct tst_cgroup_group *cg,
+				    const char *ctrl_name)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
+	const struct cgroup_dir *dir;
+
+	if (!strcmp(ctrl_name, "cgroup")) {
+		tst_brk_(file, lineno,
+			 TBROK,
+			 "cgroup may be present on both V1 and V2 hierarchies");
+		return 0;
+	}
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	if (!ctrl) {
+		tst_brk_(file, lineno,
+			 TBROK, "Unknown controller '%s'", ctrl_name);
+		return 0;
+	}
 
-	if (tst_cg_ver & TST_CGROUP_V1) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.memsw.limit_in_bytes");
+	dir = cg->dirs_by_ctrl[ctrl->ctrl_indx];
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+	if (!dir) {
+		tst_brk_(file, lineno,
+			 TBROK, "%s controller not attached to CGroup %s",
+			 ctrl_name, cg->group_name);
+		return 0;
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.swap.max");
+	return dir->dir_root->ver;
+}
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+static const char *cgroup_file_alias(const struct cgroup_file *const cfile,
+				     const struct cgroup_dir *const dir)
+{
+	if (dir->dir_root->ver != TST_CGROUP_V1)
+		return cfile->file_name;
+
+	if (cfile->ctrl_indx == CTRL_CPUSET &&
+	    dir->dir_root->no_cpuset_prefix &&
+	    cfile->file_name_v1) {
+		return strchr(cfile->file_name_v1, '.') + 1;
 	}
 
-	return 0;
+	return cfile->file_name_v1;
 }
 
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz)
+int safe_cgroup_has(const char *file, const int lineno,
+		    const struct tst_cgroup_group *cg, const char *file_name)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.memsw.limit_in_bytes", memsz);
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.swap.max", memsz);
+	if (!cfile)
+		return 0;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		if (!(alias = cgroup_file_alias(cfile, *dir)))
+		    continue;
+
+		if (!faccessat((*dir)->dir_fd, file_name, F_OK, 0))
+			return 1;
+
+		if (errno == ENOENT)
+			continue;
+
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "faccessat(%d<%s>, %s, F_OK, 0)",
+			 (*dir)->dir_fd, tst_decode_fd((*dir)->dir_fd), alias);
+	}
+
+	return 0;
 }
 
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz)
+static struct tst_cgroup_group *cgroup_group_from_roots(size_t tree_off)
 {
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	struct cgroup_root *root;
+	struct cgroup_dir *dir;
+	struct tst_cgroup_group *cg;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	cg = tst_alloc(sizeof(*cg));
+	cgroup_group_init(cg, NULL);
 
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
+	for_each_root(root) {
+		dir = (typeof(dir))(((char *)root) + tree_off);
+
+		if (dir->ctrl_field)
+			cgroup_group_add_dir(cg, dir);
 	}
 
-	memset(retbuf, 0, retbuf_sz);
-	if (read(fd, retbuf, retbuf_sz) < 0)
-		tst_brk(TBROK | TERRNO, "read %s", knob_path);
+	if (cg->dirs[0]) {
+		cg->group_name = cg->dirs[0]->dir_name;
+		return cg;
+	}
+
+	tst_brk(TBROK,
+		"No CGroups found; maybe you forgot to call tst_cgroup_require?");
 
-	close(fd);
+	return cg;
 }
 
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf)
+const struct tst_cgroup_group *tst_cgroup_get_test_group(void)
 {
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	return cgroup_group_from_roots(offsetof(struct cgroup_root, test_dir));
+}
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+const struct tst_cgroup_group *tst_cgroup_get_drain_group(void)
+{
+	return cgroup_group_from_roots(offsetof(struct cgroup_root, drain_dir));
+}
 
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
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+			 const struct tst_cgroup_group *cg, const char *file_name,
+			 char *out, size_t len)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+	size_t prev_len = 0;
+	char prev_buf[BUFSIZ];
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		if (!(alias = cgroup_file_alias(cfile, *dir)))
+			continue;
+
+		if (prev_len)
+			memcpy(prev_buf, out, prev_len);
+
+		TEST(safe_file_readat(file, lineno,
+				      (*dir)->dir_fd, alias, out, len));
+		if (TST_RET < 0)
+			continue;
+
+		if (prev_len && memcmp(out, prev_buf, prev_len)) {
+			tst_brk_(file, lineno, TBROK,
+				 "%s has different value across roots",
+				 file_name);
+			break;
+		}
+
+		prev_len = MIN(sizeof(prev_buf), (size_t)TST_RET);
 	}
 
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+	out[MAX(TST_RET, 0)] = '\0';
 
-	close(fd);
+	return TST_RET;
+}
+
+void safe_cgroup_printf(const char *file, const int lineno,
+			const struct tst_cgroup_group *cg,
+			const char *file_name,
+			const char *fmt, ...)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+	va_list va;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		if (!(alias = cgroup_file_alias(cfile, *dir)))
+		    continue;
+
+		va_start(va, fmt);
+		safe_file_vprintfat(file, lineno,
+				    (*dir)->dir_fd, alias, fmt, va);
+		va_end(va);
+	}
+}
+
+void safe_cgroup_scanf(const char *file, const int lineno,
+		       const struct tst_cgroup_group *cg, const char *file_name,
+		       const char *fmt, ...)
+{
+	va_list va;
+	char buf[BUFSIZ];
+	ssize_t len = safe_cgroup_read(file, lineno,
+				       cg, file_name, buf, sizeof(buf));
+
+	if (len < 1)
+		return;
+
+	va_start(va, fmt);
+	if (vsscanf(buf, fmt, va) < 1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "'%s': vsscanf('%s', '%s', ...)", file_name, buf, fmt);
+	}
+	va_end(va);
 }
-- 
2.31.1

