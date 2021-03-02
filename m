From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  2 Mar 2021 15:25:08 +0000
Subject: [LTP] [RFC PATCH v2 5/7] docs: Update CGroups API
In-Reply-To: <20210302152510.15116-1-rpalethorpe@suse.com>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
Message-ID: <20210302152510.15116-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/test-writing-guidelines.txt | 165 ++++++++++++++++++++++++++++++--
 1 file changed, 156 insertions(+), 9 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index dd1911ceb..7978c3904 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2165,48 +2165,195 @@ the field value of file.
 
 2.2.36 Using Control Group
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
-Some of LTP tests need Control Group in their configuration, tst_cgroup.h provides
-APIs to make cgroup unified mounting at setup phase to be possible. The method?is
+
+Some of LTP tests need Control Groups in their configurations, tst_cgroup.h provides
+APIs to discover and use CGroups. The method?is
 extracted from mem.h with the purpose of?extendible for further developing, and
 trying to compatible the current two versions of cgroup.
 
-Considering there are many differences between cgroup v1 and v2, here we capsulate
+Considering there are many differences between cgroup v1 and v2, here we encapsulate
 the detail of cgroup mounting in high-level functions, which will be easier to use
-cgroup without caring about too much technical thing.? ?
+cgroup without caring about too much technical thing.
 
 Also, we do cgroup mount/umount work for the different hierarchy automatically.
+If that is required.
 
 [source,c]
 -------------------------------------------------------------------------------
 #include "tst_test.h"
+#include "tst_cgroup.h"
+
+static const struct tst_cgroup *cg;
 
 static void run(void)
 {
 	...
+	// do test under cgroup
+	...
+}
+
+static void setup(void)
+{
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
+	cg = tst_cgroup_get_default();
+	SAFE_CGROUP_PRINTF(&cg->cgroup.procs, "%d", getpid());
+	SAFE_CGROUP_PRINTF(&cg->memory.max, "%lu", MEMSIZE);
+	if (TST_CGROUP_HAS(&cg->memory.swap))
+		SAFE_CGROUP_PRINTF(&cg->memory.swap.max, "%zu", memsw);
+}
 
-	tst_cgroup_move_current(PATH_TMP_CG_MEM);
-	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
+static void cleanup(void)
+{
+	tst_cgroup_cleanup();
+}
 
-	// do test under cgroup
+struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
 	...
+};
+-------------------------------------------------------------------------------
+
+Above, we first ensure the memory controller is available on the
+test's CGroup with 'tst_cgroup_require'. We then get a structure,
+'cg', which represents the test's CGroup. Note that
+'tst_cgroup_get_default' should not be called many times, as it is
+allocated in a guarded buffer (See section 2.2.31). Therefor it is
+best to call it once in 'setup' and not 'run' because 'run' may be
+repeated with the '-i' option.
+
+We then write the current processes PID into 'cgroup.procs', which
+moves the current process into the test's CGroup. After which we set
+the maximum memory size by writing to 'memory.max'. If the memory
+controller is mounted on CGroups V1 then the library will actually
+write to 'memory.limit_in_bytes'. As a general rule, if a file exists
+on both CGroup versions, then we use the V2 naming.
+
+Some controller features, such as 'memory.swap', can be
+disabled. Therefor we need to check if they exist before accessing
+them. This can be done with 'TST_CGROUP_HAS' which can be called on
+any control file or feature.
+
+Most tests only require setting a few limits similar to the above. In
+such cases the differences between V1 and V2 are hidden. Setup and
+cleanup is also mostly hidden. However things can get much worse.
+
+[source,c]
+-------------------------------------------------------------------------------
+static const struct tst_cgroup *cg;
+static const struct tst_cgroup *cg_drain;
+static struct tst_cgroup *cg_child;
+
+static void run(void)
+{
+	char buf[BUFSIZ];
+	size_t mem = 0;
+
+	cg_child = tst_cgroup_mk(cg, "child");
+	SAFE_CGROUP_PRINTF(&cg_child->cgroup.procs, "%d", getpid());
+
+	if (cg->memory.ver != TST_CGROUP_V1)
+		SAFE_CGROUP_PRINT(&cg->cgroup.subtree_control, "+memory");
+	if (cg->cpuset.ver != TST_CGROUP_V1)
+		SAFE_CGROUP_PRINT(&cg->cgroup.subtree_control, "+cpuset");
+
+	if (!SAFE_FORK()) {
+		SAFE_CGROUP_PRINTF(&cg_child->cgroup.procs, "%d", getpid());
+
+		if (TST_CGROUP_HAS(&cg_child->memory.swap))
+			SAFE_CGROUP_SCANF(&cg_child->memory.swap.current, "%zu", &mem);
+		SAFE_CGROUP_READ(&cg_child->cpuset.mems, buf, sizeof(buf));
+
+		// Do something with cpuset.mems and memory.current values
+		...
+
+		exit(0);
+	}
+
+	tst_reap_children();
+	SAFE_CGROUP_PRINTF(&cg_drain->cgroup.procs, "%d", getpid());
+	cg_child = tst_cgroup_rm(cg_child);
 }
 
 static void setup(void)
 {
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
+	tst_cgroup_require(TST_CGROUP_CPUSET, NULL);
+
+	cg = tst_cgroup_get_default();
+	cg_drain = tst_cgroup_get_drain();
 }
 
 static void cleanup(void)
 {
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	if (cg_child) {
+		SAFE_CGROUP_PRINTF(&cg_drain->cgroup.procs, "%d", getpid());
+		cg_child = tst_cgroup_rm(cg_child);
+	}
+
+	tst_cgroup_cleanup();
 }
 
 struct tst_test test = {
+	.setup = setup,
 	.test_all = run,
+	.cleanup = cleanup,
 	...
 };
 -------------------------------------------------------------------------------
 
