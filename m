Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABA0C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 18:52:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF8013CFCDB
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 20:52:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89FC3CF276
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 20:52:18 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 24022600D68
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 20:52:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 678BD5CE92;
 Thu, 18 Apr 2024 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713466337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4lI/4dp9vezR9A/Nytz82iELqqiCNoDG79mxmB+caA=;
 b=b92R3SMvmp7uaq7cQA5A0+7gjUON2uzL3PVWIDd0F8TLnH3pysnIgyulwHqTSBLtR01jr+
 qPAgnB9wsq4DH3K547cg2P2N5U9M59PhVdIJGpPE+hasuYs3TRyfP+1iCYvdmFYRSxK9/v
 255vfOY8MM2WEmHlryCy5R32xRMkzrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713466337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4lI/4dp9vezR9A/Nytz82iELqqiCNoDG79mxmB+caA=;
 b=vLA9CY2Qe9TDFuH5uFrjZua3k6uPlCaaCQwwmcH2NhZU2QXjWgeF1NOQbNZi7L/QgoHHIh
 7/sOtpC63NiVqQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713466337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4lI/4dp9vezR9A/Nytz82iELqqiCNoDG79mxmB+caA=;
 b=b92R3SMvmp7uaq7cQA5A0+7gjUON2uzL3PVWIDd0F8TLnH3pysnIgyulwHqTSBLtR01jr+
 qPAgnB9wsq4DH3K547cg2P2N5U9M59PhVdIJGpPE+hasuYs3TRyfP+1iCYvdmFYRSxK9/v
 255vfOY8MM2WEmHlryCy5R32xRMkzrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713466337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4lI/4dp9vezR9A/Nytz82iELqqiCNoDG79mxmB+caA=;
 b=vLA9CY2Qe9TDFuH5uFrjZua3k6uPlCaaCQwwmcH2NhZU2QXjWgeF1NOQbNZi7L/QgoHHIh
 7/sOtpC63NiVqQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1AF413894;
 Thu, 18 Apr 2024 18:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +OhQHuBrIWaJewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 18:52:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 20:52:09 +0200
Message-ID: <20240418185210.132137-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418185210.132137-1-pvorel@suse.cz>
References: <20240418185210.132137-1-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] libswap: Add {SAFE_,
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

65536 bytes triggered warning on systems with 64kb page size (e.g. on
aarch64 with CONFIG_ARM64_64K_PAGES=y or on ppc64le with
CONFIG_PAGE_SIZE_64KB=y):

    TWARN: Swapfile size is less than the system page size. Using page size
    (65536 bytes) instead of block size (4096 bytes).

1 MB should be ok for most of the systems.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Use 1MB for minimal swap file instead of using disk block size as a
  base measure of size (Cyril)

 include/libswap.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index 87e32328e..28ce7842d 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -23,6 +23,24 @@ int make_swapfile(const char *file, const int lineno,
 			const char *swapfile, unsigned int num,
 			int safe, enum swapfile_method method);
 
+/* 65536 bytes is minimum for 64kb page size, let's use 1 MB */
+#define MINIMAL_SWAP_SIZE_MB 1
+
+/**
+ * Macro to create minimal swapfile.
+ */
+#define MAKE_MINIMAL_SWAPFILE(swapfile) \
+    make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 0, \
+		  SWAPFILE_BY_SIZE)
+
+/**
+ * Macro to create minimal swapfile.
+ * Includes safety checks to handle potential errors.
+ */
+#define SAFE_MAKE_MINIMAL_SWAPFILE(swapfile) \
+    make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 1, \
+		  SWAPFILE_BY_SIZE)
+
 /**
  * Macro to create swapfile size in megabytes (MB).
  */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
