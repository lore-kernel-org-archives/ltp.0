Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B3CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:27:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86BD13CE4CA
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:27:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C09B3CA99A
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:27:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 85F381400C67
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:27:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBA531FDC3;
 Mon, 18 Sep 2023 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695032838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q1xluOjGtopyUosrTwjpluAYa9anARJ5mnYoS26NQ8k=;
 b=evPjHyNfx953OhHD7s7KeUWsnHVkOoNNNfgS81FtccdQwFa9SCvH76Q2uoNpAzq096Q3EE
 HcQFZ2XivGGQQECP38zSvX9CdsodPD2VNv7QTWHg3MDrmZoKBd5JU4n7P5rQOOOhJzawjV
 YnS5YogR7VQ1Y2c7RRGJduK/IJQBR0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695032838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q1xluOjGtopyUosrTwjpluAYa9anARJ5mnYoS26NQ8k=;
 b=We8LBQG8EMpm1Dj79NoLJOlHVP9ppxM3OSyyrhQ2zdO7YvhvOw7cG43M9pA7ewCXgxfPNU
 FirFL104Am5YC7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ED3A1358A;
 Mon, 18 Sep 2023 10:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x8edJAYmCGW5NwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 10:27:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 12:27:11 +0200
Message-ID: <20230918102711.9567-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_fill_fs: Fix printf format error
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

openat() first parameter is file descriptor (int), not string.
Add also original path (string) to be more informative.

Fixes: df1b01cc1 ("tst_fill_fs: drop safe_macro from fill_flat_vec")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I'd like to get this tiny fix merged before the release.

Kind regards,
Petr

 lib/tst_fill_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 243eb279f..5e8cf9197 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -93,7 +93,8 @@ void fill_flat_vec(const char *path, int verbose)
 			tst_res(TINFO | TERRNO, "openat()");
 			return;
 		}
-		tst_brk(TBROK | TERRNO, "openat(%s, %d, 0600) failed", dir, O_PATH | O_DIRECTORY);
+		tst_brk(TBROK | TERRNO, "openat(%d, %d, 0600) failed for path %s",
+			dir, O_PATH | O_DIRECTORY, path);
 	}
 
 	SAFE_CLOSE(dir);
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
