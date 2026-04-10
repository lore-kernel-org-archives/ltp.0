Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5868F36BA9
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775800101; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=wDpT6EiG8ALmCxYEgVfJOTc+vvNzSYgLxnr4r0x4+WQ=;
 b=FAt2q21ml2ld9lic7Z4WKVBe/oyhtYC2Y/KH7xROHk7sMuNi3ORzLe5j1oP1vecQ/17LA
 qXyuPgHxJPuuGe/qLPPMN/xFVOrozpQff5DWvIrl3f3GribtpK6aGrTUVgHMMt/QmHB0FQr
 Fqhmfo67ZJix9Qb18i8M36gC9JpKjQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DFBD3E1DE6
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 07:48:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 204383E149F
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 07:47:55 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1711B1A0081A
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 07:47:54 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo937961f8f.0
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 22:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775800073; x=1776404873; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ud//P3rL+V/d77Oq7c/MCMUc85CtJBz9By+ouumU8k0=;
 b=NUHNpG1emifgJm3OQt6zVo0UqQ28gIe20IbsHPxvk5FL2aKkf7AZUiCujo8RxqheDo
 tULAwqN+Fbda8Mf3oCR/X8LaiugnsZ4ms+bOZxqKUwt49jbOvJjND45KL+eA5X4lCk7d
 UncFnbNvPxCJTIqMsNl8BBNxAoZM8cdxKKqRAP7oIGUPtNY48E5RHHKw4gnuauafsbhy
 3vhUyhLK1oLZ9c/sJPft/3N+rKbzbLxheCEJK7LplInuW+wZZF/WD9lVeCYmrysvsfCU
 WKo/CHEtKIV7wMSn7v3wTnzsU8G43koVwp1GdRck05bWpN5Nh4Jub1gWeWjxqg2pVRmU
 FSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775800073; x=1776404873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ud//P3rL+V/d77Oq7c/MCMUc85CtJBz9By+ouumU8k0=;
 b=T1VSPZLLbHUPjmAtewlcclcsdE0oqYDsPyMWLCiXAmVNT8KoxuC31vkMHejzf7fNn/
 LfiybFHx4gv9+/H2fwetR5ucLjW5fEVF3QBA3lzyQ3MPjxY+I3pixuD01u+xKZcbE7sk
 2HbQCN2hT8pp8Z/O1VnuMTlVBC2vMp1fhvq6uQiNgufp7/TFLOdqTwObyn5Q2bGAxRHu
 1qty+IbqU+mKcGJN5S6DmVDJ1Q6va+V+DYzMX9Yh0L68xehBDxWQKjYSCD2T9CySJu0d
 a3L43QzteZQkwUd63D/t/EmucN72JKWpLPU7RcofuZHF3SRaLnNG9EKcHJ1kNp4iYel7
 rfGA==
X-Gm-Message-State: AOJu0YxhF2SKBUFxTQZs6TQGpjTefzEMaXl7b5W05dGcRDzPiGdk8e3M
 Jzr8qf0MvY+xR8C3IV/+y59aTOqk7MBUQaNAjcsv/ZmVXAGZMCy3xYkit/6hXh540AtUx4lv0W7
 Obk0=
X-Gm-Gg: AeBDiesLSFFnLc1QGJNizrtjenooD4MIlyKRc6MnF5pONWdG+rD2/2OYk7nstCns6SC
 IRe4m3Kg3MWsNVf8xx6S6N/7WvpMjwjC1Fx5yGMMqu9JzbTb8zohma6jYMTmN4J/7gd7FzqkAH/
 qnSbj88WlLDpJlH2Pq8TWVSGyQuDmYTnRmOqHMI/bDFdYlbqiEA7AWjPOiZG7mxAs40tKiHdywv
 x49LzifT02XnIxGqxUlffxdYT//adsZVjKv+WgA8T2aNRS8i2qZvyTAO7xA3fiirFU9dTd0v7LX
 5tROz/xVQja3OnRyu8BeMH2b7PsTnMOQeg2YuXLj+UOfmds+3TrTYA+E/GS01LFdOlln+nAOVQb
 wmipDWk6rdv+ZHeQJh0cmFR5+vOvDidtOkLuTZBB6pXEIR9c9PwZOwLvK437EOcbtfJVHPJM/89
 Bixef9p1+aCOo=
X-Received: by 2002:a05:6000:1866:b0:43d:1bf6:91b with SMTP id
 ffacd0b85a97d-43d649741f7mr2340500f8f.16.1775800073126; 
 Thu, 09 Apr 2026 22:47:53 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43d63e5061fsm4433301f8f.30.2026.04.09.22.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 22:47:52 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Apr 2026 05:47:40 +0000
Message-ID: <20260410054750.18283-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603214503.3792293-1-wegao@suse.com>
References: <20250603214503.3792293-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] fsconfig04.c: Check FSCONFIG_SET_PATH
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

Fixes: https://github.com/linux-test-project/ltp/issues/1169

The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
most of the calls there just set dummy "sync" parameter. This test
case aims to verify if the FSCONFIG_SET_PATH operation can be used
to dynamically change the external journal device of ext3 or ext4
filesystem.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v3->v4:
- Replace popen to SAFE_POPEN

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 163 ++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d72fceb5e..49ba7d845 100644
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
index 000000000..c6ff17f40
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
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
+ * 2 workarounds in this case need mention:
+ *
+ * - To avoid "journal UUID does not match" error when switch external journal device
+ *   we have to assign same UUID to dev1/dev2
+ * - Before fsconfig test we have to formats dev0 associating to dev1->dev2->dev1,
+ *   this will make sure both dev1/2's supper block contain correct content. Otherwise
+ *   you will encounter error such as "EXT4-fs (loop0): External journal has more than
+ *   one user (unsupported) - 0" when switch external journal device using fsconfig.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/fsmount.h"
+#include "old/tso_device.h"
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
+	mkfs_opts_set_UUID = (const char *const []) {"-F", "-U", UUID,
+		"-O journal_dev", NULL};
+
+	char device_option_dev1[PATH_MAX];
+	char device_option_dev2[PATH_MAX];
+
+	sprintf(device_option_dev1, "device=%s", dev1);
+	sprintf(device_option_dev2, "device=%s", dev2);
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
+	snprintf(device_str, sizeof(device_str), "0x%04X", device_num);
+
+	char line[PATH_MAX];
+	FILE *tune2fs;
+
+	sprintf(path, "tune2fs -l %s 2>&1", dev0);
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
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.needs_cmds = (const char *[]) {
+		"tune2fs",
+		NULL
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
