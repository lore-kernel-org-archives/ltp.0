Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D911C44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784550431; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gnghPXjzFwjac5AQWFrfYnw9I3DeZaBb700TmBZD1j4=;
 b=OeJi0oFlUn5kSOnFwAyv5t5uqyV6BAjhJen/hnTxGvm5QJ8Gvtu0m/BewD4MJ5zUiR/S2
 NkgrpJaNtZtSfxFIL51jPHEBalyd1wa1kCGzRnt4hap2hnIOPQJz/iJlraPZxkFdDARVJBG
 2DrnBWtvWm21NNqJ9zaNZ0ileFNrjw0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FF593E62A5
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:27:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FB6D3C2A52
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:26:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C78160066E
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:26:47 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso15215245e9.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784550406; x=1785155206; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8748xOnMf8Avo6Ws3/BPlqmxv+ud/JE8Cx396nOOvgo=;
 b=JMnlV4x7ZzJW+GIcWi+VA3y+/y6ZxhEBmBUlzT63xR1UUPvaYbk3kETNQDf4PyZ5LT
 +AO0mnIGtFPuiTHVMEECqUKO4LXSp0/u97LG/Zj7TsjU2jr06vh9zksV8gw5P3Dn6Q+u
 vwMFECfC7e0C/TRWwoJ0KJfPWNcU7kx6CyJmMKclu+8YjsIJ7qyvuNxD7Cx7YL3sEL3B
 5qA+3ORdyi5iH8NegXJrs/u8Un0HqxReMTryxvSzGVUXz5YnknoHkmTin81RDtBUhKIl
 fly1TXJ5QA4eYjBpwoHnluEN9Mqz2QTRiZUKKYN/Tft+Wzh5GqXh9eJPFQkL9um44MKe
 VJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784550406; x=1785155206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8748xOnMf8Avo6Ws3/BPlqmxv+ud/JE8Cx396nOOvgo=;
 b=WTm3sJvcS3PGV3R4PYeYik1nE8g16gPBt2Po11ysiUs+ShDioFbwY2Cpv+jP5iw2QD
 YRZY4mf4arysfcsU7n3vUQOFtZd0E3xDtOTxUrX9YrnUWfGSA9NXwujn6E4stdRdzmkf
 UJPoMMRT779EfV+xtqwoTost9WUue1zvV0DzKzwlxd4r2HGZp/xi+GxWUmITJS3s283S
 4It2lk9xHKPM05a2oGi6hvDftIdNA/njNxec+zhgGMyauEXMA+7J11ZCwu+9NemeFKJC
 mY2wVsSyzw314ExDMAe/4J2C1MrBFypWDzIy+v4URIXsAHTQAfYtQ7oV/l+BbxH6bGo2
 2ycw==
X-Gm-Message-State: AOJu0YzMe78hYIunztF+2mdmzEAgXOcTXT9zGE0ll6y7JTkUiKGYRErT
 oQqKpPdV1vYqcrawcJOc9iLsM20ae61TxcePeL6/226iuIJz+jlseidwgAUt+8o0LpoXGEOR9Fn
 3e9QsBA==
X-Gm-Gg: AfdE7ckczGoDHZ8+2MuZaIxWl6wgjEfpDTlObhlwX0jlxn0fCrSt6KjlPKDx68Ay962
 0v8+obRbGnQ0JeFJdcx4sUKRQDZaT0lW3CbXni1lyDnGEz1mPuo65KVzZj2Qgqh4el07cL1uhMC
 VGdQZc+euCojrRHkTnG9daQueq0g/7hJf1dLUDbdew51tMyqogETXUjokLl3elAh/G9YGSlPul+
 bpNhnNcGr1XCFThkgkwKsweX9lCMIf3o7Qr7VGVbaSs+rmH37BcUtvyd19OIBM1xKgzI95IxPQP
 eAxAI5FvpVA03QJaXiAvEqbglUQY6aGlua6Y69whn4A3dGfAAIFdxSrehcRP083RzNUkEjxVWbY
 MySvjNKa71IrLkIL4m9+9QG35QOChqYIiQqsuOz2U8GSFLzz2n1yzgLBBN8sJh6Tcxw==
