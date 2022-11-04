Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47B4C43217
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:10:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E55B3CAEDD
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:10:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075A03CB48D
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D012D6010F4
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 10:25:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C87241F8C1;
 Fri,  4 Nov 2022 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1667553937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HNg8U9QqzVIxr1gYysiuc0hi4AMtQrGun/pWV8V67F0=;
 b=T4WDPsbpjQ/J7oUh9QUfXVaM0x8aZXZfrHc34au2GcKytCPXKdHurPY/KH52aqruHcg/1e
 9bTY8szy4xe98e6qMJ6pD8LZrMiXhtti7AN6LIWzcgGi6JnCqCRLWDdMAcWO9KbxtEi1GJ
 vcCby72gGY3OqMaVKOsR1/CU8Mjii2k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B6B01346F;
 Fri,  4 Nov 2022 09:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bpfKGpHaZGNDfwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 04 Nov 2022 09:25:37 +0000
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 10:24:11 +0100
Message-Id: <20221104092411.5446-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Correctly handle user time in setitimer01
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

Since ITIMER_VIRTUAL and ITIMER_PROF are counting down in user time, we
need to take in consideration CLOCK_MONOTONIC_COARSE resolution. This is
requested by the syscall, since it's considering context switch from
user to kernel mode by using a higher clock resolution.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/setitimer/setitimer01.c   | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index eb62f02c6..5fcae53e8 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -8,9 +8,16 @@
 /*\
  * [Description]
  *
- * Spawn a child and verify that setitimer() syscall passes, and it ends up
+ * Spawn a child, verify that setitimer() syscall passes and it ends up
  * counting inside expected boundaries. Then verify from the parent that our
  * syscall sent the correct signal to the child.
+ *
+ * Boundaries are choosen accordingly with system clock. In particular, when
+ * timer counts down in real time, CLOCK_MONOTONIC resolution has taken into
+ * account as our time step. When timer counts down in user time,
+ * CLOCK_MONOTONIC_COARSE is used. The reason is that CLOCK_MONOTONIC_COARSE
+ * is our system resolution in user space, since it's taking in consideration
+ * context switches from user to kernel space.
  */
 
 #include <time.h>
@@ -22,7 +29,6 @@
 #include "tst_safe_clocks.h"
 
 static struct itimerval *value, *ovalue;
-static unsigned long time_step;
 
 static struct tcase {
 	int which;
@@ -55,9 +61,31 @@ static void set_setitimer_value(int usec, int o_usec)
 static void verify_setitimer(unsigned int i)
 {
 	pid_t pid;
-	int status;
-	int usec = 3 * time_step;
+	struct timespec res;
 	struct tcase *tc = &tcases[i];
+	int status, usec, time_step, error;
+
+	if (tc->which == ITIMER_REAL)
+		SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
+	else
+		SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &res);
+
+	time_step = res.tv_nsec / 1000;
+	error = time_step;
+
+	if (time_step <= 0) {
+		time_step = 1000;
+		error = 0;
+	}
+
+	usec = 3 * time_step;
+
+	tst_res(TINFO, "clock resolution: %luns, "
+		"time step: %ius, "
+		"counter time: %ius",
+		res.tv_nsec,
+		time_step,
+		usec);
 
 	pid = SAFE_FORK();
 
@@ -76,7 +104,7 @@ static void verify_setitimer(unsigned int i)
 			ovalue->it_value.tv_sec,
 			ovalue->it_value.tv_usec);
 
-		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec)
+		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec + error)
 			tst_res(TFAIL, "Ending counters are out of range");
 
 		for (;;)
@@ -91,26 +119,10 @@ static void verify_setitimer(unsigned int i)
 		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
 }
 
-static void setup(void)
-{
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
-}
-
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.forks_child = 1,
 	.test = verify_setitimer,
-	.setup = setup,
 	.bufs = (struct tst_buffers[]) {
 		{&value,  .size = sizeof(struct itimerval)},
 		{&ovalue, .size = sizeof(struct itimerval)},
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
