Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECC606A32D
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KaV4kot6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE63D3C9AC2
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:00:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D00C3C265A
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:59:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B7061000372
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792573185; x=1824109185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ghJi4a2+iW5XD210qc7ND5RARziA0aS4oXp9THbQtrA=;
 b=KaV4kot6P9P5cFUK5JAnD1bB/pvEZn+ZdS4VMejoNPo+Oknn6AHA7uNy
 KyHmnMRUrFTd1SXJ7LxQ0EzbTmkvqMZAGBYm+eM0GO/eD2q7P4AHxK7/3
 85dGyMBRt8zMajJgMXwAW7G0GQUFGBlKRlP25Qo9AJkXwUmiesrFb5mvZ
 zr1HidMLkQv2GpXJZwwRiDAjxh2aI77R+aE+eGXWM+09WJEuxpbQ2HLKo
 5CYtMPO7M7UdEU/F/S8ygXYLPTEjo86M+5+tNeJOVEygRWK0AILDuRro9
 rWakkuROXR/pkyII0S7YcqPJBurvqLHmCkT+heeXs0TYbGSl2D4oMpb5Y w==;
X-CSE-ConnectionGUID: VD7ahEOGRhWFfuGTNcwc9w==
X-CSE-MsgGUID: qA7gd6kVRnejTH31pwB4cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1167133"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1167133"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:59:42 -0700
X-CSE-ConnectionGUID: c3gf8nWHR+O/lgc613u79g==
X-CSE-MsgGUID: hxgwXSR8Q9iKVnmQSCSDEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3033336"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:59:40 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 10:59:30 +0200
Message-ID: <20261021085932.20557-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021085932.20557-1-piotr.kubaj@intel.com>
References: <20261021085932.20557-1-piotr.kubaj@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] lib: add tst_test.needs_debugfs flag
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests reading debugfs files each carry the same statfs() and mount()
dance, because /sys/kernel/debug exists as a plain sysfs directory even
when debugfs is not mounted on it, so checking for the path is not
enough.

With needs_debugfs set the library mounts debugfs during setup, exits
with TCONF if it cannot, and unmounts it at the end only if it did the
mount. The flag implies needs_root. Add TST_DEBUGFS_PATH for tests to
build their paths from, register the flag in the metadata parser and add
a lib/newlib_tests self-test.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 doc/developers/writing_tests.rst     |  3 +++
 include/tst_fs.h                     |  6 +++++
 include/tst_test.h                   |  8 ++++++
 lib/newlib_tests/.gitignore          |  1 +
 lib/newlib_tests/runtest.sh          |  1 +
 lib/newlib_tests/tst_needs_debugfs.c | 32 +++++++++++++++++++++++
 lib/tst_test.c                       | 38 ++++++++++++++++++++++++++++
 metadata/metaparse.c                 |  1 +
 8 files changed, 90 insertions(+)
 create mode 100644 lib/newlib_tests/tst_needs_debugfs.c

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 9a56c0265..5d08cd907 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -448,6 +448,9 @@ shell API. For tests using the new shell loader library, see
     * - .needs_cpu_vendor
       - \-
 
+    * - .needs_debugfs
+      - \-
+
     * - .needs_devfs
       - \-
 
