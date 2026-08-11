Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67810C5B56A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 15:53:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80F6F3D0E80
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 17:53:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 133A43D0649
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7CC1B2001B0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8ABB81DC3;
 Tue, 11 Aug 2026 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPmR8cg9H3FanharZuLF6m2Lm8HvH4RXtEMiyrlu98Q=;
 b=wUlFZWTsy9eW/6BmVMKbvnbI1bBIoInYOwfpUSS0vysWcmYc+7hlybk0aQkXfXaUhrRBne
 lWyLuV+ny8KKH3cxfEaulZALvN2NXOIed8DF1mfbf5tcV37gphoK5HjDp/1+dVqo0n7Ea+
 lUAiFOmvpzvo5Z4007T7EI2H+CGLrTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPmR8cg9H3FanharZuLF6m2Lm8HvH4RXtEMiyrlu98Q=;
 b=jfDbArWGiQqPuHa2OEc4D2tlAe0Fabrj72kIM+MvEV4gDSD5hkOqAP06J9mOXRfSchpTCT
 2DifYTuDqaNiiABQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPmR8cg9H3FanharZuLF6m2Lm8HvH4RXtEMiyrlu98Q=;
 b=ieNbjCAlc//zlF9Bftw1Sh3XAf4alml+3Q5su4T7MlG9b4ucRnnykilb80iE2S8rIJVDPN
 dILOxlwuYsZw5Ivg0lAsHnGhpRR0Q4cYx9Je3O9hkpQym/kr86HtKJxZ2wVGY0Z1e9A3yO
 96WVFxsQfTE2P3+9xO3e8jsHa+TGm9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPmR8cg9H3FanharZuLF6m2Lm8HvH4RXtEMiyrlu98Q=;
 b=9ZrRq4PU79xYSZrLddavoKbUXg8jxLR3SFwDdUUZOIKiRB3yDo1u8Behr1+BrWI4lPaNBx
 t3n5R6O3XbZz99BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F1C1779C0;
 Tue, 11 Aug 2026 15:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qHaCCTFFe2rldAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 15:52:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 17:52:02 +0200
Message-ID: <20260811155202.1744316-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155202.1744316-1-pvorel@suse.cz>
References: <20260811155202.1744316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,fujitsu.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] test_macros*.c: Simplify with macros macros
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

Use similar macros as is used in test_macros02.c in other tests
to reduce duplicity (and slightly degrease readability).

Also
* Merge test_macros04.c into test_macros01.c
* Increase coverage by skipping msg parameter
* Test also TST_EXP_FD_OR_FAIL()

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/test_macros01.c | 57 +++++++++++++++++++------------
 lib/newlib_tests/test_macros03.c | 43 ++++++++++++-----------
 lib/newlib_tests/test_macros04.c | 58 --------------------------------
 lib/newlib_tests/test_macros06.c | 32 +++++++++++-------
 4 files changed, 76 insertions(+), 114 deletions(-)
 delete mode 100644 lib/newlib_tests/test_macros04.c

diff --git a/lib/newlib_tests/test_macros01.c b/lib/newlib_tests/test_macros01.c
index c04c943637..d6fdac7bd9 100644
--- a/lib/newlib_tests/test_macros01.c
+++ b/lib/newlib_tests/test_macros01.c
@@ -1,21 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ * Copyright (c) Linux Test Project, 2026
  */
 
 /*
- * Test TST_EXP_FD and TST_EXP_FD_SILENT macro.
+ * Test macros:
+ *
+ * - TST_EXP_PASS
+ * - TST_EXP_PASS_SILENT
+ * - TST_EXP_FD
+ * - TST_EXP_FD_SILENT
+ * - TST_EXP_PID
+ * - TST_EXP_PID_SILENT
  */
 
 #include "tst_test.h"
 
-static int fail_fd(void)
+static int fail_fn(void)
 {
 	errno = EINVAL;
 	return -1;
 }
 
-static int pass_fd(void)
+static int pass_fn(void)
 {
 	return 42;
 }
