Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC98C636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:20:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50F1E3CBF4A
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:20:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD76A3CBF09
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10F0760096D
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3372C227CE;
 Wed, 15 Feb 2023 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMkOm9KvuIiMGScBJZa0J9hCDYW/JaKrylA52bDKek4=;
 b=ngVn7yXO7b9Wui39IjGwANaklquuPYNjUrNvSD4ujVt5yut8vD7ZEma5pPBI/B9ib2U7jG
 f0J2jO1CRqm1Q6Rpm15+8tIDSA0uXRvclgFCgvox8MHrymIdVvSi9y7xxR9Qrdqfi3Cgqr
 TNmmWz8RSJQbEagpbk6x025voQoTEJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F128013483;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OBsaOGyx7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:20 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:10 +0100
Message-Id: <20230215101615.27534-6-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 05/10] Refactor userns05 test
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
 testcases/kernel/containers/userns/userns05.c | 48 ++++++++-----------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns05.c b/testcases/kernel/containers/userns/userns05.c
index 4c16694b1..36f48fda5 100644
--- a/testcases/kernel/containers/userns/userns05.c
+++ b/testcases/kernel/containers/userns/userns05.c
@@ -18,15 +18,12 @@
 
 #include <stdio.h>
 #include "tst_test.h"
+#include "lapi/sched.h"
 #include "common.h"
 
-/*
- * child_fn1() - Inside a new user namespace
- */
-static int child_fn1(void)
+static void child_fn1(void)
 {
 	TST_CHECKPOINT_WAIT(0);
-	return 0;
 }
 
 static unsigned int getusernsidbypid(int pid)
@@ -47,14 +44,18 @@ static unsigned int getusernsidbypid(int pid)
 
 static void run(void)
 {
+	const struct tst_clone_args args1 = { .exit_signal = SIGCHLD };
+	const struct tst_clone_args args2 = { CLONE_NEWUSER, SIGCHLD };
 	int cpid1, cpid2, cpid3;
 	unsigned int parentuserns, cpid1userns, cpid2userns, newparentuserns;
 
 	parentuserns = getusernsidbypid(getpid());
 
-	cpid1 = ltp_clone_quick(SIGCHLD, (void *)child_fn1, NULL);
-	if (cpid1 < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
+	cpid1 = SAFE_CLONE(&args1);
+	if (!cpid1) {
+		child_fn1();
+		return;
+	}
 
 	cpid1userns = getusernsidbypid(cpid1);
 
@@ -64,23 +65,20 @@ static void run(void)
 	 * CLONE_NEWUSER flag is a member of the same user namespace as its
 	 * parent
 	 */
-	if (parentuserns != cpid1userns)
-		tst_res(TFAIL, "userns:parent should be equal to cpid1");
-	else
-		tst_res(TPASS, "userns:parent is equal to cpid1");
+	TST_EXP_EQ_LI(parentuserns, cpid1userns);
 
-	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
-	if (cpid2 < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
+	cpid2 = SAFE_CLONE(&args2);
+	if (!cpid2) {
+		child_fn1();
+		return;
+	}
 
 	cpid2userns = getusernsidbypid(cpid2);
 
 	TST_CHECKPOINT_WAKE(0);
 
-	if (parentuserns == cpid2userns)
-		tst_res(TFAIL, "userns:parent should be not equal to cpid2");
-	else
-		tst_res(TPASS, "userns:parent is not equal to cpid2");
+	TST_EXP_EXPR(parentuserns != cpid2userns,
+		"parent namespace != child namespace");
 
 	cpid3 = SAFE_FORK();
 	if (!cpid3) {
@@ -91,20 +89,12 @@ static void run(void)
 		 * is moved into a new user namespace which is not shared
 		 * with any previously existing process
 		 */
-		if (parentuserns == newparentuserns)
-			tst_res(TFAIL, "unshared namespaces with same id");
-		else
-			tst_res(TPASS, "unshared namespaces with different id");
+		TST_EXP_EXPR(parentuserns != newparentuserns,
+			"parent namespace != unshared child namespace");
 	}
 }
 
-static void setup(void)
-{
-	check_newuser();
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
