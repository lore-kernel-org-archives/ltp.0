Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B7C4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 15:01:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D23A3CADA6
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 16:01:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5748C3CA86B
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 16:01:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C147F1400771
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 16:01:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E1EC1F8A3;
 Wed,  2 Nov 2022 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1667401260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBPFpcNR8Uw2/fqnKHfgdi0dv4W7fP7nywrKN8mTUZQ=;
 b=DtzNeviCgGf5EYyEUGLZXqNGskx/+FfFCoX6os7xGRagpd9r+aj4nTP74XEx+1lsIhgM0h
 GoAkFMf6LXMhhMtnbUHO9Wsis0ie3lJTn5H2EKmtgwkYoCJLWAJQBSVmqLMwXlK5r09Vh3
 oQB9SF9rhpEp8F54E/IIg+wdG8w5eEU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F98B13AE0;
 Wed,  2 Nov 2022 15:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TM1hFSyGYmO1cAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 02 Nov 2022 15:01:00 +0000
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 15:59:35 +0100
Message-Id: <20221102145935.24738-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Correctly check setitimer params in setitimer01
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

Last test rewrite didn't consider the right expected boundaries when
setitimer syscall was tested. We also introduced counter times as
multiple of clock resolution, to avoid kernel rounding during setitimer
counter increase.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/setitimer/setitimer01.c   | 42 ++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index f04cb5a69..3fb9250e2 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -8,20 +8,21 @@
 /*\
  * [Description]
  *
- * Check that a setitimer() call pass with timer seting.
- * Check if signal is generated correctly when timer expiration.
+ * Spaw a child and verify that setitimer() syscall passes and it ends up
+ * counting inside expected boundaries. Then verify from parent that our syscall
+ * sent the correct signal to the child.
  */
 
+#include <time.h>
 #include <errno.h>
 #include <sys/time.h>
 #include <stdlib.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-
-#define USEC1	10000
-#define USEC2	20000
+#include "tst_safe_clocks.h"
 
 static struct itimerval *value, *ovalue;
+static unsigned long time_step;
 
 static struct tcase {
 	int which;
@@ -55,6 +56,7 @@ static void verify_setitimer(unsigned int i)
 {
 	pid_t pid;
 	int status;
+	int usec = 3 * time_step;
 	struct tcase *tc = &tcases[i];
 
 	pid = SAFE_FORK();
@@ -64,14 +66,18 @@ static void verify_setitimer(unsigned int i)
 
 		tst_no_corefile(0);
 
-		set_setitimer_value(USEC1, 0);
-		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
+		set_setitimer_value(usec, 0);
+		TST_EXP_PASS(sys_setitimer(tc->which, value, 0));
 
-		set_setitimer_value(USEC2, USEC2);
+		set_setitimer_value(5 * time_step, 7 * time_step);
 		TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
 
-		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec >= USEC2)
-			tst_brk(TFAIL, "old timer value is not within the expected range");
+		tst_res(TINFO, "tv_sec=%ld, tv_usec=%ld",
+			ovalue->it_value.tv_sec,
+			ovalue->it_value.tv_usec);
+
+		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec)
+			tst_res(TFAIL, "Ending counters are out of range");
 
 		for (;;)
 			;
@@ -85,10 +91,26 @@ static void verify_setitimer(unsigned int i)
 		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
 }
 
+static void setup(void)
+{
+	struct timespec res;
+
+	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
+
+	time_step = res.tv_nsec / 1000;
+	if (time_step < 10000)
+		time_step = 10000;
+
+	tst_res(TINFO, "clock resolution: %luns, time step: %luus",
+		res.tv_nsec,
+		time_step);
+}
+
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.forks_child = 1,
 	.test = verify_setitimer,
+	.setup = setup,
 	.bufs = (struct tst_buffers[]) {
 		{&value,  .size = sizeof(struct itimerval)},
 		{&ovalue, .size = sizeof(struct itimerval)},
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
