Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED882C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:55:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C923D527A
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:55:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 886933D74E4
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 767C4200078
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D1C31F841;
 Thu, 27 Aug 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecoz3LRYVIYCHSjW9yCGUXGvpkPvq4JuhZZZp7J6Fj8=;
 b=0i+VmINinYOjlvNgu4d+ktRd0uNLjuKXKMKRUsN4yEEaQ289YfYEzXDXGWD4mAUpbYzKLh
 VZYdsvE3/LNJi/QkKyUqEwWVk9VRGtIjPU+blgAS10YLU5lhxRUhPrefPwNLs5EDHaA9g0
 rItuXyp+qTid5yaol+28315CoJ/JYv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecoz3LRYVIYCHSjW9yCGUXGvpkPvq4JuhZZZp7J6Fj8=;
 b=nZ870+gqOcLVTwRZ2+mM+Da/AVFrV88zow6VH1JHsjPOBQ8Zpys6EjIj2evSLeljkV76HV
 PDq7a2Mer7uLmrCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecoz3LRYVIYCHSjW9yCGUXGvpkPvq4JuhZZZp7J6Fj8=;
 b=tV/PrIyGzQDuUsan9errlSeD3lxeWvKfTHchHRc/0r1iOV+2E3yoBSLTXkhUNQZ9A7BXBp
 BMgC9NC0L6AVaKTfDyhV0YZPGqjZp3zyxJsCgBmTufLymsYhyJMw7rD4w0tjAmALw4hR3S
 obftRhzpglb1nnGLpjLL9A5rp+ydK/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecoz3LRYVIYCHSjW9yCGUXGvpkPvq4JuhZZZp7J6Fj8=;
 b=46ZwM/Qqrr84e85qzrSovegjWKsAeu0kds0Zzzmh0IDpT4tvPDUva8HtdxYOSl8Mn18HX6
 3FbVUshlYBQmidAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4A8413533;
 Thu, 27 Aug 2026 11:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QPpNNmIlkGq6DAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 11:54:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 13:54:04 +0200
MIME-Version: 1.0
Message-Id: <20260827-swapon_discard_coverage-v1-1-633bcb11c181@suse.com>
References: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
In-Reply-To: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787831650; l=1007;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=aMEh3Rbq9G5DR3Ce/1u6os0hQR7nGA5ZDMYIX1gu/6Y=;
 b=NYwGK2PAB1O1+O/aXkDwATgV1Kn9glDTDAevsSj2Gk/Y/mmzIm6Gc1/lUq+8yX7JvuE97vXYn
 zU4Ngih8o1wBbt8xCw6UOVtE6eBAUpFQ7p2Nz4ZcxOmRPhr0RVZNavr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lapi: fallback definitions for swapon syscall
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
