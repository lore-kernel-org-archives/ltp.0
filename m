Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AEDC433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:45:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07B293CA9C0
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:45:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44FE73CA949
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 418E91000956
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 940FB210DF;
 Tue,  3 May 2022 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdgPWAJfDF/QtgOnATG3fCC4alxh84gIbhHgchuSV7o=;
 b=foXmH/9+/WT69MbJGxelB9w3aLH6tkuuhK52sEtymt7DCh9ztU+xLiuaBHk2ix1Dm2qZLF
 igGqzm8A+uIXk6OTuni9tQFoKV9iwStnQpHe8LTxJ4oh6HHyfUSNkhWbv4s0I8oulmAkKM
 JLJky1giTZemOdCkw7ou0+1b7IYlTTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdgPWAJfDF/QtgOnATG3fCC4alxh84gIbhHgchuSV7o=;
 b=2B26dBCFVI7yUazIj0hsaGPLVv6GkMLL06PwpwOO0Q5an08Op80eVQb0LZ6lr3IrGGRb1U
 CoRftRWp9E2g/2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7821713ABE;
 Tue,  3 May 2022 17:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wGLYGxxqcWLPPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:49 +0200
Message-Id: <20220503174718.21205-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/30] Introduce a concept of max runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit introduce a concept of per iteration max test runtime. In
other words test runtime is capped at a certain value in order to make
testruns more deterministic. Test is free to to finish before the
runtime is used up, for example when maximal number of iterations
was reached, but test must stop once the runtime has been used up.

Testcases that run for more than a second or two must check for
remaining runtime by regular calls to tst_remaining_runtime() and should
exit when zero is returned.

The test max runtime must be set either by the .max_iteration_runtime in
the tst_test structure or in the test setup by a call to
tst_set_runtime().

The test timeout is then computed as a sum of DEFAULT_TIMEOUT (currently
set to 30 seconds) and the test runtime. The DEFAULT_TIMEOUT is nothing
more than a safety margin for teardown of the test.

This commit also maps the -I parameter to the test max runtime if
available and introduces LTP_RUNTIME_MUL enviroment variable so that we
have an easy controll over the runtime cap.

Lastly but not least the function related to the timeout are turned into
no-op by this commit and removed after all test are converted to the
runtime API.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/user-guide.txt                            |   4 +
 include/tst_test.h                            |  27 ++++
 lib/newlib_tests/.gitignore                   |   5 +-
 lib/newlib_tests/test10.c                     |  22 ---
 lib/newlib_tests/test12.c                     |  21 ---
 lib/newlib_tests/test13.c                     |   1 -
 lib/newlib_tests/test_children_cleanup.c      |   1 -
 .../{test18.c => test_runtime01.c}            |  10 +-
 lib/newlib_tests/test_runtime02.c             |  31 ++++
 lib/tst_test.c                                | 151 ++++++++++++++----
 10 files changed, 187 insertions(+), 86 deletions(-)
 delete mode 100644 lib/newlib_tests/test10.c
 delete mode 100644 lib/newlib_tests/test12.c
 rename lib/newlib_tests/{test18.c => test_runtime01.c} (58%)
 create mode 100644 lib/newlib_tests/test_runtime02.c

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index f41cbc733..d50d2e0cb 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -25,6 +25,10 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
                           Variable is also used in shell tests, but ceiled to int.
+| 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
+                          that run for more than a second or two are capped on
+			  runtime. You can scale the default runtime both up
+			  and down with this multiplier.
 | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
                           library. Setting it to empty string tell the library
                           that system is not a virtual machine. Other possible
diff --git a/include/tst_test.h b/include/tst_test.h
index dbe303bc8..c084ce4bc 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -134,6 +134,8 @@ extern unsigned int tst_variant;
 
 #define TST_NO_HUGEPAGES ((unsigned long)-1)
 
