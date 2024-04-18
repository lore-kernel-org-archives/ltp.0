Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E186C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:13:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB5633CFC99
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:13:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93EED3CF511
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:23 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC88F1007CB4
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A77235020;
 Thu, 18 Apr 2024 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0imA8Kz6+MWvpH28dUhJvraZHXL/JKQgoGNThToj1Ik=;
 b=r+HznNBf51TwO/Lwn9VKjDqROz/ZO2WYB71f2QNiSwzEX2u2adL7NA5Q6qOxAFmaKNxBC9
 W+u6Tu6EYTSKmDMVqOW/XGDea5MNB9H47H8+4aT+IKTddSJTC1B6MtPnFYio+fLmKrUtqb
 j+KAlFVw6Met6jaqtj7LIWuzWvwkaJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0imA8Kz6+MWvpH28dUhJvraZHXL/JKQgoGNThToj1Ik=;
 b=68yu+icNtYSqGGtWiYmjlQXcRDLuOuikI4WcUKWoHm1D5zyXXrakY8ZEimkEav0UfHQU9c
 sdGCtmXR+8b79GBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0imA8Kz6+MWvpH28dUhJvraZHXL/JKQgoGNThToj1Ik=;
 b=lb/DOEu2s72VG6CTcKYu3Yo8LCh0xdgDTSeWFWLOoSynEOYBCSCSzUnGX7lSQQJ/8UB02/
 iu+f4zU7kLJX2Iw/ph1fo0/lY5NE4nTHGZ6mTHztfPfe6eD02CNmwYhEbi5j6nbgQoRerO
 0eYDb8dm9WPJm6Is5c5JKMJ+xntvh9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0imA8Kz6+MWvpH28dUhJvraZHXL/JKQgoGNThToj1Ik=;
 b=5c1mMhUq57oJm7eGyev1GrK73BLGifeMQKOe14Gqe3HGMR6RBSOQ7nFzSPAxeVJv37eCOG
 wu7pxFAba0JfsHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D95B213980;
 Thu, 18 Apr 2024 14:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHrlM38qIWbOHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 14:13:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 16:13:11 +0200
Message-ID: <20240418141312.99794-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418141312.99794-1-pvorel@suse.cz>
References: <20240418141312.99794-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] libswap: Add {SAFE_,
 }MAKE_MINIMAL_SWAPFILE() macros
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

Maximum kernel page size is 256KiB (see kernel arch/Kconfig). Therefore
this is the minimum blocks allowed to be used to avoid warning on any
kernel page size setup:

    TWARN: Swapfile size is less than the system page size. Using page size
    (65536 bytes) instead of block size (4096 bytes).

Therefore define this size and add helper macros.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/libswap.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index 87e32328e..ea1285e4f 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -23,6 +23,23 @@ int make_swapfile(const char *file, const int lineno,
 			const char *swapfile, unsigned int num,
 			int safe, enum swapfile_method method);
 
+
+/* see kernel arch/Kconfig */
+#define MINIMAL_SWAP_BLOCKS 256
+
+/**
+ * Macro to create minimal swapfile.
+ */
+#define MAKE_MINIMAL_SWAPFILE(swapfile) \
+    make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_BLOCKS, 0, SWAPFILE_BY_BLKS)
+
+/**
+ * Macro to create minimal swapfile.
+ * Includes safety checks to handle potential errors.
+ */
+#define SAFE_MAKE_MINIMAL_SWAPFILE(swapfile) \
+    make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_BLOCKS, 1, SWAPFILE_BY_BLKS)
+
 /**
  * Macro to create swapfile size in megabytes (MB).
  */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
