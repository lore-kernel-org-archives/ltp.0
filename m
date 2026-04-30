Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2658FF8864
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 03:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777520880; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0BDyr1MKism39JyWa+VOHAQAXMCJNkuTy/DCm2V841A=;
 b=PmaGQn15U/N8a0r7gf9+WwPLKI4u1KHK+Pll2zDhzGBZ5IC2j07FvxhLxpqWQ52xcvGUD
 pI/Q+jDIgwY26QVnwwmOjnTTO8OQ9/ak6KXNNrHrtAAD0PfKc2PS1DAnsXhEtP4wXl9u72i
 2+r/A+8PKRFLr3cjRwqekIxfyA1m5xo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E8AD3E929D
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 05:48:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD7853E1630
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 05:47:34 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5ECAF1000740
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 05:47:34 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so223913f8f.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 20:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777520853; x=1778125653; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9ANyz8nyqtDXFuJAYKKsaQDXzPVdfxC0VzaUiaG40E=;
 b=QfP8ydOTRY/6KO/VO4KIsSt+oSc9LzkaxqKg7IY4JQG3PCqRQKqMccXD/o7iycZ86X
 t7L9S5QIKn9TtllZH62nta1RLfkhsnfavVavfowN2y9wK0A7qz3ZrBfjYNj7IE0U4Bn2
 G+bwyrLwLuLvsI1lI5MlrjHfDTlfrho77yHADeQiqTgrKoIXWp8ctdhxQFPLvMwJj/26
 p4VfZJxNLgUdFEuaXBCzcN0kNMpwqQkGmLg3XtyckyzZn9tFyuVyurNaenFelB6BVbbw
 WBQsS3Ikcv67i5leWQ7UdkMQQQ6ZJy6QHfRzIWcSIEb7gsxz9JLkxZhTdBfzj707gUfw
 1gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777520853; x=1778125653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S9ANyz8nyqtDXFuJAYKKsaQDXzPVdfxC0VzaUiaG40E=;
 b=amj5zVX+wFB3JejlSfXd2VIdp6AXq33837WJOy57MPDvuUxCeO5+zOouUWRnt67fkF
 l2bG/Q+7Qt+sr/KalZkcHsEc/Nssd6p+EafRcH7FF/gvJ7rGHg5wDc6BynVRmxkQexCp
 a0VuKahvbTl/lz06eaCd84Ho5qdLHhvditqwF5b3RUXzOoke+Z4dkNDjTngrhq6DDLQp
 e2P5j4uk17Xa6rGIvmsM+1fb/L1kveSGscFSL4+3TneUw9Dct07JWZqSiOne8Cl267nU
 Gn8K824fIrfHxqqV/OW+7zQgPr+XfH1v9XKCkuszCZdRZAk4Tp3WT6gl8TS4MC0Iwx8K
 MyMA==
X-Gm-Message-State: AOJu0Yx4sEd8je19qmTfBYy6MS/bwbIMnshvuz10HoNuUOZRYfIGb0xH
 adpObcM2yNIWJ7GI67lHOBxVPz7lGsyYXvera8Rk2LLh8R+kgEnKWUntxB6FMRCQqrWlHm0wc1C
 7U4k=
X-Gm-Gg: AeBDietcwW2KFh9a6jggiGlKhGKS2lkYONFtG+sxhRp30SHk/k1tv2OXcvUIKi+CyIJ
 T7zS8o7sq0x/Mnk8FW09YPoMjAnQiGllsfAf3n6/THgce/sVyR5xTB4qoPMnrNXYjboTi2MU4nY
 j/I1uFsyJTvxkJRwmSlAuE95K9Q0EJ5jmUij4/uusbmx+jIQRRdXWV9e7HMzTzJkiMsRg0Q2+Qk
 W7AL6MZLBjZT5fIxwVTESBk5WRkrIGHjj5EJvmChQoigmb4DMUjNmkNH3l7IoPeds8K6lFzFccn
 hKzLqyWnx+dXBNrb5XbqKtK2X/LWSzUQ1V69tGaNAWf6CRce1j9IfAS86p0xLmezTkUFi+ZmII6
 4hTyHSfkDm5e68nA2/c05faAnTmq6CGTxIN6QErgtWIpHFaAFjWOB3KrqzblQzhxBkQYN9P38op
 ePbfPKdY2Lxhpj6DzImxnOyg==
X-Received: by 2002:a05:6000:2385:b0:43d:70de:1c68 with SMTP id
 ffacd0b85a97d-4493fa01907mr1570493f8f.30.1777520853362; 
 Wed, 29 Apr 2026 20:47:33 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-447b3d482d3sm9704239f8f.1.2026.04.29.20.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:47:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Apr 2026 03:47:16 +0000
Message-ID: <20260430034724.1628-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429111823.1046-1-wegao@suse.com>
References: <20260429111823.1046-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] shmctl03: Fix 32-bit compat mode failure by
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
 include/tst_assert.h                          |  9 ++++---
 lib/tst_assert.c                              | 27 ++++++++++++++-----
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 17 +++++++++---
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..2f1051270 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,17 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
+#define TST_ASSERT_SATURATED_INT   0x01
+#define TST_ASSERT_BITWISE         0x02
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
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index a1f53e7c1..e6c7a8027 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -30,9 +30,20 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
+	if (tst_is_compat_mode()) {
+		/*
+		 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
+		 * compat syscall, while shmmni and shmall are truncated
+		 * to 32-bit.
+		 */
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
