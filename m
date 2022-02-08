Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F12C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:10:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0243C9B2C
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:10:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE813C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C0A6601142
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ED6B1F383;
 Tue,  8 Feb 2022 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i92FbxeVcq5p5EGllYiu9/KmlzDt7AHiVS+Ao7XBlD0=;
 b=swYoeqATWvbNnTVUBcLgrb/4upYKjGV8opk7n6wEYzhWQDHuM/za5Pa2Sq9XK1hOMPPOBE
 NMzGSj6jIDlTTiWWe2q0G9t7IEJ0rQBjrX72plg4nC1rIAylp/YHFGDd1nLpzRZtR8+jl7
 dzeyd9VheQXTzr3W5IbdDzp8aX4haz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i92FbxeVcq5p5EGllYiu9/KmlzDt7AHiVS+Ao7XBlD0=;
 b=C+9lXRE9BlW6jHkCIoeDHE74/GBXwi0GYtjmZLmLeEw9mjL/6YeeJhzLI23Cn0qmJSnvRP
 Jg7ILIH5furrH3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47AB213C06;
 Tue,  8 Feb 2022 10:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6EFsD3BBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:41 +0100
Message-Id: <20220208100948.22913-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/9] Rewrite mesgq_nstest.c using new LTP API
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
 .../kernel/containers/sysvipc/mesgq_nstest.c  | 234 ++++++++----------
 1 file changed, 108 insertions(+), 126 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
index dbf311dc8..d0fc5ff34 100644
--- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
+++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
@@ -1,175 +1,157 @@
-/* *************************************************************************
-* Copyright (c) International Business Machines Corp., 2009
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*
-* In Parent Process , create mesgq with key 154326L
-* Now create container by passing 1 of the flag values..
-*	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In cloned process, try to access the created mesgq
-* Test PASS: If the mesgq is readable when flag is None.
-* Test FAIL: If the mesgq is readable when flag is Unshare or Clone.
-***************************************************************************/
-
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2009
+ *				Veerendra C <vechandr@in.ibm.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * In Parent Process , create mesgq with key 154326L
+ * Now create container by passing 1 of the flag values..
+ *	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
+ * In cloned process, try to access the created mesgq
+ * Test PASS: If the mesgq is readable when flag is None.
+ * Test FAIL: If the mesgq is readable when flag is Unshare or Clone.
+ */
+
+#define _GNU_SOURCE
+
 #include <sys/ipc.h>
+#include <sys/wait.h>
 #include <sys/msg.h>
-#include <libclone.h>
-#include "test.h"
-#include "ipcns_helper.h"
-
-#define KEY_VAL		154326L
-#define UNSHARESTR	"unshare"
-#define CLONESTR	"clone"
-#define NONESTR		"none"
-
-char *TCID = "mesgq_nstest";
-int TST_TOTAL = 1;
-int p1[2];
-int p2[2];
-struct msg_buf {
-	long int mtype;		/* type of received/sent message */
-	char mtext[80];		/* text of the message */
+#include <sys/types.h>
+#include "tst_test.h"
+#include "common.h"
+
+#define KEY_VAL 154326L
+
+static char *str_op = "clone";
+
+static int p1[2];
+static int p2[2];
+
+static struct msg_buf {
+	int mtype; /* type of received/sent message */
+	char mtext[80]; /* text of the message */
 } msg;
 
-void mesgq_read(int id)
+static void mesgq_read(int id)
 {
-	int READMAX = 80;
 	int n;
-	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
 
-	n = msgrcv(id, &msg, READMAX, 5, 0);
-	if (n == -1)
-		perror("msgrcv"), tst_exit();
+	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
+	n = msgrcv(id, &msg, sizeof(struct msg_buf) - sizeof(long), 5, 0);
+	if (n < 0)
+		tst_brk(TBROK, "msgrcv: %s", tst_strerrno(-n));
 
-	tst_resm(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s",
-		 n, msg.mtype, n, msg.mtext);
+	tst_res(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s", n,
+		msg.mtype, n, msg.mtext);
 }
 
-int check_mesgq(void *vtest)
+static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
 	char buf[3];
 	int id;
 
-	(void) vtest;
+	SAFE_CLOSE(p1[1]);
+	SAFE_CLOSE(p2[0]);
 
-	close(p1[1]);
-	close(p2[0]);
+	SAFE_READ(1, p1[0], buf, 3);
 
-	read(p1[0], buf, 3);
 	id = msgget(KEY_VAL, 0);
-	if (id == -1)
-		write(p2[1], "notfnd", 7);
+	if (id < 0)
+		SAFE_WRITE(1, p2[1], "notfnd", 7);
 	else {
-		write(p2[1], "exists", 7);
+		SAFE_WRITE(1, p2[1], "exists", 7);
 		mesgq_read(id);
 	}
-	tst_exit();
-}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	return 0;
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int ret, use_clone = T_NONE, id, n;
-	char *tsttype = NONESTR;
+	int use_clone = T_NONE, id, n;
 	char buf[7];
 
