Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A87CCF9F8
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 15:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD03D3CE5D9
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 16:48:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D14AF3CE4B0
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 16:47:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51A231400DC7
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 16:47:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADF9D211A8;
 Wed,  5 Nov 2025 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762357640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NrSeeahc/yj8iexGol0Geb/8zb+0jls0WV7PKtC8Oo=;
 b=VJMlPraN5vASmRY38MKTvwvpkHFb2v026X+ZpJtpoFtsVim+Ohd1MF1U2HKAqA02dCMQH5
 4Rx+mfCkY443Ug4Hl9/bUAtYGb0f2l4bHKmlQXUDTlMArAHX49kiHCfJ9FX9BUXqbAaI+5
 L65ylngQ7UpvUaHbif+kDU40/iT6j0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762357640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NrSeeahc/yj8iexGol0Geb/8zb+0jls0WV7PKtC8Oo=;
 b=fsWqUy08iAKGnEtCPLy1xnouJo82oCWbuRJoWpQ6qFW6D/7Wy+uSZBvctDNGSf8pgpNv0k
 xQXxgFfvk+ZQAKCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762357640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NrSeeahc/yj8iexGol0Geb/8zb+0jls0WV7PKtC8Oo=;
 b=VJMlPraN5vASmRY38MKTvwvpkHFb2v026X+ZpJtpoFtsVim+Ohd1MF1U2HKAqA02dCMQH5
 4Rx+mfCkY443Ug4Hl9/bUAtYGb0f2l4bHKmlQXUDTlMArAHX49kiHCfJ9FX9BUXqbAaI+5
 L65ylngQ7UpvUaHbif+kDU40/iT6j0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762357640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NrSeeahc/yj8iexGol0Geb/8zb+0jls0WV7PKtC8Oo=;
 b=fsWqUy08iAKGnEtCPLy1xnouJo82oCWbuRJoWpQ6qFW6D/7Wy+uSZBvctDNGSf8pgpNv0k
 xQXxgFfvk+ZQAKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 902C913ADD;
 Wed,  5 Nov 2025 15:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDIwIohxC2n7HQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Nov 2025 15:47:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Nov 2025 16:47:16 +0100
Message-ID: <20251105154716.995786-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105154716.995786-1-pvorel@suse.cz>
References: <20251105154716.995786-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] libswap: Remove now unused tst_max_swapfiles()
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

The only use in swapon03 was removed in the previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I can squash this to previous commit if you like.

 include/libswap.h   |  7 -----
 libs/swap/libswap.c | 64 ---------------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index 6904e8f45b..b22b992eeb 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -109,13 +109,6 @@ int make_swapfile(const char *file, const int lineno,
  */
 bool is_swap_supported(const char *filename);
 
-/**
- * tst_max_swapfiles() - Get kernel constant MAX_SWAPFILES value.
- *
- * Return: MAX_SWAPFILES value.
- */
-int tst_max_swapfiles(void);
-
 /**
  * tst_count_swaps() - Get the used swapfiles number.
  *
diff --git a/libs/swap/libswap.c b/libs/swap/libswap.c
index 734cd2612d..3eb589cdd7 100644
--- a/libs/swap/libswap.c
+++ b/libs/swap/libswap.c
@@ -239,70 +239,6 @@ bool is_swap_supported(const char *filename)
 	return true;
 }
 
-int tst_max_swapfiles(void)
-{
-	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0,
-		     swp_device_num = 0, swp_pte_marker_num = 0,
-		     swp_swapin_error_num = 0;
-	struct tst_kconfig_var migration = TST_KCONFIG_INIT("CONFIG_MIGRATION");
-	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
-	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
-	struct tst_kconfig_var marker = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
-	struct tst_kern_exv kvers_marker_migration[] = {
-		/* RHEL9 kernel has patch 6c287605f and 679d10331 since 5.14.0-179 */
-		{ "RHEL9", "5.14.0-179" },
-		{ NULL, NULL},
-	};
-
-	struct tst_kern_exv kvers_marker_migration2[] = {
-		/* RHEL9 kernel has patch ca92ea3dc5a since 5.14.0-441 */
-		{ "RHEL9", "5.14.0-441" },
-		{ NULL, NULL},
-	};
-
-	struct tst_kern_exv kvers_device[] = {
-		/* SLES12-SP4 has patch 5042db43cc26 since 4.12.14-5.5 */
-		{ "SLES", "4.12.14-5.5" },
-		{ NULL, NULL},
-	};
-
-	tst_kconfig_read(&migration, 1);
-	tst_kconfig_read(&memory, 1);
-	tst_kconfig_read(&device, 1);
-	tst_kconfig_read(&marker, 1);
-
-	if (migration.choice == 'y') {
-		if (tst_kvercmp2(5, 19, 0, kvers_marker_migration) < 0)
-			swp_migration_num = 2;
-		else
-			swp_migration_num = 3;
-	}
-
-	if (memory.choice == 'y')
-		swp_hwpoison_num = 1;
-
-	if (device.choice == 'y') {
-		if (tst_kvercmp2(4, 14, 0, kvers_device) >= 0)
-			swp_device_num = 2;
-		if (tst_kvercmp(5, 14, 0) >= 0)
-			swp_device_num = 4;
-		if (tst_kvercmp(6, 15, 0) >= 0)
-			swp_device_num = 3;
-	}
-
-	if ((marker.choice == 'y' &&
-	     tst_kvercmp2(5, 19, 0, kvers_marker_migration) >= 0)
-	    || tst_kvercmp2(6, 2, 0, kvers_marker_migration2) >= 0) {
-		swp_pte_marker_num = 1;
-	}
-
-	if ((tst_kvercmp(5, 19, 0) >= 0) && (tst_kvercmp(6, 2, 0) < 0))
-		swp_swapin_error_num = 1;
-
-	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num
-		- swp_device_num - swp_pte_marker_num - swp_swapin_error_num;
-}
-
 int tst_count_swaps(void)
 {
 	FILE *fp;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
