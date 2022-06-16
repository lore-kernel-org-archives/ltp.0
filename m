Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5578AC433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 14:07:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 836E63C641F
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 16:07:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 771913C19CA
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDFC91A01140
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C06521B6F;
 Thu, 16 Jun 2022 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655388444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zltuR2MX4Gko7X3fxOtDU3+j1JUopQHP+a3TRbRsqg=;
 b=V5QhGzhgXlUEPQ2VhI9U4pjMVcJLdJimuvXAo8cKXffC7AhTSXr7az+YeRY6si82fstMVq
 af5O5r2E9iOpXPx73fNdznP1L/qqq9CVuRXSpFGrDnB+nA/cKKlcLTJ9PL3Bd5SUP2FXI4
 Hv/VmGJ5VBKOL6liRd75Ysha53DQXkk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DF0A13A70;
 Thu, 16 Jun 2022 14:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0EmnDBw5q2IlJwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Jun 2022 14:07:24 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Jun 2022 16:07:12 +0200
Message-Id: <20220616140717.23708-3-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616140717.23708-1-andrea.cervesato@suse.com>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] Refactor mqns_01 using new LTP API
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
 testcases/kernel/containers/mqns/common.h  | 101 +++++++++++
 testcases/kernel/containers/mqns/mqns_01.c | 195 +++++++--------------
 3 files changed, 169 insertions(+), 132 deletions(-)
 create mode 100644 testcases/kernel/containers/mqns/common.h

diff --git a/runtest/containers b/runtest/containers
index 2637b62fe..073e206d0 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -15,8 +15,9 @@ pidns30 pidns30
 pidns31 pidns31
 pidns32 pidns32
 
-mqns_01 mqns_01
-mqns_01_clone mqns_01 -clone
+mqns_01_none mqns_01 -m none
+mqns_01_clone mqns_01 -m clone
+mqns_01_unshare mqns_01 -m unshare
 mqns_02 mqns_02
 mqns_02_clone mqns_02 -clone
 mqns_03 mqns_03
diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
new file mode 100644
index 000000000..58ddfe5f4
--- /dev/null
+++ b/testcases/kernel/containers/mqns/common.h
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef MQNS_COMMON_H
+#define MQNS_COMMON_H
+
+#include <stdlib.h>
+#include "lapi/namespaces_constants.h"
+#include "tst_test.h"
+#include "tst_safe_posix_ipc.h"
+
+enum {
+	T_CLONE,
+	T_UNSHARE,
+	T_NONE,
+};
+
+static int dummy_child1(void *v)
+{
+	(void)v;
+	return 0;
+}
+
+static void check_newipc(void)
+{
+	int pid, status;
+
+	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1, NULL);
+	if (pid < 0)
+		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
+
+	SAFE_WAITPID(pid, &status, 0);
+}
+
+static inline int get_clone_unshare_enum(const char* str_op)
+{
+	if (!str_op || !strcmp(str_op, "none"))
+		return T_NONE;
+	else if (!strcmp(str_op, "clone"))
+		return T_CLONE;
+	else if (!strcmp(str_op, "unshare"))
+		return T_UNSHARE;
+
+	return T_NONE;
+}
+
+static void clone_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
+{
+	int pid;
+
+	pid = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
+	if (pid < 0)
+		tst_brk(TBROK | TERRNO, "ltp_clone_quick error");
+}
+
+static void unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
+{
+	int pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_UNSHARE(clone_flags);
+
+		fn1(arg1);
+		exit(0);
+	}
+}
+
+static void plain_test(int (*fn1)(void *arg), void *arg1)
+{
+	int pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		fn1(arg1);
+		exit(0);
+	}
+}
+
+static void clone_unshare_test(int use_clone, unsigned long clone_flags,
+			       int (*fn1)(void *arg), void *arg1)
+{
+	switch (use_clone) {
+	case T_NONE:
+		plain_test(fn1, arg1);
+	break;
+	case T_CLONE:
+		clone_test(clone_flags, fn1, arg1);
+	break;
+	case T_UNSHARE:
+		unshare_test(clone_flags, fn1, arg1);
+	break;
+	default:
+		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__, use_clone);
+	break;
+	}
+}
+
+#endif /* MQNS_COMMON_H */
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 1d109e020..40f08fa77 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -1,148 +1,83 @@
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
-* Check mqns isolation: father mqns cannot be accessed from newinstance
-*
-* Mount mqueue fs
-* Create a posix mq -->mq1
-* unshare
-* In unshared process:
-*    Mount newinstance mqueuefs
-*    Check that mq1 is not readable from new ns
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
-char *TCID = "posixmq_namespace_01";
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
+ * Create a mqueue inside the parent and check if it can be accessed from
+ * the isolated/forked child namespace.
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
+	mqd1 = mq_open(MQNAME, O_RDONLY);
 
-	close(p1[1]);
-	close(p2[0]);
+	if (use_clone == T_NONE) {
+		if (mqd1 == -1)
+			tst_res(TFAIL, "Queue has been accessed form plain cloned process");
+		else
+			tst_res(TPASS, "Can't access to queue from plain cloned process");
 
-	if (read(p1[0], buf, strlen("go") + 1) < 0) {
-		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
-		exit(1);
-	}
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
-	if (mqd == -1) {
-		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
-			perror("write(p2[1], ...) failed");
-			exit(1);
-		}
-	} else {
-		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
-			perror("write(p2[1], \"exists\", 7) failed");
-			exit(1);
-		} else if (mq_close(mqd) < 0) {
-			perror("mq_close(mqd) failed");
-			exit(1);
-		}
+		return 0;
 	}
 
-	exit(0);
+	if (mqd1 == -1)
+		tst_res(TPASS, "Can't access to queue from isolated process");
+	else
+		tst_res(TFAIL, "Queue has been accessed from isolated process");
+
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
-		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
-	}
+	use_clone = get_clone_unshare_enum(str_op);
 
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0777, NULL);
-	if (mqd == -1) {
-		perror("mq_open");
-		tst_brkm(TFAIL, NULL, "mq_open failed");
-	}
+	if (use_clone != T_NONE)
+		check_newipc();
 
-	tst_resm(TINFO, "Checking namespaces isolation from parent to child");
-	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (r < 0) {
-		tst_resm(TFAIL, "failed clone/unshare");
-		mq_close(mqd);
-		tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
-		tst_exit();
-	}
-
-	close(p1[0]);
-	close(p2[1]);
-	if (write(p1[1], "go", strlen("go") + 1) < 0)
-		tst_resm(TBROK | TERRNO, "write(p1[1], \"go\", ...) failed");
-	else if (read(p2[0], buf, 7) < 0)
-		tst_resm(TBROK | TERRNO, "read(p2[0], buf, ...) failed");
-	else {
-		if (!strcmp(buf, "exists")) {
-			tst_resm(TFAIL, "child process found mqueue");
-		} else if (!strcmp(buf, "notfnd")) {
-			tst_resm(TPASS, "child process didn't find mqueue");
-		} else {
-			tst_resm(TFAIL, "UNKNOWN RESULT");
-		}
-	}
+	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
+	if (mqd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open failed");
+}
 
-	/* destroy the mqueue */
-	if (mq_close(mqd) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
+static void cleanup(void)
+{
+	if (mqd != -1) {
+		SAFE_MQ_CLOSE(mqd);
+		SAFE_MQ_UNLINK(MQNAME);
 	}
-	tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
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
