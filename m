Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D3C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:37:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9851F3C91BC
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:37:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B8373C5A8A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70A211001262
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05AD11F7AE;
 Fri, 25 Mar 2022 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648200989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDgF7KbQiA1rzjtiGLDKZ0Im7qwcLcimlH9E0NNGNZM=;
 b=rejmOkY12vL20n88zppwlrTr1Y1VQG+6jakNb27hKZybR2KD4G1BNcq3r5SuG9W8q+sDoD
 1LXSqiyktPoChc9HveqglSq4Ud0xQiEeOA9hyXrBcjouYGwKpkaNFntx9qG6SPFn1XztZ8
 eoYYx9sGEcY4NBJGmbe3ZpVGHra7tE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648200989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDgF7KbQiA1rzjtiGLDKZ0Im7qwcLcimlH9E0NNGNZM=;
 b=xzQMkDvZRDU4AMHMVM61K7ci1iovKpHxmOOPbgkH7sHORx7syKJX6NDYxZsgM4LCT1z+YE
 vD2ciuBzqQ1bGyDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D00E6132E9;
 Fri, 25 Mar 2022 09:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cIaDMByNPWI1BQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 09:36:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 10:36:20 +0100
Message-Id: <20220325093626.11114-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325093626.11114-1-andrea.cervesato@suse.de>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/9] Rewrite userns03.c using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/containers/userns/userns03.c | 284 ++++++++----------
 1 file changed, 129 insertions(+), 155 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index be511fec8..9a6f1b54a 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -1,24 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version. This program is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
- * Public License for more details. You should have received a copy of the GNU
- * General Public License along with this program.
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Verify that:
- * /proc/PID/uid_map and /proc/PID/gid_map contains three values separated by
- * white space:
+/*\
+ * [Description]
+ *
+ * Verify that /proc/PID/uid_map and /proc/PID/gid_map contains three values
+ * separated by white space:
+ *
  * ID-inside-ns   ID-outside-ns   length
  *
  * ID-outside-ns is interpreted according to which process is opening the file.
+ *
  * If the process opening the file is in the same user namespace as the process
  * PID, then ID-outside-ns is defined with respect to the parent user namespace.
+ *
  * If the process opening the file is in a different user namespace, then
  * ID-outside-ns is defined with respect to the user namespace of the process
  * opening the file.
@@ -26,29 +24,16 @@
  * The string "deny" would be written to /proc/self/setgroups before GID
  * check if setgroups is allowed, see kernel commits:
  *
- *   commit 9cc46516ddf497ea16e8d7cb986ae03a0f6b92f8
- *   Author: Eric W. Biederman <ebiederm@xmission.com>
- *   Date:   Tue Dec 2 12:27:26 2014 -0600
- *     userns: Add a knob to disable setgroups on a per user namespace basis
- *
- *   commit 66d2f338ee4c449396b6f99f5e75cd18eb6df272
- *   Author: Eric W. Biederman <ebiederm@xmission.com>
- *   Date:   Fri Dec 5 19:36:04 2014 -0600
- *     userns: Allow setting gid_maps without privilege when setgroups is disabled
- *
+ * * 9cc46516ddf4 ("userns: Add a knob to disable setgroups on a per user namespace basis")
+ * * 66d2f338ee4c ("userns: Allow setting gid_maps without privilege when setgroups is disabled")
  */
 
 #define _GNU_SOURCE
-#include <sys/wait.h>
-#include <assert.h>
+
 #include <stdio.h>
-#include <stdlib.h>
 #include <stdbool.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "userns_helper.h"
-#include "test.h"
+#include "common.h"
+#include "tst_test.h"
 
 #define CHILD1UID 0
 #define CHILD1GID 0
@@ -57,16 +42,16 @@
 #define UID_MAP 0
 #define GID_MAP 1
 
-char *TCID = "user_namespace3";
-int TST_TOTAL = 1;
-static int cpid1, parentuid, parentgid;
+static int cpid1;
+static int parentuid;
+static int parentgid;
 
 /*
  * child_fn1() - Inside a new user namespace
  */
 static int child_fn1(void)
 {
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 	return 0;
 }
 
