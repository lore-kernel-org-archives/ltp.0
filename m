Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6856C982C1
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 02:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789613191; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nrjb44O9uz8CdeamT5BFbFL+au16wJXS36HVnocEFu0=;
 b=CTosSnbXaI+7+F5xxhBV877sr7DMG0DqfNieDnd1wyZaea2XPf9gjaTp2qSet1qoOZ1lK
 +tal7vJ212AQHqphmo6TCjYYBiaT9PZINWyBn1OKD7DRqFJbxnb7RdkHWpUif7AP9xLw+nj
 nxnTNBlwUa85pphFog+DfsI7K839Gr8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F9A03E9286
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 04:46:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE7973E76C4
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 04:46:12 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1E2DF10009F0
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 04:46:12 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so1762845e9.1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789613171; x=1790217971; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ncgGQc8EJpQJTDwvEvny3YEdY/JilyusZjVzBuEkGAQ=;
 b=Ne8fdr164MciKKh6tF+91t4suFWr0c1+Ih6T0yvWeI4qovqsXBGprRmghVJ0hjWgKO
 pD/ZySTq1L86KAqxacM0dGHfg6XxR+aDNXKUEHco6qJM+Qsv4aPPOLmgu4Yg+K1E+4qO
 nYYYMARBd4GFyN0JOoaOyvl7k7b5TMKgM8UFqdVRgy8Ch6GSXUWs7yqvV+/U9VfoLYSW
 I/5W4ZxndZs1LUp/lkCe6+3KZLgBWw9myqtIBGWfHOADyuhvEGME5NbUI95IZuURhrZt
 RXLd+xzQx4S5ath+Y0EIn3SZtT/kvIEq97DjtnZnuvPVZ17e8BjrcEG6aeQ5RY7A8nZz
 E+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789613171; x=1790217971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ncgGQc8EJpQJTDwvEvny3YEdY/JilyusZjVzBuEkGAQ=;
 b=s/H6ysJXVHUYahOqJhA5xdbmMN2L/hCkeP2VBOOzv6sT/JtSuouvV699wkQ2yDVSMh
 hDJ7LXezfD/BlpBErLUYTURXQRp43ufZdF7X2nea3VyLEFTNK6fYYvZcMVWuSDaGdBOw
 V2CPYcZ+/e6vzQXVqVAzU25cJccJXtBR9TP0HJZCE0nazAZp0bpLvQUlDnR7o4R0h0gu
 5IU2oQyQBLz+/pHcNRc6iA7Tp0DQQlnYWBICR244HvbQLF6B5b7gZQ+bGDP+2LFfmssd
 SRuYohZ6PFXSt2CyYGgjq6ApOldQf9XXnEeKBjBfpOo01g+qAWMhNY0yTFplhz0RB0rV
 wRYA==
X-Gm-Message-State: AFuF++mcx3xZuWINEeNNFoME9AoT1dM4tyGhvpiSroq8jfX3TJGJXKvN
 qwbQvNj25BXZM2SO4OVJx+qyoWkSO2320qgH+oerUm3J0rpupHWwWC3x4k+AqZgM1tHqaJqF2HE
 3PbM=
X-Gm-Gg: AYBFou3z2BWXr2MLpgIhncp09kk1UCbzx4ZEB+PT3xg079AJ7a0sJt0rL+JVfCxRIgY
 Jpct8jUbCBphIqbec5SXj1gNG1CaCqZTzvYCY2XXJ+emF5ktrHAyQ9Qakqihnvj3hgBWFl9Nqn8
 0BtoBgCa/1kx/8p8dIx6P1Fk3hcOre8AkPFWcrAGXz50T80tNkoIfxxkkFTPtLoHrigvuDsMFeR
 T9PTIq6Yca9lMflGejjUNF+x3jqALemfvKQ0dvCLGX1LFsnFb7GC4Log+TgEihBujGw/Sf54mQr
 GMFiBRQc5pbKKwputtbFChVfaILF73EDV/72IpqGdsNB5oQSFAvF+IHHQ0vBVmW/RuKwgLJAkwN
 Pj5MeH482aDyPiyMjpK+ajPoKqhYRiLlq3tjA1bSmR0M+kUF4bLUqX67xFLu1mPf6oijTfvLzX2
 lvc+GV+e2AqzTig12aL0WEM1QBW0ildrcmA1Gq6HS7jWwEegzo/B+1tptjxXFPq1ABWTGS+cLb6
 xAVs74gcG5Lw1tAJThbQdTioVxAmGNFrP6v4BRDepc=
X-Received: by 2002:a05:600c:6290:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-49eb732cd4amr54150205e9.18.1789613171457; 
 Wed, 16 Sep 2026 19:46:11 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fbefe1791sm17566325e9.1.2026.09.16.19.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 19:46:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 17 Sep 2026 02:45:56 +0000
Message-ID: <20260917024609.20527-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909100414.14473-1-wegao@suse.com>
References: <20260909100414.14473-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16] fsconfig04: Check FSCONFIG_SET_PATH
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
v15->v16:
- Pass AT_FDCWD instead of 0 for the aux argument of fsconfig 

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 169 ++++++++++++++++++
 3 files changed, 171 insertions(+)
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
index 000000000..bd649717e
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,169 @@
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
