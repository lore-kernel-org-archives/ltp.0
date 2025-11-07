Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A40CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:31:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 779BB3C0EFB
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:31:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52ACE3CEFA6
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D2CB41400263
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D0AC1F461;
 Fri,  7 Nov 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2DC313A60;
 Fri,  7 Nov 2025 10:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CP4oOhjKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:38 +0100
Message-ID: <20251107102939.1111074-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1D0AC1F461
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/8] tst_test.c: Change run_tcase_on_fs() return type
 to void
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

Return code is not used any more.

Fixes: a1f82704c2 ("lib/tst_test.c: Fix tst_brk() handling")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c1a1abf7fb..8098b3a010 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1963,29 +1963,27 @@ ret:
 	return &tst_test->filesystems[0];
 }
 
-static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
+static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 {
-	int ret;
-
 	tst_res(TINFO, "=== Testing on %s ===", fs_type);
 	tdev.fs_type = fs_type;
 
 	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
-		return TCONF;
+		return;
 
 	if (fs->min_kver && !check_kver(fs->min_kver, 0))
-		return TCONF;
+		return;
 
 	prepare_device(fs);
 
-	ret = fork_testrun();
+	fork_testrun();
 
 	if (context->mntpoint_mounted) {
 		tst_umount(tst_test->mntpoint);
 		context->mntpoint_mounted = 0;
 	}
 
-	return ret;
+	return;
 }
 
 static void run_tcases_per_fs(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
