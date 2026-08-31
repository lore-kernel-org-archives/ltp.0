Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212EC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788164244; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8Xtf/RDM/a+Pb2zeaJuqE84HU6Hj3K81aJCWVEMT7BQ=;
 b=GkNFpEBvFMFhT98BOgNoWXIHSt9HsiGABcPiV64G7ARk9tGqjRFZeGkANbeJriFNuzck/
 UfApREiT2NcpeYU72eDX/kupW5Xe5x24+FyG3WD+kyp1XDRkjhw47ujFCem8vP/C4FKHAG6
 wD7plCcFEwicyQkt/WAK8wfiu7WcWiM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B54FE3E5B5B
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:17:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59F183C064D
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:16:45 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC4BA1A000A2
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:16:44 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so150327f8f.2
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788164204; x=1788769004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBPrLsNwbml6IMuYolk3kBz83hSVmy5QOrZoVGXbaLE=;
 b=DH1zOcsakrz2MiMfzIoxCsNmNEmZSf+io/3hKavFOV5TqPOg7RsgHdnyFS62IIubY6
 rxTHmo/AWyZErrbz5bilFiGjAqj7yLVCUF8GSI67xedh1VanfNe8GbpXK+gBubvhjF4X
 xwmOpj3TDdSDaRiddJHjUOXgwSbaecQPIS0thjr2sptbaekYQkWApNv2bHFN4xLQDWx5
 kJnR2PqCDCblvL/MPUiL32kHkIGJlfAAk39t0taIvUGqn5/7rCPSknHM0m9vIBLV1SPO
 ydc9r2Mvce8ibUC+yK1necfTwFIv+FeS2y9rW7hvaL7ad5pys46O8KhTaOFwfp9Mstx3
 hIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164204; x=1788769004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eBPrLsNwbml6IMuYolk3kBz83hSVmy5QOrZoVGXbaLE=;
 b=h6A4GdQd0h4JiOSFMIAqAdO/qZYQbCsFOOfuo2QSLq1AbdKMywDlfe5YVDEpZaurx4
 hyPjMim20Yulz/F8OdK2oMrkBSNURg/Z85yBau/qIzX8pGgT1y7YbeaSWjFpTOTaBDYl
 etlwJEyQveRNGdFaKRKsqci5EqXH2JGaddDQFf9ZCdHo2Y4E20i3dXyw4vh7sDJL/agB
 lUxoFCSxSFNyly38SL0zteJK60qh71lIhSlsjoHOvg9Oc6wzlMXAn4RCXNLWrZCiKztG
 dkUcnhKMk661SU7Bq8kLTO+XhbXPEnbnpJ7OSlSzvjKvVxhCgGHST2gQ06WnNwxZXakt
 XjiQ==
X-Gm-Message-State: AFuF++n9ipNn/eswzqAbkK3h/qxmLTZnQn35NgoupcoXLrutGySUH7S4
 iHXWttDn7AgJgSK018+FRs0xo129fCn1P/qc4HVJb0XYGyJwNzqwdbGCBLJyeFufZibAK+e00g/
 vrkg=
X-Gm-Gg: AYBFou1YjhgwwGEPah0ucdt5yjZR5J5BnlZjfUCGaGtZC6uCG+uHeX8uLobsZBWuJO8
 86g+J8yQmIv1osVd7xEnaeOeAzuWnts5WMYqF7tlB6anwGEVaoBsL/oQeNPhWonp337PXO5pDBt
 /07cwi7M0lnD29XkwpR8lTfrEGelgBn/O+nMNDmd5cw/r6ht13N9G389Pyyve7C3E8TfVfSYXv2
 vhy0d7veCQA9J3Nzc7vnL57AfPo4aoEM6nDm14HXs5H+FFkw2k+bLSdhY/BNMhdadtzgc9/CWi9
 c2qdJKbEpNE3KowbCOdN/ykjtu1hX2yjynheQesHEJ+0sAG/sJ8XnImKtXZP6G7HeXaqjI8Zvon
 sVc3I3Qn6Ub8TRXlAqjhuzJ3J9NKN7VqDMFMwIbUv2E7r0vY5m54EofnaPz1f+CeFXy07eF+xfL
 3d9d10gz4atg8qVACn+fFEDlrx++XwzS9T/cn2lD8bRsA6ZVpuW3KnQPWJIhU5K/FJM3Z6YPf55
 DT5/Ei3UAEfXGkHfsPWBj91b3EmhEen937SzTtUMy8=
