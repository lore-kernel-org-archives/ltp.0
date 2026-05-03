Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E55FF886F
	for <ltp@archiver.kernel.org>; Sun,  3 May 2026 08:57:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D493E16F0
	for <ltp@archiver.kernel.org>; Sun,  3 May 2026 10:57:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 996833E2116
 for <ltp@lists.linux.it>; Sun,  3 May 2026 10:56:17 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FED42001C6
 for <ltp@lists.linux.it>; Sun,  3 May 2026 10:56:13 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-364eef1891dso1211789a91.1
 for <ltp@lists.linux.it>; Sun, 03 May 2026 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777798571; x=1778403371; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8eBRMW7Hfyz2NbNDcN0Itr4QnzHPT08gLOAqPkkw1Mw=;
 b=oofqo3/sQqyKIgWR+v3yCf6dFROs9tP8NS+ewiBm1XGwQe6FQJ4t2/RF14bLrV8WE7
 42kndV3uPQ7lbbLtWd5OKL2w17eFpfBlb/dlG1TkdmqQ4s6euzsmo+GnQJm9XzjvSje4
 w5CiLBxQIQZmEW2Y3asJoZIDNEYJDZc3L/xwO7HUDgNlhvI2GEtBuuh1wahdFqsnJpXc
 C7EHoE0eO05TFw97zrPzYYtLRuoPL+1NJIMjhZgQrbZhVNbIkVRiiegrK7s4ULaYLGfu
 Iqxf8a2h0RF9fF0nNJXNZLsf+9/TblqZxs5ANCRcThJP9ZBO2N8Lj09F0OEz6ZsdQOOM
 +70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777798571; x=1778403371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8eBRMW7Hfyz2NbNDcN0Itr4QnzHPT08gLOAqPkkw1Mw=;
 b=QHGN1TbloQOA9wFF7v7bi2foJ1xaO+2j/VG9JvDZARdQDvJSH/NUeVT15JemcUZGhk
 dRVrHQP+Mm7YFQIST2x6eiR9YxnAhEWQN2DgLvzTndJtqBoQh22jfCvrKAW5NdraoGmd
 UD4GXwZavL4cb8TIwuQUxD0XJFC3tqwKhbEuMoH+sqA3w1zEK/Fpfj4cBkWrL3wZKhJT
 neV8QQthDKYj/7rigInAw+LGeJNGls3JBfCZK34gHkAPQHzL4ucncf7G2/h9+LVtxLKj
 d2SQ2M4/FLE++3niAZPbQVFBo1nHrAq5FsTWFxAZU6/uUOcwL8MF3SjrK1C6DZ4axVEG
 S92A==
X-Gm-Message-State: AOJu0YwpZwJ4zcvezWEJQn332e+aPweRIXGl7nIsg1UBG7GTuPw1qRBp
 cQtArl/wA+AbYXToibwPsyBa2FgZ2CwP0r6wVMl40A2S9ZNWvpyGXloSB2Oe2935BRK4
X-Gm-Gg: AeBDietMBqg1UQ5Yh0rAK98F21OeJcY7VJ3S9c00EjQj6ixYeJMR3eyvmOB0h7pfDTt
 +XZqwOdMej2MqbcHFUFNJifiv6nOQGHIZ7oLZoskXyEu+dZpvbGHM0L6qzwMGrSOo4+dq9DikQW
 hNXMBwcrg3UpLJwvll0E8TP2cZPAlSPpZVw6xXayJKQGz2sKH51kIQK/emcwrfI2a4dkoCeh4XI
 ZchOJPsgfkiAFlUHD8qOBq/W7CJah76gf5HCLxsNJv9SAnv3si2oSxU8kChidFMl+BLkmBTDf97
 /RRSkZiLFi8Ht9H3kBDzGWoTmAQUr8GmzQvIZUaGtvf9eXWj2l+c570jcx91Tb2NePjst7S+DW0
 yEetm3jXxk+orB7yRV9aGYqeZecXIVv+Z1eQoJJRnc0CTScxUjhKw43wABw6R+u5uplNEr0D4M1
 NGMSrp1rYDVdAwblbu1B3bdosb8nTO+F6wXjSYLMd7zAPJgj4B6qRt6A5Z51pR9HY=
X-Received: by 2002:a17:90b:4ccb:b0:35f:bbc0:e570 with SMTP id
 98e67ed59e1d1-3650cb0af61mr5718151a91.0.1777798571212; 
 Sun, 03 May 2026 01:56:11 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ebec899esm8044167a91.1.2026.05.03.01.56.09
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 01:56:10 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  3 May 2026 17:55:39 +0900
Message-ID: <20260503085544.16915-3-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503085544.16915-1-always.starving0@gmail.com>
References: <20260503085544.16915-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] getppid: Link manpage and fix minor issues
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

Also remove the unused <error.h> header and tighten the ppid bounds check.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/getppid/getppid01.c | 6 +++---
 testcases/kernel/syscalls/getppid/getppid02.c | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/getppid/getppid01.c b/testcases/kernel/syscalls/getppid/getppid01.c
index 3f05aed37..5b5e6cceb 100644
--- a/testcases/kernel/syscalls/getppid/getppid01.c
+++ b/testcases/kernel/syscalls/getppid/getppid01.c
@@ -5,10 +5,10 @@
  */

 /*\
- * Test whether parent process id that getppid() returns is out of range.
+ * Test whether parent process id that :manpage:`getppid(2)` returns is
+ * out of range.
  */

-#include <errno.h>
 #include "tst_test.h"

 static pid_t pid_max;
@@ -23,7 +23,7 @@ static void verify_getppid(void)
 	pid_t ppid;

 	ppid = getppid();
-	if (ppid > pid_max)
+	if (ppid < 1 || ppid > pid_max)
 		tst_res(TFAIL, "getppid() returned %d, out of range!", ppid);
 	else
 		tst_res(TPASS, "getppid() returned %d", ppid);
diff --git a/testcases/kernel/syscalls/getppid/getppid02.c b/testcases/kernel/syscalls/getppid/getppid02.c
index 7497eba12..a2796406f 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -4,11 +4,10 @@
  */

 /*\
- * Check that getppid() in child returns the same pid as getpid() in parent.
+ * Check that :manpage:`getppid(2)` in child returns the same pid as
+ * :manpage:`getpid(2)` in parent.
  */

-#include <errno.h>
-
 #include "tst_test.h"

 static void verify_getppid(void)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
