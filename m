Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF7C5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 10:52:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2CA73E7205
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:52:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 264CD3E2D15
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:51:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 86CC36002CA
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:51:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 327247DEDC;
 Fri, 31 Jul 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785495102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/W7Z2AJsog0feHx0N1TrdhKPGyuuoDJxFzAtWNLUu3E=;
 b=qE6r/yX9oyffYZWhKS2B9qZulZyaQiPEsM9prbhJ/Uc++SEo0A0fFaAqDGVfX4ErA/F5p1
 YWnuAj3Ra4Px9eRI23W5kAQoGMuPama/sRGhUc8P3rZ6uQceV0PVkM5FzkDIKAoakKYLhq
 OcAswAhSwcPT+b1zSEzEK6NKpyqfsAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785495102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/W7Z2AJsog0feHx0N1TrdhKPGyuuoDJxFzAtWNLUu3E=;
 b=THM4ky6w6/MsnEZek8RIJy/sY+qvWUbNcn5Cg/rUjVYCWiloeD6nADj4uViBdv66FicUvh
 eMVK/Fs2i+Jx3wDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6790779C7;
 Fri, 31 Jul 2026 10:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mAZsJz1+bGoTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 10:51:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 12:51:28 +0200
Message-ID: <20260731105132.187177-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731105132.187177-1-pvorel@suse.cz>
References: <20260731105132.187177-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 327247DEDC
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/5] lib: Rename function check_kver() =>
 check_min_kver()
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

Preparation for a next commit.

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v2.

 lib/tst_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 5c3607016e..778a1fed40 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1058,11 +1058,11 @@ static void do_exit(int ret)
 }
 
 /*
- * Check for the required kernel version.
+ * Check for the minimal required kernel version.
  *
  * return: true if the kernel version is high enough, false otherwise.
  */
-static bool check_kver(const char *min_kver, const int brk_nosupp)
+static bool check_min_kver(const char *min_kver, const int brk_nosupp)
 {
 	char *msg;
 	int v1, v2, v3;
@@ -1461,7 +1461,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
-		check_kver(tst_test->min_kver, 1);
+		check_min_kver(tst_test->min_kver, 1);
 
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
@@ -1584,7 +1584,7 @@ static void do_setup(int argc, char *argv[])
 				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
 
 			if (tst_test->filesystems && tst_test->filesystems->min_kver)
-				check_kver(tst_test->filesystems->min_kver, 1);
+				check_min_kver(tst_test->filesystems->min_kver, 1);
 
 			prepare_device(tst_test->filesystems);
 		}
@@ -1988,7 +1988,7 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
 		return;
 
-	if (fs->min_kver && !check_kver(fs->min_kver, 0))
+	if (fs->min_kver && !check_min_kver(fs->min_kver, 0))
 		return;
 
 	prepare_device(fs);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
