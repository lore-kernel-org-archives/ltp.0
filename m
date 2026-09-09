Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDEFC79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 03:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788924911; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kVMQF8vZzehfYaERk7roocqmmaRMsWBawpxDDedupQE=;
 b=XP++UXafiAdUi5kAwKpodH/8SXXI6jY8zBERjZlSjDn18pQ6iuTANoc48ZOhSNWhj0Pqf
 ZSERo1Fqb5BhrRdwZWmL8JgJJcbmbELhfg4aXteDX/o6FTPTguIg/GcS0PWxfUxHCXVnv4A
 5RBLrN9OwhEAxLnfHb9Wpow9Nmr9p6A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C6763E94C6
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 05:35:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCC33C2C00
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 05:34:50 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C03A7200D03
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 05:34:49 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so284782f8f.3
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788924889; x=1789529689; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyH4y1BdnJJjSf2Ue2R8JavcyN/gfHigpXpFvX4R+Rc=;
 b=PryYI4tdXQHZhKH81JdLxNP9x1QwVuuHqbkGMVD+aQfCC6QRA1RjK+7XHHjw3PEV3c
 FGUgXRCHP22UoRa0UNnaN6fAuzyFj1+19oZIq5eZ0C+cD1fswiXusEI/HIO1v9z5TOIq
 V5SP7hZsO6nzRcWDt+o03zYCsQdjhlZjbgAA/7U8IpKzIrRrFZkoaWBv5gZtPakMJcEn
 ZYgVNLwDUkTyieBN7tdsx53BnvX/m+9L7ByRfjMYjK3t28Jj7NUesD7dgw14vwGeW10I
 R6CTopL3HEtKWhdoKNV9Wo2yllpAUVWKrdIhScafaJgbqUjOhyjBtq3r683XKC2+TyfM
 VrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788924889; x=1789529689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZyH4y1BdnJJjSf2Ue2R8JavcyN/gfHigpXpFvX4R+Rc=;
 b=HP1m/gI9OvUpIr6r8dMg7mZ5Gw/JJrg2RMaPHSmFZa9m2Y79mdJkgcdbxN3ApUZWt/
 FdcZ0LV6mGT68zAW9mZ379iEDkV2Eviw3OkNOyJBiIzYK2SFp2wRj95NLlpNt3736epR
 jppn3BoFBD7O4q2YcTqnDSy+ZRhnAnZfPJUJ0v+czkwhRuBBd+r9bLxJD7oGr90imAVn
 i0WtQC+xC5o3y6DcWXxyyZDD43+7x30cq/MhlHk9kzc4yAkqzYISyBAXElGNSH88j/mh
 7adgvc+54QovCjTtWDiFN6uroxtMqL/11vQt8uEBMW1pgUrZl7xgB1yTB9tpgFy2ZKmz
 sYRw==
X-Gm-Message-State: AFuF++lZ7abld5LssicYhUNNihTifJyZaqm5PnjS5UEUKryJYYmOJk84
 30WT+YwWmOgMvt1KPlMgU/yZCnUuXyfN+ItMV5idAeDLZiH/SXT/3N/qPurKSIIGNKfC2jY+Jox
 h4dQ=
X-Gm-Gg: AYBFou0+KtQUfW8266gJ7dOgvNGZc4EkpTDOtE00IV2xfxYjWY+9Y4U7VO+r3MEolGx
 NIA+gKGCkcoSmbKrkSrRwkJDwoW7rXnkAAL8E0BZ6cPmTWpMbTfbPRdhtcbFV7YGso1YnHW4Wt3
 GDklvz013LsvIoi877nb0L440P6isjEClVApMjb+4FUEXtlqCfk6Mbxwo4ixWpAwllk/wlSSx8B
 WlqC7fEH1UjrqspYQTDQgXJx9wNWMntGcfNt7LcpBjpZOEUGsWil3e9VHZJrcP+sCqAKefu0+ne
 ZTQat7q7ZvQNDPMwnUkye4Od4AdNW68JXNKJk7TaJkAu0Telvpi+w13dfyTRMnglWnbG4lfoFUR
 cg52gNF/2p+XHYRL1GS2BcqSLMZWLbNGXHNjsYFrFEhwUAHeDfrrttOToffD974hXaKDOXQaAsk
 shwcBHsjYP3kKY4jWl5f5seshaiNnR1eio0cMzBjH7RGrzLS+mKGThN1yZHHmn4F3xXIwKSEJSC
 9iiEulVebrSjJGBhR3XmPRAGT8C8+LCvSaKMfKDG8A=
