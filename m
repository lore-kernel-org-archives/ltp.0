Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13585C05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 13:20:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F41C53CC0B3
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:20:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D28A43C304A
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:19:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D83DC1400752
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:19:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DCD2374AA;
 Thu,  9 Feb 2023 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675948790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0CsUgxM9M6rY8n2Bek34jjJclf7W0+mmQnfOsL3DaU=;
 b=I2PcFUySoKF497lKN7HtxO7sVS99ecGREIVlw8/fF7FMmKEW5EBfsfP20WS7aPkHImCfBp
 sGX/S/X2158sp1s14K/5fvJ8xj+3S4BpIom4/BWngy06W5BDemTGMvxfAAK4vEYh4zdnfO
 2/kkEJseaZMYMqOmyQVL45IUy/drDpU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D9031339E;
 Thu,  9 Feb 2023 13:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vqdBN/Ty5GOqbgAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 09 Feb 2023 13:19:48 +0000
To: ltp@lists.linux.it
Date: Thu,  9 Feb 2023 08:19:02 -0500
Message-Id: <20230209131902.12260-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230129115021.25778-1-wegao@suse.com>
References: <20230129115021.25778-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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

There are reproducers available for CVE-2022-0185
https://www.openwall.com/lists/oss-security/2022/01/25/14
has links or even a zip file for an exploit
https://github.com/Crusaders-of-Rust/CVE-2022-0185
The exploits are kind of complicated as they try to be complete,
but the exploitation vector is the fsconfig() syscall,
this case used for add some coverage to that to detect it.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |  1 +
 .../kernel/syscalls/fsconfig/fsconfig03.c     | 64 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig03.c

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
index 000000000..32d062f66
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test add some coverage to CVE-2022-0185.
+ * Try to trigger a crash.
+ * References links:
+ * https://www.openwall.com/lists/oss-security/2022/01/25/14
+ * https://github.com/Crusaders-of-Rust/CVE-2022-0185
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
+
+	TEST(fd = fsopen(tst_device->fs_type, 0));
+	if (fd == -1)
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
+
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
+
+	for (unsigned int i = 0; i < 5000; i++)
+		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
+
+	tst_res(TPASS | TTERRNO, "Try fsconfig overflow on %s done! Failed as expected", tst_device->fs_type);
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
+	.min_kver = "5.17",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "722d94847de29"},
+		{"CVE", "2020-29373"},
+		{"CVE", "2022-0185"},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
