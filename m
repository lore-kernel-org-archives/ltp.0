Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11C1C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4E93CC3DC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:19:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31953CBF09
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D1D51400B76
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AE21227CB;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6NWldUp5yooQkt36WyoVix58rZYbnM87TIo+0RCUggA=;
 b=O+t5jlaSXpX3pFA8rVT/H+nRPXBmGXzJBfwi1VUy8EJrg1Z9NIszIgnnA6JzHpVF9ZvM5o
 7CphZRVmF3Ocq2uC/3tb8mUMAHA94U04wNhf9Rcd90Eh9ZrT/DR9Is16ykgJnokRw0QBh7
 ERPghG0AD67PdB8R/X331uffNb41QuU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2871113483;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YDZxB2yx7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:20 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:07 +0100
Message-Id: <20230215101615.27534-3-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 02/10] Refactor userns02 test
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
 testcases/kernel/containers/userns/userns02.c | 31 +++++++------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
index dd784000e..9d445d986 100644
--- a/testcases/kernel/containers/userns/userns02.c
+++ b/testcases/kernel/containers/userns/userns02.c
@@ -14,13 +14,10 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
-#include "common.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
-/*
- * child_fn1() - Inside a new user namespace
- */
-static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_fn1(void)
 {
 	int uid, gid;
 
@@ -29,29 +26,23 @@ static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
 	uid = geteuid();
 	gid = getegid();
 
-	if (uid == 100 && gid == 100)
-		tst_res(TPASS, "got expected uid and gid");
-	else
-		tst_res(TFAIL, "got unexpected uid=%d gid=%d", uid, gid);
-
-	return 0;
-}
-
-static void setup(void)
-{
-	check_newuser();
+	TST_EXP_EQ_LI(uid, 100);
+	TST_EXP_EQ_LI(gid, 100);
 }
 
 static void run(void)
 {
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
 	int childpid;
 	int parentuid;
 	int parentgid;
 	char path[BUFSIZ];
 
-	childpid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
-	if (childpid < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
+	childpid = SAFE_CLONE(&args);
+	if (!childpid) {
+		child_fn1();
+		return;
+	}
 
 	parentuid = geteuid();
 	parentgid = getegid();
@@ -71,9 +62,9 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS",
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
