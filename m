Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B3606A330
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=EuXmaSiX;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mgilxrcp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794577300; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Tr8OrcgpDyjG9EX+QRp7wiVTQRcxvaNfI0N0AHso49k=;
 b=EuXmaSiXT0fURRGnRUcMPGEwwJupPMrNKkQha817fPUX2wV9+XkYDHNuiPdCbGXy4vu5g
 9jK3/PHzTJg/OCgngvjFPXEL3ltyQJC7vNJ70Tg/+a3Gq719I3W8KcbhvBvRYX7NZUMQrt5
 uC1zxLMhPzVtsOajxDhB6yy8XWB5pMY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F2773EA060
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 14:41:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8292C3CFEFD
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 14:41:20 +0100 (CET)
Received: from mail-oi1-x248.google.com (mail-oi1-x248.google.com
 [IPv6:2607:f8b0:4864:20::248])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA1431400B83
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 14:41:19 +0100 (CET)
Received: by mail-oi1-x248.google.com with SMTP id
 5614622812f47-4b26d8d2498so1185776b6e.2
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794577278; x=1795182078; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5E8+wuULR7p3a7y7taCwvi6DmbcjClq3MIAMc2nLkyA=;
 b=Mgilxrcpvl52XHsygFLrc/3rypPRDmNo3DKaPkZgJqh545/AQFXBioeMmH08U6TYBX
 QJqJwUutQG//JAU7NmEi4+Y18VA2WtsryEmBIE+epSSNvS7HgGZcuMRcxFlO9LMiTLig
 s1jD4OzT6OYQmr7fgBe+31IT8AzxyNS+LdRr4tRVe6kjvSxBnXdP0OlRBPmAnMERIjJ3
 58q8/UXv60Oqbzvf3ULsJa7/YgoQ/y/nnKVKZif/pGdwPGV8yvOxcLB63r750BHmq5/r
 /R4cl70S/QeubL5fuWNZ750Pu/mgsCw61X7R1bYuqlIqtHi8YyfMgaTPeroDg2vrT29Q
 Geug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794577278; x=1795182078;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5E8+wuULR7p3a7y7taCwvi6DmbcjClq3MIAMc2nLkyA=;
 b=akRI5ykDo7mWzshyJbunoRxvleObkok2zRm33dD3REPm0puWN6/bMVRfP7s37cPkSi
 BUjRRCIjLbobp57T4kHvzG+c/sa6iSC2OVM9JEQuOrq8byic5HmtRYU/7tBYGtdaea8F
 gfoQyrcMqTif3KW/hmC/94ka/GwFzxPbhOD4l0tGDC6CjjhecZikIwW9UVOVse3oF+g8
 DLwlNxYgihIGYGgYX3CUmPxkKsIwiwDOLi1H/zV/KHmENciTfleEEkS9f0kjFKBt9X8k
 8SL1SZyh85z+zmlrzm7Z58ga9c29fA8y/3E2dF7Ctx6ba+jerLYXaR3CF3wS8//xc8Ih
 K1uw==
X-Gm-Message-State: APuU4Z8m3FxHvZorhAkGiExnxUJSJHWn/MKItb7Z5Fg3lEZK5xxDRVJi
 Lf6WgfPLj71B/ooKUrb9aYiqJdDHsUlFem4NE/JuLaX3RrTo1lRPqx45HLHISPJ53SyXm1ygSol
 R3ziNH5mPcpVrB7BVAG/ej3VbWjUy8bWi3P3rwFCYmoCwkPaRmwOWUZ8tAM47VPOf30hlfR4iJA
 V9U198ULUBMzlpGc2E7OvyXTvZwg==
X-Received: from iobh26.prod.google.com ([2002:a05:6602:9a:b0:9c4:bd6e:a838])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1917:b0:4e5:c2b4:33a3
 with SMTP id 5614622812f47-56e65a3b3bcmr1787054b6e.45.1794577277761; Fri, 13
 Nov 2026 05:41:17 -0800 (PST)
Date: Fri, 13 Nov 2026 13:41:13 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113134113.2822581-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test_macros: Avoid re-evaluating arguments in
 TST_EXP_{EQ, LE}_*()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit 1759ad9f3f0b ("Add silent macros for TST_EXP_EQ_*") split the
