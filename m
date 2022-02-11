Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CAC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:27:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D35633C9F06
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:27:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C4F3C9E46
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A6A42140139C
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C5DF21138;
 Fri, 11 Feb 2022 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644571612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxP3B8ROVWjYQBCnofBq10EhX3RJ9yq0SEYI20Mf+kA=;
 b=ZtFhWqVmYBbhWuyunOFovYRKyyvXa1xPN2PbDvPR2NIK/GTNHJLHx3oWk/7rJHGPFKURM2
 zsmQ9C9uayaUur8SekYUVkg3E6U5HZr0/8L0jxzV8VFoaq+4Zqdc5m2gFywRuW8PK3Sv3X
 KP7RKreQiC7MM/uGr/+nxD3kRgX4h6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644571612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxP3B8ROVWjYQBCnofBq10EhX3RJ9yq0SEYI20Mf+kA=;
 b=aD7gcfpdyMyRvZdkIKJbnKuk4jSSx6Ci7KuxDg5JSMKoLJC9IRhgL2ZBsWEMfzaUp/4Lme
 ygPA6utvVO8M1sBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D20F313BC3;
 Fri, 11 Feb 2022 09:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oEIKMdsrBmJ7EwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Feb 2022 09:26:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 10:26:39 +0100
Message-Id: <20220211092646.23748-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211092646.23748-1-andrea.cervesato@suse.de>
References: <20220211092646.23748-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/8] Rewrite userns01.c test using new LTP API
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

Added common.h and removed helper header. Removed libclone dependency.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/containers/userns/Makefile   |  23 +---
 testcases/kernel/containers/userns/common.h   |  58 +++++++++
 testcases/kernel/containers/userns/userns01.c | 111 +++++++++---------
 .../kernel/containers/userns/userns_helper.h  |  62 ----------
 4 files changed, 116 insertions(+), 138 deletions(-)
 create mode 100644 testcases/kernel/containers/userns/common.h
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
index 80681096d..c1f10de20 100644
--- a/testcases/kernel/containers/userns/Makefile
+++ b/testcases/kernel/containers/userns/Makefile
@@ -1,26 +1,11 @@
-###############################################################################
-#                                                                            ##
-# Copyright (c) Huawei Technologies Co., Ltd., 2015                          ##
-#                                                                            ##
-# This program is free software;  you can redistribute it and#or modify      ##
-# it under the terms of the GNU General Public License as published by       ##
-# the Free Software Foundation; either version 2 of the License, or          ##
-# (at your option) any later version.                                        ##
-#                                                                            ##
-# This program is distributed in the hope that it will be useful, but        ##
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-# for more details.                                                          ##
-#                                                                            ##
-# You should have received a copy of the GNU General Public License          ##
-# along with this program.                                                   ##
-###############################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Huawei Technologies Co., Ltd., 2015
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone $(LDLIBS) $(CAP_LIBS)
+LDLIBS  := $(CAP_LIBS) $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel/containers/userns/common.h
new file mode 100644
index 000000000..95160c8cc
--- /dev/null
+++ b/testcases/kernel/containers/userns/common.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef COMMON_H
+#define COMMON_H
+
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
+
+#define UID_MAP 0
+#define GID_MAP 1
+
+static int dummy_child(void *v)
+{
+	(void)v;
+	return 0;
+}
+
+static inline int check_newuser(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(3, 8, 0) < 0)
+		tst_brk(TCONF, "CLONE_NEWUSER not supported");
+
+	pid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, dummy_child, NULL);
+	if (pid == -1)
+		tst_brk(TCONF | TTERRNO, "CLONE_NEWUSER not supported");
+
+	SAFE_WAIT(&status);
+
+	return 0;
+}
+
+static inline void updatemap(int cpid, bool type, int idnum, int parentmappid)
+{
+	char path[BUFSIZ];
+	char content[BUFSIZ];
+	int fd;
+
+	if (type == UID_MAP)
+		sprintf(path, "/proc/%d/uid_map", cpid);
+	else if (type == GID_MAP)
+		sprintf(path, "/proc/%d/gid_map", cpid);
+	else
+		tst_brk(TBROK, "invalid type parameter");
+
+	sprintf(content, "%d %d 1", idnum, parentmappid);
+
+	fd = SAFE_OPEN(path, O_WRONLY, 0644);
+	SAFE_WRITE(1, fd, content, strlen(content));
+	SAFE_CLOSE(fd);
+}
+
+#endif
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 1c8cf570d..2287f333a 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -1,115 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Verify that:
- *  If a user ID has no mapping inside the namespace, user ID and group
- * ID will be the value defined in the file /proc/sys/kernel/overflowuid(65534)
- * and /proc/sys/kernel/overflowgid(65534). A child process has a full set
- * of permitted and effective capabilities, even though the program was
- * run from an unprivileged account.
+ * If a user ID has no mapping inside the namespace, user ID and group ID will
+ * be the value defined in the file /proc/sys/kernel/overflowuid(65534) and
+ * /proc/sys/kernel/overflowgid(65534). A child process has a full set of
+ * permitted and effective capabilities, even though the program was run from an
+ * unprivileged account.
  */
 
