Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B1BC61DC2
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787730806; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RgtPza9oAWxQTLH7iI31rzSYaoLRRiy4Ka07tbRGDW0=;
 b=Eae9fbaMJ6e8xHcm0ySZvd5OIYEw6jzYK9UW6JhOTJT6S3l1NGw5bMP/czVJqnFILdqJb
 bkJDRP7jAO6HG7hokuOL7q3Y9sbKl093iTWE/+5KovjZ8EQpuz0CAi9rbggPu/iKmd5+gUS
 8LPk+g5mQRvmq0vapMeMW3aJTwWAFhQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EF463CC17D
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:53:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB1613CA166
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:53:04 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 040531A0092D
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:53:03 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a3e145e1bfso896598a12.1
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787730783; x=1788335583; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dW3uEXkOjQzdedVLEQLR7MoaSIGqCq8xnwAiBYq9aGU=;
 b=NGamUiSlVzLukP7Kn83xk5Xf1K+pLvWFn3fQ1s4bEOB4MhZclQYJ+/eFvVDo2rVwu3
 +7Sby52C7ftYnrnlBMlZ5FGgn+rJ2q5arE/2McUnjjaaR7sXcY/Iq18TEUIIcUuvhfnv
 lOmuHTMlxAGT44V7ZDJxTay4eFn4rdalmj542DpnqHPSZB/SNW71Yvgq1dkoWbmRGqGQ
 DhdMhdtyI5jXtlct1mj059+Y2U+MIfmEPwgM4Zt0XCGQPqo01KySSexEYqLCOzdEzSLu
 8/8o8lJTuLfy8FCm9d4QFSEOdWIOljW3UhbGDifFlBFGAOU7qFjYIXc5TA1BITXFy6h2
 nktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730783; x=1788335583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dW3uEXkOjQzdedVLEQLR7MoaSIGqCq8xnwAiBYq9aGU=;
 b=mE69BCdo0BUad4CLIRvA7xnedamao9B9l0xbIIkiHiXMMWXioIUcWvtTeXhEDQO08A
 SoRrdP08jd39BxQ1YuvTGp5Xp7qzDsaR+bCkdflmA/3ingSdblZlHJLuFJSp8/pzWhcG
 aMkytkyHZwcdgjpxkuJf6+dhMiWjsb2DMi2TylFcWK2LrwHs/M/QYCy60TkxDhqHMD1T
 3t5xgQyEDzm/Z/bSfhVUYIaZj8XV6GNzpMFdZGHzvuKPQ3LOmXqUrMCVaZm82dP0FStt
 x6fReBScat6E0AvGPSTXJvVrElqEJBUjsjQbtnGbo82LDOiD3sFvmNHzVb16GvKtsVaN
 Mbaw==
X-Gm-Message-State: AFuF++nqWRQjILYNArtVVRIhu2rMuenfxzB5RKU74FeTXAEzdViYQyIW
 GcxfJXIroaB4gWctQny/9dwx2b7hC6I2LVNbo6hz+bwYDnIEgb6CfCAgstO9W2x6IuxrDWRnWv8
 XQvg=
X-Gm-Gg: AR+sD11zNHH9i5h5wNFQk0nIDy3+aBTdYwh9C0VEXjvor+0h1hjLmY7Gz6qceMFLYjY
 FOqwzA1nyBxmTuR+XM2P6Oech5Ri4stbKxQWOmVGoLigKytZzawBXEOxArECucy5+YLDRFlIt3x
 Q6f3SZEmCquukenksecgUGe19U3B4zpQrcRjtwkJH+IYu86d+3qgyQiw272w1BZoyw2z/qoUL5+
 ZrA7hgkc3QWzEUqKS6nuBGkEglc7p2LcRB+h27mQGyjBw/nUrPaF7Sf+I3EcEtMKdkcJxxZ758E
 BK/cKFRusV/RHi1/aVtQGbpWjOzEYFKPDeDXzE31dPslV/du5vPh4CknGZs+eRqtFsm51r5j1Zo
 FpCODGUL+mPz24+h30kKjNFQszDUBAc04fEQB9Y/aYkcNwhxgOg+oALED6rZMn+08TH7v06swkV
 4+x9zk8QKDnFPNJFelkBgiVrWe46kZz+RWkN+yNGCvImRQGvZSQcYEj9uDeLgoWM/2USd5Fm6+S
 nueAPc3fTVcSC19G9xYGzR5iSkl8QRER8agWysJIoo=
