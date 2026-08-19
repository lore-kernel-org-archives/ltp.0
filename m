Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FAC5DF7D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 03:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787109461; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/kUWqXdVavrjMJZGw0altp2prCMTdE88E/JAmHKc1b0=;
 b=YHXNoSaFALl2R8GOjU31VoA/bGgsmFnnGrkIK88YNTORw3SC0JZetwoWOgBokso2a05zP
 I3hCgzY8WQF/IGsNgunnNnNdYvzzTBdR2Gtt6SWph5OxfTQDEAjZ/2AUTHlNCmSfGZ82hBj
 m5xUpLCrat2bxt7Hkkp2/hqOXpni3mE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82BA83CD55A
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 05:17:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D7D03CCA83
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 05:17:21 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8F9960081E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 05:17:19 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47de008b020so230546f8f.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787109439; x=1787714239; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xiV2ZO4peqMH+y3oe522e7iSzsOsqzRfwbuQo6jvhZ0=;
 b=aGginVbEs/a8c+RA4JucJTC7UAckuIxBbEQ4bLiA/ysZyop4ntFsN5zZg7dt+zyOeT
 P+ctpJEk+iIWQaDv+XoqMTEkoU1Mnqw3U0IFlRkNB8iSR9N55k0ot3ZaZ1s2kz7mHDqp
 mYO4gynm2IWphdNE3kMx80wLxocaIfE/4vl+VEr6fZsjE2/nRX4GPJPPtVxJcLSWxNvH
 aI81FWhH+H9BFx3dO0e6dPtRQmf/vjDjZiwBjlGRo+vcV/DXdB3AvjN2dRx0WxNq0/2N
 tDZJjatwZYu8J13IUIOUpQN3AXMYumdMirNH2HT5bABgsCTnGike0LMITr1wiQT9hYU+
 e6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787109439; x=1787714239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xiV2ZO4peqMH+y3oe522e7iSzsOsqzRfwbuQo6jvhZ0=;
 b=EpZ8REwo667JLVqPFXVTWR9pHzJ8MJsg3tW7ks62LbHxTbyIrfJi90nmVD/G1rHA+q
 ISEWG0r7ZSQtQ/UnH7ayz67SiS3Eh5NCo8mzvn5Cauh/sLwJUkJxboHQFNdljKi3O44z
 eklD1SKVlhGSJTsDuOapKw9QIMacmzBupXy+tg6FCGdBrl5szioU5PBOm0bAk9FVaE6Y
 Gb8euModFOcw8hqDLGlJ5ZeKLQhZ73RcbYHHwUaKhiqDqzm/29UP37t+T0FvVNVcwkfB
 9Zlzp0Aitnjmtf54X61VpR+aXeMHQzZ6dXBcJxeZxqzQKoMdpwCpQSQ7dJn8waN1WDzM
 osCQ==
X-Gm-Message-State: AOJu0YznfZxiqGPFPdwz5NpJ4iDum7sPyDVovyax92rLEvkkpAfowNan
 5RGhY0HZklEm+mkhSHj01f5zGwlAw7G658jaKA/YGQGL2Md9mcWmUwF+1jpF67sIZAt8EDi655y
 T3Ls=
X-Gm-Gg: AR+sD11gsrDDXm5MV9VbbdjvbX3fxIvWD9+vbMiPIbkWhtNHbxYOCsZVU7htpEB+SB9
 CBBeEVd1COe0NFEiyXkcHFdN0g6VWeIVHTg5jdZ2PiozkoJGIyn0TrYB+UdbriLA1NqeYpGswBO
 SNKseQyhkIOHtTwTHeE9BYyG4bhLR0P02UZXohPtwyLodBHcE/5ayioPxBMOylEBsUhfRYUlC4J
 JZDo072lIbHNXhfbKugIGi12vIGMC78iTc/zyCa/FUfGooAU6/QBYJKSQYI6ZzekvOCQJJ/M+ae
 AMbtA0ek9orH3juBcnQzQE0hinCfG0SRRz4Xy8EvvjzNcHlqzkfFak7S13CttFMnnKSJKvyyWcW
 I8l0f7hA8KrNj+YKZ/Vv7O75uGKVU2s98oDwr7g9833NpHnHu/agKXTLd9esYIRh+lr+uA87GUH
 Epn8UCBhTiLK8tI4/EOWV17TVUOC1hSRrAL9GMWnh7fktCR8tgS+lX4R6umRW2rTpVJVmFyd7hL
 9Wy4VCYCQzeeaI6q3ovpbN42S12ufywN4kqKTR6DBo=
X-Received: by 2002:a05:6000:4815:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-482b1066a64mr2795018f8f.8.1787109439137; 
 Tue, 18 Aug 2026 20:17:19 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-482b145c9d7sm2410189f8f.15.2026.08.18.20.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:17:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 03:17:05 +0000
Message-ID: <20260819031716.26527-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430034724.1628-1-wegao@suse.com>
References: <20260430034724.1628-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] shmctl03: Fix 32-bit compat mode failure by
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
v4->v5:
- Rebase to latest upstream code

 include/tst_assert.h                        |  9 ++++---
 lib/tst_assert.c                            | 27 ++++++++++++++++-----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 17 ++++++++++---
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