+#include "tst_test.h"
+
+#ifdef HAVE_LIBCAP
 #define _GNU_SOURCE
-#include <sys/wait.h>
-#include <assert.h>
+
 #include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "userns_helper.h"
-#include "test.h"
+#include <stdbool.h>
+#include "common.h"
 #include "config.h"
-#if HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
-#endif
 
 #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
 #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
 
-char *TCID = "user_namespace1";
-int TST_TOTAL = 1;
-
 static long overflowuid;
 static long overflowgid;
 
 /*
  * child_fn1() - Inside a new user namespace
  */
-static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
+static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int exit_val = 0;
 	int uid, gid;
-#ifdef HAVE_LIBCAP
 	cap_t caps;
 	int i, last_cap;
 	cap_flag_value_t flag_val;
-#endif
 
 	uid = geteuid();
 	gid = getegid();
 
-	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
+	tst_res(TINFO, "USERNS test is running in a new user namespace.");
 
 	if (uid != overflowuid || gid != overflowgid) {
-		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
+		tst_res(TFAIL, "got unexpected uid=%d gid=%d", uid, gid);
 		exit_val = 1;
+	} else {
+		tst_res(TPASS, "got expected uid and gid");
 	}
 
-#ifdef HAVE_LIBCAP
 	caps = cap_get_proc();
-	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
+
+	SAFE_FILE_SCANF("/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
+
 	for (i = 0; i <= last_cap; i++) {
 		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
-		if (flag_val == 0)
+		if (!flag_val)
 			break;
+
 		cap_get_flag(caps, i, CAP_PERMITTED, &flag_val);
-		if (flag_val == 0)
+		if (!flag_val)
 			break;
 	}
 
-	if (flag_val == 0) {
-		printf("unexpected effective/permitted caps at %d\n", i);
+	if (!flag_val) {
+		tst_res(TFAIL, "unexpected effective/permitted caps at %d", i);
 		exit_val = 1;
+	} else {
+		tst_res(TPASS, "expected capabilities");
 	}
-#else
-	printf("System is missing libcap.\n");
-#endif
+
 	return exit_val;
 }
 
 static void setup(void)
 {
 	check_newuser();
-	SAFE_FILE_SCANF(NULL, OVERFLOWUIDPATH, "%ld", &overflowuid);
-	SAFE_FILE_SCANF(NULL, OVERFLOWGIDPATH, "%ld", &overflowgid);
+
+	SAFE_FILE_SCANF(OVERFLOWUIDPATH, "%ld", &overflowuid);
+	SAFE_FILE_SCANF(OVERFLOWGIDPATH, "%ld", &overflowgid);
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
+	int pid;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-	setup();
+	pid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, child_fn1, NULL);
+	if (pid < 0)
+		tst_brk(TBROK | TTERRNO, "clone failed");
+}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER,
-			child_fn1, NULL));
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_kconfigs =
+		(const char *[]){
+			"CONFIG_USER_NS",
+			NULL,
+		},
+};
 
-		if (TEST_RETURN == -1)
-			tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
-		tst_record_childstatus(NULL, -1);
-	}
-	tst_exit();
-}
+#else
+TST_TEST_TCONF("System is missing libcap");
+#endif
diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
deleted file mode 100644
index 12b491f62..000000000
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- */
-
-#include "../libclone/libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-#include <stdbool.h>
-
-#define UID_MAP 0
-#define GID_MAP 1
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static int check_newuser(void)
-{
-	int pid, status;
-
-	if (tst_kvercmp(3, 8, 0) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWUSER not supported");
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUSER not supported");
-	SAFE_WAIT(NULL, &status);
-
-	return 0;
-}
-
-LTP_ATTRIBUTE_UNUSED static int updatemap(int cpid, bool type, int idnum,
-	int parentmappid, void (*cleanup)(void))
-{
-	char path[BUFSIZ];
-	char content[BUFSIZ];
-	int fd;
-
-	if (type == UID_MAP)
-		sprintf(path, "/proc/%d/uid_map", cpid);
-	else if (type == GID_MAP)
-		sprintf(path, "/proc/%d/gid_map", cpid);
-	else
-		tst_brkm(TBROK, cleanup, "invalid type parameter");
-
-	sprintf(content, "%d %d 1", idnum, parentmappid);
-	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
-	SAFE_CLOSE(cleanup, fd);
-	return 0;
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
