Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F01C2D0CD
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 03:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747365064; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=mjkxyUyJ9DSakdHnCV8qjFkQh/8Q1YDrS9rxS1jpblU=;
 b=c2kuEc9+V2Uox6wCQ6Z0nl+159CRuqK4tPu4K9zhY2mi4Eh58Zn4naXkppshKYOeaOKtS
 N1UbPC7FqxbI/lSYdaEa0igokwSjRl3wcmjM5uPu1ZuDcb3gDd/co2LONSKq1wb64CDMgR3
 tKlEqK24/5E29Waq10fEUAbkKOwlR/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C4CF3CC597
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 05:11:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B1D13CC2F7
 for <ltp@lists.linux.it>; Fri, 16 May 2025 05:10:42 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70CB61002032
 for <ltp@lists.linux.it>; Fri, 16 May 2025 05:10:41 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a1c85e77d7so1019110f8f.0
 for <ltp@lists.linux.it>; Thu, 15 May 2025 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747365040; x=1747969840; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+KfMgS8ODst6Hv+8Mx2YcN7j6h74m1x9xVxeQc8OLHo=;
 b=bMr9jyXRVqJ85zGJXBFJjmQtfM+6buWajWSJf3eZC47yWcyOZpGZtcSiG70JgdhboI
 0UsIaeEnDmix30MIgi96pwNn5mCDGZsIgVx9TGAjr7xWSWQGIgHluFtKj2qe9qF4bh00
 3Gbo+qLTWK04gDxUvp8LsVuuuiBWrHES9nudq4x31i9GIKhn0Su+fOSzqDHIqbu0BSJ4
 zTq71xgL1lHsAADcol/AE1ZOo2+m6hQsPUcpvw8jDfGt3Kcf0T3FafQKUGlkU9ARiGOX
 HUgxgXElemm8w2tqnrPWvzxAejAHxJi9no++QJY8SGkQr55AQfRGktUESHSVvBZfDhy0
 Lutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747365040; x=1747969840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KfMgS8ODst6Hv+8Mx2YcN7j6h74m1x9xVxeQc8OLHo=;
 b=Idi/qWDyRX61RQc5njCwHeDOWH6nTgnjVPRKvJvQE6PGUYqd3Lstsz1RRpwl4Ya3AP
 aFlGHP3psjoNSWoJZ+J5FaOtx2fRXh/v4azSahOIbEMrscX+1qhF8nInI+4VaoA5gIZT
 YQX1Elofh5pYvRkG3GiORaXUV1Xt0JsTEIu3tCf3TmEeWMPxB9IJPfX47W3rl7oAZ0W7
 tt8tNR6OKx61Kuas29JVWvkQafxVLos0LboitSWQQfbFQkha0qqonfXdABk8tc9bQYry
 mHrWmIzR5jc7sx1ubgSsVhAoL+yGmP+hBlF9q/Z/vEEcTYfkDagVVysMunBF+OwfJ3xB
 rEEQ==
X-Gm-Message-State: AOJu0YwdNpL3f1YdytMMUjNNmmAdjUOsI2EGYWvOuu791glD0aNRCMB5
 SCKsl5PhI/vvS83T+CSG8Cj6tr6JLgVGnzbl0MRzPt8q9Pvklrarc5F+/4qW73HU3KIXW9UlwT/
 lAAM=
X-Gm-Gg: ASbGnctXxh7r9HKqwdaGY+g86p1kuy5NblDr+x0f+z0dNOVZfEKQg6gM1ib3d2ov2WG
 TmpnB2hUdS4tY63HvslqYX2H7utYRieGWumKCRAuHlNOm586be4ywOivprkxbKpfV6Z7y8w5Ohi
 w+YCu8eDKZhJJziY/M7pyyJEd85NrU07JiDbIPlRQbw8j1jF+1IVt24czHpzmAbqmJd1pAQ7ubA
 lYP3A4GhhXG8dn52mTx2NhFT4pJr/recJjueAfLOMOQuUqrOyahLoMmaTsnxVgLyutMOtWC7+fN
 LacUVQ+IyI305SDpt34iv0VRq/GZqyXjqsRRhkqE
X-Google-Smtp-Source: AGHT+IFh4QRxgldok8ejMb+AlOW7RVs9e2suqngZjzBrHpJ4vLkou3BSak8+DbPp37NZiV68iixtgg==
X-Received: by 2002:a5d:64ee:0:b0:391:43cb:43fa with SMTP id
 ffacd0b85a97d-3a3601dbd53mr692566f8f.51.1747365040141; 
 Thu, 15 May 2025 20:10:40 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eaf5c6fasm649264a12.5.2025.05.15.20.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 20:10:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 16 May 2025 11:10:26 -0400
