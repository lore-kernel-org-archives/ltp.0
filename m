From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 12 Apr 2021 15:55:02 +0100
Subject: [LTP] [PATCH v3 3/7] Add new CGroups APIs
In-Reply-To: <20210412145506.26894-1-rpalethorpe@suse.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
Message-ID: <20210412145506.26894-4-rpalethorpe@suse.com>
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
 include/tst_cgroup.h |  194 ++++++-
 include/tst_test.h   |    1 -
 lib/Makefile         |    2 +
 lib/tst_cgroup.c     | 1205 +++++++++++++++++++++++++++++++-----------
 4 files changed, 1056 insertions(+), 346 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index bfd848260..d6842d641 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -2,46 +2,194 @@
 /*
  * Copyright (c) 2020 Red Hat, Inc.
  * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
  */
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
+\*/
 
 #ifndef TST_CGROUP_H
 #define TST_CGROUP_H
 
-#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
-#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
-
+/* CGroups Kernel API version */
 enum tst_cgroup_ver {
 	TST_CGROUP_V1 = 1,
 	TST_CGROUP_V2 = 2,
 };
 
-enum tst_cgroup_ctrl {
-	TST_CGROUP_MEMCG = 1,
+/* Controller sub-systems */
+enum tst_cgroup_css {
+	TST_CGROUP_MEMORY = 1,
 	TST_CGROUP_CPUSET = 2,
-	/* add cgroup controller */
 };
+#define TST_CGROUP_MAX TST_CGROUP_CPUSET
+
+/* At most we can have one cgroup V1 tree for each controller and one
+ * (empty) v2 tree.
+ */
+#define TST_CGROUP_MAX_TREES (TST_CGROUP_MAX + 1)
+
+
+/* Used to specify CGroup hierarchy configuration options, allowing a
+ * test to request a particular CGroup structure.
+ */
+struct tst_cgroup_opts {
+	/* Only try to mount V1 CGroup controllers. This will not
+	 * prevent V2 from being used if it is already mounted, it
+	 * only indicates that we should mount V1 controllers if
+	 * nothing is present. By default we try to mount V2 first. */
+	int only_mount_v1:1;
+};
+
+struct tst_cgroup_tree;
+
+
+/* A Control Group in LTP's aggregated hierarchy */
+struct tst_cgroup {
+	const char *name;
+	/* Maps controller ID to the tree which contains it. The V2
+	 * tree is at zero even if it contains no controllers.
+	 */
+	struct tst_cgroup_tree *trees_by_css[TST_CGROUP_MAX_TREES];
+	/* NULL terminated list of trees */
+	struct tst_cgroup_tree *trees[TST_CGROUP_MAX_TREES + 1];
+};
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
+void tst_cgroup_require(enum tst_cgroup_css type,
+			const struct tst_cgroup_opts *options);
+
+/* Tear down any CGroups created by calls to tst_cgroup_require */
+void tst_cgroup_cleanup(void);
+
+/* Get the default CGroup for the test. It allocates memory (in a
+ * guarded buffer) so should always be called from setup
+ */
+const struct tst_cgroup *tst_cgroup_get_test(void);
+/* Get the shared drain group. Also should be called from setup */
+const struct tst_cgroup *tst_cgroup_get_drain(void);
+/* Create a descendant CGroup */
+struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
+				 const char *name);
+/* Remove a descendant CGroup */
+struct tst_cgroup *tst_cgroup_rm(struct tst_cgroup *cg);
+
+#define SAFE_CGROUP_VER(cg, name) \
+	safe_cgroup_ver(__FILE__, __LINE__, (cg), (name))
+
+enum tst_cgroup_ver safe_cgroup_ver(const char *file, const int lineno,
+				    const struct tst_cgroup *cg,
+				    const char *name);
+
+#define SAFE_CGROUP_HAS(cg, name) \
+	safe_cgroup_has(__FILE__, __LINE__, (cg), (name))
+
+int safe_cgroup_has(const char *file, const int lineno,
+		    const struct tst_cgroup *cg, const char *name);
+
+#define SAFE_CGROUP_READ(cg, name, out, len)				\
+	safe_cgroup_read(__FILE__, __LINE__, (cg), (name), (out), (len))
+
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+			 const struct tst_cgroup *cg, const char *name,
+			 char *out, size_t len);
 
-enum tst_cgroup_ver tst_cgroup_version(void);
+#define SAFE_CGROUP_PRINTF(cg, name, fmt, ...)				\
+	safe_cgroup_printf(__FILE__, __LINE__, (cg), (name), (fmt), __VA_ARGS__)
 
-/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
-void tst_cgroup_umount(const char *cgroup_dir);
+#define SAFE_CGROUP_PRINT(cg, name, str)				\
+	safe_cgroup_printf(__FILE__, __LINE__, (cg), (name), "%s", (str))
 
