Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F37ECD13D3
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 17:25:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A6AA3E6C97
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 19:25:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 094833E1BEC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 19:25:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B7B120118E
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 19:25:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B602A5BD76;
 Thu, 30 Apr 2026 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777569930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi7kf9XmY+t2/F9XBmXW0W3CfhM2YHbAQErs1toBJ7A=;
 b=EtowRRcTmh4rKnirnRBQcQYNM4dxMtZQhWifAEumenn/ybN3UUcG5UO8ykoYBoBCwVceyz
 IMw0kmInl1WaSAoNUIhRe2ZBx38NnxfLRElCEyEKmYa7bXi4Z3lX6ML/0uf+GD01FusJ58
 Qa/L0a0ur8Ll6QObzOD1XcxRHlPbwd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777569930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi7kf9XmY+t2/F9XBmXW0W3CfhM2YHbAQErs1toBJ7A=;
 b=CBx+hCfN17xnErGDp7p6D0iH9vcdpHAGRi7h9hUR3j6l/Iwr2fpp7SGQPlcr188leM7u5k
 VolaFqw9mz4TvSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777569930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi7kf9XmY+t2/F9XBmXW0W3CfhM2YHbAQErs1toBJ7A=;
 b=EtowRRcTmh4rKnirnRBQcQYNM4dxMtZQhWifAEumenn/ybN3UUcG5UO8ykoYBoBCwVceyz
 IMw0kmInl1WaSAoNUIhRe2ZBx38NnxfLRElCEyEKmYa7bXi4Z3lX6ML/0uf+GD01FusJ58
 Qa/L0a0ur8Ll6QObzOD1XcxRHlPbwd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777569930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi7kf9XmY+t2/F9XBmXW0W3CfhM2YHbAQErs1toBJ7A=;
 b=CBx+hCfN17xnErGDp7p6D0iH9vcdpHAGRi7h9hUR3j6l/Iwr2fpp7SGQPlcr188leM7u5k
 VolaFqw9mz4TvSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96B7B593B1;
 Thu, 30 Apr 2026 17:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJY2I4qQ82kMIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Apr 2026 17:25:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 19:25:29 +0200
MIME-Version: 1.0
Message-Id: <20260430-safe_splice-v1-1-d1d919ff2a3a@suse.com>
References: <20260430-safe_splice-v1-0-d1d919ff2a3a@suse.com>
In-Reply-To: <20260430-safe_splice-v1-0-d1d919ff2a3a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777569930; l=2390;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OKqSZ6LXj6H7kjfhRSTFZV6P69iuPY1CYnybsY3NAK8=;
 b=b02Nioc1A28NB6wpZuFBaf6NjDpYvoIyo/zMiEUhlgH4suEO6vCE0/1mBQJs7lN0Cwr8Yu+kW
 HOGKR1ETishDa3nNwESIbngufEH16dj3Ae9FEtD+Q4qoIomdjOikUn+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add SAFE_SPLICE() macro
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

splice() is used as utility plumbing in several tests (tee01,
vmsplice01, af_alg08) but lacks a SAFE_* wrapper, forcing each
caller to manually check the return value. Add SAFE_SPLICE()
following the existing safe_pipe2() pattern.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_safe_macros.h |  8 ++++++++
 lib/tst_safe_macros.c     | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c73c1acb1cbd671d4d22b740647d3e7491f7baf2..53caf845d1172cccf23d631d97e1f5086f98f547 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -114,6 +114,14 @@ int safe_pipe2(const char *file, const int lineno, int fildes[2], int flags);
 #define SAFE_PIPE2(fildes, flags) \
 	safe_pipe2(__FILE__, __LINE__, (fildes), (flags))
 
+ssize_t safe_splice(const char *file, const int lineno,
+		    int fd_in, loff_t *off_in, int fd_out, loff_t *off_out,
+		    size_t len, unsigned int flags);
+
+#define SAFE_SPLICE(fd_in, off_in, fd_out, off_out, len, flags) \
+	safe_splice(__FILE__, __LINE__, (fd_in), (off_in), (fd_out), \
+		    (off_out), (len), (flags))
+
 #define SAFE_READ(len_strict, fildes, buf, nbyte) \
 	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index cdc8c7dd33cb0f805d40095b732d723497b2adeb..8f3dbbd1d2f371f2986356187c41007993f1589e 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -21,6 +21,7 @@
 #include "tst_safe_macros.h"
 #include "lapi/personality.h"
 #include "lapi/pidfd.h"
+#include "lapi/splice.h"
 
 int safe_access(const char *file, const int lineno,
 	    const char *pathname, int mode)
@@ -512,6 +513,22 @@ int safe_pipe2(const char *file, const int lineno, int fildes[2], int flags)
 	return ret;
 }
 
+ssize_t safe_splice(const char *file, const int lineno,
+		    int fd_in, loff_t *off_in, int fd_out, loff_t *off_out,
+		    size_t len, unsigned int flags)
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
 int safe_dup(const char *file, const int lineno, int oldfd)
 {
 	int rval;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
