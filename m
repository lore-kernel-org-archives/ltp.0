Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A09C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 23:52:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CB453CBF48
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 00:52:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B93303CB073
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 00:52:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBE91600A67
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 00:52:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12A9D339BE;
 Thu, 16 Feb 2023 23:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676591555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcHZZiBnF75oyXf7uBaBMWU/DDkIU2Ju2tz2P+r8Zvw=;
 b=mAfDlRJC7EttljnBUJohz8WcyESTt0n8gz3UbTvEf6nyojGSbl1E+tRk6h+CxndmmT91qg
 KNG/wRLJ8vQxbapR6rGNxZlPOfg6QJw4QyJT6hvHf4Fj6n0pyVD3t5flUfDfhouE1c17AL
 LiWq/yHJoqO2WEAE+plnHbSxkqRgXWM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F20CD13438;
 Thu, 16 Feb 2023 23:52:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kaI1MsHB7mNXSQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 16 Feb 2023 23:52:33 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Feb 2023 18:52:18 -0500
Message-Id: <20230216235218.25757-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230213010924.12352-1-wegao@suse.com>
References: <20230213010924.12352-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] fsconfig03: New test CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There are reproducers available for CVE-2022-0185
https://www.openwall.com/lists/oss-security/2022/01/25/14

Also with links or even a zip file for an exploit
https://github.com/Crusaders-of-Rust/CVE-2022-0185

The exploits are kind of complicated as they try to be complete,
but the exploitation vector is the fsconfig() syscall,
this case used for add some coverage to that to detect it.

When kernel < v5.15.16, you can easily reproduce crash use test case
without check error and return logic in loop.

I have used this test case trigger 5.14.1 kernel crash with ext2/4.
Just make sure your kernel have not patched by following two commits:
e192ccc17ecf3 - fix up param length parsing in legacy_parse_param
cebe85d570cf8 - ext4: switch to the new mount api

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/cve                                   |  2 +
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |  1 +
 .../kernel/syscalls/fsconfig/fsconfig03.c     | 79 +++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig03.c

diff --git a/runtest/cve b/runtest/cve
index 1ba63c2a7..7da3ff853 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -77,3 +77,5 @@ cve-2022-2590 dirtyc0w_shmem
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-4378 cve-2022-4378
+# Tests below may cause kernel crash
+cve-2022-0185 fsconfig03
diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192..b4cde8071 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -383,6 +383,7 @@ fremovexattr02 fremovexattr02
 
 fsconfig01 fsconfig01
 fsconfig02 fsconfig02
+fsconfig03 fsconfig03
 
 fsmount01 fsmount01
 fsmount02 fsmount02
diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
index 2bc54b827..cfedae5f7 100644
--- a/testcases/kernel/syscalls/fsconfig/.gitignore
+++ b/testcases/kernel/syscalls/fsconfig/.gitignore
@@ -1,2 +1,3 @@
 /fsconfig01
 /fsconfig02
+/fsconfig03
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
new file mode 100644
index 000000000..c2e908221
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Alejandro Guerrero <aguerrero@...lys.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+
+/*\
+ * [Description]
+ *
+ * Test for CVE-2022-0185.
+ *
+ * References links:
+ * - https://www.openwall.com/lists/oss-security/2022/01/25/14
+ * - https://github.com/Crusaders-of-Rust/CVE-2022-0185
+ */
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+
+#define MNTPOINT	"mntpoint"
+
+static int fd = -1;
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+}
+
+static void run(void)
+{
+	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
+	long pagesize;
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
+
+	pagesize = sysconf(_SC_PAGESIZE);
+	if (pagesize == -1)
+		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
+
+	for (size_t i = 0; i < 5000; i++) {
+		/* use same logic in kernel legacy_parse_param function */
+		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
+
+		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize) {
+			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
+			if (TST_ERR)
+				return;
+		} else {
+			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
+					    EINVAL);
+			if (!TST_PASS)
+				return;
+		}
+	}
+
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	tst_res(TPASS, "fsconfig() overflow on %s haven't triggerred crash",
+			tst_device->fs_type);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "722d94847de29"},
+		{"CVE", "2022-0185"},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
