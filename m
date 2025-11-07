Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D720DCCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:30:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 509B63CEFA3
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:30:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78FCA3CEF03
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39C65200C7E
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BEB1211D4;
 Fri,  7 Nov 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF512132DD;
 Fri,  7 Nov 2025 10:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SPe4KhfKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:34 +0100
Message-ID: <20251107102939.1111074-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 0BEB1211D4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/8] tst_test.c: Change check_kver() return type to
 bool
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

Also change the value (0 becomes true), add docs (don't use kerneldoc as
this is a internal function which does not need to be in LTP online doc).

While at it, add missing static.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index bda66c4672..1725844b54 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1056,7 +1056,12 @@ static void do_exit(int ret)
 	exit(ret);
 }
 
-int check_kver(const char *min_kver, const int brk_nosupp)
+/*
+ * Check for the required kernel version.
+ *
+ * return: true if the kernel version is high enough, false otherwise.
+ */
+static bool check_kver(const char *min_kver, const int brk_nosupp)
 {
 	char *msg;
 	int v1, v2, v3;
@@ -1075,10 +1080,10 @@ int check_kver(const char *min_kver, const int brk_nosupp)
 		else
 			tst_res(TCONF, msg, min_kver);
 
-		return 1;
+		return false;
 	}
 
-	return 0;
+	return true;
 }
 
 static int results_equal(struct results *a, struct results *b)
@@ -1963,7 +1968,7 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
 		return TCONF;
 
-	if (fs->min_kver && check_kver(fs->min_kver, 0))
+	if (fs->min_kver && !check_kver(fs->min_kver, 0))
 		return TCONF;
 
 	prepare_device(fs);
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