+#define TST_UNLIMITED_RUNTIME (-1)
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -236,6 +238,18 @@ struct tst_test {
 
 	/* override default timeout per test run, disabled == -1 */
 	int timeout;
+	/*
+	 * Maximal test runtime in seconds.
+	 *
+	 * Any test that runs for more than a second or two should set this and
+	 * also use tst_remaining_runtime() to exit when runtime was used up.
+	 * Tests may finish sooner, for example if requested number of
+	 * iterations was reached before the runtime runs out.
+	 *
+	 * If test runtime cannot be know in advance it should be set to
+	 * TST_UNLIMITED_RUNTIME.
+	 */
+	int max_iteration_runtime;
 
 	void (*setup)(void);
 	void (*cleanup)(void);
@@ -323,6 +337,19 @@ unsigned int tst_timeout_remaining(void);
 unsigned int tst_multiply_timeout(unsigned int timeout);
 void tst_set_timeout(int timeout);
 
+/*
+ * Returns remaining test runtime. Test that runs for more than a few seconds
+ * should check if they should exit by calling this function regularly.
+ *
+ * The function returns remaining runtime in seconds. If runtime was used up
+ * zero is returned.
+ */
+unsigned int tst_remaining_runtime(void);
+
+/*
+ * Sets runtime per iteration in seconds.
+ */
+void tst_set_runtime(int runtime_per_iteration);
 
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index f4414f6a1..59b57d063 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -7,9 +7,7 @@ test06
 test07
 test08
 test09
-test10
 test11
-test12
 test13
 test14
 test15
@@ -22,7 +20,6 @@ tst_safe_fileops
 tst_res_hexd
 tst_strstatus
 tst_print_result
-test18
 test19
 test20
 test22
@@ -56,3 +53,5 @@ tst_needs_cmds05
 tst_needs_cmds06
 tst_needs_cmds07
 tst_needs_cmds08
+test_runtime01
+test_runtime02
diff --git a/lib/newlib_tests/test10.c b/lib/newlib_tests/test10.c
deleted file mode 100644
index df61908ac..000000000
--- a/lib/newlib_tests/test10.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2016 Linux Test Project
- */
-
-/*
- * Test for watchdog timeout.
- */
-
-#include "tst_test.h"
-
-
-static void do_test(void)
-{
-	sleep(2);
-	tst_res(TPASS, "Not reached");
-}
-
-static struct tst_test test = {
-	.test_all = do_test,
-	.timeout = 1,
-};
diff --git a/lib/newlib_tests/test12.c b/lib/newlib_tests/test12.c
deleted file mode 100644
index b4f0d6303..000000000
--- a/lib/newlib_tests/test12.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2016 Linux Test Project
- */
-
-/*
- * Test for timeout override.
- */
-
-#include "tst_test.h"
-
-static void do_test(void)
-{
-	sleep(1);
-	tst_res(TPASS, "Passed!");
-}
-
-static struct tst_test test = {
-	.timeout = 2,
-	.test_all = do_test,
-};
diff --git a/lib/newlib_tests/test13.c b/lib/newlib_tests/test13.c
index c447dc3dc..83c48f734 100644
--- a/lib/newlib_tests/test13.c
+++ b/lib/newlib_tests/test13.c
@@ -20,7 +20,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.timeout = 1,
 	.forks_child = 1,
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/test_children_cleanup.c b/lib/newlib_tests/test_children_cleanup.c
index 2b1ca5f9c..4a1313f6d 100644
--- a/lib/newlib_tests/test_children_cleanup.c
+++ b/lib/newlib_tests/test_children_cleanup.c
@@ -39,5 +39,4 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
-	.timeout = 10,
 };
diff --git a/lib/newlib_tests/test18.c b/lib/newlib_tests/test_runtime01.c
similarity index 58%
rename from lib/newlib_tests/test18.c
rename to lib/newlib_tests/test_runtime01.c
index 026435d7d..79e4c7eac 100644
--- a/lib/newlib_tests/test18.c
+++ b/lib/newlib_tests/test_runtime01.c
@@ -9,14 +9,18 @@
 
 static void run(void)
 {
+	int runtime;
+
 	do {
+		runtime = tst_remaining_runtime();
+		tst_res(TINFO, "Remaining runtime %d", runtime);
 		sleep(1);
-	} while (tst_timeout_remaining() >= 4);
+	} while (runtime);
 
-	tst_res(TPASS, "Timeout remaining: %d", tst_timeout_remaining());
+	tst_res(TPASS, "Finished loop!");
 }
 
 static struct tst_test test = {
 	.test_all = run,
-	.timeout = 5
+	.max_iteration_runtime = 5
 };
