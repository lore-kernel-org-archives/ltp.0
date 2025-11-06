Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BFCCCF9F8
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:36:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F368C3CEBD5
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:36:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973463CED01
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B636600146
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 836FC211FA;
 Thu,  6 Nov 2025 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nlSX8y7JrM3YcrmnGl54ZtstHHfK5+Mt43nVt14bf8=;
 b=E1dLmJfP3mpSuUgI+o0R02tWM2ztQ4VZnxA03FCcmjXGFVrDoMQAGdolb6qNcqBJkVZJON
 Y9hY/wmUxlo4guNgIny1VRTg9BFWri3zoxor2nTWq51IaNpqjRjMpUhgc3ule3W8mpAEAC
 5QQAZsoideIMW7eCjTk4y8FANu/uWk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nlSX8y7JrM3YcrmnGl54ZtstHHfK5+Mt43nVt14bf8=;
 b=ZMW6PT/O5cp/BCdHfkAhd4w47Mt7+UVFKsF4thgZHaWPU0phVn7+Udk0IvPJpYryPGC/Dy
 teiXyLnujUXAF6Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E1dLmJfP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZMW6PT/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nlSX8y7JrM3YcrmnGl54ZtstHHfK5+Mt43nVt14bf8=;
 b=E1dLmJfP3mpSuUgI+o0R02tWM2ztQ4VZnxA03FCcmjXGFVrDoMQAGdolb6qNcqBJkVZJON
 Y9hY/wmUxlo4guNgIny1VRTg9BFWri3zoxor2nTWq51IaNpqjRjMpUhgc3ule3W8mpAEAC
 5QQAZsoideIMW7eCjTk4y8FANu/uWk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nlSX8y7JrM3YcrmnGl54ZtstHHfK5+Mt43nVt14bf8=;
 b=ZMW6PT/O5cp/BCdHfkAhd4w47Mt7+UVFKsF4thgZHaWPU0phVn7+Udk0IvPJpYryPGC/Dy
 teiXyLnujUXAF6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4115513A31;
 Thu,  6 Nov 2025 16:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IKEwDjvODGkHRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:35:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Nov 2025 17:34:59 +0100
Message-ID: <20251106163500.1063704-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106163500.1063704-1-pvorel@suse.cz>
References: <20251106163500.1063704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 836FC211FA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] libswap: Remove now unused tst_max_swapfiles()
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
The same as in v1.

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
