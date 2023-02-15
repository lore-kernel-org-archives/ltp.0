Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF2C636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:19:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 953403C010A
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:19:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A14A93CBF08
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2672D1400BF4
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD31A20571;
 Wed, 15 Feb 2023 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBvdF7RKQU8bbk+no9U/Fuif49/OsPil5EsJK9n1LO0=;
 b=tsgUQ6QTmEw+jLpZKzcaMpisJIWs+oD1N/joE7MijGmV4gr3zZbB38KrCREaBHCuzlhO2m
 4t+LMXpOZiBWg7Xfq0N2Dy4vxBif/+Cd/jxKUU8QMFfi9SCCvzRFZNFKFWSYGJNsqky0/3
 XDwlv++fTH0yWQt2ahE2Z3tD1CeTv8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AF6713483;
 Wed, 15 Feb 2023 10:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2LMxH22x7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:21 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:12 +0100
Message-Id: <20230215101615.27534-8-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 07/10] Refactor userns07 test
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
 testcases/kernel/containers/userns/userns07.c | 67 +++++++++++--------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 4659de636..3a693b8e3 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -16,80 +16,89 @@
 #include <sys/wait.h>
 #include "common.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
 #define MAXNEST 32
 
-static void setup(void)
-{
-	check_newuser();
-}
+static int *level;
 
-static int child_fn1(void *arg)
+static void child_fn1(void)
 {
-	pid_t cpid1;
-	long level = (long)arg;
-	int status;
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	pid_t cpid;
 	int parentuid;
 	int parentgid;
+	int status;
 
 	TST_CHECKPOINT_WAIT(0);
 
-	if (level == MAXNEST) {
+	if (*level == MAXNEST) {
 		tst_res(TPASS, "nested all children");
-		return 0;
+		return;
 	}
 
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)(level + 1));
-	if (cpid1 < 0) {
-		tst_res(TFAIL | TERRNO, "level %ld, unexpected error", level);
-		return 1;
+	cpid = SAFE_CLONE(&args);
+	if (!cpid) {
+		*level += 1;
+		child_fn1();
+		return;
 	}
 
 	parentuid = geteuid();
 	parentgid = getegid();
 
-	updatemap(cpid1, UID_MAP, 0, parentuid);
-	updatemap(cpid1, GID_MAP, 0, parentgid);
+	updatemap(cpid, UID_MAP, 0, parentuid);
+	updatemap(cpid, GID_MAP, 0, parentgid);
 
 	TST_CHECKPOINT_WAKE(0);
 
-	SAFE_WAITPID(cpid1, &status, 0);
-
-	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-		tst_brk(TBROK, "child %s", tst_strstatus(status));
-
-	return 0;
+	SAFE_WAITPID(cpid, &status, 0);
 }
 
 static void run(void)
 {
-	pid_t cpid1;
+	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
+	pid_t cpid;
 	int parentuid;
 	int parentgid;
 	char path[BUFSIZ];
 
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)0);
-	if (cpid1 < 0)
-		tst_brk(TBROK | TTERRNO, "clone failed");
+	cpid = SAFE_CLONE(&args);
+	if (!cpid) {
+		child_fn1();
+		return;
+	}
 
 	parentuid = geteuid();
 	parentgid = getegid();
 
 	if (access("/proc/self/setgroups", F_OK) == 0) {
-		sprintf(path, "/proc/%d/setgroups", cpid1);
+		sprintf(path, "/proc/%d/setgroups", cpid);
 		SAFE_FILE_PRINTF(path, "deny");
 	}
 
-	updatemap(cpid1, UID_MAP, 0, parentuid);
-	updatemap(cpid1, GID_MAP, 0, parentgid);
+	updatemap(cpid, UID_MAP, 0, parentuid);
+	updatemap(cpid, GID_MAP, 0, parentgid);
 
 	TST_CHECKPOINT_WAKE(0);
 }
 
+static void setup(void)
+{
+	level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(level, sizeof(int));
+}
+
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
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