X-Received: by 2002:a05:600c:6212:b0:495:5375:2510 with SMTP id
 5b1f17b1804b1-495537526b4mr90607885e9.24.1784550406388; 
 Mon, 20 Jul 2026 05:26:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49548e0fcdbsm236666315e9.2.2026.07.20.05.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:26:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 12:26:32 +0000
Message-ID: <20260720122644.2153-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626061436.15253-1-wegao@suse.com>
References: <20260626061436.15253-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10] fsconfig04: Check FSCONFIG_SET_PATH
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
---
v9->v10:
- Split the test doc block into clear [Description] and [Algorithm] sections.
- Refactor loop device creation and attachment into a `create_and_attach_loopdev()` helper to eliminate duplicate code.
- Replace redundant `.format_device = 1` with `.needs_device = 1` in the `tst_test` structure since the device is formatted manually in `setup()`.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 190 ++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a021c79da..a7a9cf638 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -422,6 +422,7 @@ fremovexattr02 fremovexattr02
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
index 000000000..7fb59d539
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test aims to validate :manpage:`fsconfig(2)` with the
+ * FSCONFIG_SET_PATH operation in dynamically altering the external
+ * journal device of an ext3 or ext4 filesystem.
+ *
+ * Root privileges are required because the test creates and formats loop
+ * devices, and configures filesystems.
+ *
+ * [Algorithm]
+ *
+ * Case acquires three loop devices (dev0, dev1, dev2).
+ * It formats dev1 and dev2 as external journal devices using the
+ * "-O journal_dev" option and assigns them the same UUID.
+ *
+ * Then, it formats dev0 (the main filesystem) multiple times,
+ * first associating it with dev1, then dev2, and finally back to
+ * dev1 again as an external journal using the "-J device=" option.
+ *
+ * Next, it calls fsopen() and configures the filesystem using
+ * fsconfig(FSCONFIG_SET_STRING, "source", dev0) and
+ * fsconfig(FSCONFIG_SET_PATH, "journal_path", dev2) to dynamically
+ * alter the external journal device.
+ *
+ * After applying FSCONFIG_CMD_CREATE, it verifies using tune2fs
+ * if the external journal device of dev0 has been successfully
+ * and dynamically switched to dev2.
+ *
+ * Implementation notes:
+ *
+ * - To avoid "journal UUID does not match" error when switching external
+ *   journal device, we have to assign the same UUID to dev1/dev2.
+ * - Before the fsconfig test, we have to format dev0 associating to
+ *   dev1->dev2->dev1. This ensures that both dev1/2's super block contain
+ *   correct content. Otherwise, you will encounter errors such as
+ *   "EXT4-fs (loop0): External journal has more than one user (unsupported)"
+ *   when switching the external journal device using fsconfig.
+ */
+
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
+	const char *const *mkfs_opts_set_UUID;
+	const char *const *mkfs_opts_set_journal_dev1;
+	const char *const *mkfs_opts_set_journal_dev2;
+
+	mkfs_opts_set_UUID = (const char *const []) {"-F", "-U", UUID,
+		"-O", "journal_dev", NULL};
+
+	char device_option_dev1[PATH_MAX + 16];
+	char device_option_dev2[PATH_MAX + 16];
+
+	snprintf(device_option_dev1, sizeof(device_option_dev1), "device=%s", dev1);
+	snprintf(device_option_dev2, sizeof(device_option_dev2), "device=%s", dev2);
+
+	mkfs_opts_set_journal_dev1 = (const char *const []) {"-F", "-J",
+		device_option_dev1, NULL};
+
+	mkfs_opts_set_journal_dev2 = (const char *const []) {"-F", "-J",
+		device_option_dev2, NULL};
+
+	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev2, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
+}
+
+static void run(void)
+{
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
+	char loop_name[NAME_MAX];
+	char path[PATH_MAX + 32];
+	char device_str[NAME_MAX];
+	unsigned int major, minor, device_num;
+	unsigned int found = 0;
+
+	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
+
+	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
+	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
+	device_num = (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
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
+			found = 1;
+			break;
+		}
+	}
+
+	if (found == 1)
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
+	.needs_tmpdir = 1,
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
