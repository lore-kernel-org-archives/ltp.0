Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E7C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:10:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E90943C9B37
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:10:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F2F93C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D76531001180
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCB221106;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYvtUPML9VcZQoTjVHdVsDRKIfmHS1+14PubaNSNxlI=;
 b=O/hae9CBDxh9Tq0NpuGTpx3wLO3ezewELkyuCHsK9tKWgd/pGomoftW0JA4fPOquqB2VsX
 30Ygxga5jL3onpiqWHruyMnCWZweLboWDbynxF2nkE1YJsj6R3ajvKtjZY9795bKSziGdE
 PbUJOv7lDAoWVtDhoWh04p+gSduUKE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYvtUPML9VcZQoTjVHdVsDRKIfmHS1+14PubaNSNxlI=;
 b=lGePpcb2ZQiTIQyHXrtw9vgxfuAueSaXbnNP1SXmMn/CTxH0qumTzZ83GboKJSBoVam9lB
 6JnXs8kDwr5Pg4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54FB113C06;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EN3DEnFBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:46 +0100
Message-Id: <20220208100948.22913-8-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 7/9] Rewrite shm_comm.c using new LTP API
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
 .../kernel/containers/sysvipc/shm_comm.c      | 144 +++++++-----------
 1 file changed, 55 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shm_comm.c b/testcases/kernel/containers/sysvipc/shm_comm.c
index 4b3bbfaa8..297486131 100644
--- a/testcases/kernel/containers/sysvipc/shm_comm.c
+++ b/testcases/kernel/containers/sysvipc/shm_comm.c
@@ -1,20 +1,12 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- ***********************************************************************
- * File: shm_comm.c
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * 1. Clones two child processes with CLONE_NEWIPC flag, each child
  *    allocates System V shared memory segment (shm) with the _identical_
  *    key and attaches that segment into its address space.
@@ -27,141 +19,115 @@
  */
 
 #define _GNU_SOURCE
+
 #include <sys/ipc.h>
 #include <sys/shm.h>
-#include <sys/types.h>
 #include <sys/wait.h>
-#include <stdio.h>
-#include <errno.h>
-#include "ipcns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
-
+#include <sys/msg.h>
+#include <sys/types.h>
+#include "tst_test.h"
+#include "common.h"
 
 #define TESTKEY 124426L
 #define SHMSIZE 50
-char *TCID	= "shm_comm";
-int TST_TOTAL	= 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(tst_rmdir);
-}
 
-int chld1_shm(void *arg)
+static int chld1_shm(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int id, rval = 0;
 	char *shmem;
 
 	id = shmget(TESTKEY, SHMSIZE, IPC_CREAT);
-	if (id == -1) {
-		perror("shmget");
-		return 2;
-	}
+	if (id < 0)
+		tst_brk(TBROK, "shmget: %s", tst_strerrno(-id));
 
-	if ((shmem = shmat(id, NULL, 0)) == (char *) -1) {
-		perror("shmat");
+	shmem = shmat(id, NULL, 0);
+	if (shmem == (char *)-1) {
 		shmctl(id, IPC_RMID, NULL);
-		return 2;
+		tst_brk(TBROK, "shmem error");
 	}
 
 	*shmem = 'A';
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	/* if child1 shared segment has changed (by child2) report fail */
 	if (*shmem != 'A')
 		rval = 1;
 
 	/* tell child2 to continue */
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_CHECKPOINT_WAKE(0);
 
 	shmdt(shmem);
 	shmctl(id, IPC_RMID, NULL);
+
 	return rval;
 }
 
-int chld2_shm(void *arg)
+static int chld2_shm(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int id;
 	char *shmem;
 
 	id = shmget(TESTKEY, SHMSIZE, IPC_CREAT);
-	if (id == -1) {
-		perror("shmget");
-		return 2;
-	}
+	if (id < 0)
+		tst_brk(TBROK, "shmget: %s", tst_strerrno(-id));
 
-	if ((shmem = shmat(id, NULL, 0)) == (char *) -1) {
-		perror("shmat");
+	shmem = shmat(id, NULL, 0);
+	if (shmem == (char *)-1) {
 		shmctl(id, IPC_RMID, NULL);
-		return 2;
+		tst_brk(TBROK, "shmem error");
 	}
 
 	/* wait for child1 to write to his segment */
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 
 	*shmem = 'B';
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	shmdt(shmem);
 	shmctl(id, IPC_RMID, NULL);
+
 	return 0;
 }
 
-static void test(void)
+static void run(void)
 {
 	int status, ret = 0;
 
-	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_shm, NULL);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_shm, NULL);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_shm, NULL);
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_shm, NULL);
 
 	while (wait(&status) > 0) {
 		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
 			ret = 1;
+
 		if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
-			tst_brkm(TBROK | TERRNO, cleanup, "error in child");
+			tst_brk(TBROK, "error in child");
+
 		if (WIFSIGNALED(status)) {
-			tst_resm(TFAIL, "child was killed with signal %s",
-					tst_strsig(WTERMSIG(status)));
-			return;
+			tst_brk(TBROK, "child was killed with signal %s",
+				tst_strsig(WTERMSIG(status)));
 		}
 	}
 
-	if (ret)
-		tst_resm(TFAIL, "SysV shm: communication with identical keys"
-				" between namespaces");
-	else
-		tst_resm(TPASS, "SysV shm: communication with identical keys"
-				" between namespaces");
+	if (ret) {
+		tst_res(TFAIL, "SysV shm: communication with identical keys"
+			       " between namespaces");
+	} else {
+		tst_res(TPASS, "SysV shm: communication with identical keys"
+			       " between namespaces");
+	}
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		test();
-
-	cleanup();
-	tst_exit();
+	check_newipc();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
