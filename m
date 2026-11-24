Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0E606A31E
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yKjVQk59;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KwZENvUJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yKjVQk59;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KwZENvUJ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2D733E9145
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 07:02:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 544C23E906C
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 07:01:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 918F31400427
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 07:01:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F3811FAB2;
 Tue, 24 Nov 2026 06:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795500109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziYsqrWb/Kl288PN6QCgMgmusZ013DX7qR18QLLQxdI=;
 b=yKjVQk59Me3QRdjUv8p5wYetvL7w0rq5XQwKI9RWVFNf1eA2WjW/PQcOEXd2TXUK/DNa6O
 WZxJMDTKuJAoVaDWxIoM6XmDL331AiybhDj8Kc9jXjvYzxvF8ANMMfqqJ0Ylg96uI/1I17
 ShSpyayecpZq1e7T/TL7AP9cMjLwyPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795500109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziYsqrWb/Kl288PN6QCgMgmusZ013DX7qR18QLLQxdI=;
 b=KwZENvUJBmPz5dBdg2qwdCR5N+P5tfMErkTwwrafj89s1GxRMF6vLqD+PSuIndjOl7646U
 oyNGt8NPqToBhiBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795500109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziYsqrWb/Kl288PN6QCgMgmusZ013DX7qR18QLLQxdI=;
 b=yKjVQk59Me3QRdjUv8p5wYetvL7w0rq5XQwKI9RWVFNf1eA2WjW/PQcOEXd2TXUK/DNa6O
 WZxJMDTKuJAoVaDWxIoM6XmDL331AiybhDj8Kc9jXjvYzxvF8ANMMfqqJ0Ylg96uI/1I17
 ShSpyayecpZq1e7T/TL7AP9cMjLwyPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795500109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziYsqrWb/Kl288PN6QCgMgmusZ013DX7qR18QLLQxdI=;
 b=KwZENvUJBmPz5dBdg2qwdCR5N+P5tfMErkTwwrafj89s1GxRMF6vLqD+PSuIndjOl7646U
 oyNGt8NPqToBhiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A1A91339F;
 Tue, 24 Nov 2026 06:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7JJNGkcoBWu0eAAAD6G6ig:T3
 (envelope-from <gpathak@suse.de>); Tue, 24 Nov 2026 06:01:48 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: Linux Test Project <ltp@lists.linux.it>
Date: Tue, 24 Nov 2026 11:31:27 +0530
Message-ID: <20261124-statx-atomic-write-v12-2-57e8b2dc4a18@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261124-statx-atomic-write-v12-0-57e8b2dc4a18@suse.com>
References: <20261124-statx-atomic-write-v12-0-57e8b2dc4a18@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12552; i=gaurav.pathak@suse.com;
 h=from:subject:message-id; bh=HHZ6Cz5WumdYQ06ouzhUEmPCX+1wIaFcfOqkffFsymU=;
 b=owGbwMvMwCUWE1e4+dFlWS3G02pJDNmsascNmwSd7VbKBGs3764MqdWJvF8SPfumweLVzrrBL
 yY1ffXoKGVhEONikBVTZDFWaBb3u8pcbaupKQczh5UJZAgDF6cATGR6OiPDs/BC2d1/lvyQbOBc
 dXPyp3Qhn0+anVH/DnxMKrljefkfB8N/18WJ1dMSfrexRBzmWZWv9dA1et0pi8V71luKBM780PG
 ZHwA=
X-Developer-Key: i=gaurav.pathak@suse.com; a=openpgp;
 fpr=332083174ED5037B3D29291E5C5E71B3E2D31D2A
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 2/2] statx13: Add LT/POW2 macros in
 tst_test_macros.h and simplify statx13 checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, Gaurav Pathak <gpathak@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gaurav Pathak <gaurav.pathak@suse.com>

Add TST_EXP_LT_LU(), TST_EXP_LT_LU_SILENT(), TST_EXP_POW2_LU(), and
TST_EXP_POW2_LU_SILENT() helper macros to tst_test_macros.h for
unsigned long long less-than and power-of-2 assertions.

