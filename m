Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD32CD4F26
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782454502; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=2ipklDn7MdokYgpLrp49OcAqEn6dsNl/EnNZCfsRBMM=;
 b=KNVcvC8j2nXlODa9xKngpngqtNUYVxn4oOof1uQvD21nXDT0LLloazQtylrVd4kW1llr5
 xYFK9p80UgYHKKg6DirNJ8FY2pI/jMCDL1TtZq5IB5xJo73spPdpDdV37FQVnPDEZF7TExv
 sXxZZ2Uuso+8FaUgpo9gzCPjCo3/QuU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 184B43E29D1
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 08:15:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0309F3C73A9
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 08:14:40 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A04B200217
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 08:14:39 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so3221675e9.3
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 23:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782454479; x=1783059279; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5J8QsKGuGGX6tQkg1oxlVXl50fKHnV06oEu7p4+6QE=;
 b=CQ4KZyujGRC6uD5+CgQEjtro5n0NVTBtTGR0n40sW4Gg8f6XnKLjLzOno6B1ykA3Ca
 Tedt+R7Xk87PP9g7KsS+5WG/yk+yKDq9zpivl4XuhVi5Q8DhYAE4IJ5SQc3Iv3wZLe0u
 IM4omPfs/J3a1Wr65fOsikuYLL2b2zy5BLXrxmKM9uBhjTphwMzJJHbpJPxUQqnKYoVA
 rNfTtXmYD2IkTEqVA4D9YidNF6EtfnOT4P4KeKV6pntNv4cUalUaylEcOqwn6KLo7pwf
 qZDcLE0XZkTtP4vlBS7iMi7P4JduNYj//x3PZkNVZp6IRUDIfcgSO1MFct09KCMMyTNd
 wXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782454479; x=1783059279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s5J8QsKGuGGX6tQkg1oxlVXl50fKHnV06oEu7p4+6QE=;
 b=mpuDnXA9nl4PtApHbEPh2GM0etRgrXJFNhtTx2z/zbCecjYMWzyTV+xosq9HQEWsqU
 U8OHyN5EIGbCIU0IBdU6N4HW0fBy83x6SkDyqzsmj8LrZ7boRtPxeItLYupGiMs7v/EX
 88lQJpO7R4rb9dlFo6nLlvFiybqcZ6Ma2gjhB/i2bWljNr7H0zl8PWzBWb+qV00h03F7
 ANgyTIw1CQ9xy5dJZO7nnjScPJXktyYdz7Bvtx/fQTQVjhezdZ1ewwuG+nyr7eFvTQxh
 IAIkJ1bWPmO52/W6YGuIY2FNVi1lkQhEASIj3+d5IB7+z8n25yhOPqAApEyZX82RRXIM
 UALg==
X-Gm-Message-State: AOJu0YwxC/vbK6oC8I/mwT9vpGsADMDVAM6dH3rrq7Ixk0hIptuZmoIk
 OSazhjCVsnLw8vRKTjP/7iSYBWa9Rh0hl83Fdhi1G8bPIuzpMY4dUNliyQ4BDBR4XgGFGDwDMa8
 qSk0=
X-Gm-Gg: AfdE7ck/Pk0oAjL7LB0ubc6bP9G2tm0VKp9uZdHnR7ohZmYKMeXAFmwlleqjxN7kT65
 0WgkKo883CFCKjfM/Kz9X/AY1blHrfg+X/f7Vc3YcLk6mYBwccsgEzylzVEDmAnxOKycEn14ioi
 O/+/xuP+pb9a5X9gPFJir+aq70IhO3WoNQudpbNF46fZMjXvjSO8aeZ0IYiWYzvHzJz3mLmauGh
 c7rX2Ro+Meb/SbTnSBTXrEsVMmfHRiPTAazuxXgicUTLTT4Js2xZ0ttOFlBscsvbpnnJIpbHRcg
 ezjXLdvveAmPzl0Wjkv5ezWtJLVyJXYo9J8FvRhByLcdU31Mmn0vyiDqKuZWWknw3jcBAuU8Na4
 FfE0Ywlv41OI5igclT968EKZJ4DTyJentqzESylc39OUZkWhGlwPsuplhQ4ezh+HTj+G5jAQV8I
 hT
X-Received: by 2002:a05:600c:4e4b:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-49266872cd7mr74097185e9.10.1782454478636; 
 Thu, 25 Jun 2026 23:14:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49269002511sm51333645e9.8.2026.06.25.23.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 23:14:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Jun 2026 06:14:26 +0000
Message-ID: <20260626061436.15253-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618023820.9823-1-wegao@suse.com>
References: <20260618023820.9823-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] fsconfig04: Check FSCONFIG_SET_PATH
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
v8->v9:
- Drop braces for single-statement inner branches

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 180 ++++++++++++++++++
 3 files changed, 182 insertions(+)
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
index 000000000..ce6c8fd01
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test aims to validate :manpage:`fsconfig(2)` with the
+ * FSCONFIG_SET_PATH operation in dynamically altering the external
+ * journal device of an ext3 or ext4 filesystem. Case acquires three
+ * loop devices (dev0, dev1, dev2), it formats dev1 and dev2 as
+ * external journal devices using the -O journal_dev option and assigns
+ * them the same UUID. Then formats dev0 (the main filesystem) multiple
+ * times, first associating it with dev1, then change to dev2, finally
+ * back to dev1 again as an external journal using the -J device= option.
+ *
+ * 2 Implementation notes in this case need mention:
+ *
+ * - To avoid "journal UUID does not match" error when switch external journal device
+ *   we have to assign same UUID to dev1/dev2
+ * - Before fsconfig test we have to format dev0 associating to dev1->dev2->dev1,
+ *   this will make sure both dev1/2's super block contain correct content. Otherwise
+ *   you will encounter error such as "EXT4-fs (loop0): External journal has more than
+ *   one user (unsupported) - 0" when switch external journal device using fsconfig.
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
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	strcpy(dev0, tst_device->dev);
+
+	if (tst_prealloc_file("dev1_file", 1024 * 1024, LOOP_DEV_SIZE))
+		tst_brk(TBROK, "Failed to create dev1_file");
+
+	if (tst_find_free_loopdev(dev1, sizeof(dev1)) == -1)
+		tst_brk(TBROK, "No free loop device found for dev1");
+
+	if (tst_attach_device(dev1, "dev1_file"))
+		tst_brk(TBROK, "Failed to attach dev1_file to %s", dev1);
+
+	if (tst_prealloc_file("dev2_file", 1024 * 1024, LOOP_DEV_SIZE))
+		tst_brk(TBROK, "Failed to create dev2_file");
+
+	if (tst_find_free_loopdev(dev2, sizeof(dev2)) == -1)
+		tst_brk(TBROK, "No free loop device found for dev2");
+
+	if (tst_attach_device(dev2, "dev2_file"))
+		tst_brk(TBROK, "Failed to attach dev2_file to %s", dev2);
+
+	const char *const *mkfs_opts_set_UUID;
+	const char *const *mkfs_opts_set_journal_dev1;
+	const char *const *mkfs_opts_set_journal_dev2;
+
+	mkfs_opts_set_UUID = (const char *const []) {"-F", "-U", UUID,
+		"-O", "journal_dev", NULL};
+
+	char device_option_dev1[PATH_MAX];
+	char device_option_dev2[PATH_MAX];
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
+			tst_res(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
+		else
+			tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	char loop_name[NAME_MAX];
+	char path[PATH_MAX];
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
+	.format_device = 1,
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