-/* To move current process PID to the mounted cgroup tasks */
-void tst_cgroup_move_current(const char *cgroup_dir);
+void safe_cgroup_printf(const char *file, const int lineno,
+			const struct tst_cgroup *cg, const char *name,
+			const char *fmt, ...)
+			__attribute__ ((format (printf, 5, 6)));
 
-/* To set cgroup controller knob with new value */
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
+#define SAFE_CGROUP_SCANF(cg, name, fmt, ...)				\
+	safe_cgroup_scanf(__FILE__, __LINE__, (cg), (name), (fmt), __VA_ARGS__)
 
-/* Set of functions to set knobs under the memory controller */
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
-int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
+void safe_cgroup_scanf(const char *file, const int lineno,
+		       const struct tst_cgroup *cg, const char *name,
+		       const char *fmt, ...)
+		       __attribute__ ((format (scanf, 5, 6)));
 
-/* Set of functions to read/write cpuset controller files content */
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz);
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename,
-	const char *buf);
 
 #endif /* TST_CGROUP_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index 1fbebe752..62ab2981f 100644
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
diff --git a/lib/Makefile b/lib/Makefile
index f019432e8..6f641ee9a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -38,6 +38,8 @@ pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
 
 INSTALL_TARGETS		:= $(pc_file)
 
+tst_cgroup.o: CFLAGS += -Wno-missing-field-initializers
+
 $(pc_file):
 	test -d "$(@D)" || mkdir -p "$(@D)"
 	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 96c9524d2..40c9a9bec 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -2,453 +2,1014 @@
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
 #include "tst_cgroup.h"
-#include "tst_device.h"
 
-static enum tst_cgroup_ver tst_cg_ver;
-static int clone_children;
+/* CGroup Core Implementation
+ *
+ * CGroup Item Implementation is towards the bottom.
+ */
 
-static int tst_cgroup_check(const char *cgroup)
-{
-	char line[PATH_MAX];
-	FILE *file;
-	int cg_check = 0;
+struct cgroup_root;
 
-	file = SAFE_FOPEN("/proc/filesystems", "r");
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, cgroup) != NULL) {
-			cg_check = 1;
-			break;
+/* A node in a single CGroup hierarchy. It exists mainly for
+ * convenience so that we do not have to traverse the CGroup structure
+ * for frequent operations.
+ *
+ * This is actually a single-linked list not a tree. We only need to
+ * traverse from leaf towards root.
+ */
+struct tst_cgroup_tree {
+	const char *name;
+	const struct tst_cgroup_tree *parent;
+
+	/* Shortcut to root */
+	const struct cgroup_root *root;
+
+	/* Subsystems (controllers) bit field. Only controllers which
+	 * were required and configured for this node are added to
+	 * this field. So it may be different from root->css_field.
+	 */
+	uint32_t css_field;
+
+	/* In general we avoid having sprintfs everywhere and use
+	 * openat, linkat, etc.
+	 */
+	int dir;
+
+	int we_created_it:1;
+};
+
+/* The root of a CGroup hierarchy/tree */
+struct cgroup_root {
+	enum tst_cgroup_ver ver;
+	/* A mount path */
+	char path[PATH_MAX/2];
+	/* Subsystems (controllers) bit field. Includes all
+	 * controllers found while scanningthis root.
+	 */
+	uint32_t css_field;
+
+	/* CGroup hierarchy: mnt -> ltp -> {drain, test -> ??? } We
+	 * keep a flat reference to ltp, drain and test for
+	 * convenience.
+	 */
+
+	/* Mount directory */
+	struct tst_cgroup_tree mnt;
+	/* LTP CGroup directory, contains drain and test dirs */
+	struct tst_cgroup_tree ltp;
+	/* Drain CGroup, see cgroup_cleanup */
+	struct tst_cgroup_tree drain;
+	/* CGroup for current test. Which may have children. */
+	struct tst_cgroup_tree test;
+
+	int we_mounted_it:1;
+	/* cpuset is in compatability mode */
+	int no_prefix:1;
+};
+
+/* Always use first item for unified hierarchy */
+struct cgroup_root roots[TST_CGROUP_MAX_TREES + 1];
+
+/* Describes some things that are part of a CGroup
+ *
+ * Usually trunk nodes are controllers and leaves are files exported
+ * by the controllers. Sometimes trunk nodes are components of a
+ * controller (e.g. memory.swap).
+ *
+ * The primary purpose of this is to map V2 names to V1
+ * names. Secondarily we can map name prefixes to controller IDs and
+ * figure out which hierarchy the item should be present on and
+ * whether the current configuration requires yet further work arounds
+ * (e.g. if cpuset is mounted in compatablity mode).
+ */
+struct cgroup_item {
+	/* Canonical name. Is the V2 name unless an item is V1 only */
+	const char *name;
+	/* V1 name or NULL if item is V2 only */
+	const char *name_v1;
+	/* Array of child items or NULL */
+	struct cgroup_item *inner;
+
+	/* The controller this item belongs to or zero for
+	 * 'cgroup.<item>'. Leaf items are statically initialised as
+	 * zero then set at runtime.
+	 */
+	enum tst_cgroup_css css_indx;
+
+	struct cgroup_root *root;
+
+	int we_require_it:1;
+};
+
+/* Lookup tree for item names. */
+typedef struct cgroup_item items_t[];
+static items_t items = {
+	[0] = { "cgroup", .inner = (items_t){
+			{ "cgroup.procs", "tasks" },
+			{ "cgroup.subtree_control" },
+			{ "cgroup.clone_children", "clone_children" },
+			{ NULL }
 		}
-	}
-	SAFE_FCLOSE(file);
+	},
+	[TST_CGROUP_MEMORY] = { "memory", .inner = (items_t){
+			{ "memory.current", "memory.usage_in_bytes" },
+			{ "memory.max", "memory.limit_in_bytes" },
+			{ "memory.swappiness", "memory.swappiness" },
+			{ "memory.swap.current", "memory.memsw.usage_in_bytes" },
+			{ "memory.swap.max", "memory.memsw.limit_in_bytes" },
+			{ "memory.kmem.usage_in_bytes", "memory.kmem.usage_in_bytes" },
+			{ "memory.kmem.limit_in_bytes", "memory.kmem.usage_in_bytes" },
+			{ NULL }
+		},
+	  .css_indx = TST_CGROUP_MEMORY
+	},
+	[TST_CGROUP_CPUSET] = { "cpuset", .inner = (items_t){
+			{ "cpuset.cpus", "cpuset.cpus" },
+			{ "cpuset.mems", "cpuset.mems" },
+			{ "cpuset.memory_migrate", "cpuset.memory_migrate" },
+			{ NULL }
+		},
+	  .css_indx = TST_CGROUP_CPUSET
+	},
+	{ NULL }
+};
 
