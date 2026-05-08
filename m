Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBD4CD342F
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 09:18:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 930CC3E2C25
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:18:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55FF13E24DB
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04C72200906
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F13A85CFFA;
 Fri,  8 May 2026 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyx5z0eIh2bAOtH4OhyDs3yKWpbD1A6K0LRPqh7Dl8Y=;
 b=m1WPpB0n6adeO77D3SkcOwpP9rMQyvMywFxLitnmcTxBDlLGzI2PMo+mo2o90rnN/Jx/d5
 cE7Awonl4xmLxSqpVKJsxPzwl/Uw/tthZAT9u3a1sPcLir69lcvEWrdB4aF40RKf3Nklhp
 KkBXl27ca3i9iuDA23ZQVPmjCddIAJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyx5z0eIh2bAOtH4OhyDs3yKWpbD1A6K0LRPqh7Dl8Y=;
 b=AJATcQqL7DUFDAytsQMINy4B48pjo6jJPHBDzVaPTrmSfpWtTTw53BoVz0yJeLJ26SujDr
 dFh3DL2uqwKhfQCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyx5z0eIh2bAOtH4OhyDs3yKWpbD1A6K0LRPqh7Dl8Y=;
 b=jgfFAVAbG/o1sQsv3z6JlSKG2leYgjBtSW+bjqmaYSLJsm75vzsqWE7Mody2/JFZd6IS7I
 /RC+RCYkatP2U/N8yT9JmMkdky1oxh6TFRode0IqLbFb90PyPItycPSeL2ER0w7nJFDUvl
 Xq5R73XCMKY7VoYOqvcyGh5bHzgpzTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyx5z0eIh2bAOtH4OhyDs3yKWpbD1A6K0LRPqh7Dl8Y=;
 b=kjse4ZSfuuseLnLKCyN8LBdsHJpV98fYLWeVuVb0HTR2PcfqYdOCHHVxwLhNYkzSUPJHs0
 cdflt80hqsQ8SBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA7A3593A8;
 Fri,  8 May 2026 09:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCjHMy+q/WnsCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 May 2026 09:17:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 08 May 2026 11:17:34 +0200
MIME-Version: 1.0
Message-Id: <20260508-cve-2026-43284-v1-1-bf2549d2430d@suse.com>
References: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
In-Reply-To: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778231855; l=680;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=aOYMoeT1mvt4hmIxETzbG6E19xKNTCdoNR66ytshqus=;
 b=xGAY8aoTtrJMgRqexP/XLERt0WIJlpYfXf7qQuNN600tfAnZ8zB0dtTbDw3LYtymGimBpxduf
 lDzjIVriCJLAxATKvgxXklebg+a+zqLayDp2hKbM5dQ/NowJM7KC7On
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lapi: fallback SPLICE_F_MORE
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/splice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index 48181715de7610e6f943d50360023d4146ae5f46..9d5a9c97344c9cd434a4f0843009beefd45a0607 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -17,6 +17,10 @@
 #include "config.h"
 #include "lapi/syscalls.h"
 
+#ifndef SPLICE_F_MORE
+# define SPLICE_F_MORE 4
+#endif
+
 #if !defined(HAVE_SPLICE)
 static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
                              loff_t *off_out, size_t len, unsigned int flags)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
