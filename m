Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7868EC53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 12:09:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC49E3D0FDB
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 14:09:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4B343D07C9
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 14:08:50 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5FAD16002D1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 14:08:50 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7ef596c6so7067885ad.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785326929; x=1785931729; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GBfvVwQWp7Z5zAutIkOGUZeE4IEZr8fgHJfZevCb1IQ=;
 b=dMY0cfMrc7HLGGSb+1Q7vXK0rC/AmRuOyl4iACQa7ay8SmvTIxFI0GgGvDOWTgO0vI
 cMxChf2AhS8gFGfpF7eL1Pqx7Ou6MQCMr+8+zKexRCnveznuu0DGluvF9576kthxzQ/g
 bgLk2/Za9hkg8TU/9Zavp/A/RPcA6xm7M393Gt6X+AtO7KSgGlqUEtZCRGuxrXf2MnH8
 NeSKvXEf80qBk8x1dAPNSCEIoxea2eL6EzBLcKxLAhw9UtZmEXREyG+SgspNR7Bvxi5N
 ZNnTsDtW7voh6HtvGzA4Wjj8gRNEUo9tgC5OMOhXzGvTo0CCIXPSDy5xoJDM+xHf5hPV
 jx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785326929; x=1785931729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GBfvVwQWp7Z5zAutIkOGUZeE4IEZr8fgHJfZevCb1IQ=;
 b=PyOUilrhxGjMbb9ODd0pBLqnOzaLwdB/4qArCu1Zr+f1yWgNhqmlzeaofkOaKCArPr
 27JTgpUyUxZ48hM3PIsWB/3dah7Pb0PkcK6Y6t5ge+fqqeboCSGHwRzdOYenvZsVX3BH
 aTo7dC2d/XtYOFhpUbCYx6cfOPpRhgetNkJiLyKRP0GoiSo/+zMNDE4FdIKQHdPyn1lr
 6ukFAPLqOgzkAjjesq6bvD8/+OJtgziUDZ4eYN1cRI49oNSBhS3TA8KM6SjSYNWqDmE6
 dX+/brObEEU+9o/Hy0zmW2DQNG9i6vCtjCFpA4dqeXIVcW4Aa6JVCawytP52eZqglOq7
 NI3Q==
X-Gm-Message-State: AOJu0Yz7M9dzvGBJz/eJrFg3Cgkh7d6glxMYq3FY1IyqQ3F7snmA0Iz1
 6o70MQoObYU6FabkjL1uN0EBInViZriAxDA2IRGMprigCt1MlbB4vvcHfQnLdY0HOQ==
X-Gm-Gg: AR+sD10130eQmAZn7gq0irRfakB5FIwoqERzmWgciLjC5ByhvbYUqT/iahbvzzY4Qz/
 RUQ1mV9qlX5n7Jm5m3LkTUJHuPLdM9R4gOKvnQBMdK9l8XprQIOAe33YWPWNq/prt53ThFGQCdm
 tJSYm9qQoq4R2Wl/a/PcH9/JTHPrUqPkA8NWT+Ry7K9AE8TeRHW7g9jl+XGkt88H4F5Ehmld8Ec
 ndrjWK812PXxhl/0Ysg8hDXGR69EKwXOb2NtkdM7KKKyGXZ9GCOqOY5SqUwl8pOmf4F9vTJobiJ
 rh0e7lEjxN/J5E/Py2jo9TaEnjfdHlw4zN0EvXMPwYWM4LTNYhBXQWt6gBMuAG0ohAmX6eeAHDN
 jhiHQ8BvkiwRw0tQwr+btCGmYKZ+GGOrrqzUlF+5hYRGJvQo5CHTUcaUQveoxGY7cZ8OWxprTzD
 rra7OLNnIGAvtYH2hnduVt88RYKYS85HXISUiYUDL0edNPBCHopd2KvbOJx2yfcXsJ+dxZazzOm
 qzpvKM=
X-Received: by 2002:a05:6a20:a104:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3c8ba46c54dmr7496733637.29.1785326928374; 
 Wed, 29 Jul 2026 05:08:48 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb8158efasm760731a12.8.2026.07.29.05.08.47
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:08:47 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 21:08:19 +0900
Message-ID: <20260729120820.5646-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls: consolidate getpid02 into getppid02
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

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 runtest/syscalls                              |  1 -
 testcases/kernel/syscalls/getpid/.gitignore   |  1 -
 testcases/kernel/syscalls/getpid/getpid02.c   | 67 -------------------
 testcases/kernel/syscalls/getppid/getppid02.c | 45 +++++++++++--
 4 files changed, 38 insertions(+), 76 deletions(-)
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
index 7497eba12..054ddbab7 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -4,13 +4,18 @@
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
 	pid_t proc_id;
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
+	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = verify_getppid,
 };
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
