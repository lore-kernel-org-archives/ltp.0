From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  2 Mar 2021 15:25:06 +0000
Subject: [LTP] [RFC PATCH v2 3/7] Add new CGroups Core and Item APIs
In-Reply-To: <20210302152510.15116-1-rpalethorpe@suse.com>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
Message-ID: <20210302152510.15116-4-rpalethorpe@suse.com>
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
 include/tst_cgroup.h      |  124 ++--
 include/tst_cgroup_core.h |   58 ++
 include/tst_cgroup_item.h |  139 ++++
 include/tst_test.h        |    1 -
 lib/tst_cgroup.c          | 1258 +++++++++++++++++++++++++++----------
 5 files changed, 1224 insertions(+), 356 deletions(-)
 create mode 100644 include/tst_cgroup_core.h
 create mode 100644 include/tst_cgroup_item.h

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index bfd848260..3263537c2 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -2,46 +2,98 @@
 /*
  * Copyright (c) 2020 Red Hat, Inc.
  * Copyright (c) 2020 Li Wang <liwang@redhat.com>
+ * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
  */
+/*\
+ * [DESCRIPTION]
+ *
+ * The LTP Control Groups library can be seperated into two parts.
+ * - CGroup Core
+ * - CGroup Item
+ *
+ * The CGroup Core is where we scan the current system, build a model
+ * of the current CGroup configuration, then add missing configuration
+ * necessary for the LTP or give up. Once testing is finished it then
+ * also attempts cleanup.
+ *
+ * The CGroup Item interface is mostly what the test author interacts
+ * with. It mirrors the CGroups V2 (unified) kernel API. So even if
+ * the system has some nasty V1 configuration, the test author may
+ * write their code as if for V2 (with exceptions). It builds on the
+ * model created by CGroup Core.
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
+ * existing system manager created CGroups have been omitted.
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
+ * name, but the same functionality. In this case the Item API uses
+ * the V2 names and aliases them to the V1 name when appropriate.
+ *
+ * Some control files only exist on one of the versions or they can be
+ * missing due to other reasons. The Item API allows the user to check
+ * if the file exists before trying to use it.
+ *
+ * In some cases a control file has almost the same functionality
+ * between V1 and V2. Which means it can be used in the same way most
+ * of the time, but not all. For now this is handled by exposing the
+ * API version a controller is using to allow the test author to
+ * handle edge cases. (e.g. V2 memory.swap.max accepts "max", but V1
+ * memory.memsw.limit_in_bytes does not).
+\*/
 
 #ifndef TST_CGROUP_H
 #define TST_CGROUP_H
 
-#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
-#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
-
-enum tst_cgroup_ver {
-	TST_CGROUP_V1 = 1,
-	TST_CGROUP_V2 = 2,
-};
-
-enum tst_cgroup_ctrl {
-	TST_CGROUP_MEMCG = 1,
-	TST_CGROUP_CPUSET = 2,
-	/* add cgroup controller */
-};
-
-enum tst_cgroup_ver tst_cgroup_version(void);
-
-/* To mount/umount specified cgroup controller on 'cgroup_dir' path */
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir);
-void tst_cgroup_umount(const char *cgroup_dir);
-
-/* To move current process PID to the mounted cgroup tasks */
-void tst_cgroup_move_current(const char *cgroup_dir);
-
-/* To set cgroup controller knob with new value */
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value);
-
-/* Set of functions to set knobs under the memory controller */
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz);
-int  tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir);
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz);
-
-/* Set of functions to read/write cpuset controller files content */
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz);
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename,
-	const char *buf);
+#include "tst_cgroup_core.h"
+#include "tst_cgroup_item.h"
 
 #endif /* TST_CGROUP_H */
