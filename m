Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B3CC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 09:02:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30B123CFB82
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 11:02:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE2CC3CFB16
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:02:31 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCAE560B2DB
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:02:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BEE6205F7;
 Wed, 17 Apr 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713344546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X+e9jXfeodR3CrP/AqBhgnJUfsbSqL8mkmwa5zrnsbk=;
 b=2gWtEA7RXgD3VlE3wgK2WsdQmzazm3qAJXP2bHydlH0r1L7GRDGVblbYIoGnIdi7rp9koC
 U6gVnvdHXOxL4BKNEkaz8GGpCwazmzacQtQMKiPA3325gHifuH9e+D2qFsYNHNdWSCWJgv
 AmswQPrGywF6Tlo9zaghW0ltsr8Ewuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713344546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X+e9jXfeodR3CrP/AqBhgnJUfsbSqL8mkmwa5zrnsbk=;
 b=owCoA8jGhEbWacrsGYZbUqTvtzza9oUtH2yknyDLRCc8CkH2H20YKm4OLa+xmcIJrrq+ma
 f4iHb1t6V+wkiXDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713344546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X+e9jXfeodR3CrP/AqBhgnJUfsbSqL8mkmwa5zrnsbk=;
 b=2gWtEA7RXgD3VlE3wgK2WsdQmzazm3qAJXP2bHydlH0r1L7GRDGVblbYIoGnIdi7rp9koC
 U6gVnvdHXOxL4BKNEkaz8GGpCwazmzacQtQMKiPA3325gHifuH9e+D2qFsYNHNdWSCWJgv
 AmswQPrGywF6Tlo9zaghW0ltsr8Ewuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713344546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X+e9jXfeodR3CrP/AqBhgnJUfsbSqL8mkmwa5zrnsbk=;
 b=owCoA8jGhEbWacrsGYZbUqTvtzza9oUtH2yknyDLRCc8CkH2H20YKm4OLa+xmcIJrrq+ma
 f4iHb1t6V+wkiXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E731F1384C;
 Wed, 17 Apr 2024 09:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BZdANyGQH2bsTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 09:02:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Apr 2024 11:02:22 +0200
Message-ID: <20240417090222.707302-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.981];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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

This is hit on systems with 64kb page size (e.g. on aarch64 with
CONFIG_ARM64_64K_PAGES=y or on ppc64le with CONFIG_PAGE_SIZE_64KB=y).
Using TINFO causes test not "failing" with non-zero exit code.

Fixes: f987ffff5 ("libswap: add two methods to create swapfile")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/libltpswap/libswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 313a15f24..6d4184ef9 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -160,7 +160,7 @@ int make_swapfile_(const char *file, const int lineno,
 
 	/* To guarantee at least one page can be swapped out */
 	if (blk_size * blocks < pg_size) {
-		tst_res(TWARN, "Swapfile size is less than the system page size. "
+		tst_res(TINFO, "Swapfile size is less than the system page size. "
 			"Using page size (%lu bytes) instead of block size (%lu bytes).",
 			(unsigned long)pg_size, blk_size);
 		blk_size = pg_size;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
