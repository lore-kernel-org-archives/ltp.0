Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCF5CD1284
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 16:30:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B3963C2A5C
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 17:30:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B4293C2153
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 17:29:46 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 87086616173
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 17:29:45 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 172AE20BA2;
 Thu, 28 Mar 2024 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711643384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvmrRh35V6Y4xtCxo61P8HfGwMRJKAFnMew1CtS6S/4=;
 b=RaTNCGchG3o1br53q7aJYvyYEaGg/NkPTM2uKug7oiYmbTQxy8DoPrUgVf8Af2pN8m48BB
 SeB0mJ/fbLBCh9Fx0AZXmKaUeZsohw5ntdTw28MOzeTyCXcbBhT5EEcMiVK7Nc1vgiONKy
 UeXEWSXAnvS18JHVhnRyegUFY8JqB7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711643384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvmrRh35V6Y4xtCxo61P8HfGwMRJKAFnMew1CtS6S/4=;
 b=/NZ/6ErUQuLEMRXpKfNv1Io0hlNFOEsWP7aAoFE2M6L2+lGl2hGZyIa61SK5Ag8W7hTWKE
 e0bVih6B8J0MRdAQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B11AB13A9B;
 Thu, 28 Mar 2024 16:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 0BzCKPeaBWZoeAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 16:29:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 Mar 2024 17:29:36 +0100
Message-ID: <20240328162939.100872-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328162939.100872-1-pvorel@suse.cz>
References: <20240328162939.100872-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[21.52%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/4] test_macros02: Reduce duplicity
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v6.

 lib/newlib_tests/test_macros02.c | 54 +++++++++++++++-----------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/lib/newlib_tests/test_macros02.c b/lib/newlib_tests/test_macros02.c
index 8e5a83346..3cc0cd08d 100644
--- a/lib/newlib_tests/test_macros02.c
+++ b/lib/newlib_tests/test_macros02.c
@@ -1,10 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2021-2024
  */
 
 /*
- * Test TST_EXP_FAIL and TST_EXP_FAIL2 macro.
+ * Test macros:
+ *
+ * - TST_EXP_FAIL
+ * - TST_EXP_FAIL_ARR
+ * - TST_EXP_FAIL2
+ * - TST_EXP_FAIL2_ARR
  */
 
 #include "tst_test.h"
@@ -25,38 +31,30 @@ static int inval_ret_fn(void)
 	return 42;
 }
 
+#define TEST_MACRO(macro, macro_arr, fail_fn, pass_fn, inval_fn) \
+	do { \
+		tst_res(TINFO, "Testing " #macro " macro"); \
+		macro(fail_fn(), EINVAL, #fail_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(fail_fn(), ENOTTY); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(pass_fn(), ENOTTY, #pass_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro(inval_fn(), ENOTTY, #inval_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro_arr(fail_fn(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), #fail_fn"()"); \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+		macro_arr(fail_fn(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail)); /* skip msg parameter */ \
+		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
+	} while (0)
+
 static void do_test(void)
 {
 	const int exp_errs_pass[] = {ENOTTY, EINVAL};
 	const int exp_errs_fail[] = {ENOTTY, EISDIR};
 
-	tst_res(TINFO, "Testing TST_EXP_FAIL macro");
-	TST_EXP_FAIL(fail_fn(), EINVAL, "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL(fail_fn(), ENOTTY, "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL(pass_fn(), ENOTTY, "pass_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail), "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-
-	tst_res(TINFO, "Testing TST_EXP_FAIL2 macro");
-	TST_EXP_FAIL2(fail_fn(), EINVAL, "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2(fail_fn(), ENOTTY, "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2(pass_fn(), ENOTTY, "pass_fn");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail), "fail_fn()");
-	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TEST_MACRO(TST_EXP_FAIL, TST_EXP_FAIL_ARR, fail_fn, pass_fn, inval_ret_fn);
+	TEST_MACRO(TST_EXP_FAIL2, TST_EXP_FAIL2_ARR, fail_fn, pass_fn, inval_ret_fn);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
