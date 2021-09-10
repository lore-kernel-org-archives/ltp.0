Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A9C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC44861153
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC44861153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58E43C8C75
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 15:09:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A291B3C8CD7
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 913F41A00891
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:29 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2464920212;
 Fri, 10 Sep 2021 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631279309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzO2rNfG4s8JtNFUQt5Lqmsh/XHzFoTz0q241AYSk28=;
 b=0+PAAnH//MxPslKBchdBIv9HLbmKz2r71txBzOkayQ8cP8wu7IP8UNVajWJ/nog1fD6esV
 yGEDTqRlirsKeLnXknmPk/Lxkr5kClQcsnnCma3zLRw8fXnE0MKwJNVne+sn9B61RMSvD4
 UZ72veD1G+hxLH5eNXV3m0vME8FCRQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631279309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzO2rNfG4s8JtNFUQt5Lqmsh/XHzFoTz0q241AYSk28=;
 b=xqxVWOz8JYK3Ls+Ih44mkYNUusrGpF/M00sXHn04H5a3uygCPfsRcEaG4StLNC6Vpr/3jB
 BUxRrMlBw8dw+eCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E30F5133D0;
 Fri, 10 Sep 2021 13:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id eO/zNcxYO2HKdAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 13:08:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Sep 2021 15:08:15 +0200
Message-ID: <20210910130820.21141-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] sched/process.c: Open debugfp with freopen()
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
Message-ID: <20210910130815.kVaSMErF9AeXB-TADEtOO4aKHOdh279-sfgCHsddF6o@z>

From: Petr Vorel <petr.vorel@gmail.com>

i.e. use the recommended way.

This fixes compilation on MUSL which does not like assignment to stderr:

    process.c:551:14: error: assignment of read-only variable 'stderr'
      551 |      debugfp = fopen(foo, "a+");
          |              ^

Also drop debugfp definition. It'd be more obvious to use FILE pointer
for logging, but some debug functions are intended to use to log into
both stderr and into the log files (or at least logging is before stderr
is redirected into the log files), thus use stderr as file descriptor.

Although not sure why part of the code is logged into stdout and other
part into file, let's keep it.

Suggested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/sched/process_stress/process.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index 2dd501f2e..777cdecd4 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -141,12 +141,6 @@ timer_t timer;			/* timer structure */
 
 Pinfo *shmaddr;			/* Start address  of shared memory */
 
-#ifndef _LINUX
-FILE *debugfp = stderr;		/* debug file pointer, used if AUSDEBUG set */
-#else
-#define debugfp stderr
-#endif
-
 struct envstruct *edat = envdata;	/* pointer to environment data */
 
 /* external function declarations */
@@ -260,7 +254,7 @@ void debugout(char *fmt, ...)
 
 	if (AUSDEBUG) {
 		va_start(args, fmt);
-		vfprintf(debugfp, fmt, args);
+		vfprintf(stderr, fmt, args);
 		va_end(args);
 	}
 }
@@ -546,7 +540,12 @@ int spawn(int val)
 			if (!pid) {	/* CHILD */
 				if (AUSDEBUG) {
 					sprintf(foo, "%sslot%d", SLOTDIR, tval);
-					debugfp = fopen(foo, "a+");
+
+					if ((freopen(foo, "w", stderr)) == NULL) {
+						fprintf(stderr, "freopen(%s, w, stderr) failed: %s (%d)\n",
+								foo, strerror(errno), errno);
+						exit(1);
+					}
 				}
 				pinfo = put_proc_info(tval);
 
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
