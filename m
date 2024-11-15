Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB06D68BCE
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 16:41:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 774843D7822
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 17:41:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8AA53D76A8
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 17:40:59 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B31B630063
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 17:40:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEC211F37E
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731688857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SEWUR2WJwpN0DK/Dxu7Ez7Mfywggl6sZs2GrBoiK7SQ=;
 b=y+VJ1+smwpJdf6EeXUlkOipJ6CD/XuyFIIoOXqXEWXdGC8HwPZNBI7oZtZIwhRKokOCh2L
 xwtUAjYXlNahnI8q1Abf9/rLRU713/SYkbeZXE67jIJV0WF5sEymqmh3c6ubvQnAAeZOzN
 VNQliLPGvT3LU2HtaRt09HA1RU24yUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731688857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SEWUR2WJwpN0DK/Dxu7Ez7Mfywggl6sZs2GrBoiK7SQ=;
 b=AK3xiDaq9y/OQFqtw5j5jVb4RE7fJ1e+fbExmvMwrB/AVUbbAzcFm53nxx/nUd71oSkzYa
 pBoR6j+m9XwACdAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eUm7YptI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4oXXtHLz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731688856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SEWUR2WJwpN0DK/Dxu7Ez7Mfywggl6sZs2GrBoiK7SQ=;
 b=eUm7YptIeQsJA4bmNLDtUiQcaZA2qE7PSPPKou4186vrPWuKrMvW1IPYeABQ0CgYEc9bdj
 iwaeblvhTxK7bOaQhg3LtuwQXvbM9QAItnHQwlQ3VxzfGuQxevQI1JAxJePeZaPjX48Uni
 Q0kPIX/r8263fl8dGFiRL5F/8UkWrxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731688856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SEWUR2WJwpN0DK/Dxu7Ez7Mfywggl6sZs2GrBoiK7SQ=;
 b=4oXXtHLzX8L3Z1SgxFecjIGOvs67jeFuG6rfUSmVmiGuL3WUKj7tYeFxxYGJuucJ9D2Oke
 VwqqzMTkNPvRStDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B913D13485
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:40:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ygp6K5h5N2cRUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:40:56 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 17:41:01 +0100
Message-ID: <20241115164101.17983-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: CEC211F37E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [RFC] lib/tst_test.c: Fix tst_brk() handling
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

This makes the tst_brk() handling cleaner and saner as instead of
propagating the tst_brk() result in a return value an abort flag is
introduced into the shared memory.

Now:

- All the processes but the library one that reports the results exit
  with 0
- tst_brk(TBROK, ...) increments result conters, sets the abort flag.
  and exit current process
- all other tst_brk() variants will just increments the countes and
  exits the current process

This makes the tst_brk() behavior well defined so we can now even call
tst_brk() with TFAIL and TPASS as well.

Open question (may be done in a separatep patch):