diff --git a/lib/newlib_tests/test_runtime02.c b/lib/newlib_tests/test_runtime02.c
new file mode 100644
index 000000000..1329743f4
--- /dev/null
+++ b/lib/newlib_tests/test_runtime02.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021, Linux Test Project
+ */
+/*
+ * This test is set up so that the timeout is not long enough to guarantee
+ * enough runtime for two iterations, i.e. the timeout without offset and after
+ * scaling is too small and the tests ends up with TBROK.
+ *
+ * You can fix this by exporting LTP_MAX_TEST_RUNTIME=10 before executing the
+ * test, in that case the runtime would be divided between iterations and timeout
+ * adjusted so that it provides enough safeguards for the test to finish.
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	while (tst_remaining_runtime())
+		sleep(1);
+
+	tst_res(TPASS, "Timeout remaining: %d", tst_remaining_runtime());
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.max_iteration_runtime = 5,
+	.test_variants = 2
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8e258594a..096acef96 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -45,6 +45,8 @@ const char *TCID __attribute__((weak));
 #define GLIBC_GIT_URL "https://sourceware.org/git/?p=glibc.git;a=commit;h="
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
 
+#define DEFAULT_TIMEOUT 30
+
 struct tst_test *tst_test;
 
 static const char *tid;
@@ -63,6 +65,7 @@ struct results {
 	int warnings;
 	int broken;
 	unsigned int timeout;
+	int max_iteration_runtime;
 };
 
 static struct results *results;
@@ -464,6 +467,40 @@ pid_t safe_clone(const char *file, const int lineno,
 	return pid;
 }
 
+static void parse_mul(float *mul, const char *env_name, float min, float max)
+{
+	char *str_mul;
+	int ret;
+
+	if (*mul > 0)
+		return;
+
+	str_mul = getenv(env_name);
+
+	if (!str_mul) {
+		*mul = 1;
+		return;
+	}
+
+	ret = tst_parse_float(str_mul, mul, min, max);
+	if (ret) {
+		tst_brk(TBROK, "Failed to parse %s: %s",
+			env_name, tst_strerrno(ret));
+	}
+}
+
+static int multiply_runtime(void)
+{
+	static float runtime_mul = -1;
+
+	if (tst_test->max_iteration_runtime <= 0)
+		return tst_test->max_iteration_runtime;
+
+	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
+
+	return tst_test->max_iteration_runtime * runtime_mul;
+}
+
 static struct option {
 	char *optstr;
 	char *help;
@@ -477,6 +514,7 @@ static struct option {
 static void print_help(void)
 {
 	unsigned int i;
+	int timeout, runtime;
 
 	/* see doc/user-guide.txt, which lists also shell API variables */
 	fprintf(stderr, "Environment Variables\n");
@@ -489,10 +527,32 @@ static void print_help(void)
 	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
+	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
 	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
 	fprintf(stderr, "\n");
 
+	fprintf(stderr, "Timeout and runtime\n");
+	fprintf(stderr, "-------------------\n");
+
+	if (tst_test->max_iteration_runtime) {
+		runtime = multiply_runtime();
+
+		if (runtime == TST_UNLIMITED_RUNTIME) {
+			fprintf(stderr, "Test iteration runtime is not limited\n");
+		} else {
+			fprintf(stderr, "Test iteration runtime cap %ih %im %is\n",
+				runtime/3600, (runtime%3600)/60, runtime % 60);
+		}
+	}
+
+	timeout = tst_multiply_timeout(DEFAULT_TIMEOUT);
+
+	fprintf(stderr, "Test timeout (not including runtime) %ih %im %is\n",
+		timeout/3600, (timeout%3600)/60, timeout % 60);
+
+	fprintf(stderr, "\n");
+
 	fprintf(stderr, "Options\n");
 	fprintf(stderr, "-------\n");
 
@@ -620,7 +680,10 @@ static void parse_opts(int argc, char *argv[])
 			iterations = atoi(optarg);
 		break;
 		case 'I':
