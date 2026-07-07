Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3EEC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 15:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 830283E5D30
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 17:35:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98ED33C3167
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 17:35:30 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B2F2600925
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 17:35:30 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc6207127aso6937515ad.1
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783438528; x=1784043328; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mvwK9b1HA+/Dpa6gFO/iBJCIps8pZs2ounzfDLGp5c8=;
 b=pUrYduQTqaWW5TDqoFD34cTCc/HSGgz/ecxkJ4Lt1g9VKA/LqYEvoIurLuNX08xlJy
 +nvSfHdc2yQIWjfM9lF2xEvS0pRiu/vajfj6moZfe06JIY0hBgT580U6ZHjVai/sGVW1
 LI23vr+Oqm1d/swH6NDPjsY16gc2hPauMraMLHv7mikSWbkIVdCV+T1mYSb/dkCOEGUx
 1+X3P2WEVhEC8xK9FL44NiwzXGyFOnTwczgMosrftCEbPiuvs7XWRaA2hn+9xnDEZb3U
 HmFFoPgMBtRNanxXtdj4Sm4C7dcsEF8GtbkRP6O7j/EyqddXlziugMgChPPWk98JanH+
 wOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438528; x=1784043328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvwK9b1HA+/Dpa6gFO/iBJCIps8pZs2ounzfDLGp5c8=;
 b=ctfUXdizVxjKpN4Y+XrIerh2fNiZ2BalwwxA+TaRwa1ZlxC1IjirVclTfZNKro1PWh
 hs8m4KZEuDflzfuHexeVb1sZzCW2sCxyIx1we/sQSkiUwwXNkgGrQ07Wg1wzvmz80VIO
 3jltHkPPu9MiV5g+qv8/DZOphWy9FHIP5/FgOC8T5Wck+sBB56aor7sH74mmQ3SjVtNS
 AWib2xzBvR2MTA11hi+Vcum4002Lb2sxX9bJatf7ux7J+vqFW/T5Cd0gfLxffp2Svkcq
 qaDDW6AJpp3n0IdaeKVbqQ2hgwTO9y7MYoRO5PAHf5wTUM8qTWz3SKwfbgOnW/sZ+7sq
 n0Wg==
X-Gm-Message-State: AOJu0YybOwWOqo2ACTujZp73p8iVL72IkvVcqIwKtVg4Q9eUVu9BwMGr
 7DeHRe3IVDLGAGpfs5WRCvBSnH9FSyAP6ksoORRB68clEMA7slRL3bE0ecSxMGa+gBpi
X-Gm-Gg: AfdE7clchs3k68ngMerso5aFVETd4to3BM4VMt98AGhWTuaL1oS7x2FkyMZ6oVxb/qh
 ZC0JWH1kkDQodOvwtZU5jfsPt5KqELl0k0/7ujZYIGMcPR7hIXXUJAK3tIgW2pgymoMYWA9DDTY
 AmyUZBHaclZtc479J/jmy0YodoN6f3pnF5NiQ7qFLt+8/Y7lbuPthd0ALRq7tyaC8cT2Kur+pKu
 054mx0XRiZmn+k7CnMQo3MGvJ+dicM7LK+sxlyMj5gazaf7qO4J16VRhhXUI2HgAHUdkpO6fCF3
 fG0XE1cBb1F2tci22LB+XTIEAZKf/27Mvx7oLqGXuUulsEuK2EsiHOqejrsmdTg1eJD5+hNWdJV
 CuYJPkFurh78GHaw7X/ORbpzHSWwCR10HLf6LgbxtAYbeKJPgGKDs7VMc7ccwb1EAOyFryM9tFn
 SA4C/H+UkffbFWnS3XwCA1CY42wThEbE7r3gaz55WbqTBL
X-Received: by 2002:a17:903:2444:b0:2c9:ae0b:61e3 with SMTP id
 d9443c01a7336-2ccbe40b8efmr59685225ad.2.1783438527998; 
 Tue, 07 Jul 2026 08:35:27 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bfe040sm14369975ad.31.2026.07.07.08.35.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:35:27 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 00:35:00 +0900
Message-ID: <20260707153502.15421-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: Replace getppid02 with getpid02
 implementation
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

Remove the existing getppid02.c as its coverage is overlapped by
getpid02.c. Then, replace it by renaming and adapting the broader checks
from getpid02.c to serve as the new getppid02.c.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 runtest/syscalls                              |  1 -
 testcases/kernel/syscalls/getpid/.gitignore   |  1 -
 testcases/kernel/syscalls/getpid/getpid02.c   | 67 -------------------
 testcases/kernel/syscalls/getppid/getppid02.c | 49 +++++++++++---
 4 files changed, 40 insertions(+), 78 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/getpid/getpid02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a38743ded..62a33e3a6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -517,7 +517,6 @@ getpgid02 getpgid02
 getpgrp01 getpgrp01

 getpid01 getpid01
