Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B08FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 05:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777526382; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Ua9fsL7nXJp07DtC6J87sJizvSWw/S78X0RR2aM9ND0=;
 b=UVQc74PobbhXkEJy07GzNKQLAEJZOLhkWv/6QXYQptJjDG6YXdNSki6aWRkUBMQQWIFkE
 5ZI0xLoOhHKTlep+agLo0fHMqOyTZdA99soeCDSynqT1BdeAT5qNbQJi6ZZNSmbWGB/+P2T
 C1tAc6onJfFOpujxVNlOFsnDSCsKemE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E11CE3E182A
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 07:19:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD7AB3C5ED7
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 07:19:19 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AC3FD1A0037B
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 07:19:18 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48374014a77so5062055e9.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 22:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777526358; x=1778131158; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jA69VNxe8pEXVQ7AIskqtx3z4p7+0nq7Ms+dDhJCMA=;
 b=XjjFHO1R3Z339Y/q1REMJGcrSPVmw8Y+qs6dIbQON065zbqDiLkMDaTaQoeIFYYmoY
 JVhOEhdXqIeqXQszF4JGbCSFk/gySaHsDePoMK6qJTOoEq7NnvL97/rh4RQQOtHbklmR
 Ba1QGIJIBl4+yYJFCQ0oTvoawu4j+lEnHej8rXQXyZiY12crhZui07O2mJsaJq7sVkc/
 uJAtmwPBfkgjIeHt4iH3rs0i1P8SwqSteDzLRKofJEqoIVQ0KQ3mzSO4GhPUDJXnqCch
 0yyTWNtnTU0cunpyUK55G0W/cxdrzzvXjgVXRHluR01N4kskkVvPwhZQWkn2/fcpi5do
 9EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526358; x=1778131158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0jA69VNxe8pEXVQ7AIskqtx3z4p7+0nq7Ms+dDhJCMA=;
 b=fpEeu5RTrw9kfvI0VbMUFDQbq69DpROcKC8HRoD6eDeYTCo8Jhc7F7iaf9plwsA+t+
 f3Dmq/NMhq+MNba/hiKV5RgBziOz6dClDpJQEqC2hPTihargH2lBZyvVoHnYz1YMN1Uk
 mAymK+JQbj/pzyem0znHZUIETqK4naCGdGXYvnI7y9QMFJcITF8s5LrkW4iNltUuVntm
 GBs8zofm4pNxYhEZhqKhP2N4kvP8Nu57fSc2z9UCJ7ycqzQ4IUU5pMmwTTosxhCYMSxI
 0yHMtjIb3nuwjowwyKXiaar39SBBHVDtYtj+zs5vTjpxJuMHabASOqW0N0wKkOJ9u3QC
 k+MQ==
X-Gm-Message-State: AOJu0YyE4koPzJQFSMwAluDLwpegNw5k5fWvAE+MjTVD/vk3TsCUdfVP
 aBSsyrdcX3CCZz/nk+HwFiJ1Y3W4UDdDhH90Wp5nQHdpwrInaBQleWO5BUF4qf17vwdt1H8AZOr
 SEy8=
X-Gm-Gg: AeBDiesiWuxN41f/YAz9Lxbz/xR4PfLm4fhIrMg2Vz1rLRE5MObyD4NQyQWchpWWNho
 k/F2yD/BVB4y1XINqLBWO7Y6PxbDoJXbFlKLoLAGkxczLM6ESdaOvIJLLom4QPi3mNDS/9fHdBv
 JkUvFiFdstsLgxf2LEFt3h/AYeKyPbOeOxAsYXpLdmFR5I/bxyHdq8sq48NXdC9G9dTt2o0klGm
 qegWkCHqWaUFmDyBOM2YUDXGmuLVOJmuSwlZXK30gj6Wb3imDpIjpr4qKyKkbd5Eiw15m0I2+pR
 xNLmEKkFSAe46aUddLUB9S6ORHgb2DkAd5Bdg1g/5Srp3lOJOOmjEAV6hOK/F9CYH/imkF+Y81G
 c7h0Y6xvtzZObvxY41i8gyaygBrWIO8YEhakcLxBLYZg+f5cjuOxzpnYDGZdNRAEgnKEP1h5dRJ
 NaJRZnNGF6v3pjM91LHNzg4Q==
X-Received: by 2002:a05:600c:6285:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48a84486f35mr23637445e9.29.1777526357648; 
 Wed, 29 Apr 2026 22:19:17 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a81b99127sm36825955e9.0.2026.04.29.22.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:19:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Apr 2026 05:19:07 +0000
Message-ID: <20260430051915.2178-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416112611.23057-1-wegao@suse.com>
References: <20260416112611.23057-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] fsconfig04: Check FSCONFIG_SET_PATH
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

The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
most of the calls there just set dummy "sync" parameter. This test
case aims to verify if the FSCONFIG_SET_PATH operation can be used
to dynamically change the external journal device of ext3 or ext4
filesystem.

Fixes: https://github.com/linux-test-project/ltp/issues/1169
Signed-off-by: Wei Gao <wegao@suse.com>
---
v5->v6:
- use `tst_find_free_loopdev()` + `tst_attach_device()` from
`tst_device.h` instead of pulling in a legacy header.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 172 ++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5025b259f..84adf4fad 100644
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
index 000000000..f00ce88e4
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in
+ * dynamically altering the external journal device of a ext3 or ext4 filesystem.
+ * Case acquires three loop devices (dev0, dev1, dev2), it formats dev1 and dev2
+ * as external journal devices using the -O journal_dev option and assigns them
+ * the same UUID. Then formats dev0 (the main filesystem) multiple times, first
+ * associating it with dev1, then change to dev2, finally back to dev1 again as
+ * an external journal using the -J device= option.
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
+	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
+
+	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
+	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
+	device_num = (major << 8) | minor;
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
