Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB564C36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 14:34:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FCB83CB323
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 16:34:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AB203C189E
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 16:34:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54187600A4A
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 16:34:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D472C1F385
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743777245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=o5Rb8F/CY0StHoj1fTkHj5xXYZjYLmdPOT5OOitiY7M=;
 b=3B5fdkbjLSN5CyhsDsM0DqaSL0ZKMxjLZ+uFlcfCOtoujSzs6W/HwLMTzZW9mfllZhAuy7
 6yBUDMMy762975hyG4jJosd3PbumlT6gHefvBHRAjJtoWoQRUr0Nroq+ygrC/Ri47litZD
 3TURyiKjvivbcHNgxVRY6Ku+XsSw1Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743777245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=o5Rb8F/CY0StHoj1fTkHj5xXYZjYLmdPOT5OOitiY7M=;
 b=8brkznggZ31nCGekfplDxmIhJqWhRPAkv1Lq9fAxrjOxhHDJzoJlmSVGV/kcXapuijcXZG
 b66IZCP2zT8i6UCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743777244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=o5Rb8F/CY0StHoj1fTkHj5xXYZjYLmdPOT5OOitiY7M=;
 b=AM2a+rRXa8LR/u2Y9AzR+ploSIsoFNrkpnxI3S+VJkVjDrGae9eOdnn1EbuNy06ntu7Hzl
 0kQTwNSBtkqkxFdwG0r/ULy49T6QJTi2EGZUDVOuXUFhsslk7O97CFVNYJQ37pcyJpN9/f
 m6DMdSY7+bvnWe90wOLoblMJabIxCbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743777244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=o5Rb8F/CY0StHoj1fTkHj5xXYZjYLmdPOT5OOitiY7M=;
 b=rNJCRGQ9gsjk9e3HgBXIxkTuV0EDmFTokCfkiLMqraI1Fn4uedtH/bb2JQE2Eq0C9/2KyK
 Kc8anr9DkEmJa6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB26E1364F
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 14:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGmELNzt72eJcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 04 Apr 2025 14:34:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Apr 2025 16:34:23 +0200
Message-ID: <20250404143423.16268-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib/tst_test.c: Fix tst_brk() handling
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

- tst_brk(TBROK, ...) increments result conters, sets the abort flag,
  exit current process and makes sure all process group processes are
  terminated

- all other tst_brk() variants will just increments the counters and
  exits the current process (which is current iteration for
  .all_filesysstems, .test_variants, etc.)

This makes the tst_brk() behavior well defined so we can now even call
tst_brk() with TFAIL and TPASS as well. And since TBROK is supposed to
exit the test immediately (i.e.  unrecoverable error) we are now
properly doing so.

The case that main test pid called TBROK was working correctly before
this patch, since send the SIGKILL signal to the process group after we
waited for the main test pid. All that was missing is a code that sends
a signal to the main test pid in the case that TBROK was triggered by
one of it's children and now we properly kill all test processes in that
case as well.

There is also special case where we call tst_brk() before the test
library has been initialized (mostly done by the C shell helpers) in
that case we have to exit with a proper return value, which is normally
done by the test library process.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
v2:
 - Fix cases where tst_brk() was called before library was initialize
   (fixes tst_run_shell segfaults)
 - Fixes typos reported by Peter
 - Renames tests to have descriptive file names
 - Fix C-Test-API paragraphs that describe tst_brk() to match new
   implementation

 doc/old/C-Test-API.asciidoc          | 24 +++----
 include/tst_test.h                   | 26 ++++----
 lib/newlib_tests/.gitignore          |  8 ++-
 lib/newlib_tests/test_brk_child.c    | 31 ++++++++++
 lib/newlib_tests/test_brk_fail.c     | 25 ++++++++
 lib/newlib_tests/test_brk_parent.c   | 28 +++++++++
 lib/newlib_tests/test_brk_pass.c     | 25 ++++++++
 lib/newlib_tests/test_brk_variant.c  | 19 ++++++
 lib/newlib_tests/test_fail_variant.c | 20 ++++++
 lib/tst_test.c                       | 93 +++++++++++++++++++---------
 10 files changed, 245 insertions(+), 54 deletions(-)
 create mode 100644 lib/newlib_tests/test_brk_child.c
 create mode 100644 lib/newlib_tests/test_brk_fail.c
 create mode 100644 lib/newlib_tests/test_brk_parent.c
 create mode 100644 lib/newlib_tests/test_brk_pass.c
 create mode 100644 lib/newlib_tests/test_brk_variant.c
 create mode 100644 lib/newlib_tests/test_fail_variant.c

diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 3fe9cd1d9..7212f4e75 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -245,13 +245,13 @@ The 'ttype' can be combined bitwise with 'TERRNO' or 'TTERRNO' to print
 void tst_brk(int ttype, char *arg_fmt, ...);
 -------------------------------------------------------------------------------
 
