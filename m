Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B115DCD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 05:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781068915; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6axnZeEhoBN5BHAKGIBR1S+3TAEahkRg9jZgvOh/P+s=;
 b=kF6MTnWj81LeilJxmi2AdWne2tlD3S0RIw3gihaj+Ft3r7i7OsT8vQBOfgUn6Y2xWJvpY
 DDrIhiNT4uxQ6+qhb8788Z3SQoGUzy3BpN8F4TjtVyICWaTXmrxvYQNaF0wHH33gKOBhiu4
 gejIrtzVWM9/cqzUHlUTLdqKFu9XFSI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C2833E2B09
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 07:21:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 844FD3E11CD
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 07:21:36 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AC8166009D2
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 07:21:35 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso72807805e9.3
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781068895; x=1781673695; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAWYENO4/cl7Q9UMSdOfwOIVM1ZRAjdZs0/AzS/13PU=;
 b=dCnouPjgoXe8jAeKe8HTYBmTiYzMxv4xfC4NKvifNWulrTAorCC1586gCpoSilTs9k
 clok3tmN8Id11gnM6JV71F8pma/Le+X2aJJrny440qN+JLUO/pGYNggnVYZWrRkX48ro
 hFknf7YCXbQmsQ+C8b2WI3UCa/bwNZnwc4pM47B0lmE1jYH9h7NHkZKcWCLYHSofTI/q
 YRYpwBTbhJzeFZ2OHs8G4wK5rrxKmGPcBLaYdlEqEYqvRaahuGvgm75KCTKroFol4t3M
 fmypvke675WIjkIN+6O0fEw9NDTVHS+CHD55CBUjdyxuPGvpgNPMDdypSC3utO8aMb1M
 TDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781068895; x=1781673695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KAWYENO4/cl7Q9UMSdOfwOIVM1ZRAjdZs0/AzS/13PU=;
 b=k/cYMy0E195D5xJbpyTqt1sp1i+V/9QgTYzX4yQhTBwYi/7osli2JefacVqTJsKNBR
 TqexqIGJxXvz46pEb4+N5Yo5ymN/rfYwXBosCXyLjhsbtYyojcGQgoQSd5G25v6opcCb
 afblEAwElXfchtN1QEHwgY38VHp5UBc+gUMtnGEz/SZSZivGoehUI0wfwMVoVHHwB6ON
 RCwwATlByytZ5AjrYFeD84TumRSv9yFa/tgJ720j4kxBaP2Nca4iWKNpn3grFx8EVcNz
 Uh1KhmJJG9QNymzC+KxPSzIUPpeMb9ETnO6aP8cKsAnvztQ/kb4PcYAL0QNDGOBNSCo0
 JYjw==
X-Gm-Message-State: AOJu0YyAzCaYvTHDUa8koXGbJSUe6gmrM8G3q1MqI+Rj8dE1X90cBT/6
 7jdEkjrb9rqcC+hP9LGPqWRQqYRxFh1fdJ4UUr4mFkL1biSZy3UJiGk7sSQbIUZN++G8YIGKZc7
 iM6Y=
X-Gm-Gg: Acq92OGJnCaoSIaeCZbJes2GV2MhbItx+IaJNwyTx7Fb7zIJ8MbIorR+/326lCwbtv+
 BJzJKAGM75QjmjRDUHGUrZJC+tN0IJzTsm5JZlqHSuIg3Iv7UjHiEjsl4nUlW0hEUJnyht6BDJ9
 HTFd9w0dP/0TMA/Jc9lo8jle9WCOjCiwwpud+bK0QKJM0Pci0h4gE826tewENw0WiqWvZz8kl0F
 5ecgxg6Vy5TUNldJiMq+mkIayQMiUQoMxjMYuqUXcop3/qv1kSq67emWIlTMZPNRkkPH7KnVEGK
 h4fIsHWjw+6+69OH5EWESuIKSoWfjdd1Evi7NidMF5W+xp6oCz4ACIhvhcn+WnA72VyEC+rz6KS
 IHkgq8nNAO6pOZfODxXnPDERE01ijrhqPkqOq78RKnxHB7gliPUKpcHBYES/X9YPLdzNFcdjjbQ
 QZjDAxSme3nEVQmSBWZTQ5qQ==
X-Received: by 2002:a05:600c:4e09:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-490c25acd18mr412372635e9.14.1781068894935; 
 Tue, 09 Jun 2026 22:21:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490bc3918d7sm500018845e9.2.2026.06.09.22.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 22:21:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 10 Jun 2026 05:21:25 +0000
Message-ID: <20260610052132.2727-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430051915.2178-1-wegao@suse.com>
References: <20260430051915.2178-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] fsconfig04: Check FSCONFIG_SET_PATH
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
v6->v7:
   * Doc Comment: Rewrapped introduction & added Sphinx :manpage:fsconfig(2)`` link.
   * Setup: Added fsopen_supported_by_kernel() check.
   * Logic & Results: Replaced tst_brk(TFAIL) with tst_res(TFAIL) + return.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 184 ++++++++++++++++++
 3 files changed, 186 insertions(+)
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
index 000000000..7bed0111b
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,184 @@
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
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
+		SAFE_CLOSE(fd);
+		return;
+	}
+
+	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP) {
+			tst_res(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
+		} else {
+			tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
+		}
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