diff --git a/include/tst_cgroup_core.h b/include/tst_cgroup_core.h
new file mode 100644
index 000000000..00c1b6f84
--- /dev/null
+++ b/include/tst_cgroup_core.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+#ifndef TST_CGROUP_CORE_H
+#define TST_CGROUP_CORE_H
+
+enum tst_cgroup_ver {
+	TST_CGROUP_V1 = 1,
+	TST_CGROUP_V2 = 2,
+};
+
+enum tst_cgroup_ctrl {
+	TST_CGROUP_MEMORY = 1,
+	TST_CGROUP_CPUSET = 2,
+};
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
+struct tst_cgroup_location {
+	const char *name;
+	const struct tst_cgroup_tree *tree;
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
+void tst_cgroup_require(enum tst_cgroup_ctrl type,
+			const struct tst_cgroup_opts *options);
+
+/* Tear down any CGroups created by calls to tst_cgroup_require */
+void tst_cgroup_cleanup(void);
+
+#endif /* TST_CGROUP_CORE_H */
diff --git a/include/tst_cgroup_item.h b/include/tst_cgroup_item.h
new file mode 100644
index 000000000..476c06d86
--- /dev/null
+++ b/include/tst_cgroup_item.h
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+#ifndef TST_CGROUP_ITEM_H
+#define TST_CGROUP_ITEM_H
+
+/* CGroup Item Declarations */
+
+
+typedef const struct tst_cgroup_item *const *tst_cgroup_item_ptr;
+/* Base CGroup Item operations
+ *
+ * Note, for all callbacks, we pass a pointer to the item field within
+ * the containing object. Then use the container_of trick to get the
+ * specific tst_cgroup_* struct. This avoids passing a void pointer
+ * which has no type checking atall.
+ */
+struct tst_cgroup_item {
+	int (*exists)(const char *, const int, tst_cgroup_item_ptr);
+};
+
+struct tst_cgroup_file {
+	const struct tst_cgroup_item *item;
+
+	unsigned int n;
+	struct tst_cgroup_location locations[TST_CGROUP_MAX_TREES];
+};
+
+/* Generic Control Group (cgroup) parameters */
+struct tst_cgroup_cgroup {
+	const struct tst_cgroup_item *item;
+
+	/* tasks on V1, cgroup.procs on V2 */
+	struct tst_cgroup_file procs;
+	/* Only V1 */
+	struct tst_cgroup_file clone_children;
+	/* Only V2 */
+	struct tst_cgroup_file subtree_control;
+};
+
+/* On V1 this is memsw */
+struct tst_cgroup_memory_swap {
+	const struct tst_cgroup_item *item;
+
+	struct tst_cgroup_file current;
+	struct tst_cgroup_file max;
+};
+
+/* Only on V1 (but same info may be in memory.stat on V2) */
+struct tst_cgroup_memory_kmem {
+	const struct tst_cgroup_item *item;
+
+	struct tst_cgroup_file current;
+	struct tst_cgroup_file max;
+};
+
+/* memory (memcg) controller */
+struct tst_cgroup_memory {
+	const struct tst_cgroup_item *item;
+	enum tst_cgroup_ver ver;
+
+	struct tst_cgroup_memory_kmem kmem;
+	struct tst_cgroup_memory_swap swap;
+
+	/* usage_in_bytes on V1 */
+	struct tst_cgroup_file current;
+	/* limit_in_bytes on V1 */
+	struct tst_cgroup_file max;
+	/* Only on V1 as of 5.11 */
+	struct tst_cgroup_file swappiness;
+};
+
+/* cpuset controller */
+struct tst_cgroup_cpuset {
+	const struct tst_cgroup_item *item;
+	enum tst_cgroup_ver ver;
+
+	struct tst_cgroup_file cpus;
+	struct tst_cgroup_file mems;
+
+	struct tst_cgroup_file memory_migrate;
+};
+
+/* A Control Group in LTP's aggregated hierarchy */
+struct tst_cgroup {
+	const struct tst_cgroup_item *item;
+
+	unsigned int n;
+	struct tst_cgroup_tree *trees[TST_CGROUP_MAX_TREES];
+
+	struct tst_cgroup_cgroup cgroup;
+	struct tst_cgroup_cpuset cpuset;
+	struct tst_cgroup_memory memory;
+};
+
+/* Get the default CGroup for the test. It allocates memory (in a
+ * guarded buffer) so should always be called from setup
+ */
+const struct tst_cgroup *tst_cgroup_get_default(void);
+/* Get the shared drain group. Also should be called from setup */
+const struct tst_cgroup *tst_cgroup_get_drain(void);
+/* Create a descendant CGroup */
+struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
+				 const char *name);
+/* Remove a descendant CGroup */
+struct tst_cgroup *tst_cgroup_rm(struct tst_cgroup *cg);
+
+#define SAFE_CGROUP_READ(file, out, len) \
+	safe_cgroup_read(__FILE__, __LINE__, (file), (out), (len));
+
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+			 const struct tst_cgroup_file *cgf,
+			 char *out, size_t len);
+
+/* Print to a control file in the test's default CGroup */
+#define SAFE_CGROUP_PRINTF(file, fmt, ...) \
+	safe_cgroup_printf(__FILE__, __LINE__, (file), (fmt), __VA_ARGS__)
+
+#define SAFE_CGROUP_PRINT(file, str) \
+	safe_cgroup_printf(__FILE__, __LINE__, (file), "%s", (str))
+
+void safe_cgroup_printf(const char *file, const int lineno,
+			const struct tst_cgroup_file *cgf,
+			const char *fmt, ...)
+			__attribute__ ((format (printf, 4, 5)));
+
+#define SAFE_CGROUP_SCANF(file, fmt, ...)				\
+	safe_cgroup_scanf(__FILE__, __LINE__, (file), (fmt), __VA_ARGS__)
+
+void safe_cgroup_scanf(const char *file, const int lineno,
+		       const struct tst_cgroup_file *cgf,
+		       const char *fmt, ...)
+		       __attribute__ ((format (scanf, 4, 5)));
+
+#define TST_CGROUP_HAS(obj) \
+	(((obj)->item)->exists(__FILE__, __LINE__, &(obj)->item))
+
+#endif /* TST_CGROUP_ITEM_H */
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
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 96c9524d2..6fa725f37 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -2,453 +2,1073 @@
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
+
+struct cgroup_root;
+
+/* A node in a single CGroup hierarchy. It exists mainly for
+ * convenience so that we do not have to traverse the CGroup structure
+ * for frequent operations.
+ *
+ * This is actually a single-linked list not a tree. We only need to
+ * traverse from leaf towards root.
+ */
+struct tst_cgroup_tree {
+	/* The tree's name and parent */
+	struct tst_cgroup_location loc;
+	/* Shortcut to root */
+	const struct cgroup_root *root;
+
+	/* Subsystems (controllers) bit field. Only controllers which
+	 * were required and configured for this node are added to
+	 * this field. So it may be different from root->ss_field.
+	 */
+	uint32_t ss_field;
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
+	uint32_t ss_field;
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
+/* 'ss' stands for subsystem which is the same as 'controller' */
+struct cgroup_ss {
+	enum tst_cgroup_ctrl indx;
+	const char *name;
+	struct cgroup_root *tree;
+
+	int we_require_it:1;
+};
+
+/* Always use first item for unified hierarchy */
+struct cgroup_root roots[TST_CGROUP_MAX_TREES + 1];
 
-static int tst_cgroup_check(const char *cgroup)
+static struct cgroup_ss css[TST_CGROUP_MAX + 1] = {
+	{ TST_CGROUP_MEMORY, "memory", NULL, 0 },
+	{ TST_CGROUP_CPUSET, "cpuset", NULL, 0 },
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
+#define for_each_css(ss)			\
+	for ((ss) = css; (ss)->indx; (ss)++)
+
+static int has_css(uint32_t ss_field, enum tst_cgroup_ctrl type)
 {
-	char line[PATH_MAX];
-	FILE *file;
-	int cg_check = 0;
+	return !!(ss_field & (1 << type));
+}
 
-	file = SAFE_FOPEN("/proc/filesystems", "r");
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, cgroup) != NULL) {
-			cg_check = 1;
-			break;
-		}
+static void add_css(uint32_t *ss_field, int cond, enum tst_cgroup_ctrl type)
+{
+	*ss_field |= (!!cond) << type;
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
+static struct cgroup_ss *cgroup_get_ss(enum tst_cgroup_ctrl type)
+{
+	return &css[type - 1];
+}
+
+static int cgroup_ss_on_v2(const struct cgroup_ss *ss)
+{
+	return ss->tree->ver == TST_CGROUP_V2;
+}
+
+int tst_cgroup_tree_mk(const struct tst_cgroup_tree *parent,
+		       const char *name,
+		       struct tst_cgroup_tree *new)
+{
+	char *dpath;
+
+	new->root = parent->root;
+	new->loc.name = name;
+	new->loc.tree = parent;
+	new->ss_field = parent->ss_field;
+	new->we_created_it = 0;
+
+	if (!mkdirat(parent->dir, name, 0777)) {
+		new->we_created_it = 1;
+		goto opendir;
+	}
+
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
+	}
+
+	return -1;
+opendir:
+	new->dir = SAFE_OPENAT(parent->dir, name, O_PATH | O_DIRECTORY);
+
+	return 0;
+}
+
+void tst_cgroup_print_config(void)
+{
+	struct cgroup_root *t;
+	struct cgroup_ss *ss;
+
+	tst_res(TINFO, "Detected Controllers:");
+
+	for_each_css(ss) {
+		t = ss->tree;
+
+		if (!t)
+			continue;
+
+		tst_res(TINFO, "\t%.10s %s @ %s:%s",
+			ss->name,
+			t->no_prefix ? "[noprefix]" : "",
+			t->ver == TST_CGROUP_V1 ? "V1" : "V2",
+			t->path);
+	}
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
+	struct cgroup_ss *c;
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
+		for_each_css(c)
+			add_css(&ss_field, !strcmp(c->name, tok), c->indx);
+	}
+
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
+		for_each_css(c)
+			add_css(&ss_field, !strcmp(c->name, tok), c->indx);
+
+		no_prefix |= !strcmp("noprefix", tok);
+	}
+
+	if (!ss_field)
+		goto discard;
+
+	for_each_v1_root(t) {
+		if (!(ss_field & t->ss_field))
+			continue;
+
+		if (ss_field == t->ss_field)
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
+	t->mnt.loc.name = t->path;
+	t->mnt.dir = dfd;
+	t->ss_field = ss_field;
+	t->no_prefix = no_prefix;
+
+	for_each_css(c) {
+		if (has_css(t->ss_field, c->indx))
+			c->tree = t;
 	}
-	SAFE_FCLOSE(file);
 
-	return cg_check;
+	return;
+
+discard:
+	close(dfd);
 }
 