-Printf-like function to report error and exit the test, it can be used with ttype:
+Printf-like function to report result and exits current test. If test uses
+'.all_filesystems', '.test_variants' etc. the 'tst_brk()' exits current test
+iteration e.g. currently running filesystem test or a test variant unless
+'ttype' is set to 'TBROK'.
 
-|============================================================
-| 'TBROK' | Something has failed in test preparation phase.
-| 'TCONF' | Test is not appropriate for current configuration
-            (syscall not implemented, unsupported arch, ...)
-|============================================================
+If 'ttype' is set to 'TBROK' all test processes are killed and the test exits
+immediatelly with an error.
 
 The 'ttype' can be combined bitwise with 'TERRNO' or 'TTERRNO' to print
 'errno', 'TST_ERR' respectively.
@@ -647,15 +647,15 @@ IMPORTANT: You have to set the '.forks_child' flag in the test structure
 Results reported by 'tst_res()' are propagated to the parent test process via
 block of shared memory.
 
-Calling 'tst_brk()' causes child process to exit with non-zero exit value.
-Which means that it's safe to use 'SAFE_*()' macros in the child processes as
-well.
+Calling 'tst_brk()' causes child process to set the test library abort flag and
+exits the test immediately. Which means that it's safe to use 'SAFE_*()' macros
+in the child processes as well.
 
 Children that outlive the 'test()' function execution are waited for in the
 test library. Unclean child exit (killed by signal, non-zero exit value, etc.)
-will cause the main test process to exit with 'tst_brk()', which especially
-means that 'TBROK' propagated from a child process will cause the whole test
-to exit with 'TBROK'.
+will cause the main test process to exit with 'tst_brk()'. That means that all
+test child processes are supposed to exit with success unless they are
+explicitly waited for.
 
 If a test needs a child that segfaults or does anything else that cause it to
 exit uncleanly all you need to do is to wait for such children from the
diff --git a/include/tst_test.h b/include/tst_test.h
index eb73cd593..d71474e2a 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -98,28 +98,32 @@ void tst_brk_(const char *file, const int lineno, int ttype,
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
+ * The TBROK ttype is special that apart from exiting the current test process
+ * it also tells to the test library to exit immediately. When TBROK is
+ * triggered by any of the test processes the whole process group is killed so
+ * that there are no processes left after the library process exits. This also
+ * means that any subsequent test iterations are not executed, e.g. if a test
+ * runs for all filesystems and tst_brk() with TBROK is called, the test exits
+ * and does not attempt to continue a test iteration for the next filesystem.
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
index 6d125f933..8acaec0b6 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -58,4 +58,10 @@ test_runtime01
 test_runtime02
 test_children_cleanup
 tst_res_flags
-tst_safe_sscanf
\ No newline at end of file
+tst_safe_sscanf
+test_brk_child
+test_brk_fail
+test_brk_parent
+test_brk_pass
+test_brk_variant
+test_fail_variant
diff --git a/lib/newlib_tests/test_brk_child.c b/lib/newlib_tests/test_brk_child.c
new file mode 100644
index 000000000..68c50ed1e
--- /dev/null
+++ b/lib/newlib_tests/test_brk_child.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TFAIL, ...) exits only single test variant.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		if (!SAFE_FORK()) {
+			tst_res(TINFO, "Suspending child %i", i);
+			pause();
+		}
+	}
+
+	if (!SAFE_FORK())
+		tst_brk(TBROK, "Child triggers TBROK");
+
+	pause();
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
diff --git a/lib/newlib_tests/test_brk_fail.c b/lib/newlib_tests/test_brk_fail.c
new file mode 100644
index 000000000..ee1e554a6
--- /dev/null
+++ b/lib/newlib_tests/test_brk_fail.c
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
+	tst_brk(TFAIL, "Test child exiting...");
+	tst_res(TWARN, "Test child stil alive!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
diff --git a/lib/newlib_tests/test_brk_parent.c b/lib/newlib_tests/test_brk_parent.c
new file mode 100644
index 000000000..974e77829
--- /dev/null
+++ b/lib/newlib_tests/test_brk_parent.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TFAIL, ...) exits only single test variant.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		if (!SAFE_FORK()) {
+			tst_res(TINFO, "Suspending child %i", i);
+			pause();
+		}
+	}
+
+	tst_brk(TBROK, "Parent triggers TBROK");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
diff --git a/lib/newlib_tests/test_brk_pass.c b/lib/newlib_tests/test_brk_pass.c
new file mode 100644
index 000000000..135270780
--- /dev/null
+++ b/lib/newlib_tests/test_brk_pass.c
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
+	tst_brk(TPASS, "Test child exiting...");
+	tst_res(TWARN, "Test child stil alive!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
diff --git a/lib/newlib_tests/test_brk_variant.c b/lib/newlib_tests/test_brk_variant.c
new file mode 100644
index 000000000..6f91a72aa
--- /dev/null
+++ b/lib/newlib_tests/test_brk_variant.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that tst_brk(TBROK, ...) exits the test immediately.
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
diff --git a/lib/newlib_tests/test_fail_variant.c b/lib/newlib_tests/test_fail_variant.c
new file mode 100644
index 000000000..27829c703
--- /dev/null
+++ b/lib/newlib_tests/test_fail_variant.c
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
index 9a23cd4a0..8210912f6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2015-2025 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) Linux Test Project, 2016-2024
  */
 