-	return cg_check;
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
+#define for_each_css(css)			\
+	for ((css) = items + 1; (css)->name; (css)++)
+
+/* Controller items may only be in a single tree. So when (ss) > 0
+ * we only loop once.
+ */
+#define for_each_tree(cg, css, t)					\
+	for ((t) = (css) ? (cg)->trees_by_css + (css) : (cg)->trees;	\
+	     *(t);							\
+	     (t) = (css) ? (cg)->trees + TST_CGROUP_MAX_TREES : (t) + 1)
+
+static int has_css(uint32_t css_field, enum tst_cgroup_css type)
+{
+	return !!(css_field & (1 << type));
 }
 
-enum tst_cgroup_ver tst_cgroup_version(void)
+static void add_css(uint32_t *css_field, const struct cgroup_item *css)
 {
-        enum tst_cgroup_ver cg_ver;
+	*css_field |= 1 << css->css_indx;
+}
 
-        if (tst_cgroup_check("cgroup2")) {
-                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
-                        cg_ver = TST_CGROUP_V1;
-                else
-                        cg_ver = TST_CGROUP_V2;
+struct cgroup_root *tst_cgroup_root_get(void)
+{
+	return roots[0].ver ? roots : roots + 1;
+}
 
-                goto out;
-        }
+static int cgroup_v2_mounted(void)
+{
+	return !!roots[0].ver;
+}
+
+static int cgroup_v1_mounted(void)
+{
+	return !!roots[1].ver;
+}
 
-        if (tst_cgroup_check("cgroup"))
-                cg_ver = TST_CGROUP_V1;
+static int cgroup_mounted(void)
+{
+	return cgroup_v2_mounted() || cgroup_v1_mounted();
+}
 
-        if (!cg_ver)
-                tst_brk(TCONF, "Cgroup is not configured");
+static struct cgroup_item *cgroup_get_css(enum tst_cgroup_css type)
+{
+	return items + type;
+}
 
-out:
-        return cg_ver;
+static int cgroup_css_on_v2(const struct cgroup_item *css)
+{
+	return css->root && css->root->ver == TST_CGROUP_V2;
 }
 
