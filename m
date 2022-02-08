Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF596C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:04:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC1023C9B51
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 15:04:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0D213C9B60
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:03:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7D63601074
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:03:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 430F31F383;
 Tue,  8 Feb 2022 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644329025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EMFzO8QhiMP4mvh/iBDoYCuYJBkSHuMrG+F8v0mugs=;
 b=H1cAPN4yuq6LdTl3Jgd6vVafFkthE6Tjn5rALyzgu3Ez/joRigJyMAkQlQ2z6Sfzea6DKi
 8y+jlIS30xTXis/6iCU2UHs2vI0PXa4W9ySD9dGgdUFvxHjmDep5jKWidAXcSVdLi7Xw3D
 UkwxAvURriF9cPZift7FvI5NKEEFwoo=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 6DB1CA3B90;
 Tue,  8 Feb 2022 14:03:44 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 14:03:21 +0000
Message-Id: <20220208140322.6842-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208140322.6842-1-rpalethorpe@suse.com>
References: <20220208140322.6842-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] API/cgroup: Shorten cgroup to cg in most symbols
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

With the current naming it is common to have 'group' repeated 3 or
even 4 times in one line. This causes a number of readability
problems. Renaming it to cg reduces the amount of repetition.

The one place it is not renamed is in tst_test because it won't cause
repetition there. Meanwhile it is easier to search the internet for
'linux cgroup' than 'linux cg'.

