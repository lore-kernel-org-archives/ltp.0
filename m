Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ECEC433FE
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 15:08:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB86C3CC526
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 16:08:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 594BE3CC52F
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 16:07:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 6E7D760082D
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 16:07:48 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84155D6E;
 Wed, 30 Nov 2022 07:07:54 -0800 (PST)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC2D03F73D;
 Wed, 30 Nov 2022 07:07:46 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 30 Nov 2022 15:07:38 +0000
Message-Id: <20221130150738.745960-4-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130150738.745960-1-tudor.cretu@arm.com>
References: <20221130150738.745960-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] safe_semctl: Fix undefined behaviour in vararg
 handling
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

Accessing elements in an empty va_list is undefined behaviour.
The semctl system call expects the union semun argument only for a
set of cmd values, otherwise the argument is ignored.

Modify the safe_semctl wrapper to read the variadic argument only when
it's expected to be provided.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 include/lapi/ipc.h      | 14 ++++++++++++++
 lib/tst_safe_sysv_ipc.c | 23 ++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)
 create mode 100644 include/lapi/ipc.h

diff --git a/include/lapi/ipc.h b/include/lapi/ipc.h
new file mode 100644
index 000000000..5645c8817
--- /dev/null
+++ b/include/lapi/ipc.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Arm Ltd.
+ */
+#ifndef LAPI_IPC_H__
+#define LAPI_IPC_H__
+
+#include <sys/ipc.h>
+
+#ifndef IPC_INFO
+# define IPC_INFO 3
+#endif
+
+#endif /* LAPI_IPC_H__ */
diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index 5eaa82539..a196fc9ce 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -4,12 +4,12 @@
  */
 
 #include <sys/types.h>
-#include <sys/ipc.h>
 #include <sys/msg.h>
 #include <sys/shm.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
+#include "lapi/ipc.h"
 #include "lapi/sem.h"
 
 /*
@@ -232,13 +232,22 @@ int safe_semctl(const char *file, const int lineno, int semid, int semnum,
 {
 	int rval;
 	va_list va;
-	union semun un;
+	union semun un = {0};
 
-	va_start(va, cmd);
-
-	un = va_arg(va, union semun);
-
-	va_end(va);
+	switch (cmd) {
+	case SETVAL:
+	case GETALL:
+	case SETALL:
+	case IPC_STAT:
+	case IPC_SET:
+	case SEM_STAT:
+	case SEM_STAT_ANY:
+	case IPC_INFO:
+	case SEM_INFO:
+		va_start(va, cmd);
+		un = va_arg(va, union semun);
+		va_end(va);
+	}
 
 	rval = semctl(semid, semnum, cmd, un);
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
