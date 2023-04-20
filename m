Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC01C77B72
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 16:09:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC2F43CBFAD
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 18:09:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58E1A3CBF77
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 18:09:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 4A735600846
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 18:09:21 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 474711595
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 09:10:03 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.59.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDF523F6C4
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 09:09:18 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 20 Apr 2023 17:09:10 +0100
Message-Id: <20230420160910.809091-3-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420160910.809091-1-teo.coupriediaz@arm.com>
References: <20230420160910.809091-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] setpgid03: Add test for PGID in different
 session
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

The current test in setpgid03 generates EPERM because the child is
a session leader, as it has called setsid().
EPERM can also happen by trying to change to a PGID in another session.
This was previously done in setpgid02, but it could fail on some systems.

setpgid03 provides a guaranteed way to generate this error by forking and
setsid() in the child, so add a test for it here.

Update the description to reflect this understanding.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
 testcases/kernel/syscalls/setpgid/setpgid03.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index b23d662e9..9ce2603d8 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -11,6 +11,8 @@
  *
  * Tests setpgid(2) errors:
  *
+ * - EPERM The process specified by pid must not be a session leader.
+ *
  * - EPERM The calling process, process specified by pid and the target
  *         process group must be in the same session.
  *
@@ -43,6 +45,8 @@ static void run(void)
 	TST_CHECKPOINT_WAIT(0);
 
 	TST_EXP_FAIL(setpgid(child_pid, getppid()), EPERM);
+	/* Child did setsid(), so its PGID is set to its PID. */
+	TST_EXP_FAIL(setpgid(0, child_pid), EPERM);
 
 	TST_CHECKPOINT_WAKE(0);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
