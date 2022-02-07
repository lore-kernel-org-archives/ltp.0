Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBDCC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:17:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 290633C9B28
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 15:17:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC8CE3C9B18
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 616121400B89
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:36 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A94851F386;
 Mon,  7 Feb 2022 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644243395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPoTa0NUBFn4H/Yq8yKgYxfRX59YcjJMtp/Gzf/3KAw=;
 b=SH/wDwSRPo2rugDfn8pAYxzMFmPfgeBlfOGhWIqrfUE9h8jMzsvCZKNgp2sfeCi6OI+sfL
 Apo3j57pTqvTQIu/Uk3tXzGEuQtkIMZ9OLb7y4xOLjdpvjC0lH7uk1ZWQhOxSxHlDaIGVt
 M2dwTNj90arSm4xsqlk+NxlwUNe+Y1U=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 71517A3B94;
 Mon,  7 Feb 2022 14:16:33 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  7 Feb 2022 14:16:15 +0000
Message-Id: <20220207141618.2844-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207141618.2844-1-rpalethorpe@suse.com>
References: <20220207141618.2844-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/5] API/cgroup: Declare required controllers and
 version in test struct
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This allows the test author to declaratively specify the required
CGroup controllers in struct tst_test. Also they can optionally
specify the CGroup API version. In some cases this removes any need for a
setup function. It also adds CGroup information to the meta-data.

In theory its possible to require that only one controller is on a
particular version while others are free to be on any. Currently this
would still need to be handled by calling tst_cgroup_require() and
checking the controller version. So far we do not have any tests which
need to be run in such a hybrid scenario. Usually if V2 and V1 are
mounted at once, V2 is empty. So this does not complicate the
declaration by allowing the version to be specified on a per
controller basis.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/c-test-api.txt                            | 102 ++++++++----------
 include/tst_cgroup.h                          |  29 ++---
 include/tst_test.h                            |   7 ++
 lib/newlib_tests/tst_cgroup01.c               |   3 +-
 lib/newlib_tests/tst_cgroup02.c               |  27 +++--
 lib/tst_cgroup.c                              |  59 +++++-----
 lib/tst_test.c                                |  21 ++++
 .../kernel/controllers/memcg/memcontrol01.c   |  20 +---
 .../kernel/controllers/memcg/memcontrol02.c   |  13 +--
 .../controllers/memcg/memcontrol_common.h     |   1 -
 testcases/kernel/mem/cpuset/cpuset01.c        |  25 ++---
 testcases/kernel/mem/include/mem.h            |   1 -
 testcases/kernel/mem/ksm/ksm02.c              |  19 ++--
 testcases/kernel/mem/ksm/ksm03.c              |  13 +--
 testcases/kernel/mem/ksm/ksm04.c              |  16 ++-
 testcases/kernel/mem/oom/oom03.c              |  24 ++---
 testcases/kernel/mem/oom/oom04.c              |  15 +--
 testcases/kernel/mem/oom/oom05.c              |  34 +++---
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |  11 +-
 testcases/kernel/syscalls/madvise/madvise06.c |  29 ++---
 20 files changed, 209 insertions(+), 260 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 6f4de3f80..9b516bb38 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2056,11 +2056,13 @@ the field value of file.
 1.36 Using Control Group
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Some LTP tests need specific Control Group configurations. tst_cgroup.h provides
-APIs to discover and use CGroups. There are many differences between CGroups API
-V1 and V2. We encapsulate the details of configuring CGroups in high-level
-functions which follow the V2 kernel API. Allowing one to use CGroups without
-caring too much about the current system's configuration.
+Some LTP tests need specific Control Group configurations.  'tst_cgroup.h'
+provides APIs to discover and use CGroups. There are many differences between
+CGroups API V1 and V2. We encapsulate the details of configuring CGroups in
+high-level functions which follow the V2 kernel API where possible. Allowing one
+to write code that works on both V1 or V2. At least some of the time anyway;
+often the behavioural differences between V1 and V2 are too great. In such cases
+we revert to branching on the CGroup version.
 
 Also, the LTP library will automatically mount/umount and configure the CGroup
 hierarchies if that is required (e.g. if you run the tests from init with no
@@ -2069,9 +2071,6 @@ system manager).
 [source,c]
 -------------------------------------------------------------------------------
 #include "tst_test.h"
-#include "tst_cgroup.h"
-
-static const struct tst_cgroup_group *cg;
 
 static void run(void)
 {
@@ -2082,34 +2081,24 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_cgroup_require("memory", NULL);
-	cg = tst_cgroup_get_test_group();
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", MEMSIZE);
-	if (SAFE_CGROUP_HAS(cg, "memory.swap.max"))
-		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%zu", memsw);
-}
-
-static void cleanup(void)
-{
-	tst_cgroup_cleanup();
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", MEMSIZE);
+	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max"))
+		SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%zu", memsw);
 }
 
 struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
+	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
 	...
 };
 -------------------------------------------------------------------------------
 
 Above, we first ensure the memory controller is available on the
-test's CGroup with 'tst_cgroup_require'. We then get a structure,
-'cg', which represents the test's CGroup. Note that
-'tst_cgroup_get_test_group' should not be called many times, as it is
-allocated in a guarded buffer (See section 2.2.31). Therefor it is
-best to call it once in 'setup' and not 'run' because 'run' may be
-repeated with the '-i' option.
+test's CGroup with '.needs_cgroup_controllers'. This populates a structure,
+'tst_cgroup', which represents the test's CGroup.
 
 We then write the current processes PID into 'cgroup.procs', which
 moves the current process into the test's CGroup. After which we set
