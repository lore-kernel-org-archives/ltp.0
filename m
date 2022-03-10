Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D4C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:00:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D4753C6FDD
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:00:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A05523C0FB4
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1AC33600E5A
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC044210EE;
 Thu, 10 Mar 2022 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USfWFeGV8ml2A6m8c+GW6g826iGp3vJ+x8FGJ/S9Hco=;
 b=xYlHNMYVJW/KOsMoJ5zvi3j0+v0mksWxpm/B9bOHLru6O8MOgN4CBfWWgtWSo383Ykz804
 7HPu5O0uujUFhkxfQRgK5YgyMA5KTDkHu79NJ/CSPMDoTUB/lkRCz/0tNDC0ZX8cvALP0Y
 7AJTdR/w0G7CkscjgwhIxE2WBW6gp58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USfWFeGV8ml2A6m8c+GW6g826iGp3vJ+x8FGJ/S9Hco=;
 b=EyLoLafZjhPa5HfLqSr5pj2gtJjk9my2lNqEcnBKr3NhPUk3RscCypbINv+/tNjjymH7e9
 G17s+O7R4rB9NpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96C6813A3D;
 Thu, 10 Mar 2022 10:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +BKvIgraKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:13 +0100
Message-Id: <20220310105916.7960-8-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310105916.7960-1-andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/10] Rewrite shmem_2nstest.c using new LTP API
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
 .../kernel/containers/sysvipc/shmem_2nstest.c | 239 ++++++------------
 1 file changed, 83 insertions(+), 156 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index b172ee07c..fe3715509 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -1,187 +1,114 @@
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
-* Test Assertion:
-* This testcase verifies the Shared Memory isoloation in 2 containers.
-* It tries to create/access a Shared Memory created with the same KEY.
-*
-* Description:
-* Create 2 'containers' with the below flag value
-*   Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In Cont1, create Shared Memory segment with key 124426L
-* In Cont2, try to access the MQ created in Cont1.
-* PASS :
-* 		If flag = None and the shmem seg is accessible in Cont2.
-*		If flag = unshare/clone and the shmem seg is not accessible in Cont2.
-* 		If shmem seg is not accessible in Cont2,
-*		creates new shmem with same key to double check isloation in IPCNS.
-*
-* FAIL :
-* 		If flag = none and the shmem seg is not accessible.
-* 		If flag = unshare/clone and shmem seg is accessible in Cont2.
-*		If the new shmem seg creation Fails.
-***************************************************************************/
-
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include <libclone.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "ipcns_helper.h"
-
-#define TESTKEY    124426L
-#define UNSHARESTR "unshare"
-#define CLONESTR   "clone"
-#define NONESTR    "none"
-
-char *TCID = "shmem_2nstest";
-int TST_TOTAL = 1;
-int p2[2];
-int p1[2];
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * check_shmem1() does not read -- it writes to check_shmem2() when it's done.
+ * Copyright (c) International Business Machines Corp., 2009
+ *				Veerendra C <vechandr@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if SysV IPC shared memory is properly used between two namespaces.
+ *
+ * [Algorithm]
+ *
+ * Create two 'containers'.
+ * In container1, create Shared Memory segment with a specific key.
+ * In container2, try to access the MQ created in container1.
+ *
+ * Test is PASS if flag = none and the shmem seg is accessible in container2.
+ * If flag = unshare/clone and the shmem seg is not accessible in container2.
+ * If shmem seg is not accessible in container2, creates new shmem with same
+ * key to double check isloation in IPCNS.
+ *
+ * Test is FAIL if flag = none and the shmem seg is not accessible, if
+ * flag = unshare/clone and shmem seg is accessible in container2 or if the new
+ * shmem seg creation Fails.
  */
-int check_shmem1(void *vtest)
-{
-	int id1;
 
-	(void) vtest;
+#define _GNU_SOURCE
 
-	close(p1[0]);
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "common.h"
 
-	/* first create the key */
-	id1 = shmget(TESTKEY, 100, IPC_CREAT);
-	if (id1 == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "shmget failed");
+#define TESTKEY 124426L
 
-	tst_resm(TINFO, "Cont1: Able to create shared mem segment");
-	write(p1[1], "done", 5);
-	tst_exit();
-}
+static char *str_op = "clone";
+static int use_clone;
 
 /*
- * check_shmem2() reads from check_shmem1() and writes to main() when it's done.
+ * check_shmem1() does not read -- it writes to check_shmem2() when it's done.
  */
