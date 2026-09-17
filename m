Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8844C982CD
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 06:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87F343E53B8
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 08:45:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DACAF3C26DC
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 04:57:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 65238100037D
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 04:57:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D588A21E32;
 Thu, 17 Sep 2026 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789613860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4e0Rytu31HcZUOHYCAix8LynWOS5tNzGq5sXbLcAPrE=;
 b=hI3jDZ0cCpT88LRpr7Ua1FAhJFO4gBBrNm4nrr2EG2Xv1LJzeSD188bMse2IGJ65U6mrEk
 X0DvT8/qeYnp2lxbOLsXqHNDL+8wZAx+A0kX0sie4gVKAO3LvU0JpUUsJjzPza/fFFySQ/
 c3mauZ49aMu5ETACBphH8dqVB9V4kos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789613860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4e0Rytu31HcZUOHYCAix8LynWOS5tNzGq5sXbLcAPrE=;
 b=XCCNlsKDWm6wjTLsYDdguJpIzNrZ9E4ogbqLTwlbCQKwBBOUfrj2jblwiy941QiB8lK0Ct
 QmKI2F0wli/mVqBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789613855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4e0Rytu31HcZUOHYCAix8LynWOS5tNzGq5sXbLcAPrE=;
 b=F1oyQN7uQ8xvkyCr+kbztRG/4kqGJMsLH+K3DRw0nCCcMXTTCMIvpVJrxXqkVVudpnNvDI
 lpHwwg6vRA1B7KSir/9nPlW9VYwDzzjh+E/hBsAn/9a+rLiAT7enOfZUEMCKXsYeeKNAjK
 zitWBl8fgj8mBq7Xc7VG1qNWzKGQ4Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789613855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4e0Rytu31HcZUOHYCAix8LynWOS5tNzGq5sXbLcAPrE=;
 b=rTEg2kV0a7E2b+e66SCE+ZEovbQov84h7qcOdwdSQP/tJPz0TnjfRjDRl02e1wU/PEs7Yy
 SiORnto+KOn8+nDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0DA31374A;
 Thu, 17 Sep 2026 02:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lag5Ch5Xq2r3fAAAD6G6ig
 (envelope-from <gpathak@suse.de>); Thu, 17 Sep 2026 02:57:34 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Thu, 17 Sep 2026 08:26:57 +0530
Message-ID: <20260917025657.327887-1-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.de:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 17 Sep 2026 08:45:42 +0200
Subject: [LTP] [PATCH] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gaurav Pathak <gaurav.pathak@suse.com>

This patch adds a new test to validate these atomic write limit fields.
The test ensures the filesystem correctly advertises the STATX_ATTR_WRITE_ATOMIC
attribute when queried on a file opened with O_DIRECT. It also verifies that the
reported optimized maximum is logically consistent by falling within the
absolute minimum and maximum boundaries. Furthermore, it checks that all
reported atomic write unit sizes are valid powers of two, adhering to the strict
requirements of the kernel block layer.

If the underlying storage hardware or filesystem lacks atomic write
support, the test gracefully skips with TCONF.

Fixes: #1224

Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
---
 configure.ac                               |   2 +-
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx13.c  | 130 +++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx13.c

diff --git a/configure.ac b/configure.ac
index 18bfdb88c..72f423c56 100644
--- a/configure.ac
+++ b/configure.ac
@@ -181,7 +181,7 @@ AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
-AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
+AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align, struct statx.stx_atomic_write_unit_max_opt],,,[
 #define _GNU_SOURCE
 #include <sys/stat.h>
 ])
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index f6a423eed..e601a46a3 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -10,3 +10,4 @@
 /statx10
 /statx11
 /statx12