@@ -2129,8 +2118,6 @@ cleanup is also mostly hidden. However things can get much worse.
 
 [source,c]
 -------------------------------------------------------------------------------
-static const struct tst_cgroup_group *cg;
-static const struct tst_cgroup_group *cg_drain;
 static struct tst_cgroup_group *cg_child;
 
 static void run(void)
@@ -2138,19 +2125,21 @@ static void run(void)
 	char buf[BUFSIZ];
 	size_t mem = 0;
 
-	cg_child = tst_cgroup_group_mk(cg, "child");
+	cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
 	SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-	if (!TST_CGROUP_VER_IS_V1(cg, "memory"))
-		SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
-	if (!TST_CGROUP_VER_IS_V1(cg, "cpuset"))
-		SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+cpuset");
+	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+memory");
+	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "cpuset"))
+		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+cpuset");
 
 	if (!SAFE_FORK()) {
 		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-		if (SAFE_CGROUP_HAS(cg_child, "memory.swap"))
-			SAFE_CGROUP_SCANF(cg_child, "memory.swap.current", "%zu", &mem);
+		if (SAFE_CGROUP_HAS(cg_child, "memory.swap")) {
+			SAFE_CGROUP_SCANF(cg_child,
+					  "memory.swap.current", "%zu", &mem);
+		}
 		SAFE_CGROUP_READ(cg_child, "cpuset.mems", buf, sizeof(buf));
 
 		// Do something with cpuset.mems and memory.current values
@@ -2160,44 +2149,42 @@ static void run(void)
 	}
 
 	tst_reap_children();
-	SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
 	cg_child = tst_cgroup_group_rm(cg_child);
 }
 
-static void setup(void)
-{
-	tst_cgroup_require("memory", NULL);
-	tst_cgroup_require("cpuset", NULL);
-
-	cg = tst_cgroup_get_test_group();
-	cg_drain = tst_cgroup_get_drain_group();
-}
-
 static void cleanup(void)
 {
 	if (cg_child) {
-		SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
+		SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
 		cg_child = tst_cgroup_group_rm(cg_child);
 	}
-
-	tst_cgroup_cleanup();
 }
 
 struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.cleanup = cleanup,
+	.needs_cgroup_controllers = (const char *const []){
+		"cpuset",
+		"memory",
+		NULL
+	},
 	...
 };
 -------------------------------------------------------------------------------
 
-Starting with setup; we can see here that we also fetch the 'drain'
+Starting with setup; we can see here that we fetch the 'drain'
 CGroup. This is a shared group (between parallel tests) which may
-contain processes from other tests. It should have default settings and
-these should not be changed by the test. It can be used to remove
+contain processes from other tests. It should have default settings
+and these should not be changed by the test. It can be used to remove
 processes from other CGroups incase the hierarchy root is not
 accessible.
 
+Note that 'tst_cgroup_get_drain_group' should not be called many times,
+as it is allocated in a guarded buffer (See section 2.2.31). Therefor
+it is best to call it once in 'setup' and not 'run' because 'run' may
+be repeated with the '-i' option.
+
 In 'run', we first create a child CGroup with 'tst_cgroup_mk'. As we
 create this CGroup in 'run' we should also remove it at the end of
 run. We also need to check if it exists and remove it in cleanup as
@@ -2229,22 +2216,23 @@ destroying the child CGroup. So there is no need to transfer the child
 to drain. However the parent process must be moved otherwise we will
 get 'EBUSY' when trying to remove the child CGroup.
 
-Another example of an edge case is the following.
+Another example of a behavioral difference between versions is shown below.
 
 [source,c]
 -------------------------------------------------------------------------------
