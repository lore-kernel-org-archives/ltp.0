Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C756C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786598957; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=4zMiuKEvwGntPEgsZ6FhjaAQFSTeQsjqIL1Bf/mt7/g=;
 b=BCx6E8HxHMcCLv+WhN/oTpp16pl8ZYCQDNDPXnUcwJ022ZAOdRFWfJSo93jtxdOpPcCRj
 74Ol6imI9uLTyGhQvRtlSQMORt9zt5RgvI4Dmg9Vp2EokJzQ1iTWOTg7nbd5/tEI6rHgD91
 1EVQgBR5rwoOj3VcvxMBbbdBmrKBZ6U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 624C43E5295
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 07:29:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A34B83DC3E9
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 07:28:57 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B5E1E1A00649
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 07:28:56 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4956869750eso1720055e9.2
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786598936; x=1787203736; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=muFxrpzc7sOasDSRn0TF6U9+LPg/oxfgz0UyBLlQ0vo=;
 b=Nfbdeh/hHi5MMpg9pMRWLXqCh0lqF3ih9qnLShCPdWWoXTBtq6ZCiLc+w7u7vWgGov
 PJT2pIFmz42pdQOO9T+watrSNQB2ZAB4Zj1vPffX2jJVfi+n+LqSNPR9ml6Pr3CpzGMb
 z0Twj6maKCaL9BwEM8SOfB9/OEYxstbekz89TlaVOTN504bxck8pKxiHwnZS9Ag7VzWp
 3RTdkr98rZUEp98ltK7wlObDGiE3zxeIP5qOePNIpbQ8v0TS8+qGa4pnuygk1J3BpGMS
 vtlUvK5+UqmC7eKbgTK/whordwFpRFtUsiNyZp+HgIELBtvBQjFv1jQo8wCKzh9nAUcc
 hPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786598936; x=1787203736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=muFxrpzc7sOasDSRn0TF6U9+LPg/oxfgz0UyBLlQ0vo=;
 b=CkSchQNstrdKXVf91DMa/FxsCsfP+GPG1ioPkgy1RNZbHpuMrMmmcG0ad3xYTlIk5E
 Y8SnCB5Qv2DgMDbnlA4zMbOq9YZLONxNngrtFrl5kuytNsRh9jEIKnwbRWOPjilPlMuu
 Mr55zP6T3bBcL88jN8wBQSPtgPCay11WbYka3QwMba5pkibDhFIxmN3jj7wIt5oi4K3E
 ZTiRfDZsVOma+nliv4yqKgv48hmtqPjx2xrpV237dmo7b/h0IJ2yvI8HYEzeXucVqugz
 YNDKXXoQ8zxGwHeXMoKI1dPILFZ4K3CkqrIGSuc7eVXWJXg7ofJDOk9NnBzoEIVtxqPK
 D9Kw==
X-Gm-Message-State: AOJu0Ywpl1Jv2djCn49Mkw0Jq4Z28HwQrV1Q4DNOoKC2VYHHYCKNNXdJ
 2on6ORLaH/D2vz6wBWusK9z1mfcgDsVgBAlCDhaBQ0klWVvZ7vYWU7iuBzGwk60ruyKf/Z8dTlP
 2ELs=
X-Gm-Gg: AR+sD12DbUMq7oYLmZXpNa+L4ZD5V1HPE3Fa5md+iETe4yk+Ot4/fTt086bT8yBm7uS
 fYUdxvwcAvthKbgy0038MSDIfkedhp7j0I8uqN9OgpqYTPT86D3Ft3l/ArO/XwKaOa0tGKUH7T1
 MR+9akIYoEye29aaixHaoaiwOmFcSwI0cPYifCHDr3pOuwgRrH0Zk5RATgtTn3/13n7mFzMioEu
 gfDM2u0r5iUdt1qkkSOoLKPPtGDRisljGZ/bjJhrAUjMAiWn80bcrl4Vb+Fe0/4I/iL7cdS4QOp
 HHaeZRioxHgKPH/W+8HfzyhwLvgKnbyRcb2k0Ds4iWDkZ84h6gzZsmLMBcBTTwZF772ECRwPqng
 ymGN2XOZBEaaw2O8ETfJ4OyXm2b2bT2ztOTYNcno7u9Vtkrlqr69bhNUpfuumps+D5Dt8OLUkRp
 Yz2hVAyeULOr+T5zxYmAkvQEPDeDv64KxE25oaY2g0+iZBWrt6
X-Received: by 2002:a05:600c:8519:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-499821f20efmr30208295e9.10.1786598935984; 
 Wed, 12 Aug 2026 22:28:55 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4998216cf97sm30791165e9.14.2026.08.12.22.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:28:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 13 Aug 2026 05:28:40 +0000
Message-ID: <20260813052853.22152-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804010439.15195-1-wegao@suse.com>
References: <20260804010439.15195-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13] fsconfig04: Check FSCONFIG_SET_PATH
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The fsconfig01.c does not test if FSCONFIG_SET_PATH has any effect;
most of the calls there just set a dummy "sync" parameter. This test
case aims to verify if the FSCONFIG_SET_PATH operation can be used
to dynamically change the external journal device of an ext3 or ext4
filesystem.

Closes: https://github.com/linux-test-project/ltp/issues/1169
Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
v12-v13:
   - Uses bool found with standard false/true logic.
   - Resolves device node numbers portably using standard SAFE_STAT and major/minor macros on st_rdev.
   - Fixes dangling stack pointer bugs across loop runs.
   - Moves formatting of all loop devices into run() to guarantee full test idempotency.
   - Removes redundant .needs_tmpdir = 1.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 174 ++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 65fb4d1ce..13bb59cde 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -437,6 +437,7 @@ fremovexattr02 fremovexattr02
 fsconfig01 fsconfig01
 fsconfig02 fsconfig02
 fsconfig03 fsconfig03
