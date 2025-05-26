Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A65C54F30
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 02:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748226986; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=wMz+JTxHLmsWZ7wpH22Ws5awy4gWo89jfxNgX4Sp3lg=;
 b=X8y7r/4FwJd4D/0QLQdMOYrtGvac89v7BEw3likiUpYfdAjhl+jfoVz3abPY3R3FXv+9k
 bjMyry6ipkrI0du/qUVJKV5yd+6uLZwALlYbpxSq3GUCOzboqQTZd8T+qROTn8z7fQJva+6
 zTx8tfbxPcDm/B/ynLNm3EOmNR1+sBU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B7D33C25B4
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 04:36:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80BBF3C0F82
 for <ltp@lists.linux.it>; Mon, 26 May 2025 04:36:05 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BBE460083B
 for <ltp@lists.linux.it>; Mon, 26 May 2025 04:36:04 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so13200845e9.1
 for <ltp@lists.linux.it>; Sun, 25 May 2025 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748226963; x=1748831763; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7z/EGtAR+/jGaVqpaSEF9Y7eMo2P24/sGTp/hoGKMc=;
 b=YfkQHjUY1oiDzIMopUDbB9incYjHfNtZDRNZ3CCo4Uw4UcorjxmRkqfxI3O8b2D3i+
 q+OydjFzeJOC2sByZsailP/wDUVtF6KFOPeBN9f0c9SaHpBDjZrcMFF4falPGBUCBHAB
 8HC/+CVLiuDSf4zbSwiZaZVYgvkgNr5xp8X+COmgv3drRRyhoAch3w0LKoyn2I1VlwPx
 t+AgUIOKtOzYK8cpBnSQRkfVtrjdc61IQToQuo6eT6hUCG2sv8mpy6HWF+XihrVbln35
 AJKUH/ciLIAm3VJ2dFTZAXftXOkraccl8+5GWHEz+w3RPrrtv4H59OTFDNDfn8OGsjKC
 5nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748226963; x=1748831763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7z/EGtAR+/jGaVqpaSEF9Y7eMo2P24/sGTp/hoGKMc=;
 b=iEhTNtAO65aY/wDWmZ0V2lAuMl/c/YteN0l9zS/mUKbLpSdtEDKP4Z5VAalqkFsiDd
 GovG2QZVykmtF6S1y4jwbug3dfVvJqoALq19X8S0hcr70koi5a9+jDBEf1NFmSb2eMM0
 HI2g6fir4ERCRP0F0xWsDLK6kw8iwVAxASJzagyDz5YTEey3a70vLeL0og5h8FcweSXQ
 zMV/sUOs+JQXEFLiquVm638hwbCwBkt312+FxJ4L3eO1svG0lMFd9QU3M+7nciy3iamq
 V/a/iODQ30afGZlW5VejgZsZDixOljVUXe3dDQ+69ZqKWkS/HQ00iViNDDVYY9ExCUW/
 rA1Q==
X-Gm-Message-State: AOJu0YwQPTB13RDg0Dc+RtNtXb+WXz8ZgZrFC4NOBuKY40yrXQ4N508x
 OFl3gNh2NboATUYDdqcqynBQrGfTI3V6kWARLQDVumtKnmczRiuQvJy776JUIv2dFJCktGe6d/G
 Xjm0=
X-Gm-Gg: ASbGncuYEXZ0Z0SgRbCCHgIHnhPbNdrhQfPWoMBOqnVgLycrFxALaeXL3sF4fHMBo5E
 QVBQ2Buk+n6HuLCF3GrrATNf4tR/LeDXxMT6QVfdc0zdeyAEbQui5QsRcmdI60EbIXwV5xLdReW
 8Q/0/9Avy3/xvYFl17I8dP3OuxM6eGq7WDEdFclyLuBf27FUxIFuZEeXMnf4nL7fk3xXokG6M0X
 XrQjagWkWgxxAK5zJJfFDTyhyKT907eqMaRhJTQrf1vrkH6kuORLTIFTR686kSUzwxoDOdxuv63
 OHFudk2/ZMJdXOchR1/4X73QrjRuOHKBXrexYP/M
X-Google-Smtp-Source: AGHT+IGDCXJKAA4I1xgMUvANZBW1iHvjKK69o0FFUZUcyyQ84dJpLP9G1TSiTUegrLsN7vw+1LkXyg==
X-Received: by 2002:a05:6000:240d:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3a4d6eda63bmr2072737f8f.39.1748226963541; 
 Sun, 25 May 2025 19:36:03 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23449586778sm14194425ad.210.2025.05.25.19.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 19:36:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 26 May 2025 10:35:36 -0400
Message-ID: <20250526143551.1321709-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516151028.1254207-1-wegao@suse.com>
References: <20250516151028.1254207-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fsconfig04.c: Check FSCONFIG_SET_PATH
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

Fixes:#1169

The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
most of the calls there just set dummy "sync" parameter. This test
case aims to verify if the FSCONFIG_SET_PATH operation can be used
to dynamically change the external journal device of ext3 or ext4
filesystem.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 163 ++++++++++++++++++
 3 files changed, 165 insertions(+)
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
index 000000000..0df16f0ed
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\ This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in
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
+	.all_filesystems = 1,
+	.needs_cmds = (const char *[]) {
+		"tune2fs",
+		NULL
+	},
+	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat",
+		"ext2", "tmpfs", "xfs", "btrfs", NULL},
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
