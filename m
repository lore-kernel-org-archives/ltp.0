Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB137CD3430
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:51:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B8113E4988
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:51:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BFB23E61FD
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:51:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 63E4460032D
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:51:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 719765C248;
 Mon,  4 May 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777888265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FOEHGrgSJD5mEGsNGWFOyYBWGDtLKJZLA9LVt7kleI=;
 b=ZxuRVc76p51gQDmJSZcKIFBk3mdgZ7aAqkACI3h/ncBa8dMkZJVS8TO4wqmeyetRW59u5T
 eMKwj28SfasEof2KxNeODBMHqN4qXdcApMnOQNbFdQdZWZWfD927ob7pT7CU/Eo8VgSqEU
 e/X/HnlVbb2HmwuIvz0+w9WgFzMck8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777888265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FOEHGrgSJD5mEGsNGWFOyYBWGDtLKJZLA9LVt7kleI=;
 b=IJAIaUMP89LYXdhp0qs7VyHGscgn4acRbENlVkxIPHrFG5HqtmGlBX/KipPnu9mBCmBEpk
 QmC+zA97ds2UlRCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777888265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FOEHGrgSJD5mEGsNGWFOyYBWGDtLKJZLA9LVt7kleI=;
 b=ZxuRVc76p51gQDmJSZcKIFBk3mdgZ7aAqkACI3h/ncBa8dMkZJVS8TO4wqmeyetRW59u5T
 eMKwj28SfasEof2KxNeODBMHqN4qXdcApMnOQNbFdQdZWZWfD927ob7pT7CU/Eo8VgSqEU
 e/X/HnlVbb2HmwuIvz0+w9WgFzMck8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777888265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FOEHGrgSJD5mEGsNGWFOyYBWGDtLKJZLA9LVt7kleI=;
 b=IJAIaUMP89LYXdhp0qs7VyHGscgn4acRbENlVkxIPHrFG5HqtmGlBX/KipPnu9mBCmBEpk
 QmC+zA97ds2UlRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53108593A6;
 Mon,  4 May 2026 09:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eB30EQls+GkOOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 09:51:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 11:51:00 +0200
MIME-Version: 1.0
Message-Id: <20260504-safe_splice-v3-1-e5acf4c9193b@suse.com>
References: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
In-Reply-To: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888265; l=1394;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=h1d2sUKb7X5RgrWyJRHX+dekD1LOLp/UEnDnjwE8bFQ=;
 b=kD9yBYxARdgwaEbH8wwgR1JoTOCQSQpXH4Q9zsQ7mVo7AEv3TR0hhTfb52xyKGNUDIbvC0xoA
 YP4NF7P4Cp+DE/fPoiyzJtCb9WjMtR/w2Odfq9b0KV+yJZCBHSnO2Fu
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: Add SAFE_SPLICE() macro
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

Add new SAFE_SPLIT() in lapi/splice.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/splice.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index 191b22d2d6397d1efad5e2025be5a2c4370724dc..e346e5cca9f44bd8421c6b99f84cd4646269ac1f 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -7,6 +7,13 @@
 #ifndef LAPI_SPLICE_H__
 #define LAPI_SPLICE_H__
 
+#ifndef _GNU_SOURCE
+# define _GNU_SOURCE
+#endif
+
+#include <fcntl.h>
+#include <sys/types.h>
+
 #include "config.h"
 #include "lapi/syscalls.h"
 
@@ -19,4 +26,25 @@ static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
 }
 #endif
 
+static inline ssize_t safe_splice(const char *file, const int lineno,
+				   int fd_in, loff_t *off_in,
+				   int fd_out, loff_t *off_out,
+				   size_t len, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = splice(fd_in, off_in, fd_out, off_out, len, flags);
+
+	if (ret < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"splice(%d, %d, %zu) failed", fd_in, fd_out, len);
+	}
+
+	return ret;
+}
+
+#define SAFE_SPLICE(fd_in, off_in, fd_out, off_out, len, flags) \
+	safe_splice(__FILE__, __LINE__, (fd_in), (off_in), (fd_out), \
+		    (off_out), (len), (flags))
+
 #endif /* LAPI_SPLICE_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
