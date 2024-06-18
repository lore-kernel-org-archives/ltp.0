Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A0FC27C4F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 10:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740603D0D39
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 12:31:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC7063CB74E
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:31:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32DAF1A00CC2
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:31:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B16D1F451;
 Tue, 18 Jun 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E8151369F;
 Tue, 18 Jun 2024 10:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFUwAvlhcWY5LQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jun 2024 10:31:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Jun 2024 12:31:17 +0200
Message-ID: <20240618103117.371469-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618103117.371469-1-pvorel@suse.cz>
References: <20240618103117.371469-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 3B16D1F451
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_taint: Assume kernel > 4.0
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

LTP recently (9e9654cf2) raised minimal kernel support to 4.4.
Therefore remove checks for kernel < 4.0.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_taint.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index f28932609..94459523e 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -60,43 +60,8 @@ static int tst_taint_check_kver(unsigned int mask)
 	} else if (mask & TST_TAINT_K) {
 		r1 = 4;
 		r2 = 0;
-	} else if (mask & TST_TAINT_L) {
-		r1 = 3;
-		r2 = 17;
-	} else if (mask & TST_TAINT_E) {
-		r1 = 3;
-		r2 = 15;
-	} else if (mask & TST_TAINT_O) {
-		r1 = 3;
-		r2 = 2;
-	} else if (mask & TST_TAINT_I) {
-		r1 = 2;
-		r2 = 6;
-		r3 = 35;
-	} else if (mask & TST_TAINT_C) {
-		r1 = 2;
-		r2 = 6;
-		r3 = 28;
-	} else if (mask & TST_TAINT_W) {
-		r1 = 2;
-		r2 = 6;
-		r3 = 26;
-	} else if (mask & TST_TAINT_A) {
-		r1 = 2;
-		r2 = 6;
-		r3 = 25;
-	} else if (mask & TST_TAINT_D) {
-		r1 = 2;
-		r2 = 6;
-		r3 = 23;
-	} else if (mask & TST_TAINT_U) {
-		r1 = 2;
-		r2 = 6;
-		r3 = 21;
 	} else {
-		r1 = 2;
-		r2 = 6;
-		r3 = 16;
+		return 1;
 	}
 
 	return tst_kvercmp(r1, r2, r3);
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
