Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD06AC4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 10:29:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC1263CD6F5
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 11:29:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D85F53C9737
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 11:29:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD2526002DE
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 11:29:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CED9722D94;
 Thu, 10 Nov 2022 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1668076164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=81rshbNJkstGqir6aQGe9egztBJJX4vRCi39T1Xuq4U=;
 b=Hth0JGlvFw1HdeOHi6Vt4++1oWKRHsRYTL/awjGPh7lGaZyAEu25/Kux4kF4rOr8ODsmB9
 gml1V7kIPI7yrj7f1SLDizLj3RLdaNtgC6pB/AdLG0H70NLPlE2QZfPn9ghTw/y0WllBbN
 04jmNk4yFCC62JIEm2a+1wABfiOsVKE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACC8913B58;
 Thu, 10 Nov 2022 10:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kjc+KITSbGOmDQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 10 Nov 2022 10:29:24 +0000
To: ltp@lists.linux.it
Date: Thu, 10 Nov 2022 11:27:58 +0100
Message-Id: <20221110102758.26328-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Correctly check setitimer params in setitimer01
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We use CLOCK_MONOTONIC_COARSE as our time resolution for checking
setitimer counter boundaries.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Margin in ITIMER_REAL is 0
Add some comments

 .../kernel/syscalls/setitimer/setitimer01.c   | 52 +++++++++++++------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index eb62f02c6..e967577ed 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -8,7 +8,7 @@
 /*\
  * [Description]
  *
- * Spawn a child and verify that setitimer() syscall passes, and it ends up
+ * Spawn a child, verify that setitimer() syscall passes and it ends up
  * counting inside expected boundaries. Then verify from the parent that our
  * syscall sent the correct signal to the child.
  */
@@ -22,7 +22,8 @@
 #include "tst_safe_clocks.h"
 
 static struct itimerval *value, *ovalue;
-static unsigned long time_step;
+static long time_step;
+static long time_count;
 
 static struct tcase {
 	int which;
@@ -56,7 +57,7 @@ static void verify_setitimer(unsigned int i)
 {
 	pid_t pid;
 	int status;
-	int usec = 3 * time_step;
+	long margin;
 	struct tcase *tc = &tcases[i];
 
 	pid = SAFE_FORK();
@@ -66,7 +67,7 @@ static void verify_setitimer(unsigned int i)
 
 		tst_no_corefile(0);
 
-		set_setitimer_value(usec, 0);
+		set_setitimer_value(time_count, 0);
 		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
 
 		set_setitimer_value(5 * time_step, 7 * time_step);
@@ -76,7 +77,14 @@ static void verify_setitimer(unsigned int i)
 			ovalue->it_value.tv_sec,
 			ovalue->it_value.tv_usec);
 
-		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec)
+		/*
+		 * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
+		 * time_step afterward the elapsed time to make sure that
+		 * at least counters take effect.
+		 */
+		margin = tc->which == ITIMER_REAL ? 0 : time_step;
+
+		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > time_count + margin)
 			tst_res(TFAIL, "Ending counters are out of range");
 
 		for (;;)
@@ -93,24 +101,34 @@ static void verify_setitimer(unsigned int i)
 
 static void setup(void)
 {
-	struct timespec res;
-
-	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
-
-	time_step = res.tv_nsec / 1000;
-	if (time_step < 10000)
-		time_step = 10000;
-
-	tst_res(TINFO, "clock resolution: %luns, time step: %luus",
-		res.tv_nsec,
-		time_step);
+	struct timespec time_res;
+
+	/*
+	 * We use CLOCK_MONOTONIC_COARSE resolution for all timers, since
+	 * we are sure its value is bigger than CLOCK_MONOTONIC and we can use
+	 * it for both realtime and virtual/prof timers resolutions.
+	 */
+	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
+
+	time_step = time_res.tv_nsec / 1000;
+	if (time_step <= 0)
+		time_step = 1000;
+
+	time_count = 3 * time_step;
+
+	tst_res(TINFO, "clock resolution: %luns, "
+		"time step: %luus, "
+		"time count: %luus",
+		time_res.tv_nsec,
+		time_step,
+		time_count);
 }
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.forks_child = 1,
-	.test = verify_setitimer,
 	.setup = setup,
+	.test = verify_setitimer,
 	.bufs = (struct tst_buffers[]) {
 		{&value,  .size = sizeof(struct itimerval)},
 		{&ovalue, .size = sizeof(struct itimerval)},
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