@@ -75,161 +60,150 @@ static int child_fn1(void)
  */
 static int child_fn2(void)
 {
-	int exit_val = 0;
 	int uid, gid;
 	char cpid1uidpath[BUFSIZ];
 	char cpid1gidpath[BUFSIZ];
 	int idinsidens, idoutsidens, length;
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
+	TST_CHECKPOINT_WAIT(1);
 
 	uid = geteuid();
 	gid = getegid();
 
-	if (uid != CHILD2UID || gid != CHILD2GID) {
-		printf("unexpected uid=%d gid=%d\n", uid, gid);
-		exit_val = 1;
-	}
+	tst_res(TINFO, "uid=%d, gid=%d", uid, gid);
+
+	if (uid != CHILD2UID || gid != CHILD2GID)
+		tst_res(TFAIL, "unexpected uid=%d gid=%d", uid, gid);
+	else
+		tst_res(TPASS, "expected uid and gid");
 
-	/*Get the uid parameters of the child_fn2 process.*/
-	SAFE_FILE_SCANF(NULL, "/proc/self/uid_map", "%d %d %d", &idinsidens,
-		&idoutsidens, &length);
+	/* Get the uid parameters of the child_fn2 process */
+	SAFE_FILE_SCANF("/proc/self/uid_map", "%d %d %d", &idinsidens, &idoutsidens, &length);
 
 	/* map file format:ID-inside-ns   ID-outside-ns   length
-	If the process opening the file is in the same user namespace as
-	the process PID, then ID-outside-ns is defined with respect to the
-	 parent user namespace.*/
-	if (idinsidens != CHILD2UID || idoutsidens != parentuid) {
-		printf("child_fn2 checks /proc/cpid2/uid_map:\n");
-		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
-			idinsidens, idoutsidens);
-		exit_val = 1;
-	}
+	 * If the process opening the file is in the same user namespace as
+	 * the process PID, then ID-outside-ns is defined with respect to the
+	 * parent user namespace
+	 */
+	tst_res(TINFO, "child2 checks /proc/cpid2/uid_map");
+
+	if (idinsidens != CHILD2UID || idoutsidens != parentuid)
+		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
+	else
+		tst_res(TPASS, "expected namespaces IDs");
 
 	sprintf(cpid1uidpath, "/proc/%d/uid_map", cpid1);
-	SAFE_FILE_SCANF(NULL, cpid1uidpath, "%d %d %d", &idinsidens,
-		&idoutsidens, &length);
+	SAFE_FILE_SCANF(cpid1uidpath, "%d %d %d", &idinsidens, &idoutsidens, &length);
 
 	/* If the process opening the file is in a different user namespace,
-	then ID-outside-ns is defined with respect to the user namespace
-	of the process opening the file.*/
-	if (idinsidens != CHILD1UID || idoutsidens != CHILD2UID) {
-		printf("child_fn2 checks /proc/cpid1/uid_map:\n");
-		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
-			idinsidens, idoutsidens);
-		exit_val = 1;
-	}
+	 * then ID-outside-ns is defined with respect to the user namespace
+	 * of the process opening the file
+	 */
+	tst_res(TINFO, "child2 checks /proc/cpid1/uid_map");
+
+	if (idinsidens != CHILD1UID || idoutsidens != CHILD2UID)
+		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
+	else
+		tst_res(TPASS, "expected namespaces IDs");
 
 	sprintf(cpid1gidpath, "/proc/%d/gid_map", cpid1);
-	SAFE_FILE_SCANF(NULL, "/proc/self/gid_map", "%d %d %d",
-		 &idinsidens, &idoutsidens, &length);
-
-	if (idinsidens != CHILD2GID || idoutsidens != parentgid) {
-		printf("child_fn2 checks /proc/cpid2/gid_map:\n");
-		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
-			idinsidens, idoutsidens);
-		exit_val = 1;
-	}
+	SAFE_FILE_SCANF("/proc/self/gid_map", "%d %d %d", &idinsidens, &idoutsidens, &length);
 
-	SAFE_FILE_SCANF(NULL, cpid1gidpath, "%d %d %d", &idinsidens,
-		&idoutsidens, &length);
+	tst_res(TINFO, "child2 checks /proc/cpid2/gid_map");
 
-	if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID) {
-		printf("child_fn1 checks /proc/cpid1/gid_map:\n");
-		printf("unexpected: idinsidens=%d idoutsidens=%d\n",
-			idinsidens, idoutsidens);
-		exit_val = 1;
-	}
+	if (idinsidens != CHILD2GID || idoutsidens != parentgid)
+		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
+	else
+		tst_res(TPASS, "expected namespaces IDs");
 
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 1);
-	return exit_val;
-}
+	SAFE_FILE_SCANF(cpid1gidpath, "%d %d %d", &idinsidens, &idoutsidens, &length);
 
