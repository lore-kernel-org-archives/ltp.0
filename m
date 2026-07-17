Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47166C4451C
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 12:34:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93DA63E1C40
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 14:34:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDCBD3E58FB
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8697E600B9E
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6FF03E43;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofHGf5FPv9v4VvZTu0C2oZeBVclFzRTQhwdrH9iO+ik=;
 b=jQRtHRPQotcmYXXBAforS0yBs3vzhWwYrktfClDK43h9r6qkzd8BPUKvFK/a440t3yM0xH
 IMNU9nuTxDFCo1tFXJ+IUUZUtEKSLUK5MhAJWLUUOZD8jduWL+XtCKi4D+rX+qmaUwcB90
 WR3S+u0eFMovUhkFPsDkZcouQn1gld8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofHGf5FPv9v4VvZTu0C2oZeBVclFzRTQhwdrH9iO+ik=;
 b=8Fa5yea3/iHq5lTEGEpnNWEndfvnIiBPmGK73+10fNJQ4y9gMlBqVsycDZ4rE2l3cRVEjG
 Z486XDKcGdqroiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofHGf5FPv9v4VvZTu0C2oZeBVclFzRTQhwdrH9iO+ik=;
 b=jQRtHRPQotcmYXXBAforS0yBs3vzhWwYrktfClDK43h9r6qkzd8BPUKvFK/a440t3yM0xH
 IMNU9nuTxDFCo1tFXJ+IUUZUtEKSLUK5MhAJWLUUOZD8jduWL+XtCKi4D+rX+qmaUwcB90
 WR3S+u0eFMovUhkFPsDkZcouQn1gld8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofHGf5FPv9v4VvZTu0C2oZeBVclFzRTQhwdrH9iO+ik=;
 b=8Fa5yea3/iHq5lTEGEpnNWEndfvnIiBPmGK73+10fNJQ4y9gMlBqVsycDZ4rE2l3cRVEjG
 Z486XDKcGdqroiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9791A779AE;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uLc1Iw8hWmr7LgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 12:33:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 14:33:19 +0200
MIME-Version: 1.0
Message-Id: <20260717-fix_core_library-v1-2-c575fcbb2cb3@suse.com>
References: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
In-Reply-To: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784291599; l=785;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+TARZYaNnJRjvHaIgvwKWz6uapCesOhJKH+I9TFYna8=;
 b=xAV+DWe6ZRr3TGYxu08Id529I2ipqDR2vcWvnS3kO0SinHsC7WLqvMkQzrKtNkIxSbTq+pC2W
 aRn3QO//tF6DywbE4D5JRM0JbVWhybw1RMGSg49nKaNTbuN3oTiMv5q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] lib: Close directory fd on ENOSPC in tst_fill_fs
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

The directory descriptor opened at the top of the function was leaked
when openat() failed with ENOSPC and the function returned early. Close
it before returning.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_fill_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index c62d48e289965d59ef6c877870c6047bbecb33da..b1e48fdeea6ab00848aab482fd3899fc6f6ce23c 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -91,6 +91,7 @@ static void fill_flat_vec(const char *path, int verbose)
 	if (fd == -1) {
 		if (errno == ENOSPC) {
 			tst_res(TINFO | TERRNO, "openat()");
+			SAFE_CLOSE(dir);
 			return;
 		}
 		tst_brk(TBROK | TERRNO, "openat(%d, %d, 0600) failed for path %s",

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
