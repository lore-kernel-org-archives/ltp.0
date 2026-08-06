Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B00AC56205
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 15:09:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A2133E9032
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 17:08:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD9DA3C2A5A
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 17:08:44 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CB7210006D2
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 17:08:41 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso8347175ad.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786028920; x=1786633720; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vtkuIIlwLp1Efn7VE6iMnUZoEtpDqQUSdiUliH2EY68=;
 b=i16XYPVXAfDZ1f0J+e86Gl3zRn7lR62pqk5cyWUWtRTif10zTiiRu91SwprO8EjICO
 UiYfJWJAfY8sSyAGqB5LgGA9j1HBtWr2PztxlhITTANzE31/A1lywQOe74pAEjtl0gft
 w5TXuFtiobT1B5YjhfJx4awUJh62VCL+NMhzrtf2gtsijreAblQj8icdyk9hqdwOvWgm
 yos46feWAjbxJhVKd4xgZNQG9DhXQ4z8K1UI3sP/fqWUx1uvTR2upnGmqCxoAmgdoYbt
 3Trk2X8eb/e1YhI2GLC/O8TgvPB6Th3ZBzZ54VZOxiIdAQGww++dmp2TouLSAswvGg9l
 ceSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786028920; x=1786633720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vtkuIIlwLp1Efn7VE6iMnUZoEtpDqQUSdiUliH2EY68=;
 b=fCFHBw5+bouWusLiYjhWRJDhs9/2jTDCyD8CuTeG44DQ6c+hF3GqnEMA25t7Qt4evP
 o4Dw8wHM2L3l9t2asvAy4DO9+7RwWWCuz/JFZGbaNbIX2RIJLvPrTzIZRemdwkR2ZlTx
 /l8ncSPY9WN19aAuCW4HvQFUdrP7G21wTS7tohdkus0F6MMLs4dAPv3U54ybf7SJvQRH
 k+0u6r6Gd7REMqqB+RNJbNsTZUmqsCqllfY1NAIl/uiZcAWzUih4sDRCen6KUZBhCYtp
 leUv+JgyO73GeS52EkImMq2VCjon6Jr8UCFtak4oeKzJstGAY82vHQbSXqp2bCAVOsNa
 hM9g==
X-Gm-Message-State: AOJu0Ywnp3ouY3tafw0cZimggZEwmPdFkU59dGuntgqSrL8JIF+RaEfU
 EiBw9fgBEtqy+4Wp3dIbT8C1cDYvtwNiI8uxdFPdYP4rxHERagQ4IXqbDZ94du7lPIsV
X-Gm-Gg: AR+sD10lO1gJd8O7epw/EyzsLB8hbVSUvxVDguphe4dBE6wQNsKNJGfpu5eZz43bsw5
 2udtnAhCjQ2abbH1n6yOUun9vwfaYDt0igDewsug1xl23LfetxWBIi6Y6Rc93v/UCqy6cha5L8U
 Qxc25Zme7Gg/pkq5Sg4dl2DnFM/pbUIvu1wcjVUdWreY2VmBtbajrI5kmY5Zm+U4iDeWolKwPWd
 iZSxZn4E/nF2a/8yFTc5kroh5agR29mpeQtZzwKYyw4Ga2+WDvx8FGEdl3MwSLT7MQaKx3Crd1S
 atF/7CzcQ7A9GkBa71/olzCUwVfd9sNOqryz6GawuuI+iWR0TEm3zh3SK07s+EP2dOc3kSpiWQI
 pYGVc+T0Ci4bGLwhEYmyNF9seFZABo+K01BhOEP3+B2/bpjuNHiKmJtbku4rhNENu8QwXJIRvfq
 fzHE8oWpbLVnkbkInTu0rboQ3qFwF/f/r/1nAcM23CR+Mx6T4PxZm7oLw7ZIrEcC0v859L/n6l2
 n4pnFy4Zg==
X-Received: by 2002:a17:903:3c68:b0:2cf:bf32:b754 with SMTP id
 d9443c01a7336-2d106a900b6mr28661765ad.8.1786028919471; 
 Thu, 06 Aug 2026 08:08:39 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4d68easm33248435ad.68.2026.08.06.08.08.37
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 08:08:38 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  7 Aug 2026 00:08:13 +0900
Message-ID: <20260806150814.4947-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls: consolidate getpid02 into getppid02
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

Although named getpid02, the test verifies both getpid() and getppid()
across fork(). Reuse its broader coverage in getppid02 and remove the
duplicated getpid02 test.

While at it, rename proc_id to parent_pid for clarity and use
TST_EXP_EQ_LI() for PID comparisons.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v3:
- Rename proc_id to parent_pid for clarity.
- Use TST_EXP_EQ_LI() for PID comparisons.
- Link to v2: https://lore.kernel.org/ltp/20260729120820.5646-1-always.starving0@gmail.com
---
 runtest/syscalls                              |  1 -
 testcases/kernel/syscalls/getpid/.gitignore   |  1 -
 testcases/kernel/syscalls/getpid/getpid02.c   | 67 -------------------
 testcases/kernel/syscalls/getppid/getppid02.c | 43 ++++++++----
 4 files changed, 31 insertions(+), 81 deletions(-)
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
index 7497eba12..b9c773e8d 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -4,33 +4,52 @@
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

+static pid_t *child_pid;
+
 static void verify_getppid(void)
 {
-	pid_t proc_id;
+	pid_t parent_pid;
 	pid_t pid;
-	pid_t pproc_id;

-	proc_id = getpid();
+	parent_pid = getpid();
 	pid = SAFE_FORK();
+
 	if (pid == 0) {
-		pproc_id = getppid();
+		TST_EXP_EQ_LI(getppid(), parent_pid);

-		if (pproc_id != proc_id)
-			tst_res(TFAIL, "child's ppid(%d) not equal to parent's pid(%d)",
-				pproc_id, proc_id);
-		else
-			tst_res(TPASS, "getppid() returned parent pid (%d)", proc_id);
+		*child_pid = getpid();
+		return;
 	}
+
+	tst_reap_children();
+
+	TST_EXP_EQ_LI(*child_pid, pid);
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
+	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = verify_getppid,
 };
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