-enum tst_cgroup_ver tst_cgroup_version(void)
+void tst_cgroup_scan(void)
 {
-        enum tst_cgroup_ver cg_ver;
+	struct mntent *mnt;
+	FILE *f = setmntent("/proc/self/mounts", "r");
+
+	if (!f)
+		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
+
+	mnt = getmntent(f);
+	if (!mnt)
+		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
 
-        if (tst_cgroup_check("cgroup2")) {
-                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
-                        cg_ver = TST_CGROUP_V1;
-                else
-                        cg_ver = TST_CGROUP_V2;
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
 
-                goto out;
-        }
+	sprintf(path, "%s%s", ltp_mount_prefix, ltp_v2_mount);
 
-        if (tst_cgroup_check("cgroup"))
-                cg_ver = TST_CGROUP_V1;
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
+		return;
+	}
+
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
+mount:
+	if (!mount("cgroup2", path, "cgroup2", 0, NULL)) {
+		tst_res(TINFO, "Mounted V2 CGroups on %s", path);
+		tst_cgroup_scan();
+		roots[0].we_mounted_it = 1;
+		return;
+	}
 
-        if (!cg_ver)
-                tst_brk(TCONF, "Cgroup is not configured");
+	tst_res(TINFO | TERRNO, "Could not mount V2 CGroups on %s", path);
 