@@ -71,6 +71,11 @@ struct results {
 	int failed;
 	int warnings;
 	int broken;
+	/*
+	 * This is set by a call to tst_brk() with TBROK parameter and means
+	 * that the test should exit immediately.
+	 */
+	int abort_flag;
 	unsigned int runtime;
 	unsigned int overall_time;
 };
@@ -381,6 +386,14 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	       va_list va)
 {
 	print_result(file, lineno, ttype, fmt, va);
+
+	/*
+	 * If tst_brk() is called from some of the C helpers even before the
+	 * library was initialized, just exit.
+	 */
+	if (!lib_pid)
+		exit(TTYPE_RESULT(ttype));
+
 	update_results(TTYPE_RESULT(ttype));
 
 	/*
@@ -392,10 +405,34 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	if (tst_getpid() == main_pid)
 		do_test_cleanup();
 
+	/*
+	 * The test library process reports result statistics and exits.
+	 */
 	if (getpid() == lib_pid)
 		do_exit(TTYPE_RESULT(ttype));
 
-	exit(TTYPE_RESULT(ttype));
+	/*
+	 * If we get here we are in a child process, either the main child
+	 * running the test or its children. If any of them called tst_brk()
+	 * with TBROK we need to exit the test. Otherwise we just exit the
+	 * current process.
+	 */
+	if (TTYPE_RESULT(ttype) == TBROK) {
+		if (results)
+			tst_atomic_inc(&results->abort_flag);
+
+		/*
+		 * If TBROK was called from one of the child processes we kill
+		 * the main test process. That in turn triggers the code that
+		 * kills leftover children once the main test process did exit.
+		 */
+		if (main_pid && tst_getpid() != main_pid) {
+			tst_res(TINFO, "Child process reported TBROK killing the test");
+			kill(main_pid, SIGKILL);
+		}
+	}
+
+	exit(0);
 }
 
 void tst_res_(const char *file, const int lineno, int ttype,
@@ -432,8 +469,6 @@ void tst_printf(const char *const fmt, ...)
 
 static void check_child_status(pid_t pid, int status)
 {
-	int ret;
-
 	if (WIFSIGNALED(status)) {
 		tst_brk(TBROK, "Child (%i) killed by signal %s", pid,
 			tst_strsig(WTERMSIG(status)));
@@ -442,15 +477,8 @@ static void check_child_status(pid_t pid, int status)
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
@@ -912,6 +940,14 @@ static void print_failure_hints(void)
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
@@ -1557,6 +1593,7 @@ static void run_tests(void)
 
 		if (results_equal(&saved_results, results))
 			tst_brk(TBROK, "Test haven't reported results!");
+
 		return;
 	}
 
@@ -1651,6 +1688,7 @@ static volatile sig_atomic_t sigkill_retries;
 static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	WRITE_MSG("Test timeouted, sending SIGKILL!\n");
+
 	kill(-test_pid, SIGKILL);
 	alarm(5);
 
@@ -1785,7 +1823,10 @@ static int fork_testrun(void)
 		tst_res(TINFO, "Killed the leftover descendant processes");
 
 	if (WIFEXITED(status) && WEXITSTATUS(status))
-		return WEXITSTATUS(status);
+		tst_brk(TBROK, "Child returned with %i", WEXITSTATUS(status));
+
+	if (results->abort_flag)
+		return 0;
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(TINFO, "If you are running on slow machine, "
@@ -1868,15 +1909,10 @@ static int run_tcases_per_fs(void)
 			continue;
 
 		found_valid_fs = true;
-		ret = run_tcase_on_fs(fs, filesystems[i]);
-
-		if (ret == TCONF)
-			continue;
+		run_tcase_on_fs(fs, filesystems[i]);
 
-		if (ret == 0)
-			continue;
-
-		do_exit(ret);
+		if (tst_atomic_load(&results->abort_flag))
+			do_exit(0);
 	}
 
 	if (!found_valid_fs)
@@ -1889,7 +1925,6 @@ unsigned int tst_variant;
 
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
-	int ret = 0;
 	unsigned int test_variants = 1;
 	struct utsname uval;
 
@@ -1918,19 +1953,17 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
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
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
