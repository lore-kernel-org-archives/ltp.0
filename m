Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CDEC636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:19:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20D773CBF1B
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:18:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20D43CBEFF
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 483CC1400960
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C35220572;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xX/QJ5Ba9sAgm8xdNNNPtqKAC79X1CYv8Tp4oL1MqA4=;
 b=uenjhrMitMewuvEvKsdVb4x6jJvpsBTE3GzedUApsvz4FVFdYkNhuFPm3jYErm3XrnuNj2
 4jpn6tA00oE0I33+ZfAHW3zGzlSBb/f1ShrGFrgm2mB/oumanaIWZ4XDzXTysvhSuoH28d
 IlkLimQAU124EJWcCy8xmSDElsFcu8g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B84413483;
 Wed, 15 Feb 2023 10:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6LK7F2yx7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:20 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:08 +0100
Message-Id: <20230215101615.27534-4-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 03/10] Refactor userns03 test
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
 testcases/kernel/containers/userns/userns03.c | 70 +++++++------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index b90cc09ba..4dd3f1a73 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -32,8 +32,9 @@
 
 #include <stdio.h>
 #include <stdbool.h>
-#include "common.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
+#include "common.h"
 
 #define CHILD1UID 0
 #define CHILD1GID 0
@@ -42,23 +43,12 @@
 #define UID_MAP 0
 #define GID_MAP 1
 
-static int cpid1;
-static int parentuid;
-static int parentgid;
-
-/*
- * child_fn1() - Inside a new user namespace
- */
-static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_fn1(void)
 {
 	TST_CHECKPOINT_WAIT(0);
-	return 0;
 }
 
-/*
- * child_fn2() - Inside a new user namespace
- */
-static int child_fn2(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_fn2(int cpid1, int parentuid, int parentgid)
 {
 	int uid, gid;
 	char cpid1uidpath[BUFSIZ];
@@ -70,12 +60,8 @@ static int child_fn2(LTP_ATTRIBUTE_UNUSED void *arg)
 	uid = geteuid();
 	gid = getegid();
 
-	tst_res(TINFO, "uid=%d, gid=%d", uid, gid);
-
-	if (uid != CHILD2UID || gid != CHILD2GID)
-		tst_res(TFAIL, "unexpected uid=%d gid=%d", uid, gid);
-	else
-		tst_res(TPASS, "expected uid and gid");
+	TST_EXP_EQ_LI(uid, CHILD2UID);
+	TST_EXP_EQ_LI(gid, CHILD2GID);
 
 	/* Get the uid parameters of the child_fn2 process */
 	SAFE_FILE_SCANF("/proc/self/uid_map", "%d %d %d", &idinsidens, &idoutsidens, &length);
@@ -127,32 +113,31 @@ static int child_fn2(LTP_ATTRIBUTE_UNUSED void *arg)
 
 	TST_CHECKPOINT_WAKE(0);
 	TST_CHECKPOINT_WAKE(1);
-
-	return 0;
-}
-
-static void setup(void)
-{
-	check_newuser();
 }
 
 static void run(void)
 {
-	pid_t cpid2;
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	pid_t cpid1, cpid2;
+	uid_t parentuid;
+	gid_t parentgid;
 	char path[BUFSIZ];
 	int fd;
-	int ret;
 
 	parentuid = geteuid();
 	parentgid = getegid();
 
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
-	if (cpid1 < 0)
-		tst_brk(TBROK | TTERRNO, "cpid1 clone failed");
+	cpid1 = SAFE_CLONE(&args);
+	if (!cpid1) {
+		child_fn1();
+		return;
+	}
 
-	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn2, NULL);
-	if (cpid2 < 0)
-		tst_brk(TBROK | TTERRNO, "cpid2 clone failed");
+	cpid2 = SAFE_CLONE(&args);
+	if (!cpid2) {
+		child_fn2(cpid1, parentuid, parentgid);
+		return;
+	}
 
 	if (access("/proc/self/setgroups", F_OK) == 0) {
 		sprintf(path, "/proc/%d/setgroups", cpid1);
@@ -168,19 +153,12 @@ static void run(void)
 		 * do so will fail with the error EPERM.)
 		 */
 
-		/* test that setgroups can't be re-enabled */
-		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		ret = write(fd, "allow", 5);
-
-		if (ret != -1)
-			tst_brk(TBROK, "write action should fail");
-		else if (errno != EPERM)
-			tst_brk(TBROK | TTERRNO, "unexpected error");
+		tst_res(TINFO, "Check if setgroups can be re-enabled");
 
+		fd = SAFE_OPEN(path, O_WRONLY, 0644);
+		TST_EXP_FAIL(write(fd, "allow", 5), EPERM);
 		SAFE_CLOSE(fd);
 
-		tst_res(TPASS, "setgroups can't be re-enabled");
-
 		sprintf(path, "/proc/%d/setgroups", cpid2);
 
 		fd = SAFE_OPEN(path, O_WRONLY, 0644);
@@ -198,9 +176,9 @@ static void run(void)
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
