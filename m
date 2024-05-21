Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B8C25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 07:50:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D4493CFF69
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 09:50:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8143D3CEFCB
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A57DB2009A5
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C024345B5;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716277801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNXi+tZLjeKTlS7NC1FdjCIE//Lx2hN9zQobodkwtDs=;
 b=OZ2adk1wppYkFO/rLaD4gAhyXd3WAdhMFnVrjR2sRS6xK5FH9FlyMjYq58ohoXuTjCygFZ
 qgHTYEchwdCJCVC8df+BglfscWfEN2m6FZiFG88CMaFYCtRac0L/T2KBixoTwDI8BXM6Ho
 lghBNOJOeXqUgYjX+edejK4FTSmjbco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716277801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNXi+tZLjeKTlS7NC1FdjCIE//Lx2hN9zQobodkwtDs=;
 b=gHBuhCWlcuVsJYBrHYhRWOuiDSIH1HFR1DWfpW613BbhXN3eKDu7tHnw9gVqhJNspeQoAe
 WuY0iJfGclG9tDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716277800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNXi+tZLjeKTlS7NC1FdjCIE//Lx2hN9zQobodkwtDs=;
 b=FHW/DXNRAMM8Ag7UkLouZvUdP85kqSXFIm82+nc3uoGbxmf+KqNPp6beZ1hK8uKDkZteqP
 y9oBcElJ4QLIhMS0O2QhjF3il4AR4yVZUT4UujS0TeQdpQ76YE+mADQ8BSGFa5eag7mv9G
 URuOmcUQannShm1RD0qpgu8Rgs57JHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716277800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNXi+tZLjeKTlS7NC1FdjCIE//Lx2hN9zQobodkwtDs=;
 b=saB1RehTcvOYtvUhfe6/l/fCfO7PwxyReK1wEoqVzEw7uzqRyErPkFVsjmf6Ip5Oq52Duv
 PF9a13kBBGmpTlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5548013A75;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMe+EyhSTGYMFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 07:50:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 09:49:53 +0200
Message-ID: <20240521074955.78675-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521074955.78675-1-pvorel@suse.cz>
References: <20240521074955.78675-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] libswap: Split long lines (readability)
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Separated from the next commit

 libs/libltpswap/libswap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index eb066df71..0066ca734 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -93,7 +93,9 @@ static int file_is_contiguous(const char *filename)
 
 	fd = SAFE_OPEN(filename, O_RDONLY);
 
-	fiemap = (struct fiemap *)SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent));
+	fiemap = (struct fiemap *)SAFE_MALLOC(sizeof(struct fiemap)
+					      + sizeof(struct fiemap_extent));
+
 	memset(fiemap, 0, sizeof(struct fiemap) + sizeof(struct fiemap_extent));
 
 	fiemap->fm_start = 0;
@@ -243,7 +245,8 @@ bool is_swap_supported(const char *filename)
  */
 int tst_max_swapfiles(void)
 {
-	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
+	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0,
+		     swp_device_num = 0, swp_pte_marker_num = 0;
 	struct tst_kconfig_var migration = TST_KCONFIG_INIT("CONFIG_MIGRATION");
 	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
 	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
@@ -281,7 +284,8 @@ int tst_max_swapfiles(void)
 		swp_pte_marker_num = 1;
 	}
 
-	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
+	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num
+		- swp_device_num - swp_pte_marker_num;
 }
 
 /*
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
