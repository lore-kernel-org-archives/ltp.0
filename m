Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E728DC433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513F36023F
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 513F36023F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61E4F3C661A
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:02:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24E953C673B
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46967601CC9
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B39212195A
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5V4bAjDOQMVcKaMFjxsSJQhi0myRJnJP9S9V8XD7hc=;
 b=bcY3v+mlnbmkobdLlQS48UHoTfLf6WZ7CTrcP25VxTdIcpurX7i225mHE2z2Kv5PpI8KoC
 hZIbQLZXjyhUsTO3YkXy7hVAaamwQuoFGKnnD45JT2xS+WcYaKgNyO5J/uQKQ59nrkmMV9
 xnEZ/39PcP2nvgbFtXEOJEx64Sncb6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5V4bAjDOQMVcKaMFjxsSJQhi0myRJnJP9S9V8XD7hc=;
 b=WAP72A3llT5Ghy/6PwpNneRrwzVAOv/UByt7ESj7YTKTRtA3Z4pC9Aq4oATQVybwKlTHk3
 r7P2GG7RK9LLJNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C31F13C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ce9bFLHUdmGmLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:34 +0200
Message-Id: <20211025160134.9283-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025160134.9283-1-chrubis@suse.cz>
References: <20211025160134.9283-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] lib: Add tst_set_runtime() & remove
 tst_set_timeout()
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

Rarely there is a need to set the test runtime dynamically, the only
tests in LTP that does this are the timer tests that can get two
parameters, number of iterations and sleep time, and the test runtime is
close to the multiplication of these two.

It's still cleaner to set the runtime and let the test library figure
out the timeout in this case.

Also when no parameters are passed to these tests the runtime is a sum
of multiplications from the tst_timer_test.c source so we define a
constant in the tst_timer_test.h header and set the max_runtime in the
testcases accordingly. With this we get correct estimate for the test
runtime and tighter, but still forgiving enough, timeout as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                            |  8 ++++-
 include/tst_timer_test.h                      |  3 ++
 lib/newlib_tests/.gitignore                   |  1 +
 lib/newlib_tests/test_max_runtime03.c         | 35 +++++++++++++++++++
 lib/tst_test.c                                | 35 +++++++++++--------
 lib/tst_timer_test.c                          |  4 +--
 .../clock_nanosleep/clock_nanosleep02.c       |  1 +
 .../syscalls/epoll_pwait/epoll_pwait03.c      |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait02.c |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait04.c |  2 +-
 .../syscalls/futex/futex_cmp_requeue01.c      |  2 +-
 .../kernel/syscalls/futex/futex_wait05.c      |  1 +
 .../kernel/syscalls/nanosleep/nanosleep01.c   |  1 +
 testcases/kernel/syscalls/poll/poll02.c       |  1 +
 testcases/kernel/syscalls/prctl/prctl09.c     |  1 +
 testcases/kernel/syscalls/pselect/pselect01.c |  1 +
 testcases/kernel/syscalls/select/select02.c   |  1 +
 17 files changed, 79 insertions(+), 20 deletions(-)
 create mode 100644 lib/newlib_tests/test_max_runtime03.c

diff --git a/include/tst_test.h b/include/tst_test.h
index a9746b440..3348eda96 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -309,8 +309,14 @@ const char *tst_strstatus(int status);
  */
 unsigned int tst_remaining_runtime(void);
 
+/*
+ * Sets the test runtime dymamically, this is supposed to be used from a test
+ * setup() in cases where the test runtime depends on parameters passed to the
+ * test.
+ */
+void tst_set_runtime(unsigned int runtime);
+
 unsigned int tst_multiply_timeout(unsigned int timeout);
-void tst_set_timeout(int timeout);
 
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
diff --git a/include/tst_timer_test.h b/include/tst_timer_test.h
index b825a4d1a..2a863391a 100644
--- a/include/tst_timer_test.h
+++ b/include/tst_timer_test.h
@@ -39,6 +39,9 @@
 
 void tst_timer_sample(void);
 
+/* This is a bit more than the sum of all the iterations the test does */
+#define TST_TIMER_TEST_MAX_RUNTIME 10
+
 # ifdef TST_NO_DEFAULT_MAIN
 struct tst_test *tst_timer_test_setup(struct tst_test *test);
 # endif /* TST_NO_DEFAULT_MAIN */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 403076ba5..1a33d8967 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -48,3 +48,4 @@ tst_fuzzy_sync03
 test_zero_hugepage
 test_max_runtime01
 test_max_runtime02
+test_max_runtime03
diff --git a/lib/newlib_tests/test_max_runtime03.c b/lib/newlib_tests/test_max_runtime03.c
new file mode 100644
index 000000000..5d1c1099c
--- /dev/null
+++ b/lib/newlib_tests/test_max_runtime03.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021, Linux Test Project
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+#define MAX_RUNTIME 3
+
+static void run(void)
+{
+	unsigned int ms = 0;
+
+	do {
+		usleep(10000);
+		ms++;
+	} while (tst_remaining_runtime());
+
+	if (ms > MAX_RUNTIME * 100)
+		tst_res(TFAIL, "Slept for longer than 1s %u", tst_remaining_runtime());
+	else
+		tst_res(TPASS, "Timeout remaining: %d, Slept for %ums", tst_remaining_runtime(), 10 * ms);
+}
+
+static void setup(void)
+{
+	tst_set_runtime(MAX_RUNTIME);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 23f55b306..9a1c23dce 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -62,6 +62,7 @@ struct results {
 	int warnings;
 	int broken;
 	unsigned int timeout;
+	unsigned int max_runtime;
 };
 
 static struct results *results;
@@ -975,8 +976,6 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->max_runtime) {
 		if (tst_test->timeout)
 			tst_brk(TBROK, "Only one of timeout and max_iter_runtime can be set!");
-
-		tst_test->timeout = tst_test->max_runtime + MAX(10u, tst_test->max_runtime);
 	}
 
 	if (tst_test->needs_root && geteuid() != 0)
