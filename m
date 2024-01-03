Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E801CC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 11:58:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79CD63CE771
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 12:57:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1856E3C8122
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 12:57:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9168600C9F
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 12:57:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B64AD21F5E
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704283064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFTMi6bBYhJixULTEmmY+xE/flKPC+8vukfU3pMbyr4=;
 b=xF3K8sW76tUxSOBWRZ6PLNxPOqSwB34QTU6fYFIGoJYxqeeuB/FAeIQAOLP9CK6BSVhWMs
 HlD9jXV9CPWm/B/XK3pMTclNcygpLqdtL93CR5t0O6xxo+bBl4eiiLO4cRmYtHogKvwHHq
 c0o7iT690VZ6SqUTbWHU3OPo7a0B7ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704283064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFTMi6bBYhJixULTEmmY+xE/flKPC+8vukfU3pMbyr4=;
 b=uFRlhqu4FEsv4Mk59g9dM/Koje9I27po/Z+a9aD4ARKZ2VR220AcoCSR2OTNDhAcaOjUZw
 60oLZuXFIEsr/KAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704283064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFTMi6bBYhJixULTEmmY+xE/flKPC+8vukfU3pMbyr4=;
 b=xF3K8sW76tUxSOBWRZ6PLNxPOqSwB34QTU6fYFIGoJYxqeeuB/FAeIQAOLP9CK6BSVhWMs
 HlD9jXV9CPWm/B/XK3pMTclNcygpLqdtL93CR5t0O6xxo+bBl4eiiLO4cRmYtHogKvwHHq
 c0o7iT690VZ6SqUTbWHU3OPo7a0B7ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704283064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oFTMi6bBYhJixULTEmmY+xE/flKPC+8vukfU3pMbyr4=;
 b=uFRlhqu4FEsv4Mk59g9dM/Koje9I27po/Z+a9aD4ARKZ2VR220AcoCSR2OTNDhAcaOjUZw
 60oLZuXFIEsr/KAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A675813AA6
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 11:57:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kQxWKLhLlWXeGwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 11:57:44 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Jan 2024 12:57:00 +0100
Message-ID: <20240103115700.14585-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xF3K8sW7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uFRlhqu4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: B64AD21F5E
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: TST_EXP_FAIL: Add array variants
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

For certain cases there is a possibility of a failure with more than one
errno, for instance testcases with invalid fd may return either EINVAL
or EBADFD and in many cases either one is fine, at least that was the
feedback from kernel devs.

This change also adds a tst_errno_in_set() function that is now the
single place to validate errno for all TST_EXP_FAIL*() variants. That is
intentional since this allows us to implement code to relax the
conditions if needed, e.g. we had requests to allow additional errnos
for systems with SELinux where failures may be caused by the SELinux
policies and the errors may differ.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h        | 65 ++++++++++++++++++++++++++------
 lib/newlib_tests/test_macros02.c | 11 ++++++
 lib/tst_test_macros.c            | 36 ++++++++++++++++++
 3 files changed, 101 insertions(+), 11 deletions(-)
 create mode 100644 lib/tst_test_macros.c

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index bd0c491c1..5687d0904 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -186,7 +186,18 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
-#define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNO, ...)             \
+/*
+ * Returns true if err is in the exp_err array.
+ */
+int tst_errno_in_set(int err, const int *exp_errs, int exp_errs_cnt);
+
+/*
+ * Fills in the buf with the errno names in the exp_err set. The buf must be at
+ * least 20 * exp_errs_cnt bytes long.
+ */
+const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
+
+#define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNOS, ERRNOS_CNT, ...)\
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -203,36 +214,68 @@ extern void *TST_RET_PTR;
 			break;                                                 \
 		}                                                              \
 		                                                               \
-		if (TST_ERR == (ERRNO)) {                                      \
+		if (tst_errno_in_set(TST_ERR, ERRNOS, ERRNOS_CNT)) {           \
 			TST_PASS = 1;                                          \
 		} else {                                                       \
+			char tst_str_buf__[ERRNOS_CNT * 20];                   \
 			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
-				  tst_strerrno(ERRNO),                         \
+				  tst_errno_names(tst_str_buf__,               \
+						  ERRNOS, ERRNOS_CNT),         \
 				  SSCALL, ##__VA_ARGS__);                      \
 		}                                                              \
 	} while (0)
 