-getpid02 getpid02

 getppid01 getppid01
 getppid02 getppid02
diff --git a/testcases/kernel/syscalls/getpid/.gitignore b/testcases/kernel/syscalls/getpid/.gitignore
index f44bc9eac..8e7ab0185 100644
--- a/testcases/kernel/syscalls/getpid/.gitignore
+++ b/testcases/kernel/syscalls/getpid/.gitignore
@@ -1,2 +1 @@
 /getpid01
-/getpid02
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
deleted file mode 100644
index 08fcd5337..000000000
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- */
-
-/*\
- * Check that:
- *
- * - :manpage:`fork(2)` in parent returns the same pid as
- *   :manpage:`getpid(2)` in child
- * - :manpage:`getppid(2)` in child returns the same pid as
- *   :manpage:`getpid(2)` in parent
- */
-
-#include "tst_test.h"
-
-static pid_t *child_pid;
-
-static void verify_getpid(void)
-{
-	pid_t proc_id;
-	pid_t pid;
-	pid_t pproc_id;
-
-	proc_id = getpid();
-	pid = SAFE_FORK();
-
-	if (pid == 0) {
-		pproc_id = getppid();
-
-		if (pproc_id != proc_id) {
-			tst_res(TFAIL, "child getppid() (%d) != parent getpid() (%d)",
-				pproc_id, proc_id);
-		} else {
-			tst_res(TPASS, "child getppid() == parent getpid() (%d)", proc_id);
-		}
-
-		*child_pid = getpid();
-
-		return;
-	}
-
-	tst_reap_children();
-
-	if (*child_pid != pid)
-		tst_res(TFAIL, "child getpid() (%d) != parent fork() (%d)", *child_pid, pid);
-	else
-		tst_res(TPASS, "child getpid() == parent fork() (%d)", pid);
-}
-
-static void setup(void)
-{
-	child_pid = SAFE_MMAP(NULL, sizeof(pid_t), PROT_READ | PROT_WRITE,
-			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
-}
-
-static void cleanup(void)
-{
-	SAFE_MUNMAP(child_pid, sizeof(pid_t));
-}
-
-static struct tst_test test = {
-	.forks_child = 1,
-	.setup = setup,
-	.cleanup = cleanup,
-	.test_all = verify_getpid,
-};
diff --git a/testcases/kernel/syscalls/getppid/getppid02.c b/testcases/kernel/syscalls/getppid/getppid02.c
index 7497eba12..08fcd5337 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -4,14 +4,19 @@
  */

 /*\
- * Check that getppid() in child returns the same pid as getpid() in parent.
+ * Check that:
+ *
+ * - :manpage:`fork(2)` in parent returns the same pid as
+ *   :manpage:`getpid(2)` in child
+ * - :manpage:`getppid(2)` in child returns the same pid as
+ *   :manpage:`getpid(2)` in parent
  */

-#include <errno.h>
-
 #include "tst_test.h"

-static void verify_getppid(void)
+static pid_t *child_pid;
+
+static void verify_getpid(void)
 {
 	pid_t proc_id;
 	pid_t pid;
@@ -19,18 +24,44 @@ static void verify_getppid(void)

 	proc_id = getpid();
 	pid = SAFE_FORK();
+
 	if (pid == 0) {
 		pproc_id = getppid();

-		if (pproc_id != proc_id)
-			tst_res(TFAIL, "child's ppid(%d) not equal to parent's pid(%d)",
+		if (pproc_id != proc_id) {
+			tst_res(TFAIL, "child getppid() (%d) != parent getpid() (%d)",
 				pproc_id, proc_id);
-		else
-			tst_res(TPASS, "getppid() returned parent pid (%d)", proc_id);
+		} else {
+			tst_res(TPASS, "child getppid() == parent getpid() (%d)", proc_id);
+		}
+
+		*child_pid = getpid();
+
+		return;
 	}
+
+	tst_reap_children();
+
+	if (*child_pid != pid)
+		tst_res(TFAIL, "child getpid() (%d) != parent fork() (%d)", *child_pid, pid);
+	else
+		tst_res(TPASS, "child getpid() == parent fork() (%d)", pid);
+}
+
+static void setup(void)
+{
+	child_pid = SAFE_MMAP(NULL, sizeof(pid_t), PROT_READ | PROT_WRITE,
+			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(child_pid, sizeof(pid_t));
 }

 static struct tst_test test = {
 	.forks_child = 1,
-	.test_all = verify_getppid,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_getpid,
 };
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