X-Received: by 2002:a5d:5f8d:0:b0:484:3310:f39b with SMTP id
 ffacd0b85a97d-4843310f476mr20321457f8f.28.1788164203998; 
 Mon, 31 Aug 2026 01:16:43 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-482fbab5a2csm18862096f8f.4.2026.08.31.01.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:16:43 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 08:16:33 +0000
Message-ID: <20260831081638.19539-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081638.19539-1-wegao@suse.com>
References: <20260831081638.19539-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/2] lib: Extend tst_assert_ulong() with enum flags
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Introduce enum tst_assert_flags (including TST_ASSERT_NONE,
TST_ASSERT_SATURATED_INT, and TST_ASSERT_TRUNC_32BIT) to
tst_assert_ulong(). This enables type-safe handling of 32-bit
compat-mode truncation and clamping behaviors on 64-bit kernels
when verifying sysfs/procfs limits.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_assert.h | 36 +++++++++++++++++++++++++++++++-----
 lib/tst_assert.c     | 26 ++++++++++++++++++++------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..9154b7249 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,40 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
-/*
- * Same as tst_assert_int() but for unsigned long.
+/**
+ * enum tst_assert_flags - Flags for tst_assert_ulong().
+ *
+ * @TST_ASSERT_NONE: No flags, default direct comparison.
+ * @TST_ASSERT_SATURATED_INT: Clamps the value at %INT_MAX if it exceeds it.
+ * @TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the read value,
+ *                          truncating any higher bits.
+ */
+enum tst_assert_flags {
+	TST_ASSERT_NONE          = 0x00,
+	TST_ASSERT_SATURATED_INT = 0x01,
+	TST_ASSERT_TRUNC_32BIT   = 0x02,
+};
+
+/**
+ * tst_assert_ulong() - Assert that an unsigned long value in a file matches.
+ * @file: The source file of the assertion (usually __FILE__).
+ * @lineno: The source line number of the assertion (usually __LINE__).
+ * @path: Path to the sysfs or procfs file to read from.
+ * @val: The expected unsigned long value to compare against.
+ * @flags: Bitwise flags controlling how the read value is processed.
+ *         See &enum tst_assert_flags.
+ *
+ * This function reads an integer value from the file specified by @path
+ * and compares it with @val. It allows handling of 32-bit compat mode
+ * truncation/clamping on 64-bit systems via @flags.
  */
 void tst_assert_ulong(const char *file, const int lineno,
-                      const char *path, unsigned long val);
+                      const char *path, unsigned long val,
+                      enum tst_assert_flags flags);
 
-#define TST_ASSERT_ULONG(path, val) \
-	tst_assert_ulong(__FILE__, __LINE__, path, val)
+#define TST_ASSERT_ULONG(path, val, ...) \
+	tst_assert_ulong(__FILE__, __LINE__, path, val, \
+		TST_2_(dummy, ##__VA_ARGS__, TST_ASSERT_NONE))
 
 /*
  * Asserts that integer value stored in the prefix field of file pointed by path
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index b68bd5d39..04241d31b 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -23,18 +23,32 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
-void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+void tst_assert_ulong(const char *file, const int lineno, const char *path,
+		      unsigned long val, enum tst_assert_flags flags)
 {
-	unsigned long sys_val;
-
-	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
+	unsigned long long sys_val_64;
+	unsigned long expected_val;
+
+	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);
+
+	if (flags & TST_ASSERT_SATURATED_INT) {
+		if (sys_val_64 > (unsigned long long)INT_MAX)
+			expected_val = (unsigned long)INT_MAX;
+		else
+			expected_val = (unsigned long)sys_val_64;
+	} else if (flags & TST_ASSERT_TRUNC_32BIT) {
+		expected_val = (unsigned long)(sys_val_64 & 0xFFFFFFFFULL);
+	} else {
+		expected_val = (unsigned long)sys_val_64;
+	}
 
-	if (val == sys_val) {
+	if (val == expected_val) {
 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
 		return;
 	}
 
-	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
+	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu (raw: %llu)",
+		path, val, expected_val, sys_val_64);
 }
 
 void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
