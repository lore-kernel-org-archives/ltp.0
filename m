Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A86EC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:59:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49683C6AD5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:59:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28613C0E6D
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20AE7600E5B
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B862C21119;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWat7jwQka2pVQmfZWylAexDG1L3PIMbB9VOYDOUVRE=;
 b=1lGZeXnAgu3gyu9CvOuNUqzj2zVE2KIBqHK2XDOV9kuBt/bhkWoQdslkCBNpuHVfP5qNpj
 CP46BjZ5KlyYQuNnFwmBjLJ19s4WlaHF0n3k4owM5fIZHB8NMMpg+ilksjgMZjjxXpi6ZW
 5sRdzG2h+j3IWVLEVLmgr0WPqqG2bBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWat7jwQka2pVQmfZWylAexDG1L3PIMbB9VOYDOUVRE=;
 b=yJs4wDTVOJ8xTVx+jdcwzFa17RB1NPCkPcU9bMZaM4a4OQ8GR1hHHSERH8KzJBNC4VWAQp
 n6aRJKKYoaFQSnDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9312713A3D;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GEz3IQnaKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:08 +0100
Message-Id: <20220310105916.7960-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310105916.7960-1-andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/10] Rewrite msg_comm.c using new LTP API
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
 .../kernel/containers/sysvipc/msg_comm.c      | 180 ++++++------------
 1 file changed, 55 insertions(+), 125 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/msg_comm.c b/testcases/kernel/containers/sysvipc/msg_comm.c
index 0da328997..0dce423f0 100644
--- a/testcases/kernel/containers/sysvipc/msg_comm.c
+++ b/testcases/kernel/containers/sysvipc/msg_comm.c
@@ -1,20 +1,16 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Test SysV IPC message passing through different processes.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- ***********************************************************************
- * File: msg_comm.c
+ * [Algorithm]
  *
- * Description:
  * 1. Clones two child processes with CLONE_NEWIPC flag, each child
  *    gets System V message queue (msg) with the _identical_ key.
  * 2. Child1 appends a message with identifier #1 to the message queue.
@@ -27,152 +23,86 @@
  */
 
 #define _GNU_SOURCE
-#include <sys/ipc.h>
+
+#include <sys/wait.h>
 #include <sys/msg.h>
 #include <sys/types.h>
-#include <sys/wait.h>
-#include <stdio.h>
-#include <errno.h>
-#include "ipcns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "common.h"
 
 #define TESTKEY 124426L
-#define MSGSIZE 50
-char *TCID	= "msg_comm";
-int TST_TOTAL	= 1;
 
 struct sysv_msg {
 	long mtype;
-	char mtext[MSGSIZE];
+	char mtext[1];
 };
 
-static void cleanup(void)
+static int chld1_msg(LTP_ATTRIBUTE_UNUSED void *arg)
 {
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
-
-int chld1_msg(void *arg)
-{
-	int id, n, rval = 0;
+	int id;
 	struct sysv_msg m;
 	struct sysv_msg rec;
 
-	id = msgget(TESTKEY, IPC_CREAT | 0600);
-	if (id == -1) {
-		perror("msgget");
-		return 2;
-	}
+	id = SAFE_MSGGET(TESTKEY, IPC_CREAT | 0600);
 
 	m.mtype = 1;
 	m.mtext[0] = 'A';
-	if (msgsnd(id, &m, sizeof(struct sysv_msg) - sizeof(long), 0) == -1) {
-		perror("msgsnd");
-		msgctl(id, IPC_RMID, NULL);
-		return 2;
-	}
 
-	/* wait for child2 to write into the message queue */
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	SAFE_MSGSND(id, &m, sizeof(struct sysv_msg) - sizeof(long), 0);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	TEST(msgrcv(id, &rec, sizeof(struct sysv_msg) - sizeof(long), 2, IPC_NOWAIT));
+	if (TST_RET < 0 && TST_ERR != ENOMSG)
+		tst_brk(TBROK | TERRNO, "msgrcv error");
 
 	/* if child1 message queue has changed (by child2) report fail */
-	n = msgrcv(id, &rec, sizeof(struct sysv_msg) - sizeof(long),
-		   2, IPC_NOWAIT);
-	if (n == -1 && errno != ENOMSG) {
-		perror("msgrcv");
-		msgctl(id, IPC_RMID, NULL);
-		return 2;
-	}
-	/* if mtype #2 was found in the message queue, it is fail */
-	if (n > 0) {
-		rval = 1;
-	}
-
-	/* tell child2 to continue */
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-
-	msgctl(id, IPC_RMID, NULL);
-	return rval;
+	if (TST_RET > 0)
+		tst_res(TFAIL, "SysV msg: communication with non-identical keys between namespaces");
+	else
+		tst_res(TPASS, "SysV msg: communication with identical keys between namespaces");
+
+	TST_CHECKPOINT_WAKE(0);
+
+	SAFE_MSGCTL(id, IPC_RMID, NULL);
+
+	return 0;
 }
 
-int chld2_msg(void *arg)
+static int chld2_msg(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int id;
 	struct sysv_msg m;
 
-	id = msgget(TESTKEY, IPC_CREAT | 0600);
-	if (id == -1) {
-		perror("msgget");
-		return 2;
-	}
+	id = SAFE_MSGGET(TESTKEY, IPC_CREAT | 0600);
 
 	m.mtype = 2;
 	m.mtext[0] = 'B';
-	if (msgsnd(id, &m, sizeof(struct sysv_msg) - sizeof(long), 0) == -1) {
-		perror("msgsnd");
-		msgctl(id, IPC_RMID, NULL);
-		return 2;
-	}
 
-	/* tell child1 to continue and wait for it */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	SAFE_MSGSND(id, &m, sizeof(struct sysv_msg) - sizeof(long), 0);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_MSGCTL(id, IPC_RMID, NULL);
 
-	msgctl(id, IPC_RMID, NULL);
 	return 0;
 }
 
-static void test(void)
+static void run(void)
 {
-	int status, ret = 0;
-
-	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_msg, NULL);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_msg, NULL);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-
-	while (wait(&status) > 0) {
-		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
-			ret = 1;
-		if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
-			tst_brkm(TBROK | TERRNO, cleanup, "error in child");
-		if (WIFSIGNALED(status)) {
-			tst_resm(TFAIL, "child was killed with signal %s",
-					tst_strsig(WTERMSIG(status)));
-			return;
-		}
-	}
-
-	if (ret)
-		tst_resm(TFAIL, "SysV msg: communication with identical keys"
-				" between namespaces");
-	else
-		tst_resm(TPASS, "SysV msg: communication with identical keys"
-				" between namespaces");
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_msg, NULL);
+	clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_msg, NULL);
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