+/statx13
diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
new file mode 100644
index 000000000..5f73807b4
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx13.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC <gaurav.pathak@suse.com>
+ */
+
+/*\
+ * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
+ * It ensures that supported filesystems (xfs as of now) correctly report their
+ * atomic write limits to user space when queried via statx().
+ *
+ * The test performs the following validations:
+ * - Creates a test file using O_DIRECT (a prerequisite for atomic writes).
+ * - Calls statx() with the STATX_WRITE_ATOMIC mask to retrieve the limits.
+ * - Verifies that stx_atomic_write_unit_min, stx_atomic_write_unit_max, and
+ *    stx_atomic_write_unit_max_opt are logically consistent (e.g., max_opt is
+ *    within the min and max bounds).
+ * - Ensures all reported atomic write unit sizes are valid powers of two.
+ */
+
+#define _GNU_SOURCE
+#include <sys/param.h>
+#include "tst_test.h"
+
+#define MNTPOINT "mnt_point"
+#define TESTFILE MNTPOINT"/testfile"
+#define MODE 0644
+
+#define WRITE_SIZE 4096
+#define ALIGNMENT  4096
+
+static int file_fd = -1;
+
+static void verify_statx(void)
+{
+	struct statx buff;
+
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff),
+			"statx(AT_FDCWD, %s, 0, STATX_WRITE_ATOMIC, &buf)", TESTFILE);
+
+	if (!(buff.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
+		tst_res(TCONF, "Filesystem does not support STATX_WRITE_ATOMIC");
+		return;
+	}
+
+	if (buff.stx_atomic_write_unit_min > 0 &&
+			__builtin_popcount(buff.stx_atomic_write_unit_min) == 1)
+		tst_res(TPASS, "stx_atomic_write_unit_min(%u) is power of 2",
+				buff.stx_atomic_write_unit_min);
+	else
+		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) is not a power of 2",
+				buff.stx_atomic_write_unit_min);
+
+	if (buff.stx_atomic_write_unit_max > 0 &&
+			__builtin_popcount(buff.stx_atomic_write_unit_max) == 1)
+		tst_res(TPASS, "stx_atomic_write_unit_max(%u) is power of 2",
+				buff.stx_atomic_write_unit_max);
+	else
+		tst_res(TFAIL, "stx_atomic_write_unit_max(%u) is not a power of 2",
+				buff.stx_atomic_write_unit_max);
+
+#ifdef HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
+	if (buff.stx_atomic_write_unit_max_opt == 0) {
+		tst_res(TINFO, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
+	} else {
+		if (buff.stx_atomic_write_unit_max_opt > buff.stx_atomic_write_unit_max)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
+					buff.stx_atomic_write_unit_max_opt,
+					buff.stx_atomic_write_unit_max);
+
+		else if (buff.stx_atomic_write_unit_max_opt < buff.stx_atomic_write_unit_min)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
+					buff.stx_atomic_write_unit_max_opt,
+					buff.stx_atomic_write_unit_min);
+		else
+			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
+					buff.stx_atomic_write_unit_max_opt,
+					buff.stx_atomic_write_unit_min,
+					buff.stx_atomic_write_unit_max);
+
+		if (__builtin_popcount(buff.stx_atomic_write_unit_max_opt) != 1)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is not a power of 2",
+					buff.stx_atomic_write_unit_max_opt);
+	}
+#else
+    tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in struct statx");
+#endif
+}
+
+static void setup(void)
+{
+	char *data_buff = SAFE_MEMALIGN(ALIGNMENT, WRITE_SIZE);
+
+	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
+		tst_brk(TCONF, "This test only supports ext4 and xfs");
+
+	umask(0);
+	memset(data_buff, '@', WRITE_SIZE);
+
+	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
+	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, WRITE_SIZE);
+}
+
+static void cleanup(void)
+{
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_statx,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.13",
+	.needs_root = 1,
+	.needs_device = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.filesystems = (struct tst_fs[]) {
+		{
+			.type = "xfs",
+			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},
+		},
+        {
+            .type = "ext4",
+            .mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", "4096", "-C", "65536", NULL},
+        },
+		{}
+	},
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