TPASS message out of TST_EXP_EQ_SILENT_() and printed VAL_A directly in
TST_EXP_EQ_LI(), TST_EXP_EQ_LU(), TST_EXP_EQ_SZ() and TST_EXP_EQ_SSZ()
because tst_tmp_a__ was no longer in scope. As a result, VAL_A is
evaluated a second time whenever the check passes. Commit 1b0395338108
("tst_test_macros: Add TST_EXP_LE_LU*()") followed the same pattern and
evaluates both VAL_A and VAL_B a second time on TPASS.

When an argument has side effects, the test executes it twice on
success. For example, stream04 calls:

  TST_EXP_EQ_LI(fwrite(data, 1, DATASIZE, stream), DATASIZE);

which writes DATASIZE (27) bytes twice into the file, and epoll_wait06
calls:

  TST_EXP_EQ_LI(SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0), 1);

where the first call consumes the edge-triggered event and the second
call in the TPASS message returns 0, printing:

  TPASS: SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0) == 1 (0)

The first commit also passed size_t instead of ssize_t to
TST_EXP_EQ_SILENT_() in TST_EXP_EQ_SSZ().

Pass a SILENT parameter to TST_EXP_EQ_() and TST_EXP_LE_() so the TPASS
message is emitted inside the same block using tst_tmp_a__ and
tst_tmp_b__, and fix the type in TST_EXP_EQ_SSZ() to ssize_t.

Fixes: 1759ad9f3f0b ("Add silent macros for TST_EXP_EQ_*")
Fixes: 1b0395338108 ("tst_test_macros: Add TST_EXP_LE_LU*()")
Signed-off-by: Wake Liu <wakel@google.com>
---
 include/tst_test_macros.h | 89 +++++++++++++--------------------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index fcecf7f82..53f6c1e80 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -759,33 +759,37 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
        tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "       \
                 TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__));
 
-#define TST_EXP_EQ_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {       \
+#define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS, SILENT) do {      \
 	TYPE tst_tmp_a__ = VAL_A;                                              \
 	TYPE tst_tmp_b__ = VAL_B;                                              \
                                                                                \
-	TST_PASS = 0;                                                          \
+	TST_PASS = tst_tmp_a__ == tst_tmp_b__;                                 \
                                                                                \
-	if (tst_tmp_a__ != tst_tmp_b__) {                                      \
+	if (!TST_PASS) {                                                       \
 		tst_res_(__FILE__, __LINE__, TFAIL,                            \
 			SVAL_A " (" PFS ") != " SVAL_B " (" PFS ")",           \
 			tst_tmp_a__, tst_tmp_b__);                             \
-	} else {                                                               \
-		TST_PASS = 1;                                                  \
+	} else if (!(SILENT)) {                                                \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			SVAL_A " == " SVAL_B " (" PFS ")",                     \
+			tst_tmp_a__);                                          \
 	}                                                                      \
 } while (0)
 
-#define TST_EXP_LE_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {       \
+#define TST_EXP_LE_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS, SILENT) do {      \
 	TYPE tst_tmp_a__ = VAL_A;                                              \
 	TYPE tst_tmp_b__ = VAL_B;                                              \
                                                                                \
-	TST_PASS = 0;                                                          \
+	TST_PASS = tst_tmp_a__ <= tst_tmp_b__;                                 \
                                                                                \
-	if (tst_tmp_a__ > tst_tmp_b__) {                                       \
+	if (!TST_PASS) {                                                       \
 		tst_res_(__FILE__, __LINE__, TFAIL,                            \
 			SVAL_A " (" PFS ") > " SVAL_B " (" PFS ")",            \
 			tst_tmp_a__, tst_tmp_b__);                             \
-	} else {                                                               \
-		TST_PASS = 1;                                                  \
+	} else if (!(SILENT)) {                                                \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			SVAL_A " <= " SVAL_B " (" PFS " <= " PFS ")",          \
+			tst_tmp_a__, tst_tmp_b__);                             \
 	}                                                                      \
 } while (0)
 
@@ -797,15 +801,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * Reports a pass if A <= B and a fail otherwise.
  */
