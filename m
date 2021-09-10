Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DFDC433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2EB61153
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD2EB61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5441C3C8D0C
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 15:09:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05CD23C8CE3
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A7F1F1A00FAC
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:30 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B3BE2243E;
 Fri, 10 Sep 2021 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631279310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFe/gPfdsREhEa1XU7zrU7RRhw3Y4rH+//yfS9EjJkE=;
 b=t3neBcuQoIAizyzcB81pdXlODhYCGsW8FzIA9zFBH19Gks5aRCrCKzhOXaH/Ro04N+v8UN
 Iszjqp5Fan0vMc2yHc6DwLd5ASgm6w2FJOJh3g+ZNVQxZTsmy2+GiO6/oxx6RSdcdhMVaE
 MGXR61eLba6ohP8Xbl8jl7hU1YyvgK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631279310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFe/gPfdsREhEa1XU7zrU7RRhw3Y4rH+//yfS9EjJkE=;
 b=3dM/PxrME+ZWulfJA4MF7Gz4mUj9rMEXcvrFbRUQ8DxkngYdt06IshLa4ufyZWoDkUjurB
 k+83tLiPuOI72HDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 08BAF133D0;
 Fri, 10 Sep 2021 13:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id sG5fO81YO2HKdAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 13:08:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Sep 2021 15:08:19 +0200
Message-ID: <20210910130820.21141-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] sched/process.c: Remove non-Linux code
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
Message-ID: <20210910130819.WKihx39-znpLxODFms_nr-sN3QF-tozE7aC72X7RfGU@z>

as we don't care about other platforms.
Also remove -D_LINUX definition from Makefile.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/sched/process_stress/Makefile      |  2 -
 .../kernel/sched/process_stress/process.c     | 67 +------------------
 2 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/Makefile b/testcases/kernel/sched/process_stress/Makefile
index 011017c65..48c825bd9 100644
--- a/testcases/kernel/sched/process_stress/Makefile
+++ b/testcases/kernel/sched/process_stress/Makefile
@@ -24,6 +24,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= -D_LINUX
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index 1fd520eee..b66908e7a 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -27,16 +27,9 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
-
-#ifndef _LINUX
-			/* LINUX INCLUDES */
-#include <sys/mode.h>
-#include <sys/timers.h>
-#else
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/ipc.h>
-#endif
 #include <sys/msg.h>
 #include <sys/resource.h>
 #include <sys/select.h>
@@ -53,17 +46,14 @@
 #define MAXBVAL 70
 #define MAXDVAL 11
 
-#ifdef _LINUX
-			/* LINUX #defnes */
 #ifndef TRUE
 #define TRUE 1
 #endif
 #ifndef FALSE
 #define FALSE 0
 #endif
-#endif
 
-#if defined _LINUX && defined DEBUG
+#ifdef DEBUG
 #define prtln()	printf("At line number: %d\n", __LINE__); \
 		fflush(NULL)
 #define dprt(fmt, args...) printf(fmt, ## args)
@@ -78,9 +68,7 @@
 #define    DVAL  (*edat[DNDX].eval.vint)	/* depth of process tree */
 #define    TVAL  (*edat[TNDX].eval.vint)	/* timer value */
 
-#ifdef _LINUX
 typedef long mtyp_t;
-#endif
 
 /* structure of information stored about each process in shared memory */
 typedef struct proc_info {
@@ -346,9 +334,6 @@ void nextofkin(int sig, int code, struct sigcontext *scp)
 		severe("msgsnd failed: %d msgid %d mtyp %d mtext %d\n",
 		       errno, msgerr, 3, mtext);
 	}
-#ifndef _LINUX
-	reltimerid(timer);
-#endif
 	exit(1);
 }
 
@@ -799,25 +784,14 @@ void set_signals(void *sighandler())
 
 	action.sa_handler = (void *)sighandler;
 
-#ifdef _LINUX
 	sigfillset(&action.sa_mask);
-#else
-	SIGINITSET(action.sa_mask);
-#endif
 	action.sa_flags = 0;
 
 	/* Set the signal handler up */
-#ifdef _LINUX
 	sigaddset(&action.sa_mask, SIGTERM);
-#else
-	SIGADDSET(action.sa_mask, SIGTERM);
-#endif
+
 	for (i = 0; siginfo[i].signum != -1; i++) {
-#ifdef _LINUX
 		sigaddset(&action.sa_mask, siginfo[i].signum);
-#else
-		SIGADDSET(action.sa_mask, siginfo[i].signum);
-#endif
 		rc = sigaction(siginfo[i].signum, &action, NULL);
 		if (rc == -1) {
 			sprintf(tmpstr, "sigaction: %s\n", siginfo[i].signame);
@@ -833,36 +807,6 @@ void set_signals(void *sighandler())
 /*
 * Get and set a timer for current process.
 */
-#ifndef _LINUX
-void set_timer(void)
-{
-	struct itimerstruc_t itimer, old_itimer;
-
-	if ((timer = gettimerid(TIMERID_REAL, DELIVERY_SIGNALS)) == -1) {
-		perror("gettimerid");
-		fprintf(stderr, " SEVERE : Could not get timer id, errno=%d.",
-			errno);
-		exit(1);
-	}
-
-	/*
-	 * Start the timer.
-	 */
-	itimer.it_interval.tv_nsec = 0;
-	itimer.it_interval.tv_sec = 0;
-	itimer.it_value.tv_nsec = 0;
-	itimer.it_value.tv_sec = (time_t) (TVAL * 60.0);
-	if (incinterval(timer, &itimer, &old_itimer) == -1) {
-		perror("incinterval");
-		fprintf(stderr,
-			" SEVERE : Could not set timer interval, errno=%d.",
-			errno);
-		(void)reltimerid(timer);
-		exit(1);
-	}
-}
-#else
-
 void set_timer(void)
 {
 	struct itimerval itimer;
@@ -881,7 +825,6 @@ void set_timer(void)
 		exit(1);
 	}
 }
-#endif
 
 /*
  * parse_args
@@ -1157,11 +1100,7 @@ void doit(void)
 #endif
 		/* set the process group so we can terminate all children */
 		set_signals((void *)nextofkin);	/* set up signal handlers and initialize pgrp */
-#ifndef _LINUX
-		procgrp = setpgrp(0, 0);
-#else
 		procgrp = setpgrp();
-#endif
 		if (AUSDEBUG) {
 			fprintf(stderr, "process group: %d\n", procgrp);
 			fflush(stderr);
@@ -1239,7 +1178,6 @@ int main(int argc, char *argv[])
 	parse_args(argc, argv);	/* Get all command line arguments */
 	dprt("value of BVAL = %d, value of DVAL = %d\n", BVAL, DVAL);
 	nodesum = sumit(BVAL, DVAL);
-#ifdef _LINUX
 	if (nodesum > 250) {
 		printf("total number of process to be created "
 		       "nodesum (%d) is greater\n than the allowed "
@@ -1247,7 +1185,6 @@ int main(int argc, char *argv[])
 		printf("reseting the value of nodesum to SEMMSL\n");
 		nodesum = 250;
 	}
-#endif
 
 	dprt("value of nodesum is initiallized to: %d\n", nodesum);
 
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
