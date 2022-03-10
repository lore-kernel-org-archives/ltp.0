Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9970C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C3213C1FE9
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:01:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D32B3C0FD6
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B25A20091A
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02D2821118;
 Thu, 10 Mar 2022 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyp/TC4m+gHJRXbq6TQIR5fuY8SH6DSlo/LSQI/DAF8=;
 b=fo9w8X+W5ISB7K+t5BTD98r+RWWeM8MMALqh/w4cvuJaw3gUNXTeGKU/YExU7KrIQJwTSl
 F3obQna3cy/olb52gnD7sl/46rexWkLzFczZg4CBXtuwXNWcUW6OpNGdmxpI4HIQc6IL80
 dwL3sNoJtqxd+kN6auoz89H8DkT1y+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyp/TC4m+gHJRXbq6TQIR5fuY8SH6DSlo/LSQI/DAF8=;
 b=zK0+DSMCrLFN3DkOi9j9IxxMsOYscH1C5ZKMLiwQf8+KKUo5R9D3iK0kPiYl3DkC/eLW67
 ADfU9t4jXagbKzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6E3813A3D;
 Thu, 10 Mar 2022 10:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eNekLgraKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:14 +0100
Message-Id: <20220310105916.7960-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310105916.7960-1-andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/10] Rewrite shmnstest.c using new LTP API
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
 .../kernel/containers/sysvipc/shmnstest.c     | 182 ++++++------------
 1 file changed, 62 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index cf69cab21..0b0b4a3b7 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -1,144 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) International Business Machines Corp., 2007
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
-* Author: Serge Hallyn <serue@us.ibm.com>
-*
-* Create shm with key 0xEAEAEA
-* clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In cloned process, try to get the created shm
+ * Copyright (c) International Business Machines Corp., 2007
+ *				Serge Hallyn <serue@us.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-***************************************************************************/
+/*\
+ * [Description]
+ *
+ * Test if SysV IPC shared memory with a specific key is shared between
+ * processes and namespaces.
+ */
+
+#define _GNU_SOURCE
 
-#define _GNU_SOURCE 1
 #include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include "ipcns_helper.h"
-#include "test.h"
+#include <sys/msg.h>
+#include <sys/types.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "common.h"
 
-char *TCID = "sysvipc_namespace";
-int TST_TOTAL = 1;
 #define TESTKEY 0xEAEAEA
 
-int p1[2];
-int p2[2];
+static char *str_op = "clone";
+static int use_clone;
+static int ipc_id = -1;
 
-int check_shmid(void *vtest)
+static int check_shmid(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[3];
-	int id;
-
-	(void) vtest;
-
-	close(p1[1]);
-	close(p2[0]);
-
-	read(p1[0], buf, 3);
-	id = shmget(TESTKEY, 100, 0);
-	if (id == -1) {
-		write(p2[1], "notfnd", 7);
+	TEST(shmget(TESTKEY, 100, 0));
+	if (TST_RET < 0) {
+		if (use_clone == T_NONE)
+			tst_res(TFAIL, "plain cloned process didn't find shmid");
+		else
+			tst_res(TPASS, "%s: child process didn't find shmid", str_op);
 	} else {
-		write(p2[1], "exists", 7);
-		shmctl(id, IPC_RMID, NULL);
+		if (use_clone == T_NONE)
+			tst_res(TPASS, "plain cloned process found shmid");
+		else
+			tst_res(TFAIL, "%s: child process found shmid", str_op);
 	}
 
-	tst_exit();
+	return 0;
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
-	check_newipc();
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
 }
 
-#define UNSHARESTR "unshare"
-#define CLONESTR "clone"
-#define NONESTR "none"
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int r, use_clone = T_NONE;
-	int id;
-	char *tsttype = NONESTR;
-	char buf[7];
+	use_clone = get_clone_unshare_enum(str_op);
 
-	setup();
+	if (use_clone != T_NONE)
+		check_newipc();
 
-	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
-		tst_brkm(TFAIL,
-			 NULL,
-			 " where clone, unshare, or fork specifies unshare method.");
-	}
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	tsttype = NONESTR;
-	if (strcmp(argv[1], "clone") == 0) {
-		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
-		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
-
-	/* first create the key */
-	id = shmget(TESTKEY, 100, IPC_CREAT);
-	if (id == -1) {
-		perror("shmget");
-		tst_brkm(TFAIL, NULL, "shmget failed");
-	}
-
-	tst_resm(TINFO, "shmid namespaces test : %s", tsttype);
-	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
-	if (r < 0) {
-		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
+	ipc_id = shmget(TESTKEY, 100, IPC_CREAT);
+	if (ipc_id < 0) {
+		tst_res(TINFO, "Shared memory already exist");
+		ipc_id = SAFE_SHMGET(TESTKEY, 100, 0);
 	}
+}
 
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], "go", 3);
-	read(p2[0], buf, 7);
-	if (strcmp(buf, "exists") == 0) {
-		if (use_clone == T_NONE)
-			tst_resm(TPASS, "plain cloned process found shmid");
-		else
-			tst_resm(TFAIL, "%s: child process found shmid",
-				 tsttype);
-	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "plain cloned process didn't find shmid");
-		else
-			tst_resm(TPASS, "%s: child process didn't find shmid",
-				 tsttype);
+static void cleanup(void)
+{
+	if (ipc_id != -1) {
+		tst_res(TINFO, "Delete shared memory");
+		SAFE_SHMCTL(ipc_id, IPC_RMID, NULL);
 	}
-
-	/* destroy the key */
-	shmctl(id, IPC_RMID, NULL);
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
+		{},
+	},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
