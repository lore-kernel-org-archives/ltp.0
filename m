Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7077AEB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 12:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DE213CAFE7
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 14:54:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 392933CA860
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 14:54:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2339A1A000B8
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 14:54:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 666EA1FDA9;
 Mon, 17 Jul 2023 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689598457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PVAgXEuNUIcgctDdlTv6DcG14qhB9US2EHg9z9dw/VA=;
 b=AuL0d3TCIennjquxRVYvar744XC1UeQPL09uW0ormzkYT83aluW+sK6MchzqSGM5lJGACL
 0cUuqN6+Iz5EZHYXUNZnLwgxvTktnX/bLzuPakL2Eq6YDn9B3+pEu+FJSrwN84RkmFhZO2
 e9yzqHDi7qhqBDTGCT7WQPUVrlOlBqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689598457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PVAgXEuNUIcgctDdlTv6DcG14qhB9US2EHg9z9dw/VA=;
 b=8I4vE8v404J+G6qQndeuGgn+8Rc7IK9Ta+ZyCPG9LRmPpkY6quOAkr5X5LsGGvRgJlrXlo
 Zn8UNg9ykaPP8oAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05FB713276;
 Mon, 17 Jul 2023 12:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RCJjO/g5tWRFOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jul 2023 12:54:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Jul 2023 14:54:13 +0200
Message-Id: <20230717125413.1123587-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] statx09: Format filesystem with page size
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

This fixes statx09.c for kernel < 6.3. Previously test was skipped:
statx09.c:126: TCONF: fs-verity not supported on loopdev, due the
default block size, which is for our 300 MB loop device 1024.

This is a follow up of previous fix 2e582e743 ("statx09: Set fs-verity
blocksize to FS blocksize") for kernel >= 6.3.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/statx/statx09.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index 7211d8393..6e75ff3ec 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -20,6 +20,7 @@
 #define _GNU_SOURCE
 #include <sys/mount.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include "tst_test.h"
 #include "lapi/fs.h"
 #include "lapi/fsverity.h"
@@ -120,6 +121,12 @@ static void flag_setup(void)
 
 static void setup(void)
 {
+	char opt_bsize[32];
+	const char *const fs_opts[] = {"-O verity", opt_bsize, NULL};
+
+	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+
 	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
 	if (TST_RET) {
 		if (TST_ERR == EINVAL)
@@ -147,10 +154,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.needs_device = 1,
 	.mntpoint = MNTPOINT,
-	.format_device = 1,
 	.dev_fs_type = "ext4",
-	.dev_fs_opts = (const char *const []){"-O verity", NULL},
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_FS_VERITY",
 		NULL
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
