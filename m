Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA069C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 10:23:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD1803CDEAC
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 11:23:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49A2E3C044A
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 11:22:47 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 106D8600BCD
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 11:22:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20C461F7F9;
 Fri,  9 Feb 2024 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707474166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgN02euzoxlkGKl+N5ApfRHPvnfPSnZRX0230t+koKA=;
 b=vuT7JEpbN4qrIIEQQTjyVNpq2wcdBG/m+8ZhUDfIM8LcQ0YmhzXWiAC06N6Yga1bdsmbM4
 LHBjKxPSm3leCy9M4ow/3Yop0rq8el1v/VktbUCnChZj98LZr7IDzzm9+kZjJ4GsPN3Sfp
 BuCzAjOBwaCscpWSZv5DC30nGHSDmq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707474166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgN02euzoxlkGKl+N5ApfRHPvnfPSnZRX0230t+koKA=;
 b=E7mkDUjsAV1XTzrql+8yyybtwHvo3JNprlnRURkHBSTrtQzzghaz7qO6pMMaBQ8+sJLLAC
 HP7pH++7KWemcCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707474166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgN02euzoxlkGKl+N5ApfRHPvnfPSnZRX0230t+koKA=;
 b=vuT7JEpbN4qrIIEQQTjyVNpq2wcdBG/m+8ZhUDfIM8LcQ0YmhzXWiAC06N6Yga1bdsmbM4
 LHBjKxPSm3leCy9M4ow/3Yop0rq8el1v/VktbUCnChZj98LZr7IDzzm9+kZjJ4GsPN3Sfp
 BuCzAjOBwaCscpWSZv5DC30nGHSDmq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707474166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgN02euzoxlkGKl+N5ApfRHPvnfPSnZRX0230t+koKA=;
 b=E7mkDUjsAV1XTzrql+8yyybtwHvo3JNprlnRURkHBSTrtQzzghaz7qO6pMMaBQ8+sJLLAC
 HP7pH++7KWemcCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D19E31326D;
 Fri,  9 Feb 2024 10:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cmKtL/X8xWUhIwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 09 Feb 2024 10:22:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  9 Feb 2024 11:22:44 +0100
Message-Id: <20240209102244.24835-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [8.80 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(5.10)[100.00%]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactor mount01 test using new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mount/mount01.c | 117 +++++++---------------
 1 file changed, 35 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index 1d902ba89..ceb9bd075 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -1,99 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ *               Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    DESCRIPTION
- *	This is a Phase I test for the mount(2) system call.
- *	It is intended to provide a limited exposure of the system call.
+ * Basic test that checks `mount` syscall works on multiple filesystems.
  */
 
-#include <errno.h>
+#include "tst_test.h"
 #include <sys/mount.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
 
-char *TCID = "mount01";
-int TST_TOTAL = 1;
-
-#define DIR_MODE (S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
 #define MNTPOINT "mntpoint"
 
-static const char *device;
-static const char *fs_type;
-
-int main(int ac, char **av)
+static void cleanup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(mount(device, MNTPOINT, fs_type, 0, NULL));
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL | TTERRNO, "mount(2) failed");
-		} else {
-			tst_resm(TPASS, "mount(2) passed ");
-			TEST(tst_umount(MNTPOINT));
-			if (TEST_RETURN != 0) {
-				tst_brkm(TBROK | TTERRNO, cleanup,
-					 "umount(2) failed");
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	TST_EXP_PASS(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	if (tst_is_mounted(MNTPOINT)) {
+		tst_res(TPASS, "folder has been mounted");
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-
-	TEST_PAUSE;
+		SAFE_UMOUNT(MNTPOINT);
+	} else {
+		tst_res(TFAIL, "folder has not been mounted");
+	}
 }
 
-static void cleanup(void)
-{
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char *const []){
+		"exfat",
+		"vfat",
+		"ntfs",
+		NULL
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