Li Wang suggested renaming tst_cg to tst_cg_test because it is
consistent with tst_cg_drain. However I think tst_cg is used so often
that it is more important to have shorter lines.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/c-test-api.txt                            |  52 ++++----
 include/tst_cgroup.h                          | 112 +++++++++---------
 include/tst_test.h                            |   2 +-
 lib/newlib_tests/tst_cgroup01.c               |  18 +--
 lib/newlib_tests/tst_cgroup02.c               |  54 ++++-----
 lib/tst_cgroup.c                              | 110 ++++++++---------
 lib/tst_test.c                                |   8 +-
 scripts/coccinelle/cgroup-ver.cocci           |  16 +--
 .../coccinelle/kselftest-cgroup-to-ltp.cocci  |  16 +--
 .../kernel/controllers/memcg/memcontrol01.c   |  36 +++---
 .../kernel/controllers/memcg/memcontrol02.c   |  28 ++---
 .../kernel/controllers/memcg/memcontrol03.c   |  60 +++++-----
 testcases/kernel/mem/cpuset/cpuset01.c        |  14 +--
 testcases/kernel/mem/include/mem.h            |   2 +-
 testcases/kernel/mem/ksm/ksm02.c              |   6 +-
 testcases/kernel/mem/ksm/ksm03.c              |   4 +-
 testcases/kernel/mem/ksm/ksm04.c              |   6 +-
 testcases/kernel/mem/lib/mem.c                |   8 +-
 testcases/kernel/mem/oom/oom03.c              |  18 +--
 testcases/kernel/mem/oom/oom04.c              |   8 +-
 testcases/kernel/mem/oom/oom05.c              |  24 ++--
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |  40 +++----
 testcases/kernel/syscalls/madvise/madvise06.c |  16 +--
 23 files changed, 329 insertions(+), 329 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 51dac58ae..4ae49925c 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2084,10 +2084,10 @@ static void run(void)
 
 static void setup(void)
 {
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", MEMSIZE);
-	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max"))
-		SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%zu", memsw);
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", MEMSIZE);
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%zu", memsw);
 }
 
 struct tst_test test = {
@@ -2101,7 +2101,7 @@ struct tst_test test = {
 
 Above, we first ensure the memory controller is available on the
 test's CGroup with '.needs_cgroup_controllers'. This populates a structure,
-'tst_cgroup', which represents the test's CGroup.
+'tst_cg', which represents the test's CGroup.
 
 We then write the current processes PID into 'cgroup.procs', which
 moves the current process into the test's CGroup. After which we set
@@ -2112,7 +2112,7 @@ on both CGroup versions, then we use the V2 naming.
 
 Some controller features, such as 'memory.swap', can be
 disabled. Therefor we need to check if they exist before accessing
-them. This can be done with 'SAFE_CGROUP_HAS' which can be called on
+them. This can be done with 'SAFE_CG_HAS' which can be called on
 any control file or feature.
 
 Most tests only require setting a few limits similar to the above. In
@@ -2121,29 +2121,29 @@ cleanup is also mostly hidden. However things can get much worse.
 
 [source,c]
 -------------------------------------------------------------------------------
-static struct tst_cgroup_group *cg_child;
+static struct tst_cg_group *cg_child;
 
 static void run(void)
 {
 	char buf[BUFSIZ];
 	size_t mem = 0;
 
-	cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
-	SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+	cg_child = tst_cg_group_mk(tst_cg, "child");
+	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+memory");
-	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "cpuset"))
-		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+cpuset");
+	if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_PRINT(tst_cg, "cgroup.subtree_control", "+memory");
+	if (!TST_CG_VER_IS_V1(tst_cg, "cpuset"))
+		SAFE_CG_PRINT(tst_cg, "cgroup.subtree_control", "+cpuset");
 
 	if (!SAFE_FORK()) {
-		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+		SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-		if (SAFE_CGROUP_HAS(cg_child, "memory.swap")) {
-			SAFE_CGROUP_SCANF(cg_child,
+		if (SAFE_CG_HAS(cg_child, "memory.swap")) {
+			SAFE_CG_SCANF(cg_child,
 					  "memory.swap.current", "%zu", &mem);
 		}
-		SAFE_CGROUP_READ(cg_child, "cpuset.mems", buf, sizeof(buf));
+		SAFE_CG_READ(cg_child, "cpuset.mems", buf, sizeof(buf));
 
 		// Do something with cpuset.mems and memory.current values
 		...
@@ -2152,15 +2152,15 @@ static void run(void)
 	}
 
 	tst_reap_children();
-	SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
-	cg_child = tst_cgroup_group_rm(cg_child);
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	cg_child = tst_cg_group_rm(cg_child);
 }
 
 static void cleanup(void)
 {
 	if (cg_child) {
-		SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
-		cg_child = tst_cgroup_group_rm(cg_child);
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child = tst_cg_group_rm(cg_child);
 	}
 }
 
@@ -2183,12 +2183,12 @@ and these should not be changed by the test. It can be used to remove
 processes from other CGroups incase the hierarchy root is not
 accessible.
 
-Note that 'tst_cgroup_get_drain_group' should not be called many times,
+Note that 'tst_cg_get_drain_group' should not be called many times,
 as it is allocated in a guarded buffer (See section 2.2.31). Therefor
 it is best to call it once in 'setup' and not 'run' because 'run' may
 be repeated with the '-i' option.
 
-In 'run', we first create a child CGroup with 'tst_cgroup_mk'. As we
+In 'run', we first create a child CGroup with 'tst_cg_mk'. As we
 create this CGroup in 'run' we should also remove it at the end of
 run. We also need to check if it exists and remove it in cleanup as
 well. Because there are 'SAFE_' functions which may jump to cleanup.
@@ -2223,10 +2223,10 @@ Another example of a behavioral difference between versions is shown below.
 
 [source,c]
 -------------------------------------------------------------------------------
-	if (TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-		SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", ~0UL);
+	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", ~0UL);
 	else
-		SAFE_CGROUP_PRINT(tst_cgroup, "memory.swap.max", "max");
+		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
 -------------------------------------------------------------------------------
 
 CGroups V2 introduced a feature where 'memory[.swap].max' could be set to
diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 39aa95a88..d32d62399 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -84,134 +84,134 @@
 #include <sys/types.h>
 
 /* CGroups Kernel API version */
-enum tst_cgroup_ver {
-	TST_CGROUP_V1 = 1,
-	TST_CGROUP_V2 = 2,
+enum tst_cg_ver {
+	TST_CG_V1 = 1,
+	TST_CG_V2 = 2,
 };
 
 /* Used to specify CGroup hierarchy configuration options, allowing a
  * test to request a particular CGroup structure.
  */
-struct tst_cgroup_opts {
+struct tst_cg_opts {
 	/* Call tst_brk with TCONF if the controller is not on this
 	 * version. Defautls to zero to accept any version.
 	 */
-	enum tst_cgroup_ver needs_ver;
+	enum tst_cg_ver needs_ver;
 };
 
 /* A Control Group in LTP's aggregated hierarchy */
-struct tst_cgroup_group;
+struct tst_cg_group;
 
 /* Populated with a reference to this tests's CGroup */
-extern const struct tst_cgroup_group *const tst_cgroup;
-extern const struct tst_cgroup_group *const tst_cgroup_drain;
+extern const struct tst_cg_group *const tst_cg;
+extern const struct tst_cg_group *const tst_cg_drain;
 
 /* Search the system for mounted cgroups and available
- * controllers. Called automatically by tst_cgroup_require.
+ * controllers. Called automatically by tst_cg_require.
  */
-void tst_cgroup_scan(void);
-/* Print the config detected by tst_cgroup_scan */
-void tst_cgroup_print_config(void);
+void tst_cg_scan(void);
+/* Print the config detected by tst_cg_scan */
+void tst_cg_print_config(void);
 
 /* Ensure the specified controller is available in the test's default
  * CGroup, mounting/enabling it if necessary. Usually this is not
  * necesary use tst_test.needs_cgroup_controllers instead.
  */
-void tst_cgroup_require(const char *const ctrl_name,
-			const struct tst_cgroup_opts *const options)
+void tst_cg_require(const char *const ctrl_name,
+			const struct tst_cg_opts *const options)
 			__attribute__ ((nonnull));
 
-/* Tear down any CGroups created by calls to tst_cgroup_require */
-void tst_cgroup_cleanup(void);
+/* Tear down any CGroups created by calls to tst_cg_require */
+void tst_cg_cleanup(void);
 
-/* Call this in setup after you call tst_cgroup_require and want to
- * initialize tst_cgroup and tst_cgroup_drain. See tst_cgroup_require.
+/* Call this in setup after you call tst_cg_require and want to
+ * initialize tst_cg and tst_cg_drain. See tst_cg_require.
  */
-void tst_cgroup_init(void);
+void tst_cg_init(void);
 
 /* Create a descendant CGroup */
-struct tst_cgroup_group *
-tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
+struct tst_cg_group *
+tst_cg_group_mk(const struct tst_cg_group *const parent,
 		    const char *const group_name_fmt, ...)
 	    __attribute__ ((nonnull, warn_unused_result, format (printf, 2, 3)));
 
 const char *
-tst_cgroup_group_name(const struct tst_cgroup_group *const cg)
+tst_cg_group_name(const struct tst_cg_group *const cg)
 		      __attribute__ ((nonnull, warn_unused_result));
 
 /* Remove a descendant CGroup */
-struct tst_cgroup_group *
-tst_cgroup_group_rm(struct tst_cgroup_group *const cg)
+struct tst_cg_group *
+tst_cg_group_rm(struct tst_cg_group *const cg)
 		    __attribute__ ((nonnull, warn_unused_result));
 
-#define TST_CGROUP_VER(cg, ctrl_name) \
-	tst_cgroup_ver(__FILE__, __LINE__, (cg), (ctrl_name))
+#define TST_CG_VER(cg, ctrl_name) \
+	tst_cg_ver(__FILE__, __LINE__, (cg), (ctrl_name))
 
-enum tst_cgroup_ver tst_cgroup_ver(const char *const file, const int lineno,
-				   const struct tst_cgroup_group *const cg,
+enum tst_cg_ver tst_cg_ver(const char *const file, const int lineno,
+				   const struct tst_cg_group *const cg,
 				   const char *const ctrl_name)
 				   __attribute__ ((nonnull, warn_unused_result));
 
-#define TST_CGROUP_VER_IS_V1(cg, ctrl_name) \
-	(TST_CGROUP_VER((cg), (ctrl_name)) == TST_CGROUP_V1)
+#define TST_CG_VER_IS_V1(cg, ctrl_name) \
+	(TST_CG_VER((cg), (ctrl_name)) == TST_CG_V1)
 
-#define SAFE_CGROUP_HAS(cg, file_name) \
-	safe_cgroup_has(__FILE__, __LINE__, (cg), (file_name))
+#define SAFE_CG_HAS(cg, file_name) \
+	safe_cg_has(__FILE__, __LINE__, (cg), (file_name))
 
-int safe_cgroup_has(const char *const file, const int lineno,
-		    const struct tst_cgroup_group *const cg,
+int safe_cg_has(const char *const file, const int lineno,
+		    const struct tst_cg_group *const cg,
 		    const char *const file_name)
 		    __attribute__ ((nonnull, warn_unused_result));
 
-#define SAFE_CGROUP_READ(cg, file_name, out, len)			\
-	safe_cgroup_read(__FILE__, __LINE__,				\
+#define SAFE_CG_READ(cg, file_name, out, len)			\
+	safe_cg_read(__FILE__, __LINE__,				\
 			 (cg), (file_name), (out), (len))
 
-ssize_t safe_cgroup_read(const char *const file, const int lineno,
-			 const struct tst_cgroup_group *const cg,
+ssize_t safe_cg_read(const char *const file, const int lineno,
+			 const struct tst_cg_group *const cg,
 			 const char *const file_name,
 			 char *const out, const size_t len)
 			 __attribute__ ((nonnull));
 
-#define SAFE_CGROUP_PRINTF(cg, file_name, fmt, ...)			\
-	safe_cgroup_printf(__FILE__, __LINE__,				\
+#define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
+	safe_cg_printf(__FILE__, __LINE__,				\
 			   (cg), (file_name), (fmt), __VA_ARGS__)
 
-#define SAFE_CGROUP_PRINT(cg, file_name, str)				\
-	safe_cgroup_printf(__FILE__, __LINE__, (cg), (file_name), "%s", (str))
+#define SAFE_CG_PRINT(cg, file_name, str)				\
+	safe_cg_printf(__FILE__, __LINE__, (cg), (file_name), "%s", (str))
 
-void safe_cgroup_printf(const char *const file, const int lineno,
-			const struct tst_cgroup_group *const cg,
+void safe_cg_printf(const char *const file, const int lineno,
+			const struct tst_cg_group *const cg,
 			const char *const file_name,
 			const char *const fmt, ...)
 			__attribute__ ((format (printf, 5, 6), nonnull));
 
-#define SAFE_CGROUP_SCANF(cg, file_name, fmt, ...)			\
-	safe_cgroup_scanf(__FILE__, __LINE__,				\
+#define SAFE_CG_SCANF(cg, file_name, fmt, ...)			\
+	safe_cg_scanf(__FILE__, __LINE__,				\
 			  (cg), (file_name), (fmt), __VA_ARGS__)
 
-void safe_cgroup_scanf(const char *file, const int lineno,
-		       const struct tst_cgroup_group *const cg,
+void safe_cg_scanf(const char *file, const int lineno,
+		       const struct tst_cg_group *const cg,
 		       const char *const file_name,
 		       const char *const fmt, ...)
 		       __attribute__ ((format (scanf, 5, 6), nonnull));
 
-#define SAFE_CGROUP_LINES_SCANF(cg, file_name, fmt, ...)		\
-	safe_cgroup_lines_scanf(__FILE__, __LINE__,			\
+#define SAFE_CG_LINES_SCANF(cg, file_name, fmt, ...)		\
+	safe_cg_lines_scanf(__FILE__, __LINE__,			\
 				(cg), (file_name), (fmt), __VA_ARGS__)
 
-void safe_cgroup_lines_scanf(const char *const file, const int lineno,
-			     const struct tst_cgroup_group *const cg,
+void safe_cg_lines_scanf(const char *const file, const int lineno,
+			     const struct tst_cg_group *const cg,
 			     const char *const file_name,
 			     const char *const fmt, ...)
 			__attribute__ ((format (scanf, 5, 6), nonnull));
 
-#define SAFE_CGROUP_OCCURSIN(cg, file_name, needle)		\
-	safe_cgroup_occursin(__FILE__, __LINE__,		\
+#define SAFE_CG_OCCURSIN(cg, file_name, needle)		\
+	safe_cg_occursin(__FILE__, __LINE__,		\
 			     (cg), (file_name), (needle))
 
-int safe_cgroup_occursin(const char *file, const int lineno,
-			 const struct tst_cgroup_group *const cg,
+int safe_cg_occursin(const char *file, const int lineno,
+			 const struct tst_cg_group *const cg,
 			 const char *const file_name,
 			 const char *const needle);
 
diff --git a/include/tst_test.h b/include/tst_test.h
index a7aaedcff..6ccd82b48 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -283,7 +283,7 @@ struct tst_test {
 	const char *const *needs_cmds;
 
 	/* Requires a particular CGroup API version. */
-	const enum tst_cgroup_ver needs_cgroup_ver;
+	const enum tst_cg_ver needs_cgroup_ver;
 
 	/* {} terminated array of required CGroup controllers */
 	const char *const *needs_cgroup_ctrls;
diff --git a/lib/newlib_tests/tst_cgroup01.c b/lib/newlib_tests/tst_cgroup01.c
index 0fdc57e2e..eda0c548d 100644
--- a/lib/newlib_tests/tst_cgroup01.c
+++ b/lib/newlib_tests/tst_cgroup01.c
@@ -12,7 +12,7 @@ static struct tst_option opts[] = {
 	{"n", &no_cleanup, "-n\tLeave CGroups created by test"},
 	{NULL, NULL, NULL},
 };
-struct tst_cgroup_opts cgopts;
+struct tst_cg_opts cgopts;
 
 static void do_test(void)
 {
@@ -21,15 +21,15 @@ static void do_test(void)
 
 static void setup(void)
 {
-	cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
+	cgopts.needs_ver = !!only_mount_v1 ? TST_CG_V1 : 0;
 
-	tst_cgroup_scan();
-	tst_cgroup_print_config();
+	tst_cg_scan();
+	tst_cg_print_config();
 
-	tst_cgroup_require("memory", &cgopts);
-	tst_cgroup_print_config();
-	tst_cgroup_require("cpuset", &cgopts);
-	tst_cgroup_print_config();
+	tst_cg_require("memory", &cgopts);
+	tst_cg_print_config();
+	tst_cg_require("cpuset", &cgopts);
+	tst_cg_print_config();
 }
 
 static void cleanup(void)
@@ -38,7 +38,7 @@ static void cleanup(void)
 		tst_res(TINFO, "no cleanup");
 	} else {
 		tst_res(TINFO, "cleanup");
-		tst_cgroup_cleanup();
+		tst_cg_cleanup();
 	}
 }
 
diff --git a/lib/newlib_tests/tst_cgroup02.c b/lib/newlib_tests/tst_cgroup02.c
index 257bc8f35..de2ca1812 100644
--- a/lib/newlib_tests/tst_cgroup02.c
+++ b/lib/newlib_tests/tst_cgroup02.c
@@ -13,69 +13,69 @@ static struct tst_option opts[] = {
 	{"n", &no_cleanup, "-n\tLeave CGroups created by test"},
 	{NULL, NULL, NULL},
 };
-static struct tst_cgroup_opts cgopts;
-static struct tst_cgroup_group *cg_child;
+static struct tst_cg_opts cgopts;
+static struct tst_cg_group *cg_child;
 
 static void do_test(void)
 {
 	char buf[BUFSIZ];
 	size_t mem;
 
-	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+memory");
-	if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "cpuset"))
-		SAFE_CGROUP_PRINT(tst_cgroup, "cgroup.subtree_control", "+cpuset");
+	if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_PRINT(tst_cg, "cgroup.subtree_control", "+memory");
+	if (!TST_CG_VER_IS_V1(tst_cg, "cpuset"))
+		SAFE_CG_PRINT(tst_cg, "cgroup.subtree_control", "+cpuset");
 
-	cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
+	cg_child = tst_cg_group_mk(tst_cg, "child");
 	if (!SAFE_FORK()) {
-		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+		SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-		SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &mem);
+		SAFE_CG_SCANF(cg_child, "memory.current", "%zu", &mem);
 		tst_res(TPASS, "child/memory.current = %zu", mem);
-		SAFE_CGROUP_PRINTF(cg_child, "memory.max",
+		SAFE_CG_PRINTF(cg_child, "memory.max",
 				   "%zu", (1UL << 24) - 1);
-		SAFE_CGROUP_PRINTF(cg_child, "memory.swap.max",
+		SAFE_CG_PRINTF(cg_child, "memory.swap.max",
 				   "%zu", 1UL << 31);
 
-		SAFE_CGROUP_READ(cg_child, "cpuset.mems", buf, sizeof(buf));
+		SAFE_CG_READ(cg_child, "cpuset.mems", buf, sizeof(buf));
 		tst_res(TPASS, "child/cpuset.mems = %s", buf);
-		SAFE_CGROUP_PRINT(cg_child, "cpuset.mems", buf);
+		SAFE_CG_PRINT(cg_child, "cpuset.mems", buf);
 
 		exit(0);
 	}
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%zu", (1UL << 24) - 1);
-	SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_SCANF(tst_cgroup, "memory.current", "%zu", &mem);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%zu", (1UL << 24) - 1);
+	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+	SAFE_CG_SCANF(tst_cg, "memory.current", "%zu", &mem);
 	tst_res(TPASS, "memory.current = %zu", mem);
 
 	tst_reap_children();
-	SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
-	cg_child = tst_cgroup_group_rm(cg_child);
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	cg_child = tst_cg_group_rm(cg_child);
 }
 
 static void setup(void)
 {
-	cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
+	cgopts.needs_ver = !!only_mount_v1 ? TST_CG_V1 : 0;
 
-	tst_cgroup_scan();
-	tst_cgroup_print_config();
+	tst_cg_scan();
+	tst_cg_print_config();
 
-	tst_cgroup_require("memory", &cgopts);
-	tst_cgroup_require("cpuset", &cgopts);
+	tst_cg_require("memory", &cgopts);
+	tst_cg_require("cpuset", &cgopts);
 
-	tst_cgroup_init();
+	tst_cg_init();
 }
 
 static void cleanup(void)
 {
 	if (cg_child) {
-		SAFE_CGROUP_PRINTF(tst_cgroup_drain,
+		SAFE_CG_PRINTF(tst_cg_drain,
 				   "cgroup.procs", "%d", getpid());
-		cg_child = tst_cgroup_group_rm(cg_child);
+		cg_child = tst_cg_group_rm(cg_child);
 	}
 	if (!no_cleanup)
-		tst_cgroup_cleanup();
+		tst_cg_cleanup();
 }
 
 static struct tst_test test = {
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 4d326c730..dc090b70a 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -51,7 +51,7 @@ struct cgroup_dir {
 
 /* The root of a CGroup hierarchy/tree */
 struct cgroup_root {
-	enum tst_cgroup_ver ver;
+	enum tst_cg_ver ver;
 	/* A mount path */
 	char mnt_path[PATH_MAX];
 	/* Subsystems (controllers) bit field. Includes all
@@ -127,7 +127,7 @@ struct cgroup_ctrl {
 	int we_require_it:1;
 };
 
-struct tst_cgroup_group {
+struct tst_cg_group {
 	char group_name[NAME_MAX + 1];
 	/* Maps controller ID to the tree which contains it. The V2
 	 * tree is at zero even if it contains no controllers.
@@ -140,10 +140,10 @@ struct tst_cgroup_group {
 /* If controllers are required via the tst_test struct then this is
  * populated with the test's CGroup.
  */
-static struct tst_cgroup_group test_group;
-static struct tst_cgroup_group drain_group;
-const struct tst_cgroup_group *const tst_cgroup = &test_group;
-const struct tst_cgroup_group *const tst_cgroup_drain = &drain_group;
+static struct tst_cg_group test_group;
+static struct tst_cg_group drain_group;
+const struct tst_cg_group *const tst_cg = &test_group;
+const struct tst_cg_group *const tst_cg_drain = &drain_group;
 
 /* Always use first item for unified hierarchy */
 static struct cgroup_root roots[ROOTS_MAX + 1];
@@ -268,7 +268,7 @@ static int cgroup_mounted(void)
 __attribute__ ((nonnull, warn_unused_result))
 static int cgroup_ctrl_on_v2(const struct cgroup_ctrl *const ctrl)
 {
-	return ctrl->ctrl_root && ctrl->ctrl_root->ver == TST_CGROUP_V2;
+	return ctrl->ctrl_root && ctrl->ctrl_root->ver == TST_CG_V2;
 }
 
 __attribute__ ((nonnull))
@@ -309,7 +309,7 @@ opendir:
 				  O_PATH | O_DIRECTORY);
 }
 
-void tst_cgroup_print_config(void)
+void tst_cg_print_config(void)
 {
 	struct cgroup_root *root;
 	const struct cgroup_ctrl *ctrl;
@@ -325,7 +325,7 @@ void tst_cgroup_print_config(void)
 		tst_res(TINFO, "\t%.10s %s @ %s:%s",
 			ctrl->ctrl_name,
 			root->no_cpuset_prefix ? "[noprefix]" : "",
-			root->ver == TST_CGROUP_V1 ? "V1" : "V2",
+			root->ver == TST_CG_V1 ? "V1" : "V2",
 			root->mnt_path);
 	}
 }
@@ -390,7 +390,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 	if (root->ctrl_field)
 		tst_brk(TBROK, "Available V2 controllers are changing between scans?");
 
-	root->ver = TST_CGROUP_V2;
+	root->ver = TST_CG_V2;
 
 	goto backref;
 
@@ -424,7 +424,7 @@ v1:
 			ROOTS_MAX);
 	}
 
-	root->ver = TST_CGROUP_V1;
+	root->ver = TST_CG_V1;
 
 backref:
 	strcpy(root->mnt_path, mnt_dir);
@@ -445,7 +445,7 @@ discard:
 	close(mnt_dfd);
 }
 
-void tst_cgroup_scan(void)
+void tst_cg_scan(void)
 {
 	struct mntent *mnt;
 	FILE *f = setmntent("/proc/self/mounts", "r");
@@ -496,7 +496,7 @@ static void cgroup_mount_v2(void)
 mount:
 	if (!mount("cgroup2", mnt_path, "cgroup2", 0, NULL)) {
 		tst_res(TINFO, "Mounted V2 CGroups on %s", mnt_path);
-		tst_cgroup_scan();
+		tst_cg_scan();
 		roots[0].we_mounted_it = 1;
 		return;
 	}
@@ -546,7 +546,7 @@ mount:
 	}
 
 	tst_res(TINFO, "Mounted V1 %s CGroup on %s", ctrl->ctrl_name, mnt_path);
-	tst_cgroup_scan();
+	tst_cg_scan();
 	if (!ctrl->ctrl_root)
 		return;
 
@@ -602,8 +602,8 @@ static void cgroup_copy_cpuset(const struct cgroup_root *const root)
  * cpuset.
  *
  */
-void tst_cgroup_require(const char *const ctrl_name,
-			const struct tst_cgroup_opts *options)
+void tst_cg_require(const char *const ctrl_name,
+			const struct tst_cg_opts *options)
 {
 	const char *const cgsc = "cgroup.subtree_control";
 	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
@@ -623,18 +623,18 @@ void tst_cgroup_require(const char *const ctrl_name,
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	tst_cgroup_scan();
+	tst_cg_scan();
 
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	if (!cgroup_v2_mounted() && options->needs_ver != TST_CGROUP_V1)
+	if (!cgroup_v2_mounted() && options->needs_ver != TST_CG_V1)
 		cgroup_mount_v2();
 
 	if (ctrl->ctrl_root)
 		goto mkdirs;
 
-	if (options->needs_ver != TST_CGROUP_V2)
+	if (options->needs_ver != TST_CG_V2)
 		cgroup_mount_v1(ctrl);
 
 	if (!ctrl->ctrl_root) {
@@ -648,12 +648,12 @@ mkdirs:
 	root = ctrl->ctrl_root;
 	add_ctrl(&root->mnt_dir.ctrl_field, ctrl);
 
-	if (cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CGROUP_V1) {
+	if (cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CG_V1) {
 		tst_brk(TCONF,
 			"V1 '%s' controller required, but it's mounted on V2",
 			ctrl->ctrl_name);
 	}
-	if (!cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CGROUP_V2) {
+	if (!cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CG_V2) {
 		tst_brk(TCONF,
 			"V2 '%s' controller required, but it's mounted on V1",
 			ctrl->ctrl_name);
@@ -691,13 +691,13 @@ mkdirs:
 	cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir, &root->test_dir);
 }
 
-static void cgroup_drain(const enum tst_cgroup_ver ver,
+static void cgroup_drain(const enum tst_cg_ver ver,
 			 const int source_dfd, const int dest_dfd)
 {
 	char pid_list[BUFSIZ];
 	char *tok;
 	const char *const file_name =
-		ver == TST_CGROUP_V1 ? "tasks" : "cgroup.procs";
+		ver == TST_CG_V1 ? "tasks" : "cgroup.procs";
 	int fd;
 	ssize_t ret;
 
@@ -766,7 +766,7 @@ static void close_path_fds(struct cgroup_root *const root)
  * Finally we clear any data we have collected on CGroups. This will
  * happen regardless of whether anything was removed.
  */
-void tst_cgroup_cleanup(void)
+void tst_cg_cleanup(void)
 {
 	struct cgroup_root *root;
 	struct cgroup_ctrl *ctrl;
@@ -837,14 +837,14 @@ clear_data:
 }
 
 __attribute__((nonnull(2, 3)))
-static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
-				 struct tst_cgroup_group *const cg,
+static void cgroup_group_add_dir(const struct tst_cg_group *const parent,
+				 struct tst_cg_group *const cg,
 				 struct cgroup_dir *const dir)
 {
 	const struct cgroup_ctrl *ctrl;
 	int i;
 
-	if (dir->dir_root->ver != TST_CGROUP_V1)
+	if (dir->dir_root->ver != TST_CG_V1)
 		cg->dirs_by_ctrl[0] = dir;
 
 	for_each_ctrl(ctrl) {
@@ -853,10 +853,10 @@ static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 
 		cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
 
-		if (!parent || dir->dir_root->ver == TST_CGROUP_V1)
+		if (!parent || dir->dir_root->ver == TST_CG_V1)
 			continue;
 
-		SAFE_CGROUP_PRINTF(parent, "cgroup.subtree_control",
+		SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
 				   "+%s", ctrl->ctrl_name);
 	}
 
@@ -865,11 +865,11 @@ static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 	cg->dirs[i] = dir;
 }
 
-struct tst_cgroup_group *
-tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
+struct tst_cg_group *
+tst_cg_group_mk(const struct tst_cg_group *const parent,
 		    const char *const group_name_fmt, ...)
 {
-	struct tst_cgroup_group *cg;
+	struct tst_cg_group *cg;
 	struct cgroup_dir *const *dir;
 	struct cgroup_dir *new_dir;
 	va_list ap;
@@ -895,12 +895,12 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
 	return cg;
 }
 
-const char *tst_cgroup_group_name(const struct tst_cgroup_group *const cg)
+const char *tst_cg_group_name(const struct tst_cg_group *const cg)
 {
 	return cg->group_name;
 }
 
-struct tst_cgroup_group *tst_cgroup_group_rm(struct tst_cgroup_group *const cg)
+struct tst_cg_group *tst_cg_group_rm(struct tst_cg_group *const cg)
 {
 	struct cgroup_dir **dir;
 
@@ -961,8 +961,8 @@ static const struct cgroup_file *cgroup_file_find(const char *const file,
 	return cfile;
 }
 
-enum tst_cgroup_ver tst_cgroup_ver(const char *const file, const int lineno,
-				    const struct tst_cgroup_group *const cg,
+enum tst_cg_ver tst_cg_ver(const char *const file, const int lineno,
+				    const struct tst_cg_group *const cg,
 				    const char *const ctrl_name)
 {
 	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
@@ -997,7 +997,7 @@ __attribute__ ((nonnull, warn_unused_result))
 static const char *cgroup_file_alias(const struct cgroup_file *const cfile,
 				     const struct cgroup_dir *const dir)
 {
-	if (dir->dir_root->ver != TST_CGROUP_V1)
+	if (dir->dir_root->ver != TST_CG_V1)
 		return cfile->file_name;
 
 	if (cfile->ctrl_indx == CTRL_CPUSET &&
@@ -1009,8 +1009,8 @@ static const char *cgroup_file_alias(const struct cgroup_file *const cfile,
 	return cfile->file_name_v1;
 }
 
-int safe_cgroup_has(const char *const file, const int lineno,
-		    const struct tst_cgroup_group *cg,
+int safe_cg_has(const char *const file, const int lineno,
+		    const struct tst_cg_group *cg,
 		    const char *const file_name)
 {
 	const struct cgroup_file *const cfile =
@@ -1040,7 +1040,7 @@ int safe_cgroup_has(const char *const file, const int lineno,
 	return 0;
 }
 
-static void group_from_roots(struct tst_cgroup_group *const cg)
+static void group_from_roots(struct tst_cg_group *const cg)
 {
 	struct cgroup_root *root;
 
@@ -1064,17 +1064,17 @@ static void group_from_roots(struct tst_cgroup_group *const cg)
 	}
 
 	tst_brk(TBROK,
-		"No CGroups found; maybe you forgot to call tst_cgroup_require?");
+		"No CGroups found; maybe you forgot to call tst_cg_require?");
 }
 
-void tst_cgroup_init(void)
+void tst_cg_init(void)
 {
 	group_from_roots(&test_group);
 	group_from_roots(&drain_group);
 }
 
-ssize_t safe_cgroup_read(const char *const file, const int lineno,
-			 const struct tst_cgroup_group *const cg,
+ssize_t safe_cg_read(const char *const file, const int lineno,
+			 const struct tst_cg_group *const cg,
 			 const char *const file_name,
 			 char *const out, const size_t len)
 {
@@ -1114,8 +1114,8 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 	return read_ret;
 }
 
-void safe_cgroup_printf(const char *const file, const int lineno,
-			const struct tst_cgroup_group *cg,
+void safe_cg_printf(const char *const file, const int lineno,
+			const struct tst_cg_group *cg,
 			const char *const file_name,
 			const char *const fmt, ...)
 {
@@ -1137,14 +1137,14 @@ void safe_cgroup_printf(const char *const file, const int lineno,
 	}
 }
 
-void safe_cgroup_scanf(const char *const file, const int lineno,
-		       const struct tst_cgroup_group *const cg,
+void safe_cg_scanf(const char *const file, const int lineno,
+		       const struct tst_cg_group *const cg,
 		       const char *const file_name,
 		       const char *const fmt, ...)
 {
 	va_list va;
 	char buf[BUFSIZ];
-	ssize_t len = safe_cgroup_read(file, lineno,
+	ssize_t len = safe_cg_read(file, lineno,
 				       cg, file_name, buf, sizeof(buf));
 	const int conv_cnt = tst_count_scanf_conversions(fmt);
 	int ret;
@@ -1168,14 +1168,14 @@ void safe_cgroup_scanf(const char *const file, const int lineno,
 		 file_name, buf, fmt, ret, conv_cnt);
 }
 
-void safe_cgroup_lines_scanf(const char *const file, const int lineno,
-			     const struct tst_cgroup_group *const cg,
+void safe_cg_lines_scanf(const char *const file, const int lineno,
+			     const struct tst_cg_group *const cg,
 			     const char *const file_name,
 			     const char *const fmt, ...)
 {
 	va_list va;
 	char buf[BUFSIZ];
-	ssize_t len = safe_cgroup_read(file, lineno,
+	ssize_t len = safe_cg_read(file, lineno,
 				       cg, file_name, buf, sizeof(buf));
 	const int conv_cnt = tst_count_scanf_conversions(fmt);
 	int ret = 0;
@@ -1201,14 +1201,14 @@ void safe_cgroup_lines_scanf(const char *const file, const int lineno,
 		 file_name, buf, fmt, ret, conv_cnt);
 }
 
-int safe_cgroup_occursin(const char *const file, const int lineno,
-			 const struct tst_cgroup_group *const cg,
+int safe_cg_occursin(const char *const file, const int lineno,
+			 const struct tst_cg_group *const cg,
 			 const char *const file_name,
 			 const char *const needle)
 {
 	char buf[BUFSIZ];
 
-	safe_cgroup_read(file, lineno, cg, file_name, buf, sizeof(buf));
+	safe_cg_read(file, lineno, cg, file_name, buf, sizeof(buf));
 
 	return !!strstr(buf, needle);
 }
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1fd238cf5..9d96e8a39 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1015,15 +1015,15 @@ static void prepare_device(void)
 
 static void do_cgroup_requires(void)
 {
-	const struct tst_cgroup_opts cg_opts = {
+	const struct tst_cg_opts cg_opts = {
 		.needs_ver = tst_test->needs_cgroup_ver,
 	};
 	const char *const *ctrl_names = tst_test->needs_cgroup_ctrls;
 
 	for (; *ctrl_names; ctrl_names++)
-		tst_cgroup_require(*ctrl_names, &cg_opts);
+		tst_cg_require(*ctrl_names, &cg_opts);
 
-	tst_cgroup_init();
+	tst_cg_init();
 }
 
 static void do_setup(int argc, char *argv[])
@@ -1217,7 +1217,7 @@ static void do_test_setup(void)
 static void do_cleanup(void)
 {
 	if (tst_test->needs_cgroup_ctrls)
-		tst_cgroup_cleanup();
+		tst_cg_cleanup();
 
 	if (ovl_mounted)
 		SAFE_UMOUNT(OVL_MNT);
diff --git a/scripts/coccinelle/cgroup-ver.cocci b/scripts/coccinelle/cgroup-ver.cocci
index fc1d2ec93..0a73e94ea 100644
--- a/scripts/coccinelle/cgroup-ver.cocci
+++ b/scripts/coccinelle/cgroup-ver.cocci
@@ -4,26 +4,26 @@ virtual fix
 expression cg, ctrl;
 @@
 
-- TST_CGROUP_VER(cg, ctrl) == TST_CGROUP_V1
-+ TST_CGROUP_VER_IS_V1(cg, ctrl)
+- TST_CG_VER(cg, ctrl) == TST_CG_V1
++ TST_CG_VER_IS_V1(cg, ctrl)
 
 @@
 expression cg, ctrl;
 @@
 
-- TST_CGROUP_VER(cg, ctrl) != TST_CGROUP_V1
-+ !TST_CGROUP_VER_IS_V1(cg, ctrl)
+- TST_CG_VER(cg, ctrl) != TST_CG_V1
++ !TST_CG_VER_IS_V1(cg, ctrl)
 
 @@
 expression cg, ctrl;
 @@
 
-- TST_CGROUP_VER(cg, ctrl) == TST_CGROUP_V2
-+ !TST_CGROUP_VER_IS_V1(cg, ctrl)
+- TST_CG_VER(cg, ctrl) == TST_CG_V2
++ !TST_CG_VER_IS_V1(cg, ctrl)
 
 @@
 expression cg, ctrl;
 @@
 
-- TST_CGROUP_VER(cg, ctrl) != TST_CGROUP_V2
-+ TST_CGROUP_VER_IS_V1(cg, ctrl)
+- TST_CG_VER(cg, ctrl) != TST_CG_V2
++ TST_CG_VER_IS_V1(cg, ctrl)
diff --git a/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci b/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci
index f91c2c467..de064af39 100644
--- a/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci
+++ b/scripts/coccinelle/kselftest-cgroup-to-ltp.cocci
@@ -3,7 +3,7 @@ expression cgn, cgns;
 @@
 
 - cgn = cg_name(..., cgns);
-+ cgn = tst_cgroup_group_mk(cg_test, cgns);
++ cgn = tst_cg_group_mk(cg_test, cgns);
 
 @@
 expression cg, fname, data;
@@ -12,24 +12,24 @@ expression cg, fname, data;
 - if (cg_write(cg, fname, data)) {
 -    ...
 - }
-+ SAFE_CGROUP_PRINT(cg, fname, data);
++ SAFE_CG_PRINT(cg, fname, data);
 
 @@
 expression cg;
 @@
 
-... when != TST_CGROUP_VER(...)
+... when != TST_CG_VER(...)
 
-- SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
-+ if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
-+    SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
+- SAFE_CG_PRINT(cg, "cgroup.subtree_control", "+memory");
++ if (TST_CG_VER(cg, "memory") != TST_CG_V1)
++    SAFE_CG_PRINT(cg, "cgroup.subtree_control", "+memory");
 
 @@
 expression cg, fname, needle;
 @@
 
 - cg_read_strstr(cg, fname, needle)
-+ !SAFE_CGROUP_OCCURSIN(cg, fname, needle)
++ !SAFE_CG_OCCURSIN(cg, fname, needle)
 
 @@
 identifier l;
@@ -37,4 +37,4 @@ expression cg, fname;
 @@
 
 - l = cg_read_long(cg, fname);
-+ SAFE_CGROUP_SCANF(cg, fname, "%ld", &l);
++ SAFE_CG_SCANF(cg, fname, "%ld", &l);
diff --git a/testcases/kernel/controllers/memcg/memcontrol01.c b/testcases/kernel/controllers/memcg/memcontrol01.c
index 595192437..935b97778 100644
--- a/testcases/kernel/controllers/memcg/memcontrol01.c
+++ b/testcases/kernel/controllers/memcg/memcontrol01.c
@@ -17,46 +17,46 @@
 
 #include "tst_test.h"
 
-static struct tst_cgroup_group *parent, *child;
-static struct tst_cgroup_group *parent2, *child2;
+static struct tst_cg_group *parent, *child;
+static struct tst_cg_group *parent2, *child2;
 
 static void test_memcg_subtree_control(void)
 {
-	parent = tst_cgroup_group_mk(tst_cgroup, "memcg_test_0");
-	child = tst_cgroup_group_mk(parent, "memcg_test_1");
-	parent2 = tst_cgroup_group_mk(tst_cgroup, "memcg_test_2");
-	child2 = tst_cgroup_group_mk(parent2, "memcg_test_3");
+	parent = tst_cg_group_mk(tst_cg, "memcg_test_0");
+	child = tst_cg_group_mk(parent, "memcg_test_1");
+	parent2 = tst_cg_group_mk(tst_cg, "memcg_test_2");
+	child2 = tst_cg_group_mk(parent2, "memcg_test_3");
 
-	SAFE_CGROUP_PRINT(parent2, "cgroup.subtree_control", "-memory");
+	SAFE_CG_PRINT(parent2, "cgroup.subtree_control", "-memory");
 
 	TST_EXP_POSITIVE(
-		SAFE_CGROUP_OCCURSIN(child, "cgroup.controllers", "memory"),
+		SAFE_CG_OCCURSIN(child, "cgroup.controllers", "memory"),
 		"child should have memory controller");
 	TST_EXP_POSITIVE(
-		!SAFE_CGROUP_OCCURSIN(child2, "cgroup.controllers", "memory"),
+		!SAFE_CG_OCCURSIN(child2, "cgroup.controllers", "memory"),
 		"child2 should not have memory controller");
 
-	child2 = tst_cgroup_group_rm(child2);
-	parent2 = tst_cgroup_group_rm(parent2);
-	child = tst_cgroup_group_rm(child);
-	parent = tst_cgroup_group_rm(parent);
+	child2 = tst_cg_group_rm(child2);
+	parent2 = tst_cg_group_rm(parent2);
+	child = tst_cg_group_rm(child);
+	parent = tst_cg_group_rm(parent);
 }
 
 static void cleanup(void)
 {
 	if (child2)
-		child2 = tst_cgroup_group_rm(child2);
+		child2 = tst_cg_group_rm(child2);
 	if (parent2)
-		parent2 = tst_cgroup_group_rm(parent2);
+		parent2 = tst_cg_group_rm(parent2);
 	if (child)
-		child = tst_cgroup_group_rm(child);
+		child = tst_cg_group_rm(child);
 	if (parent)
-		parent = tst_cgroup_group_rm(parent);
+		parent = tst_cg_group_rm(parent);
 }
 
 static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = test_memcg_subtree_control,
-	.needs_cgroup_ver = TST_CGROUP_V2,
+	.needs_cgroup_ver = TST_CG_V2,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 4adb31512..1656176b6 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -26,7 +26,7 @@
 #include "memcontrol_common.h"
 
 static size_t page_size;
-static struct tst_cgroup_group *cg_child;
+static struct tst_cg_group *cg_child;
 static int fd;
 static int file_to_all_error = 10;
 
@@ -36,17 +36,17 @@ static void alloc_anon_50M_check(void)
 	char *buf, *ptr;
 	ssize_t anon, current;
 	const char *const anon_key_fmt =
-		TST_CGROUP_VER_IS_V1(tst_cgroup, "memory") ? "rss %zd" : "anon %zd";
+		TST_CG_VER_IS_V1(tst_cg, "memory") ? "rss %zd" : "anon %zd";
 
 	buf = SAFE_MALLOC(size);
 	for (ptr = buf; ptr < buf + size; ptr += page_size)
 		*ptr = 0;
 
-	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zd", &current);
+	SAFE_CG_SCANF(cg_child, "memory.current", "%zd", &current);
 	TST_EXP_EXPR(current >= size,
 		     "(memory.current=%zd) >= (size=%zd)", current, size);
 
-	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", anon_key_fmt, &anon);
+	SAFE_CG_LINES_SCANF(cg_child, "memory.stat", anon_key_fmt, &anon);
 
 	TST_EXP_EXPR(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
 	TST_EXP_EXPR(values_close(size, anon, 3),
@@ -61,20 +61,20 @@ static void alloc_pagecache_50M_check(void)
 	const size_t size = MB(50);
 	size_t current, file;
 	const char *const file_key_fmt =
-		TST_CGROUP_VER_IS_V1(tst_cgroup, "memory") ? "cache %zd" : "file %zd";
+		TST_CG_VER_IS_V1(tst_cg, "memory") ? "cache %zd" : "file %zd";
 
 	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
 
-	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
+	SAFE_CG_SCANF(cg_child, "memory.current", "%zu", &current);
 	tst_res(TINFO, "Created temp file: memory.current=%zu", current);
 
 	alloc_pagecache(fd, size);
 
-	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
+	SAFE_CG_SCANF(cg_child, "memory.current", "%zu", &current);
 	TST_EXP_EXPR(current >= size,
 			 "(memory.current=%zu) >= (size=%zu)", current, size);
 
-	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", file_key_fmt, &file);
+	SAFE_CG_LINES_SCANF(cg_child, "memory.stat", file_key_fmt, &file);
 	TST_EXP_EXPR(file > 0, "(memory.stat.file=%zd) > 0", file);
 
 	TST_EXP_EXPR(values_close(file, current, file_to_all_error),
@@ -88,14 +88,14 @@ static void test_memcg_current(unsigned int n)
 {
 	size_t current;
 
-	cg_child = tst_cgroup_group_mk(tst_cgroup, "child");
-	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
+	cg_child = tst_cg_group_mk(tst_cg, "child");
+	SAFE_CG_SCANF(cg_child, "memory.current", "%zu", &current);
 	TST_EXP_EXPR(current == 0, "(current=%zu) == 0", current);
 
 	if (!SAFE_FORK()) {
-		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+		SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-		SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
+		SAFE_CG_SCANF(cg_child, "memory.current", "%zu", &current);
 		tst_res(TINFO, "Added proc to memcg: memory.current=%zu",
 			current);
 
@@ -105,7 +105,7 @@ static void test_memcg_current(unsigned int n)
 			alloc_pagecache_50M_check();
 	} else {
 		tst_reap_children();
-		cg_child = tst_cgroup_group_rm(cg_child);
+		cg_child = tst_cg_group_rm(cg_child);
 	}
 }
 
@@ -125,7 +125,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (cg_child)
-		cg_child = tst_cgroup_group_rm(cg_child);
+		cg_child = tst_cg_group_rm(cg_child);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 1c14d6766..bc726f395 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -44,8 +44,8 @@
 
 #define TMPDIR "mntdir"
 
-static struct tst_cgroup_group *trunk_cg[3];
-static struct tst_cgroup_group *leaf_cg[4];
+static struct tst_cg_group *trunk_cg[3];
+static struct tst_cg_group *leaf_cg[4];
 static int fd = -1;
 
 enum checkpoints {
@@ -84,28 +84,28 @@ static void cleanup_sub_groups(void)
 		if (!leaf_cg[i - 1])
 			continue;
 
-		leaf_cg[i - 1] = tst_cgroup_group_rm(leaf_cg[i - 1]);
+		leaf_cg[i - 1] = tst_cg_group_rm(leaf_cg[i - 1]);
 	}
 
 	for (i = ARRAY_SIZE(trunk_cg); i > 0; i--) {
 		if (!trunk_cg[i - 1])
 			continue;
 
-		trunk_cg[i - 1] = tst_cgroup_group_rm(trunk_cg[i - 1]);
+		trunk_cg[i - 1] = tst_cg_group_rm(trunk_cg[i - 1]);
 	}
 }
 
-static void alloc_anon_in_child(const struct tst_cgroup_group *const cg,
+static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 				const size_t size, const int expect_oom)
 {
 	int status;
 	const pid_t pid = SAFE_FORK();
 
 	if (!pid) {
-		SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
 		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
-		getpid(), tst_cgroup_group_name(cg), size);
+		getpid(), tst_cg_group_name(cg), size);
 		alloc_anon(size);
 		exit(0);
 	}
@@ -129,7 +129,7 @@ static void alloc_anon_in_child(const struct tst_cgroup_group *const cg,
 		tst_strstatus(status));
 }
 
-static void alloc_pagecache_in_child(const struct tst_cgroup_group *const cg,
+static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 				     const size_t size)
 {
 	const pid_t pid = SAFE_FORK();
@@ -139,10 +139,10 @@ static void alloc_pagecache_in_child(const struct tst_cgroup_group *const cg,
 		return;
 	}
 
-	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
 	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
-		getpid(), tst_cgroup_group_name(cg), size);
+		getpid(), tst_cg_group_name(cg), size);
 	alloc_pagecache(fd, size);
 
 	TST_CHECKPOINT_WAKE(CHILD_IDLE);
@@ -157,27 +157,27 @@ static void test_memcg_min(void)
 	size_t attempts;
 
 	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
-	trunk_cg[A] = tst_cgroup_group_mk(tst_cgroup, "trunk_A");
+	trunk_cg[A] = tst_cg_group_mk(tst_cg, "trunk_A");
 
-	SAFE_CGROUP_SCANF(trunk_cg[A], "memory.min", "%ld", c);
+	SAFE_CG_SCANF(trunk_cg[A], "memory.min", "%ld", c);
 	if (c[0]) {
 		tst_brk(TCONF,
 			"memory.min already set to %ld on parent group", c[0]);
 	}
 
-	SAFE_CGROUP_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
+	SAFE_CG_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
 
-	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.max", "200M");
-	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.swap.max", "0");
+	SAFE_CG_PRINT(trunk_cg[A], "memory.max", "200M");
+	SAFE_CG_PRINT(trunk_cg[A], "memory.swap.max", "0");
 
-	trunk_cg[B] = tst_cgroup_group_mk(trunk_cg[A], "trunk_B");
+	trunk_cg[B] = tst_cg_group_mk(trunk_cg[A], "trunk_B");
 
-	SAFE_CGROUP_PRINT(trunk_cg[B], "cgroup.subtree_control", "+memory");
+	SAFE_CG_PRINT(trunk_cg[B], "cgroup.subtree_control", "+memory");
 
-	trunk_cg[G] = tst_cgroup_group_mk(trunk_cg[A], "trunk_G");
+	trunk_cg[G] = tst_cg_group_mk(trunk_cg[A], "trunk_G");
 
 	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
-		leaf_cg[i] = tst_cgroup_group_mk(trunk_cg[B],
+		leaf_cg[i] = tst_cg_group_mk(trunk_cg[B],
 						 "leaf_%c", 'C' + i);
 
 		if (i == E)
@@ -186,15 +186,15 @@ static void test_memcg_min(void)
 		alloc_pagecache_in_child(leaf_cg[i], MB(50));
 	}
 
-	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.min", "50M");
-	SAFE_CGROUP_PRINT(trunk_cg[B], "memory.min", "50M");
-	SAFE_CGROUP_PRINT(leaf_cg[C], "memory.min", "75M");
-	SAFE_CGROUP_PRINT(leaf_cg[D], "memory.min", "25M");
-	SAFE_CGROUP_PRINT(leaf_cg[E], "memory.min", "500M");
-	SAFE_CGROUP_PRINT(leaf_cg[F], "memory.min", "0");
+	SAFE_CG_PRINT(trunk_cg[A], "memory.min", "50M");
+	SAFE_CG_PRINT(trunk_cg[B], "memory.min", "50M");
+	SAFE_CG_PRINT(leaf_cg[C], "memory.min", "75M");
+	SAFE_CG_PRINT(leaf_cg[D], "memory.min", "25M");
+	SAFE_CG_PRINT(leaf_cg[E], "memory.min", "500M");
+	SAFE_CG_PRINT(leaf_cg[F], "memory.min", "0");
 
 	for (attempts = 0; attempts < 5; attempts++) {
-		SAFE_CGROUP_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+		SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
 		if (values_close(c[0], MB(150), 3))
 			break;
 
@@ -203,12 +203,12 @@ static void test_memcg_min(void)
 
 	alloc_anon_in_child(trunk_cg[G], MB(148), 0);
 
-	SAFE_CGROUP_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
 	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
 		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
 
 	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
-		SAFE_CGROUP_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
+		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
 
 	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
 		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
@@ -219,7 +219,7 @@ static void test_memcg_min(void)
 
 	alloc_anon_in_child(trunk_cg[G], MB(170), 1);
 
-	SAFE_CGROUP_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
 	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
 		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
 
@@ -248,6 +248,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
-	.needs_cgroup_ver = TST_CGROUP_V2,
+	.needs_cgroup_ver = TST_CG_V2,
 	.needs_cgroup_ctrls = (const char *const[]){ "memory", NULL },
 };
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 6383187d7..6e9691edb 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -51,10 +51,10 @@ static void test_cpuset(void)
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	char buf[BUFSIZ];
 
-	SAFE_CGROUP_READ(tst_cgroup, "cpuset.cpus", buf, sizeof(buf));
-	SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.cpus", buf);
-	SAFE_CGROUP_READ(tst_cgroup, "cpuset.mems", buf, sizeof(buf));
-	SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.mems", buf);
+	SAFE_CG_READ(tst_cg, "cpuset.cpus", buf, sizeof(buf));
+	SAFE_CG_PRINT(tst_cg, "cpuset.cpus", buf);
+	SAFE_CG_READ(tst_cg, "cpuset.mems", buf, sizeof(buf));
+	SAFE_CG_PRINT(tst_cg, "cpuset.mems", buf);
 
 	child = SAFE_FORK();
 	if (child == 0) {
@@ -68,8 +68,8 @@ static void test_cpuset(void)
 		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
 	}
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cpuset.mems", "%d", nodes[0]);
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cpuset.mems", "%d", nodes[1]);
+	SAFE_CG_PRINTF(tst_cg, "cpuset.mems", "%d", nodes[0]);
+	SAFE_CG_PRINTF(tst_cg, "cpuset.mems", "%d", nodes[1]);
 
 	tst_reap_children();
 
@@ -84,7 +84,7 @@ static void setup(void)
 	if (nnodes <= 1)
 		tst_brk(TCONF, "requires a NUMA system.");
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 }
 
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 47a180d7e..f1cba5fcb 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -65,7 +65,7 @@ void check_hugepage(void);
 void write_memcg(void);
 
 /* cpuset/memcg - include/tst_cgroup.h */
-void write_cpusets(const struct tst_cgroup_group *cg, long nd);
+void write_cpusets(const struct tst_cg_group *cg, long nd);
 
 /* shared */
 unsigned int get_a_numa_node(void);
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 2a890f025..76a87c6b1 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -76,10 +76,10 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(tst_cgroup, node);
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	write_cpusets(tst_cg, node);
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	create_same_memory(size, num, unit);
-	SAFE_CGROUP_PRINTF(tst_cgroup_drain, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 03fad2ee2..6a0566f43 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -77,8 +77,8 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 683780907..77fafa641 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -67,7 +67,7 @@ static void verify_ksm(void)
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 		if (errno != ENOSYS)
@@ -78,7 +78,7 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(tst_cgroup, node);
+	write_cpusets(tst_cg, node);
 	create_same_memory(size, num, unit);
 }
 
@@ -102,7 +102,7 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index a4bede0df..99d5f7f53 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -632,11 +632,11 @@ static void gather_node_cpus(char *cpus, long nd)
 	cpus[strlen(cpus) - 1] = '\0';
 }
 
-void write_cpusets(const struct tst_cgroup_group *cg, long nd)
+void write_cpusets(const struct tst_cg_group *cg, long nd)
 {
 	char cpus[BUFSIZ] = "";
 
-	SAFE_CGROUP_PRINTF(cg, "cpuset.mems", "%ld", nd);
+	SAFE_CG_PRINTF(cg, "cpuset.mems", "%ld", nd);
 
 	gather_node_cpus(cpus, nd);
 	/*
@@ -645,11 +645,11 @@ void write_cpusets(const struct tst_cgroup_group *cg, long nd)
 	 * the value of cpuset.cpus.
 	 */
 	if (strlen(cpus) != 0) {
-		SAFE_CGROUP_PRINT(cg, "cpuset.cpus", cpus);
+		SAFE_CG_PRINT(cg, "cpuset.cpus", cpus);
 	} else {
 		tst_res(TINFO, "No CPUs in the node%ld; "
 				"using only CPU0", nd);
-		SAFE_CGROUP_PRINT(cg, "cpuset.cpus", "0");
+		SAFE_CG_PRINT(cg, "cpuset.cpus", "0");
 	}
 }
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 8b4fb47c7..48a0f20b5 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -43,7 +43,7 @@ static void verify_oom(void)
 #endif
 	testoom(0, 0, ENOMEM, 1);
 
-	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max")) {
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
 		tst_res(TINFO, "OOM on MEMCG with special memswap limitation:");
 		/*
 		 * Cgroup v2 tracks memory and swap in separate, which splits
@@ -55,17 +55,17 @@ static void verify_oom(void)
 		 * let's scale down the value of 'memory.swap.max' to only
 		 * 1MB for CGroup v2.
 		 */
-		if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", MB);
+		if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", MB);
 		else
-			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", TESTMEM + MB);
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TESTMEM + MB);
 
 		testoom(0, 1, ENOMEM, 1);
 
-		if (TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", ~0UL);
+		if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", ~0UL);
 		else
-			SAFE_CGROUP_PRINT(tst_cgroup, "memory.swap.max", "max");
+			SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
 	}
 
 	/* OOM for MEMCG with mempolicy */
@@ -82,8 +82,8 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 8e8902b76..6b65383a3 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -45,13 +45,13 @@ static void verify_oom(void)
 	testoom(0, 0, ENOMEM, 1);
 
 	if (is_numa(NULL, NH_MEMS, 2) &&
-	    SAFE_CGROUP_HAS(tst_cgroup, "cpuset.memory_migrate")) {
+	    SAFE_CG_HAS(tst_cg, "cpuset.memory_migrate")) {
 		/*
 		 * Under NUMA system, the migration of cpuset's memory
 		 * is in charge of cpuset.memory_migrate, we can write
 		 * 1 to cpuset.memory_migrate to enable the migration.
 		 */
-		SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.memory_migrate", "1");
+		SAFE_CG_PRINT(tst_cg, "cpuset.memory_migrate", "1");
 
 		tst_res(TINFO, "OOM on CPUSET with mem migrate:");
 		testoom(0, 0, ENOMEM, 1);
@@ -78,8 +78,8 @@ static void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(tst_cgroup, memnode);
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	write_cpusets(tst_cg, memnode);
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index ca60f1101..91c9bec83 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -51,29 +51,29 @@ static void verify_oom(void)
 	 * 1 to cpuset.memory_migrate to enable the migration.
 	 */
 	if (is_numa(NULL, NH_MEMS, 2) &&
-	    SAFE_CGROUP_HAS(tst_cgroup, "cpuset.memory_migrate")) {
-		SAFE_CGROUP_PRINT(tst_cgroup, "cpuset.memory_migrate", "1");
+	    SAFE_CG_HAS(tst_cg, "cpuset.memory_migrate")) {
+		SAFE_CG_PRINT(tst_cg, "cpuset.memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"cpuset.memory_migrate=1");
 		testoom(0, 0, ENOMEM, 1);
 	}
 
-	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max")) {
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
-		if (!TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", MB);
+		if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", MB);
 		else
-			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", TESTMEM + MB);
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TESTMEM + MB);
 
 		testoom(0, 1, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-		if (TST_CGROUP_VER_IS_V1(tst_cgroup, "memory"))
-			SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%lu", ~0UL);
+		if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", ~0UL);
 		else
-			SAFE_CGROUP_PRINT(tst_cgroup, "memory.swap.max", "max");
+			SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
 		testoom(0, 0, ENOMEM, 1);
 	}
 }
@@ -99,9 +99,9 @@ void setup(void)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
 
-	write_cpusets(tst_cgroup, memnode);
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%lu", TESTMEM);
+	write_cpusets(tst_cg, memnode);
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index 2c28b83a2..a24dccc4e 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -31,37 +31,37 @@
 #include "tst_test.h"
 #include "tst_timer.h"
 
-static struct tst_cgroup_group *cg_level2, *cg_level3a, *cg_level3b;
-static struct tst_cgroup_group *cg_workers[3];
+static struct tst_cg_group *cg_level2, *cg_level3a, *cg_level3b;
+static struct tst_cg_group *cg_workers[3];
 static int may_have_waiters = 0;
 
-static void set_cpu_quota(const struct tst_cgroup_group *const cg,
+static void set_cpu_quota(const struct tst_cg_group *const cg,
 			  const float quota_percent)
 {
 	const unsigned int period_us = 10000;
 	const unsigned int quota_us = (quota_percent / 100) * (float)period_us;
 
-	if (!TST_CGROUP_VER_IS_V1(cg, "cpu")) {
-		SAFE_CGROUP_PRINTF(cg, "cpu.max",
+	if (!TST_CG_VER_IS_V1(cg, "cpu")) {
+		SAFE_CG_PRINTF(cg, "cpu.max",
 				   "%u %u", quota_us, period_us);
 	} else {
-		SAFE_CGROUP_PRINTF(cg, "cpu.cfs_period_us",
+		SAFE_CG_PRINTF(cg, "cpu.cfs_period_us",
 				  "%u", period_us);
-		SAFE_CGROUP_PRINTF(cg, "cpu.max",
+		SAFE_CG_PRINTF(cg, "cpu.max",
 				   "%u", quota_us);
 	}
 
 	tst_res(TINFO, "Set '%s/cpu.max' = '%d %d'",
-		tst_cgroup_group_name(cg), quota_us, period_us);
+		tst_cg_group_name(cg), quota_us, period_us);
 }
 
-static void mk_cpu_cgroup(struct tst_cgroup_group **cg,
-			  const struct tst_cgroup_group *const cg_parent,
+static void mk_cpu_cgroup(struct tst_cg_group **cg,
+			  const struct tst_cg_group *const cg_parent,
 			  const char *const cg_child_name,
 			  const float quota_percent)
 
 {
-	*cg = tst_cgroup_group_mk(cg_parent, "%s", cg_child_name);
+	*cg = tst_cg_group_mk(cg_parent, "%s", cg_child_name);
 
 	set_cpu_quota(*cg, quota_percent);
 }
@@ -83,7 +83,7 @@ static void busy_loop(const unsigned int sleep_ms)
 	}
 }
 
-static void fork_busy_procs_in_cgroup(const struct tst_cgroup_group *const cg)
+static void fork_busy_procs_in_cgroup(const struct tst_cg_group *const cg)
 {
 	const unsigned int sleeps_ms[] = {3000, 1000, 10};
 	const pid_t worker_pid = SAFE_FORK();
@@ -98,7 +98,7 @@ static void fork_busy_procs_in_cgroup(const struct tst_cgroup_group *const cg)
 		if (!busy_pid)
 			busy_loop(sleeps_ms[i]);
 
-		SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", busy_pid);
+		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", busy_pid);
 	}
 
 	tst_reap_children();
@@ -131,13 +131,13 @@ static void do_test(void)
 
 static void setup(void)
 {
-	cg_level2 = tst_cgroup_group_mk(tst_cgroup, "level2");
+	cg_level2 = tst_cg_group_mk(tst_cg, "level2");
 
-	cg_level3a = tst_cgroup_group_mk(cg_level2, "level3a");
+	cg_level3a = tst_cg_group_mk(cg_level2, "level3a");
 	mk_cpu_cgroup(&cg_workers[0], cg_level3a, "worker1", 30);
 	mk_cpu_cgroup(&cg_workers[1], cg_level3a, "worker2", 20);
 
-	cg_level3b = tst_cgroup_group_mk(cg_level2, "level3b");
+	cg_level3b = tst_cg_group_mk(cg_level2, "level3b");
 	mk_cpu_cgroup(&cg_workers[2], cg_level3b, "worker3", 30);
 }
 
@@ -153,15 +153,15 @@ static void cleanup(void)
 
 	for (i = 0; i < ARRAY_SIZE(cg_workers); i++) {
 		if (cg_workers[i])
-			cg_workers[i] = tst_cgroup_group_rm(cg_workers[i]);
+			cg_workers[i] = tst_cg_group_rm(cg_workers[i]);
 	}
 
 	if (cg_level3a)
-		cg_level3a = tst_cgroup_group_rm(cg_level3a);
+		cg_level3a = tst_cg_group_rm(cg_level3a);
 	if (cg_level3b)
-		cg_level3b = tst_cgroup_group_rm(cg_level3b);
+		cg_level3b = tst_cg_group_rm(cg_level3b);
 	if (cg_level2)
-		cg_level2 = tst_cgroup_group_rm(cg_level2);
+		cg_level2 = tst_cg_group_rm(cg_level2);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index a2f32f733..54391db28 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -70,10 +70,10 @@ static void print_cgmem(const char *name)
 {
 	long ret;
 
-	if (!SAFE_CGROUP_HAS(tst_cgroup, name))
+	if (!SAFE_CG_HAS(tst_cg, name))
 		return;
 
-	SAFE_CGROUP_SCANF(tst_cgroup, name, "%ld", &ret);
+	SAFE_CG_SCANF(tst_cg, name, "%ld", &ret);
 	tst_res(TINFO, "\t%s: %ld Kb", name, ret / 1024);
 }
 
@@ -118,18 +118,18 @@ static void setup(void)
 	check_path("/proc/self/oom_score_adj");
 	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "memory.max", "%ld", MEM_LIMIT);
-	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swap.max"))
-		SAFE_CGROUP_PRINTF(tst_cgroup, "memory.swap.max", "%ld", MEMSW_LIMIT);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%ld", MEM_LIMIT);
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%ld", MEMSW_LIMIT);
 
-	if (SAFE_CGROUP_HAS(tst_cgroup, "memory.swappiness")) {
-		SAFE_CGROUP_PRINT(tst_cgroup, "memory.swappiness", "60");
+	if (SAFE_CG_HAS(tst_cg, "memory.swappiness")) {
+		SAFE_CG_PRINT(tst_cg, "memory.swappiness", "60");
 	} else {
 		check_path("/proc/sys/vm/swappiness");
 		SAFE_FILE_PRINTF("/proc/sys/vm/swappiness", "%d", 60);
 	}
 
-	SAFE_CGROUP_PRINTF(tst_cgroup, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
 	meminfo_diag("Initial meminfo, later values are relative to this (except memcg)");
 	init_swap = SAFE_READ_MEMINFO("SwapTotal:") - SAFE_READ_MEMINFO("SwapFree:");
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