-static void tst_cgroup1_mount(const char *name, const char *option,
-			const char *mnt_path, const char *new_path)
+int tst_cgroup_tree_mk(const struct tst_cgroup_tree *parent,
+		       const char *name,
+		       struct tst_cgroup_tree *new)
 {
-	char knob_path[PATH_MAX];
-	if (tst_is_mounted(mnt_path))
-		goto out;
+	char *dpath;
 
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v1 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	new->root = parent->root;
+	new->name = name;
+	new->parent = parent;
+	new->css_field = parent->css_field;
+	new->we_created_it = 0;
+
+	if (!mkdirat(parent->dir, name, 0777)) {
+		new->we_created_it = 1;
+		goto opendir;
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
+	if (errno == EEXIST)
+		goto opendir;
+
+	dpath = tst_decode_fd(parent->dir);
+
+	if (errno == EACCES) {
+		tst_brk(TCONF | TERRNO,
+			"Lack permission to make '%s/%s'; premake it or run as root",
+			dpath, name);
+	} else {
+		tst_brk(TBROK | TERRNO,
+			"mkdirat(%d<%s>, '%s', 0777)", parent->dir, dpath, name);
 	}
-out:
-	SAFE_MKDIR(new_path, 0777);
 
-	tst_res(TINFO, "Cgroup(%s) v1 mount at %s success", option, mnt_path);
+	return -1;
+opendir:
+	new->dir = SAFE_OPENAT(parent->dir, name, O_PATH | O_DIRECTORY);
+
+	return 0;
 }
 
-static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
+void tst_cgroup_print_config(void)
 {
-	if (tst_is_mounted(mnt_path))
-		goto out;
+	struct cgroup_root *t;
+	struct cgroup_item *css;
 
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v2 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	tst_res(TINFO, "Detected Controllers:");
+
+	for_each_css(css) {
+		t = css->root;
+
+		if (!t)
+			continue;
+
+		tst_res(TINFO, "\t%.10s %s @ %s:%s",
+			css->name,
+			t->no_prefix ? "[noprefix]" : "",
+			t->ver == TST_CGROUP_V1 ? "V1" : "V2",
+			t->path);
+	}
+}
+
+static const struct cgroup_item *cgroup_find_css(const char *name)
+{
+	struct cgroup_item *next = items;
+
+	while (next->name && strcmp(name, next->name))
+		next++;
+
+	if (!next->name)
+		next = NULL;
+
+	return next;
+}
+
+/* Determine if a mounted cgroup hierarchy (tree) is unique and record it if so.
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
+ * Each controller partition has its own hierarchy which we must track
+ * and update independently.
+ */
+static void cgroup_root_scan(const char *type, const char *path, char *opts)
+{
+	struct cgroup_root *t = roots;
+	const struct cgroup_item *css;
+	struct cgroup_item *ss;
+	uint32_t css_field = 0;
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
+		if ((css = cgroup_find_css(tok)))
+			add_css(&css_field, css);
+	}
+
+	if (t->ver && css_field == t->css_field)
+		goto discard;
+
+	if (t->css_field)
+		tst_brk(TBROK, "Available V2 controllers are changing between scans?");
+
+	t->ver = TST_CGROUP_V2;
+
+	goto backref;
+
+v1:
+	for (tok = strtok(opts, ","); tok; tok = strtok(NULL, ",")) {
+		if ((css = cgroup_find_css(tok)))
+			add_css(&css_field, css);
+
+		no_prefix |= !strcmp("noprefix", tok);
 	}
 
-out:
-	SAFE_MKDIR(new_path, 0777);
+	if (!css_field)
+		goto discard;
 
-	tst_res(TINFO, "Cgroup v2 mount at %s success", mnt_path);
+	for_each_v1_root(t) {
+		if (!(css_field & t->css_field))
+			continue;
+
+		if (css_field == t->css_field)
+			goto discard;
+
+		tst_brk(TBROK,
+			"The intersection of two distinct sets of mounted controllers should be null?"
+			"Check '%s' and '%s'", t->path, path);
+	}
+
+	if (t >= roots + TST_CGROUP_MAX_TREES) {
+		tst_brk(TBROK, "Unique controller mounts have exceeded our limit %d?",
+			TST_CGROUP_MAX_TREES);
+	}
+
+	t->ver = TST_CGROUP_V1;
+
+backref:
+	strcpy(t->path, path);
+	t->mnt.root = t;
+	t->mnt.name = t->path;
+	t->mnt.dir = dfd;
+	t->css_field = css_field;
+	t->no_prefix = no_prefix;
+
+	for_each_css(ss) {
+		if (has_css(t->css_field, ss->css_indx))
+			ss->root = t;
+	}
+
+	return;
+
+discard:
+	close(dfd);
 }
 
