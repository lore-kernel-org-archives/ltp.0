Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3504FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777461532; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WjiPph2EUzVVIpfLMivP7TmBgtruamzumCvycr25/Uo=;
 b=h4JaBstRPbleQvU96XP2yWgKdSnyi/5PBM6lp8qKVo/8PDnAXUYW66r3NOF9PFJ4DZuT8
 sJYP7Pga2YvYw++PIfs/WvppfNzyyYuzqnMITYD1Q1ksaD4S7Dywl/thva0q1ozcpNC+sQr
 uxVrlzkShrNTBXJBU6CL3J+RY9quw80=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 938283E49C4
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 13:18:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E22AE3E2206
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 13:18:28 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A38110009BD
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 13:18:27 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso139192985e9.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777461506; x=1778066306; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EM+BLH98Sz+d+g7Uhl342wc+fVuN+NtQOcGe2027X0w=;
 b=A1pbqs9szOLPcKVXslvhBAFrwaOLAIfPte2eWGaOowkXkl2Z30iQmFgvUjpyVzqQeJ
 Axt/4/qznwZ1RP4DlseEO0TChip4yJhmADOMfLj2U9GgeKgkBOMSGMcnMydIGsVmGxAt
 XaqmNnKqTfrIRpA31ywjGbno18XEpt6GScIR7ZHXccolPk6jZZy7nMDa5gBtbFdg9ZLe
 X8s69LPFKL7i75RV1GbsAX8ztsI8Fm9hB3xezpFRP3e2ZeThqeMAcx5KXuqsrHwBI9hv
 KnZge/FCTXF+slYn9Hu/ihcV/8F4CfVmDkXbjcSVJ/tWsse8XnAAIcOJwp4awJSStLYs
 mZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777461506; x=1778066306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EM+BLH98Sz+d+g7Uhl342wc+fVuN+NtQOcGe2027X0w=;
 b=blw8YkclWacwWaImKB3dBC6EkvE2OiqtZqIg1wnTiTaRZm4sKAOfei8xicUEUQBYbK
 bO4XoFypJtY7EP5Jg0dMVamLyxHKskDkCz7T+6yB5IYSy5rylxMyvzwX/Y2EGUnMgQnY
 cz7DwvG7I7nQNdbZCcQEt156GX3UlWDO01V7aiM7ZXyhMATMppLpfAiVPBAvGjsrGYxS
 +zHA1oXn05Y2vrkwEx+H48hF3alRJrmCCf0hXKk5Pvd2NM2kRntxD0aSS5tPbPYhPnpg
 siaHtpUStbVxF1uHfyDPQSm8aWGeParuV0JRUDUmkINZGhWqpihF/hugwzp7lpwLDako
 ypfw==
X-Gm-Message-State: AOJu0YzYx/RsRza74i+89ohnHgar3z0B+7bGzyo5VKzVTyWmUyMuDwBh
 61U3eoGRHsN2T+FQScxYFjSu0KntCSRYuPT6GkrjvqJNNSq4j87acmT1xaf9ZtQPgQwArFjMwQa
 xves=
X-Gm-Gg: AeBDietrZ0+OC4NGmL3dW8lWvaDBURwkMSJ/Yh7KKR93dd5ccvG4uqQz0MiQJoRueOv
 g5vuiNFOk5LmnpDS0wZSg2Cv3INHtFzSMGCv+MNqqC8tRhlEs/b/jO0Ma9XfRxPtPIaFQV7Hp1p
 TujhafAtKAFxCP7K5cbKoR4JUIdQ+II/VS8oMmWV3skG6MKf0f4oY018+XCSaZSF5sMDMhKghM9
 Y/ykpjCH5pjH5/1i0WP74w2Ka9iPfE9pIO9NwgVBaDSVi0vlDZHSptfqc+azHw1OZYrq7xa1zp9
 P9QTNvipCga9nDNDgjMu2NbgIN2PPQX5YxGXX1jnruLapK/nY/I3mzXhvBHRDuegMCrCvXIrH1Z
 xhAwm1gDKfvIeajooThoxeAmSnL3937ZhabX52ZxHSzrgvUWBXwPJqvOdU55qq0E9tBNPHhktys
 nwjVcw0awwmrMuhsZDXam68Q==
X-Received: by 2002:a05:600c:b90:b0:489:1e8a:90b4 with SMTP id
 5b1f17b1804b1-48a7b53ca8fmr58557035e9.21.1777461506349; 
 Wed, 29 Apr 2026 04:18:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a7c5845c8sm44716545e9.7.2026.04.29.04.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 04:18:26 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Apr 2026 11:18:13 +0000
Message-ID: <20260429111823.1046-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413062002.20324-1-wegao@suse.com>
References: <20260413062002.20324-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] shmctl03: Fix 32-bit compat mode failure by
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
 include/tst_assert.h                          |  9 +++++---
 lib/tst_assert.c                              | 22 ++++++++++++++-----
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 17 +++++++++++---
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..8b2c8f655 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,17 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
+#define TST_ASSERT_SATURATED_INT   0x01
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
index b68bd5d39..773a10e49 100644
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
@@ -23,18 +24,29 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
-void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+void tst_assert_ulong(const char *file, const int lineno, const char *path,
+		      unsigned long val, int flags)
 {
-	unsigned long sys_val;
+	unsigned long long sys_val_64;
+	unsigned long expected_val;
 
-	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
+	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);
 
-	if (val == sys_val) {
+	if (flags & TST_ASSERT_SATURATED_INT) {
+		expected_val = (sys_val_64 > (unsigned long long)INT_MAX) ? (unsigned long)INT_MAX : (unsigned long)sys_val_64;
+	} else if (flags & TST_ASSERT_BITWISE) {
+		expected_val = (unsigned long)(sys_val_64 & 0xFFFFFFFFULL);
+	} else {
+		expected_val = (unsigned long)sys_val_64;
+	}
+
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