-out:
-        return cg_ver;
+	if (roots[0].mnt.we_created_it) {
+		roots[0].mnt.we_created_it = 0;
+		SAFE_RMDIR(path);
+	}
 }
 
-static void tst_cgroup1_mount(const char *name, const char *option,
-			const char *mnt_path, const char *new_path)
+static void cgroup_mount_v1(enum tst_cgroup_ctrl type)
 {
-	char knob_path[PATH_MAX];
-	if (tst_is_mounted(mnt_path))
-		goto out;
+	struct cgroup_ss *ss = cgroup_get_ss(type);
+	char path[PATH_MAX];
+	int made_dir = 0;
 
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount(name, mnt_path, "cgroup", 0, option) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
-			tst_brk(TCONF,
-				 "Cgroup v1 is not configured in kernel");
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
+	sprintf(path, "%s%s", ltp_mount_prefix, ss->name);
+
+	if (!mkdir(path, 0777)) {
+		made_dir = 1;
+		goto mount;
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
+		goto mount;
+
+	if (errno == EACCES) {
+		tst_res(TINFO | TERRNO,
+			"Lack permission to make %s, premake it or run as root",
+			path);
+		return;
 	}
-out:
-	SAFE_MKDIR(new_path, 0777);
 
-	tst_res(TINFO, "Cgroup(%s) v1 mount at %s success", option, mnt_path);
+	tst_brk(TBROK | TERRNO, "mkdir(%s, 0777)", path);
+
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
+	ss->tree->mnt.we_created_it = made_dir;
+
+	if (type == TST_CGROUP_MEMORY) {
+		SAFE_FILE_PRINTFAT(ss->tree->mnt.dir,
+				   "memory.use_hierarchy", "%d", 1);
+	}
+}
+
+static void cgroup_copy_cpuset(const struct cgroup_root *t)
+{
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
 }
 
-static void tst_cgroup2_mount(const char *mnt_path, const char *new_path)
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
+void tst_cgroup_require(enum tst_cgroup_ctrl type,
+			const struct tst_cgroup_opts *options)
 {
-	if (tst_is_mounted(mnt_path))
-		goto out;
+	const char *const cgsc = "cgroup.subtree_control";
+	struct cgroup_ss *ss = cgroup_get_ss(type);
+	struct cgroup_root *t;
+	char buf[BUFSIZ];
+
+	if (!options)
+		options = &default_opts;
+
+	if (ss->we_require_it)
+		tst_res(TWARN, "Duplicate tst_cgroup_require(%s, )", ss->name);
+	ss->we_require_it = 1;
+
+	if (ss->tree)
+		goto ltpdir;
+
+	tst_cgroup_scan();
+
+	if (ss->tree)
+		goto ltpdir;
+
+	if (!cgroup_v2_mounted() && !options->only_mount_v1)
+		cgroup_mount_v2();
 
-	SAFE_MKDIR(mnt_path, 0777);
-	if (mount("cgroup2", mnt_path, "cgroup2", 0, NULL) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(mnt_path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed", mnt_path);
+	if (ss->tree)
+		goto ltpdir;
+
+	cgroup_mount_v1(type);
+
+	if (!ss->tree) {
+		tst_brk(TCONF,
+			"'%s' controller required, but not available", ss->name);
+	}
+
+ltpdir:
+	t = ss->tree;
+	add_css(&t->mnt.ss_field, 1, type);
+
+	if (cgroup_ss_on_v2(ss) && t->we_mounted_it) {
+		SAFE_FILE_PRINTFAT(t->mnt.dir, cgsc, "+%s", ss->name);
+	} else if (cgroup_ss_on_v2(ss)) {
+		SAFE_FILE_READAT(t->mnt.dir, cgsc, buf, sizeof(buf));
+		if (!strstr(buf, ss->name)) {
 			tst_brk(TCONF,
-				 "Cgroup v2 is not configured in kernel");
+				"'%s' controller required, but not in %s/%s",
+				ss->name, t->path, cgsc);
 		}
-		tst_brk(TBROK | TERRNO, "mount %s", mnt_path);
 	}
 
-out:
-	SAFE_MKDIR(new_path, 0777);
+	if (!t->ltp.dir)
+		tst_cgroup_tree_mk(&t->mnt, ltp_cgroup_dir, &t->ltp);
+	else
+		t->ltp.ss_field |= t->mnt.ss_field;
+
+	if (!t->ltp.we_created_it)
+		goto testdir;
+
+	if (cgroup_ss_on_v2(ss)) {
+		SAFE_FILE_PRINTFAT(t->ltp.dir, cgsc, "+%s", ss->name);
+	} else {
+		SAFE_FILE_PRINTFAT(t->ltp.dir, "cgroup.clone_children",
+				   "%d", 1);
+
+		if (type == TST_CGROUP_CPUSET)
+			cgroup_copy_cpuset(t);
+	}
+
+testdir:
+	tst_cgroup_tree_mk(&t->ltp, ltp_cgroup_drain_dir, &t->drain);
 
-	tst_res(TINFO, "Cgroup v2 mount at %s success", mnt_path);
+	sprintf(test_cgroup_dir, "test-%d", getpid());
+	tst_cgroup_tree_mk(&t->ltp, test_cgroup_dir, &t->test);
 }
 
-static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
+static void cgroup_drain(enum tst_cgroup_ver ver, int source, int dest)
 {
-	FILE *fp;
+	char buf[BUFSIZ];
+	char *tok;
+	const char *fname = ver == TST_CGROUP_V1 ? "tasks" : "cgroup.procs";
 	int fd;
-	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
-	char knob_path[PATH_MAX];
+	ssize_t ret;
 
-	if (!tst_is_mounted(mnt_path))
+	ret = SAFE_FILE_READAT(source, fname, buf, sizeof(buf));
+	if (ret < 0)
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
+	fd = SAFE_OPENAT(dest, fname, O_WRONLY);
+	if (fd < 0)
+		return;
+
+	for (tok = strtok(buf, "\n"); tok; tok = strtok(NULL, "\n")) {
+		ret = dprintf(fd, "%s", tok);
+
+		if (ret < (ssize_t)strlen(tok))
+			tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
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
+	SAFE_CLOSE(fd);
+}
 
-static struct tst_cgroup_path *tst_cgroup_paths;
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
+}
 
-static void tst_cgroup_set_path(const char *cgroup_dir)
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
-	char cgroup_new_dir[PATH_MAX];
-	struct tst_cgroup_path *tst_cgroup_path, *a;
+	struct cgroup_root *t;
+	struct cgroup_ss *ss;
 
-	if (!cgroup_dir)
-		tst_brk(TBROK, "Invalid cgroup dir, plese check cgroup_dir");
+	if (!cgroup_mounted())
+		goto clear_data;
 
-	sprintf(cgroup_new_dir, "%s/ltp_%d", cgroup_dir, rand());
+	for_each_root(t) {
+		if (!t->test.loc.name)
+			continue;
 
-	/* To store cgroup path in the 'path' list */
-	tst_cgroup_path = SAFE_MALLOC(sizeof(struct tst_cgroup_path));
-	tst_cgroup_path->mnt_path = SAFE_MALLOC(strlen(cgroup_dir) + 1);
-	tst_cgroup_path->new_path = SAFE_MALLOC(strlen(cgroup_new_dir) + 1);
-	tst_cgroup_path->next = NULL;
+		cgroup_drain(t->ver, t->test.dir, t->drain.dir);
+		SAFE_UNLINKAT(t->ltp.dir, t->test.loc.name, AT_REMOVEDIR);
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
+	for_each_root(t) {
+		if (!t->ltp.we_created_it)
+			continue;
+
+		cgroup_drain(t->ver, t->drain.dir, t->mnt.dir);
+
+		if (t->drain.loc.name)
+			SAFE_UNLINKAT(t->ltp.dir, t->drain.loc.name, AT_REMOVEDIR);
+
+		if (t->ltp.loc.name)
+			SAFE_UNLINKAT(t->mnt.dir, t->ltp.loc.name, AT_REMOVEDIR);
 	}
 
-	sprintf(tst_cgroup_path->mnt_path, "%s", cgroup_dir);
-	sprintf(tst_cgroup_path->new_path, "%s", cgroup_new_dir);
+	for_each_css(ss) {
+		if (!cgroup_ss_on_v2(ss) || !ss->tree->we_mounted_it)
+			continue;
+
+		SAFE_FILE_PRINTFAT(ss->tree->mnt.dir, "cgroup.subtree_control",
+				   "-%s", ss->name);
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
+	memset(css, 0, sizeof(css));
+
+	for_each_root(t)
+		close_path_fds(t);
+
+	memset(roots, 0, sizeof(roots));
 }
 
-static char *tst_cgroup_get_path(const char *cgroup_dir)
+/* CGroup Item Implementation */
+
+static int cgroup_default_exists(const char * file, const int lineno,
+				 tst_cgroup_item_ptr item LTP_ATTRIBUTE_UNUSED)
 {
-	struct tst_cgroup_path *a;
+	tst_brk_(file, lineno, TBROK, "Exists method not implemented for item");
+
+	return 0;
+}
 
-	if (!tst_cgroup_paths)
-		return NULL;
+static const struct tst_cgroup_item cgroup_default_item = {
+	.exists = cgroup_default_exists,
+};
 
-	a = tst_cgroup_paths;
+static int cgroup_ent_exists(const char * file, const int lineno,
+			     const struct tst_cgroup_location *loc)
+{
+	int dirfd, ret;
 
-	while (strcmp(a->mnt_path, cgroup_dir) != 0){
-		if (!a->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return NULL;
-		}
-		a = a->next;
-	};
+	if (!loc->tree)
+		return 0;
 
-	return a->new_path;
+	dirfd = loc->tree->dir;
+	ret = faccessat(dirfd, loc->name, F_OK, 0);
+
+	if (!ret)
+		return 1;
+
+	if (errno == ENOENT)
+		return 0;
+
+	tst_brk_(file, lineno, TBROK | TERRNO,
+		 "faccessat(%d<%s>, %s, F_OK, 0)",
+		 dirfd, tst_decode_fd(dirfd), loc->name);
+
+	return 0;
 }
 
-static void tst_cgroup_del_path(const char *cgroup_dir)
+static int cgroup_file_exists(const char * file, const int lineno,
+			      tst_cgroup_item_ptr item)
 {
-	struct tst_cgroup_path *a, *b;
+	const struct tst_cgroup_file *cgf =
+		tst_container_of(item, typeof(*cgf), item);
+	unsigned int i, n = cgf->n;
+	const struct tst_cgroup_location *loc = cgf->locations;
 
-	if (!tst_cgroup_paths)
-		return;
+	for (i = 0; i < n; i++) {
+		if (cgroup_ent_exists(file, lineno, loc + i))
+			return 1;
+	}
 
-	a = b = tst_cgroup_paths;
+	return 0;
+}
 
-	while (strcmp(b->mnt_path, cgroup_dir) != 0) {
-		if (!b->next) {
-			tst_res(TINFO, "%s is not found", cgroup_dir);
-			return;
-		}
-		a = b;
-		b = b->next;
-	};
+static const struct tst_cgroup_item cgroup_file_item = {
+	.exists = cgroup_file_exists,
+};
 
-	if (b == tst_cgroup_paths)
-		tst_cgroup_paths = b->next;
-	else
-		a->next = b->next;
+static void cgroup_file_init(struct tst_cgroup_file *file)
+{
+	file->item = &cgroup_file_item;
+	file->n = 0;
+}
+
+static void cgroup_file_add(struct tst_cgroup_file *file,
+			    const char *name,
+			    const struct tst_cgroup_tree *tree)
+{
+	file->locations[file->n].name = name;
+	file->locations[file->n].tree = tree;
+	file->n++;
+}
+
+static int cgroup_memory_swap_exists(const char * file, const int lineno,
+				     tst_cgroup_item_ptr item)
+{
+	const struct tst_cgroup_memory_swap *c =
+		tst_container_of(item, typeof(*c), item);
 
-	free(b->mnt_path);
-	free(b->new_path);
-	free(b);
+	return cgroup_file_exists(file, lineno, &c->max.item);
 }
 
-void tst_cgroup_mount(enum tst_cgroup_ctrl ctrl, const char *cgroup_dir)
+static const struct tst_cgroup_item cgroup_memory_swap_item = {
+	.exists = cgroup_memory_swap_exists,
+};
+
+static int cgroup_memory_kmem_exists(const char * file, const int lineno,
+				     tst_cgroup_item_ptr item)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	const struct tst_cgroup_memory_kmem *c =
+		tst_container_of(item, typeof(*c), item);
 
-	tst_cg_ver = tst_cgroup_version();
+	return cgroup_file_exists(file, lineno, &c->max.item);
+}
 
-	tst_cgroup_set_path(cgroup_dir);
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+static const struct tst_cgroup_item cgroup_memory_kmem_item = {
+	.exists = cgroup_memory_kmem_exists,
+};
 
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
+static int cgroup_memory_exists(const char * file, const int lineno,
+				tst_cgroup_item_ptr item)
+{
+	const struct tst_cgroup_memory *c =
+		tst_container_of(item, typeof(*c), item);
+
+	return cgroup_file_exists(file, lineno, &c->max.item);
+}
+
+static struct tst_cgroup_item cgroup_memory_item = {
+	.exists = cgroup_memory_exists,
+};
+
+static void cgroup_memory_init(struct tst_cgroup_memory *cgm)
+{
+	cgm->item = &cgroup_memory_item;
+	cgm->ver = 0;
+	cgroup_file_init(&cgm->current);
+	cgroup_file_init(&cgm->max);
+	cgroup_file_init(&cgm->swappiness);
+
+	cgm->swap.item = &cgroup_memory_swap_item;
+	cgroup_file_init(&cgm->swap.current);
+	cgroup_file_init(&cgm->swap.max);
+
+	cgm->kmem.item = &cgroup_memory_kmem_item;
+	cgroup_file_init(&cgm->kmem.current);
+	cgroup_file_init(&cgm->kmem.max);
+}
+
+static void cgroup_memory_add(struct tst_cgroup_memory *cgm,
+			      const struct tst_cgroup_tree *tree)
+{
+	const char *current, *max, *swap_current, *swap_max;
+
+	cgm->ver = tree->root->ver;
+
+	cgroup_file_add(&cgm->kmem.current, "memory.kmem.usage_in_bytes", tree);
+	cgroup_file_add(&cgm->kmem.max, "memory.kmem.limit_in_bytes", tree);
+
+	if (tree->root->ver == TST_CGROUP_V1) {
+		current = "memory.usage_in_bytes";
+		max = "memory.limit_in_bytes";
+		swap_current = "memory.memsw.usage_in_bytes";
+		swap_max = "memory.memsw.limit_in_bytes";
+	} else {
+		current = "memory.current";
+		max = "memory.max";
+		swap_current = "memory.swap.current";
+		swap_max = "memory.swap.max";
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		tst_cgroup2_mount(cgroup_dir, cgroup_new_dir);
+	cgroup_file_add(&cgm->current, current, tree);
+	cgroup_file_add(&cgm->max, max, tree);
+	cgroup_file_add(&cgm->swappiness, "memory.swappiness", tree);
 
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
+	cgroup_file_add(&cgm->swap.current, swap_current, tree);
+	cgroup_file_add(&cgm->swap.max, swap_max, tree);
+}
+
+static int cgroup_cpuset_exists(const char * file, const int lineno,
+				tst_cgroup_item_ptr item)
+{
+	const struct tst_cgroup_cpuset *c =
+		tst_container_of(item, typeof(*c), item);
+
+	return cgroup_file_exists(file, lineno, &c->cpus.item);
+}
+
+static struct tst_cgroup_item cgroup_cpuset_item = {
+	.exists = cgroup_cpuset_exists,
+};
+
+static void cgroup_cpuset_init(struct tst_cgroup_cpuset *cgc)
+{
+	cgc->item = &cgroup_cpuset_item;
+	cgc->ver = 0;
+
+	cgroup_file_init(&cgc->cpus);
+	cgroup_file_init(&cgc->mems);
+
+	cgroup_file_init(&cgc->memory_migrate);
+}
+
+static void cgroup_cpuset_add(struct tst_cgroup_cpuset *cgc,
+			      const struct tst_cgroup_tree *tree)
+{
+	const char *cpus, *mems, *memory_migrate;
+
+	cgc->ver = tree->root->ver;
+
+	if (tree->root->no_prefix) {
+		cpus = "cpus";
+		mems = "mems";
+		memory_migrate = "memory_migrate";
+	} else {
+		cpus = "cpuset.cpus";
+		mems = "cpuset.mems";
+		memory_migrate = "cpuset.memory_migrate";
 	}
+
+	cgroup_file_add(&cgc->cpus, cpus, tree);
+	cgroup_file_add(&cgc->mems, mems, tree);
+	cgroup_file_add(&cgc->memory_migrate, memory_migrate, tree);
 }
 
-void tst_cgroup_umount(const char *cgroup_dir)
+static void cgroup_cgroup_init(struct tst_cgroup_cgroup *cgg)
 {
-	char *cgroup_new_dir;
+	cgg->item = &cgroup_default_item;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	tst_cgroupN_umount(cgroup_dir, cgroup_new_dir);
-	tst_cgroup_del_path(cgroup_dir);
+	cgroup_file_init(&cgg->procs);
+	cgroup_file_init(&cgg->clone_children);
+	cgroup_file_init(&cgg->subtree_control);
 }
 
-void tst_cgroup_set_knob(const char *cgroup_dir, const char *knob, long value)
+static void cgroup_cgroup_add(struct tst_cgroup_cgroup *cgg,
+			      const struct tst_cgroup_tree *tree)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	if (tree->root->ver == TST_CGROUP_V1) {
+		cgroup_file_add(&cgg->procs, "tasks", tree);
+		cgroup_file_add(&cgg->clone_children, "clone_children", tree);
+		return;
+	}
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
-	sprintf(knob_path, "%s/%s", cgroup_new_dir, knob);
-	SAFE_FILE_PRINTF(knob_path, "%ld", value);
+	cgroup_file_add(&cgg->procs, "cgroup.procs", tree);
+	cgroup_file_add(&cgg->subtree_control, "cgroup.subtree_control", tree);
 }
 
-void tst_cgroup_move_current(const char *cgroup_dir)
+static void cgroup_init(struct tst_cgroup *cg)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "tasks", getpid());
+	cg->item = &cgroup_default_item;
+	cg->n = 0;
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "cgroup.procs", getpid());
+	cgroup_cgroup_init(&cg->cgroup);
+	cgroup_cpuset_init(&cg->cpuset);
+	cgroup_memory_init(&cg->memory);
 }
 
