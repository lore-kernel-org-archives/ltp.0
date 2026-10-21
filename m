Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6B606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=VyqTfcHo;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=d5hM2yzD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792572598; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=clABHNxApDan9GAdyD2tHgm/aOeKf4A+JscTdkxJnR8=;
 b=VyqTfcHoh7TpIuIOtctjcljjsca+XKa7tlHlaZEZy6bNBVK+pA+Q++cz6fEQF+0CCLlYc
 OC8wuhVHRy6ZL61T1bMaKBs76m0ZXGyXZGUsbjG/20mL1TU3x+X4b6x5VarwvTZpCaH9tQZ
 FPGN+qHX/BI9JmLn1NYpDpKQ8pzqTrs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 194A23C7A3B
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:49:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD29D3C2313
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:49:37 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9713720005A
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:49:36 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so475835f8f.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792572576; x=1793177376; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WbHT3zEpSzN1fS0oB5Z/UfGfgBA1jn6fyJ6JQFrE4/s=;
 b=d5hM2yzDgnDRVlYSxA0ZWrfS0gcSbCQNjiS1AbIb0srCKWhiNt+mjhpIZS7BMdlrbZ
 iut6mPuZ4wCaiy3eN2wkDixdKpXFqU+nYvSiqrg+8Hvt6xHaLYh/0Ny67BqGKi3xPMbw
 QEYRrJMYruYEtMEA6kOcwAv4eq++ufaS9TAJAYfDJVkFxn+LvvkYB2isxfv5BEpOMBup
 xK+p5BmoOAqROnPR8YPX09PVKCt/xWouUNccz8tD5ul6KuuVWq3gmN0EqqrEB8tfgR7i
 fhTzGoj5eUtO0ceBrMc5HMVZWUFGfJWps1+xuZueiLB+dwMzwM5SJaPgSDwsJPUZHZyd
 ENNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572576; x=1793177376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WbHT3zEpSzN1fS0oB5Z/UfGfgBA1jn6fyJ6JQFrE4/s=;
 b=xYqpQSJAhQZjVGOeDtQju9m7xtkm/ki7tXe8YySjkSgSgPzUGKoS8ZVTUISIHxJUG9
 FCV0NLELMCuw4M1s4B2LBCUhMnCZRf6HJ+SDihL/gnu24Htjw5r6JCYFn3hu14gXkEgt
 LiwnoHYlWFzbN0uadoNRxag6toEc+8CYoE4rQR8n9Fz1eW0OE8ZJ4VarOmOW/KustYjX
 cbNUAa8t6YHSxRb0heATV1t8NE8sD7X7FF4RcpwUvOin48b3ceNmfPh+dDv3Ij971OvS
 8QstvYBV5jmOIlj2osRKjFASufZ0YFLa6QkfwKcijFKXP1dF4ODUzoLg2KO0kOAtt0nT
 xCkA==
X-Gm-Message-State: AFq9FYK2ZE2yy42hVpqvXAjluqV42o7/Hk532B/RecJMil/b5enzW5uR
 Y1o8Qe0uoLTB7xPsVMr7jphuo1dRGHEbZocCfnb6t1Km0dTkGO1l62ODvOPB8rR0AGXmzACxkhF
 TSyI=
X-Gm-Gg: AYBFou11HcSu/N8Tgk3PbOFDG52yYTPckXFLUDUBnv1SBScoXWMaT4nZt+VZZPRrV5v
 HMBYvrnDcUTBQ5Gt7nWHSPl/79VQvoFyCX8ezP/fQdLH897AmDxNU2D5/Ddskz72+kO1XS8RqJU
 2IOlDNjzEwBgA7vtRtlxbFnyMVmR0xsW8fIbJfwGqNAjYZCK8TFbezMtPPuZNItvEb8z4KYexQZ
 g0mBn6Z3ueHOwk0Y/DIkT7X3akXWt5OTNilUVccSsY0t+quXc9TOPrqq7/3fmRoXc2gfmKVgcqC
 3vfnDgtfmqskYH+x61LUwEBPrO8EdDuBvIXTe/Id4mjycYOo2iaiKgrlxaorcssYTFK+TUIez7p
 TACj0TFSOOv2LMQZROg3OCepUoICK1yDvJxSHchlnuiqjZ/JUKId7SIREHC0ampeQ781T6Ii+R1
 JXuHu37o4FlJIIvtc5YFy1m9wpJVx9BvjFQ5Zz7DT3kmZ/gBtUyZWkBsrti2LAob37QEjYcqiBh
 6TFK3bo2hWIuXSYTD1yihVnO04j573pcbkqyrxrNREzZClfRtTgSr8vkGOGnI3kLQAv7irAZcnn
 ZanR60dLe4BTxa58VCQODRIE