Should tst_brk(TBROK, ...) apart from setting the flag also send sigkill
signal to the test process group to kill any leftover test processes?

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h          | 24 +++++++-------
 lib/newlib_tests/.gitignore |  6 +++-
 lib/newlib_tests/test23.c   | 25 ++++++++++++++
 lib/newlib_tests/test24.c   | 25 ++++++++++++++
 lib/newlib_tests/test25.c   | 19 +++++++++++
 lib/newlib_tests/test26.c   | 20 +++++++++++
 lib/tst_test.c              | 66 +++++++++++++++++++++----------------
 7 files changed, 144 insertions(+), 41 deletions(-)
 create mode 100644 lib/newlib_tests/test23.c
 create mode 100644 lib/newlib_tests/test24.c
 create mode 100644 lib/newlib_tests/test25.c
 create mode 100644 lib/newlib_tests/test26.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 8d1819f74..7ad91e9fa 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -98,28 +98,30 @@ void tst_brk_(const char *file, const int lineno, int ttype,
               __attribute__ ((format (printf, 4, 5)));
 
 /**
- * tst_brk() - Reports a breakage and exits the test.
+ * tst_brk() - Reports a breakage and exits the test or test process.
  *
  * @ttype: An enum tst_res_type.
  * @arg_fmt: A printf-like format.
  * @...: A printf-like parameters.
  *
- * Reports either TBROK or TCONF and exits the test immediately. When called
- * all children in the same process group as the main test library process are
- * killed. This function, unless in a test cleanup, calls _exit() and does not
- * return.
+ * Reports a single result and exits immediately. The call behaves differently
+ * based on the ttype parameter. For all ttype results but TBROK the call exits
+ * the current test process, i.e. increments test result counters and calls
+ * exit(0).
+ *
+ * The TBROK ttype is special that apart from exitting the current test process
+ * it also tells to the test library to exit immediatelly. This means that any
+ * subsequent test iterations are not executed, e.g. if tests runs for all
+ * filesystems but tst_brk() with TBROK is called, the test exits and does not
+ * attempt to continue a test iteration for the next filtesystem.
  *
  * When test is in cleanup() function TBROK is converted into TWARN by the test
  * library and we attempt to carry on with a cleanup even when tst_brk() was
  * called. This makes it possible to use SAFE_FOO() macros in the test cleanup
  * without interrupting the cleanup process on a failure.
  */
-#define tst_brk(ttype, arg_fmt, ...)						\
-	({									\
-		TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(!((ttype) &			\
-			(TBROK | TCONF | TFAIL)));				\
-		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
-	})
+#define tst_brk(ttype, arg_fmt, ...) \
+		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
 
 void tst_printf(const char *const fmt, ...)
 		__attribute__((nonnull(1), format (printf, 1, 2)));
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6d125f933..b3b662d51 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -23,6 +23,10 @@ tst_print_result
 test19
 test20
 test22
+test23
+test24
+test25
+test26
 tst_expiration_timer
 test_assert
 test_timer
@@ -58,4 +62,4 @@ test_runtime01
 test_runtime02
 test_children_cleanup
 tst_res_flags
-tst_safe_sscanf
\ No newline at end of file
+tst_safe_sscanf
diff --git a/lib/newlib_tests/test23.c b/lib/newlib_tests/test23.c
new file mode 100644
index 000000000..f3ec29793
--- /dev/null
+++ b/lib/newlib_tests/test23.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TFAIL, ...) works properly.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int pid = SAFE_FORK();
+
+	if (pid)
+		return;
+
+	tst_brk(TFAIL, "Test child exitting...");
+	tst_res(TWARN, "Test child stil alive!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
diff --git a/lib/newlib_tests/test24.c b/lib/newlib_tests/test24.c
new file mode 100644
index 000000000..423383cfd
--- /dev/null
+++ b/lib/newlib_tests/test24.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TPASS, ...) works properly.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int pid = SAFE_FORK();
+
+	if (pid)
+		return;
+
+	tst_brk(TPASS, "Test child exitting...");
+	tst_res(TWARN, "Test child stil alive!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
diff --git a/lib/newlib_tests/test25.c b/lib/newlib_tests/test25.c
new file mode 100644
index 000000000..0795ca7d0
--- /dev/null
+++ b/lib/newlib_tests/test25.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TBROK, ...) exits the test immediatelly.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_brk(TBROK, "Exitting the test during the first variant");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.test_variants = 10,
+};
diff --git a/lib/newlib_tests/test26.c b/lib/newlib_tests/test26.c
new file mode 100644
index 000000000..27829c703
--- /dev/null
+++ b/lib/newlib_tests/test26.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TFAIL, ...) exits only single test variant.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_brk(TFAIL, "Failing a test variant");
+	tst_res(TWARN, "Shouldn't be reached");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.test_variants = 10,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8db554dea..9dd00718a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -71,6 +71,13 @@ struct results {
 	int failed;
 	int warnings;
 	int broken;
+
+	/*
+	 * This is set by a call to tst_brk() with TBROK parameter and means
+	 * that the test should exit immediatelly.
+	 */
+	int abort_flag;
+
 	unsigned int timeout;
 	int max_runtime;
 };