-int check_shmem2(void *vtest)
+static int check_shmem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[3];
-	int id2;
+	SAFE_SHMGET(TESTKEY, 100, IPC_CREAT);
 
-	(void) vtest;
+	tst_res(TINFO, "container1: able to create shared mem segment");
 
-	close(p1[1]);
-	close(p2[0]);
+	TST_CHECKPOINT_WAKE(0);
 
-	read(p1[0], buf, 3);
-	/* Trying to access shmem, if not existing create new shmem */
-	id2 = shmget(TESTKEY, 100, 0);
-	if (id2 == -1) {
-		id2 = shmget(TESTKEY, 100, IPC_CREAT);
-		if (id2 == -1)
-			tst_resm(TFAIL | TERRNO, "shmget failed");
-		else
-			tst_resm(TINFO,
-				 "Cont2: Able to allocate shmem seg with "
-				 "the same key");
-		write(p2[1], "notfnd", 7);
-	} else
-		write(p2[1], "exists", 7);
-
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	return 0;
 }
 
-int main(int argc, char *argv[])
+/*
+ * check_shmem2() reads from check_shmem1() and writes to main() when it's done.
+ */
+static int check_shmem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	int ret, use_clone = T_NONE;
-	char *tsttype = NONESTR;
-	char buf[7];
 	int id;
 
-	setup();
+	TST_CHECKPOINT_WAIT(0);
 
-	if (argc != 2) {
-		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
-		tst_resm(TINFO, " where clone, unshare, or fork specifies"
-			 " unshare method.");
-		tst_exit();
-	}
-
-	/* Using PIPE's to sync between containers and Parent */
-	SAFE_PIPE(NULL, p1);
-	SAFE_PIPE(NULL, p2);
-
-	if (strcmp(argv[1], "clone") == 0) {
-		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
-		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
+	TEST(shmget(TESTKEY, 100, 0));
 
-	tst_resm(TINFO, "Shared Memory namespace test : %s", tsttype);
+	if (TST_RET < 0) {
+		SAFE_SHMGET(TESTKEY, 100, IPC_CREAT);
 
-	/* Create 2 containers */
-	ret =
-	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1, NULL);
-	if (ret < 0)
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
+		tst_res(TINFO, "container2: able to allocate shmem seg with the same key");
 
-	ret =
-	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2, NULL);
-	if (ret < 0)
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
-
-	close(p2[1]);
-	read(p2[0], buf, 7);
-
-	if (strcmp(buf, "exists") == 0) {
 		if (use_clone == T_NONE)
-			tst_resm(TPASS,
-				 "Plain cloned process able to access shmem "
-				 "segment created");
+			tst_res(TFAIL, "Plain cloned process didn't find shmem segment");
 		else
-			tst_resm(TFAIL,
-				 "%s : In namespace2 found the shmem segment "
-				 "created in Namespace1", tsttype);
+			tst_res(TPASS, "%s: in namespace2 unable to access the shmem seg created in namespace1", str_op);
 	} else {
 		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "Plain cloned process didn't find shmem seg");
+			tst_res(TPASS, "Plain cloned process able to access shmem segment created");
 		else
-			tst_resm(TPASS,
-				 "%s : In namespace2 unable to access the shmem seg "
-				 "created in Namespace1", tsttype);
+			tst_res(TFAIL, "%s: in namespace2 found the shmem segment created in namespace1", str_op);
 	}
-	/* destroy the key */
 
-	id = shmget(TESTKEY, 100, 0);
-	shmctl(id, IPC_RMID, NULL);
+	id = SAFE_SHMGET(TESTKEY, 100, 0);
+	SAFE_SHMCTL(id, IPC_RMID, NULL);
 
-	tst_exit();
+	return 0;
 }
+
+static void run(void)
+{
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2, NULL);
+}
+
+static void setup(void)
+{
+	use_clone = get_clone_unshare_enum(str_op);
+
+	if (use_clone != T_NONE)
+		check_newipc();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
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
