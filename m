Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723EBCA5FF0
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 13:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2061A3E543B
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 15:03:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00C93E5511
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E5A81400B93
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87CC2219D3;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Rm9hzlVCgFtA5t5INC9leF7qZonXeqSiVBBo1VpNqU=;
 b=zQQOrtIdCQV3OFW/6KNzUyU5cWoT4BEI0QUEiuW6sP9kN2FxFQIRldevkccr92Ptqpc/o7
 CgHExrpV8DG0V1+l2xKmSATtXQFEhJ2V+gnkjYBVqytzX+IvA/76XWyqKAvrq8C9T/Gu7H
 V6yv1ClC1B8KiwkAa1Wxchhc+XRi4+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Rm9hzlVCgFtA5t5INC9leF7qZonXeqSiVBBo1VpNqU=;
 b=+rJSGK7Lvwh4+YJYIZPazntlIGT2iDI9gFBMuBDmhu79tjdg6WQdQZXoAxoEOR7qoTHI1h
 1T0/3ujGLPKdd3Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Rm9hzlVCgFtA5t5INC9leF7qZonXeqSiVBBo1VpNqU=;
 b=o1kQ7cVYEPbVFteKkn+Y/B27ENWV5JC/EzsWuVf7NsrXGA+VWsDxto32FIn9m4dSqBr34m
 CjfqiZgpPsDQhLDPF/Y2+5Y1Bw2Za1WrtWv6OHxHIFXsJaL4EEOWHasJ4sZLGpvAVwuPsx
 lmYotBUqu6hsQzJ8HNodtkzORzrLNhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Rm9hzlVCgFtA5t5INC9leF7qZonXeqSiVBBo1VpNqU=;
 b=SCA8Bo6MIlZWARljokAP5NOneZTcsnhpSVBfsTIWGe9NgcKxrRBrZTsHo3gx5XZilKHZdu
 NyOW5zo6MUYA8DDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5136D13C7B;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGTTAG/xxGqLRQAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Tue, 06 Oct 2026 13:02:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 06 Oct 2026 15:02:37 +0200
MIME-Version: 1.0
Message-Id: <20261006-fix_simple_bugs_core_lib-v1-1-c94199a46ec5@suse.com>
References: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791291759; l=1266;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=57cEbIEI/pP0lTnZX9oWAQTUTjkeSmBFhcklT5WWByI=;
 b=VvRXtu7eHFsxrZd5MoqlLCepTfH+3qzrKxiTnAPV+YLKQuvlYGfb/eveydgjD1vhKiAXlAWFV
 QH4e3rxSoEuAT0bB1/TH3/jQvsrqkLPWaD7YpS7GeQjf3tZKnBqu3zj
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_timer_test: Fix out-of-bounds array access
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

Both outlier and early-wake loops in do_timer_test() evaluate
samples[i] before verifying that index i is within bounds.
When all samples are outliers or early, this causes heap buffer
overreads at samples[nsamples] or samples[-1].

Check index bounds before indexing the samples array.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_timer_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index b5a088a14..8f9ec12f6 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -276,7 +276,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
 
 	write_to_file();
 
-	for (i = 0; samples[i] > 10 * usec && i < (int)nsamples; i++) {
+	for (i = 0; i < (int)nsamples && samples[i] > 10 * usec; i++) {
 		if (samples[i] <= 3 * monotonic_resolution)
 			break;
 	}
@@ -286,7 +286,8 @@ void do_timer_test(long long usec, unsigned int nsamples)
 			i, samples[0], samples[i-1]);
 	}
 
-	for (i = nsamples - 1; samples[i] < usec && i > -1; i--);
+	for (i = nsamples - 1; i >= 0 && samples[i] < usec; i--)
+		;
 
 	if (i < (int)nsamples - 1) {
 		tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
