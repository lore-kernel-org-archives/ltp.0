Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0554EFF886F
	for <ltp@archiver.kernel.org>; Sun,  3 May 2026 08:56:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C2C3E1FD8
	for <ltp@archiver.kernel.org>; Sun,  3 May 2026 10:56:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07F673E16F0
 for <ltp@lists.linux.it>; Sun,  3 May 2026 10:56:12 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A805D1A00245
 for <ltp@lists.linux.it>; Sun,  3 May 2026 10:56:11 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-36520a83186so493591a91.3
 for <ltp@lists.linux.it>; Sun, 03 May 2026 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777798570; x=1778403370; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mXsreLzpH+NcGtPcAzgW51T4BU6Md/xcQOwU+ze1/9k=;
 b=sEqLdVvsoVVzFxdH0ykrJCmyIMAHX/FZqjsneGfovkNjy1j2PwOhCEw4FGb0PPNfdt
 iBrtYAdY+VeNbFNPSl8LLr0aDCQ3MzMRYoCncTeCpPdOiRXnGCAifoizQKOITpGDecU6
 fJ+MVlHzkEHKZA1K4SQ8TnxbbDfeuUXf4oBgYhsAvAQ5ycxUSw5QEY41eoE3YAe8ax3f
 HYawfOJUSd7ptl/iVXvR2slXkJsoK2s92tDX/Q8D7mKbzbX7d+U1qnaIHeeLVffEfyIY
 QQzt2IaKUTdj1bEUnC+onuF2r/SYhbUQYNBIJ4B+qY/g4R+yuUrIIH9LFxUyHUSF5dfH
 nOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777798570; x=1778403370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mXsreLzpH+NcGtPcAzgW51T4BU6Md/xcQOwU+ze1/9k=;
 b=UypU79A+ZfFQ2t07/g6OZtFATSa5lT2C620vDNt+pSCr3Q9xPglIjNtDj1TSfQqQp4
 F3oiN0+IxVauccZgbD0u5XZfCL0NPstvYaPJFI0gaozFnpq77g61vg65FlbjVP36odFJ
 zteW2ZUL1ED7MWuyHCsWkOagr/REssA1O+JHhQGvuF6z2kUGC/fcoONXHN7dWO7aS8L1
 qvgmdn3jZsydW5bQYCDd1MIgwbAYfdSDiwiQIiqepdYqvba1LMA8sOBPQxlY6k4sZoxo
 YREhQSX2ZRLMmrLKqyjKLkNkUgqImw6rcnYteWa1d8tfpv8s6aezRcdQwq2B0AJneP9H
 0CFQ==
X-Gm-Message-State: AOJu0YxFX+yOauV6/8wjtq19pBaUHtJAPVMJmUmq9e2zSCvGBW5PHxas
 kFoSoOYS7Aqu2sHoR5msZUbYvK/W7Bhz9IFjkRFRJxOl1RXLzmtZcXSt/WZFkcneSJzP
X-Gm-Gg: AeBDietFrPEKXPuoZFjnTANI6+rwt6pFZm32C3Tg3/zyTWOi5PeMNXJbroVh5rf4dHd
 VHPZmUJBBTBW8yAUNl4BHlNSvC8eNx2dpYFZMhaMqJDnkR9gWlhup8rnM0GmUxvbi8FpggDOfe9
 ABx2ikhvO/p+rYkys2mSufe9Agz48AuxKz5PGB5ccm4eW1MwcwZroFjxhQdxRdd7i8TbyPCzlBU
 4NZOjguqbKQVkhDcAskj5YJH/JwP8wgi/ESOws/5qz34W6+WvWQasZCoHzurB7l0lqkk6OyMmXJ
 PU1DZqYkJpoZJfwBk3CZEEp7x6Vx4IWUuDvbiXbdXbkGvPcDgAxagu5jS9kxLGrkBFr0uq+eN71
 CJXmpK79+RT2HyCleNnUjsOf9JwnPpbctUwTXG+RkcQlearwMZBD18Itdd0Zy7WnkHVoG3M7Giq
 RJRJwOvdHSc1nWitTMESioBtAm4f2F+zlYeOs1fmZjBD49kw0zT5+v
X-Received: by 2002:a17:90b:3c45:b0:35f:b6d3:da7d with SMTP id
 98e67ed59e1d1-3650ce7e5a7mr5833450a91.17.1777798569737; 
 Sun, 03 May 2026 01:56:09 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ebec899esm8044167a91.1.2026.05.03.01.56.08
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 01:56:09 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  3 May 2026 17:55:38 +0900
Message-ID: <20260503085544.16915-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503085544.16915-1-always.starving0@gmail.com>
References: <20260503085544.16915-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] getpid: Link manpage and fix minor issues
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Link to the manpage in docparse comments.

Also remove the unused <error.h> header and use tabs for indentation.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/getpid/getpid01.c |  3 ++-
 testcases/kernel/syscalls/getpid/getpid02.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index d9ba0953c..8fcd351d6 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -4,7 +4,8 @@
  */

 /*\
- * Verify that getpid() system call returns process ID in range <2, PID_MAX>.
+ * Verify that :manpage:`getpid(2)` system call returns process ID in range
+ * <2, PID_MAX>.
  */

 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 3da853d48..08fcd5337 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -6,12 +6,12 @@
 /*\
  * Check that:
  *
- * - fork() in parent returns the same pid as getpid() in child
- * - getppid() in child returns the same pid as getpid() in parent
+ * - :manpage:`fork(2)` in parent returns the same pid as
+ *   :manpage:`getpid(2)` in child
+ * - :manpage:`getppid(2)` in child returns the same pid as
+ *   :manpage:`getpid(2)` in parent
  */

-#include <errno.h>
-
 #include "tst_test.h"

 static pid_t *child_pid;
@@ -51,7 +51,7 @@ static void verify_getpid(void)
 static void setup(void)
 {
 	child_pid = SAFE_MMAP(NULL, sizeof(pid_t), PROT_READ | PROT_WRITE,
-                              MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 }

 static void cleanup(void)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
