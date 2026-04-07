Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8782CEDB7DC
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775554010; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=THaxjMp+CXUBoY964QBh2dkK/KojtxVr2y2DgMZU8jc=;
 b=KnYmjqCHFo3zHrJfPep/Aq0RklHC71nHwAWppXn1gguynu2dZJa9tQ3rJNaSaCBQquZz4
 5DRGTOLDOb9X2NW8cbV758kayhb6ttc8/vOxWCpkmbjxT1YaGdRntEx2XGLCj29OBgI5SwZ
 2J7YsAbMwTsrE60fA8iugVbEPHstwAc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3C973E2148
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:26:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEC413DB86B
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 11:26:27 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 376EB200769
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 11:26:26 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d17bb1c1dso4168169f8f.2
 for <ltp@lists.linux.it>; Tue, 07 Apr 2026 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775553985; x=1776158785; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ecWWtRfufrYJvrAYYO9YkKvDdFLnL/uRBSRp1gNGdT8=;
 b=gZ1DcNHlbprQsnCCozfSM+3DxGIZTES39K6W9ejC8A9OOtqZ049SyXdhwCjgslr07q
 QfvMGdAcC5oBTlG+9toI/mz0Ym8Tn3Fr19QVtDrgW9MjOMUFylwBDTbYc/ewGCVNJRMm
 r9u22MVsnhNwfdeX3drXpRgs/wlVsWeFY9cNxwu+AbNPk5icNKA44vImOtamCFft01N7
 ZyG23ZPbvArDGttRhdllL6++N7F64vwIW9uuZJbtGsOOvSIrq6LOYCrN/t6d0IgehNjK
 lHvhIe0/DBVSDjqZ3lpnizMDT5mcD5ATOSTnYvmpiboXsGvoOhRmo7UbAooaPT1igxeB
 Ef8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775553985; x=1776158785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecWWtRfufrYJvrAYYO9YkKvDdFLnL/uRBSRp1gNGdT8=;
 b=FKNJNXNShnBlDCLbOtyKCmTa6+zE1TwmeRgEiVKEVz25ITSK54TTeRse/KSEppwm3c
 2EWgrLpcrvMqmr/98TcAkrlEnLRo7oeg3lRekW/bx5+wWz+T8U31BbIUkg8djNIxANGG
 bnF3RR3MO19mj0M1e0nQi/xsyU5dkp9IxRqaO81bpCP33waEQhVq9kqCT+QKLZtAtMP4
 H80NH6cEa1YNZhu7sNoTBy/kwqcgD7t/WL1wjnbjS46ibfWO0iTQxdZSZbFK5UBzFgWb
 j+afNtDQUbT3b0qt8VzqxDcr3CGTRoDVSpZyzWwnXaYs56TW3fsuZd/dF81TdxnQVwHy
 MtbA==
X-Gm-Message-State: AOJu0Yy8xs7Tu0i1O+3BrwKibKudkogiMWdEKxWcDuyfqr3LPu8TOn6T
 G4/pTJKfYEwRttowepPQYoX6VF8bJs4Q9bRB/X5Zi251WLYsoeeJcNgM2MGKgnGKe0z9KNBBD7N
 2788=
X-Gm-Gg: AeBDiesOemKaaA05SFhnSaf9FYQA3EqgL/oofwpAuD6YIQVfxmX1x6Q/pcQkMk9n2Xr
 xYkLuNds4Ic/PdxmyWrEo9Impb/qO60zuAvC5jXl3fAwYU9ghkIkO9mi5gYhsewmSqYsfIrIuf3
 yBp0rKk7y82eMowjIFbBx0w138C1ZtZkoAqBvP+8jR4ILh1Dxic4+Fn0dDYL2eemLnsbGYra+i+
 r00IiRzjrLP1p8jIc6G41T8izn7GpP7RU035kO7ahNRA+vV8BGfncUlaq1oXMVWKXrbqoiiTBwk
 lm8i1pL7PDjG55XdBoLwd3YrtronGM79dqDvHy+mFHO2/9wu0/eTUnr/lnHpEg78cHZYE9/Wy7+
 T7bViRIZaj4WHhOxl4w7P4Fe3+sztMihsUGTat9RmpLeobsNDKD1tTP8vdJiTdnxfPb1wJVjvFy
 vP+1PMpVKIPxk60DtI3uBt0Q==
X-Received: by 2002:a05:6000:40d9:b0:43d:4df5:3de with SMTP id
 ffacd0b85a97d-43d4df504d7mr491910f8f.31.1775553985189; 
 Tue, 07 Apr 2026 02:26:25 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43d1e1fe0b0sm49571118f8f.0.2026.04.07.02.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:26:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Apr 2026 09:26:11 +0000
Message-ID: <20260407092616.15563-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] shmctl03: Fix 32-bit compat mode failure by
 forcing limits
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
 include/tst_assert.h                          | 10 +++++---
 lib/tst_assert.c                              | 25 ++++++++++++++-----
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 12 ++++++---
 3 files changed, 35 insertions(+), 12 deletions(-)

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
index b68bd5d39..09d7d8a6f 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -23,18 +23,31 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
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
+		expected_val = (sys_val_64 > 2147483647ULL) ? 2147483647UL : (unsigned long)sys_val_64;
+	} else if (flags & TST_ASSERT_SATURATED_ULONG) {
+		expected_val = (sys_val_64 > 4294967295ULL) ? 4294967295UL : (unsigned long)sys_val_64;
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
