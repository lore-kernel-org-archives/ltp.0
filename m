Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBA6C433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:10:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C411D3C9B50
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:10:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A59AA3C9AE6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2D51200AE9
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46A30210FE;
 Tue,  8 Feb 2022 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zo29cX0puVwrGRNrKlpY5k7SvnX5IizJX3ExFBtGlQ4=;
 b=HehuQOx18sytNngqXeKWlQWvVqxtPN/TdBn+ZaMxNeNWSTEgly32P7uDRtXfhzrM9dsx0d
 GFUH2uaX3L/a+8hgx8N2JyX/m3Crw2l47Uw6U62himlkOoEQCZg1bxfmsJ80QlHgEIzin8
 wNM3kkZ4IrxK4tDeV18MW3Fir5fufkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zo29cX0puVwrGRNrKlpY5k7SvnX5IizJX3ExFBtGlQ4=;
 b=zb+vNbd+3XINxqqZ2hyt6Pwv9D0Yxj/zbhWK2pxpqHr8awWEzPC3oM8lzMsLQmc313oGUV
 B4mdobK/ijjhH/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 144AE13BF9;
 Tue,  8 Feb 2022 10:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +AzzAnBBAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:40 +0100
Message-Id: <20220208100948.22913-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208100948.22913-1-andrea.cervesato@suse.de>
References: <20220208100948.22913-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/9] Remove libclone dependency from sysvipc
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

This is the step 1 before rewriting all sysvipc tests using new
LTP API. Substituted ipcns_helper.h with a common.h header for all
tests. The new common.h file includes some helpers functions, as
well as specific clone functionalities.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/containers/sysvipc/Makefile  |  26 +---
 testcases/kernel/containers/sysvipc/common.h  | 138 ++++++++++++++++++
 .../kernel/containers/sysvipc/ipcns_helper.h  |  41 ------
 3 files changed, 141 insertions(+), 64 deletions(-)
 create mode 100644 testcases/kernel/containers/sysvipc/common.h
 delete mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h

diff --git a/testcases/kernel/containers/sysvipc/Makefile b/testcases/kernel/containers/sysvipc/Makefile
index 00b537f6a..426fe5292 100644
--- a/testcases/kernel/containers/sysvipc/Makefile
+++ b/testcases/kernel/containers/sysvipc/Makefile
@@ -1,28 +1,8 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2007
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
-
-LDLIBS			:= -lclone $(LDLIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
new file mode 100644
index 000000000..019716781
--- /dev/null
+++ b/testcases/kernel/containers/sysvipc/common.h
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2007
+ *               Rishikesh K Rajak <risrajak@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef COMMON_H
+#define COMMON_H
+
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/namespaces_constants.h"
+
+enum {
+	T_CLONE,
+	T_UNSHARE,
+	T_NONE,
+};
+
+static int dummy_child(void *v)
+{
+	(void)v;
+	return 0;
+}
+
+static void check_newipc(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(2, 6, 19) < 0)
+		tst_brk(TCONF, "CLONE_NEWIPC not supported");
+
+	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child, NULL);
+	if (pid < 0)
+		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
+
+	SAFE_WAITPID(pid, &status, 0);
+}
+
+static int clone_test(unsigned long clone_flags, int (*fn1)(void *arg),
+		      void *arg1)
+{
+	int ret;
+
+	ret = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
+
+	if (ret != -1) {
+		/* no errors: we'll get the PID id that means success */
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int unshare_test(unsigned long clone_flags, int (*fn1)(void *arg),
+			void *arg1)
+{
+	int pid, ret = 0;
+	int retpipe[2];
+	char buf[2];
+
+	SAFE_PIPE(retpipe);
+
+	pid = fork();
+	if (pid < 0) {
+		SAFE_CLOSE(retpipe[0]);
+		SAFE_CLOSE(retpipe[1]);
+		tst_brk(TBROK, "fork");
+	}
+
+	if (!pid) {
+		SAFE_CLOSE(retpipe[0]);
+
+		ret = tst_syscall(SYS_unshare, clone_flags);
+		if (ret == -1) {
+			SAFE_WRITE(1, retpipe[1], "0", 2);
+			SAFE_CLOSE(retpipe[1]);
+			exit(1);
+		} else {
+			SAFE_WRITE(1, retpipe[1], "1", 2);
+		}
+
+		SAFE_CLOSE(retpipe[1]);
+
+		ret = fn1(arg1);
+		exit(ret);
+	}
+
+	SAFE_CLOSE(retpipe[1]);
+	SAFE_READ(1, retpipe[0], &buf, 2);
+	SAFE_CLOSE(retpipe[0]);
+
+	if (*buf == '0')
+		return -1;
+
+	return ret;
+}
+
+static int plain_test(int (*fn1)(void *arg), void *arg1)
+{
+	int ret = 0, pid;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(fn1(arg1));
+
+	return ret;
+}
+
+static void clone_unshare_test(int use_clone, unsigned long clone_flags,
+			       int (*fn1)(void *arg), void *arg1)
+{
+	int ret = 0;
+
+	switch (use_clone) {
+	case T_NONE:
+		ret = plain_test(fn1, arg1);
+		break;
+	case T_CLONE:
+		ret = clone_test(clone_flags, fn1, arg1);
+		break;
+	case T_UNSHARE:
+		ret = unshare_test(clone_flags, fn1, arg1);
+		break;
+	default:
+		ret = -1;
+		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__,
+			use_clone);
+		break;
+	}
+
+	if (ret == -1)
+		tst_brk(TBROK, "child2 clone failed");
+}
+
+#endif
diff --git a/testcases/kernel/containers/sysvipc/ipcns_helper.h b/testcases/kernel/containers/sysvipc/ipcns_helper.h
deleted file mode 100644
index 01ad0fff6..000000000
--- a/testcases/kernel/containers/sysvipc/ipcns_helper.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
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
-* Author: Rishikesh K Rajak <risrajak@in.ibm.com>
-***************************************************************************/
-#include <sched.h>
-#include "../libclone/libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static void check_newipc(void)
-{
-	int pid, status;
-
-	if (tst_kvercmp(2, 6, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWIPC not supported");
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWIPC not supported");
-
-	SAFE_WAIT(NULL, &status);
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