+Starting with setup; we can see here that we also fetch the 'drain'
+CGroup. This is a shared group (between parallel tests) which may
+contain processe from other tests. It should have default settings and
+these should not be changed by the test. It can be used to remove
+processes from other CGroups incase the hierarchy root is not
+accessible.
+
+In 'run', we first create a child CGroup with 'tst_cgroup_mk'. As we
+create this CGroup in 'run' we should also remove it at the end of
+run. We also need to check if it exists and remove it in cleanup as
+well. Because there are 'SAFE_' functions which may jump to cleanup.
+
+We then move the main test process into the child CGroup. This is
+important as it means that before we destroy the child CGroup we have
+to move the main test process elsewhere. For that we use the 'drain'
+group.
+
+Next we enable the memory and cpuset controller configuration on the
+test CGroup's descendants (i.e. 'cg_child'). This allows each child to
+have its own settings. The file 'cgroup.subtree_control' does not
+exist on V1. Because it is possible to have both V1 and V2 active at
+the same time. We can not simply check if 'subtree_control' exists
+before writing to it. We have to check if a particular controller is
+on V2 before trying to add it to 'subtree_control'. Trying to add a V1
+controller will result in 'ENOENT'.
+
+We then fork a child process and add this to the child CGroup. Within
+the child process we try to read 'memory.swap.current'. It is possible
+that the memory controller was compiled without swap support, so it is
+necessary to check if 'memory.swap' is enabled. That is unless the
+test will never reach the point where 'memory.swap.*' are used without
+swap support.
+
+The parent process waits for the child process to be reaped before
+destroying the child CGroup. So there is no need to transfer the child
+to drain. However the parent process must be moved otherwise we will
+get 'EBUSY' when trying to remove the child CGroup.
+
+Another example of an edge case is the following.
+
+[source,c]
+-------------------------------------------------------------------------------
+	if (cg->memory.ver == TST_CGROUP_V1)
+		SAFE_CGROUP_PRINTF(&cg->memory.swap.max, "%lu", ~0UL);
+	else
+		SAFE_CGROUP_PRINT(&cg->memory.swap.max, "max");
+-------------------------------------------------------------------------------
+
+CGroups V2 introduced a feature where 'memory[.swap].max' could be set
+to "max". This does not appear to work on V1 however.
+
 2.2.37 Require minimum numbers of CPU for a testcase
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.30.0

