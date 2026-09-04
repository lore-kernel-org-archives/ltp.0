Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82699C61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:41:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E8B3E4B68
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:41:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 429833E1D87
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:41:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3CC831000F39
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788525659; x=1820061659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pM8/bp0AaY30oVffttVwVhPMij5nuZGc6r33/i9hmtQ=;
 b=PwNYz7DW93qll2Pyhi6EhMAi3y4an6FgWwuQI7KwbEqLdwAw8Ip7MxNH
 ebDk2VzxGPT+0QNaGYqSdEer8zhHICKUCXpCkGS+Tk4jhDq3ycxMND5jf
 mKLUop3zNN6++j514niBZeEGlP7IF/QSKvh8EPZ4+2ro4zOVlTjqdrmWL
 6frw0uW+XnY6RKCKPDyIGwnxcZcpq5vA1iYZC20KiJAF2C99aOzn/DYC3
 P7h0QKJz9W4kjOCmbQ4fmnhDe64czphiIeaifhqCXTWJ+OIhir/FbB/jk
 BVKgiYXPweL/5JA5b82ZcvKJdYDD3F2tPXeRfC5rpAqDTDoJCCXJ98Ml+ A==;
X-CSE-ConnectionGUID: x4vvEJ7rRrWZe4+Uv3mDHQ==
X-CSE-MsgGUID: c8/PaP/2Q0OIc6wyofzTzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106544227"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="106544227"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:40:58 -0700
X-CSE-ConnectionGUID: oHfQD5BORT2lfQWmW+qWEw==
X-CSE-MsgGUID: qFNmNyLwSnyMoMzodHiPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="266780771"
Received: from pkubaj-desk.igk.intel.com (HELO intel.com) ([10.237.142.111])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:40:57 -0700
From: Piotr Kubaj <piotr.kubaj@intel.com>
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 14:40:40 +0200
Message-ID: <20260904124042.212065-2-piotr.kubaj@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124042.212065-1-piotr.kubaj@intel.com>
References: <20260904124042.212065-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib: add tst_test.needs_debugfs flag
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests that read debugfs files have to check that debugfs is mounted at
/sys/kernel/debug and mount it when it is not. The mount point exists as
a plain sysfs directory whenever CONFIG_DEBUG_FS is enabled, whether or
not debugfs is mounted on it, so a test that only checks that the path is
there reports the platform as unsupported when debugfs simply is not
mounted, and each test ends up carrying the same statfs() and mount()
dance.

Move it into the library: with tst_test.needs_debugfs set the library
mounts debugfs during setup, exits with TCONF if it cannot, and unmounts
it at the end of the test if it was the one that mounted it. Add
TST_DEBUGFS_PATH so that tests build their paths from the library
constant, register the flag in the metadata parser, and add a
lib/newlib_tests self-test that covers both the mounted and the unmounted
case.

Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
---
 doc/developers/writing_tests.rst     |  3 +++
 include/tst_fs.h                     |  4 +++
 include/tst_test.h                   |  8 ++++++
 lib/newlib_tests/.gitignore          |  1 +
 lib/newlib_tests/runtest.sh          |  1 +
 lib/newlib_tests/tst_needs_debugfs.c | 37 ++++++++++++++++++++++++++++
 lib/tst_test.c                       | 35 ++++++++++++++++++++++++++
 metadata/metaparse.c                 |  1 +
 8 files changed, 90 insertions(+)
 create mode 100644 lib/newlib_tests/tst_needs_debugfs.c

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 992374f8b..20b5b5088 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -429,6 +429,9 @@ LTP C And Shell Test API Comparison
     * - .needs_cmds
       - TST_NEEDS_CMDS
 
+    * - .needs_debugfs
+      - \-
+
     * - .needs_devfs
       - \-
 
diff --git a/include/tst_fs.h b/include/tst_fs.h
index ceae78e7e..d7353dbb2 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -8,6 +8,7 @@
 
 /* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
 #define TST_BTRFS_MAGIC    0x9123683E
+#define TST_DEBUGFS_MAGIC  0x64626720
 #define TST_NFS_MAGIC      0x6969
 #define TST_RAMFS_MAGIC    0x858458f6
 #define TST_TMPFS_MAGIC    0x01021994
@@ -57,6 +58,9 @@ enum {
 #define OVL_WORK	OVL_BASE_MNTPOINT"/work"
 #define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
 
+/* Where debugfs is mounted by the tst_test.needs_debugfs flag */
+#define TST_DEBUGFS_PATH "/sys/kernel/debug"
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
diff --git a/include/tst_test.h b/include/tst_test.h
index ddfe9d4d6..905fe0d0f 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -352,6 +352,13 @@ struct tst_fs {
  *               needed for tests that need to create device files since tmpfs
  *               at /tmp is usually mounted with 'nodev' option.
  *
+ * @needs_debugfs: If set debugfs is mounted at TST_DEBUGFS_PATH i.e.
+ *                 /sys/kernel/debug, unless it is mounted there already, and
+ *                 the test exits with TCONF if it cannot be. The library
+ *                 unmounts it at the end of the test if it mounted it. Note
+ *                 that both mounting debugfs and reading its content require
+ *                 root, so tests using this also set tst_test.needs_root.
+ *
  * @restore_wallclock: Saves wall clock at the start of the test and restores
  *                     it at the end with the help of monotonic timers.
  *                     Testcases that modify system wallclock use this to
@@ -561,6 +568,7 @@ struct tst_fs {
 	unsigned int child_needs_reinit:1;
 	unsigned int runs_script:1;
 	unsigned int needs_devfs:1;
+	unsigned int needs_debugfs:1;
 	unsigned int restore_wallclock:1;
 
 	unsigned int all_filesystems:1;
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 1586e0ad6..794e61453 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -60,6 +60,7 @@ tst_needs_cmds05
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
index 000000000..fd6adf7a5
--- /dev/null
+++ b/lib/newlib_tests/tst_needs_debugfs.c
@@ -0,0 +1,37 @@
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
+	.needs_root = 1,
+	.needs_debugfs = 1,
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_DEBUG_FS",
+		NULL
+	},
+	.test_all = run,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 239494b6f..58c9c7843 100644
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
@@ -83,6 +84,7 @@ struct context {
 	tst_atomic_t abort_flag;
 	uint32_t mntpoint_mounted:1;
 	uint32_t ovl_mounted:1;
+	uint32_t debugfs_mounted:1;
 	uint32_t tdebug:1;
 };
 
@@ -1209,6 +1211,31 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
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
 	if (access(PATH_HUGEPAGES, F_OK))
@@ -1545,6 +1572,9 @@ static void do_setup(int argc, char *argv[])
 			"Two or more of needs_{rofs, devfs, device, hugetlbfs} are set");
 	}
 
+	if (tst_test->needs_debugfs)
+		mount_debugfs();
+
 	if (tst_test->needs_devfs)
 		prepare_and_mount_dev_fs(tst_test->mntpoint);
 
@@ -1656,6 +1686,11 @@ static void do_cleanup(void)
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
index c495d2eb5..37251ae6a 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -994,6 +994,7 @@ static struct typemap tst_test_typemap[] = {
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
