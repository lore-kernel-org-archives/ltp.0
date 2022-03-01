Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB50BC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 09:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC1C33CA2FC
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 10:15:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4166A3CA2BD
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:15:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 55E27200DB7
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:15:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9ED611F37E;
 Tue,  1 Mar 2022 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646126120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j8ECvHNoB9URk1t+aN4uUzd2dboTRH3xRvk7nop8cM=;
 b=Pc6IjiRoVxxtawHdWNuX1yPpuRyKg598Z//xguJBcSQiPvUibi9i+huOBEW9VyJqsO1pRA
 MT3PKDb+1k+2K08GIvGd3g8uR4j9UdyuSh51qN3xsL+79Ql5Nkbx28jMRLCPPSnzviXHXs
 lDsgy/D0XLw/6rdadIkXsg/GehZHZt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646126120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7j8ECvHNoB9URk1t+aN4uUzd2dboTRH3xRvk7nop8cM=;
 b=nv8ciee3WKxOKQL1zhtV4V2yz76r1+BJJhGhwSVhfGLywxtU+jmYGSA9L2d3RAlVJlo2uS
 tOBZdvwzik99VmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65AB613B08;
 Tue,  1 Mar 2022 09:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6NInEyjkHWJ3VwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 01 Mar 2022 09:15:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  1 Mar 2022 10:15:12 +0100
Message-Id: <20220301091517.11142-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301091517.11142-1-andrea.cervesato@suse.de>
References: <20220301091517.11142-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/6] Rewrite mountns01 test using new LTP API
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
 testcases/kernel/containers/mountns/mountns.h |  50 +++++
 .../kernel/containers/mountns/mountns01.c     | 185 +++++++-----------
 2 files changed, 125 insertions(+), 110 deletions(-)
 create mode 100644 testcases/kernel/containers/mountns/mountns.h

diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
new file mode 100644
index 000000000..ad8befa71
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef COMMON_H
+#define COMMON_H
+
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
+
+#define DIRA "A"
+#define DIRB "B"
+
+static int dummy_child(void *v)
+{
+	(void)v;
+	return 0;
+}
+
+static void check_newns(void)
+{
+	int pid, status;
+
+	pid = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, dummy_child, NULL);
+	if (pid < 0)
+		tst_brk(TCONF, "CLONE_NEWNS not supported");
+
+	SAFE_WAIT(&status);
+}
+
+static void umount_folders(void)
+{
+	if (tst_is_mounted(DIRA))
+		SAFE_UMOUNT(DIRA);
+
+	if (tst_is_mounted(DIRB))
+		SAFE_UMOUNT(DIRB);
+}
+
+static void create_folders(void)
+{
+	SAFE_MKDIR(DIRA, 0777);
+	SAFE_MKDIR(DIRB, 0777);
+	SAFE_TOUCH(DIRA "/A", 0, NULL);
+	SAFE_TOUCH(DIRB "/B", 0, NULL);
+}
+
+#endif
diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 0bd0c592c..f2d67d17a 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -1,149 +1,114 @@
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
- * File: mountns01.c
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
  * Tests a shared mount: shared mount can be replicated to as many
  * mountpoints and all the replicas continue to be exactly same.