Update statx13 to use TST_EXP_LE_LU(), TST_EXP_LT_LU(), and
TST_EXP_POW2_LU() instead of manual TST_EXP_EXPR() and if/else checks,
shorten diagnostic messages, remove redundant comments in setup(), and
drop the unnecessary .needs_tmpdir = 1 flag.

Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
---
 include/tst_test_macros.h                 | 111 ++++++++++++++++++++++++++++++
 testcases/kernel/syscalls/statx/statx13.c |  66 ++++--------------
 2 files changed, 124 insertions(+), 53 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index fcecf7f8251e156170762519bd9b7ab1acd2d35c..312806a70bb15bed1489302d52d37c8964964d1a 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -879,6 +879,117 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 #define TST_EXP_EQ_LU_SILENT(VAL_A, VAL_B) \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
 
+/*
+ * TST_EXP_LT_SILENT_() - Internal helper to compare two values, expect A < B.
+ *
+ * @VAL_A: First value to compare.
+ * @SVAL_A: Stringified expression of VAL_A for failure reporting.
+ * @VAL_B: Second value to compare.
+ * @SVAL_B: Stringified expression of VAL_B for failure reporting.
+ * @TYPE: C type used to evaluate and store values (e.g. unsigned long long).
+ * @PFS: printf format specifier matching TYPE (e.g. "%llu").
+ *
+ * Sets TST_PASS to 1 if VAL_A < VAL_B. Otherwise sets TST_PASS to 0 and
+ * reports TFAIL with both evaluated values.
+ */
+#define TST_EXP_LT_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {       \
+	TYPE tst_tmp_a__ = VAL_A;                                              \
+	TYPE tst_tmp_b__ = VAL_B;                                              \
+                                                                               \
+	TST_PASS = 0;                                                          \
+                                                                               \
+	if (tst_tmp_a__ >= tst_tmp_b__) {                                      \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			SVAL_A " (" PFS ") >= " SVAL_B " (" PFS ")",           \
+			tst_tmp_a__, tst_tmp_b__);                             \
+	} else {                                                               \
+		TST_PASS = 1;                                                  \
+	}                                                                      \
+} while (0)
+
+/**
+ * TST_EXP_LT_LU() - Compare two unsigned long long values, expect A < B.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Reports a pass if A < B and a fail otherwise.
+ */
+#define TST_EXP_LT_LU(VAL_A, VAL_B) do {                                              \
+	TST_EXP_LT_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
+                                                                                      \
+	if (TST_PASS) {                                                               \
+		tst_res_(__FILE__, __LINE__, TPASS,                                   \
+			#VAL_A " < " #VAL_B " (%llu < %llu)",                         \
+			(unsigned long long)VAL_A, (unsigned long long)VAL_B);        \
+	}                                                                             \
+} while (0)
+
+/**
+ * TST_EXP_LT_LU_SILENT() - Compare two unsigned long long values, silent variant.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Unlike TST_EXP_LT_LU() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
+#define TST_EXP_LT_LU_SILENT(VAL_A, VAL_B) \
+	TST_EXP_LT_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+
+/*
+ * TST_EXP_POW2_SILENT_() - Internal helper to check if a value is a power of 2.
+ *
+ * @VAL: Value to check.
+ * @SVAL: Stringified expression of VAL for failure reporting.
+ * @TYPE: C type used to evaluate and store VAL (e.g. unsigned long long).
+ * @PFS: printf format specifier matching TYPE (e.g. "%llu").
+ *
+ * Sets TST_PASS to 1 if VAL is a non-zero power of 2. Otherwise sets
+ * TST_PASS to 0 and reports TFAIL.
+ */
+#define TST_EXP_POW2_SILENT_(VAL, SVAL, TYPE, PFS) do {                        \
+	TYPE tst_tmp__ = VAL;                                                  \
+                                                                               \
+	TST_PASS = 0;                                                          \
+                                                                               \
+	if (tst_tmp__ == 0 || (tst_tmp__ & (tst_tmp__ - 1)) != 0) {            \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			SVAL " (" PFS ") is not a power of 2",                 \
+			tst_tmp__);                                            \
+	} else {                                                               \
+		TST_PASS = 1;                                                  \
+	}                                                                      \
+} while (0)
+
+/**
+ * TST_EXP_POW2_LU() - Check if an unsigned long long value is a power of 2.
+ *
+ * @VAL: unsigned long long value to check.
+ *
+ * Reports a pass if VAL is a power of 2 (and non-zero) and a fail otherwise.
+ */
+#define TST_EXP_POW2_LU(VAL) do {                                              \
+	TST_EXP_POW2_SILENT_(VAL, #VAL, unsigned long long, "%llu");           \
+                                                                               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			#VAL " (%llu) is a power of 2",                        \
+			(unsigned long long)VAL);                              \
+	}                                                                      \
+} while (0)
+
+/**
+ * TST_EXP_POW2_LU_SILENT() - Check if an unsigned long long value is a power of 2, silent variant.
+ *
+ * @VAL: unsigned long long value to check.
+ *
+ * Unlike TST_EXP_POW2_LU() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
+#define TST_EXP_POW2_LU_SILENT(VAL) \
+	TST_EXP_POW2_SILENT_(VAL, #VAL, unsigned long long, "%llu")
+
 /**
  * TST_EXP_EQ_SZ() - Compare two size_t values.
  *
diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
index 81b58cdfc9e8f4430c641ff4c6ffde9686a2d0b7..f447d101ce162ce1cb14eae669306338fc58f615 100644
--- a/testcases/kernel/syscalls/statx/statx13.c
+++ b/testcases/kernel/syscalls/statx/statx13.c
@@ -93,11 +93,11 @@ static void verify_statx(void)
 
 	/* Check if the kernel populated the atomic limit struct members */
 	if (!(buff->data.stx_mask & STATX_WRITE_ATOMIC))