-	setup();
-
-	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
-		tst_brkm(TFAIL, NULL, " where clone, unshare, or fork specifies"
-			 " unshare method.");
-	}
-
 	/* Using PIPE's to sync between container and Parent */
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
+	SAFE_PIPE(p1);
+	SAFE_PIPE(p2);
 
-	tsttype = NONESTR;
-
-	if (strcmp(argv[1], "clone") == 0) {
+	if (!strcmp(str_op, "clone"))
 		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
+	else if (!strcmp(str_op, "unshare"))
 		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
 
 	id = msgget(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
-	if (id == -1) {
-		perror("msgget");
+	if (id < 0) {
 		/* Retry without attempting to create the MQ */
 		id = msgget(KEY_VAL, 0);
-		if (id == -1)
-			perror("msgget failure"), exit(1);
+		if (id < 0)
+			tst_brk(TBROK, "msgget: %s", tst_strerrno(-id));
 	}
 
 	msg.mtype = 5;
 	strcpy(msg.mtext, "Message of type 5!");
+
 	n = msgsnd(id, &msg, strlen(msg.mtext), 0);
-	if (n == -1)
-		perror("msgsnd"), tst_exit();
+	if (n < 0)
+		tst_brk(TBROK, "msgsnd: %s", tst_strerrno(-n));
 
-	tst_resm(TINFO, "mesgq namespaces test : %s", tsttype);
-	/* fire off the test */
-	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
-	if (ret < 0) {
-		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
-	}
+	tst_res(TINFO, "mesgq namespaces test : %s", str_op);
 
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], "go", 3);
-
-	read(p2[0], buf, 7);
-	if (strcmp(buf, "exists") == 0) {
-		if (use_clone == T_NONE)
-			tst_resm(TPASS, "Plain cloned process found mesgq "
-				 "inside container");
-		else
-			tst_resm(TFAIL,
-				 "%s: Container init process found mesgq",
-				 tsttype);
+	/* fire off the test */
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
+
+	SAFE_CLOSE(p1[0]);
+	SAFE_CLOSE(p2[1]);
+
+	SAFE_WRITE(1, p1[1], "go", 3);
+	SAFE_READ(1, p2[0], buf, 7);
+
+	if (!strcmp(buf, "exists")) {
+		if (use_clone == T_NONE) {
+			tst_res(TPASS, "Plain cloned process found mesgq "
+				       "inside container");
+		} else {
+			tst_res(TFAIL, "%s: Container init process found mesgq",
+				str_op);
+		}
 	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "Plain cloned process didn't find mesgq");
-		else
-			tst_resm(TPASS, "%s: Container didn't find mesgq",
-				 tsttype);
+		if (use_clone == T_NONE) {
+			tst_res(TFAIL,
+				"Plain cloned process didn't find mesgq");
+		} else {
+			tst_res(TPASS, "%s: Container didn't find mesgq",
+				str_op);
+		}
 	}
 
 	/* Delete the mesgQ */
 	id = msgget(KEY_VAL, 0);
 	msgctl(id, IPC_RMID, NULL);
+}
 
-	tst_exit();
+static void setup(void)
+{
+	check_newipc();
+
+	if (strcmp(str_op, "clone") && strcmp(str_op, "unshare") &&
+	    strcmp(str_op, "none"))
+		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options =
+		(struct tst_option[]){
+			{ "m:", &str_op,
+			  "Test execution mode <clone|unshare|none>" },
+			{},
+		},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