- * Description:
- * 1. Creates directories "A", "B" and files "A/A", "B/B"
- * 2. Unshares mount namespace and makes it private (so mounts/umounts
- *    have no effect on a real system)
- * 3. Bind mounts directory "A" to "A"
- * 4. Makes directory "A" shared
- * 5. Clones a new child process with CLONE_NEWNS flag
- * 6. There are two test cases (where X is parent namespace and Y child
- *    namespace):
- *    1)
- *	X: bind mounts "B" to "A"
- *	Y: must see "A/B"
- *	X: umounts "A"
- *    2)
- *	Y: bind mounts "B" to "A"
- *	X: must see "A/B"
- *	Y: umounts "A"
- ***********************************************************************/
-
-#define _GNU_SOURCE
+ *
+ * [Algorithm]
+ *
+ * . Creates directories "A", "B" and files "A/A", "B/B"
+ * . Unshares mount namespace and makes it private (so mounts/umounts have no
+ *   effect on a real system)
+ * . Bind mounts directory "A" to "A"
+ * . Makes directory "A" shared
+ * . Clones a new child process with CLONE_NEWNS flag
+ * . There are two test cases (where X is parent namespace and Y child namespace):
+ * .. First test case
+ * ... X: bind mounts "B" to "A"
+ * ... Y: must see "A/B"
+ * ... X: umounts "A"
+ * .. Second test case
+ * ... Y: bind mounts "B" to "A"
+ * ... X: must see "A/B"
+ * ... Y: umounts "A"
+ */
+
 #include <sys/wait.h>
 #include <sys/mount.h>
-#include <stdio.h>
-#include <errno.h>
-#include "mountns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID	= "mountns01";
-int TST_TOTAL	= 2;
+#include "mountns.h"
+#include "tst_test.h"
 
-#if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)
-
-int child_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	int ret = 0;
+	TST_CHECKPOINT_WAIT(0);
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	if (access(DIRA "/B", F_OK) == 0)
+		tst_res(TPASS, "shared mount in parent passed");
+	else
+		tst_res(TFAIL, "shared mount in parent failed");
 
-	if (access(DIRA"/B", F_OK) == -1)
-		ret = 2;
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
+	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
-	/* bind mounts DIRB to DIRA making contents of DIRB visible
-	 * in DIRA */
-	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
-		perror("mount");
-		return 1;
-	}
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	SAFE_UMOUNT(DIRA);
 
-	umount(DIRA);
-	return ret;
+	return 0;
 }
 
-static void test(void)
+static void run(void)
 {
-	int status;
+	int ret;
 
 	/* unshares the mount ns */
-	if (unshare(CLONE_NEWNS) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+	SAFE_UNSHARE(CLONE_NEWNS);
+
 	/* makes sure parent mounts/umounts have no effect on a real system */
-	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
+	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
 
 	/* bind mounts DIRA to itself */
-	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
+	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
 
 	/* makes mount DIRA shared */
-	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
+	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
 
-	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK, "clone failed");
 
-	/* bind mounts DIRB to DIRA making contents of DIRB visible
-	 * in DIRA */
-	SAFE_MOUNT(cleanup, DIRB, DIRA, "none", MS_BIND, NULL);
+	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
+	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	SAFE_UMOUNT(cleanup, DIRA);
+	SAFE_UMOUNT(DIRA);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	if (access(DIRA"/B", F_OK) == 0)
-		tst_resm(TPASS, "shared mount in child passed");
+	if (access(DIRA "/B", F_OK) == 0)
+		tst_res(TPASS, "shared mount in child passed");
 	else
-		tst_resm(TFAIL, "shared mount in child failed");
-
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+		tst_res(TFAIL, "shared mount in child failed");
 
+	TST_CHECKPOINT_WAKE(0);
 
-	SAFE_WAIT(cleanup, &status);
-	if (WIFEXITED(status)) {
-		if ((WEXITSTATUS(status) == 0))
-			tst_resm(TPASS, "shared mount in parent passed");
-		else
-			tst_resm(TFAIL, "shared mount in parent failed");
-	}
-	if (WIFSIGNALED(status)) {
-		tst_resm(TBROK, "child was killed with signal %s",
-			 tst_strsig(WTERMSIG(status)));
-		return;
-	}
-
-	SAFE_UMOUNT(cleanup, DIRA);
+	SAFE_UMOUNT(DIRA);
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
+	check_newns();
+	create_folders();
 }
 
-#else
-int main(void)
+static void cleanup(void)
 {
-	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
+	umount_folders();
 }
-#endif
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
