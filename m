Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB6FC55162
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 02:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785723176; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+kd7Xy9SUwcMjrG3tVFPLtxstQ5yihLPo6DxjzuBS20=;
 b=TjmdSAI4Gj305Uc7xoeOUrSdI3VHLaDrk5z9z3stQCCmU7uKMowkT/GiR+QbiCormL1lv
 h7apJ8l1CYj3h6Pkjsmt4kdVEpfQF2FCj46svGehGOZcCrFj6vow38rgKXTzoYypj/Yc6OG
 spzBhdhVibh+yfodEoxyM/lhUMIwpjk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD5D23E4B84
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 04:12:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422093E145B
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 04:12:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3142360046D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 04:12:33 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so12569975e9.1
 for <ltp@lists.linux.it>; Sun, 02 Aug 2026 19:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785723152; x=1786327952; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhk/EPIHlP/qCNzqyqtzqOmTwEpTuET2x56fqQt/6Lk=;
 b=YhJ/G+eNlipikjDeK2n3aeIeLbV3kMkmLFsDafJgq96JJdYeC29XsQfbYkzO2W1UDq
 lTmO09A8KMVkpp6vV89SPSgBi+5mYMqAv/ARyZtq4K7kAGMlfB90qtFXuw+zrhbiWjfa
 1evhFOPIuPVROcGm/J2u5T/qXTQXK14OpsL0L/azmPlt65dKDezDb+MxtZCAbYQxKHC2
 /rRyXBrcXe+ZJai3vQ6ItolBB9vwYQFV/wCC3cfrR3VelsXmgdb/Hblc79bJ5LvdaC84
 TeS0cEFWChdjFE1HycZCeuVx/OzpPrFFJafRFY6P65uxywPK6SOro2ijeW8YLJqHBeuX
 Bn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785723152; x=1786327952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hhk/EPIHlP/qCNzqyqtzqOmTwEpTuET2x56fqQt/6Lk=;
 b=mq3ZhnpQTO6xoKsZ/WOFLIPV8fjC/dwzKx/A6C0i+uYpknFTMNECDs8biwTCSHqcST
 Sne4wa1IK7BT2lLQ4uyO8wLj0zLM4ENmvUcl1D1Nn1Cmir9er8Apdl6f+zPVT1jGJrx9
 0+y+NQ6PoR4v89Jl79dq0QP20DvgsMR/bdxZdzE6ACqtrOGsoOGBNQh96NYDK5unbf/Z
 34xLpnPzsAdfrUrE3RlboxJC+v59WqMkYGcz83C+UJpIOvEysX9e04x3HAxtbzU1NoYx
 UJQsosbG8wSNppcZpIDKVNwfNnpZb2vnm0R2QK7BHn7j4uH6xPLK6Y4UAzXPQ/saACtf
 0Cag==
X-Gm-Message-State: AOJu0YyQFahxE4V+K0mK5DbsPZfbn6bKLtdXXL+Nhb2PwdR6K7NigwYZ
 drBycB1m+Eic7JKS8To8M6Q/Zgj8wlmlNP86c0ywf7TE1T5tvlEBMxYfMQ5v1Bn83pphDT6Fzq6
 6eXw=
X-Gm-Gg: AR+sD13OMMPylUazZFX9LzToZstkiAmHvGj+JOjdh2BwkpAQo3FZOU4p88MzSpHPPEs
 LNeZaGVkbSdLy18kiTzgJ00rXdq15Vup8Uxkk7dq3X2yLa9uywzYRuM/Cikgx2oVpi1uCBmxh+F
 Ou1kKEPfOil0NjJ2U2nbOJ0D/mmOmkBie315+OeHnPZ2V7Me7aw6sMHMd6gU0rNOlz07uYfT3q6
 KLRvC7swdozu7LrerWFemCubowfi2x81vj1XLJu+Ec/jgavQqB9ESK3Ig4I3YEHye5iOa3x7K4Y
 Al9YgwekR45EUA3hDS1+Ef76XQBfMW+WNin747SpHgbfopsN4XzijojJ5vQS+jvyl7dC/aBZRny
 83GN24IPuPJq4uq+XlPecUWtuZTFRKvrakMolp3JR8lJ+wWy2Hc65WoMlOyH04G7ozcEeES0SYs
 a4TUCIvVEgqbslPHWfmfu1NOWFQ7OHUyqarwVHbb/WeL9RqZJY
X-Received: by 2002:a05:600c:8b17:b0:495:4491:b8c2 with SMTP id
 5b1f17b1804b1-4980c66c926mr170573825e9.3.1785723152573; 
 Sun, 02 Aug 2026 19:12:32 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49808199a68sm129807285e9.4.2026.08.02.19.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 19:12:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  3 Aug 2026 02:12:17 +0000
Message-ID: <20260803021230.14530-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720122644.2153-1-wegao@suse.com>
References: <20260720122644.2153-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11] fsconfig04: Check FSCONFIG_SET_PATH
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
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 183 ++++++++++++++++++
 3 files changed, 185 insertions(+)
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
index 000000000..3890b0a38
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,183 @@
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
+ * - Acquire three loop devices (dev0 from framework, dev1, dev2).
+ * - Format dev1 and dev2 as external journal devices with the same UUID
+ *   ("-O journal_dev -U <uuid>").
+ * - Format dev0 three times to cycle journal associations:
+ *   dev1 -> dev2 -> dev1, so both journal superblocks are consistent.
+ * - Open dev0 via fsopen(2) and set the source and journal_path using
+ *   fsconfig(FSCONFIG_SET_STRING) and fsconfig(FSCONFIG_SET_PATH).
+ * - Apply FSCONFIG_CMD_CREATE and verify with tune2fs that dev0's
+ *   journal device is now dev2.
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