-void tst_cgroup_mem_set_maxbytes(const char *cgroup_dir, long memsz)
+static void cgroup_add(struct tst_cgroup *cg, struct tst_cgroup_tree *tree)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.limit_in_bytes", memsz);
+	uint32_t ss_field = tree->ss_field;
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.max", memsz);
+	cg->trees[cg->n++] = tree;
+	cgroup_cgroup_add(&cg->cgroup, tree);
+
+	if (has_css(ss_field, TST_CGROUP_MEMORY))
+		cgroup_memory_add(&cg->memory, tree);
+
+	if (has_css(ss_field, TST_CGROUP_CPUSET))
+		cgroup_cpuset_add(&cg->cpuset, tree);
 }
 
-int tst_cgroup_mem_swapacct_enabled(const char *cgroup_dir)
+struct tst_cgroup *tst_cgroup_mk(const struct tst_cgroup *parent,
+				 const char *name)
 {
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	unsigned int i;
+	struct tst_cgroup *cg;
+	struct tst_cgroup_tree *tree;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	if (!parent->n)
+		tst_brk(TBROK, "Trying to make CGroup in empty parent");
 
-	if (tst_cg_ver & TST_CGROUP_V1) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.memsw.limit_in_bytes");
+	cg = SAFE_MALLOC(sizeof(*cg));
+	cgroup_init(cg);
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+	for (i = 0; i < parent->n; i++) {
+		tree = SAFE_MALLOC(sizeof(*tree));
+		tst_cgroup_tree_mk(parent->trees[i], name, tree);
+		cgroup_add(cg, tree);
 	}
 
-	if (tst_cg_ver & TST_CGROUP_V2) {
-		sprintf(knob_path, "%s/%s",
-				cgroup_new_dir, "/memory.swap.max");
+	return cg;
+}
 
-		if ((access(knob_path, F_OK) == -1)) {
-			if (errno == ENOENT)
-				tst_res(TCONF, "memcg swap accounting is disabled");
-			else
-				tst_brk(TBROK | TERRNO, "failed to access %s", knob_path);
-		} else {
-			return 1;
-		}
+struct tst_cgroup *tst_cgroup_rm(struct tst_cgroup *cg)
+{
+	unsigned int i;
+
+	for (i = 0; i < cg->n; i++) {
+		close(cg->trees[i]->dir);
+		SAFE_UNLINKAT(cg->trees[i]->loc.tree->dir,
+			      cg->trees[i]->loc.name,
+			      AT_REMOVEDIR);
+		free(cg->trees[i]);
 	}
 
-	return 0;
+	free(cg);
+	return NULL;
 }
 
-void tst_cgroup_mem_set_maxswap(const char *cgroup_dir, long memsz)
+static struct tst_cgroup *cgroup_from_roots(size_t tree_off)
 {
-	if (tst_cg_ver & TST_CGROUP_V1)
-		tst_cgroup_set_knob(cgroup_dir, "memory.memsw.limit_in_bytes", memsz);
+	struct cgroup_root *r;
+	struct tst_cgroup_tree *t;
+	struct tst_cgroup *cg;
+
+	cg = tst_alloc(sizeof(*cg));
+	cgroup_init(cg);
+
+	for_each_root(r) {
+		t = (typeof(t))(((char *)r) + tree_off);
+
+		if (t->ss_field)
+			cgroup_add(cg, t);
+	}
 
-	if (tst_cg_ver & TST_CGROUP_V2)
-		tst_cgroup_set_knob(cgroup_dir, "memory.swap.max", memsz);
+	if (cg->n)
+		return cg;
+
+	tst_brk(TBROK,
+		"No CGroups found; maybe you forgot to call tst_cgroup_require?");
+
+	return cg;
 }
 
-void tst_cgroup_cpuset_read_files(const char *cgroup_dir, const char *filename,
-	char *retbuf, size_t retbuf_sz)
+const struct tst_cgroup *tst_cgroup_get_default(void)
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
-	fd = open(knob_path, O_RDONLY);
-	if (fd == -1) {
-		if (errno == ENOENT) {
-			sprintf(knob_path, "%s/cpuset.%s",
-					cgroup_new_dir, filename);
-			fd = SAFE_OPEN(knob_path, O_RDONLY);
-		} else
-			tst_brk(TBROK | TERRNO, "open %s", knob_path);
+static void cgroup_file_populated(const char *file, const int lineno,
+				  const struct tst_cgroup_file *cgf)
+{
+	if (cgf->n)
+		return;
+
+	tst_brk_(file, lineno, TBROK,
+		 "CGroup item not populated. Maybe missing tst_cgroup_require() or TST_CGROUP_HAS()");
+}
+
+ssize_t safe_cgroup_read(const char *file, const int lineno,
+			 const struct tst_cgroup_file *cgf,
+			 char *out, size_t len)
+{
+	unsigned int i;
+	size_t min_len;
+	const struct tst_cgroup_location *loc = cgf->locations;
+	char buf[BUFSIZ];
+
+	cgroup_file_populated(file, lineno, cgf);
+
+	for (i = 0; i < cgf->n; i++) {
+		TEST(safe_file_readat(file, lineno,
+				      loc[i].tree->dir, loc[i].name, out, len));
+		if (TST_RET < 0)
+			continue;
+
+		min_len = MIN(sizeof(buf), (size_t)TST_RET);
+
+		if (i > 0 && memcmp(out, buf, min_len)) {
+			tst_brk_(file, lineno, TBROK,
+				 "%s has different value across roots",
+				 loc[i].name);
+			break;
+		}
+
+		if (i >= cgf->n)
+			break;
+
+		memcpy(buf, out, min_len);
 	}
 
-	memset(retbuf, 0, retbuf_sz);
-	if (read(fd, retbuf, retbuf_sz) < 0)
-		tst_brk(TBROK | TERRNO, "read %s", knob_path);
+	out[MAX(TST_RET, 0)] = '\0';
 
-	close(fd);
+	return TST_RET;
 }
 
-void tst_cgroup_cpuset_write_files(const char *cgroup_dir, const char *filename, const char *buf)
+void safe_cgroup_printf(const char *file, const int lineno,
+			const struct tst_cgroup_file *cgf,
+			const char *fmt, ...)
 {
-	int fd;
-	char *cgroup_new_dir;
-	char knob_path[PATH_MAX];
+	unsigned int i;
+	const struct tst_cgroup_location *loc = cgf->locations;
+	va_list va;
 
-	cgroup_new_dir = tst_cgroup_get_path(cgroup_dir);
+	cgroup_file_populated(file, lineno, cgf);
 
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
+	for (i = 0; i < cgf->n; i++) {
+		va_start(va, fmt);
+		safe_file_vprintfat(file, lineno,
+				    loc[i].tree->dir, loc[i].name, fmt, va);
+		va_end(va);
 	}
+}
 
-	SAFE_WRITE(1, fd, buf, strlen(buf));
+void safe_cgroup_scanf(const char *file, const int lineno,
+		       const struct tst_cgroup_file *cgf,
+		       const char *fmt, ...)
+{
+	va_list va;
+	char buf[BUFSIZ];
+	const struct tst_cgroup_location *loc;
+	ssize_t len = safe_cgroup_read(file, lineno, cgf, buf, sizeof(buf));
+
+	if (len < 1)
+		return;
 
-	close(fd);
+	va_start(va, fmt);
+	if (vsscanf(buf, fmt, va) < 1) {
+		loc = cgf->locations;
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "'%s/%s': vsscanf('%s', '%s', ...)",
+			 tst_decode_fd(loc->tree->dir), loc->name, buf, fmt);
+	}
+	va_end(va);
 }
-- 
2.30.0

