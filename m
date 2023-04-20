Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B199EC77B72
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 16:09:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 641EB3CBF91
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 18:09:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60F3E3CBF78
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 18:09:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id EE1CE60082D
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 18:09:20 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 749A2152B
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 09:10:02 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.59.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AAFA3F6C4
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 09:09:17 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 20 Apr 2023 17:09:09 +0100
Message-Id: <20230420160910.809091-2-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420160910.809091-1-teo.coupriediaz@arm.com>
References: <20230420160910.809091-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] setpgid02: Use pid_max as PGID for EPERM
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

In some simple systems (like Busybox), the login shell might be run
as init (PID 1).
This leads to a case where LTP is run in the same session as init,
thus setpgid is allowed to the PGID of init which results in a test fail.
Indeed, the test retrieves the PGID of init to try and generate EPERM.

Instead get the PGID we use to generate EPERM from the kernel pid_max.
It should not be used by any process, guaranteeing an invalid PGID
and generating an EPERM error.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
 testcases/kernel/syscalls/setpgid/setpgid02.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 4b63afee8..b380d7df4 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -13,15 +13,15 @@
  * - EINVAL when given pgid is less than 0.
  * - ESRCH when pid is not the calling process and not a child of
  * the calling process.
- * - EPERM when an attempt was made to move a process into a process
- * group in a different session.
+ * - EPERM when an attempt was made to move a process into a nonexisting
+ * process group.
  */
 
 #include <errno.h>
 #include <unistd.h>
 #include "tst_test.h"
 
-static pid_t pgid, pid, ppid, init_pgid;
+static pid_t pgid, pid, ppid, inval_pgid;
 static pid_t negative_pid = -1;
 
 static struct tcase {
@@ -31,7 +31,7 @@ static struct tcase {
 } tcases[] = {
 	{&pid, &negative_pid, EINVAL},
 	{&ppid, &pgid, ESRCH},
-	{&pid, &init_pgid, EPERM}
+	{&pid, &inval_pgid, EPERM}
 };
 
 static void setup(void)
@@ -41,10 +41,10 @@ static void setup(void)
 	pgid = getpgrp();
 
 	/*
-	 * Getting pgid of init/systemd process to use it as a
-	 * process group from a different session for EPERM test
+	 * pid_max would not be in use by another process and guarantees that
+	 * it corresponds to an invalid PGID, generating EPERM.
 	 */
-	init_pgid = SAFE_GETPGID(1);
+	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &inval_pgid);
 }
 
 static void run(unsigned int n)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
