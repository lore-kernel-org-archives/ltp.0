Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FB2C624D3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 03:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788406390; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lFjQYURBQADrOVqncKsHZ6K9fBoWVjRdp8oc2R7rknM=;
 b=FX+E7qrutnwczfW+N3xSxlN8mPdtj3bO5h7NCS6besb+CxDsJUdjA3bFPkQU8m0je05on
 Xd87PjXiPtivO4NlHxgebsuenu5JGeO69z8H7U0a96+nSlu0wZBzNanhY6dhK1eqtNJxBDf
 xWSBbx1nN5DudtAVafF/UZe91mORY90=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF423E986F
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 05:33:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 019583E93C4
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 05:32:32 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD4FE600847
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 05:32:31 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so14883375e9.0
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788406351; x=1789011151; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fh8mvP4bCzgNbfKXYxB6NtxjnWkLtIrRdqpDKllN53E=;
 b=Z5CSDTtkDwAYtcTJjE8tezdMYYXI+sEUn+rcFpbpaX7+zWfcb0W9SbUJR4M/dNxSD1
 EBKYXbng2nOK7Vy2yXU2pla7e4lAhaJEcTjEHKhxCCmzYIWXfQVpZ7vBKtJMqHU5vVhf
 d5bN/AJTBNzFR1ckcaeSmdIu5u+pwoFSULNrXuPaWFHNvSECD8p3ERoOvhz4BoUfbS91
 IhqVCUz+1bT37HSlT00jN6DkG9H1Ip7dVg9YSLPywgBsoLcmQ1ubbykLXmmY3Xt1Zxy9
 uJdQ6KFv2IPRNISfNGqpsPILN++qw8MSe0Uq8SLEsiiq3vSCeSaHIsyiKociVccMgjW4
 YOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406351; x=1789011151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fh8mvP4bCzgNbfKXYxB6NtxjnWkLtIrRdqpDKllN53E=;
 b=VjtGoz03IoR/z4Tl7FeHYsjgd3OyQDO2GX87r2VPffgsGIK6kQOCgO9df20/ghEeh7
 e9CozJzK+hLWQu1CE5LEg6n/3lPPesIQvamT8cVhdyeAiVXdPhUuUS4guNkvp/i9PP9W
 IBf4zh2aHP182HmvZwNL0YgUbzOGv/iZX91p4g7LiJ+kJMcGNaIE2P3tEiEhqcx8lxLJ
 mBuYhMcWrJ0Xhj0EL82VIr+3o4yJLbAZblcCqND6FbMW7P4W9xc2QGgS2GUqgEJwiAvN
 76GAvkWbGO7W4xR6Cffz6nC+diK40M9zbrVM8hfVH9a8zOLeycaQl3+Ok2ihj71O1OJR
 6jlQ==
X-Gm-Message-State: AFuF++mQOROjISODWTt82MN4vOzphvOdgNa2TcdVdwzfQgCfct+zgS/p
 OJebHkhmRr52L0XPpQ5qrbKH5QwGXQ8sgJgkGFH3DkndW6SReXelZV6btttS4JdOVM+UjpXijkP
 Jv3M=
X-Gm-Gg: AYBFou1wqWgzByr364tDHIti6ZSUjd4V1/2VUFJeh/4TNuy0+/bITKRKLiOACoiVpHx
 pICN2pmQwSpn2Uh46XIhKwLOX3PSV6X+IC4VV3W7brHXZEFb1HlbcNtJ7DBfO0+A89VxJlztKZY
 iI9Bk933y/67CITh8wIHa/FiKABntNCbVrLGecUO99B8/25XGIDZ4Oj84waa6g5NIaeCpQfAOOj
 KY56lzDwejZrAVLfEFaSkn7zQ7Hk6d7UEtavqx2UyPTKwa/BgKfdJxJGKqhcGPi27jLm3Z7woiP
 iUV1+coT0tpPsWFf1/cLfS7AIHyMWy9So9WCH8efXMI2Ya/s7oLC5Gg0sM0Arn887AH9bcCI0oJ
 S6v49Ynp6R5VLynTugjQ9ipH+Db6QEN6z6xfdQlds3T9PgN006h7E0xQqTVJH5TB+dgZXbG5l4U
 8pPbFPYih1aYiANWJor9rNtmaY6476TFQOwJ/nfDINvIf5g7km2/HGb0DXXf+dH2duGi/hhASnp
 MisBm0IGcjbDowJKvcl5vsNSeKtli+t
X-Received: by 2002:a05:600c:8a17:20b0:49c:d818:8771 with SMTP id
 5b1f17b1804b1-49ce5808d4dmr129867355e9.7.1788406351139; 
 Wed, 02 Sep 2026 20:32:31 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49ce58da3acsm191284315e9.0.2026.09.02.20.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 20:32:30 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 03:32:13 +0000
Message-ID: <20260903033219.4747-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903033219.4747-1-wegao@suse.com>
References: <20260903033219.4747-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/2] lib: Extend tst_assert_ulong() with enum flags
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

Introduce enum tst_assert_flags (including TST_ASSERT_SATURATED_INT and
TST_ASSERT_TRUNC_32BIT) to tst_assert_ulong(). This enables type-safe
handling of 32-bit compat-mode truncation and clamping behaviors on
64-bit kernels when verifying sysfs/procfs limits.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_assert.h | 34 +++++++++++++++++++++++++++++-----
 lib/tst_assert.c     | 26 ++++++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..c4112a237 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,38 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
-/*
- * Same as tst_assert_int() but for unsigned long.
+/**
+ * enum tst_assert_flags - Bitwise flags for tst_assert_ulong().
+ *
+ * @TST_ASSERT_SATURATED_INT: Clamps the value at %INT_MAX if it exceeds it.
+ * @TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the read value,
+ *                          truncating any higher bits.
+ */
+enum tst_assert_flags {
+	TST_ASSERT_SATURATED_INT = 1,
+	TST_ASSERT_TRUNC_32BIT   = 2,
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
+		TST_2_(dummy, ##__VA_ARGS__, 0))
 
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