-static void cleanup(void)
-{
-	tst_rmdir();
+	tst_res(TINFO, "child1 checks /proc/cpid1/gid_map");
+
+	if (idinsidens != CHILD1GID || idoutsidens != CHILD2GID)
+		tst_res(TFAIL, "unexpected: namespace ID inside=%d outside=%d", idinsidens, idoutsidens);
+	else
+		tst_res(TPASS, "expected namespaces IDs");
+
+	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAKE(1);
+
+	return 0;
 }
 
 static void setup(void)
 {
 	check_newuser();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(NULL);
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
 	pid_t cpid2;
 	char path[BUFSIZ];
-	int lc;
 	int fd;
 	int ret;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		parentuid = geteuid();
-		parentgid = getegid();
-
-		cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-			(void *)child_fn1, NULL);
-		if (cpid1 < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				"cpid1 clone failed");
-
-		cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-			(void *)child_fn2, NULL);
-		if (cpid2 < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				"cpid2 clone failed");
-
-		if (access("/proc/self/setgroups", F_OK) == 0) {
-			sprintf(path, "/proc/%d/setgroups", cpid1);
-			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
-			SAFE_CLOSE(cleanup, fd);
-			/* If the setgroups file has the value "deny",
-			 * then the setgroups(2) system call can't
-			 * subsequently be reenabled (by writing "allow" to
-			 * the file) in this user namespace.  (Attempts to
-			 * do so will fail with the error EPERM.)
-			*/
-
-			/* test that setgroups can't be re-enabled */
-			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-			ret = write(fd, "allow", 5);
-
-			if (ret != -1) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					"write action should fail");
-			} else if (errno != EPERM) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					"unexpected error: \n");
-			}
-			SAFE_CLOSE(cleanup, fd);
-			tst_resm(TPASS, "setgroups can't be re-enabled");
-
-			sprintf(path, "/proc/%d/setgroups", cpid2);
-			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
-			SAFE_CLOSE(cleanup, fd);
-		}
-
-		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid, cleanup);
-		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid, cleanup);
-
-		updatemap(cpid1, GID_MAP, CHILD1GID, parentgid, cleanup);
-		updatemap(cpid2, GID_MAP, CHILD2GID, parentgid, cleanup);
-
-		TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 1);
-
-		tst_record_childstatus(cleanup, cpid1);
-		tst_record_childstatus(cleanup, cpid2);
+	parentuid = geteuid();
+	parentgid = getegid();
+
+	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
+	if (cpid1 < 0)
+		tst_brk(TBROK | TTERRNO, "cpid1 clone failed");
+
+	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn2, NULL);
+	if (cpid2 < 0)
+		tst_brk(TBROK | TTERRNO, "cpid2 clone failed");
+
+	if (access("/proc/self/setgroups", F_OK) == 0) {
+		sprintf(path, "/proc/%d/setgroups", cpid1);
+
+		fd = SAFE_OPEN(path, O_WRONLY, 0644);
+		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_CLOSE(fd);
+
+		/* If the setgroups file has the value "deny",
+		 * then the setgroups(2) system call can't
+		 * subsequently be reenabled (by writing "allow" to
+		 * the file) in this user namespace.  (Attempts to
+		 * do so will fail with the error EPERM.)
+		 */
+
+		/* test that setgroups can't be re-enabled */
+		fd = SAFE_OPEN(path, O_WRONLY, 0644);
+		ret = write(fd, "allow", 5);
+
+		if (ret != -1)
+			tst_brk(TBROK, "write action should fail");
+		else if (errno != EPERM)
+			tst_brk(TBROK | TTERRNO, "unexpected error");
+
+		SAFE_CLOSE(fd);
+
+		tst_res(TPASS, "setgroups can't be re-enabled");
+
+		sprintf(path, "/proc/%d/setgroups", cpid2);
+
+		fd = SAFE_OPEN(path, O_WRONLY, 0644);
+		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_CLOSE(fd);
 	}
-	cleanup();
-	tst_exit();
+
+	updatemap(cpid1, UID_MAP, CHILD1UID, parentuid);
+	updatemap(cpid2, UID_MAP, CHILD2UID, parentuid);
+
+	updatemap(cpid1, GID_MAP, CHILD1GID, parentgid);
+	updatemap(cpid2, GID_MAP, CHILD2GID, parentgid);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(1);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		NULL,
+	},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
