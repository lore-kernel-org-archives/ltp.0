Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26089C5AE59
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748943956; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/HqXiTqNXzw/PjhLZk7X7hCTlO/OeEuHt7Gc9Hptagk=;
 b=bpmUxLIHuare64qg43KG8evZAOHT2+uO1Ux+KWUNntLII4s3SWFMGFReNQF3UTNTDqtcq
 5G/8h4+bQ7xef6QoPqPsNNG2tmIG3tTW4jj2YP8kWxrbcQ+w2YxExwtFAg4FVYZ+7tdQ6gT
 5tMONmnOGCbf8rhn5m4gLOByI1hCMHI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61C0E3C9E90
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 11:45:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2AD93C9E90
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 11:45:34 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 60FE2600BCE
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 11:45:32 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1085515f8f.2
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748943931; x=1749548731; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEzPeYor9HBenB4smbhl085/bYdPZMbxV9pOeLN32rA=;
 b=dTEvehkRmdiMAu5U0vZ658ECnaG3RcqbPH8nW1HtlS+paRu6Zy+LB3bM3fodse+2QZ
 uV0Mtcvtr7CS23XaiTpb0ipbCVLUYu46M6lSdzvfTx9PfmslkQ50IE1b6HihemTDfDsD
 H8pX9SWcAeG4HwFWj7NXRjn7L+noVIL/Q+OAnhPHR3NZIbVaWsK18KJldwwI3pMFKLzD
 Hq0/UKpcvKrStUE51akDXoQXc++i+PQasWvKjntD/oqZx5fhJfUQEC1zSXSsmp+xifVa
 yp5XtZBrZDowuUmkcCPI1FI4kG/b+P7dDgOBaR3ZdDLy/kPSzQRZOr4Rz4qqAxPCqDGF
 4+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748943931; x=1749548731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEzPeYor9HBenB4smbhl085/bYdPZMbxV9pOeLN32rA=;
 b=jZRsi8/WRaocewxgjiFU6kqPylUFHmM15jaow2GbZI+/pNP+vbDYMt7BqbTl7iAXtw
 ppaNr8ikmqVs7Guu5gL08kiWYs7ys6eqIvgAPjn0uCa8Uh/MYcZsz1ixGYW+X7m8euQx
 iBdScVCyi5YWekD2Awegeh1lKBhQTnHjuw5jFggDIpCVO21JT2rcjktDaX1UCpK+ELZp
 2OqXlHCnaHvd2/N0dULW+yp1DBKRBdIXXo0ueU3Lgu1V5cATvj6nUASX5BpdhmAdfEL4
 SWHVaCoLGtBhyG+kARISyWrmwieIzYqQtZxq5Xklf4mxzoCifSLP6XCvWUJJitpgL4rZ
 co9A==
X-Gm-Message-State: AOJu0Yz8jKg2i9rXWk8VSNVHUBV/afhZzIRr5wgLGMijRiKZSse0gPc1
 8so9Bo2PnAfTgx8M6zLZt0F62UZBgxLeJxnej3hQyggotLUtMHkWh4y6hYPHdattxl2qm7QYEuW
 7Gmw=
X-Gm-Gg: ASbGncvBMfYYJDnu3UQdpVm2EDQNgaYavHHeF5S3PImRh1E1iWi3OI9gskcJLtyoxOu
 nXP6xUJws6sWwtobcGmJeHxbprRo+fDO/IOh4n6Dh/qbdQj6AiasS++p8JwrlD4iG7xZESaarIt
 veymlkE1Y6CqbEgBvHKo4fpmvIKpYiZ8pHmkcvfqLLzOci06+8Gbs8lOToEuIO9H6rIyD4i2Dcx
 ZrGK+Gz3pEnAlkZ2KmP9aOAlA+9bkvMnwTTbMF2AztXpjYEv48Z6AI+S553mt19mE15YWKOTZt+
 dB13yAyjKfsbShDLi+v/vsfm0MFBIQPfuXkElQhmmTER/NqDIXY=
X-Google-Smtp-Source: AGHT+IFSPFzyHcLEdXRT+fh4OBl1qo0JSOLbiiSo8OVi5PRWive4EyaJNXQWoCBcMuLKJg0pBxhVnQ==
X-Received: by 2002:a05:6000:2303:b0:3a4:ef00:a7ba with SMTP id
 ffacd0b85a97d-3a4f7a3e8e8mr12811689f8f.2.1748943931373; 
 Tue, 03 Jun 2025 02:45:31 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747affafc1bsm9260738b3a.105.2025.06.03.02.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 02:45:30 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  3 Jun 2025 17:45:01 -0400
Message-ID: <20250603214503.3792293-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526143551.1321709-1-wegao@suse.com>
References: <20250526143551.1321709-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] fsconfig04.c: Check FSCONFIG_SET_PATH
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
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 162 ++++++++++++++++++
 3 files changed, 164 insertions(+)
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
index 000000000..c86dac0d2
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,162 @@
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
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