X-Received: by 2002:a05:6000:250c:b0:482:eab2:a752 with SMTP id
 ffacd0b85a97d-485aad9459amr6528725f8f.1.1788924889166; 
 Tue, 08 Sep 2026 20:34:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4858d2693e8sm39737734f8f.3.2026.09.08.20.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 20:34:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  9 Sep 2026 03:34:31 +0000
Message-ID: <20260909033447.14302-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813052853.22152-1-wegao@suse.com>
References: <20260813052853.22152-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14] fsconfig04: Check FSCONFIG_SET_PATH
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
v13->v14:
- Eliminated redundant static 'dev0' buffer and strcpy() by directly using 'tst_device->dev' from the framework.
- Removed global mutable option-formatting buffers and arrays, replacing them with a local stack-based helper function 'format_journal_device()'.
- Replaced manual if-else results reporting with the standard LTP 'TST_EXP_EXPR()' macro.
- Relocated 'SAFE_CLOSE(fd)' to execute immediately after 'FSCONFIG_CMD_CREATE' succeeds to free the kernel filesystem context early.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 171 ++++++++++++++++++
 3 files changed, 173 insertions(+)
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
index 000000000..842a9dffc
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,171 @@
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
+ * - Acquire three loop devices (``tst_device->dev`` from framework, ``dev1``, ``dev2``).
+ * - Format ``dev1`` and ``dev2`` as external journal devices with the same UUID
+ *   (``-O journal_dev -U <uuid>``).
+ * - Format ``tst_device->dev`` three times to cycle journal associations:
+ *   ``dev1`` -> ``dev2`` -> ``dev1``, so both journal superblocks are consistent.
+ * - Open ``tst_device->dev`` via :manpage:`fsopen(2)` and set the source and journal_path using
+ *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_STRING``) and
+ *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_PATH``).
+ * - Apply ``FSCONFIG_CMD_CREATE`` and verify with ``tune2fs`` that ``tst_device->dev``'s
+ *   journal device is now ``dev2``.
+ *
+ * Implementation notes:
+ *
+ * - To avoid ``journal UUID does not match`` error when switching external
+ *   journal device, we have to assign the same UUID to ``dev1``/``dev2``.
+ * - Before the :manpage:`fsconfig(2)` test, we have to format ``tst_device->dev`` associating to
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
+static char dev1[PATH_MAX];
+static char dev2[PATH_MAX];
+
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
+static void format_journal_device(const char *dev, const char *journal)
+{
+	char journal_opt[PATH_MAX + 16];
+	const char *const opts[] = {"-F", "-J", journal_opt, NULL};
+
+	snprintf(journal_opt, sizeof(journal_opt), "device=%s", journal);
+	SAFE_MKFS(dev, tst_device->fs_type, opts, NULL);
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	create_and_attach_loopdev("dev1_file", dev1, sizeof(dev1));
+	create_and_attach_loopdev("dev2_file", dev2, sizeof(dev2));
+}
+
+static void run(void)
+{
+	/* Reset dev1, dev2 and tst_device->dev superblocks before each test run iteration */
+	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	format_journal_device(tst_device->dev, dev1);
+	format_journal_device(tst_device->dev, dev2);
+	format_journal_device(tst_device->dev, dev1);
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
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
+	SAFE_CLOSE(fd);
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
+	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
+	tune2fs = SAFE_POPEN(path, "r");
+
+	while (fgets(line, PATH_MAX, tune2fs)) {
+		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
+			found = true;
+			break;
+		}
+	}
+
+	TST_EXP_EXPR(found, "Device found in journal");
+
+	pclose(tune2fs);
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