-#define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
+#define TST_EXP_FAIL_ARR_(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                  \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
-			ERRNO, ##__VA_ARGS__);                                 \
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);                \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
 	} while (0)
 
-#define TST_EXP_FAIL2(SCALL, ERRNO, ...)                                       \
+#define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_ARR_(SCALL, &tst_exp_err__, 1,                    \
+                                  ##__VA_ARGS__);                              \
+	} while (0)
+
+#define TST_EXP_FAIL_ARR(SCALL, EXP_ERRS, ...)                                 \
+		TST_EXP_FAIL_ARR_(SCALL, EXP_ERRS, ARRAY_SIZE(EXP_ERRS),       \
+                                  ##__VA_ARGS__);                              \
+
+#define TST_EXP_FAIL2_ARR_(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                 \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,              \
-			ERRNO, ##__VA_ARGS__);                                 \
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);                \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
 	} while (0)
 
-#define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) \
-	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL2_ARR(SCALL, EXP_ERRS, ...)                                \
+		TST_EXP_FAIL2_ARR_(SCALL, EXP_ERRS, ARRAY_SIZE(EXP_ERRS),      \
+                                  ##__VA_ARGS__);                              \
 
-#define TST_EXP_FAIL2_SILENT(SCALL, ERRNO, ...) \
-	TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL2_ARR_(SCALL, &tst_exp_err__, 1,                   \
+                                  ##__VA_ARGS__);                              \
+	} while (0)
+
+#define TST_EXP_FAIL_SILENT(SCALL, EXP_ERR, ...)                               \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+	} while (0)
+
+#define TST_EXP_FAIL2_SILENT(SCALL, EXP_ERR, ...)                              \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,              \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+	} while (0)
 
 #define TST_EXP_EXPR(EXPR, FMT, ...)						\
 	tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
diff --git a/lib/newlib_tests/test_macros02.c b/lib/newlib_tests/test_macros02.c
index 647f73682..6c1ca7a8a 100644
--- a/lib/newlib_tests/test_macros02.c
+++ b/lib/newlib_tests/test_macros02.c
@@ -27,6 +27,9 @@ static int inval_ret_fn(void)
 
 static void do_test(void)
 {
+	const int exp_errs_pass[] = {ENOTTY, EINVAL};
+	const int exp_errs_fail[] = {ENOTTY, EISDIR};
+
 	tst_res(TINFO, "Testing TST_EXP_FAIL macro");
 	TST_EXP_FAIL(fail_fn(), EINVAL, "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
@@ -36,6 +39,10 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 	TST_EXP_FAIL(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_pass, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_fail, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 
 	tst_res(TINFO, "Testing TST_EXP_FAIL2 macro");
 	TST_EXP_FAIL2(fail_fn(), EINVAL, "fail_fn()");
@@ -46,6 +53,10 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 	TST_EXP_FAIL2(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_pass, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_fail, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 }
 
 static struct tst_test test = {
diff --git a/lib/tst_test_macros.c b/lib/tst_test_macros.c
new file mode 100644
index 000000000..a36abbea3
--- /dev/null
+++ b/lib/tst_test_macros.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdio.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_test_macros.h"
+
+int tst_errno_in_set(int err, const int *exp_errs, int exp_errs_cnt)
+{
+	int i;
+
+	for (i = 0; i < exp_errs_cnt; i++) {
+		if (err == exp_errs[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt)
+{
+	int i;
+	char *cb = buf;
+
+	for (i = 0; i < exp_errs_cnt-1; i++)
+		cb += sprintf(cb, "%s, ", tst_strerrno(exp_errs[i]));
+
+	cb += sprintf(cb, "%s", tst_strerrno(exp_errs[i]));
+
+	*cb = 0;
+
+	return buf;
+}
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