-		tst_brk(TCONF, "Kernel may be too old to report atomic limits: STATX_WRITE_ATOMIC missing from stx_mask");
+		tst_brk(TCONF, "Kernel may be too old to report atomic limits");
 
 	/* Check if the filesystem supports reporting the atomic write attribute */
 	if (!(buff->data.stx_attributes_mask & STATX_ATTR_WRITE_ATOMIC)) {
-		tst_res(TFAIL, "Inconsistent: stx_mask has STATX_WRITE_ATOMIC but stx_attributes_mask lacks STATX_ATTR_WRITE_ATOMIC");
+		tst_res(TFAIL, "Missing STATX_ATTR_WRITE_ATOMIC in stx_attributes_mask");
 		return;
 	}
 
@@ -112,47 +112,20 @@ static void verify_statx(void)
 			return;
 		}
 
-		tst_brk(TCONF, "STATX_WRITE_ATOMIC unsupported by block dev or filesystem: STATX_ATTR_WRITE_ATOMIC missing from stx_attributes");
+		tst_brk(TCONF, "STATX_WRITE_ATOMIC unsupported by block dev or filesystem");
 	}
 
-	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_min <= buff->data.stx_atomic_write_unit_max,
-			"stx_atomic_write_unit_min(%u) <= stx_atomic_write_unit_max(%u)",
-			buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max);
-
-	TST_EXP_EXPR(buff->data.stx_atomic_write_segments_max > 0,
-			"stx_atomic_write_segments_max(%u) > 0", buff->data.stx_atomic_write_segments_max);
-
-	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_min > 0 &&
-			!(buff->data.stx_atomic_write_unit_min & (buff->data.stx_atomic_write_unit_min - 1)),
-			"stx_atomic_write_unit_min(%u) is a power of 2",
-			buff->data.stx_atomic_write_unit_min);
-
-	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_max > 0 &&
-			!(buff->data.stx_atomic_write_unit_max & (buff->data.stx_atomic_write_unit_max - 1)),
-			"stx_atomic_write_unit_max(%u) is a power of 2",
-			buff->data.stx_atomic_write_unit_max);
+	TST_EXP_LE_LU(buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max);
+	TST_EXP_LT_LU(0, buff->data.stx_atomic_write_segments_max);
+	TST_EXP_POW2_LU(buff->data.stx_atomic_write_unit_min);
+	TST_EXP_POW2_LU(buff->data.stx_atomic_write_unit_max);
 
 	if (buff->data.stx_atomic_write_unit_max_opt == 0) {
 		tst_res(TPASS, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
 	} else {
-		if (buff->data.stx_atomic_write_unit_max_opt > buff->data.stx_atomic_write_unit_max) {
-			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
-					buff->data.stx_atomic_write_unit_max_opt,
-					buff->data.stx_atomic_write_unit_max);
-		} else if (buff->data.stx_atomic_write_unit_max_opt < buff->data.stx_atomic_write_unit_min) {
-			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
-					buff->data.stx_atomic_write_unit_max_opt,
-					buff->data.stx_atomic_write_unit_min);
-		} else {
-			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
-					buff->data.stx_atomic_write_unit_max_opt,
-					buff->data.stx_atomic_write_unit_min,
-					buff->data.stx_atomic_write_unit_max);
-		}
-
-		TST_EXP_EXPR(!(buff->data.stx_atomic_write_unit_max_opt & (buff->data.stx_atomic_write_unit_max_opt - 1)),
-				"stx_atomic_write_unit_max_opt(%u) is a power of 2",
-				buff->data.stx_atomic_write_unit_max_opt);
+		TST_EXP_LE_LU(buff->data.stx_atomic_write_unit_max_opt, buff->data.stx_atomic_write_unit_max);
+		TST_EXP_LE_LU(buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max_opt);
+		TST_EXP_POW2_LU(buff->data.stx_atomic_write_unit_max_opt);
 	}
 }
 
