Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93C4F8A160
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776338803; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+mhcB/SkIG7RmvHMpEiBgi78RmE4oDf+V0VH+IIhBxQ=;
 b=PQyCz/0qmD+KZ38vq9BEHyeYBRfznp0MsikdXeG4eVm5wq4H7HlhAOWGoetQe9hHLD3F4
 mw0Bb30yG0L74I4/U6kvN5dlr1w5AF7IiAbKPliCOAzLtC+CkXuAqfahXSOX4PsWHpz7kFM
 vw7DuZQm5zLcn3UY3XI/HPnvGfKqg1g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F12D3E2DEC
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:26:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ED9A3C2B4B
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:26:20 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A9531A0092D
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:26:19 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso3364269f8f.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776338779; x=1776943579; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qTQJic27eWPz14TlxJYC4n/tX7dzDHs49m85C3eqfg=;
 b=MNPHrdMfOG0WKJD/INvI678v4TS7QBbojwqRul0FKHj2pzvIyk8ftGRJXc1ADrtKF1
 3dDaFdDo1zDZeuyFt3QS9DGsfO1uflnAF2Mleavx8hvEAxY1ZveunlbyNcL0Virs9kdW
 i6ZczkDsv1gB+X5itaE1g3fsD2gZINukyUxQjxUlxR2Nx7d9Cafj/KVbvuxDPWLvHm2a
 ljqdWV5LWEoRmDL7FxRVMhCxthGe3H9Pex30jqkc8Nt6egLGoj9TbKc3ypNPNUAPkSzt
 t7oRavioGyEjT7/k1NbjMCkKVE2TvLQj0NSv/9IkYLW3aNmktCYrkhG4lKNyqlXASzRh
 jnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776338779; x=1776943579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qTQJic27eWPz14TlxJYC4n/tX7dzDHs49m85C3eqfg=;
 b=KuwakDJQ6uS1gtedpgOqD79wNZALLK9fCkR7zSEAeb/JmZmJYup632GRHcIdDzFphE
 ZJ6CGxzuBx7Jh+xtAjUpcgDBkjR5MIoW72Ss7YZNjv6+EefSJoVT5XWnZWfmcB/vZ8uR
 DGkja7no//jgZaTVBRFKx7vv6nEhmXf6lKO6BRaADImleNJZVgb6rO8cZ+okpO+2Obr1
 ExQy2UAyJUklzQkODGa6pY2u+ia99UwojkvtZkmLzaQYWT5BurfATnQswLZJFVmHoofO
 2NSfryZKLTMazyXoz+0UDTHS6Ugb04vMJPwESzdPDtsK02Un8Dt4mBGdOZ7Tc1AXek6Z
 EFvg==
X-Gm-Message-State: AOJu0YyqHFZw04JJA/WObpHezUpjsWQgr8BppIy0jg+s4LUDlPsjtida
 aLReHZ4RnNtQqMg8PUYDvkk4H8K5KconJyjqZE3bx4zE4jElRgyK+eVy/mb5s7rzd9ctB0m9eFs
 5OZw=
X-Gm-Gg: AeBDieuVzPVPLIi7vSze2IKjiD+C2cWR/pPotrzx9enuZ4oC9hGHhkJf98HFyQi5Edv
 +PwmrJEIw9zZFsMp6+h2aeupDHBgyuXjJcEXlj31ppPZjnvKK3xwr9L/P+IN2FKwOeaIg6c7Gtc
 7oTRZLjM0GmoXhVBurNmTRFMY/CtdYxlB75CzRxAQZTdlwdwoXrNOrOMh0lGr/m3DKbrelwhKPV
 wn7/ZPe0ColU7yN9ssOgxgUs9idPma1qKFgF4zt6teYqaIOqsumjY8I7mmWp4W9C6LAtH1dBWmt
 pAgzBxahpR3f3PQPx5aoz4GnI3T2jjvlhFqd88xtmFl5sK35LONoAzAw7F1NSzh1gVhzSQwZLqt
 v14dPL+PyYpJbc60Pfts+zWEw9d3V8/Y1SbSOs6P2LQYL4g0h5wRtWsjd6j2HMenNg79yP0zs3B
 sGztyepEOCNwY=
X-Received: by 2002:a05:6000:4283:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-43dd037d5dfmr18184859f8f.16.1776338778385; 
 Thu, 16 Apr 2026 04:26:18 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43ead3566c4sm12743680f8f.12.2026.04.16.04.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:26:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 11:25:58 +0000
Message-ID: <20260416112611.23057-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410054750.18283-1-wegao@suse.com>
References: <20260410054750.18283-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] fsconfig04: Check FSCONFIG_SET_PATH
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
v4->v5:
   1. Fixed lowercase hex issue in device_str to match tune2fs output.
   2. Initialized fd = -1 and improved cleanup() with safety guards.
   3. Used PATH_MAX and snprintf() for safe path handling.
   4. Updated needs_cmds to the modern struct tst_cmd format.
   5. Restored TST_EXP_PASS_SILENT for device detachment.
   6. Renamed "workarounds" to "Implementation notes".

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 168 ++++++++++++++++++
 3 files changed, 170 insertions(+)
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
index 000000000..188322a4c
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,168 @@
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
+#include "old/tso_device.h"
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
+	const char *dev;
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