@@ -30,27 +39,31 @@ static int zero_val(void)
 	return 0;
 }
 
+#define TEST_MACRO(macro, fail_fn, pass_fn, inval_fn, zero_val_fn) \
+	do { \
+		tst_res(TINFO, "* Testing " #macro "() macro"); \
+		macro(fail_fn(), #fail_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(fail_fn()); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(pass_fn(), #pass_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(inval_fn(), #inval_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(zero_val_fn(), #zero_val_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+	} while (0)
+
 static void do_test(void)
 {
-	tst_res(TINFO, "Testing TST_EXP_FD macro");
-	TST_EXP_FD(fail_fd(), "fail_fd()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD(pass_fd(), "pass_fd()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD(inval_val(), "inval_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD(zero_val(), "zero_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-
-	tst_res(TINFO, "Testing TST_EXP_FD_SILENT macro");
-	TST_EXP_FD_SILENT(fail_fd(), "fail_fd()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD_SILENT(pass_fd(), "%s", "pass_fd()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_FD_SILENT(pass_fd, ...)", TST_PASS);
-	TST_EXP_FD_SILENT(inval_val(), "inval_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD_SILENT(zero_val(), "zero_val()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_FD_SILENT(zero_val, ...)", TST_PASS);
+	TEST_MACRO(TST_EXP_PASS, fail_fn, pass_fn, inval_val, zero_val);
+	TEST_MACRO(TST_EXP_PASS_SILENT, fail_fn, pass_fn, inval_val, zero_val);
+
+	TEST_MACRO(TST_EXP_FD, fail_fn, pass_fn, inval_val, zero_val);
+	TEST_MACRO(TST_EXP_FD_SILENT, fail_fn, pass_fn, inval_val, zero_val);
+
+	TEST_MACRO(TST_EXP_PID, fail_fn, pass_fn, inval_val, zero_val);
+	TEST_MACRO(TST_EXP_PID_SILENT, fail_fn, pass_fn, inval_val, zero_val);
 }
 
 static struct tst_test test = {
diff --git a/lib/newlib_tests/test_macros03.c b/lib/newlib_tests/test_macros03.c
index 2a281bafcd..536240620d 100644
--- a/lib/newlib_tests/test_macros03.c
+++ b/lib/newlib_tests/test_macros03.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2026
  */
 
 /*
- * Test TST_EXP_PASS and TST_EXP_PASS_SILENT macro.
+ * Test macros:
+ *
+ * - TST_EXP_PASS_OR_FAIL
+ * - TST_EXP_FD_OR_FAIL
  */
 
 #include "tst_test.h"
@@ -22,33 +26,28 @@ static int pass_fn(void)
 	return 0;
 }
 
-static int inval_ret_fn(void)
+static int pass_fd(void)
 {
 	return 42;
 }
 
+#define TEST_MACRO(macro, fail_fn, pass_fn, fail_err) \
+	do { \
+		tst_res(TINFO, "* Testing " #macro "() macro"); \
+		macro(fail_fn(), fail_err, #fail_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(fail_fn(), fail_err); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(pass_fn(), 0, #pass_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(fail_fn(), 0); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+	} while (0)
+
 static void do_test(void)
 {
-	tst_res(TINFO, "Testing TST_EXP_PASS macro");
-	TST_EXP_PASS(fail_fn(), "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PASS(pass_fn(), "pass_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PASS(inval_ret_fn(), "inval_ret_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-
-	tst_res(TINFO, "Testing TST_EXP_PASS_SILENT macro");
-	TST_EXP_PASS_SILENT(fail_fn(), "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PASS_SILENT(pass_fn(), "pass_fn()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PASS_SILENT(pass_fn, ...)", TST_PASS);
-	TST_EXP_PASS_SILENT(inval_ret_fn(), "inval_ret_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-
-	tst_res(TINFO, "Testing TST_EXP_PASS_OR_FAIL() macro (pass)");
-	TST_EXP_PASS_OR_FAIL(pass_fn(), 0, "pass_fn()");
-	tst_res(TINFO, "Testing TST_EXP_PASS_OR_FAIL() macro (fail)");
-	TST_EXP_PASS_OR_FAIL(fail_fn(), ERR_ERRNO, "fail_fn()");
+	TEST_MACRO(TST_EXP_PASS_OR_FAIL, fail_fn, pass_fn, ERR_ERRNO);
+	TEST_MACRO(TST_EXP_FD_OR_FAIL, fail_fn, pass_fd, ERR_ERRNO);
 }
 
 static struct tst_test test = {
diff --git a/lib/newlib_tests/test_macros04.c b/lib/newlib_tests/test_macros04.c
deleted file mode 100644
index e0111807fe..0000000000
--- a/lib/newlib_tests/test_macros04.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
- */
-
-/*
- * Test TST_EXP_PID and TST_EXP_PID_SILENT macro.
- */
-
-#include "tst_test.h"
-
-static int fail_pid(void)
-{
-	errno = EINVAL;
-	return -1;
-}
-
-static int pass_pid(void)
-{
-	return 42;
-}
-
-static int inval_val(void)
-{
-	return -42;
-}
-
-static int zero_val(void)
-{
-	return 0;
-}
-
-static void do_test(void)
-{
-	tst_res(TINFO, "Testing TST_EXP_PID macro");
-	TST_EXP_PID(fail_pid(), "fail_pid()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PID(pass_pid(), "pass_pid()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PID(inval_val(), "inval_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PID(zero_val(), "zero_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-
-	tst_res(TINFO, "Testing TST_EXP_PID_SILENT macro");
-	TST_EXP_PID_SILENT(fail_pid(), "fail_pid()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PID_SILENT(pass_pid(), "%s", "pass_pid()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PID_SILENT(pass_pid, ...)", TST_PASS);
-	TST_EXP_PID_SILENT(inval_val(), "inval_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PID_SILENT(zero_val(), "zero_val()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PID_SILENT(zero_val, ...)", TST_PASS);
-}
-
-static struct tst_test test = {
-	.test_all = do_test,
-};
diff --git a/lib/newlib_tests/test_macros06.c b/lib/newlib_tests/test_macros06.c
index 4d300d7977..621014a72a 100644
--- a/lib/newlib_tests/test_macros06.c
+++ b/lib/newlib_tests/test_macros06.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2021 zhanglianjie <zhanglianjie@uniontech.com>
+ * Copyright (c) Linux Test Project, 2026
  */
 
 /*
- * Test TST_EXP_VAL and TST_EXP_VAL_SILENT macro.
+ * Test macros:
+ *
+ * - TST_EXP_VAL
+ * - TST_EXP_VAL_SILENT
  */
 
 #include "tst_test.h"
@@ -20,19 +24,23 @@ static int pass_val(void)
 	return 42;
 }
 
+#define TEST_MACRO(macro, fail_fn, pass_fn, pass_val, fail_err) \
+	do { \
+		tst_res(TINFO, "* Testing " #macro "() macro"); \
+		macro(fail_fn(), fail_err, #fail_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(fail_fn(), fail_err); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(pass_fn(), pass_val, #pass_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(fail_fn(), pass_val); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+	} while (0)
+
 static void do_test(void)
 {
-	tst_res(TINFO, "Testing TST_EXP_VAL macro");
-	TST_EXP_VAL(fail_val(), 40, "fail_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_VAL(pass_val(), 42, "pass_val()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-
-	tst_res(TINFO, "Testing TST_EXP_VAL_SILENT macro");
-	TST_EXP_VAL_SILENT(fail_val(), 40, "fail_val()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_VAL_SILENT(fail_val, ...)", TST_PASS);
-	TST_EXP_VAL_SILENT(pass_val(), 42, "pass_val()");
-	tst_res(TINFO, "TST_PASS = %i from TST_EXP_VAL_SILENT(pass_val, ...)", TST_PASS);
+	TEST_MACRO(TST_EXP_VAL, fail_val, pass_val, 42, 40);
+	TEST_MACRO(TST_EXP_VAL_SILENT, fail_val, pass_val, 42, 40);
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
