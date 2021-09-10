Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DCCC433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDB26103D
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BDB26103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BE333C96A1
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 15:08:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A85803C2185
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96ED22011B2
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:29 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB705223B5;
 Fri, 10 Sep 2021 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631279308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2HOo+JBKH38Y0m6j0T5vNKf2c+dO6/tAeCN8wy3QBA=;
 b=dk7BOtScJ8zko9Gfc6wqhj8QhnQGMcq9BrfrPXwZlZn6l0OEdAyp29hnTl9Mt4CnxiTDCk
 P0QxmeFRRuPskRjH7DgKA9DSgL25ArCT0XgpAIIDOQrJtdjgn/7qp4whHN6FiY//HC6cIJ
 stoSvWrBUzn8thUqvF468rfjhon7Jz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631279308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2HOo+JBKH38Y0m6j0T5vNKf2c+dO6/tAeCN8wy3QBA=;
 b=UWoz6iI16THcMbm+9hlT2cByXnDZKoTjCRW4GuS5hQfAsepUxHcEko0xMlI5FVuQpDnDQq
 JUwOpTOzQoD7XhCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A5549133D0;
 Fri, 10 Sep 2021 13:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id mGDgJsxYO2HKdAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 13:08:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Sep 2021 15:08:14 +0200
Message-ID: <20210910130820.21141-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] sched/process.c: Replace errfp with stderr
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
Message-ID: <20210910130814.1cdNDPDnteEKsR7io1i2Q2B1ChLcvlbe2Lz5_xFFNuk@z>

From: Petr Vorel <petr.vorel@gmail.com>

As comment suggest it's indeed not needed :).

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../kernel/sched/process_stress/process.c     | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index a5ff80987..2dd501f2e 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -142,10 +142,8 @@ timer_t timer;			/* timer structure */
 Pinfo *shmaddr;			/* Start address  of shared memory */
 
 #ifndef _LINUX
-FILE *errfp = stderr;		/* error file pointer, probably not necessary */
 FILE *debugfp = stderr;		/* debug file pointer, used if AUSDEBUG set */
 #else
-#define errfp stderr
 #define debugfp stderr
 #endif
 
@@ -201,12 +199,12 @@ void print_shm(void)
 		return;
 
 	for (pinfo = shmaddr, i = 0; i < nodesum; i++, pinfo++) {
-		fprintf(errfp,
+		fprintf(stderr,
 			"slot: %-4d pid: %-6d ppid: %-6d msg: %-2d err: %-2d lst:",
 			i, pinfo->pid, pinfo->ppid, pinfo->msg, pinfo->err);
 		for (j = 0, listp = pinfo->list; j < BVAL; j++, listp++)
-			fprintf(errfp, " %d", *listp);
-		fprintf(errfp, "\n");
+			fprintf(stderr, " %d", *listp);
+		fprintf(stderr, "\n");
 	}
 }
 
@@ -276,13 +274,13 @@ void rm_msgqueue(void)
 
 	/* remove message queue id. */
 	if (msgctl(msgid, IPC_RMID, NULL) && errno != EINVAL) {
-		fprintf(errfp, "msgctl failed msgid: errno %d\n", errno);
+		fprintf(stderr, "msgctl failed msgid: errno %d\n", errno);
 		perror("msgctl failed");
 	}
 
 	/* remove message queue id. */
 	if (msgctl(msgerr, IPC_RMID, NULL) && errno != EINVAL) {
-		fprintf(errfp, "msgctl failed msgerr: errno %d\n", errno);
+		fprintf(stderr, "msgctl failed msgerr: errno %d\n", errno);
 		perror("msgctl failed");
 	}
 }
@@ -297,7 +295,7 @@ void rm_shmseg(void)
 
 	/* remove shared memory id (and shared memory segment). */
 	if (shmctl(shmid, IPC_RMID, NULL) && errno != EINVAL) {
-		fprintf(errfp, "shmctl failed: errno %d\n", errno);
+		fprintf(stderr, "shmctl failed: errno %d\n", errno);
 		perror("shmctl failed");
 	}
 }
@@ -313,13 +311,13 @@ void rm_semseg(void)
 	/* remove sem_lock semaphore id */
 	semarg.val = 0;		/* to fix problem with 4th arg of semctl in 64 bits MARIOG */
 	if (semctl(sem_lock, 0, IPC_RMID, semarg.val) && errno != EINVAL) {
-		fprintf(errfp, "semctl failed: errno %d\n", errno);
+		fprintf(stderr, "semctl failed: errno %d\n", errno);
 		perror("semctl failed");
 	}
 	/* remove sem_count semaphore id. */
 	semarg.val = 0;		/* to fix problem with 4th arg of semctl in 64 bits MARIOG */
 	if (semctl(sem_count, 0, IPC_RMID, semarg.val) && errno != EINVAL) {
-		fprintf(errfp, "semctl failed: errno %d\n", errno);
+		fprintf(stderr, "semctl failed: errno %d\n", errno);
 		perror("semctl failed");
 	}
 }
@@ -1094,7 +1092,7 @@ void messenger(void)
 				case SIGALRM:
 					/* a process is hung, we will terminate */
 					killpg(procgrp, sig);
-					fprintf(errfp,
+					fprintf(stderr,
 						"ALERT! ALERT! WE HAVE TIMED OUT\n");
 					fprintf(stderr,
 						" SEVERE : SIGALRM: A process timed out, we failed\n");
@@ -1109,7 +1107,7 @@ void messenger(void)
 				default:
 					/* somebody sent a signal, we will terminate */
 					killpg(procgrp, sig);
-					fprintf(errfp,
+					fprintf(stderr,
 						"We received signal %d\n", sig);
 					fprintf(stderr,
 						" SEVERE : signal %d received, A proc was killed\n",
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
