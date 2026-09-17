Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C551C88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 10:53:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA6563E758D
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 12:53:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 188C43E7573
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 12:53:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 43EF11400DD3
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 12:53:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F03C021994;
 Thu, 17 Sep 2026 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789642403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjl/5ChBJ0yjD3cQEqY/AoFuo+cCIfBVSxtr2rNIouQ=;
 b=wO6IgeQwydsagZgt48vU7EfWkvKfv6DgeT8qRk55+9ayvchkQAXCy5BMtYNOsg479GYY76
 AEh7g8Qh36e0ik0aAoZYQYD12aOkb30X2gUoXxXUlNwBFL/zmyYmnuClMOocsS6dNm5JKk
 IqiKp2bvbDKc7maO0YlcKfIznzLAsHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789642403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjl/5ChBJ0yjD3cQEqY/AoFuo+cCIfBVSxtr2rNIouQ=;
 b=QfZ10Znq2wwDoGnqJgjmrfZPIIo6uMqGW4vR9frnXpWxgNoML/5M1CIDoAJBHnbPNQFcAg
 fQ3ivlU7PjWXYHBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ymyLiFFZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kFbkp7Zx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789642398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjl/5ChBJ0yjD3cQEqY/AoFuo+cCIfBVSxtr2rNIouQ=;
 b=ymyLiFFZsGPxexNaO8uPyrXQisndubBcL4rYicjPIPtH1NHEqwhAOHvKcyFD5p4+EWWypS
 YL0DzeRIaHH6C0jYLH7cTctDFFkyIqSrIQyjiPFMGIVCkxERCVvaXUz7AbyzgU55SHa88l
 h/rbREt2lc+kVOhlVn7K237jCoV2bd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789642398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjl/5ChBJ0yjD3cQEqY/AoFuo+cCIfBVSxtr2rNIouQ=;
 b=kFbkp7ZxswIj7M+EuydAuBvybRtzZ0sNXFClnD/JEKTKdWkwhdTfMDuxVCuxmE6otoijc8
 l8qNBbWwYjjAynDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EEA7134B3;
 Thu, 17 Sep 2026 10:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jbeWOZzGq2pvCgAAD6G6ig
 (envelope-from <gpathak@suse.de>); Thu, 17 Sep 2026 10:53:17 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Thu, 17 Sep 2026 16:23:04 +0530
Message-ID: <20260917105304.9674-1-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260917025657.327887-1-gpathak@suse.de>
References: <20260917025657.327887-1-gpathak@suse.de>
MIME-Version: 1.0
X-Rspamd-Queue-Id: F03C021994
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
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
index 000000000..ea42a102c
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
+	tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in struct statx");
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
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", "4096", "-C", "65536", NULL},
+		},
+		{}
+	},
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
