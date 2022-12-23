Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3498DC4332F
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 18:33:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CABA3CC9EB
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 19:33:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0E43C010A
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 19:33:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41E46200FD9
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 19:33:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6F4A8D090;
 Fri, 23 Dec 2022 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671820410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4vLkOQb8ODGMUVG1MaugnYvPsOR1GtJXzexr0g+DNTM=;
 b=jg1eDaqV49ZeILoST19NAk/ux7kiYiLUKWQt+wWoO2LjwWvjjvq0ii6H5pLbzHzJpBXNFB
 usUiPc0edojc8b4Lpd0sNfaHTNY97RDqRHJ70W8zaTj7FKujnH6nwf+AXJySXVOO88slb0
 /6kf4tkkgYFDa54OhzJdBZFnCv496Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671820410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4vLkOQb8ODGMUVG1MaugnYvPsOR1GtJXzexr0g+DNTM=;
 b=K3QLGfeejX1ynTFF2L0xvGUVBUrQZBhxUf9Vh6fSUGVgwBbPmrffjm4sHOh3v4JepL91au
 BS44VbL80De2lyBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7741813913;
 Fri, 23 Dec 2022 18:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1zTwGXr0pWNTRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Dec 2022 18:33:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Dec 2022 19:33:25 +0100
Message-Id: <20221223183325.10814-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] aio-stress.c: Remove useless iteration variable
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
previous version before rewrite because clang correctly reported also on
this old version:

    aio-stress.c:1049:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
    int iteration = 0;

Whole restart label was not used.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* remove whole restart label.

 testcases/kernel/io/ltp-aiodio/aio-stress.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 2fdbb84e87..2946ac1f47 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1039,12 +1039,10 @@ static int *worker(struct thread_info *t)
 	char *this_stage = NULL;
 	struct timeval stage_time;
 	int status = 0;
-	int iteration = 0;
 	int cnt;
 
 	aio_setup(&t->io_ctx, 512);
 
-restart:
 	if (num_threads > 1) {
 		if (pthread_barrier_wait(&worker_barrier))
 			gettimeofday(&global_stage_start_time, NULL);
@@ -1115,12 +1113,6 @@ restart:
 			global_thread_throughput(t, this_stage);
 	}
 
-	/* someone got restarted, go back to the beginning */
-	if (t->active_opers && cnt < iterations) {
-		iteration++;
-		goto restart;
-	}
-
 	/* finally, free all the ram */
 	while (t->finished_opers) {
 		oper = t->finished_opers;
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
