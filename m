Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25913C04FFE
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:31:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DB0D3CFBA5
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:31:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08A4E3CFA00
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:31:18 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E261D201167
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:31:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE1B333C39;
 Wed, 17 Apr 2024 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713357077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CvJS9AuGLxxauzG4fmJDjhpr57x6FDhbkTb0W0eCEqo=;
 b=l2dDpgQLE27ziAxFTBzInssQLQUzp8z24EcMPUPbVS1PmA7rEPFfuD7t3U3MkFP8o7wkN5
 vsl27+cGBy5wPa53CCPtmA+EZqja3Mmm6zWy00T9clgOys8cXXghKeOnaZ5DGYidx0yeFV
 +25P4lwtHdWX7FIK3LUp8j7jRxDko3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713357077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CvJS9AuGLxxauzG4fmJDjhpr57x6FDhbkTb0W0eCEqo=;
 b=EeiTrnUNv7PQAbUu8mB2LtTJbIUKZqvSergMI0k7h/JtJAyuClzltHPLgmIvTj2BYX5ok7
 bW4yBcrHEBAeOVAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h4ozlpGf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fhrXPCvh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713357076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CvJS9AuGLxxauzG4fmJDjhpr57x6FDhbkTb0W0eCEqo=;
 b=h4ozlpGfIYs/WP222AlPQs2q3KjYVAVIc0G3yq7kr5gPiz2P4dM5G4IIINyD2IztDoI8A4
 HKV8iZD9nw/2RRAmDll65HbGSx8/mL9KtgcxvL4dFRw1qowC/d0wLiQ7e97+J7cOx86Ko2
 eiRwLgkDnj3++HwNdo63XDXxon1LN3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713357076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CvJS9AuGLxxauzG4fmJDjhpr57x6FDhbkTb0W0eCEqo=;
 b=fhrXPCvhG/VO1B8SeluMY1GBhlFJdclGh9WUzX2dYl5sPWS+Oai85t4M3FEFKFe2BDFuL1
 Fe3yR+WDHRVq5wBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C8E51384C;
 Wed, 17 Apr 2024 12:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X+uEFRTBH2aiHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 12:31:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Apr 2024 14:31:12 +0200
Message-ID: <20240417123113.731780-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CE1B333C39
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] libswap: Move file & line macros to macros
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

Having __FILE__ and __LINE__ in C function does not help,
they must be in macros to help identify the caller.

Therefore make_swapfile_() wrapper is not needed.

Fixes: f987ffff5 ("libswap: add two methods to create swapfile")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/libswap.h         | 16 +++++-----------
 libs/libltpswap/libswap.c |  2 +-
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/libswap.h b/include/libswap.h
index 96e718542..87e32328e 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -19,41 +19,35 @@ enum swapfile_method {
 /*
  * Create a swapfile of a specified size or number of blocks.
  */
-int make_swapfile_(const char *file, const int lineno,
+int make_swapfile(const char *file, const int lineno,
 			const char *swapfile, unsigned int num,
 			int safe, enum swapfile_method method);
 
-static inline int make_swapfile(const char *swapfile, unsigned int num,
-			int safe, enum swapfile_method method)
-{
-	return make_swapfile_(__FILE__, __LINE__, swapfile, num, safe, method);
-}
-
 /**
  * Macro to create swapfile size in megabytes (MB).
  */
 #define MAKE_SWAPFILE_SIZE(swapfile, size) \
-    make_swapfile(swapfile, size, 0, SWAPFILE_BY_SIZE)
+    make_swapfile(__FILE__, __LINE__, swapfile, size, 0, SWAPFILE_BY_SIZE)
 
 /**
  * Macro to create swapfile size in block numbers.
  */
 #define MAKE_SWAPFILE_BLKS(swapfile, blocks) \
-    make_swapfile(swapfile, blocks, 0, SWAPFILE_BY_BLKS)
+    make_swapfile(__FILE__, __LINE__, swapfile, blocks, 0, SWAPFILE_BY_BLKS)
 
 /**
  * Macro to safely create swapfile size in megabytes (MB).
  * Includes safety checks to handle potential errors.
  */
 #define SAFE_MAKE_SWAPFILE_SIZE(swapfile, size) \
-    make_swapfile(swapfile, size, 1, SWAPFILE_BY_SIZE)
+    make_swapfile(__FILE__, __LINE__, swapfile, size, 1, SWAPFILE_BY_SIZE)
 
 /**
  * Macro to safely create swapfile size in block numbers.
  * Includes safety checks to handle potential errors.
  */
 #define SAFE_MAKE_SWAPFILE_BLKS(swapfile, blocks) \
-    make_swapfile(swapfile, blocks, 1, SWAPFILE_BY_BLKS)
+    make_swapfile(__FILE__, __LINE__, swapfile, blocks, 1, SWAPFILE_BY_BLKS)
 
 /*
  * Check swapon/swapoff support status of filesystems or files
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 313a15f24..b4233be0d 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -133,7 +133,7 @@ out:
 	return contiguous;
 }
 
-int make_swapfile_(const char *file, const int lineno,
+int make_swapfile(const char *file, const int lineno,
 			const char *swapfile, unsigned int num,
 			int safe, enum swapfile_method method)
 {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
