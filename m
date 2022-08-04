Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8F1C19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 13:32:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4682E3C935A
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 15:32:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD4CE3C9468
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 15:31:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CC41460071F
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 15:31:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B60F37834;
 Thu,  4 Aug 2022 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659619850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GQfFo9f6IvPe8IBrXlAgpiOew6CDJDfRI2ogy6H4Qd0=;
 b=VfC7Saoc1hmcYSAg/Z4ZbFRqQGPyqZPLNRuIGfWVipmTef5d0vr5Rw7TSmQ4HN3IJyZ2Ba
 xZWg0r5MRfOocBB6Zd4t+rhARJZqtaAmdx+2sl4rpabX24ki3KL33PxmP3PZoXbGWuss+c
 GN1Fls3Bj9Na418UQz9UHssdJJpeiIs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DD9413434;
 Thu,  4 Aug 2022 13:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MzFTEArK62L3XQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 04 Aug 2022 13:30:50 +0000
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 15:30:14 +0200
Message-Id: <20220804133015.15150-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] Refactor pidns03 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns03.c | 139 ++++++--------------
 1 file changed, 38 insertions(+), 101 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index b735ab36b..b9b38b5d9 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -1,124 +1,61 @@
-/* Copyright (c) 2014 Red Hat, Inc. All rights reserved.
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
- * File: pidns03.c
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
- * Clones a new child process with CLONE_NEWPID flag - the new child
- * process mounts procfs to a "proc" directory and checks if it belongs
- * to a new pid namespace by:
- * 1. reading value of "proc/self", which is symlink
- *    to directory named after current pid number
- * 2. comparing read value (PID) with "1"
+ * Clone a process with CLONE_NEWPID flag and check if procfs mounted folder
+ * belongs to the new pid namespace by looking at /proc/self .
  */
 
-#define _GNU_SOURCE
-#include <sys/wait.h>
 #include <sys/mount.h>
-#include <sys/types.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include "pidns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
 #define PROCDIR "proc"
-char *TCID = "pidns03";
-int TST_TOTAL	= 1;
-
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
-	tst_tmpdir();
-	SAFE_MKDIR(cleanup, PROCDIR, 0555);
-}
 
-int child_func(void *arg)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	ssize_t r;
-	char buf[10];
+	char proc_self[10];
 
-	if (mount("none", PROCDIR, "proc", MS_RDONLY, NULL) == -1) {
-		perror("mount");
-		return 1;
-	}
+	SAFE_MOUNT("none", PROCDIR, "proc", MS_RDONLY, NULL);
 
-	/* self is symlink to directory named after current pid number */
-	r = readlink(PROCDIR"/self", buf, sizeof(buf)-1);
-	if (r == -1) {
-		perror("readlink");
-		umount(PROCDIR);
-		return 1;
-	}
+	SAFE_READLINK(PROCDIR"/self", proc_self, sizeof(proc_self) - 1);
 
-	buf[r] = '\0';
+	SAFE_UMOUNT(PROCDIR);
 
-	umount(PROCDIR);
-
-	/* child should have PID 1 in a new pid namespace - if true
-	 * procfs belongs to the new pid namespace */
-	if (strcmp(buf, "1")) {
-		fprintf(stderr, "%s contains: %s\n", PROCDIR"/self", buf);
-		return 1;
-	}
+	TST_EXP_PASS(strcmp(proc_self, "1"), PROCDIR"/self contains 1:");
 
 	return 0;
 }
 
-static void test(void)
+static void setup(void)
 {
-	int status;
-
-	if (do_clone_tests(CLONE_NEWPID, child_func, NULL, NULL, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-	SAFE_WAIT(cleanup, &status);
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-		tst_resm(TPASS, "mounting procfs in a new namespace");
-		return;
-	}
-
-	if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL, "child was killed with signal %s",
-			 tst_strsig(WTERMSIG(status)));
-		return;
-	}
-
-	tst_resm(TFAIL, "mounting procfs in a new namespace");
+	SAFE_MKDIR(PROCDIR, 0555);
 }
 
-int main(int argc, char *argv[])
+static void cleanup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	if (tst_is_mounted_at_tmpdir(PROCDIR))
+		SAFE_UMOUNT(PROCDIR);
+}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		test();
+static void run(void)
+{
+	int ret;
 
-	cleanup();
-	tst_exit();
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
