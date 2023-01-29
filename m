Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F110C05027
	for <ltp@archiver.kernel.org>; Sun, 29 Jan 2023 11:50:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAF5B3CB32D
	for <ltp@archiver.kernel.org>; Sun, 29 Jan 2023 12:50:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D303CB2E0
 for <ltp@lists.linux.it>; Sun, 29 Jan 2023 12:50:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FEDA1000354
 for <ltp@lists.linux.it>; Sun, 29 Jan 2023 12:50:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 718041FF0D;
 Sun, 29 Jan 2023 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674993041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7JkMuC18vT4hPlcQTx/xpX6AH86nnW0hKW4AUWvuLnY=;
 b=D1QjJdIxctakJdZX/k02E7rrA+WvLzukIKkOJsaL/bzHXuOIyUiqH+LOqDkL7HKJpnqW1b
 3ioIXALCgb4KvyeXdcw2fZOeAWJwKseDPfpzprgMKTFaDnVZSMM5tJ/LQPRA6WDhYO35ZK
 cMZijD03GcrVAXXjVggR5tR3Zy2ubSc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB0BB13583;
 Sun, 29 Jan 2023 11:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MZKwHpBd1mPuFgAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 29 Jan 2023 11:50:40 +0000
To: ltp@lists.linux.it
Date: Sun, 29 Jan 2023 06:50:21 -0500
Message-Id: <20230129115021.25778-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fsconfig: New case cover CVE-2022-0185
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
 include/lapi/fsmount.h                        |  5 +-
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/fsconfig/fsconfig03.c     | 58 +++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig03.c

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..252accb0f 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -11,12 +11,15 @@
 #include "config.h"
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <sys/mount.h>
 
 #ifndef HAVE_FSOPEN
 # ifdef HAVE_LINUX_MOUNT_H
 #  include <linux/mount.h>
+# else
+#  include <sys/mount.h>
 # endif
+#else
+# include <sys/mount.h>
 #endif
 
 #include "lapi/fcntl.h"
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
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
new file mode 100644
index 000000000..e076c2f09
--- /dev/null
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
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
+	for (unsigned int i = 0; i < 2; i++) {
+		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
+		if (TST_RET == -1)
+			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
+	}
+	tst_res(TPASS, "Try fsconfig overflow on %s done!", tst_device->fs_type);
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
+	.skip_filesystems = (const char *const []){"fuse", "ext2", "xfs", "tmpfs", NULL},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