-static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
+void tst_cgroup_scan(void)
 {
-	FILE *fp;
-	int fd;
-	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
-	char knob_path[PATH_MAX];
+	struct mntent *mnt;
+	FILE *f = setmntent("/proc/self/mounts", "r");
+
+	if (!f)
+		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
+
+	mnt = getmntent(f);
+	if (!mnt)
+		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
 
-	if (!tst_is_mounted(mnt_path))
+	do {
+		if (strncmp(mnt->mnt_type, "cgroup", 6))
+			continue;
+
+		cgroup_root_scan(mnt->mnt_type, mnt->mnt_dir, mnt->mnt_opts);
+	} while ((mnt = getmntent(f)));
+}
+
+static void cgroup_mount_v2(void)
+{
+	char path[PATH_MAX];
+
+	sprintf(path, "%s%s", ltp_mount_prefix, ltp_v2_mount);
+
+	if (!mkdir(path, 0777)) {
+		roots[0].mnt.we_created_it = 1;
+		goto mount;
+	}
+
+	if (errno == EEXIST)
+		goto mount;
+
+	if (errno == EACCES) {
+		tst_res(TINFO | TERRNO,
+			"Lack permission to make %s, premake it or run as root",
+			path);
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
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
+mount:
+	if (!mount("cgroup2", path, "cgroup2", 0, NULL)) {
+		tst_res(TINFO, "Mounted V2 CGroups on %s", path);
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
+	tst_res(TINFO | TERRNO, "Could not mount V2 CGroups on %s", path);
 
-static void tst_cgroup_set_path(const char *cgroup_dir)
+	if (roots[0].mnt.we_created_it) {
+		roots[0].mnt.we_created_it = 0;
+		SAFE_RMDIR(path);
+	}
+}
+
+static void cgroup_mount_v1(enum tst_cgroup_css type)
 {
-	char cgroup_new_dir[PATH_MAX];
-	struct tst_cgroup_path *tst_cgroup_path, *a;
+	struct cgroup_item *css = cgroup_get_css(type);
+	char path[PATH_MAX];
+	int made_dir = 0;
 
-	if (!cgroup_dir)
-		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
+	sprintf(path, "%s%s", ltp_mount_prefix, css->name);
 
-	sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
+	if (!mkdir(path, 0777)) {
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
+			path);
+		return;
+	}
+
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
+mount:
+	if (mount(css->name, path, "cgroup", 0, css->name)) {
+		tst_res(TINFO | TERRNO,
+			"Could not mount V1 CGroup on %s", path);
+
+		if (made_dir)
+			SAFE_RMDIR(path);
+		return;
 	}
 
-	sprintf(tst_cgroup_path->mnt_path, "%s", cgroup_dir);
-	sprintf(tst_cgroup_path->new_path, "%s", cgroup_new_dir);
+	tst_res(TINFO, "Mounted V1 %s CGroup on %s", css->name, path);
+	tst_cgroup_scan();
+	css->root->we_mounted_it = 1;
+	css->root->mnt.we_created_it = made_dir;
+
+	if (type == TST_CGROUP_MEMORY) {
+		SAFE_FILE_PRINTFAT(css->root->mnt.dir,
+				   "memory.use_hierarchy", "%d", 1);
+	}
 }
 
-static char *tst_cgroup_get_path(const char *cgroup_dir)
+static void cgroup_copy_cpuset(const struct cgroup_root *t)
 {
-	struct tst_cgroup_path *a;
+	char buf[BUFSIZ];
+	int i;
+	const char *n0[] = {"mems", "cpus"};
+	const char *n1[] = {"cpuset.mems", "cpuset.cpus"};
+	const char **fname = t->no_prefix ? n0 : n1;
+
+	for (i = 0; i < 2; i++) {
+		SAFE_FILE_READAT(t->mnt.dir, fname[i], buf, sizeof(buf));
+		SAFE_FILE_PRINTFAT(t->ltp.dir, fname[i], "%s", buf);
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
+void tst_cgroup_require(enum tst_cgroup_css type,
+			const struct tst_cgroup_opts *options)
+{
+	const char *const cgsc = "cgroup.subtree_control";
+	struct cgroup_item *css = cgroup_get_css(type);
+	struct cgroup_root *t;
 
-	a = tst_cgroup_paths;
+	if (!options)
+		options = &default_opts;
 
-	while (strcmp(a->mnt_path, cgroup_dir) != 0){
-		if (!a->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return NULL;
-		}
-		a = a->next;
-	};
+	if (css->we_require_it)
+		tst_res(TWARN, "Duplicate tst_cgroup_require(%s, )", css->name);
+	css->we_require_it = 1;
+
+	if (css->root)
+		goto mkdirs;
+
+	tst_cgroup_scan();
+
+	if (css->root)
+		goto mkdirs;
 
-	return a->new_path;
+	if (!cgroup_v2_mounted() && !options->only_mount_v1)
+		cgroup_mount_v2();
+
+	if (css->root)
+		goto mkdirs;
+
+	cgroup_mount_v1(type);
+
+	if (!css->root) {
+		tst_brk(TCONF,
+			"'%s' controller required, but not available", css->name);
+	}
+
+mkdirs:
+	t = css->root;
+	add_css(&t->mnt.css_field, css);
+
+	if (cgroup_css_on_v2(css)) {
+		if (t->we_mounted_it)
+			SAFE_FILE_PRINTFAT(t->mnt.dir, cgsc, "+%s", css->name);
+		else
+			tst_file_printfat(t->mnt.dir, cgsc, "+%s", css->name);
+	}
+
+	if (!t->ltp.dir)
+		tst_cgroup_tree_mk(&t->mnt, ltp_cgroup_dir, &t->ltp);
+	else
+		t->ltp.css_field |= t->mnt.css_field;
+
+	if (cgroup_css_on_v2(css)) {
+		SAFE_FILE_PRINTFAT(t->ltp.dir, cgsc, "+%s", css->name);
+	} else {
+		SAFE_FILE_PRINTFAT(t->ltp.dir, "cgroup.clone_children",
+				   "%d", 1);
+
+		if (type == TST_CGROUP_CPUSET)
+			cgroup_copy_cpuset(t);
+	}
+
+	tst_cgroup_tree_mk(&t->ltp, ltp_cgroup_drain_dir, &t->drain);
+
+	sprintf(test_cgroup_dir, "test-%d", getpid());
+	tst_cgroup_tree_mk(&t->ltp, test_cgroup_dir, &t->test);
 }
 
-static void tst_cgroup_del_path(const char *cgroup_dir)
+static void cgroup_drain(enum tst_cgroup_ver ver, int source, int dest)
 {
-	struct tst_cgroup_path *a, *b;
+	char buf[BUFSIZ];
+	char *tok;
+	const char *fname = ver == TST_CGROUP_V1 ? "tasks" : "cgroup.procs";
+	int fd;
+	ssize_t ret;
 
-	if (!tst_cgroup_paths)
+	ret = SAFE_FILE_READAT(source, fname, buf, sizeof(buf));
+	if (ret < 0)
 		return;
 
-	a = b = tst_cgroup_paths;
+	fd = SAFE_OPENAT(dest, fname, O_WRONLY);
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
+	for (tok = strtok(buf, "\n"); tok; tok = strtok(NULL, "\n")) {
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
+static void close_path_fds(struct cgroup_root *t)
+{
+	if (t->test.dir > 0)
+		SAFE_CLOSE(t->test.dir);
+	if (t->ltp.dir > 0)
+		SAFE_CLOSE(t->ltp.dir);
+	if (t->drain.dir > 0)
+		SAFE_CLOSE(t->drain.dir);
+	if (t->mnt.dir > 0)
+		SAFE_CLOSE(t->mnt.dir);
 }
 
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir)
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
+void tst_cgroup_cleanup(void)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	struct cgroup_root *t;
+	struct cgroup_item *css;
 
-	tst_cg_ver = tst_cgroup_version();
+	if (!cgroup_mounted())
+		goto clear_data;
 
-	tst_cgroup_set_path(cgroup_dir);
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	for_each_root(t) {
+		if (!t->test.name)
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
+		cgroup_drain(t->ver, t->test.dir, t->drain.dir);
+		SAFE_UNLINKAT(t->ltp.dir, t->test.name, AT_REMOVEDIR);
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		tst_cgroup2_mount(cgroup_dir, cgroup_new_dir);
+	for_each_root(t) {
+		if (!t->ltp.we_created_it)
+			continue;
 
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
+		cgroup_drain(t->ver, t->drain.dir, t->mnt.dir);
+
+		if (t->drain.name)
+			SAFE_UNLINKAT(t->ltp.dir, t->drain.name, AT_REMOVEDIR);
+
+		if (t->ltp.name)
+			SAFE_UNLINKAT(t->mnt.dir, t->ltp.name, AT_REMOVEDIR);
+	}
+
+	for_each_css(css) {
+		if (!cgroup_css_on_v2(css) || !css->root->we_mounted_it)
+			continue;
+
+		SAFE_FILE_PRINTFAT(css->root->mnt.dir, "cgroup.subtree_control",
+				   "-%s", css->name);
+	}
+
+	for_each_root(t) {
+		if (!t->we_mounted_it)
+			continue;
+
+		/* This probably does not result in the CGroup root
+		 * being destroyed */
+		if (umount2(t->path, MNT_DETACH))
+			continue;
+
+		SAFE_RMDIR(t->path);
+	}
+
+clear_data:
+	for_each_css(css) {
+		css->root = NULL;
+		css->we_require_it = 0;
 	}
+
+	for_each_root(t)
+		close_path_fds(t);
+
+	memset(roots, 0, sizeof(roots));
 }
 
-void tst_cgroup_umount(const char *cgroup_dir)
+static void cgroup_init(struct tst_cgroup *cg, const char *name)
 {
-	char *cgroup_new_dir;
+	memset(cg, 0, sizeof(*cg));
+	cg->name = name;
+}
+
+static void cgroup_add(struct tst_cgroup *cg,
+		       struct tst_cgroup_tree *tree)
+{
+	const struct cgroup_item *css;
+	int i;
+
+	if (tree->root->ver == TST_CGROUP_V2)
+		cg->trees_by_css[0] = tree;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
-	tst_cgroup_del_path(cgroup_dir);
+	for_each_css(css) {
+		if (has_css(tree->css_field, css->css_indx))
+			cg->trees_by_css[css->css_indx] = tree;
+	}
+
+	for (i = 0; cg->trees[i]; i++);
+	cg->trees[i] = tree;
 }
 
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value)
+struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
+				 const char *name)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	struct tst_cgroup *cg;
+	struct tst_cgroup_tree *const *t;
+	struct tst_cgroup_tree *nt;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	sprintf(knob_path, "%s/%s", cgroup_new_dir, knob);
-	SAFE_FILE_PRINTF(knob_path, "%ld", value);
+	cg = SAFE_MALLOC(sizeof(*cg));
+	cgroup_init(cg, name);
+
+	for_each_tree(parent, 0, t) {
+		nt = SAFE_MALLOC(sizeof(*nt));
+		tst_cgroup_tree_mk(*t, name, nt);
+		cgroup_add(cg, nt);
+	}
+
+	return cg;
 }
 
-void tst_cgroup_move_current(const char *cgroup_dir)
+struct tst_cgroup *tst_cgroup_rm(struct tst_cgroup *cg)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "tasks", getpid());
+	struct tst_cgroup_tree **t;
+
+	for_each_tree(cg, 0, t) {
+		close((*t)->dir);
+		SAFE_UNLINKAT((*t)->parent->dir, (*t)->name, AT_REMOVEDIR);
+		free(*t);
+	}
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "cgroup.procs", getpid());
+	free(cg);
+	return NULL;
 }
 
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz)
+/* Traverse the item tree to find an item. Also fixes up the indx field. */
+static const struct cgroup_item *
+cgroup_item_find(const char *file, const int lineno, const char *name)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.limit_in_bytes", memsz);
+	struct cgroup_item *item;
+	const struct cgroup_item *css;
+	char buf[32];
+	const char *mem_name;
+	size_t len = MIN(sizeof(buf) - 1, strcspn(name, "."));
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.max", memsz);
+	memcpy(buf, name, len);
+	buf[len] = '\0';
+
+	css = cgroup_find_css(buf);
+
+	if (!css) {
+		tst_brk_(file, lineno, TBROK,
+			 "Did not find controller '%s'\n", buf);
+		return NULL;
+	}
+
+	name += len + 1;
+
+	for (item = css->inner; item->name; item++) {
+		mem_name = item->name + len + 1;
+
+		if (!strcmp(name, mem_name))
+			break;
+	}
+
+	if (!item->name) {
+		tst_brk_(file, lineno, TBROK,
+			 "Did not find '%s' in '%s'\n", name, css->name);
+		return NULL;
+	}
+
+	item->css_indx = css->css_indx;
+
+	return item;
 }
 
