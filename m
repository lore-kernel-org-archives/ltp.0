Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2696C61DCD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEA2E3DFABE
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:05:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160C13CE420
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:05:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CD261000A4A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:05:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2FBF1F834;
 Fri, 28 Aug 2026 09:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787907909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSQrFd8K6X9P6RYbhf9bBz4ufs8iawLyVVwNYQpYAXk=;
 b=XkONRjFunafXUO+/FtbSu4CiQmhRJR6UzoF1Z3aBZm0ntMuvNbT15Bz1hmWdJ0lWhGlHIl
 gJxFHCyorlR73P/v5YN1ePWc8KrK1e7kf1bfoU2o7gvJP0Pbg/mD571RgC/lKFH6/+r2ue
 YkZhfBx91Nluk7mMghl+3yYWt+dnZm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787907909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSQrFd8K6X9P6RYbhf9bBz4ufs8iawLyVVwNYQpYAXk=;
 b=+AFcze5+xXrH37UY/gkJ+ZqtacYNja+RtPFN0SLSyZAipcrXoR2hA3LEslLbiTxmLjnbpv
 3Xtm2FLst1MS/2BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787907904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSQrFd8K6X9P6RYbhf9bBz4ufs8iawLyVVwNYQpYAXk=;
 b=BKO2gJviWBf5SYGIy7V1NYgjV2scH01HD8tv4tuDuScOhbapLi2Vuj23iCDzTre3GFfl6X
 sbgRljwaN7kAlJ63z2eVCAEtEtxhZexIYrAfuMRW3TQMDNjiEQ0N2BfVjM1OWMbqHeMvuA
 3WcboFOyMMReNQIdsK5orXnd1v1ua/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787907904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSQrFd8K6X9P6RYbhf9bBz4ufs8iawLyVVwNYQpYAXk=;
 b=D64sSJuEwztbJjaK+EE6EgrS6aJeCbF2KlFEfeofU2PazCn3BwmoynPM5XnPNviLrpacYd
 AFXaURWdCaPodiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6D7413674;
 Fri, 28 Aug 2026 09:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kA31JkBPkWrVYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 09:05:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 11:05:03 +0200
MIME-Version: 1.0
Message-Id: <20260828-swapon_discard_coverage-v2-1-e55a86dad729@suse.com>
References: <20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com>
In-Reply-To: <20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787907904; l=1049;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nQw5F9+8+QtW6xFTXHuY7xMc+4QcXPcx1Lv2xefPoUw=;
 b=WMnrcMunPRR222Re+Rc4AV4z09AI/5yykeZG78bOjqitjbU/yuPSg871N50QAg8FNJTMWGonq
 JPnNK8adIW9C5AjegDrRqxQdPMU/9HpQ/9gzypcIsWjmM1eUuEIwPOr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, linux.dev:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lapi: fallback definitions for swapon syscall
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Introduce fallback definition inside lapi for:

- SWAP_FLAG_PREFER
- SWAP_FLAG_PRIO_MASK
- SWAP_FLAG_DISCARD
- SWAP_FLAG_DISCARD_ONCE
- SWAP_FLAG_DISCARD_PAGES

Reviewed-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tse_swap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/tse_swap.h b/include/tse_swap.h
index c4979b3e5..25fe4ad77 100644
--- a/include/tse_swap.h
+++ b/include/tse_swap.h
@@ -14,6 +14,22 @@
 #ifndef TSE_SWAP_H__
 #define TSE_SWAP_H__
 
+#ifndef SWAP_FLAG_PREFER
+# define SWAP_FLAG_PREFER	0x8000
+#endif
+#ifndef SWAP_FLAG_PRIO_MASK
+# define SWAP_FLAG_PRIO_MASK	0x7fff
+#endif
+#ifndef SWAP_FLAG_DISCARD
+# define SWAP_FLAG_DISCARD	0x10000
+#endif
+#ifndef SWAP_FLAG_DISCARD_ONCE
+# define SWAP_FLAG_DISCARD_ONCE	0x20000
+#endif
+#ifndef SWAP_FLAG_DISCARD_PAGES
+# define SWAP_FLAG_DISCARD_PAGES 0x40000
+#endif
+
 enum swapfile_method {
     SWAPFILE_BY_SIZE,
     SWAPFILE_BY_BLKS

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
