Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE8E64007
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 06:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776061231; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VQU2VIJL67B/3Xq9XhDDWMZU02mQXWBE01Vs+QjRDuc=;
 b=MNB0uWa0DZ0XpHxHX7TtYOaGhHNcgFivpxNh4iKPasp5oBLJz/qA6sU/+tXUwOA1a7a6z
 EddCQm2VQh6mpYTopp+XmJF2Zv8CRNTtmbUZfMSf/LqmfPTvnQoTH2v5X4r7cJijJlZ2tlH
 9svef9AjYQKmNHetqrMKSSVj3ySXZOw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72EE63E2138
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 08:20:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E19523DC6D1
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 08:20:06 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB98C60011F
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 08:20:05 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso37851695e9.3
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776061205; x=1776666005; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Fi1tV/kcSvfaPXhGwMCK1pn47NjYCFUWkTRTcNfbxE=;
 b=cpNYBZsZIXFckazmGQwbhjFRYef8zNNy4ZK03pp4fdwGFQZZwrCrAG5yKBgQXXcvkA
 1GOrHVRAGGlugt/lg7GaeihC/bFs89T8J8EVqASTVJjfUVQXkP6xnpzW2AGjq/nfXpSW
 b4RFVUUijDb3HkdxWsO2xE/ZK7Pxrqknpe+xQ1EQyWqje0cSY6dZufLYKlZPkMyHlZRU
 4SzjsJQCvN+PN+CyMJlBq+wM9X8SKpc7KV2d/RUFfSRIIBZZnVjDNKh7IGHEXfNLXaKT
 4dYwm0Z4iBFvcxF+4P/wNBzMYZQUankJ1PKFoTPcF2lIM4duVzRtFP3yTou84Qh6HPxx
 Byyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776061205; x=1776666005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Fi1tV/kcSvfaPXhGwMCK1pn47NjYCFUWkTRTcNfbxE=;
 b=pRfc3mcLkGisfe2DQ1hIfD7k3elmmEwYZsEfPNAMV1TXBrxg5AtJUsTTbjo7aW3e/l
 v0128oGWc/qHTUlO/6e3/kn88dDqdyFcf3jnP+zcR1aRZZ9bgxsl+vV+0+yrb+a4qk5v
 mvDB78yZAtlxNsJxm01coQBvFPGWaqb4aenl4VTeZnRwClrHzdYwdp8BiGuTtl6T6Xqt
 AkzDQzxXcWgbDsdy0hPJKOfR5yIWfBsf0l3wTLlauD0mJktqQvQFCUMUWHne+vtjLuzg
 7RpoV3Gu2aBVizdyB4U7KfBWM0S4rptMKiI5IY1GYZ0IWH+irGKAetw25b7WiLHMi0FR
 Cb8Q==
X-Gm-Message-State: AOJu0Ywz50sQvWzQFu2PYsxDLsLtBHvrm/mr58vdZBDQYHLI+glcIEcg
 zSFSMrNn9LpWKVaxQxqPVzqQdqcIt3I5+slKjceDMuwOlWPJu8yY8YLJ+xvsD/1MfkSIyUWwg0G
 ODVE=
X-Gm-Gg: AeBDiesw21RRDv5nLGLqonvEH8YZLodId5zeNPxMFVB5WvywN1Cfnd92chg7wCIq9zX
 LLfzUVdr7bEXE3lpPA8BhZXhy4DHDEq5i5zsdnhl8KONwhuW0y/77TsjqZ5B41wUcjuYPnZkb84
 YDWHQHdD2mzUNqnxXb4KXMzyAsLKBUSbpp5ibNYP3iUYA8bBFRe2qKIVANllIRPkkKW5jSsNu8o
 8Gk5uLUl6yaDva2vDelYo81M4eKQ8HVzr98RQVzs1l/vnZx6/S/kOqbNWZH4PAWP9vaUmiiel20
 IY+YU98ZYhArvFtQ99GHvn/svApEVNfZiu8Fu3Pm2z+79hqMseu0BP8skQGG2WMDei45+PGyH0F
 uI+o/Mqvlwy3ORGULk7eUGXApv49VEyy5JAQjtu9TXm3SRxeetnrfHTkHAJQCaW0MCiiIcHdb+M
 IBWy9o2DVCI/k=
X-Received: by 2002:a05:600c:890e:b0:485:3dfc:569 with SMTP id
 5b1f17b1804b1-488d683665dmr106013315e9.16.1776061204807; 
 Sun, 12 Apr 2026 23:20:04 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488d5380feesm332418555e9.9.2026.04.12.23.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 23:20:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 13 Apr 2026 06:19:53 +0000
Message-ID: <20260413062002.20324-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407092616.15563-1-wegao@suse.com>
References: <20260407092616.15563-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] shmctl03: Fix 32-bit compat mode failure by
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
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/tst_assert.h                          | 10 ++++---
 lib/tst_assert.c                              | 26 ++++++++++++++-----
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 12 ++++++---
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..5b3bd0e12 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,18 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
+#define TST_ASSERT_SATURATED_INT   0x01
+#define TST_ASSERT_SATURATED_ULONG 0x02
+#define TST_ASSERT_BITWISE         0x04
+
 /*
  * Same as tst_assert_int() but for unsigned long.
  */
 void tst_assert_ulong(const char *file, const int lineno,
-                      const char *path, unsigned long val);
+                      const char *path, unsigned long val, int flags);
 
-#define TST_ASSERT_ULONG(path, val) \
-	tst_assert_ulong(__FILE__, __LINE__, path, val)
+#define TST_ASSERT_ULONG(path, val, ...) \
+	tst_assert_ulong(__FILE__, __LINE__, path, val, (0, ##__VA_ARGS__))
 
 /*
  * Asserts that integer value stored in the prefix field of file pointed by path
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index b68bd5d39..1598244c0 100644
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
@@ -23,18 +24,31 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
-void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+void tst_assert_ulong(const char *file, const int lineno, const char *path,
+			unsigned long val, int flags)
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
+		expected_val = (sys_val_64 > (unsigned long long)INT_MAX) ? (unsigned long)INT_MAX : (unsigned long)sys_val_64;
+	} else if (flags & TST_ASSERT_SATURATED_ULONG) {
+		expected_val = (sys_val_64 > (unsigned long long)UINT_MAX) ? (unsigned long)UINT_MAX : (unsigned long)sys_val_64;
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
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index a1f53e7c1..6d073789c 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -30,9 +30,15 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
+	if (tst_is_compat_mode()) {
+		TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax, TST_ASSERT_SATURATED_INT);
+		TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni, TST_ASSERT_BITWISE);
+		TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall, TST_ASSERT_BITWISE);
+	} else {
+		TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
+		TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
+		TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
+	}
 }
 
 static struct tst_test test = {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