-#define TST_EXP_LE_LU(VAL_A, VAL_B) do {                                              \
-	TST_EXP_LE_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
-									              \
-	if (TST_PASS) {                                                               \
-		tst_res_(__FILE__, __LINE__, TPASS,                                   \
-			#VAL_A " <= " #VAL_B " (%llu <= %llu)",                       \
-			(unsigned long long)VAL_A, (unsigned long long)VAL_B);        \
-	}                                                                             \
-} while (0)
+#define TST_EXP_LE_LU(VAL_A, VAL_B) \
+	TST_EXP_LE_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu", 0)
 
 /**
  * TST_EXP_LE_LU_SILENT() - Compare two unsigned long long values, silent variant.
@@ -817,7 +814,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
  */
 #define TST_EXP_LE_LU_SILENT(VAL_A, VAL_B) \
-	TST_EXP_LE_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+	TST_EXP_LE_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu", 1)
 
 /**
  * TST_EXP_EQ_LI() - Compare two long long values.
@@ -827,15 +824,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * Reports a pass if values are equal and a fail otherwise.
  */
-#define TST_EXP_EQ_LI(VAL_A, VAL_B) do {                                       \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli");   \
-								               \
-	if (TST_PASS) {                                                        \
-		tst_res_(__FILE__, __LINE__, TPASS,                            \
-			#VAL_A " == " #VAL_B " (%lli)",                        \
-			(long long)VAL_A);                                     \
-	}                                                                      \
-} while (0)
+#define TST_EXP_EQ_LI(VAL_A, VAL_B) \
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli", 0)
 
 /**
  * TST_EXP_EQ_LI_SILENT() - Compare two long long values, silent variant.
@@ -847,7 +837,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
  */
 #define TST_EXP_EQ_LI_SILENT(VAL_A, VAL_B) \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli")
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli", 1)
 
 /**
  * TST_EXP_EQ_LU() - Compare two unsigned long long values.
@@ -857,15 +847,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * Reports a pass if values are equal and a fail otherwise.
  */
-#define TST_EXP_EQ_LU(VAL_A, VAL_B) do {                                       \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
-								               \
-	if (TST_PASS) {                                                        \
-		tst_res_(__FILE__, __LINE__, TPASS,                            \
-			#VAL_A " == " #VAL_B " (%llu)",                        \
-			(unsigned long long)VAL_A);                            \
-	}                                                                      \
-} while (0)
+#define TST_EXP_EQ_LU(VAL_A, VAL_B) \
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu", 0)
 
 /**
  * TST_EXP_EQ_LU_SILENT() - Compare two unsigned long long values, silent variant.
@@ -877,7 +860,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
  */
 #define TST_EXP_EQ_LU_SILENT(VAL_A, VAL_B) \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu", 1)
 
 /**
  * TST_EXP_EQ_SZ() - Compare two size_t values.
@@ -887,15 +870,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * Reports a pass if values are equal and a fail otherwise.
  */
-#define TST_EXP_EQ_SZ(VAL_A, VAL_B) do {                                       \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu");       \
-								               \
-	if (TST_PASS) {                                                        \
-		tst_res_(__FILE__, __LINE__, TPASS,                            \
-			#VAL_A " == " #VAL_B " (%zu)",                         \
-			(size_t)VAL_A);                                        \
-	}                                                                      \
-} while (0)
+#define TST_EXP_EQ_SZ(VAL_A, VAL_B) \
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu", 0)
 
 /**
  * TST_EXP_EQ_SZ_SILENT() - Compare two size_t values, silent variant.
@@ -907,7 +883,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
  */
 #define TST_EXP_EQ_SZ_SILENT(VAL_A, VAL_B) \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu", 1)
 
 /**
  * TST_EXP_EQ_SSZ() - Compare two ssize_t values.
@@ -917,15 +893,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * Reports a pass if values are equal and a fail otherwise.
  */
-#define TST_EXP_EQ_SSZ(VAL_A, VAL_B) do {                                      \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zi");       \
-								               \
-	if (TST_PASS) {                                                        \
-		tst_res_(__FILE__, __LINE__, TPASS,                            \
-			#VAL_A " == " #VAL_B " (%zi)",                         \
-			(ssize_t)VAL_A);                                        \
-	}                                                                      \
-} while (0)
+#define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi", 0)
 
 /**
  * TST_EXP_EQ_SSZ_SILENT() - Compare two ssize_t values, silent variant.
@@ -937,7 +906,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
  */
 #define TST_EXP_EQ_SSZ_SILENT(VAL_A, VAL_B) \
-	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
+	TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi", 1)
 
 /**
  * TST_EXP_EQ_STR() - Compare two strings.

base-commit: 5f4d6908fa7d48842f151b18ed4d8a9a76258cd5
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
