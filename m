Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28733606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ZrjW2vEW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FqGDZwe5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793586254; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=O2hTbiQUCmHGwzN/EP4vRDixx/eYxeAD7pfOh8sF+wE=;
 b=ZrjW2vEW+ZUq8/jz9QkapXTCGb1vS3CFIkJ0JaAQe4ewGazq7+aI6PvrXDXaQCktFA3ML
 guHSfU4ok53PQZMZWo+M88I3iC6zsI7CmeDTPkzy7Qrni9nJpliR4JeskvpfxMKCwfmyEIZ
 WeB9B+k//1MDjvqcgocTVpIJeLUxuMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94B4B3E5AB7
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:24:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB5F33E2E58
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:23:00 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A6EAE1A006E0
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:59 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1682305f8f.0
 for <ltp@lists.linux.it>; Sun, 01 Nov 2026 18:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793586179; x=1794190979; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfK8IJWQe7fZIa8MEc4Y/qY2WhY8X2bBHxQ5Z1WCWU4=;
 b=FqGDZwe5qCM2TVTiodUDdZK+RpKiJkikOSJtuGgs0obNJyCtMq57No+7ex66EC7yZE
 gyTwkqC+V/19gK33yNWsbKAd5mMmKpUsg1UP2iEH56Cl2a3uiPWGJOkIyvXqx8tIv43F
 08OCG6scoXErKG1dH04Zh4fyUCoRUxkeX0Igzw17QiDyH9X+kqmnIsCQQmaS9rlgSwH1
 QQNt4Ed2B68TWE3l9GCw0uZN4zh4wGxLvCt66M/8KM1OJAWgk4yOLl1e6Yif2ZwS66q3
 TqpZisGYXrVGNMVGIdq6XJr23GGo1CB0dYFpLcbUb9Uyu95wyqHuvu7lWUsmLXyDjxC+
 nhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793586179; x=1794190979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jfK8IJWQe7fZIa8MEc4Y/qY2WhY8X2bBHxQ5Z1WCWU4=;
 b=jTpNTiWiRiyRgIQqiHFdEiU9jcTlyzMaQ67uIklXK7GgXjo5GoJLY8yHrhMq+RnN7A
 N/8op8oYveDAtpyKLC9GW7Esx9MK/TKKGUEuNNbM7VTF8X+1r56/gLhQTc0EGXpHU4Ga
 z0saZAd3vvj4BXx7ZVt6TMU9Af/Cop3iGmtXptKIb/++mveg7rD97AhC4I6WC6vd42ZI
 yMoeSs4lOeaGgW1eZ0z2UOjWDNtkW2+67+GUXNs9FjAi/7WV7r9t5qYlkDXzmpTUpK4Y
 JDSVEBwo5+Jvv+IYgFPgfU1QxZ2DxBwx9WFXYeJvCRqzGlOSCn9V8V4ZXBHHX5QVMg6U
 z+Nw==
X-Gm-Message-State: APuU4Z9ymxMf5S0aESW5wOETgLoa8d1Kpz1+UI/WcQZEUhQni/VlS36j
 U53kvDJCoXvbO/qO54MMfpGj7YoB5slnu+83U2fMKfSgbwJEa0W8egjpfeV5xEbM7MHjStvqPGt
 4vJ0=
X-Gm-Gg: AYBFou1qMDKVK/ww5X5zhIdI5d6HzR9vnJDg0xohJvn8rzM2Vm4lLdX1ZHRsp2/aIEo
 rMXba4JrWrn1noenuWtyl2CEj08bmkEstOeRLxR7WiTmjVZ/4Eo0I9PctECceEwzk8iGc0bAxDL
 UAfxaSHs59y9/82N9VSMMJ3H6ndIF4iR7wOFSOqoMDjcLdM4zHFcBYPqvugRMEYDei2or2jnGoy
 5Qhhccd3emnnlxJD0wI5SXAKP67vwgwqyjLkQwT46RAmbtR3SO+Jc+R41dxQXwXI9cREjVTS+Z0
 mlDoO4jbC82gZYfZJ2Dzvk1WBJXmNi1TJz3UHLNWt8/1zeNTzyOL15tcuQi0wWKYiqe3sBDkgJX
 iZIlfooT2gZYhyY4m30gni9qakWwRBAeXa3eNYEI1jphdB9yYW43mG0ebGCVerHwB3InlnjI2/j
 1quk2ih6V0SLTo7mb/ZgoBaPdWC2QsDJ9/ul+14q88LrJbxWg3ozZDRvM9EYnNMWnt4tzIA+tet
 /MHom90J9zcUE20Jc5EmyFYJiH1/99fo09vBJoPDum28iXtVGFzJkNxMN+N0ML9wfcjDkaLU/BN
 xerozZiFpsZKeJGs3C2ZbQsdOWhBEFdbG/R7KDxlR7YHDwOYOdqmkBt0EKGdLSU1Ww+T3tSWiw=
 =
X-Received: by 2002:a5d:64e4:0:b0:48d:fbf4:8961 with SMTP id
 ffacd0b85a97d-48e7377d134mr17301511f8f.23.1793586179078; 
 Sun, 01 Nov 2026 18:22:59 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48e71b80ecbsm17572941f8f.35.2026.11.01.18.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:22:58 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 02:22:41 +0000
Message-ID: <20261102022245.3922-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102022245.3922-1-wegao@suse.com>
References: <20261102022245.3922-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v18 3/3] fsconfig04: Check FSCONFIG_SET_PATH
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
v17->v18:
- Use tst_attach_loopdev() to set up loop devices.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 166 ++++++++++++++++++
 3 files changed, 168 insertions(+)
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
index 000000000..11984d40e
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -0,0 +1,166 @@
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
+	if (tst_attach_loopdev(dev_path, dev_path_len, filename))
+		tst_brk(TBROK, "Failed to attach loop device for %s", filename);
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
