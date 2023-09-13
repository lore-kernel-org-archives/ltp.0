Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B057FCA5531
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 10:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 949B83CB2F1
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 12:15:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A9B03CB2AF
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 12:15:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3433B60155F
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 12:15:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1EC1F390;
 Wed, 13 Sep 2023 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1694600146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zkXi1QAhLWA/8beD+zcyZk6fDTMx4Z1irNitIN49C+k=;
 b=J9yF6KfDpxVDXtpj1Kgk4nQr8uvOiTq+fpr30KB300WHsEeWOUD502JTElUT5VwXMZF1kF
 UZNnqXYqR5kd8XVD5u7zHJ/jjG12p9zyKT62nPt8t35r5NqQH/7uIpgpFrBYg9/xTX0yk0
 woBE53Wia1swQ6nXssQW/sAt4AcYzTU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5B9313440;
 Wed, 13 Sep 2023 10:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AymaKtGLAWXtXgAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 13 Sep 2023 10:15:45 +0000
To: ltp@lists.linux.it
Date: Wed, 13 Sep 2023 06:15:42 -0400
Message-Id: <20230913101542.18550-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] move_mount03: check allow to mount beneath top
 mount
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/fsmount.h                        |  4 ++
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/move_mount/.gitignore     |  1 +
 .../kernel/syscalls/move_mount/move_mount03.c | 63 +++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount03.c

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..216e966c7 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -115,6 +115,10 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
 }
 #endif /* HAVE_MOUNT_SETATTR */
 
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 		0x00000200
+#endif /* MOVE_MOUNT_BENEATH */
+
 /*
  * New headers added in kernel after 5.2 release, create them for old userspace.
 */
diff --git a/runtest/syscalls b/runtest/syscalls
index b1125dd75..04b758fd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -824,6 +824,7 @@ mount_setattr01 mount_setattr01
 
 move_mount01 move_mount01
 move_mount02 move_mount02
+move_mount03 move_mount03
 
 move_pages01 move_pages01
 move_pages02 move_pages02
diff --git a/testcases/kernel/syscalls/move_mount/.gitignore b/testcases/kernel/syscalls/move_mount/.gitignore
index 83ae40145..ddfe10128 100644
--- a/testcases/kernel/syscalls/move_mount/.gitignore
+++ b/testcases/kernel/syscalls/move_mount/.gitignore
@@ -1,2 +1,3 @@
 /move_mount01
 /move_mount02
+/move_mount03
diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
new file mode 100644
index 000000000..071fd984c
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify allow to mount beneath top mount
+ *
+ */
+
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define DIRA "LTP_DIR_A"
+
+static void run(void)
+{
+	int fd;
+
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_MKDIR(DIRA, 0777);
+	SAFE_TOUCH(DIRA "/A", 0, NULL);
+	/* The parent mnt should be private if check MOVE_MOUNT_BENEATH */
+	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
+	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
+	fd = SAFE_OPEN(DIRA, O_RDONLY | O_DIRECTORY);
+
+	TST_EXP_PASS(move_mount(fd, "", AT_FDCWD, MNTPOINT,
+				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH));
+
+	if (access(MNTPOINT "/A", F_OK) == 0)
+		tst_res(TFAIL, "mount beneath top mount failed");
+	else
+		tst_res(TPASS, "mount beneath top mount pass");
+
+	if (tst_is_mounted_at_tmpdir(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
+
+	if (access(MNTPOINT "/A", F_OK) == 0)
+		tst_res(TPASS, "mount beneath top mount pass");
+	else
+		tst_res(TFAIL, "mount beneath top mount failed");
+
+	remove(DIRA "/A");
+	SAFE_RMDIR(DIRA);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
+	.min_kver = "6.5.0"
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