-	if (TST_CGROUP_VER_IS_V1(cg, "memory"))
-		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", ~0UL);
+	if (TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+		SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", ~0UL);
 	else
-		SAFE_CGROUP_PRINT(cg, "memory.swap.max", "max");
+		SAFE_CGROUP_PRINT(tst_cgroup, "memory.swap.max", "max");
 -------------------------------------------------------------------------------
 
 CGroups V2 introduced a feature where 'memory[.swap].max' could be set to
 "max". This does not appear to work on V1 'limit_in_bytes' however. For most
 tests, simply using a large number is sufficient and there is no need to use
 "max". Importantly though, one should be careful to read both the V1 and V2
-kernel docs. The LTP library can not handle all edge cases. It does the minimal
-amount of work to make testing on both V1 and V2 feasible.
+kernel docs. Presently the LTP library does not attempt to handle most
+differences in semantics. It does the minimal amount of work to make testing on
+both V1 and V2 feasible.
 
 1.37 Require minimum numbers of CPU for a testcase
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 5190d8794..83bdb4b0d 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -93,16 +93,19 @@ enum tst_cgroup_ver {
  * test to request a particular CGroup structure.
  */
 struct tst_cgroup_opts {
-	/* Only try to mount V1 CGroup controllers. This will not
-	 * prevent V2 from being used if it is already mounted, it
-	 * only indicates that we should mount V1 controllers if
-	 * nothing is present. By default we try to mount V2 first. */
-	int only_mount_v1:1;
+	/* Call tst_brk with TCONF if the controller is not on this
+	 * version. Defautls to zero to accept any version.
+	 */
+	enum tst_cgroup_ver needs_ver;
 };
 
 /* A Control Group in LTP's aggregated hierarchy */
 struct tst_cgroup_group;
 
+/* Populated with a reference to this tests's CGroup */
+extern const struct tst_cgroup_group *const tst_cgroup;
+extern const struct tst_cgroup_group *const tst_cgroup_drain;
+
 /* Search the system for mounted cgroups and available
  * controllers. Called automatically by tst_cgroup_require.
  */
@@ -111,22 +114,20 @@ void tst_cgroup_scan(void);
 void tst_cgroup_print_config(void);
 
 /* Ensure the specified controller is available in the test's default
- * CGroup, mounting/enabling it if necessary */
+ * CGroup, mounting/enabling it if necessary. Usually this is not
+ * necesary use tst_test.needs_cgroup_controllers instead.
+ */
 void tst_cgroup_require(const char *const ctrl_name,
 			const struct tst_cgroup_opts *const options)
-			__attribute__ ((nonnull (1)));
+			__attribute__ ((nonnull));
 
 /* Tear down any CGroups created by calls to tst_cgroup_require */
 void tst_cgroup_cleanup(void);
 
-/* Get the default CGroup for the test. It allocates memory (in a
- * guarded buffer) so should always be called from setup
+/* Call this in setup after you call tst_cgroup_require and want to
+ * initialize tst_cgroup and tst_cgroup_drain. See tst_cgroup_require.
  */
-const struct tst_cgroup_group *tst_cgroup_get_test_group(void)
-	__attribute__ ((warn_unused_result));
-/* Get the shared drain group. Also should be called from setup */
-const struct tst_cgroup_group *tst_cgroup_get_drain_group(void)
-	__attribute__ ((warn_unused_result));
+void tst_cgroup_init(void);
 
 /* Create a descendant CGroup */
 struct tst_cgroup_group *
diff --git a/include/tst_test.h b/include/tst_test.h
index 450ddf086..a7aaedcff 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -99,6 +99,7 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 #include "tst_safe_file_ops.h"
 #include "tst_safe_net.h"
 #include "tst_clone.h"
+#include "tst_cgroup.h"
 
 /*
  * Wait for all children and exit with TBROK if
@@ -280,6 +281,12 @@ struct tst_test {
 
 	/* NULL terminated array of required commands */
 	const char *const *needs_cmds;
+
+	/* Requires a particular CGroup API version. */
+	const enum tst_cgroup_ver needs_cgroup_ver;
+
+	/* {} terminated array of required CGroup controllers */
+	const char *const *needs_cgroup_ctrls;
 };
 
 /*
diff --git a/lib/newlib_tests/tst_cgroup01.c b/lib/newlib_tests/tst_cgroup01.c
index 54a370362..0fdc57e2e 100644
--- a/lib/newlib_tests/tst_cgroup01.c
+++ b/lib/newlib_tests/tst_cgroup01.c
@@ -4,7 +4,6 @@
 #include <stdio.h>
 
 #include "tst_test.h"
-#include "tst_cgroup.h"
 
 static char *only_mount_v1;
 static char *no_cleanup;
@@ -22,7 +21,7 @@ static void do_test(void)
 
 static void setup(void)
 {
-	cgopts.only_mount_v1 = !!only_mount_v1,
+	cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
 
 	tst_cgroup_scan();
 	tst_cgroup_print_config();
diff --git a/lib/newlib_tests/tst_cgroup02.c b/lib/newlib_tests/tst_cgroup02.c
index 64b0a1e94..257bc8f35 100644
--- a/lib/newlib_tests/tst_cgroup02.c
+++ b/lib/newlib_tests/tst_cgroup02.c
@@ -5,7 +5,6 @@
 #include <stdio.h>
 
 #include "tst_test.h"
-#include "tst_cgroup.h"
 
 static char *only_mount_v1;
 static char *no_cleanup;
@@ -15,8 +14,6 @@ static struct tst_option opts[] = {
 	{NULL, NULL, NULL},
 };
 static struct tst_cgroup_opts cgopts;
-static const struct tst_cgroup_group *cg;
-static const struct tst_cgroup_group *cg_drain;
 static struct tst_cgroup_group *cg_child;
 
 static void do_test(void)
@@ -24,12 +21,12 @@ static void do_test(void)
 	char buf[BUFSIZ];
 	size_t mem;
 
-	if (!TST_CGROUP_VER_IS_V1(cg, "memory"))
-		SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
-	if (!TST_CGROUP_VER_IS_V1(cg, "cpuset"))
-		SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+cpuset");
+	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+memory");
+	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "cpuset"))
+		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+cpuset");
 
-	cg_child = tst_cgroup_group_mk(cg, "child");
+	cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
 	if (!SAFE_FORK()) {
 		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
@@ -47,19 +44,19 @@ static void do_test(void)
 		exit(0);
 	}
 
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%zu", (1UL << 24) - 1);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%zu", (1UL << 24) - 1);
 	SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_SCANF(cg, "memory.current", "%zu", &mem);
+	SAFE_CGROUP_SCANF(tst_cgroup, "memory.current", "%zu", &mem);
 	tst_res(TPASS, "memory.current = %zu", mem);
 
 	tst_reap_children();
-	SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
 	cg_child = tst_cgroup_group_rm(cg_child);
 }
 
 static void setup(void)
 {
-	cgopts.only_mount_v1 = !!only_mount_v1,
+	cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
 
 	tst_cgroup_scan();
 	tst_cgroup_print_config();
@@ -67,14 +64,14 @@ static void setup(void)
 	tst_cgroup_require("memory", &cgopts);
 	tst_cgroup_require("cpuset", &cgopts);
 
-	cg = tst_cgroup_get_test_group();
-	cg_drain = tst_cgroup_get_drain_group();
+	tst_cgroup_init();
 }
 
 static void cleanup(void)
 {
 	if (cg_child) {
-		SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
+		SAFE_CGROUP_PRINTF(tst_cgroup_drain,
+				   "cgroup.procs", "%d", getpid());
 		cg_child = tst_cgroup_group_rm(cg_child);
 	}
 	if (!no_cleanup)
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 10b65364b..51b523b80 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -18,7 +18,6 @@
 #include "lapi/mount.h"
 #include "lapi/mkdirat.h"
 #include "tst_safe_file_at.h"
-#include "tst_cgroup.h"
 
 struct cgroup_root;
 
@@ -138,6 +137,14 @@ struct tst_cgroup_group {
 	struct cgroup_dir *dirs[ROOTS_MAX + 1];
 };
 
+/* If controllers are required via the tst_test struct then this is
+ * populated with the test's CGroup.
+ */
+static struct tst_cgroup_group test_group;
+static struct tst_cgroup_group drain_group;
+const struct tst_cgroup_group *const tst_cgroup = &test_group;
+const struct tst_cgroup_group *const tst_cgroup_drain = &drain_group;
+
 /* Always use first item for unified hierarchy */
 static struct cgroup_root roots[ROOTS_MAX + 1];
 
@@ -196,8 +203,6 @@ static struct cgroup_ctrl controllers[] = {
 	{ }
 };
 
-static const struct tst_cgroup_opts default_opts = { 0 };
-
 /* We should probably allow these to be set in environment
  * variables
  */
@@ -607,9 +612,6 @@ void tst_cgroup_require(const char *const ctrl_name,
 		return;
 	}
 
-	if (!options)
-		options = &default_opts;
-
 	if (ctrl->we_require_it)
 		tst_res(TWARN, "Duplicate %s(%s, )", __func__, ctrl->ctrl_name);
 
@@ -623,13 +625,14 @@ void tst_cgroup_require(const char *const ctrl_name,
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	if (!cgroup_v2_mounted() && !options->only_mount_v1)
+	if (!cgroup_v2_mounted() && options->needs_ver != TST_CGROUP_V1)
 		cgroup_mount_v2();
 
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	cgroup_mount_v1(ctrl);
+	if (options->needs_ver != TST_CGROUP_V2)
+		cgroup_mount_v1(ctrl);
 
 	if (!ctrl->ctrl_root) {
 		tst_brk(TCONF,
@@ -642,6 +645,17 @@ mkdirs:
 	root = ctrl->ctrl_root;
 	add_ctrl(&root->mnt_dir.ctrl_field, ctrl);
 
+	if (cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CGROUP_V1) {
+		tst_brk(TCONF,
+			"V1 '%s' controller required, but it's mounted on V2",
+			ctrl->ctrl_name);
+	}
+	if (!cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CGROUP_V2) {
+		tst_brk(TCONF,
+			"V2 '%s' controller required, but it's mounted on V1",
+			ctrl->ctrl_name);
+	}
+
 	if (cgroup_ctrl_on_v2(ctrl)) {
 		if (root->we_mounted_it) {
 			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
@@ -1028,18 +1042,19 @@ int safe_cgroup_has(const char *const file, const int lineno,
 	return 0;
 }
 
-__attribute__ ((warn_unused_result))
-static struct tst_cgroup_group *cgroup_group_from_roots(const size_t tree_off)
+static void group_from_roots(struct tst_cgroup_group *const cg)
 {
 	struct cgroup_root *root;
-	struct cgroup_dir *dir;
-	struct tst_cgroup_group *cg;
 
-	cg = tst_alloc(sizeof(*cg));
-	cgroup_group_init(cg, NULL);
+	if (cg->group_name[0]) {
+		tst_brk(TBROK,
+			"%s CGroup already initialized",
+			cg == &test_group ? "Test" : "Drain");
+	}
 
 	for_each_root(root) {
-		dir = (typeof(dir))(((char *)root) + tree_off);
+		struct cgroup_dir *dir =
+			cg == &test_group ? &root->test_dir : &root->drain_dir;
 
 		if (dir->ctrl_field)
 			cgroup_group_add_dir(NULL, cg, dir);
@@ -1047,23 +1062,17 @@ static struct tst_cgroup_group *cgroup_group_from_roots(const size_t tree_off)
 
 	if (cg->dirs[0]) {
 		strncpy(cg->group_name, cg->dirs[0]->dir_name, NAME_MAX);
-		return cg;
+		return;
 	}
 
 	tst_brk(TBROK,
 		"No CGroups found; maybe you forgot to call tst_cgroup_require?");
-
-	return cg;
-}
-
-const struct tst_cgroup_group *tst_cgroup_get_test_group(void)
-{
-	return cgroup_group_from_roots(offsetof(struct cgroup_root, test_dir));
 }
 
-const struct tst_cgroup_group *tst_cgroup_get_drain_group(void)
+void tst_cgroup_init(void)
 {
-	return cgroup_group_from_roots(offsetof(struct cgroup_root, drain_dir));
+	group_from_roots(&test_group);
+	group_from_roots(&drain_group);
 }
 
 ssize_t safe_cgroup_read(const char *const file, const int lineno,
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 844756fbd..1fd238cf5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1013,6 +1013,19 @@ static void prepare_device(void)
 	}
 }
 
+static void do_cgroup_requires(void)
+{
+	const struct tst_cgroup_opts cg_opts = {
+		.needs_ver = tst_test->needs_cgroup_ver,
+	};
+	const char *const *ctrl_names = tst_test->needs_cgroup_ctrls;
+
+	for (; *ctrl_names; ctrl_names++)
+		tst_cgroup_require(*ctrl_names, &cg_opts);
+
+	tst_cgroup_init();
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	if (!tst_test)
@@ -1165,6 +1178,11 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->taint_check)
 		tst_taint_init(tst_test->taint_check);
+
+	if (tst_test->needs_cgroup_ctrls)
+		do_cgroup_requires();
+	else if (tst_test->needs_cgroup_ver)
+		tst_brk(TBROK, "needs_cgroup_ver only works with needs_cgroup_controllers");
 }
 
 static void do_test_setup(void)
@@ -1198,6 +1216,9 @@ static void do_test_setup(void)
 
 static void do_cleanup(void)
 {
+	if (tst_test->needs_cgroup_ctrls)
+		tst_cgroup_cleanup();
+
 	if (ovl_mounted)
 		SAFE_UMOUNT(OVL_MNT);
 
diff --git a/testcases/kernel/controllers/memcg/memcontrol01.c b/testcases/kernel/controllers/memcg/memcontrol01.c
index f3b45610e..595192437 100644
--- a/testcases/kernel/controllers/memcg/memcontrol01.c
+++ b/testcases/kernel/controllers/memcg/memcontrol01.c
@@ -16,17 +16,15 @@
 #include <stdio.h>
 
 #include "tst_test.h"
-#include "tst_cgroup.h"
 
-static const struct tst_cgroup_group *cg_test;
 static struct tst_cgroup_group *parent, *child;
 static struct tst_cgroup_group *parent2, *child2;
 
 static void test_memcg_subtree_control(void)
 {
-	parent = tst_cgroup_group_mk(cg_test, "memcg_test_0");
+	parent = tst_cgroup_group_mk(tst_cgroup, "memcg_test_0");
 	child = tst_cgroup_group_mk(parent, "memcg_test_1");
-	parent2 = tst_cgroup_group_mk(cg_test, "memcg_test_2");
+	parent2 = tst_cgroup_group_mk(tst_cgroup, "memcg_test_2");
 	child2 = tst_cgroup_group_mk(parent2, "memcg_test_3");
 
 	SAFE_CGROUP_PRINT(parent2, "cgroup.subtree_control", "-memory");
@@ -44,15 +42,6 @@ static void test_memcg_subtree_control(void)
 	parent = tst_cgroup_group_rm(parent);
 }
 
-static void setup(void)
-{
-	tst_cgroup_require("memory", NULL);
-	cg_test = tst_cgroup_get_test_group();
-
-	if (TST_CGROUP_VER_IS_V1(cg_test, "memory"))
-		tst_brk(TCONF, "V1 controllers do not have subtree control");
-}
-
 static void cleanup(void)
 {
 	if (child2)
@@ -63,12 +52,11 @@ static void cleanup(void)
 		child = tst_cgroup_group_rm(child);
 	if (parent)
 		parent = tst_cgroup_group_rm(parent);
-
-	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_memcg_subtree_control,
+	.needs_cgroup_ver = TST_CGROUP_V2,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index d5a24cc0a..4adb31512 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -26,7 +26,6 @@
 #include "memcontrol_common.h"
 
 static size_t page_size;
-static const struct tst_cgroup_group *cg_test;
 static struct tst_cgroup_group *cg_child;
 static int fd;
 static int file_to_all_error = 10;
@@ -37,7 +36,7 @@ static void alloc_anon_50M_check(void)
 	char *buf, *ptr;
 	ssize_t anon, current;
 	const char *const anon_key_fmt =
-		TST_CGROUP_VER_IS_V1(cg_test, "memory") ? "rss %zd" : "anon %zd";
+		TST_CGROUP_VER_IS_V1(tst_cgroup, "memory") ? "rss %zd" : "anon %zd";
 
 	buf = SAFE_MALLOC(size);
 	for (ptr = buf; ptr < buf + size; ptr += page_size)
@@ -62,7 +61,7 @@ static void alloc_pagecache_50M_check(void)
 	const size_t size = MB(50);
 	size_t current, file;
 	const char *const file_key_fmt =
-		TST_CGROUP_VER_IS_V1(cg_test, "memory") ? "cache %zd" : "file %zd";
+		TST_CGROUP_VER_IS_V1(tst_cgroup, "memory") ? "cache %zd" : "file %zd";
 
 	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
 
@@ -89,7 +88,7 @@ static void test_memcg_current(unsigned int n)
 {
 	size_t current;
 
-	cg_child = tst_cgroup_group_mk(cg_test, "child");
+	cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
 	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
 	TST_EXP_EXPR(current == 0, "(current=%zu) == 0", current);
 
@@ -114,9 +113,6 @@ static void setup(void)
 {
 	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
 
-	tst_cgroup_require("memory", NULL);
-	cg_test = tst_cgroup_get_test_group();
-
 	switch (tst_fs_type(TMPDIR)) {
 	case TST_VFAT_MAGIC:
 	case TST_EXFAT_MAGIC:
@@ -130,8 +126,6 @@ static void cleanup(void)
 {
 	if (cg_child)
 		cg_child = tst_cgroup_group_rm(cg_child);
-
-	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
@@ -145,4 +139,5 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.forks_child = 1,
 	.needs_root = 1,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
diff --git a/testcases/kernel/controllers/memcg/memcontrol_common.h b/testcases/kernel/controllers/memcg/memcontrol_common.h
index 67f3ca318..63df719a6 100644
--- a/testcases/kernel/controllers/memcg/memcontrol_common.h
+++ b/testcases/kernel/controllers/memcg/memcontrol_common.h
@@ -4,7 +4,6 @@
 #include <stdio.h>
 
 #include "tst_test.h"
-#include "tst_cgroup.h"
 
 #define TMPDIR "mntdir"
 #define MB(x) (x << 20)
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 66c18f6ab..6383187d7 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -35,8 +35,6 @@
 
 #ifdef HAVE_NUMA_V2
 
-static const struct tst_cgroup_group *cg;
-
 volatile int end;
 static int *nodes;
 static int nnodes;
@@ -53,10 +51,10 @@ static void test_cpuset(void)
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	char buf[BUFSIZ];
 
-	SAFE_CGROUP_READ(cg, "cpuset.cpus", buf, sizeof(buf));
-	SAFE_CGROUP_PRINT(cg, "cpuset.cpus", buf);
-	SAFE_CGROUP_READ(cg, "cpuset.mems", buf, sizeof(buf));
-	SAFE_CGROUP_PRINT(cg, "cpuset.mems", buf);
+	SAFE_CGROUP_READ(tst_cgroup, "cpuset.cpus", buf, sizeof(buf));
+	SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.cpus", buf);
+	SAFE_CGROUP_READ(tst_cgroup, "cpuset.mems", buf, sizeof(buf));
+	SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.mems", buf);
 
 	child = SAFE_FORK();
 	if (child == 0) {
@@ -70,8 +68,8 @@ static void test_cpuset(void)
 		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
 	}
 
-	SAFE_CGROUP_PRINTF(cg, "cpuset.mems", "%d", nodes[0]);
-	SAFE_CGROUP_PRINTF(cg, "cpuset.mems", "%d", nodes[1]);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cpuset.mems", "%d", nodes[0]);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cpuset.mems", "%d", nodes[1]);
 
 	tst_reap_children();
 
@@ -80,20 +78,13 @@ static void test_cpuset(void)
 
 static void setup(void)
 {
-	tst_cgroup_require("cpuset", NULL);
 	ncpus = count_cpu();
 	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
 		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
 	if (nnodes <= 1)
 		tst_brk(TCONF, "requires a NUMA system.");
 
-	cg = tst_cgroup_get_test_group();
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
-}
-
-static void cleanup(void)
-{
-	tst_cgroup_cleanup();
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
 }
 
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
@@ -183,9 +174,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = test_cpuset,
 	.min_kver = "2.6.32",
+	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
 #else
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 38a1e8879..47a180d7e 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -6,7 +6,6 @@
 #define _MEM_H
 #include "config.h"
 #include "tst_test.h"
-#include "tst_cgroup.h"
 #include "ksm_helper.h"
 #include "tst_memutils.h"
 
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index c578cfb7f..2a890f025 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -59,9 +59,6 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
-static const struct tst_cgroup_group *cg;
-static const struct tst_cgroup_group *cg_drain;
-
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -79,19 +76,18 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(cg, node);
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+	write_cpusets(tst_cgroup, node);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
 	create_same_memory(size, num, unit);
-	SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
 }
 
 static void cleanup(void)
 {
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-
-	tst_cgroup_cleanup();
+	}
 }
 
 static void setup(void)
@@ -106,10 +102,6 @@ static void setup(void)
 				"%d", &merge_across_nodes);
 		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
-
-	tst_cgroup_require("cpuset", NULL);
-	cg = tst_cgroup_get_test_group();
-	cg_drain = tst_cgroup_get_drain_group();
 }
 
 static struct tst_test test = {
@@ -129,6 +121,7 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
 #else
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index df847cf95..03fad2ee2 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -59,8 +59,6 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-static const struct tst_cgroup_group *cg;
-
 static void verify_ksm(void)
 {
 	create_same_memory(size, num, unit);
@@ -79,18 +77,16 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	tst_cgroup_require("memory", NULL);
-	cg = tst_cgroup_get_test_group();
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", TESTMEM);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
 }
 
 static void cleanup(void)
 {
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-	tst_cgroup_cleanup();
+	}
 }
 
 static struct tst_test test = {
@@ -110,4 +106,5 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index e8bc1de85..683780907 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -59,8 +59,6 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
-static const struct tst_cgroup_group *cg;
-
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -69,7 +67,7 @@ static void verify_ksm(void)
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", TESTMEM);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
 
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 		if (errno != ENOSYS)
@@ -80,7 +78,7 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(cg, node);
+	write_cpusets(tst_cgroup, node);
 	create_same_memory(size, num, unit);
 }
 
@@ -89,8 +87,6 @@ static void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-
-	tst_cgroup_cleanup();
 }
 
 static void setup(void)
@@ -106,10 +102,7 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	tst_cgroup_require("memory", NULL);
-	tst_cgroup_require("cpuset", NULL);
-	cg = tst_cgroup_get_test_group();
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
 }
 
 static struct tst_test test = {
@@ -129,6 +122,9 @@ static struct tst_test test = {
 	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
+	.needs_cgroup_ctrls = (const char *const []){
+		"memory", "cpuset", NULL
+	},
 };
 
 #else
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 451119166..8b4fb47c7 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -36,8 +36,6 @@
 
 #ifdef HAVE_NUMA_V2
 
-static const struct tst_cgroup_group *cg;
-
 static void verify_oom(void)
 {
 #ifdef TST_ABI32
@@ -45,7 +43,7 @@ static void verify_oom(void)
 #endif
 	testoom(0, 0, ENOMEM, 1);
 
-	if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
+	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max")) {
 		tst_res(TINFO, "OOM on MEMCG with special memswap limitation:");
 		/*
 		 * Cgroup v2 tracks memory and swap in separate, which splits
@@ -57,17 +55,17 @@ static void verify_oom(void)
 		 * let's scale down the value of 'memory.swap.max' to only
 		 * 1MB for CGroup v2.
 		 */
-		if (!TST_CGROUP_VER_IS_V1(cg, "memory"))
-			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", MB);
+		if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", MB);
 		else
-			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM + MB);
+			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", TESTMEM + MB);
 
 		testoom(0, 1, ENOMEM, 1);
 
-		if (TST_CGROUP_VER_IS_V1(cg, "memory"))
-			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", ~0UL);
+		if (TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", ~0UL);
 		else
-			SAFE_CGROUP_PRINT(cg, "memory.swap.max", "max");
+			SAFE_CGROUP_PRINT(tst_cgroup, "memory.swap.max", "max");
 	}
 
 	/* OOM for MEMCG with mempolicy */
@@ -84,17 +82,14 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	tst_cgroup_require("memory", NULL);
-	cg = tst_cgroup_get_test_group();
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", TESTMEM);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
@@ -104,6 +99,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
 
 #else
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index f84328f5b..8e8902b76 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -36,8 +36,6 @@
 
 #ifdef HAVE_NUMA_V2
 
-static const struct tst_cgroup_group *cg;
-
 static void verify_oom(void)
 {
 #ifdef TST_ABI32
@@ -47,13 +45,13 @@ static void verify_oom(void)
 	testoom(0, 0, ENOMEM, 1);
 
 	if (is_numa(NULL, NH_MEMS, 2) &&
-	    SAFE_CGROUP_HAS(cg, "cpuset.memory_migrate")) {
+	    SAFE_CGROUP_HAS(tst_cgroup, "cpuset.memory_migrate")) {
 		/*
 		 * Under NUMA system, the migration of cpuset's memory
 		 * is in charge of cpuset.memory_migrate, we can write
 		 * 1 to cpuset.memory_migrate to enable the migration.
 		 */
-		SAFE_CGROUP_PRINT(cg, "cpuset.memory_migrate", "1");
+		SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.memory_migrate", "1");
 
 		tst_res(TINFO, "OOM on CPUSET with mem migrate:");
 		testoom(0, 0, ENOMEM, 1);
@@ -70,9 +68,6 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	tst_cgroup_require("cpuset", NULL);
-	cg = tst_cgroup_get_test_group();
-
 	/*
 	 * Some nodes do not contain memory, so use
 	 * get_allowed_nodes(NH_MEMS) to get a memory
@@ -83,15 +78,14 @@ static void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(cg, memnode);
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+	write_cpusets(tst_cgroup, memnode);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
@@ -101,6 +95,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
+	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
 #else
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 06497261e..ca60f1101 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -36,8 +36,6 @@
 
 #ifdef HAVE_NUMA_V2
 
-static const struct tst_cgroup_group *cg;
-
 static void verify_oom(void)
 {
 #ifdef TST_ABI32
@@ -53,29 +51,29 @@ static void verify_oom(void)
 	 * 1 to cpuset.memory_migrate to enable the migration.
 	 */
 	if (is_numa(NULL, NH_MEMS, 2) &&
-	    SAFE_CGROUP_HAS(cg, "cpuset.memory_migrate")) {
-		SAFE_CGROUP_PRINT(cg, "cpuset.memory_migrate", "1");
+	    SAFE_CGROUP_HAS(tst_cgroup, "cpuset.memory_migrate")) {
+		SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"cpuset.memory_migrate=1");
 		testoom(0, 0, ENOMEM, 1);
 	}
 
-	if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
+	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max")) {
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
-		if (!TST_CGROUP_VER_IS_V1(cg, "memory"))
-			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", MB);
+		if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", MB);
 		else
-			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM + MB);
+			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", TESTMEM + MB);
 
 		testoom(0, 1, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-		if (TST_CGROUP_VER_IS_V1(cg, "memory"))
-			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", ~0UL);
+		if (TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
+			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", ~0UL);
 		else
-			SAFE_CGROUP_PRINT(cg, "memory.swap.max", "max");
+			SAFE_CGROUP_PRINT(tst_cgroup, "memory.swap.max", "max");
 		testoom(0, 0, ENOMEM, 1);
 	}
 }
@@ -90,10 +88,6 @@ void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	tst_cgroup_require("memory", NULL);
-	tst_cgroup_require("cpuset", NULL);
-	cg = tst_cgroup_get_test_group();
-
 	/*
 	 * Some nodes do not contain memory, so use
 	 * get_allowed_nodes(NH_MEMS) to get a memory
@@ -105,16 +99,15 @@ void setup(void)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
 
-	write_cpusets(cg, memnode);
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", TESTMEM);
+	write_cpusets(tst_cgroup, memnode);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
 }
 
 void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
@@ -124,6 +117,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
+	.needs_cgroup_ctrls = (const char *const []){
+		"memory", "cpuset", NULL
+	},
 };
 
 #else
diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index e3eb237da..aae1e321b 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -29,10 +29,8 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
-#include "tst_cgroup.h"
 #include "tst_timer.h"
 
-static const struct tst_cgroup_group *cg_test;
 static struct tst_cgroup_group *cg_level2, *cg_level3a, *cg_level3b;
 static struct tst_cgroup_group *cg_workers[3];
 static int may_have_waiters = 0;
@@ -132,11 +130,7 @@ static void do_test(void)
 
 static void setup(void)
 {
-	tst_cgroup_require("cpu", NULL);
-
-	cg_test = tst_cgroup_get_test_group();
-
-	cg_level2 = tst_cgroup_group_mk(cg_test, "level2");
+	cg_level2 = tst_cgroup_group_mk(tst_cgroup, "level2");
 
 	cg_level3a = tst_cgroup_group_mk(cg_level2, "level3a");
 	mk_cpu_cgroup(&cg_workers[0], cg_level3a, "worker1", 30);
@@ -167,8 +161,6 @@ static void cleanup(void)
 		cg_level3b = tst_cgroup_group_rm(cg_level3b);
 	if (cg_level2)
 		cg_level2 = tst_cgroup_group_rm(cg_level2);
-
-	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
@@ -182,6 +174,7 @@ static struct tst_test test = {
 		"CONFIG_CFS_BANDWIDTH",
 		NULL
 	},
+	.needs_cgroup_ctrls = (const char *const []){"cpu", NULL},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "39f23ce07b93"},
 		{"linux-git", "b34cb07dde7c"},
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 263b8e78b..a2f32f733 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -48,7 +48,6 @@
 #include <sys/mount.h>
 #include <sys/sysinfo.h>
 #include "tst_test.h"
-#include "tst_cgroup.h"
 
 #define CHUNK_SZ (400*1024*1024L)
 #define MEM_LIMIT (CHUNK_SZ / 2)
@@ -56,8 +55,6 @@
 #define PASS_THRESHOLD (CHUNK_SZ / 4)
 #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
 
-static const struct tst_cgroup_group *cg;
-
 static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
 static int pg_sz, stat_refresh_sup;
 
@@ -73,10 +70,10 @@ static void print_cgmem(const char *name)
 {
 	long ret;
 
-	if (!SAFE_CGROUP_HAS(cg, name))
+	if (!SAFE_CGROUP_HAS(tst_cgroup, name))
 		return;
 
-	SAFE_CGROUP_SCANF(cg, name, "%ld", &ret);
+	SAFE_CGROUP_SCANF(tst_cgroup, name, "%ld", &ret);
 	tst_res(TINFO, "\t%s: %ld Kb", name, ret / 1024);
 }
 
@@ -121,21 +118,18 @@ static void setup(void)
 	check_path("/proc/self/oom_score_adj");
 	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
 
-	tst_cgroup_require("memory", NULL);
-	cg = tst_cgroup_get_test_group();
-
-	SAFE_CGROUP_PRINTF(cg, "memory.max", "%ld", MEM_LIMIT);
-	if (SAFE_CGROUP_HAS(cg, "memory.swap.max"))
-		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%ld", MEMSW_LIMIT);
+	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%ld", MEM_LIMIT);
+	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max"))
+		SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%ld", MEMSW_LIMIT);
 
-	if (SAFE_CGROUP_HAS(cg, "memory.swappiness")) {
-		SAFE_CGROUP_PRINT(cg, "memory.swappiness", "60");
+	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swappiness")) {
+		SAFE_CGROUP_PRINT(tst_cgroup, "memory.swappiness", "60");
 	} else {
 		check_path("/proc/sys/vm/swappiness");
 		SAFE_FILE_PRINTF("/proc/sys/vm/swappiness", "%d", 60);
 	}
 
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
 
 	meminfo_diag("Initial meminfo, later values are relative to this (except memcg)");
 	init_swap = SAFE_READ_MEMINFO("SwapTotal:") - SAFE_READ_MEMINFO("SwapFree:");
@@ -149,11 +143,6 @@ static void setup(void)
 		CHUNK_SZ / 1024, CHUNK_SZ / pg_sz, MEM_LIMIT / 1024, PASS_THRESHOLD_KB);
 }
 
-static void cleanup(void)
-{
-	tst_cgroup_cleanup();
-}
-
 static void dirty_pages(char *ptr, long size)
 {
 	long i;
@@ -237,7 +226,6 @@ static void test_advice_willneed(void)
 static struct tst_test test = {
 	.test_all = test_advice_willneed,
 	.setup = setup,
-	.cleanup = cleanup,
 	.min_kver = "3.10.0",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
@@ -245,6 +233,7 @@ static struct tst_test test = {
 		"?/proc/sys/vm/swappiness",
 		NULL
 	},
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "55231e5c898c"},
 		{"linux-git", "8de15e920dc8"},
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
