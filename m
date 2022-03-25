Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C470C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 12:56:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F9853C9338
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 13:55:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1B833C189A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:54:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 59393601AF2
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:54:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0F3F210FC;
 Fri, 25 Mar 2022 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648212887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGFDu5Nxsp0y/nAQLBr3Jzp78/uFA30wVLjztJq3VbU=;
 b=0SdexQuSqGEXx2jYlZ8bp1W5ssgPOZ35ENjpDvNoPtkLaQg/U2rNzORps5Trzq9p00qra/
 RSe9WLlU/ksOTia1RNhHreekfN6K1e4AGdTeWb5uJq51k1YXG53Ui2zESE2H4+3t9FciEF
 MKSm+VI8uG3+qn+VWj2ZYnAK7op9R2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648212887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGFDu5Nxsp0y/nAQLBr3Jzp78/uFA30wVLjztJq3VbU=;
 b=7PGILLNTDexVtOg2sy8STYlxz34siIQwThh/rRStsxwH06+23abNrQkSh+P34JvBKy6CJd
 HWwaDaRcoL9KznDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C96B31332D;
 Fri, 25 Mar 2022 12:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WKwwL5e7PWKoZgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 12:54:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 13:54:41 +0100
Message-Id: <20220325125445.11984-7-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325125445.11984-1-andrea.cervesato@suse.de>
References: <20220325125445.11984-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 06/10] Rewrite shmnstest.c using new LTP API
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

Updated containers runtest file to include new shmnstest.c options.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/containers                            |   6 +-
 .../kernel/containers/sysvipc/shmnstest.c     | 180 ++++++------------
 2 files changed, 62 insertions(+), 124 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 3130ccfbd..b1b9b522a 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -43,9 +43,9 @@ netns_comm_ip_ipv4_ioctl netns_comm.sh ip ipv4 ioctl
 netns_comm_ip_ipv6_ioctl netns_comm.sh ip ipv6 ioctl
 netns_sysfs netns_sysfs.sh
 
-shmnstest_none shmnstest none
-shmnstest_clone shmnstest clone
-shmnstest_unshare shmnstest unshare
+shmnstest_none shmnstest -m none
+shmnstest_clone shmnstest -m clone
+shmnstest_unshare shmnstest -m unshare
 shmem_2nstest_none shmem_2nstest none
 shmem_2nstest_clone shmem_2nstest clone
 shmem_2nstest_unshare shmem_2nstest unshare
diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index cf69cab21..bb8435a67 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -1,144 +1,82 @@
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
+static char *str_op;
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
-
-	setup();
-
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
+	use_clone = get_clone_unshare_enum(str_op);
 
-	/* first create the key */
-	id = shmget(TESTKEY, 100, IPC_CREAT);
-	if (id == -1) {
-		perror("shmget");
-		tst_brkm(TFAIL, NULL, "shmget failed");
-	}
+	if (use_clone != T_NONE)
+		check_newipc();
 
-	tst_resm(TINFO, "shmid namespaces test : %s", tsttype);
-	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
-	if (r < 0) {
-		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
-	}
+	ipc_id = shmget(TESTKEY, 100, IPC_CREAT);
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
