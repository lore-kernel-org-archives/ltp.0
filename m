Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E1C636D6
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:32:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31DCB3CBEED
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:31:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D7E3CB073
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:31:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7E7C7600913
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:31:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C683D222C9;
 Thu, 16 Feb 2023 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676543506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uCxmK1wqlPitxDtvETGf7qOW33wWk/sVt3MMHBnfGPU=;
 b=E3abfKIzsoPP2saLn+qdL8lDp97S2Veyc8xYJsHiGxmDjcMihUEfbN2FKlmM2Yd3Zl1Wx+
 QxfQ+UJhoGInnWnhshKByEbCPO4XJ+Ni9/olDJA7hE8G28F2/ftaAm84x8q2RkJ1nqf4EO
 LPxMvbJvffpclxLtz2L64reR9MekBoM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59EF2139B5;
 Thu, 16 Feb 2023 10:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZWUuEBIG7mOaRQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Feb 2023 10:31:46 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Feb 2023 11:29:42 +0100
Message-Id: <20230216102942.11859-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Remove ltp_quick_clone from mountns testing suite
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

ltp_quick_clone has been replaced by SAFE_CLONE in the mountns testing
suite that now is independed from libclone and legacy API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/mountns/mountns.h  | 18 ------------------
 .../kernel/containers/mountns/mountns01.c      | 16 ++++++++--------
 .../kernel/containers/mountns/mountns02.c      | 16 ++++++++--------
 .../kernel/containers/mountns/mountns03.c      | 16 ++++++++--------
 .../kernel/containers/mountns/mountns04.c      |  2 +-
 5 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
index 615f1a058..9bb854659 100644
--- a/testcases/kernel/containers/mountns/mountns.h
+++ b/testcases/kernel/containers/mountns/mountns.h
@@ -8,28 +8,10 @@
 #define COMMON_H
 
 #include "tst_test.h"
-#include "lapi/sched.h"
 
 #define DIRA "LTP_DIR_A"
 #define DIRB "LTP_DIR_B"
 
-static int dummy_child(void *v)
-{
-	(void)v;
-	return 0;
-}
-
-static void check_newns(void)
-{
-	int pid, status;
-
-	pid = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, dummy_child, NULL);
-	if (pid < 0)
-		tst_brk(TCONF, "CLONE_NEWNS not supported");
-
-	SAFE_WAIT(&status);
-}
-
 static void umount_folders(void)
 {
 	if (tst_is_mounted(DIRA))
diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index e8f176920..c5b6077f1 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -33,8 +33,9 @@
 #include <sys/mount.h>
 #include "mountns.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	TST_CHECKPOINT_WAIT(0);
 
@@ -51,13 +52,11 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_UMOUNT(DIRA);
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
 
 	SAFE_UNSHARE(CLONE_NEWNS);
 
@@ -67,9 +66,10 @@ static void run(void)
 	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
 	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
 
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
+	}
 
 	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
@@ -93,7 +93,6 @@ static void run(void)
 
 static void setup(void)
 {
-	check_newns();
 	create_folders();
 }
 
@@ -107,5 +106,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index 4b85fa79b..c2260961e 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -34,8 +34,9 @@
 #include <sys/mount.h>
 #include "mountns.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	TST_CHECKPOINT_WAIT(0);
 
@@ -51,13 +52,11 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_UMOUNT(DIRA);
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
 
 	SAFE_UNSHARE(CLONE_NEWNS);
 
@@ -68,9 +67,10 @@ static void run(void)
 
 	SAFE_MOUNT("none", DIRA, "none", MS_PRIVATE, NULL);
 
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
+	}
 
 	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
@@ -94,7 +94,6 @@ static void run(void)
 
 static void setup(void)
 {
-	check_newns();
 	create_folders();
 }
 
@@ -108,5 +107,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 1d26a25d8..357a4f30b 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -36,8 +36,9 @@
 #include <sys/mount.h>
 #include "mountns.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	/*
 	 * makes mount DIRA a slave of DIRA (all slave mounts have
@@ -59,13 +60,11 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	SAFE_UMOUNT(DIRA);
-
-	return 0;
 }
 
 static void run(void)
 {
-	int ret;
+	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
 
 	SAFE_UNSHARE(CLONE_NEWNS);
 
@@ -76,9 +75,10 @@ static void run(void)
 
 	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
 
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
-	if (ret < 0)
-		tst_brk(TBROK, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
+	}
 
 	TST_CHECKPOINT_WAIT(0);
 
@@ -104,7 +104,6 @@ static void run(void)
 
 static void setup(void)
 {
-	check_newns();
 	create_folders();
 }
 
@@ -118,5 +117,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.needs_root = 1,
+	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
index fc392f1a7..6a64c2443 100644
--- a/testcases/kernel/containers/mountns/mountns04.c
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -22,6 +22,7 @@
 #include <sys/mount.h>
 #include "mountns.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
 static void run(void)
 {
@@ -46,7 +47,6 @@ static void run(void)
 
 static void setup(void)
 {
-	check_newns();
 	create_folders();
 }
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
