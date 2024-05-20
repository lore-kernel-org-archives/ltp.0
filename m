Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FDAC04FFE
	for <ltp@archiver.kernel.org>; Mon, 20 May 2024 12:40:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE4133CFF40
	for <ltp@archiver.kernel.org>; Mon, 20 May 2024 14:40:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2CBE3CFDFF
 for <ltp@lists.linux.it>; Mon, 20 May 2024 14:40:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A3F1E1A002D4
 for <ltp@lists.linux.it>; Mon, 20 May 2024 14:40:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5D3B22CD0;
 Mon, 20 May 2024 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716208811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+AxfX6GsaDWqHBUqfpbTkM0l1fWBLneSjUNgLz9rtrQ=;
 b=YyHNrhoDMpKc+RNj1nIoxUfTNbAT3dQvh353sWTHw0RcS3WNelLeSW4ChC+pMe5n1ECiA6
 hn5mwMzjH3AvyhpeCjThAVFuUdYdebHH+GvTXR8h5OXUnvtsuCQWTRJFMncIqoLF3v1g/P
 VkNGgqCYkDThvS/e8jxkiVQCMVLApSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716208811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+AxfX6GsaDWqHBUqfpbTkM0l1fWBLneSjUNgLz9rtrQ=;
 b=38qiDDV6U0Y+mZHKYml5DLFGPW7GHwPMZhv6hS3Xx6W41Y9s/rakQEMuld4JDvq90Balmz
 OM/gFnrWtuJcMMBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=frpmBCB3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ApknV5mz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716208809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+AxfX6GsaDWqHBUqfpbTkM0l1fWBLneSjUNgLz9rtrQ=;
 b=frpmBCB3CoYEALYgfOu877yK4DOMrwK7v4PN+jGY9+7IcyL55c6dGclKpUaAkupOaNlHlk
 IjO6pjsEgypVhpYG7V0SujMQOzW94fRBhfJQZ1UNjKf4hUDxWO7binGjc6Zkou5iEtYxFf
 k9GAiZ99W/2cC7+ihJOxeo1CtdYUdW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716208809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+AxfX6GsaDWqHBUqfpbTkM0l1fWBLneSjUNgLz9rtrQ=;
 b=ApknV5mzkiTFTcBfC0XXAtSFS1Lj4EYx9AJyC+HZfljbWRBnm8LXVGC9Zm3EckVrlqLWqC
 R0BZ2ON4EZokNfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B09213A21;
 Mon, 20 May 2024 12:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZQFLJKlES2YoXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 May 2024 12:40:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 May 2024 14:40:05 +0200
Message-ID: <20240520124005.57978-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C5D3B22CD0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] libswap: Fix tst_max_swapfiles() for SLE12-SP5
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

SLE12-SP4 backported 5042db43cc26. It's now EOL, but SLE12-SP5 is still
supported, thus fix tst_max_swapfiles() detection.

While at it, fix whitespace.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: this should get merged before release.

I can split whitelist change into a separate commit.

 libs/libltpswap/libswap.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index eb066df71..6c21ac8af 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -243,24 +243,31 @@ bool is_swap_supported(const char *filename)
  */
 int tst_max_swapfiles(void)
 {
-	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
+	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0,
+				 swp_device_num = 0, swp_pte_marker_num = 0;
 	struct tst_kconfig_var migration = TST_KCONFIG_INIT("CONFIG_MIGRATION");
 	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
 	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
 	struct tst_kconfig_var marker = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
-	struct tst_kern_exv kvers[] = {
+	struct tst_kern_exv kvers_marker_migration[] = {
 		/* RHEL9 kernel has patch 6c287605f and 679d10331 since 5.14.0-179 */
 		{ "RHEL9", "5.14.0-179" },
 		{ NULL, NULL},
 	};
 
+	struct tst_kern_exv kvers_device[] = {
+		/* SLES12-SP4 has patch 5042db43cc26 since 4.12.14-5.5 */
+		{ "SLES", "4.12.14-5.5" },
+		{ NULL, NULL},
+	};
+
 	tst_kconfig_read(&migration, 1);
 	tst_kconfig_read(&memory, 1);
 	tst_kconfig_read(&device, 1);
 	tst_kconfig_read(&marker, 1);
 
 	if (migration.choice == 'y') {
-		if (tst_kvercmp2(5, 19, 0, kvers) < 0)
+		if (tst_kvercmp2(5, 19, 0, kvers_marker_migration) < 0)
 			swp_migration_num = 2;
 		else
 			swp_migration_num = 3;
@@ -270,18 +277,19 @@ int tst_max_swapfiles(void)
 		swp_hwpoison_num = 1;
 
 	if (device.choice == 'y') {
-		if (tst_kvercmp(4, 14, 0) >= 0)
+		if (tst_kvercmp2(4, 14, 0, kvers_device) >= 0)
 			swp_device_num = 2;
 		if (tst_kvercmp(5, 14, 0) >= 0)
 			swp_device_num = 4;
 	}
 
-	if ((marker.choice == 'y' && tst_kvercmp2(5, 19, 0, kvers) >= 0) ||
-		tst_kvercmp(6, 2, 0) >= 0) {
+	if ((marker.choice == 'y' && tst_kvercmp(6, 2, 0) >= 0) ||
+	    tst_kvercmp2(5, 19, 0, kvers_marker_migration) >= 0) {
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