@@ -191,26 +164,14 @@ static void setup(void)
 		 * Unlike XFS, ext4 has no device-independent (software)
 		 * atomic write mechanism: ext4_atomic_write_init() always
 		 * requires bdev_can_atomic_write() to be true. So without
-		 * device support there is nothing for ext4 to exercise here.
+		 * device support, there is nothing for ext4 to exercise here.
 		 */
 		tst_brk(TCONF,
-			"%s does not support atomic writes (loop devices never do) and ext4 has no software atomic write fallback; set LTP_DEV to a real NVMe/SCSI device, or load scsi_debug",
-			tst_device->dev);
+				"%s lacks atomic writes (no ext4 software fallback); set LTP_DEV to a real NVMe/SCSI device or load scsi_debug",
+				tst_device->dev);
 	}
 
 	if (!dev_has_atomic) {
-		/*
-		 * No hardware atomic write support, but XFS can still
-		 * complete atomic writes via CoW-based out-of-place writes
-		 * (xfs_inode_can_sw_atomic_write()) as long as reflink is
-		 * enabled, independently of the backing device -- this
-		 * works even on a plain loop device, but only since Linux
-		 * v6.16. Force reflink on explicitly rather than relying on
-		 * mkfs.xfs defaults, and skip the device-limit-based block
-		 * size selection below entirely since it doesn't apply here.
-		 * If the running kernel predates v6.16, verify_statx() will
-		 * TCONF on its own once it sees STATX_WRITE_ATOMIC missing.
-		 */
 		tst_res(TINFO,
 			"%s has no atomic write support; relying on XFS's software (CoW-based, reflink) atomic writes instead (requires Linux v6.16+)",
 			tst_device->dev);
@@ -322,7 +283,6 @@ static struct tst_test test = {
 	.min_kver = "6.13",
 	.needs_root = 1,
 	.needs_device = 1,
-	.needs_tmpdir = 1,
 	.mntpoint = MNTPOINT,
 	.bufs = (struct tst_buffers []) {
 		{&buff, .size = sizeof(*buff)},

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