+fsconfig04 fsconfig04
 
 fsmount01 fsmount01
 fsmount02 fsmount02
diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
index cfedae5f7..bd3754c34 100644
--- a/testcases/kernel/syscalls/fsconfig/.gitignore
+++ b/testcases/kernel/syscalls/fsconfig/.gitignore
@@ -1,3 +1,4 @@
 /fsconfig01
 /fsconfig02
 /fsconfig03
+/fsconfig04
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
new file mode 100644
index 000000000..00468ac65
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test aims to validate :manpage:`fsconfig(2)` with the
+ * ``FSCONFIG_SET_PATH`` operation in dynamically altering the external
+ * journal device of an ext3 or ext4 filesystem.
+ *
+ * Root privileges are required because the test creates and formats loop
+ * devices, and configures filesystems.
+ *
+ * [Algorithm]
+ *
+ * - Acquire three loop devices (``dev0`` from framework, ``dev1``, ``dev2``).
+ * - Format ``dev1`` and ``dev2`` as external journal devices with the same UUID
+ *   (``-O journal_dev -U <uuid>``).
+ * - Format ``dev0`` three times to cycle journal associations:
+ *   ``dev1`` -> ``dev2`` -> ``dev1``, so both journal superblocks are consistent.
+ * - Open ``dev0`` via :manpage:`fsopen(2)` and set the source and journal_path using
+ *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_STRING``) and
+ *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_PATH``).
+ * - Apply ``FSCONFIG_CMD_CREATE`` and verify with ``tune2fs`` that ``dev0``'s
+ *   journal device is now ``dev2``.
+ *
+ * Implementation notes:
+ *
+ * - To avoid ``journal UUID does not match`` error when switching external
+ *   journal device, we have to assign the same UUID to ``dev1``/``dev2``.
+ * - Before the :manpage:`fsconfig(2)` test, we have to format ``dev0`` associating to
+ *   ``dev1`` -> ``dev2`` -> ``dev1``. This ensures that both ``dev1``/``dev2`` superblocks contain
+ *   correct content. Otherwise, you will encounter errors such as
+ *   ``EXT4-fs (loop0): External journal has more than one user (unsupported)``
+ *   when switching the external journal device using :manpage:`fsconfig(2)`.
+ */
+
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+#define LOOP_DEV_SIZE 10
+#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
+
+static int fd = -1;
+static char dev0[PATH_MAX];
+static char dev1[PATH_MAX];
+static char dev2[PATH_MAX];
+
+static char device_option_dev1[PATH_MAX + 16];
+static char device_option_dev2[PATH_MAX + 16];
+static const char *const mkfs_opts_journal_dev1[] = {"-F", "-J", device_option_dev1, NULL};
+static const char *const mkfs_opts_journal_dev2[] = {"-F", "-J", device_option_dev2, NULL};
+static const char *const mkfs_opts_set_UUID[] = {"-F", "-U", UUID, "-O", "journal_dev", NULL};
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	if (dev1[0])
+		tst_detach_device(dev1);
+
+	if (dev2[0])
+		tst_detach_device(dev2);
+}
+
+static void create_and_attach_loopdev(const char *filename, char *dev_path, size_t dev_path_len)
+{
+	if (tst_prealloc_file(filename, 1024 * 1024, LOOP_DEV_SIZE))
+		tst_brk(TBROK, "Failed to create %s", filename);
+
+	if (tst_find_free_loopdev(dev_path, dev_path_len) == -1)
+		tst_brk(TBROK, "No free loop device found for %s", filename);
+
+	if (tst_attach_device(dev_path, filename))
+		tst_brk(TBROK, "Failed to attach %s to %s", filename, dev_path);
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	strcpy(dev0, tst_device->dev);
+
+	create_and_attach_loopdev("dev1_file", dev1, sizeof(dev1));
+	create_and_attach_loopdev("dev2_file", dev2, sizeof(dev2));
+
+	snprintf(device_option_dev1, sizeof(device_option_dev1), "device=%s", dev1);
+	snprintf(device_option_dev2, sizeof(device_option_dev2), "device=%s", dev2);
+}
+
+static void run(void)
+{
+	/* Reset dev1, dev2 and dev0 superblocks before each test run iteration */
+	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_journal_dev1, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_journal_dev2, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_journal_dev1, NULL);
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", dev0, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP)
+			tst_brk(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
+		else
+			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
+
+	char path[PATH_MAX + 32];
+	char device_str[NAME_MAX];
+	bool found = false;
+	struct stat st;
+
+	SAFE_STAT(dev2, &st);
+	unsigned int device_num = (minor(st.st_rdev) & 0xff) | (major(st.st_rdev) << 8) |
+				  ((minor(st.st_rdev) & ~0xff) << 12);
+	snprintf(device_str, sizeof(device_str), "0x%04x", device_num);
+
+	char line[PATH_MAX];
+	FILE *tune2fs;
+
+	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", dev0);
+	tune2fs = SAFE_POPEN(path, "r");
+
+	while (fgets(line, PATH_MAX, tune2fs)) {
+		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found)
+		tst_res(TPASS, "Device found in journal");
+	else
+		tst_res(TFAIL, "Device not found in journal");
+
+	pclose(tune2fs);
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_device = 1,
+	.mntpoint = MNTPOINT,
+	.needs_cmds = (struct tst_cmd []) {
+		{.cmd = "tune2fs"},
+		{}
+	},
+	.filesystems = (struct tst_fs []) {
+		{.type = "ext3"},
+		{.type = "ext4"},
+		{}
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