X-Received: by 2002:a05:6402:2804:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a5df5af56bmr5932197a12.1.1787730783267; 
 Wed, 26 Aug 2026 00:53:03 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6a5deae5064sm3621939a12.27.2026.08.26.00.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:53:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 26 Aug 2026 07:52:44 +0000
Message-ID: <20260826075301.10826-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821013917.28499-1-wegao@suse.com>
References: <20260821013917.28499-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] shmctl03: Fix 32-bit compat mode failure
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 64-bit kernels, the default shmmax and shmall values often
exceed the range of a 32-bit unsigned long or are clipped
differently by the kernel's compat syscall layer than they
appear in /proc.

Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Wei Gao <wegao@suse.com>
---
v7->v8:
- Improving and Shortening the Commit Message.
- Renaming the Assert Flag: Renamed TST_ASSERT_BITWISE to TST_ASSERT_TRUNC_32BIT.

 include/tst_assert.h                        | 42 ++++++++++++++++++---
 lib/tst_assert.c                            | 27 ++++++++++---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 17 +++++++--
 3 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..045942b1b 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,46 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
-/*
- * Same as tst_assert_int() but for unsigned long.
+/**
+ * TST_ASSERT_SATURATED_INT - Clamp the sysfs/procfs value to INT_MAX.
+ *
+ * If this flag is set and the value read from the sysfs/procfs file exceeds
+ * INT_MAX, the compared value is clamped (saturated) to INT_MAX.
+ */
+#define TST_ASSERT_SATURATED_INT   0x01
+
+/**
+ * TST_ASSERT_TRUNC_32BIT - Keep only the lower 32 bits of the read value.
+ *
+ * If this flag is set, only the low 32 bits of the value read from the
+ * sysfs/procfs file are compared.
+ */
+#define TST_ASSERT_TRUNC_32BIT     0x02
+
+/**
+ * tst_assert_ulong() - Assert that an unsigned long value in a file matches.
+ * @file: The source file of the assertion (usually __FILE__).
+ * @lineno: The source line number of the assertion (usually __LINE__).
+ * @path: Path to the sysfs or procfs file to read from.
+ * @val: The expected unsigned long value to compare against.
+ * @flags: Bitwise flags controlling how the read value is processed.
+ *         Supported flags:
+ *         - %TST_ASSERT_SATURATED_INT: Clamps the value at %INT_MAX if it
+ *           exceeds it.
+ *         - %TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the
+ *           read value, truncating any higher bits.
+ *         - %0: Direct comparison without any adjustment.
+ *
+ * This function reads an integer value from the file specified by @path
+ * and compares it with @val. It allows handling of 32-bit compat mode
+ * truncation/clamping on 64-bit systems via @flags.
  */
 void tst_assert_ulong(const char *file, const int lineno,
-                      const char *path, unsigned long val);
+                      const char *path, unsigned long val, int flags);
 
-#define TST_ASSERT_ULONG(path, val) \
-	tst_assert_ulong(__FILE__, __LINE__, path, val)
+#define TST_ASSERT_ULONG(path, val, ...) \
+	tst_assert_ulong(__FILE__, __LINE__, path, val, \
+		TST_2_(dummy, ##__VA_ARGS__, 0))
 
 /*
  * Asserts that integer value stored in the prefix field of file pointed by path
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index b68bd5d39..9a606d863 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
 #include <stdio.h>
+#include <limits.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_assert.h"
 #include "tst_test.h"
@@ -23,18 +24,32 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
-void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+void tst_assert_ulong(const char *file, const int lineno, const char *path,
+		      unsigned long val, int flags)
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
diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 9e1c2f099..0ac3f45c5 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -30,9 +30,20 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
-	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
-	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
+	if (tst_is_compat_mode()) {
+		/*
+		 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
+		 * compat syscall, while shmmni and shmall are truncated
+		 * to 32-bit.
+		 */
+		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, TST_ASSERT_SATURATED_INT);
+		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, TST_ASSERT_TRUNC_32BIT);
+		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, TST_ASSERT_TRUNC_32BIT);
+	} else {
+		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
+		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
+		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
+	}
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
