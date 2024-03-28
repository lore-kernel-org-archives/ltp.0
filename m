Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F05CCD11DD
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 16:30:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FEB23C2B9C
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 17:30:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64E603C0166
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 17:29:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A671E1400FBF
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 17:29:45 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E67734117;
 Thu, 28 Mar 2024 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711643384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQhBWhyiYzN84lFn+8yjVCSwwtOoQo0vvvF7qt092ag=;
 b=nF+S7yWkNam996Ef5O+LEgDRYzE7fbFbCA7Kx7yVLoRpivYpJcwVgMAiMfGPQYSepzj/MF
 fyZkHKKoNCf+DK3m+sek16zVMR4z1GQLp+yKEV7qeqUByw9vSjy/FHNvZXQ4NLM5721TPo
 MJelp0dBoI26vQycwb87srqCMVq7ipg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711643384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQhBWhyiYzN84lFn+8yjVCSwwtOoQo0vvvF7qt092ag=;
 b=k4w8VUlS9Zg9ldVqCKPmhUvtqMlnEziRzy9i2t2SShhzVYMr+aiSvBVw0tL8yQ8acbdg5h
 6HVD4JgUrKQpLjDg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EB5D13A92;
 Thu, 28 Mar 2024 16:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id qDFVCPiaBWZoeAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 16:29:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 Mar 2024 17:29:37 +0100
Message-ID: <20240328162939.100872-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328162939.100872-1-pvorel@suse.cz>
References: <20240328162939.100872-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [3.61 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.09)[64.37%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/4] lib: Add TST_EXP_FAIL_PTR_{NULL, VOID}{,
 _ARR} macros
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

From: Wei Gao <wegao@suse.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
[ pvorel: Rename macros, add size parameter, fix subject. ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v5->v6:
* Add ERRNOS_CNT (size) parameter to reflect previous changes in other
  macros from 634376ea6 ("tst_test_macros.h: Require to pass array size
  in TST_EXP_FAIL*_ARR()")
* Fix names (we're adding different macros)
* Add tests into test_macros02.c

 include/tst_test_macros.h        | 61 ++++++++++++++++++++++++++++++++
 lib/newlib_tests/test_macros02.c | 30 ++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 6a7bcdce5..22b39fb14 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -227,6 +227,41 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		}                                                              \
 	} while (0)
 
+#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,                  \
+	ERRNOS, ERRNOS_CNT, ...)                                               \
+	do {                                                                   \
+		TESTPTR(SCALL);                                                \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET_PTR != FAIL_PTR_VAL) {                             \
+			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (!tst_errno_in_set(TST_ERR, ERRNOS, ERRNOS_CNT)) {          \
+			char tst_str_buf__[ERRNOS_CNT * 20];                   \
+			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
+				  tst_errno_names(tst_str_buf__,               \
+						  ERRNOS, ERRNOS_CNT),         \
+				  SSCALL, ##__VA_ARGS__);                      \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,                         \
+	ERRNOS, ERRNOS_CNT, ...)                                               \
+	do {                                                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,          \
+	        ERRNOS, ERRNOS_CNT, ##__VA_ARGS__);                            \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
+	} while (0)
+
+
 #define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
@@ -258,6 +293,32 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
 		                  EXP_ERRS_CNT, ##__VA_ARGS__);
 
+#define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                          \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_NULL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
+	do {                                                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                         \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_VOID_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
+	do {                                                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
+	} while (0)
+
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
diff --git a/lib/newlib_tests/test_macros02.c b/lib/newlib_tests/test_macros02.c
index 3cc0cd08d..1b12fab73 100644
--- a/lib/newlib_tests/test_macros02.c
+++ b/lib/newlib_tests/test_macros02.c
@@ -11,6 +11,10 @@
  * - TST_EXP_FAIL_ARR
  * - TST_EXP_FAIL2
  * - TST_EXP_FAIL2_ARR
+ * - TST_EXP_FAIL_PTR_NULL
+ * - TST_EXP_FAIL_PTR_NULL_ARR
+ * - TST_EXP_FAIL_PTR_VOID
+ * - TST_EXP_FAIL_PTR_VOID_ARR
  */
 
 #include "tst_test.h"
@@ -31,6 +35,28 @@ static int inval_ret_fn(void)
 	return 42;
 }
 
+static char *fail_fn_null(void)
+{
+	errno = EINVAL;
+	return NULL;
+}
+
+static char *fail_fn_void(void)
+{
+	errno = EINVAL;
+	return (void *)-1;
+}
+
+static char *inval_ret_fn_char(void)
+{
+	return (void *)-1;
+}
+
+static char *pass_fn_char(void)
+{
+	return "pass";
+}
+
 #define TEST_MACRO(macro, macro_arr, fail_fn, pass_fn, inval_fn) \
 	do { \
 		tst_res(TINFO, "Testing " #macro " macro"); \
@@ -55,6 +81,10 @@ static void do_test(void)
 
 	TEST_MACRO(TST_EXP_FAIL, TST_EXP_FAIL_ARR, fail_fn, pass_fn, inval_ret_fn);
 	TEST_MACRO(TST_EXP_FAIL2, TST_EXP_FAIL2_ARR, fail_fn, pass_fn, inval_ret_fn);
+	TEST_MACRO(TST_EXP_FAIL_PTR_NULL, TST_EXP_FAIL_PTR_NULL_ARR, fail_fn_null,
+			   pass_fn_char, inval_ret_fn_char);
+	TEST_MACRO(TST_EXP_FAIL_PTR_VOID, TST_EXP_FAIL_PTR_VOID_ARR, fail_fn_void,
+			   pass_fn_char, inval_ret_fn_char);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
