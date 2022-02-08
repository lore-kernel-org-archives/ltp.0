Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C81C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:11:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29D23C9B43
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:11:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C76A13C9B3B
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 193C7200B28
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF7AA210FE;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DC6TGXxnc6AOls4hm7ad1dDIT7aO2TFNo2e8LY36Qyk=;
 b=fVEzvtbPV+Tbb8NhZeQO4J4Ogui2e0IN3uSwIzpvHN7QJgfefvC4p5IasPisJg++DsLvU2
 x6F0mjtBUr7rXGPc8fMkASuubWApZ7b3a66icdLqmut0SR85WeaAYEq2UZmPhZgObQqr2d
 XMEMjnYgaCmq/QZcrjQn+JDcyZFmJuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DC6TGXxnc6AOls4hm7ad1dDIT7aO2TFNo2e8LY36Qyk=;
 b=SpuRr0OGDUdnxZ0P1G3dS5u+RRNiIboNbX8MYGyKW2H26Dvacpulb5OQIBbU6064CgRg05
 Jqmozq3eYN1a/YBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8814C13BF9;
 Tue,  8 Feb 2022 10:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aPpLH3FBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:47 +0100
Message-Id: <20220208100948.22913-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 8/9] Rewrite shmem_2nstest.c using new LTP API
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
 .../kernel/containers/sysvipc/shmem_2nstest.c | 262 ++++++++----------
 1 file changed, 122 insertions(+), 140 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index b172ee07c..8f64f365c 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -1,187 +1,169 @@
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
+ * Create 2 'containers' with the below flag value
+ *   Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
+ * In Cont1, create Shared Memory segment with key 124426L
+ * In Cont2, try to access the MQ created in Cont1.
+ * PASS :
+ *  If flag = None and the shmem seg is accessible in Cont2.
+ *  If flag = unshare/clone and the shmem seg is not accessible in
+ * Cont2. If shmem seg is not accessible in Cont2, creates new shmem with same
+ * key to double check isloation in IPCNS.
+ *
+ * FAIL :
+ *  If flag = none and the shmem seg is not accessible.
+ *  If flag = unshare/clone and shmem seg is accessible in Cont2.
+ *  If the new shmem seg creation Fails.
+ */
+
+#define _GNU_SOURCE
+
 #include <sys/ipc.h>
 #include <sys/shm.h>
-#include <libclone.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "ipcns_helper.h"
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+#include "tst_test.h"
+#include "common.h"
+
+#define TESTKEY 124426L
 
-#define TESTKEY    124426L
-#define UNSHARESTR "unshare"
-#define CLONESTR   "clone"
-#define NONESTR    "none"
+static char *str_op = "clone";
 
-char *TCID = "shmem_2nstest";
-int TST_TOTAL = 1;
-int p2[2];
-int p1[2];
+static int p1[2];
+static int p2[2];
 
 /*
  * check_shmem1() does not read -- it writes to check_shmem2() when it's done.
  */
-int check_shmem1(void *vtest)
+static int check_shmem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	int id1;
+	SAFE_CLOSE(p1[0]);
 
-	(void) vtest;
+	/* first create the key */
+	TEST(shmget(TESTKEY, 100, IPC_CREAT));
+	if (TST_RET < 0)
+		tst_brk(TBROK, "shmget: %s", tst_strerrno(-TST_ERR));
 
-	close(p1[0]);
+	tst_res(TINFO, "Cont1: Able to create shared mem segment");
 
-	/* first create the key */
-	id1 = shmget(TESTKEY, 100, IPC_CREAT);
-	if (id1 == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "shmget failed");
+	SAFE_WRITE(1, p1[1], "done", 5);
 
-	tst_resm(TINFO, "Cont1: Able to create shared mem segment");
-	write(p1[1], "done", 5);
-	tst_exit();
+	return 0;
 }
 
 /*
  * check_shmem2() reads from check_shmem1() and writes to main() when it's done.
  */
-int check_shmem2(void *vtest)
+static int check_shmem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
 	char buf[3];
-	int id2;
 
-	(void) vtest;
+	SAFE_CLOSE(p1[1]);
+	SAFE_CLOSE(p2[0]);
 
-	close(p1[1]);
-	close(p2[0]);
+	SAFE_READ(1, p1[0], buf, 3);
 
-	read(p1[0], buf, 3);
 	/* Trying to access shmem, if not existing create new shmem */
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
+	TEST(shmget(TESTKEY, 100, 0));
+	if (TST_RET < 0) {
+		TEST(shmget(TESTKEY, 100, IPC_CREAT));
+
+		if (TST_RET < 0) {
+			tst_brk(TBROK, "shmget: %s", tst_strerrno(-TST_ERR));
+		} else {
+			tst_res(TINFO, "Cont2: Able to allocate shmem seg with "
+				       "the same key");
+		}
+
+		SAFE_WRITE(1, p2[1], "notfnd", 7);
+	} else {
+		SAFE_WRITE(1, p2[1], "exists", 7);
+	}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	return 0;
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int ret, use_clone = T_NONE;
-	char *tsttype = NONESTR;
+	int use_clone = T_NONE;
 	char buf[7];
 	int id;
 
-	setup();
-
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
+	/* Using PIPE's to sync between container and Parent */
+	SAFE_PIPE(p1);
+	SAFE_PIPE(p2);
 
-	if (strcmp(argv[1], "clone") == 0) {
+	if (!strcmp(str_op, "clone"))
 		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], "unshare") == 0) {
+	else if (!strcmp(str_op, "unshare"))
 		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
 
-	tst_resm(TINFO, "Shared Memory namespace test : %s", tsttype);
+	tst_res(TINFO, "Shared Memory namespace test : %s", str_op);
 
 	/* Create 2 containers */
-	ret =
-	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1, NULL);
-	if (ret < 0)
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
-
-	ret =
-	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2, NULL);
-	if (ret < 0)
-		tst_brkm(TFAIL, NULL, "clone/unshare failed");
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem1, NULL);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmem2, NULL);
 
-	close(p2[1]);
-	read(p2[0], buf, 7);
+	SAFE_CLOSE(p2[1]);
+	SAFE_READ(1, p2[0], buf, 7);
 
 	if (strcmp(buf, "exists") == 0) {
-		if (use_clone == T_NONE)
-			tst_resm(TPASS,
-				 "Plain cloned process able to access shmem "
-				 "segment created");
-		else
-			tst_resm(TFAIL,
-				 "%s : In namespace2 found the shmem segment "
-				 "created in Namespace1", tsttype);
+		if (use_clone == T_NONE) {
+			tst_res(TPASS,
+				"Plain cloned process able to access shmem "
+				"segment created");
+		} else {
+			tst_res(TFAIL,
+				"%s : In namespace2 found the shmem segment "
+				"created in Namespace1",
+				str_op);
+		}
 	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 "Plain cloned process didn't find shmem seg");
-		else
-			tst_resm(TPASS,
-				 "%s : In namespace2 unable to access the shmem seg "
-				 "created in Namespace1", tsttype);
+		if (use_clone == T_NONE) {
+			tst_res(TFAIL,
+				"Plain cloned process didn't find shmem seg");
+		} else {
+			tst_res(TPASS,
+				"%s : In namespace2 unable to access the "
+				"shmem seg "
+				"created in Namespace1",
+				str_op);
+		}
 	}
-	/* destroy the key */
 
+	/* destroy the key */
 	id = shmget(TESTKEY, 100, 0);
 	shmctl(id, IPC_RMID, NULL);
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
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
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
