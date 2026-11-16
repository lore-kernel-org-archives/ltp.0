Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4F606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=VAEJLVvM;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=hBYPBvQg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794819453; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=oVz1aN2aYCpbzRp2wzlnf8M0jAmnr0SHH340rBTSXtw=;
 b=VAEJLVvMMkIBRP21hVToT0428YUvbWze+8hNzMTxeD1Xz0OMvySQKOfIWB3Upf8LlMh8Q
 uC4hBMlW8aM/Ow5Sv+SpMrPaq3PHZP1XsOSkDHjhtzAzxszyzn1tulN2/JMvZ3XVYOWn+vz
 D8jbgpvW7A5UfVB4YT2Ud76lJ3fwH8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 433573E9469
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 09:57:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E7013E941C
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:20 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E25876002D3
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:19 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so33705085e9.2
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 00:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794819379; x=1795424179; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IBmco0P8hTS5pOjM6VXfyNkWE+qOIUX3b9eezjpV0y0=;
 b=hBYPBvQgvB/B6ugKKxGPJ3BoUb4kf0pW0hpE8nRnz9BCPbHitBsH9uwk5Ipnbr/glL
 PyH/g27mEmCN5UCca4aPVw63OJ1Yj+gQqUEGYbMS1f0yHqqvjsthCW0HqgZlFST6XaB6
 NbGMlwkEIsSyDdcmA/ICOlQVwxTaqPTMzYPL7NtLb7wvt+qXKwrVQW0govJZkTg39kt3
 VYgvF7tBd5UnlL12tF2uvaTQoBcX8e9SEqSo1PDbP2HQRBfkSIxias/m+9lh1Wz0wnae
 uGOuBHFnEQ7yqW0+DCoZUm8428C8+rkqJck1rlRnHDZyc0AxD7ufwZf4XG/DbP6W3Kgz
 68vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819379; x=1795424179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IBmco0P8hTS5pOjM6VXfyNkWE+qOIUX3b9eezjpV0y0=;
 b=Nao678A5t3kgLS+Ohpr9Yv8RZtdXbBwEdbAncAHiHwiUksQBkFoeu0b2WM00/f762V
 aqGUvihFJmf5oDZgrhAzUQzhSCczun4J1nQj1Ji7nFiWFCj+PQFG20buwdu6h8KCGiEq
 7CiQnZR0JUANU1MUv/pfTCeDXb/3JdbJmq1VCYc5cnWzlMKAg5UV8vvSaZlqoNHT5Yta
 5gpullGc4EIZztmBRIRvUMcbXZiQLyFGdKVpqK8FTQjccNpgU2EUvtfxYYmW+H25cTVO
 xO6dh9q1qS/h3lqt7LLXHEEHK8AT7+PFLW/DTNsIu42KgMVzeptkY0JIXSSqEqbp5lqv
 qr8g==
X-Gm-Message-State: APuU4Z+vOSsvSVgmGv9QV8lIAe5f41jsX4Mcq77rrf50c+qPAWkhJKjC
 AvNqOxQ+ozLrP5DKVmciogZp9kLbGvoK0ln7U4p7cAEh4OMQM0zmK0kP/J3OAUP2+QWhKimHDst
 wKiApANSn
X-Gm-Gg: AYBFou35qJ9xDn45z1++eCewuAaCMpReXAw0dI/nMFB6etyWW2asL6lyQibFfxdg9JF
 xvEZRn3HDEhJZoG6eA3CGmn1H5UGhWbUp0aEmWD/3yX5EnadH/2bXQur7jee8CCHWRVNxMstrph
 Yexpf2eniRQDTEtVyjI4PQq9DIlc6G+AUqJAxOSNfipGhlsUXa4Y7Koq1BRt0fc2g/JgdzAY6Wh
 YTlmaX/QOsE27kJPhOzHOzhKHwYmMUUXk4C1GwOPbeHNitGmU4ZXPRWSpuGqGq4Td8BRuoOW8TJ
 KU7JuNtGRp9NoFi+O4cwiL8pPPUCR5VNAl0MDbrqtRblCQx3LNNjmL9ULiw0J1PDo4dVdUicw4I
 bkKDNCniR961UXq2skcwprXZRMWZ1KC80BnOdJ5aELsaY8zvudsN2fAzireJ30srrYPWkV/l+dl
 MKxd2PhKBuaVj3OgVfUum2W6DzPEqNIU7Zw5gIyY+Z8TiRnPXg6LPxfRfYECX/BUQf+T8kTJ09a
 yTdUg9gwOzOYYh7Ai4zKvfgk0+sGHl9qfbClkC0B8PmlbiTzchmdEU1RBTDsq9vUTPSU5rs/CQB
 rJQ9GRMu6dhK/7EhDzY+fTfj1Ajra2y3ZsZWo8Cqk19Ef6s1RbZX4nJfeB7JrpAe3Vp6Bk3eJxF
 jnjOTCQ6C2ag5Zjqgk0Z2keSbwMGJJ7PpfA==
X-Received: by 2002:a05:600c:46c5:b0:4b6:5dac:b61e with SMTP id
 5b1f17b1804b1-4bb55a9b453mr212260635e9.32.1794819379080; 
 Mon, 16 Nov 2026 00:56:19 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c60f8d615sm21453536f8f.56.2026.11.16.00.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:56:18 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 08:56:06 +0000
Message-ID: <20261116085612.20171-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116085612.20171-1-wegao@suse.com>
References: <20261116085612.20171-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v19 3/3] fsconfig04: Check FSCONFIG_SET_PATH
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 167 ++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7b6a7d376..58d26571d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -452,6 +452,7 @@ fremovexattr02 fremovexattr02
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
index 000000000..fa6466cff
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,167 @@
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
+#define LOOP_DEV_SIZE 10
+#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
+
+static int fd = -1;
+static char *dev1;
+static char *dev2;
+
+static const char *const mkfs_opts_set_UUID[] = {"-F", "-U", UUID, "-O", "journal_dev", NULL};
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	if (dev1) {
+		tst_detach_device(dev1);
+		free(dev1);
+	}
+
+	if (dev2) {
+		tst_detach_device(dev2);
+		free(dev2);
+	}
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
+	if (tst_prealloc_file("dev1_file", 1024 * 1024, LOOP_DEV_SIZE))
+		tst_brk(TBROK, "Failed to create dev1_file");
+
+	if (tst_prealloc_file("dev2_file", 1024 * 1024, LOOP_DEV_SIZE))
+		tst_brk(TBROK, "Failed to create dev2_file");
+
+	dev1 = SAFE_ATTACH_LOOPDEV("dev1_file");
+	dev2 = SAFE_ATTACH_LOOPDEV("dev2_file");
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
+	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, AT_FDCWD));
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
