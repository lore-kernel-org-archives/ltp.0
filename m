Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17041C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 339E93CBE6E
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 17:03:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DDC13CBE28
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:03:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C316F200353
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:03:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AECCB337DC;
 Mon, 12 Dec 2022 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670861006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=srX7WiC4O1lw4ZLRjzgDzMsGTTIy05bqASVMhgHPkxs=;
 b=1acm/gnRFHOWGDUOHlPA70xdSzoTO1P4QrQZ5rAeXxQ3F86RdHmnAzr77wTZxFr5jAWCEy
 wDdcITYRbTbHFmon6RiCtHZ5w96WWO1xwrY05eUbWqftXKUpyBlhFZMQR9H5X72gVMA51R
 3PloKHVtOYeflDczl3eS1bDoptj0xDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670861006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=srX7WiC4O1lw4ZLRjzgDzMsGTTIy05bqASVMhgHPkxs=;
 b=Lf3hpka38O9ymUb1CqjFM43m6FkfM0xtp/L3vcwee1bRELQdVFadfsrTd9ACdECZnfo3ko
 F9sm2oWiuL9DffDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E173138F3;
 Mon, 12 Dec 2022 16:03:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2o5qGc5Ql2OadwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Dec 2022 16:03:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 12 Dec 2022 17:03:22 +0100
Message-Id: <20221212160322.4600-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] aio-stress.c: Use static variable iterations
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

local iteration variable in worker() was probably left over from
previous versions rewrite (maybe -i was not used in previous versions).

Clang correctly reported:
aio-stress.c:1049:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
int iteration = 0;

Fixes: 054d45390 ("Rewrite aio-stress test using LTP API")

Reported-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

reported by Richie [1], I got confused thus merge before this fix.

[1] https://lore.kernel.org/ltp/87h6yfifbr.fsf@suse.de/

 testcases/kernel/io/ltp-aiodio/aio-stress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 39db14d65..29e679087 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1046,7 +1046,6 @@ static int *worker(struct thread_info *t)
 	char *this_stage = NULL;
 	struct timeval stage_time;
 	int status = 0;
-	int iteration = 0;
 	int cnt;
 
 	aio_setup(&t->io_ctx, 512);
@@ -1151,7 +1150,7 @@ restart:
 
 	/* someone got restarted, go back to the beginning */
 	if (t->active_opers && cnt < iterations) {
-		iteration++;
+		iterations++;
 		goto restart;
 	}
 
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
