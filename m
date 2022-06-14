Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92527C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 11:55:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC86B3C9442
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:55:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E6243C8CA7
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 13:55:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93E0A10000C3
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 13:55:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D01BD219E9
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655207702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8v/K/bhrx7h5ZPWEJN1S3ZPsgGA7c97xn3LvV/6JSA=;
 b=c0jQy5NhNM8cozvsQ6KOB++LG4FXRXue+4dmpsCScHE4ezQBY35iKeM6rlRfJ60ps5ldxS
 DlWhEwljAiDVcZe8AyDlz0d6J8nHsXBZ94dx4jtY2Zlf+GjhQIcXbvOgwiSpxzwjzjf7uw
 kxE/QWQVmReSkMfv9hG5MHLXwuMfsXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655207702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8v/K/bhrx7h5ZPWEJN1S3ZPsgGA7c97xn3LvV/6JSA=;
 b=KUvgwqisSVb68Dest6JatJnLRHYrDMo8I5U5xG24zuzfNdfJgYthtUj77uwBXALF3ejduI
 a2d2GzBD0qNNxPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B41AE139EC
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 11:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id As2+KhZ3qGLnfAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 11:55:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Jun 2022 13:57:10 +0200
Message-Id: <20220614115710.22720-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] [PATCH] syscalls/timer_tests: Hardcode runtime
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

This commit changes how default runtime is set for the timer testcases.

The main motivation behind this is to make sure that runtime is
propagated to the metadata. The downside is that we have to add the
runtime explicitly into each tst_test structure, but I still think that
it's better this way.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_timer_test.h                             |  5 +++++
 lib/tst_timer_test.c                                 | 12 ++++++------
 .../syscalls/clock_nanosleep/clock_nanosleep02.c     |  1 +
 .../kernel/syscalls/epoll_pwait/epoll_pwait03.c      |  1 +
 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c  |  1 +
 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c  |  1 +
 testcases/kernel/syscalls/futex/futex_wait05.c       |  1 +
 testcases/kernel/syscalls/nanosleep/nanosleep01.c    |  1 +
 testcases/kernel/syscalls/poll/poll02.c              |  1 +
 testcases/kernel/syscalls/prctl/prctl09.c            |  1 +
 testcases/kernel/syscalls/pselect/pselect01.c        |  1 +
 testcases/kernel/syscalls/select/select02.c          |  1 +
 12 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/tst_timer_test.h b/include/tst_timer_test.h
index b825a4d1a..689e2eea7 100644
--- a/include/tst_timer_test.h
+++ b/include/tst_timer_test.h
@@ -39,6 +39,11 @@
 
 void tst_timer_sample(void);
 
+/*
+ * By default the timer tests run for bit less than 9 seconds.
+ */
+#define TST_TIMER_TEST_RUNTIME 10
+
 # ifdef TST_NO_DEFAULT_MAIN
 struct tst_test *tst_timer_test_setup(struct tst_test *test);
 # endif /* TST_NO_DEFAULT_MAIN */
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index ef9b24d11..593917f40 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -387,6 +387,10 @@ static void timer_cleanup(void)
 		cleanup();
 }
 
+/*
+ * If you change this table do not forget to update the TST_TIMER_TEST_RUNTIME
+ * in the corresponding header to be slightly larger than a sum of this table.
+ */
 static struct tst_timer_tcase {
 	long long usec;
 	unsigned int samples;
@@ -420,7 +424,6 @@ static struct tst_option options[] = {
 
 static void parse_timer_opts(void)
 {
-	size_t i;
 	long long runtime_us = 0;
 
 	if (str_sleep_time) {
@@ -449,12 +452,9 @@ static void parse_timer_opts(void)
 		test->test_all = single_timer_test;
 		test->test = NULL;
 		test->tcnt = 0;
-	} else {
-		for (i = 0; i < ARRAY_SIZE(tcases); i++)
-			runtime_us += tcases[i].usec * tcases[i].samples;
-	}
 
-	tst_set_max_runtime((runtime_us + runtime_us/10)/1000000);
+		tst_set_max_runtime((runtime_us + runtime_us/10)/1000000);
+	}
 }
 
 struct tst_test *tst_timer_test_setup(struct tst_test *timer_test)
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
index feb3e4791..544884e9a 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -32,5 +32,6 @@ int sample_fn(int clk_id, long long usec)
 
 static struct tst_test test = {
 	.scall = "clock_nanosleep()",
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
index 2ad1a6abc..064231d9d 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -70,5 +70,6 @@ static struct tst_test test = {
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 	.test_variants = TEST_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index d2c0b6ef4..7bd45498e 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -68,6 +68,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.scall = "epoll_wait()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 	.setup = setup,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
index dc62e9202..44b957ee0 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -68,4 +68,5 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index 8fad5d858..b80832054 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -41,4 +41,5 @@ int sample_fn(int clk_id, long long usec)
 static struct tst_test test = {
 	.scall = "futex_wait()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index eaacb89fa..e0045662c 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -35,4 +35,5 @@ int sample_fn(int clk_id, long long usec)
 static struct tst_test test = {
 	.scall = "nanosleep()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
index c0665927b..30026e7d0 100644
--- a/testcases/kernel/syscalls/poll/poll02.c
+++ b/testcases/kernel/syscalls/poll/poll02.c
@@ -55,4 +55,5 @@ static struct tst_test test = {
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/prctl/prctl09.c b/testcases/kernel/syscalls/prctl/prctl09.c
index 07ce57063..8c22d95dd 100644
--- a/testcases/kernel/syscalls/prctl/prctl09.c
+++ b/testcases/kernel/syscalls/prctl/prctl09.c
@@ -44,4 +44,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.scall = "prctl()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 5b2b8b3ba..e2381bc61 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -34,4 +34,5 @@ int sample_fn(int clk_id, long long usec)
 static struct tst_test test = {
 	.scall = "pselect()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 784ec9211..5e51951e6 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -62,4 +62,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_variants = TEST_VARIANTS,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_RUNTIME,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
