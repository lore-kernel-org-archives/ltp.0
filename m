Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA47BC636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:19:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5B13CC3D5
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:19:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95DBC3CBEFF
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17A0310009FA
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF3FD227CD;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHr99kYvPr2WZSQ/ZzLGOSV0GY9I6sADQ8oF15XNvCE=;
 b=UiI+8khyoF0ZrF17x7w94WbviHstcZ8ji1kBGjo9tcs4HA2t56ehb5xtY9CU0dfxDVFTgO
 WhdwIyIO/uZJt3Q1GKVN/tqnhC0ydv2AuYRVhsJyMwa1F7/SmiPWrE0A8QgDLFiBSuAkMj
 /Znm+dL7Q0Gmg9fEa38selSgiaDAXPo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC30313483;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IISEJ2yx7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:20 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:09 +0100
Message-Id: <20230215101615.27534-5-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 04/10] Refactor userns04 test
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
 testcases/kernel/containers/userns/userns04.c | 45 +++++++------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
index d8639502e..58ae7c302 100644
--- a/testcases/kernel/containers/userns/userns04.c
+++ b/testcases/kernel/containers/userns/userns04.c
@@ -15,56 +15,46 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
-#include "common.h"
 #include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "lapi/sched.h"
 
-static void setup(void)
-{
-	check_newuser();
-	tst_syscall(__NR_setns, -1, 0);
-}
-
-static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_fn1(void)
 {
 	TST_CHECKPOINT_WAIT(0);
-	return 0;
 }
 
-static int child_fn2(void *arg)
+static void child_fn2(int fd)
 {
-	TEST(tst_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER));
-	if (TST_RET != -1 || TST_ERR != EPERM)
-		tst_res(TFAIL | TERRNO, "child2 setns() error");
-	else
-		tst_res(TPASS, "child2 setns() failed as expected");
-
+	TST_EXP_FAIL(setns(fd, CLONE_NEWUSER), EPERM);
 	TST_CHECKPOINT_WAIT(1);
-
-	return 0;
 }
 
 static void run(void)
 {
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
 	pid_t cpid1, cpid2, cpid3;
 	char path[BUFSIZ];
 	int fd;
 
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
-	if (cpid1 < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
+	cpid1 = SAFE_CLONE(&args);
+	if (!cpid1) {
+		child_fn1();
+		return;
+	}
 
 	sprintf(path, "/proc/%d/ns/user", cpid1);
 
 	fd = SAFE_OPEN(path, O_RDONLY, 0644);
-	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn2, (void *)((long)fd));
-	if (cpid2 < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
 
-	/* child 3 - throw-away process changing ns to child1 */
+	cpid2 = SAFE_CLONE(&args);
+	if (!cpid2) {
+		child_fn2(fd);
+		return;
+	}
+
 	cpid3 = SAFE_FORK();
 	if (!cpid3) {
-		TST_EXP_PASS(tst_syscall(__NR_setns, fd, CLONE_NEWUSER));
+		TST_EXP_PASS(setns(fd, CLONE_NEWUSER));
 		return;
 	}
 
@@ -75,7 +65,6 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