X-Received: by 2002:a05:6000:4a15:b0:48e:a9:9e2e with SMTP id
 ffacd0b85a97d-48e264a6338mr2617934f8f.14.1792572575908; 
 Wed, 21 Oct 2026 01:49:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48e254f093asm4439698f8f.4.2026.10.21.01.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:49:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 08:49:12 +0000
Message-ID: <20261021084933.19097-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917024609.20527-1-wegao@suse.com>
References: <20260917024609.20527-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17] fsconfig04: Check FSCONFIG_SET_PATH
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The fsconfig01.c does not test if FSCONFIG_SET_PATH has any effect;
most of the calls there just set a dummy "sync" parameter. This test
case aims to verify if the FSCONFIG_SET_PATH operation can be used
to dynamically change the external journal device of an ext3 or ext4
filesystem.

Closes: https://github.com/linux-test-project/ltp/issues/1169
Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 169 ++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2bdb4a9a2..1903f1ac6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -452,6 +452,7 @@ fremovexattr02 fremovexattr02
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
index 000000000..bd649717e
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test aims to validate :manpage:`fsconfig(2)` with the
+ * ``FSCONFIG_SET_PATH`` operation in dynamically altering the external
+ * journal device of an ext3 or ext4 filesystem.
+ *
+ * Root privileges are required because the test creates and formats loop
+ * devices, and configures filesystems.
+ *
+ * [Algorithm]
+ *
+ * - Acquire three loop devices (``tst_device->dev`` from framework, ``dev1``, ``dev2``).
+ * - Format ``dev1`` and ``dev2`` as external journal devices with the same UUID
+ *   (``-O journal_dev -U <uuid>``).
+ * - Format ``tst_device->dev`` three times to cycle journal associations:
+ *   ``dev1`` -> ``dev2`` -> ``dev1``, so both journal superblocks are consistent.
+ * - Open ``tst_device->dev`` via :manpage:`fsopen(2)` and set the source and journal_path using
+ *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_STRING``) and
+ *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_PATH``).
+ * - Apply ``FSCONFIG_CMD_CREATE`` and verify with ``tune2fs`` that ``tst_device->dev``'s
+ *   journal device is now ``dev2``.
+ *
+ * Implementation notes:
+ *
+ * - To avoid ``journal UUID does not match`` error when switching external
+ *   journal device, we have to assign the same UUID to ``dev1``/``dev2``.
+ * - Before the :manpage:`fsconfig(2)` test, we have to format ``tst_device->dev`` associating to
+ *   ``dev1`` -> ``dev2`` -> ``dev1``. This ensures that both ``dev1``/``dev2`` superblocks contain
+ *   correct content. Otherwise, you will encounter errors such as
+ *   ``EXT4-fs (loop0): External journal has more than one user (unsupported)``
+ *   when switching the external journal device using :manpage:`fsconfig(2)`.
+ */
+
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/fsmount.h"
+
+#define LOOP_DEV_SIZE 10
+#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
+
+static int fd = -1;
+static char dev1[PATH_MAX];
+static char dev2[PATH_MAX];
+
+static const char *const mkfs_opts_set_UUID[] = {"-F", "-U", UUID, "-O", "journal_dev", NULL};
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
+static void format_journal_device(const char *dev, const char *journal)
+{
+	char journal_opt[PATH_MAX + 16];
+	const char *const opts[] = {"-F", "-J", journal_opt, NULL};
+
+	snprintf(journal_opt, sizeof(journal_opt), "device=%s", journal);
+	SAFE_MKFS(dev, tst_device->fs_type, opts, NULL);
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	create_and_attach_loopdev("dev1_file", dev1, sizeof(dev1));
+	create_and_attach_loopdev("dev2_file", dev2, sizeof(dev2));
+}
+
+static void run(void)
+{
+	/* Reset dev1, dev2 and tst_device->dev superblocks before each test run iteration */
+	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
+	format_journal_device(tst_device->dev, dev1);
+	format_journal_device(tst_device->dev, dev2);
+	format_journal_device(tst_device->dev, dev1);
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
+
+	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, AT_FDCWD));
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
+	SAFE_CLOSE(fd);
+
+	char path[PATH_MAX + 32];
+	char device_str[NAME_MAX];
+	bool found = false;
+	struct stat st;
+
+	SAFE_STAT(dev2, &st);
+	unsigned int device_num = (minor(st.st_rdev) & 0xff) | (major(st.st_rdev) << 8) |
+				  ((minor(st.st_rdev) & ~0xff) << 12);
+	snprintf(device_str, sizeof(device_str), "0x%04x", device_num);
+
+	char line[PATH_MAX];
+	FILE *tune2fs;
+
+	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
+	tune2fs = SAFE_POPEN(path, "r");
+
+	while (fgets(line, PATH_MAX, tune2fs)) {
+		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
+			found = true;
+			break;
+		}
+	}
+
+	TST_EXP_EXPR(found, "Device found in journal");
+
+	pclose(tune2fs);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_device = 1,
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