-int tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir)
+enum tst_cgroup_ver safe_cgroup_ver(const char *file, const int lineno,
+				    const struct tst_cgroup *cg,
+				    const char *name)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	const struct cgroup_item *const it = cgroup_find_css(name);
+	const struct tst_cgroup_tree *t;
+
+	if (!strcmp(name, "cgroup")) {
+		tst_brk_(file, lineno,
+			 TBROK,
+			 "cgroup may be present on both V1 and V2 hierarchies");
+		return 0;
+	}
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	if (!it) {
+		tst_brk_(file, lineno,
+			 TBROK, "Unknown controller '%s'", name);
+		return 0;
+	}
 
-	if (tst_cg_ver & TST_CGROUP_V1) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.memsw.limit_in_bytes");
+	t = cg->trees_by_css[it->css_indx];
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+	if (!t) {
+		tst_brk_(file, lineno,
+			 TBROK, "%s controller not attached to CGroup %s",
+			 name, cg->name);
+		return 0;
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.swap.max");
+	return t->root->ver;
+}
+
+static const char *cgroup_item_alias(const struct cgroup_item *const it,
+				     const struct tst_cgroup_tree *const tree)
+{
+	if (tree->root->ver != TST_CGROUP_V1)
+		return it->name;
+
+	if (it->css_indx == TST_CGROUP_CPUSET && tree->root->no_prefix)
+		return strchr(it->name_v1, '.') + 1;
+
+	return it->name_v1;
+}
+
+int safe_cgroup_has(const char *file, const int lineno,
+		    const struct tst_cgroup *cg, const char *name)
+{
+	const struct cgroup_item *const it =
+		cgroup_item_find(file, lineno, name);
+	struct tst_cgroup_tree *const *t;
+	const char *alias;
+
+	if (!it)
+		return 0;
+
+	for_each_tree(cg, it->css_indx, t) {
+		if (!(alias = cgroup_item_alias(it, *t)))
+		    continue;
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
+		if (!faccessat((*t)->dir, name, F_OK, 0))
 			return 1;
-		}
+
+		if (errno == ENOENT)
+			continue;
+
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "faccessat(%d<%s>, %s, F_OK, 0)",
+			 (*t)->dir, tst_decode_fd((*t)->dir), alias);
 	}
 
 	return 0;
 }
 
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz)
+static struct tst_cgroup *cgroup_from_roots(size_t tree_off)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.memsw.limit_in_bytes", memsz);
+	struct cgroup_root *r;
+	struct tst_cgroup_tree *t;
+	struct tst_cgroup *cg;
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.swap.max", memsz);
-}
+	cg = tst_alloc(sizeof(*cg));
+	cgroup_init(cg, NULL);
 
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz)
-{
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	for_each_root(r) {
+		t = (typeof(t))(((char *)r) + tree_off);
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+		if (t->css_field)
+			cgroup_add(cg, t);
+	}
 
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
+	if (cg->trees[0]) {
+		cg->name = cg->trees[0]->name;
+		return cg;
 	}
 
-	memset(retbuf, 0, retbuf_sz);
-	if (read(fd, retbuf, retbuf_sz) < 0)
-		tst_brk(TBROK | TERRNO, "read %s", knob_path);
+	tst_brk(TBROK,
+		"No CGroups found; maybe you forgot to call tst_cgroup_require?");
 
-	close(fd);
+	return cg;
 }
 
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf)
+const struct tst_cgroup *tst_cgroup_get_test(void)
 {
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	return cgroup_from_roots(offsetof(struct cgroup_root, test));
+}
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+const struct tst_cgroup *tst_cgroup_get_drain(void)
+{
+	return cgroup_from_roots(offsetof(struct cgroup_root, drain));
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
+			 const struct tst_cgroup *cg, const char *name,
+			 char *out, size_t len)
+{
+	size_t prev_len = 0;
+	const struct cgroup_item *const it =
+		cgroup_item_find(file, lineno, name);
+	struct tst_cgroup_tree *const *t;
+	const char *alias;
+	char buf[BUFSIZ];
+
+	for_each_tree(cg, it->css_indx, t) {
+		if (!(alias = cgroup_item_alias(it, *t)))
+			continue;
+
+		if (prev_len)
+			memcpy(buf, out, prev_len);
+
+		TEST(safe_file_readat(file, lineno,
+				      (*t)->dir, alias, out, len));
+		if (TST_RET < 0)
+			continue;
+
+		if (prev_len && memcmp(out, buf, prev_len)) {
+			tst_brk_(file, lineno, TBROK,
+				 "%s has different value across roots",
+				 name);
+			break;
+		}
+
+		prev_len = MIN(sizeof(buf), (size_t)TST_RET);
+	}
+
+	out[MAX(TST_RET, 0)] = '\0';
+
+	return TST_RET;
+}
+
+void safe_cgroup_printf(const char *file, const int lineno,
+			const struct tst_cgroup *cg, const char *name,
+			const char *fmt, ...)
+{
+	const struct cgroup_item *const it =
+		cgroup_item_find(file, lineno, name);
+	struct tst_cgroup_tree *const *t;
+	const char *alias;
+	va_list va;
+
+	for_each_tree(cg, it->css_indx, t) {
+		if (!(alias = cgroup_item_alias(it, *t)))
+		    continue;
+
+		va_start(va, fmt);
+		safe_file_vprintfat(file, lineno, (*t)->dir, alias, fmt, va);
+		va_end(va);
 	}
+}
 
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+void safe_cgroup_scanf(const char *file, const int lineno,
+		       const struct tst_cgroup *cg, const char *name,
+		       const char *fmt, ...)
+{
+	va_list va;
+	char buf[BUFSIZ];
+	ssize_t len = safe_cgroup_read(file, lineno, cg, name, buf, sizeof(buf));
 
-	close(fd);
+	if (len < 1)
+		return;
+
+	va_start(va, fmt);
+	if (vsscanf(buf, fmt, va) < 1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "'%s': vsscanf('%s', '%s', ...)", name, buf, fmt);
+	}
+	va_end(va);
 }
-- 
2.30.2

