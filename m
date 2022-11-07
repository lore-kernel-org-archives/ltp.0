Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163FFC4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 11:03:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B3BC3CD9BE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 12:03:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A3513CA983
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:02:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D384F140018A
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:02:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 878FE2239D;
 Mon,  7 Nov 2022 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1667818969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cc9IWVAX5TIvhLJgUHQXnPnTMdHLMBjAzTiAOzlJdGo=;
 b=frK5pb8QD9dxt1+3XlPOfhXlWdUuvZtei79/Vmie+tLIyh0sQv0DX4XIgtimeLvTUm0BHp
 uZnW7KjIeK47Bhqqp6m2INbAKsaLDQivw7TkrnB60tvC0Uc9ddzhQ/KpW15DnSI9aXB5Oz
 7Dc/cq3emUonEW4e+8N7bXVt8UTDbWM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57CD913494;
 Mon,  7 Nov 2022 11:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wtutEtnlaGNPBQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 07 Nov 2022 11:02:49 +0000
To: ltp@lists.linux.it
Date: Mon,  7 Nov 2022 12:01:23 +0100
Message-Id: <20221107110123.16369-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Correctly check setitimer params in setitimer01
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
Switching to CLOCK_MONOTONIC_COARSE for setitimer time resolution.

 .../kernel/syscalls/setitimer/setitimer01.c   | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index eb62f02c6..5c880c6ef 100644
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
@@ -56,7 +57,6 @@ static void verify_setitimer(unsigned int i)
 {
 	pid_t pid;
 	int status;
-	int usec = 3 * time_step;
 	struct tcase *tc = &tcases[i];
 
 	pid = SAFE_FORK();
@@ -66,7 +66,7 @@ static void verify_setitimer(unsigned int i)
 
 		tst_no_corefile(0);
 
-		set_setitimer_value(usec, 0);
+		set_setitimer_value(time_count, 0);
 		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
 
 		set_setitimer_value(5 * time_step, 7 * time_step);
@@ -76,7 +76,7 @@ static void verify_setitimer(unsigned int i)
 			ovalue->it_value.tv_sec,
 			ovalue->it_value.tv_usec);
 
-		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec)
+		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > time_count + time_step)
 			tst_res(TFAIL, "Ending counters are out of range");
 
 		for (;;)
@@ -93,24 +93,29 @@ static void verify_setitimer(unsigned int i)
 
 static void setup(void)
 {
-	struct timespec res;
+	struct timespec time_res;
 
-	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
+	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
 
-	time_step = res.tv_nsec / 1000;
-	if (time_step < 10000)
-		time_step = 10000;
+	time_step = time_res.tv_nsec / 1000;
+	if (time_step <= 0)
+		time_step = 1000;
 
-	tst_res(TINFO, "clock resolution: %luns, time step: %luus",
-		res.tv_nsec,
-		time_step);
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
