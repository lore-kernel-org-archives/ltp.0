Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A69C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:18:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 417253CBF11
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:18:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FEBC3CBEFF
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C63BB1A00A33
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1714020571;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dubEUkyMjbG88Ut390kLbaV3VomuBFOezF/dlYzqjAE=;
 b=E0iwVDLsnZSS9FLuEBxMwkOZQSx8ux2N12h80hrd9fDdoMORGPeOT+q8poqYPjcNoxFy/L
 4XUhDaG0qCADVEjRHOptzujFuHOewWUKEiGz37Z+kgG9iYggF87EM/EwBukbpY8WHq9In1
 kqoM2B+OIXSaCJyI/It+fHHg0lTlFRU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAE8913483;
 Wed, 15 Feb 2023 10:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id INXwMmux7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:19 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:06 +0100
Message-Id: <20230215101615.27534-2-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 01/10] Refactor userns01 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/userns/userns01.c | 27 +++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 8ed7a9f41..cbe0da245 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -20,9 +20,9 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
-#include "common.h"
 #include "config.h"
 #include <sys/capability.h>
+#include "lapi/sched.h"
 
 #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
 #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
@@ -30,10 +30,7 @@
 static long overflowuid;
 static long overflowgid;
 
-/*
- * child_fn1() - Inside a new user namespace
- */
-static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_fn1(void)
 {
 	int uid, gid;
 	cap_t caps;
@@ -45,10 +42,8 @@ static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	tst_res(TINFO, "USERNS test is running in a new user namespace.");
 
-	if (uid != overflowuid || gid != overflowgid)
-		tst_res(TFAIL, "got unexpected uid=%d gid=%d", uid, gid);
-	else
-		tst_res(TPASS, "got expected uid and gid");
+	TST_EXP_EQ_LI(uid, overflowuid);
+	TST_EXP_EQ_LI(gid, overflowgid);
 
 	caps = cap_get_proc();
 
@@ -68,31 +63,29 @@ static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
 		tst_res(TFAIL, "unexpected effective/permitted caps at %d", i);
 	else
 		tst_res(TPASS, "expected capabilities");
-
-	return 0;
 }
 
 static void setup(void)
 {
-	check_newuser();
-
 	SAFE_FILE_SCANF(OVERFLOWUIDPATH, "%ld", &overflowuid);
 	SAFE_FILE_SCANF(OVERFLOWGIDPATH, "%ld", &overflowgid);
 }
 
 static void run(void)
 {
-	int pid;
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
 
-	pid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
-	if (pid < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_fn1();
+		return;
+	}
 }
 
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.caps = (struct tst_cap []) {
 		TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
 		{}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