-			duration = atof(optarg);
+			if (tst_test->max_iteration_runtime > 0)
+				tst_test->max_iteration_runtime = atoi(optarg);
+			else
+				duration = atof(optarg);
 		break;
 		case 'C':
 #ifdef UCLINUX
@@ -1034,6 +1097,11 @@ static void do_setup(int argc, char *argv[])
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
+	if (tst_test->max_iteration_runtime < -1) {
+		tst_brk(TBROK, "Invalid runtime value %i",
+			results->max_iteration_runtime);
+	}
+
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
 
@@ -1404,39 +1472,36 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 unsigned int tst_timeout_remaining(void)
+{
+	tst_brk(TBROK, "Stub called!");
+	return 0;
+}
+
+unsigned int tst_remaining_runtime(void)
 {
 	static struct timespec now;
-	unsigned int elapsed;
+	int elapsed;
+
+	if (results->max_iteration_runtime == TST_UNLIMITED_RUNTIME)
+		return UINT_MAX;
+
+	if (results->max_iteration_runtime == 0)
+		tst_brk(TBROK, "Runtime not set!");
 
 	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
-	elapsed = (tst_timespec_diff_ms(now, tst_start_time) + 500) / 1000;
-	if (results->timeout > elapsed)
-		return results->timeout - elapsed;
+	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
+	if (results->max_iteration_runtime > elapsed)
+		return results->max_iteration_runtime - elapsed;
 
 	return 0;
 }
 
+
 unsigned int tst_multiply_timeout(unsigned int timeout)
 {
-	char *mul;
-	int ret;
-
-	if (timeout_mul == -1) {
-		mul = getenv("LTP_TIMEOUT_MUL");
-		if (mul) {
-			if ((ret = tst_parse_float(mul, &timeout_mul, 1, 10000))) {
-				tst_brk(TBROK, "Failed to parse LTP_TIMEOUT_MUL: %s",
-						tst_strerrno(ret));
-			}
-		} else {
-			timeout_mul = 1;
-		}
-	}
-	if (timeout_mul < 1)
-		tst_brk(TBROK, "LTP_TIMEOUT_MUL must to be int >= 1! (%.2f)",
-				timeout_mul);
+	parse_mul(&timeout_mul, "LTP_TIMEOUT_MUL", 0.099, 10000);
 
 	if (timeout < 1)
 		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
@@ -1446,37 +1511,48 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 
 void tst_set_timeout(int timeout)
 {
-	if (timeout == -1) {
+	tst_brk(TBROK, "Stub called!");
+}
+
+static void set_timeout(void)
+{
+	unsigned int timeout = DEFAULT_TIMEOUT;
+
+	if (results->max_iteration_runtime == TST_UNLIMITED_RUNTIME) {
 		tst_res(TINFO, "Timeout per run is disabled");
 		return;
 	}
 
-	if (timeout < 1)
-		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
+	if (results->max_iteration_runtime < 0) {
+		tst_brk(TBROK, "max_iteration_runtime must to be >= 0! (%d)",
+			results->max_iteration_runtime);
+	}
 
-	results->timeout = tst_multiply_timeout(timeout);
+	results->timeout = tst_multiply_timeout(timeout) + results->max_iteration_runtime;
 
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
 		results->timeout % 60);
+}
 
-	if (getpid() == lib_pid)
-		alarm(results->timeout);
-	else
-		heartbeat();
+void tst_set_runtime(int max_iteration_runtime)
+{
+	results->max_iteration_runtime = max_iteration_runtime;
+	tst_res(TINFO, "Updating max runtime to %uh %02um %02us",
+		max_iteration_runtime/3600, (max_iteration_runtime%3600)/60,
+		max_iteration_runtime % 60);
+	set_timeout();
+	heartbeat();
 }
 
 static int fork_testrun(void)
 {
 	int status;
 
-	if (tst_test->timeout)
-		tst_set_timeout(tst_test->timeout);
-	else
-		tst_set_timeout(300);
-
 	SAFE_SIGNAL(SIGINT, sigint_handler);
 
+	alarm(results->timeout);
+
 	test_pid = fork();
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
@@ -1568,6 +1644,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
+	if (tst_test->max_iteration_runtime)
+		results->max_iteration_runtime = tst_test->max_iteration_runtime;
+
+	set_timeout();
+
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
 
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