@@ -1326,8 +1325,8 @@ unsigned int tst_remaining_runtime(void)
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
 	elapsed = tst_timespec_diff_ms(now, tst_start_time)/1000;
-	if (tst_test->max_runtime > elapsed)
-		return tst_test->max_runtime - elapsed;
+	if (results->max_runtime > elapsed)
+		return results->max_runtime - elapsed;
 
 	return 0;
 }
@@ -1358,16 +1357,13 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	return timeout * timeout_mul;
 }
 
-static void set_timeout(int timeout)
+static int runtime_to_timeout(unsigned int runtime)
 {
-	if (timeout == -1) {
-		tst_res(TINFO, "Timeout per run is disabled");
-		return;
-	}
-
-	if (timeout < 1)
-		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
+	return runtime + MAX(10u, runtime);
+}
 
+static void set_timeout(int timeout)
+{
 	results->timeout = tst_multiply_timeout(timeout);
 
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
@@ -1375,9 +1371,16 @@ static void set_timeout(int timeout)
 		results->timeout % 60);
 }
 
-void tst_set_timeout(int timeout)
+static void set_runtime(unsigned int max_runtime)
+{
+	tst_res(TINFO, "Test max runtime %us", max_runtime);
+	results->max_runtime = max_runtime;
+	set_timeout(runtime_to_timeout(max_runtime));
+}
+
+void tst_set_runtime(unsigned int max_runtime)
 {
-	set_timeout(timeout);
+	set_runtime(max_runtime);
 	heartbeat();
 }
 
@@ -1475,7 +1478,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-	if (tst_test->timeout)
+	if (tst_test->max_runtime)
+		set_runtime(tst_test->max_runtime);
+	else if (tst_test->timeout)
 		set_timeout(tst_test->timeout);
 	else
 		set_timeout(300);
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 3cd52fc9d..19de1ff97 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -441,9 +441,9 @@ static void parse_timer_opts(void)
 		if (!sample_cnt)
 			sample_cnt = 500;
 
-		long long timeout = sleep_time * sample_cnt / 1000000;
+		long long runtime = sleep_time * sample_cnt / 1000000;
 
-		tst_set_timeout(timeout + timeout/10);
+		tst_set_runtime(runtime);
 
 		test->test_all = single_timer_test;
 		test->test = NULL;
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
index feb3e4791..656555652 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -32,5 +32,6 @@ int sample_fn(int clk_id, long long usec)
 
 static struct tst_test test = {
 	.scall = "clock_nanosleep()",
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
index 2ad1a6abc..19a5ea664 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -70,5 +70,6 @@ static struct tst_test test = {
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 	.test_variants = TEST_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index d2c0b6ef4..5e9986905 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -69,5 +69,6 @@ static struct tst_test test = {
 	.scall = "epoll_wait()",
 	.sample = sample_fn,
 	.setup = setup,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
index dc62e9202..623c044d2 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -13,7 +13,7 @@
 #include <sys/epoll.h>
 
 #include "tst_test.h"
-#include "tst_timer_test.h"
+#include "tst_timer.h"
 
 #define USEC_PRECISION 1000	/* Error margin allowed in usec */
 
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index 13e67c758..03cc544ab 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -15,7 +15,7 @@
 #include <linux/futex.h>
 #include <sys/time.h>
 
-#include "tst_timer_test.h"
+#include "tst_timer.h"
 #include "tst_test.h"
 #include "futextest.h"
 
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index 8fad5d858..f7d66133c 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -41,4 +41,5 @@ int sample_fn(int clk_id, long long usec)
 static struct tst_test test = {
 	.scall = "futex_wait()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index eaacb89fa..9dec2276e 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -35,4 +35,5 @@ int sample_fn(int clk_id, long long usec)
 static struct tst_test test = {
 	.scall = "nanosleep()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
index c0665927b..7e2ae91f4 100644
--- a/testcases/kernel/syscalls/poll/poll02.c
+++ b/testcases/kernel/syscalls/poll/poll02.c
@@ -55,4 +55,5 @@ static struct tst_test test = {
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/prctl/prctl09.c b/testcases/kernel/syscalls/prctl/prctl09.c
index 07ce57063..be5583f98 100644
--- a/testcases/kernel/syscalls/prctl/prctl09.c
+++ b/testcases/kernel/syscalls/prctl/prctl09.c
@@ -44,4 +44,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.scall = "prctl()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 5b2b8b3ba..5c97c386c 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -34,4 +34,5 @@ int sample_fn(int clk_id, long long usec)
 static struct tst_test test = {
 	.scall = "pselect()",
 	.sample = sample_fn,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 };
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 784ec9211..f3f2b0e9d 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -62,4 +62,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_variants = TEST_VARIANTS,
 	.cleanup = cleanup,
+	.max_runtime = TST_TIMER_TEST_MAX_RUNTIME,
 };
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
