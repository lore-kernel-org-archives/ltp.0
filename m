Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA24C5DF81
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787276383; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pT7ilLPd+hadjAHR6shgTwWjOWxMGsibcgPf1ZPny2A=;
 b=Y7xuA04GUwINjS0FnU6lMzcfmiEjaf1uOklC6bkug8C1YYPCQVBO25ddOAMn0lGOrgm0R
 v+kmJ5gY1Gw3zm0/idtwAFUhzUhy+tWT4xKsB1NpDdOR1Pg3gFX+P6d0BnxudahbWnJgh/5
 rC2cSDWZhmLJGmUNriljeRbVtYgGZsw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DD1D3CFC0D
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 03:39:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC403C8679
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 03:39:23 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B8861A0091F
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 03:39:21 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso270678166b.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787276361; x=1787881161; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pul14heCjTv7XvkKLp7E2hd6e0ANimTjgo+FihSsBIE=;
 b=SnAUCEPyJeUZv8STyO4pF8CbKJwBvHDUx7Fh1plkIr7K9j4lmCXk3uUSoOslMQEoaE
 pMd4ve3Yseu7K4qiTDmlNO4mAKXKd7AG7BDRuOEFfRwpVxP0OmoSNVqYGk2RsVlj2Uz7
 oQzlKcwEOdBifyLu8IQ0YpaIJxLHObPgDFua2BGRxGNyxuHdUB1dfwbz/8ioCu+jvuG6
 S1fzf82ieN6BHvg0uOX1MJfb0rq9+R3yoXTYJdY9uCKsaOMUydswFq6xf+Sto/0i9jyJ
 OFacgkVklM4VVe921PBKaAtDmxrs3XD+Uv1H/jWmE3/JTLYGNFqcAJgKzw7v5z7+3jib
 t4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787276361; x=1787881161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pul14heCjTv7XvkKLp7E2hd6e0ANimTjgo+FihSsBIE=;
 b=Q+TM2cgZ/PekECQg/McnRFqyrl3nGwEwVOKJ/ItylLtuXAFYZCpMVdFpczUMeKqenf
 xNfa08b9tNlWnBM4C91v2ILNkm9MVtQij7SkYKpKWupf8nblsJjBNJ1tkkc8plma4wwu
 SqghkWAY3doZkyFtns233KFpNHI9RPibuYslg2XmqNd6LJBMkSdepvz5mfdqmbIukaq4
 TzklMAK3lSDlz8HNr5AnSL9ok5s7yPZETvSw+T74lNo399Kbay4BhH6NyuyGHzCJ7FYi
 nS3VvUn5nhhSOhy+uMZrWFwccoYEM6fOw7/AvTBdC8MgSMsZFdK+H9DjfAi764Eiiuwo
 T4+g==
X-Gm-Message-State: AOJu0YzP/8cQO9zja+2amshvW7BgiI9pEH0F36wYkC1y8gNfOSlA8u3y
 Nu3VNf9vFs2DZcXXq53phQkl2ITxWQGYjaCZ1fktzaS+Sn42weAQ/fQ6PnCAvu7anX0LRJPQj0C
 ilqs=
X-Gm-Gg: AR+sD123dDQriA4w54pQPJ8zou6HSsbc3W7/zUl+VP1ymF+oqCgJrhd/lNJFQcL7P/9
 /FURE5L6EcPx7UXourfV5P3NbCcWKGFFZF/q01HauWouZq+XCLhIEG8Huk6rrgBGq+hIemhqC+G
 WXYv6D4OMzng0pUsB2N0Fv6me6BTMem2unUT21hlIYpsCabaVU6OK6RGZxKIlMkScGZjNuH0VDF
 jJSvi/zxH5S4xPBdDA5rt/H4qYU7amFMWyr7JoknQtdSh6UM9FI84K2OYdGQDDJwpPDin59q2PX
 ooA9yYJoKqtv61O0YMU5o8dYasW4UvPJP3ovrDTCoJzg7PTPMBGs+ATBq6KMZMmTQGtrxU1L0o9
 qrhvb4PnoRrew6mIqthGwF2ilN6cuCA/U1j5Wt9YJiuXJcwYu5IhGkyGVxYjijAdg3bIhjKFEOr
 a+OrUBuiuH/CmiSvIi7KYusb79SCWh1MixUsPn3XRfglNABOhA85c9+hVfjE2eT/lytZBCHMiPU
 /XdKfATqwIosSFPWJx35BAbmD+i7F0x
X-Received: by 2002:a17:906:fe0e:b0:c15:c323:36e5 with SMTP id
 a640c23a62f3a-c244d7194bfmr729265066b.10.1787276361276; 
 Thu, 20 Aug 2026 18:39:21 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-c2459223816sm239575866b.57.2026.08.20.18.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 18:39:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 21 Aug 2026 01:39:08 +0000
Message-ID: <20260821013917.28499-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819083907.26866-1-wegao@suse.com>
References: <20260819083907.26866-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] shmctl03: Fix 32-bit compat mode failure by
 adjusting comparisons for compat mode truncation
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

On 64-bit kernels, the default shmmax and shmall values often exceed
the range of a 32-bit unsigned long or are clipped differently by the
kernel's compat syscall layer than they appear in /proc.

Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v6->v7:
- kernel-doc for tst_assert_ulong

 include/tst_assert.h                        | 42 ++++++++++++++++++---
 lib/tst_assert.c                            | 27 ++++++++++---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 17 +++++++--
 3 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..3cc0d334d 100644
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
+ * TST_ASSERT_BITWISE - Keep only the lower 32 bits of the read value.
+ *
+ * If this flag is set, only the low 32 bits of the value read from the
+ * sysfs/procfs file are compared.
+ */
+#define TST_ASSERT_BITWISE         0x02
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
+ *         - %TST_ASSERT_BITWISE: Keeps only the low 32 bits of the read value,
+ *           truncating any higher bits.
+ *         - %0: Direct comparison without any adjustment.
+ *
+ * This function reads an integer value from the file specified by @path and compares
+ * it with @val. It allows handling of 32-bit compat mode truncation/clamping on
+ * 64-bit systems via @flags.
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
index b68bd5d39..fd651f53a 100644
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
+	} else if (flags & TST_ASSERT_BITWISE) {
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
index 9e1c2f099..dfe5f17e3 100644
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
+		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, TST_ASSERT_BITWISE);
+		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, TST_ASSERT_BITWISE);
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