@@ -395,7 +402,16 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	if (getpid() == lib_pid)
 		do_exit(TTYPE_RESULT(ttype));
 
-	exit(TTYPE_RESULT(ttype));
+	/*
+	 * If we get here we are in a child process, either the main child
+	 * running the test or its children. If any of them called tst_brk()
+	 * with TBROK we need to exit the test. Otherwise we just exit the
+	 * current process.
+	 */
+	if (TTYPE_RESULT(ttype) == TBROK)
+		tst_atomic_inc(&results->abort_flag);
+
+	exit(0);
 }
 
 void tst_res_(const char *file, const int lineno, int ttype,
@@ -432,8 +448,6 @@ void tst_printf(const char *const fmt, ...)
 
 static void check_child_status(pid_t pid, int status)
 {
-	int ret;
-
 	if (WIFSIGNALED(status)) {
 		tst_brk(TBROK, "Child (%i) killed by signal %s", pid,
 			tst_strsig(WTERMSIG(status)));
@@ -442,15 +456,8 @@ static void check_child_status(pid_t pid, int status)
 	if (!(WIFEXITED(status)))
 		tst_brk(TBROK, "Child (%i) exited abnormally", pid);
 
-	ret = WEXITSTATUS(status);
-	switch (ret) {
-	case TPASS:
-	case TBROK:
-	case TCONF:
-	break;
-	default:
-		tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, ret);
-	}
+	if (WEXITSTATUS(status))
+		tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, WEXITSTATUS(status));
 }
 
 void tst_reap_children(void)
@@ -915,6 +922,14 @@ static void print_failure_hints(void)
 	show_failure_hints = 0;
 }
 
+/*
+ * Prints results, cleans up after the test library and exits the test library
+ * process. The ret parameter is used to pass the result flags in a case of a
+ * failure before we managed to set up the shared memory where we store the
+ * results. This allows us to use SAFE_MACROS() in the initialization of the
+ * shared memory. The ret parameter is not used (passed 0) when called
+ * explicitly from the rest of the library.
+ */
 static void do_exit(int ret)
 {
 	if (results) {
@@ -1555,6 +1570,7 @@ static void run_tests(void)
 
 		if (results_equal(&saved_results, results))
 			tst_brk(TBROK, "Test haven't reported results!");
+
 		return;
 	}
 
@@ -1775,7 +1791,7 @@ static int fork_testrun(void)
 		tst_res(TINFO, "Killed the leftover descendant processes");
 
 	if (WIFEXITED(status) && WEXITSTATUS(status))
-		return WEXITSTATUS(status);
+		tst_brk(TBROK, "Child returned with %i", WEXITSTATUS(status));
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(TINFO, "If you are running on slow machine, "
@@ -1856,15 +1872,10 @@ static int run_tcases_per_fs(void)
 		if (!fs)
 			continue;
 
-		ret = run_tcase_on_fs(fs, filesystems[i]);
+		run_tcase_on_fs(fs, filesystems[i]);
 
-		if (ret == TCONF)
-			continue;
-
-		if (ret == 0)
-			continue;
-
-		do_exit(ret);
+		if (tst_atomic_load(&results->abort_flag))
+			do_exit(0);
 	}
 
 	return ret;
@@ -1874,7 +1885,6 @@ unsigned int tst_variant;
 
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
-	int ret = 0;
 	unsigned int test_variants = 1;
 	struct utsname uval;
 
@@ -1903,19 +1913,17 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
 		if (tst_test->all_filesystems || count_fs_descs() > 1)
-			ret |= run_tcases_per_fs();
+			run_tcases_per_fs();
 		else
-			ret |= fork_testrun();
+			fork_testrun();
 
-		if (ret & ~(TCONF))
-			goto exit;
+		if (tst_atomic_load(&results->abort_flag))
+			do_exit(0);
 	}
 
-exit:
-	do_exit(ret);
+	do_exit(0);
 }
 
-
 void tst_flush(void)
 {
 	int rval;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
