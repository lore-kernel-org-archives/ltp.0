Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F62AC433F5
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 11:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3003CAC7C
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 13:29:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E033B3CAAF4
 for <ltp@lists.linux.it>; Wed, 25 May 2022 13:29:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 367C5600834
 for <ltp@lists.linux.it>; Wed, 25 May 2022 13:29:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECA40219B1
 for <ltp@lists.linux.it>; Wed, 25 May 2022 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653478145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5NmUMdjZNb36l+B51ILo73W8avTZ4fGryw0MqMBQv/o=;
 b=PPI/NAYAt3svx7zuvljGysPFO/3A8JL8B++wtu6L8Qe3Sp3fYp7v9lG11/MYKgl225Iben
 Sd53Bocbv/BWdGgff6SIn72WBCYHXU3OX/HDlziDX6nAmu7gZEDTU7fKIMcLNyCuhSCnCd
 /QptkT7ZhHlY18pKWWacuk5TCbwOz8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653478145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5NmUMdjZNb36l+B51ILo73W8avTZ4fGryw0MqMBQv/o=;
 b=YIv/OVisq7nGjhI9Q651HSOeY9hGooEeRDFySrhtjCM4vzllQiaEH6TKDFYrryksC6fX2G
 wjU9O34an5dScrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC65713487
 for <ltp@lists.linux.it>; Wed, 25 May 2022 11:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tn6GMAETjmJZEAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 25 May 2022 11:29:05 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 May 2022 13:31:13 +0200
Message-Id: <20220525113113.9811-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/timer_settime03: Scale interval with clock
 precision
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

What the test does is to:

- set initial expiration in the past
- set very small interval value
- expect the timer to overrun immediatelly many times
  to trigger timer overrun counter overflow

However the test has harcoded expectation that the kernel timers have
1ns resolution. And while that is true for many modern hardware high
resolution timers are generally not always present.

The test tried to cope with that by adding kernel requirement for
CONFIG_HIGH_RES_TIMERS=y however that does not necessarily mean that the
high resolution hardware is present or that the drivers are loaded.
This only means that the support has been compiled in the kernel.

So instead of disabling the test when kernel timers have lower precision
we scale the timer interval so that the inverval length divided by the
timer precision is constant i.e. handler_delay.

Fixes #925

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/timer_settime/timer_settime03.c      | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime03.c b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
index 4597bf74e..a828f63d3 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime03.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
@@ -32,6 +32,8 @@
 static timer_t timer;
 static volatile int handler_called, overrun, saved_errno;
 
+static struct timespec realtime_resolution;
+
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	struct itimerspec spec;
@@ -61,6 +63,11 @@ static void setup(void)
 
 	SAFE_SIGNAL(SIGUSR1, sighandler);
 	SAFE_TIMER_CREATE(CLOCK_REALTIME, &sev, &timer);
+
+	SAFE_CLOCK_GETRES(CLOCK_REALTIME, &realtime_resolution);
+
+	tst_res(TINFO, "CLOCK_REALTIME resolution %lins",
+	        (long)realtime_resolution.tv_nsec);
 }
 
 static void run(void)
@@ -81,9 +88,9 @@ static void run(void)
 
 	/* spec.it_value = now - 1.4 * max overrun value */
 	/* IOW, overflow will land right in the middle of negative range */
-	spec.it_value.tv_sec -= handler_delay / 100000000;
+	spec.it_value.tv_sec -= (handler_delay / 100000000) * realtime_resolution.tv_nsec;
 	spec.it_value.tv_nsec -= nsec;
-	spec.it_interval.tv_nsec = 1;
+	spec.it_interval.tv_nsec = realtime_resolution.tv_nsec;
 
 	SAFE_TIMER_SETTIME(timer, TIMER_ABSTIME, &spec, NULL);
 	while (!handler_called);
@@ -115,10 +122,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_HIGH_RES_TIMERS=y",
-		NULL
-	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "78c9c4dfbf8c"},
 		{"CVE", "2018-12896"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
