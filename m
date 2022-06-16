Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEA0C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 14:08:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA6643C87C6
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 16:08:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A472D3C19CA
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 08BBA200CF1
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A963C1F8F0;
 Thu, 16 Jun 2022 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655388444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBqxsZ0FXRwyBdR5+5OuOvFEPmrD5bEIl0Fs2+rcV6o=;
 b=IVoyT4SWVDfDJVtDo3giO7U2AmMLjxJfIEWPtpWKohCM8CRdn5h2HzIJmyrv/JnuNBYIrR
 7BgA9/GAhM9JwSN9jpHRe0B5QOk63dAKOJEk8EJNBvl+DXDJLR9sd8rzC5BZX5WfYIDjXU
 QWJp1K4q+CxjDoA6UgDEhTt2i1mRBeI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B3FC13A70;
 Thu, 16 Jun 2022 14:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sJGxGxw5q2IlJwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Jun 2022 14:07:24 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Jun 2022 16:07:13 +0200
Message-Id: <20220616140717.23708-4-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616140717.23708-1-andrea.cervesato@suse.com>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] Refactor mqns_02 using new LTP API
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
 runtest/containers                         |   5 +-
 testcases/kernel/containers/mqns/mqns_02.c | 225 ++++++---------------
 2 files changed, 68 insertions(+), 162 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 073e206d0..77785edd3 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -18,8 +18,9 @@ pidns32 pidns32
 mqns_01_none mqns_01 -m none
 mqns_01_clone mqns_01 -m clone
 mqns_01_unshare mqns_01 -m unshare
-mqns_02 mqns_02
-mqns_02_clone mqns_02 -clone
+mqns_02_none mqns_02 -m none
+mqns_02_clone mqns_02 -m clone
+mqns_02_unshare mqns_02 -m unshare
 mqns_03 mqns_03
 mqns_03_clone mqns_03 -clone
 mqns_04 mqns_04
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index d4e785b59..e04e23de4 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -1,180 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) International Business Machines Corp., 2009
-* Copyright (c) Nadia Derbey, 2009
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
-* Author: Nadia Derbey <Nadia.Derbey@bull.net>
-*
-* Check mqns isolation: child mqns cannot be accessed from father
-*
-* Mount mqueue fs
-* unshare
-* In unshared process:
-*    Mount newinstance mqueuefs
-*    Create a posix mq -->mq1
-* Check that mq1 is not readable from father
-*
-* Changelog:
-*	Dec 16: accomodate new mqns semantics (Serge Hallyn)
-
-***************************************************************************/
-
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <sys/wait.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include "mqns.h"
-#include "mqns_helper.h"
-
-char *TCID = "posixmq_namespace_02";
-int TST_TOTAL = 1;
-
-int p1[2];
-int p2[2];
-
-int check_mqueue(void *vtest)
+ * Copyright (c) International Business Machines Corp., 2009
+ * Copyright (c) Nadia Derbey, 2009 <Nadia.Derbey@bull.net>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Create a mqueue with the same name in both parent and isolated/forked child,
+ * then check namespace isolation.
+ */
+
+#include "common.h"
+
+#define MQNAME "/MQ1"
+
+static mqd_t mqd;
+static char *str_op;
+static int use_clone;
+
+static int check_mqueue(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[30];
-	mqd_t mqd;
+	mqd_t mqd1;
 
-	(void) vtest;
+	mqd1 = mq_open(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
 
-	close(p1[1]);
-	close(p2[0]);
+	if (use_clone == T_NONE) {
+		if (mqd1 == -1)
+			tst_res(TPASS, "Can't create queue from plain cloned process");
+		else
+			tst_res(TFAIL, "Queue has been created form plain cloned process");
 
-	if (read(p1[0], buf, 3) < 0) {
-		perror("read(p1[0], ..) failed");
-		exit(1);
-	} else {
+		return 0;
+	}
 
-		mqd =
-		    tst_syscall(__NR_mq_open, NOSLASH_MQ1,
-			    O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
-		if (mqd == -1) {
-			if (write(p2[1], "mqfail", strlen("mqfail") + 1) < 0) {
-				perror("write(p2[1], \"mqfail\", ..) failed");
-				exit(1);
-			}
-		} else {
-
-			if (write(p2[1], "mqopen", strlen("mqopen") + 1) < 0) {
-				perror("write(p2[1], \"mqopen\", ..) failed");
-				exit(1);
-			} else {
-
-				if (read(p1[0], buf, 5) < 0) {
-					perror("read(p1[0], ..) failed");
-					exit(1);
-				} else {
-
-					/* destroy the mqueue */
-					if (mq_close(mqd) < 0) {
-						perror("mq_close(mqd) failed");
-						exit(1);
-					} else if (tst_syscall(__NR_mq_unlink,
-							   NOSLASH_MQ1) < 0) {
-						perror("mq_unlink(" NOSLASH_MQ1
-						       ") failed");
-						exit(1);
-					} else if (write(p2[1], "done",
-							 strlen("done") + 1)
-						   < 0) {
-						perror("write(p2[1], "
-						       "\"done\", ..) failed");
-						exit(1);
-					}
-
-				}
-
-			}
-
-		}
+	if (mqd1 == -1) {
+		tst_res(TFAIL, "Queue hasn't been created from isolated process");
+	} else {
+		tst_res(TPASS, "Created queue from isolated process");
 
+		SAFE_MQ_CLOSE(mqd1);
+		SAFE_MQ_UNLINK(MQNAME);
 	}
-	exit(0);
 
+	return 0;
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
-	check_mqns();
+	tst_res(TINFO, "Checking namespaces isolation from parent to child");
+
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int r;
-	mqd_t mqd;
-	char buf[30];
-	int use_clone = T_UNSHARE;
-
-	setup();
-
-	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).");
-		use_clone = T_CLONE;
-	} else
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).");
-
-	if (pipe(p1) == -1 || pipe(p2) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "pipe");
-	}
+	use_clone = get_clone_unshare_enum(str_op);
 
-	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (r < 0) {
-		tst_brkm(TFAIL, NULL, "failed clone/unshare");
-	}
+	if (use_clone != T_NONE)
+		check_newipc();
 
-	tst_resm(TINFO, "Checking namespaces isolation (child to parent)");
-
-	close(p1[0]);
-	close(p2[1]);
-	if (write(p1[1], "go", strlen("go") + 1) < 0) {
-		tst_brkm(TBROK, NULL, "write(p1[1], \"go\", ..) failed");
-	}
+	SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
+}
 
-	if (read(p2[0], buf, 7) < 0) {
-		tst_resm(TBROK | TERRNO, "read(p2[0], ..) failed");
-	} else if (!strcmp(buf, "mqfail")) {
-		tst_resm(TFAIL, "child process could not create mqueue");
-		umount(DEV_MQUEUE);
-	} else if (strcmp(buf, "mqopen")) {
-		tst_resm(TFAIL, "child process could not create mqueue");
-		umount(DEV_MQUEUE);
-	} else {
-		mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
-		if (mqd == -1) {
-			tst_resm(TPASS,
-				 "Parent process can't see the mqueue");
-		} else {
-			tst_resm(TFAIL | TERRNO,
-				 "Parent process found mqueue");
-			mq_close(mqd);
-		}
-		if (write(p1[1], "cont", 5) < 0) {
-			tst_resm(TBROK | TERRNO, "write(p1[1], ..) failed");
-		}
-		read(p2[0], buf, 7);
+static void cleanup(void)
+{
+	if (mqd != -1) {
+		SAFE_MQ_CLOSE(mqd);
+		SAFE_MQ_UNLINK(MQNAME);
 	}
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
