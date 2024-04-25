Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB55C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 21:11:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89C2B3CFE81
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 23:11:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A53793CE531
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:10:51 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CA481400425
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:10:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88D8F22809;
 Thu, 25 Apr 2024 21:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714079450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5S4cAN1tSNNEiyt+ShD20zFYbetJIxeWtK27jFyWnI=;
 b=pheZ8YVbrh/GlFaeq9T2/wZ3B2QS6XuOgD4ML+SNka4E7zmlImgL+NIGgHG7rypChAcs7E
 ycUlQQicZF0KyiXUzPr4pDmKy01DXI/4moW/nGMrBgtZQkxppRCwqyCMdw7I++GRTX808U
 /ac/q0a/2dy1EuJ5j98RUlf//Q1RUEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714079450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5S4cAN1tSNNEiyt+ShD20zFYbetJIxeWtK27jFyWnI=;
 b=/69ZCfe5Ful4C+/t3WzYg1BzvaIRc4JfzvymcJ0Q6EM3UTobd8/LLitU4UFrc5A40u+B1/
 0UeLLr5VNI3CL5AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pheZ8YVb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/69ZCfe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714079450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5S4cAN1tSNNEiyt+ShD20zFYbetJIxeWtK27jFyWnI=;
 b=pheZ8YVbrh/GlFaeq9T2/wZ3B2QS6XuOgD4ML+SNka4E7zmlImgL+NIGgHG7rypChAcs7E
 ycUlQQicZF0KyiXUzPr4pDmKy01DXI/4moW/nGMrBgtZQkxppRCwqyCMdw7I++GRTX808U
 /ac/q0a/2dy1EuJ5j98RUlf//Q1RUEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714079450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5S4cAN1tSNNEiyt+ShD20zFYbetJIxeWtK27jFyWnI=;
 b=/69ZCfe5Ful4C+/t3WzYg1BzvaIRc4JfzvymcJ0Q6EM3UTobd8/LLitU4UFrc5A40u+B1/
 0UeLLr5VNI3CL5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3DA3139A9;
 Thu, 25 Apr 2024 21:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yGplOtnGKmbQaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 21:10:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Apr 2024 23:10:41 +0200
Message-ID: <20240425211042.299714-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425211042.299714-1-pvorel@suse.cz>
References: <20240425211042.299714-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 88D8F22809
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] libswap: Add {SAFE_,
 }MAKE_SMALL_SWAPFILE() macros
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

65536 bytes triggered warning on systems with 64 kb page size (e.g. on
aarch64 with CONFIG_ARM64_64K_PAGES=y or on ppc64le with
CONFIG_PAGE_SIZE_64KB=y):

    TWARN: Swapfile size is less than the system page size. Using page size
    (65536 bytes) instead of block size (4096 bytes).

1 MB should be ok for most of the systems.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/libswap.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index 87e32328e..f757073cc 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -23,6 +23,24 @@ int make_swapfile(const char *file, const int lineno,
 			const char *swapfile, unsigned int num,
 			int safe, enum swapfile_method method);
 
+/** 65536 bytes is minimum for 64kb page size, let's use 1 MB */
+#define MINIMAL_SWAP_SIZE_MB 1
+
+/**
+ * Macro to create minimal swapfile.
+ */
+#define MAKE_SMALL_SWAPFILE(swapfile) \
+    make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 0, \
+		  SWAPFILE_BY_SIZE)
+
+/**
+ * Macro to create minimal swapfile.
+ * Includes safety checks to handle potential errors.
+ */
+#define SAFE_MAKE_SMALL_SWAPFILE(swapfile) \
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