diff --git a/include/tst_fs.h b/include/tst_fs.h
index 80eb1292e..278bbab17 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -8,6 +8,7 @@
 
 /* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
 #define TST_BTRFS_MAGIC    0x9123683E
+#define TST_DEBUGFS_MAGIC  0x64626720
 #define TST_NFS_MAGIC      0x6969
 #define TST_RAMFS_MAGIC    0x858458f6
 #define TST_TMPFS_MAGIC    0x01021994
@@ -58,6 +59,11 @@ enum {
 #define OVL_WORK	OVL_BASE_MNTPOINT"/work"
 #define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
 
+/**
+ * TST_DEBUGFS_PATH - Where debugfs is mounted by tst_test.needs_debugfs.
+ */
+#define TST_DEBUGFS_PATH "/sys/kernel/debug"
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
diff --git a/include/tst_test.h b/include/tst_test.h
index 80b46f9b1..9e464ea85 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -358,6 +358,13 @@ struct tst_fs {
  *               needed for tests that need to create device files since tmpfs
  *               at /tmp is usually mounted with 'nodev' option.
  *
+ * @needs_debugfs: If set debugfs is mounted at TST_DEBUGFS_PATH i.e.
+ *                 /sys/kernel/debug, unless it is mounted there already, and
+ *                 the test exits with TCONF if it cannot be. The library
+ *                 unmounts it at the end of the test if it mounted it. Both
+ *                 mounting debugfs and reading its content require root, so
+ *                 the flag implies tst_test.needs_root.
+ *
  * @restore_wallclock: Saves wall clock at the start of the test and restores
  *                     it at the end with the help of monotonic timers.
  *                     Testcases that modify system wallclock use this to
@@ -576,6 +583,7 @@ struct tst_fs {
 	unsigned int child_needs_reinit:1;
 	unsigned int runs_script:1;
 	unsigned int needs_devfs:1;
+	unsigned int needs_debugfs:1;
 	unsigned int restore_wallclock:1;
 
 	unsigned int all_filesystems:1;
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 3a6e1643c..24008fa5c 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -59,6 +59,7 @@ tst_needs_cmds05
 tst_needs_cmds06
 tst_needs_cmds07
 tst_needs_cmds08
+tst_needs_debugfs
 test_runtime01
 test_runtime02
 test_children_cleanup
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b..1a51d8b7a 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -27,6 +27,7 @@ tst_expiration_timer
 tst_filesystems01
 tst_fuzzy_sync0[1-3]
 tst_needs_cmds0[1-36-8]
+tst_needs_debugfs
 tst_res_hexd
 tst_safe_sscanf
 tst_strstatus}"
diff --git a/lib/newlib_tests/tst_needs_debugfs.c b/lib/newlib_tests/tst_needs_debugfs.c
new file mode 100644
index 000000000..7689665a4
--- /dev/null
+++ b/lib/newlib_tests/tst_needs_debugfs.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
+ */
+
+/*
+ * Test that tst_test.needs_debugfs gets debugfs mounted for the test.
+ *
+ * Run it both with debugfs mounted and with it unmounted, it has to pass either
+ * way. In the latter case the library reports mounting debugfs and has to leave
+ * it unmounted once the test is over.
+ */
+
+#include <sys/vfs.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	struct statfs sfs;
+
+	SAFE_STATFS(TST_DEBUGFS_PATH, &sfs);
+
+	if (sfs.f_type == TST_DEBUGFS_MAGIC)
+		tst_res(TPASS, "debugfs is mounted at %s", TST_DEBUGFS_PATH);
+	else
+		tst_res(TFAIL, "debugfs is not mounted at %s", TST_DEBUGFS_PATH);
+}
+
+static struct tst_test test = {
+	.needs_debugfs = 1,
+	.test_all = run,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 10ff73397..a42d3f462 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <sys/mount.h>
 #include <sys/types.h>
+#include <sys/vfs.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <math.h>
@@ -81,6 +82,7 @@ struct context {
 	tst_atomic_t abort_flag;
 	uint32_t mntpoint_mounted:1;
 	uint32_t ovl_mounted:1;
+	uint32_t debugfs_mounted:1;
 	uint32_t tdebug;
 };
 
@@ -1224,6 +1226,31 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 	}
 }
 
+static void mount_debugfs(void)
+{
+	struct statfs sfs;
+
+	/*
+	 * TST_DEBUGFS_PATH exists as a plain sysfs directory whenever
+	 * CONFIG_DEBUG_FS is enabled, whether or not debugfs is mounted on it,
+	 * so the filesystem type has to be checked rather than the directory
+	 * being present.
+	 */
+	if (statfs(TST_DEBUGFS_PATH, &sfs))
+		tst_brk(TCONF | TERRNO, "Can't statfs %s", TST_DEBUGFS_PATH);
+
+	if (sfs.f_type == TST_DEBUGFS_MAGIC)
+		return;
+
+	if (mount("debugfs", TST_DEBUGFS_PATH, "debugfs", 0, NULL)) {
+		tst_brk(TCONF | TERRNO, "Can't mount debugfs at %s",
+			TST_DEBUGFS_PATH);
+	}
+
+	tst_res(TINFO, "Mounted debugfs at %s", TST_DEBUGFS_PATH);
+	context->debugfs_mounted = 1;
+}
+
 static void prepare_and_mount_hugetlb_fs(void)
 {
 	if (access(PATH_MM_HUGEPAGES, F_OK))
@@ -1474,6 +1501,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
+	if (tst_test->needs_debugfs)
+		tst_test->needs_root = 1;
+
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
@@ -1565,6 +1595,9 @@ static void do_setup(int argc, char *argv[])
 			"Two or more of needs_{rofs, devfs, device, hugetlbfs} are set");
 	}
 
+	if (tst_test->needs_debugfs)
+		mount_debugfs();
+
 	if (tst_test->needs_devfs)
 		prepare_and_mount_dev_fs(tst_test->mntpoint);
 
@@ -1676,6 +1709,11 @@ static void do_cleanup(void)
 	if (context->mntpoint_mounted)
 		tst_umount(tst_test->mntpoint);
 
+	if (context->debugfs_mounted) {
+		tst_umount(TST_DEBUGFS_PATH);
+		context->debugfs_mounted = 0;
+	}
+
 	if (tst_test->needs_device && tdev.dev)
 		tst_release_device(tdev.dev);
 
diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index cb141c383..7f2c09037 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -1169,6 +1169,7 @@ static struct typemap tst_test_typemap[] = {
 	{.id = "child_needs_reinit", .type = DATA_BOOL},
 	{.id = "runs_script", .type = DATA_BOOL},
 	{.id = "needs_devfs", .type = DATA_BOOL},
+	{.id = "needs_debugfs", .type = DATA_BOOL},
 	{.id = "restore_wallclock", .type = DATA_BOOL},
 	{.id = "all_filesystems", .type = DATA_BOOL},
 	{.id = "skip_in_lockdown", .type = DATA_BOOL},
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
