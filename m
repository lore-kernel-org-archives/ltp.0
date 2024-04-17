Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FC5C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:31:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 713963CFB98
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:31:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EA903CFA00
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:31:18 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E190A100114B
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:31:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E21033C33;
 Wed, 17 Apr 2024 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713357077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f1JHNz7oiUppdNkKvT1qPhA4l17qio33LxHsaFGt2g=;
 b=Fpsr7uNHiaO1Pcm3wd9huiKFQwYJdcFkqNrii9L0NXrp99neNJa6YccDIAtUquqHkCsZ3J
 RI2+K7Ht6t8WNSPIF7kNwdgvF2WvcpeacCrxiUf3cDmWXSJmK1XD1fXwV5YqwcDA12LwYW
 XWBEeT/SbKGkOlJZ7p+XcbyIZtEmd9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713357077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f1JHNz7oiUppdNkKvT1qPhA4l17qio33LxHsaFGt2g=;
 b=OLocFwd0D7qxzNBzhNNtCx3Il7kRAG8Lf2ZqanXSMeyKWlcUZbXdFMPNYQuEHiBatJp0K8
 D+0OfVZaUJrAfqCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Fpsr7uNH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OLocFwd0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713357077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f1JHNz7oiUppdNkKvT1qPhA4l17qio33LxHsaFGt2g=;
 b=Fpsr7uNHiaO1Pcm3wd9huiKFQwYJdcFkqNrii9L0NXrp99neNJa6YccDIAtUquqHkCsZ3J
 RI2+K7Ht6t8WNSPIF7kNwdgvF2WvcpeacCrxiUf3cDmWXSJmK1XD1fXwV5YqwcDA12LwYW
 XWBEeT/SbKGkOlJZ7p+XcbyIZtEmd9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713357077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f1JHNz7oiUppdNkKvT1qPhA4l17qio33LxHsaFGt2g=;
 b=OLocFwd0D7qxzNBzhNNtCx3Il7kRAG8Lf2ZqanXSMeyKWlcUZbXdFMPNYQuEHiBatJp0K8
 D+0OfVZaUJrAfqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E979513976;
 Wed, 17 Apr 2024 12:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Ju+NBTBH2aiHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 12:31:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Apr 2024 14:31:13 +0200
Message-ID: <20240417123113.731780-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417123113.731780-1-pvorel@suse.cz>
References: <20240417123113.731780-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5E21033C33
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] libswap: Use tst_res_() instead of tst_res()
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

That allows to identify the caller of the function. That is the reason
why tst_brk_() was already used instead of tst_brk().

Fixes: f987ffff5 ("libswap: add two methods to create swapfile")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/libltpswap/libswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index b4233be0d..aed76dfe2 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -149,18 +149,18 @@ int make_swapfile(const char *file, const int lineno,
 	blk_size = fs_info.f_bsize;
 
 	if (method == SWAPFILE_BY_SIZE) {
-		tst_res(TINFO, "create a swapfile size of %u megabytes (MB)", num);
+		tst_res_(file, lineno, TINFO, "create a swapfile size of %u megabytes (MB)", num);
 		blocks = num * 1024 * 1024 / blk_size;
 	} else if (method == SWAPFILE_BY_BLKS) {
 		blocks = num;
-		tst_res(TINFO, "create a swapfile with %u block numbers", blocks);
+		tst_res_(file, lineno, TINFO, "create a swapfile with %u block numbers", blocks);
 	} else {
 		tst_brk_(file, lineno, TBROK, "Invalid method, please see include/libswap.h");
 	}
 
 	/* To guarantee at least one page can be swapped out */
 	if (blk_size * blocks < pg_size) {
-		tst_res(TWARN, "Swapfile size is less than the system page size. "
+		tst_res_(file, lineno, TWARN, "Swapfile size is less than the system page size. "
 			"Using page size (%lu bytes) instead of block size (%lu bytes).",
 			(unsigned long)pg_size, blk_size);
 		blk_size = pg_size;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
