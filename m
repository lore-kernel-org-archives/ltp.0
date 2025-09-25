Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E78CAC5A7
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 13:55:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BAA63CE063
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 15:55:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C423CD942
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 15:55:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8815A14004EB
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 15:55:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7836D6B791;
 Thu, 25 Sep 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6639513869;
 Thu, 25 Sep 2025 13:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m7G0F8NJ1WiGNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Sep 2025 13:55:15 +0000
From: Cyril Hrubis <metan@ucw.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Sep 2025 15:54:48 +0200
Message-ID: <20250925135448.19818-1-metan@ucw.cz>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 R_DKIM_NA(2.20)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-0.999]; R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[metan@ucw.cz,chrubis@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995];
 FROM_NEQ_ENVFROM(0.10)[metan@ucw.cz,chrubis@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 7836D6B791
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] realtime: Fix removal of autotools
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

From: Cyril Hrubis <chrubis@suse.cz>

When we removed the autotools from the realtime subdirectory we failed
to remove the HAS_PRIORITY_INHERIT ifdefs from the source code.

Closes: https://github.com/linux-test-project/ltp/issues/1264

Fixes: a05298ec4494 ("testcases: realtime: Get rid of autotools")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/realtime/func/pi-tests/testpi-5.c   | 5 -----
 testcases/realtime/lib/librttest.c            | 4 ----
 testcases/realtime/stress/pi-tests/testpi-3.c | 2 --
 3 files changed, 11 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index 24bbb334c..80c83fa69 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -69,8 +69,6 @@ int do_test(int argc, char **argv)
 	pthread_mutexattr_t mutexattr;
 	int retc, protocol;
 
-#if HAS_PRIORITY_INHERIT
-
 	if (pthread_mutexattr_init(&mutexattr) != 0)
 		printf("Failed to init mutexattr\n");
 
@@ -91,9 +89,6 @@ int do_test(int argc, char **argv)
 	join_threads();
 
 	return 0;
-#else
-	return 1;
-#endif
 }
 
 #include "test-skeleton.c"
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 99ce78b33..21ea57dec 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -591,7 +591,6 @@ void *busy_work_us(int us)
 
 void init_pi_mutex(pthread_mutex_t * m)
 {
-#if HAS_PRIORITY_INHERIT
 	pthread_mutexattr_t attr;
 	int ret;
 	int protocol;
@@ -614,9 +613,6 @@ void init_pi_mutex(pthread_mutex_t * m)
 	if ((ret = pthread_mutex_init(m, &attr)) != 0) {
 		printf("Failed to init mutex: %d (%s)\n", ret, strerror(ret));
 	}
-#endif
-
-	/* FIXME: does any of this need to be destroyed ? */
 }
 
 /* Write the entirety of data.  Complain if unable to do so. */
diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c b/testcases/realtime/stress/pi-tests/testpi-3.c
index 70ec94513..8a3e7c731 100644
--- a/testcases/realtime/stress/pi-tests/testpi-3.c
+++ b/testcases/realtime/stress/pi-tests/testpi-3.c
@@ -365,7 +365,6 @@ int main(int argc, char *argv[])
 
 	printf("Start %s\n", argv[0]);
 
-#if HAS_PRIORITY_INHERIT
 	if (!nopi) {
 		pthread_mutexattr_t mutexattr;
 		int protocol;
@@ -386,7 +385,6 @@ int main(int argc, char *argv[])
 			printf("Failed to init mutex: %d\n", retc);
 		}
 	}
-#endif
 
 	startThread(&arg1);
 	startThread(&arg2);
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
