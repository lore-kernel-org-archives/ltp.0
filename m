Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DF3C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:19:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9403CBF2A
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:19:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCD593CBF0C
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D70F92009FF
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7887220570;
 Wed, 15 Feb 2023 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KP2yZa4F7HqJ/+UIhNpi4Pw82Y/+2GcmmDy9gM0uaI=;
 b=RjFvjE+GhbsAtyfUgXrpLY8BG+Wym5xIbppzFen+w1kHFvqEpElHP6louRbpvgtYrC8Ezj
 hHqIp3XKMJu6HV7Wlpo5ggqkN8abmeyaGPHJr2PvkLBdsXgDfxi5BZwuEXPv+2dI7qVwwD
 aUCpJnZhRgA0qLGX7Tu+SaBxqzp/tAQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44FD513483;
 Wed, 15 Feb 2023 10:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kCkzDm2x7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:21 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:11 +0100
Message-Id: <20230215101615.27534-7-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 06/10] Refactor userns06 test
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
 testcases/kernel/containers/userns/userns06.c | 41 ++++++++-----------
 .../containers/userns/userns06_capcheck.c     | 19 ++++-----
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index 39f02e38a..a2c51f725 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -20,6 +20,7 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
+#include "lapi/sched.h"
 #include "common.h"
 
 #define TEST_APP "userns06_capcheck"
@@ -29,7 +30,7 @@
 #define CHILD2UID 200
 #define CHILD2GID 200
 
-static int child_fn1(void)
+static void child_fn1(void)
 {
 	char *const args[] = { TEST_APP, "privileged", NULL };
 	int ret;
@@ -39,11 +40,9 @@ static int child_fn1(void)
 	ret = execv(args[0], args);
 	if (ret == -1)
 		tst_brk(TBROK | TERRNO, "execv: unexpected error");
-
-	return 0;
 }
 
-static int child_fn2(void)
+static void child_fn2(void)
 {
 	int uid, gid, ret;
 	char *const args[] = { TEST_APP, "unprivileged", NULL };
@@ -53,27 +52,17 @@ static int child_fn2(void)
 	uid = geteuid();
 	gid = getegid();
 
-	if (uid != CHILD2UID || gid != CHILD2GID) {
-		tst_res(TFAIL, "unexpected uid=%d gid=%d", uid, gid);
-		return 1;
-	}
-
-	tst_res(TPASS, "expected uid and gid");
+	TST_EXP_EQ_LI(uid, CHILD2UID);
+	TST_EXP_EQ_LI(gid, CHILD2GID);
 
 	ret = execv(args[0], args);
 	if (ret == -1)
 		tst_brk(TBROK | TERRNO, "execv: unexpected error");
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
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
 	pid_t cpid1;
 	pid_t cpid2;
 	int parentuid;
@@ -84,13 +73,17 @@ static void run(void)
 	parentuid = geteuid();
 	parentgid = getegid();
 
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
-	if (cpid1 < 0)
-		tst_brk(TBROK | TTERRNO, "cpid1 clone failed");
+	cpid1 = SAFE_CLONE(&args);
+	if (!cpid1) {
+		child_fn1();
+		return;
+	}
 
-	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn2, NULL);
-	if (cpid2 < 0)
-		tst_brk(TBROK | TTERRNO, "cpid2 clone failed");
+	cpid2 = SAFE_CLONE(&args);
+	if (!cpid2) {
+		child_fn2();
+		return;
+	}
 
 	if (access("/proc/self/setgroups", F_OK) == 0) {
 		sprintf(path, "/proc/%d/setgroups", cpid1);
@@ -117,9 +110,9 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.resource_files = (const char *[]) {
 		TEST_APP,
diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
index c048ef63f..8669657b9 100644
--- a/testcases/kernel/containers/userns/userns06_capcheck.c
+++ b/testcases/kernel/containers/userns/userns06_capcheck.c
@@ -24,8 +24,8 @@ int main(int argc, char *argv[])
 {
 	cap_t caps;
 	int i, last_cap;
-	cap_flag_value_t flag_val;
-	cap_flag_value_t expected_flag = 1;
+	cap_flag_value_t cap_flag;
+	cap_flag_value_t expected_cap_flag = 1;
 
 	tst_reinit();
 
@@ -35,24 +35,21 @@ int main(int argc, char *argv[])
 	SAFE_FILE_SCANF("/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
 
 	if (strcmp("privileged", argv[1]))
-		expected_flag = 0;
+		expected_cap_flag = 0;
 
 	caps = cap_get_proc();
 
 	for (i = 0; i <= last_cap; i++) {
-		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
-		if (flag_val != expected_flag)
+		cap_get_flag(caps, i, CAP_EFFECTIVE, &cap_flag);
+		if (cap_flag != expected_cap_flag)
 			break;
 
-		cap_get_flag(caps, i, CAP_PERMITTED, &flag_val);
-		if (flag_val != expected_flag)
+		cap_get_flag(caps, i, CAP_PERMITTED, &cap_flag);
+		if (cap_flag != expected_cap_flag)
 			break;
 	}
 
-	if (flag_val != expected_flag)
-		tst_res(TFAIL, "unexpected effective/permitted caps at %d", i);
-	else
-		tst_res(TPASS, "expected caps at %d", i);
+	TST_EXP_EQ_LI(cap_flag, expected_cap_flag);
 
 	return 0;
 }
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
