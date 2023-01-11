Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2196C46467
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 09:14:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A0F3CCAA5
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 10:13:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 740EC3CB560
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 10:13:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CAB8C200981
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 10:13:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82A76170EE;
 Wed, 11 Jan 2023 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673428428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x3T8hSIqx1qqm06xHQ0UBoyCrdTrwcNHWz/eyd2PtwI=;
 b=K95IQPfJMKB1diPFUwbc/EUit/iDsX6iWO7ShoeT5TMJHJk1Ih62lbGqzbY335Inh/GEEb
 s2aVDQAkmnAFEAK/0IXu4Cyl7FN7dhTYQF44+YuqYNByR5pFfs5rZDKrJQ0gXT7EVZrkJM
 cxpOCr7yY7hosiOGyBDUPK5/KFOYCsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673428428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x3T8hSIqx1qqm06xHQ0UBoyCrdTrwcNHWz/eyd2PtwI=;
 b=sZxPjun/xmt2+ktX5w1LuNN1pbPyhIUEAkOr+RzOGtcCcDoxXwZp++PihW+WsDlZvF1hVf
 6xzlW3t+X17fCEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 483311358A;
 Wed, 11 Jan 2023 09:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7fUNEMx9vmPOXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Jan 2023 09:13:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Jan 2023 10:13:41 +0100
Message-Id: <20230111091341.13346-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] aio-stress.c: Remove useless iteration variable
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

NOTE: restart label was considered to be removed, but in the end kept.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Keep restart label (remove only the variable)

 testcases/kernel/io/ltp-aiodio/aio-stress.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index d84d5a0741..5c3a0a3a49 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1039,7 +1039,6 @@ static int *worker(struct thread_info *t)
 	char *this_stage = NULL;
 	struct timeval stage_time;
 	int status = 0;
-	int iteration = 0;
 	int cnt;
 
 	aio_setup(&t->io_ctx, 512);
@@ -1116,10 +1115,8 @@ restart:
 	}
 
 	/* someone got restarted, go back to the beginning */
-	if (t->active_opers && cnt < iterations) {
-		iteration++;
+	if (t->active_opers && cnt < iterations)
 		goto restart;
-	}
 
 	/* finally, free all the ram */
 	while (t->finished_opers) {
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
