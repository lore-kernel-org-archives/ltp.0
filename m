Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118A5CD5BAB
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 16:18:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 777763D9EA0
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 18:18:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CCAA3C72D9
 for <ltp@lists.linux.it>; Sun, 24 May 2026 18:17:34 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9B2F46002EC
 for <ltp@lists.linux.it>; Sun, 24 May 2026 18:17:34 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c801b30188dso3937184a12.3
 for <ltp@lists.linux.it>; Sun, 24 May 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779639453; x=1780244253; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OJxhoL/EE2VVxbxoph9lkDzAl8k/kcfKSxmPEumSKjY=;
 b=W4tsOhnGlXI8xLSmm9MkbElcekl0Q+FrWfZFzVLqT/Uu7c5VEW4XiD3uO87d1dOWYs
 B3cN6M8FHwCrmYTLGYZzxu4EZy3eOyxBUplMBeYmzUkhD6z2u+A8iKyz5+OHA9zjfzFu
 MUVmVuFeObhkyBb2NridYc1aLKSZuZjwNv0j2sfTCcvaXfDK/OXgbV9UtCbLiojeU0C1
 BNrCi4FEjnf90O8D19fTHNZ9kZ5WZY7CPdLIEDXozZ8fzuyMx25G9qrsw9Z8Qi2I7TM7
 UkHH49/45sf3zr0i0EzrJUQhudc7k1PUb1snycofEdksxd066pdRfAXzkoO8HAIMTL5I
 /ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779639453; x=1780244253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OJxhoL/EE2VVxbxoph9lkDzAl8k/kcfKSxmPEumSKjY=;
 b=lcCPYpz1a9LflFdwAXStrIWThg0yW49u8XtqoztD2UH9LkFqZkmuTEApNXs32UhgkS
 gPqnADRpYPzito+JJNjf/XIRd8T7Vj3/+GMcRL7OnkKoeofA7Y82LE8Q8S/Rt/x+drAC
 fbRRAdDUAIsyPbGtdYd4o37zOjFAloLnCPVFHePy4uZlZ0qsD3pGkeoEiSHm4esasli+
 ECubn7uSFL9ceFgV+V7ly3g1vQuJNxcph9BQhpw0VKYUYN/VEHFNZYAm4PvvR9SMVCjF
 yELScgwpF5dg8Ypuught8ZI/mvzOzl1/hRQ4kaAkSbthf6NjFp5JSbtDOYkoR2qH47aD
 F81w==
X-Gm-Message-State: AOJu0YzTIJoUj3mlNRV2tT2cZpmi5RooecKJQvb2scr+VaJ9EWF7GahU
 L9n+U2DiC3bHsL1cDx0JXCIWvXQ9+kf5SMbALpA87V2DbfkpV0AHi8PuvopVQ91USw==
X-Gm-Gg: Acq92OFHYzRomG6YVZtiVjqp4xIVQUukcY9hqQffXHeQKSTEQqOmN7AAjQS0CEnvadQ
 ri6LB8PSsFNPmYU6AtTMoF4q4phU0/IenWHIrvxUuCejV9gC7Jru1LB8qy6rza2BSmw0rdEPj2l
 PBW0XdLtplhhRfq5nxKWeyfOuyrRvKyHiTIUcTYTGYRFO41TkOBGKjuD9ng4Luz8lkfrTV0QzsE
 0z401rVPe0rk0P/UpWnqtEER/qjhanRzier1REsRDk0mmeUrwR2yRp+RLiWoi/7IR8o+C4gDlZQ
 GByL57agpS+zFgvaNuS4+qVfVbAwyI9Wy8virjICKz3huerIgU1TylvM1H2m8Cd4+PzmdaKfhW7
 eK+ivlCpdlWoY9ayRZKuLFCpH337/vWSFOZijgLmLsHiz7FkIKsTi9xGXXEO0tDhKTglRv4I7dO
 pSMFIrwMhGLWXiZZdKY0Ir/wKa4yO+FtW0xqAvLwPF4A==
X-Received: by 2002:a05:6a20:158f:b0:398:a76e:4ad4 with SMTP id
 adf61e73a8af0-3b3291c89c2mr12302177637.21.1779639452922; 
 Sun, 24 May 2026 09:17:32 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202ad588sm5832690a12.10.2026.05.24.09.17.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 09:17:31 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 01:17:04 +0900
Message-ID: <20260524161706.3510-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524161706.3510-1-always.starving0@gmail.com>
References: <20260524161706.3510-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] getpid02: Remove unused header and fix minor
 style issue
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

Remove the unused <errno.h> header.

Use tabs for indentation.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/getpid/getpid02.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 4d2402932..08fcd5337 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -12,8 +12,6 @@
  *   :manpage:`getpid(2)` in parent
  */

-#include <errno.h>
-
 #include "tst_test.h"

 static pid_t *child_pid;
@@ -53,7 +51,7 @@ static void verify_getpid(void)
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