Message-ID: <20250516151028.1254207-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fsconfig04.c: Check FSCONFIG_SET_PATH
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

Fixes: 1169

The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
most of the calls there just set dummy "sync" parameter. This test
case aims to verify if the FSCONFIG_SET_PATH operation can be used
to dynamically change the external journal device of ext3 or ext4
filesystem.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 169 ++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e369536ea..658ab24c4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -410,6 +410,7 @@ fremovexattr02 fremovexattr02
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
index 000000000..119b8b175
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ *
+ * This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in
+ * dynamically altering the external journal device of a ext3 or ext4 filesystem.
+ * Case acquires three loop devices (dev0, dev1, dev2), it formats dev1 and dev2
+ * as external journal devices using the -O journal_dev option and assigns them
+ * the same UUID. Then formats dev0 (the main filesystem) multiple times, first
+ * associating it with dev1, then change to dev2, finally back to dev1 again as
+ * an external journal using the -J device= option.
+ *
+ * 2 workarounds in this case need mention:
+ * - To avoid "journal UUID does not match" error when switch external journal device
+ *   we have to assign same UUID to dev1/dev2
+ * - Before fsconfig test we have to formats dev0 associating to dev1->dev2->dev1,
+ *   this will make sure both dev1/2's supper block contain correct content. Otherwise
+ *   you will encounter error such as "EXT4-fs (loop0): External journal has more than
+ *   one user (unsupported) - 0" when switch external journal device using fsconfig.
+ */
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "old/old_device.h"
+
+#define MNTPOINT	"mntpoint"
+#define LOOP_DEV_SIZE 10
+#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
+
+static int fd;
+static const char *dev;
+static char dev0[NAME_MAX];
+static char dev1[NAME_MAX];
+static char dev2[NAME_MAX];
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	TST_EXP_PASS_SILENT(tst_detach_device(dev1));
+	TST_EXP_PASS_SILENT(tst_detach_device(dev2));
+}
+
+static void setup(void)
+{
+	int ret = tst_system("tune2fs");
+
+	if (WEXITSTATUS(ret) == 127)
+		tst_brk(TCONF, "tune2fs does not exist");
+
+	strcpy(dev0, tst_device->dev);
+	dev = tst_acquire_loop_device(LOOP_DEV_SIZE, "dev1_file");
+	if (!dev)
+		tst_brk(TBROK, "acquire loop dev1 failed");
+
+	strcpy(dev1, dev);
+	dev = NULL;
+
+	dev = tst_acquire_loop_device(LOOP_DEV_SIZE, "dev2_file");
+	if (!dev)
+		tst_brk(TBROK, "acquire loop dev2 failed");
+	strcpy(dev2, dev);
+
+	const char *const *mkfs_opts_set_UUID;
+	const char *const *mkfs_opts_set_journal_dev1;
+	const char *const *mkfs_opts_set_journal_dev2;
+
+	mkfs_opts_set_UUID = (const char *const []) {"-F",
+		"-U",
+		UUID,
+		"-O journal_dev",
+		NULL};
+
+	char device_option_dev1[PATH_MAX];
+	char device_option_dev2[PATH_MAX];
+
+	sprintf(device_option_dev1, "device=%s", dev1);
+	sprintf(device_option_dev2, "device=%s", dev2);
+
+	mkfs_opts_set_journal_dev1 = (const char *const []) {"-F",
+		"-J",
+		device_option_dev1,
+		NULL};
+
+	mkfs_opts_set_journal_dev2 = (const char *const []) {"-F",
+		"-J",
+		device_option_dev2,
+		NULL};
+
+	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev2, NULL);
+	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
+
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
+		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
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
+	char path[PATH_MAX];
+	char device_str[NAME_MAX];
+	unsigned int major, minor, device_num;
+	unsigned int found = 0;
+
+	int ret = sscanf(dev2, "/dev/%s", loop_name);
+
+	if (ret != 1)
+		tst_brk(TFAIL | TTERRNO, "can not parse loop_name");
+
+	sprintf(path, "/sys/block/%s/dev", loop_name);
+	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
+	device_num = (major << 8) | minor;
+	sprintf(device_str, "0x%04X", device_num);
+
+	char line[PATH_MAX];
+	FILE *tune2fs;
+
+	sprintf(path, "tune2fs -l %s 2>&1", dev0);
+	tune2fs = popen(path, "r");
+
+	while (fgets(line, PATH_MAX, tune2fs)) {
+		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found == 1)
+		tst_res(TPASS, "Journal device set pass");
+	else
+		tst_res(TFAIL, "Journal device set failed");
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
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat",
+		"ext2", "tmpfs", "xfs", "btrfs", NULL},
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
