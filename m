Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A72C105F7A8
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 13:52:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EFA13E52B1
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:52:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65DC43CCCED
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 14:51:50 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1FE06601259
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 14:51:50 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2ae527552acso9411215ad.0
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773409908; x=1774014708; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lT2RXuo1W0ZATQ0il/yeDy7nhgPp812lRBOcqg58TlE=;
 b=b1kY3xRRg8huZn5Mv/yRVnfyq3VIotyAUdyIn0ZXUOezACUVyPYATdb4Yf/PFY8ICv
 Xv8aTcwHA0vLgUBRKVsq5GBfYLU8VLYWSHC8WhdQFobmXbRQIwCCWoG4dZSBaKhU30uV
 YU9KfPYhZi2CKwM0MHzpEMvw8kcEgExgP7wlERVQD4Uu5kOI4XbfbHiImTuscXDV8tJt
 HMx5GNbKVU9dfeHAbvjxNZNwA+xpzPMt//1Zj9e8gl8PClaqN3nG0+YBfTzs7doSFu5l
 1EQ26z6I5emxaYz67VNqSGVKkXmacKlBBikqNBoBDmGsovVp9j+goWzqVovLCC0Ag2hR
 dngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773409908; x=1774014708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lT2RXuo1W0ZATQ0il/yeDy7nhgPp812lRBOcqg58TlE=;
 b=mdpTqgeIc8mxDAWpItS2EmYti4s9vBs+SqZVTvfdkG9EAZRbqiXhAejEtoluFixPwC
 et0ILsHuwVjct2tDXIsCH11P44tdHJhnmBh30vs6k47OECLgDQRbZD2BpM1agl+Ip5xu
 gmxW55SsJ1wLsZAGqj9enXmOpCLp8loTjKQdBB5gqqDJZdwsMXC8Z1WidkXLrFep9Ldl
 JhDmkDnehVmcYwXZmrEwR4G6wuMT0bEXsKzJjxtwJJ29F/Eo6MQSJAw6V8/PqAZtL7oX
 CegTLrQ4HpG9iqREox3P4hw5szEKzwbMGQBvY+jaSEbdMS7N+vCJDcv6/FOXl8LMxKSO
 0+7Q==
X-Gm-Message-State: AOJu0YwW6yxiNyZcPfevTNXhqFY0eRTwLDb2zG3qFVwxKDS1MEZS+Z/F
 cuEQh4SFIaidGBcWI0ET67fvAtlaZ3nwJQU3FnirQfneRC9y+tjqhzLweX/l1oY=
X-Gm-Gg: ATEYQzxUFfkyG83zCC7YhIyvTZPzwgSdDT/91XTWf/NZOLyUQbdql/yMy4wJWT8+PiC
 HhypJIOOWVKiRx1zHzzLW84qjMHwqdkFEFp58VlRR8AhEDgl+aexOn7YRCG6aM9YCdb7hSX4wnZ
 u+123xPjHFeq7RHP7RGH4id6KeCOSa4V7MLEXTIbowLDFjfKanXrSWm3bTNQM/LSH90I7ivbHE0
 c8YQcEYnNczFUYbdiZWmbknHVXZnAgp9Zt2DztLDL7DWI9RU973Adzsr6DLYke0t0537OFi8OD6
 Qi0IsXHrNDyDmNbf8T/NvdnKiEhK+EMaOleVqRDECxKmQf1KTTWhVFw10MReP+708IYJZSq7sok
 07ZFi1yUkiHnrVDKtzkpJNjlSBhWT7ISNTk7qev9R18m98wR0V+23wk1NfDB7opOlM59tvd7qY/
 b4YhEd0V8XFpN0DQZzWQVawJkI2725lcGAouL51CIUBQ==
X-Received: by 2002:a17:902:d485:b0:2ae:5228:e0ff with SMTP id
 d9443c01a7336-2aecaacf65cmr33038765ad.29.1773409908271; 
 Fri, 13 Mar 2026 06:51:48 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece56cdf4sm33098675ad.8.2026.03.13.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:51:47 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz
Date: Fri, 13 Mar 2026 22:51:23 +0900
Message-ID: <20260313135125.3337-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310172047.GA65487@pevik>
References: <20260310172047.GA65487@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] poll: fix make check findings and improve poll01
 validation
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Remove extra blank lines, mark helper functions as static, and fix
documentation comments starting with '/*\'.

Use :manpage:`poll(2)` in the documentation comments to link to the
man page.

Add explicit checks for poll() return value and tighten revents
validation for POLLIN and POLLOUT cases.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/poll/poll01.c | 37 ++++++++-----------------
 testcases/kernel/syscalls/poll/poll02.c |  6 ++--
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
index b05e809ab..fc11c11bc 100644
--- a/testcases/kernel/syscalls/poll/poll01.c
+++ b/testcases/kernel/syscalls/poll/poll01.c
@@ -5,8 +5,8 @@
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  */

-/*
- * Check that poll() works for POLLOUT and POLLIN and that revents is set
+/*\
+ * Check that :manpage:`poll(2)` works for POLLOUT and POLLIN and that revents is set
  * correctly.
  */
 #include <unistd.h>
@@ -27,19 +27,12 @@ static void verify_pollout(void)
 		{.fd = fildes[1], .events = POLLOUT},
 	};

-	TEST(poll(outfds, 1, -1));
-
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "poll() POLLOUT failed");
-		return;
-	}
-
-	if (outfds[0].revents != POLLOUT) {
-		tst_res(TFAIL | TTERRNO, "poll() failed to set POLLOUT");
+	TST_EXP_VAL(poll(outfds, 1, -1), 1);
+	if (!TST_PASS)
 		return;
-	}

-	tst_res(TPASS, "poll() POLLOUT");
+	TST_EXP_EXPR(outfds[0].revents & POLLOUT);
+	TST_EXP_EXPR((outfds[0].revents & ~POLLOUT) == 0);
 }

 static void verify_pollin(void)
@@ -53,26 +46,18 @@ static void verify_pollin(void)

 	SAFE_WRITE(SAFE_WRITE_ALL, fildes[1], write_buf, sizeof(write_buf));

-	TEST(poll(infds, 1, -1));
-
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "poll() POLLIN failed");
-		goto end;
-	}
-
-	if (infds[0].revents != POLLIN) {
-		tst_res(TFAIL, "poll() failed to set POLLIN");
+	TST_EXP_VAL(poll(infds, 1, -1), 1);
+	if (!TST_PASS)
 		goto end;
-	}
-

-	tst_res(TPASS, "poll() POLLIN");
+	TST_EXP_EXPR(infds[0].revents & POLLIN);
+	TST_EXP_EXPR((infds[0].revents & ~POLLIN) == 0);

 end:
 	SAFE_READ(1, fildes[0], read_buf, sizeof(write_buf));
 }

-void verify_poll(unsigned int n)
+static void verify_poll(unsigned int n)
 {
 	switch (n) {
 	case 0:
diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
index c0665927b..76cebc70d 100644
--- a/testcases/kernel/syscalls/poll/poll02.c
+++ b/testcases/kernel/syscalls/poll/poll02.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
  */

-/*
- * Check that poll() timeouts correctly.
+/*\
+ * Check that :manpage:`poll(2)` timeouts correctly.
  */
 #include <errno.h>
 #include <fcntl.h>
@@ -15,7 +15,7 @@

 static int fds[2];

-int sample_fn(int clk_id, long long usec)
+static int sample_fn(int clk_id, long long usec)
 {
 	unsigned int sleep_ms = usec / 1000;

--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
