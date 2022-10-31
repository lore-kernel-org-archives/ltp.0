Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB889C38A02
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:28:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852383CAAE6
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:28:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3318D3CA2E4
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:28:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2407F10005EF
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:28:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5E8E3374B;
 Mon, 31 Oct 2022 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1667222902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDnDPT3IIMUXMdskvsFC83HMfJkYvkEsvOAUA/fWB4U=;
 b=XfRm/Y5G0kBMkZJA/J1MgZiBszCNZ0DeGhJU+PNO34Mccf5rJfZeT39lpzstXozjS68bCu
 152swZlb1xPvBUs+i3MkPIRAKEwUmvfcGcx25qAFG2lxXVO0+NbuRN6q1BFwkyKui43GWR
 ZgXExmIJAZxcD3wH3Xj8C2/j3UTKr04=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8385613AAD;
 Mon, 31 Oct 2022 13:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8EhjHXbNX2P9XAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 31 Oct 2022 13:28:22 +0000
To: ltp@lists.linux.it
Date: Mon, 31 Oct 2022 14:26:58 +0100
Message-Id: <20221031132658.26233-3-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221031132658.26233-1-andrea.cervesato@suse.com>
References: <20221031132658.26233-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Rewrite utsname testing suite
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

Deleted utstest.c and created the following new tests:
- utsname01
- utsname02
- utsname03
- utsname04

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Usage of HOST_NAME_MAX

 runtest/containers                            |   7 +
 .../kernel/containers/utsname/.gitignore      |   5 +-
 testcases/kernel/containers/utsname/Makefile  |  23 +-
 .../containers/utsname/runutstests_noltp.sh   |  41 --
 testcases/kernel/containers/utsname/utsname.h | 116 ++++++
 .../kernel/containers/utsname/utsname01.c     |  72 ++++
 .../kernel/containers/utsname/utsname02.c     |  96 +++++
 .../kernel/containers/utsname/utsname03.c     | 110 ++++++
 .../kernel/containers/utsname/utsname04.c     |  66 ++++
 testcases/kernel/containers/utsname/utstest.c | 356 ------------------
 10 files changed, 474 insertions(+), 418 deletions(-)
 delete mode 100755 testcases/kernel/containers/utsname/runutstests_noltp.sh
 create mode 100644 testcases/kernel/containers/utsname/utsname.h
 create mode 100644 testcases/kernel/containers/utsname/utsname01.c
 create mode 100644 testcases/kernel/containers/utsname/utsname02.c
 create mode 100644 testcases/kernel/containers/utsname/utsname03.c
 create mode 100644 testcases/kernel/containers/utsname/utsname04.c
 delete mode 100644 testcases/kernel/containers/utsname/utstest.c

diff --git a/runtest/containers b/runtest/containers
index 2637b62fe..36d9378af 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -73,6 +73,13 @@ utstest_clone_3 utstest clone 3
 utstest_clone_4 utstest clone 4
 utstest_clone_5 utstest clone 5
 
+utsname01 utsname01
+utsname02 utsname02
+utsname03_clone utsname03 -m clone
+utsname03_unshare utsname03 -m unshare
+utsname04_clone utsname04 -m clone
+utsname04_unshare utsname04 -m unshare
+
 mountns01 mountns01
 mountns02 mountns02
 mountns03 mountns03
diff --git a/testcases/kernel/containers/utsname/.gitignore b/testcases/kernel/containers/utsname/.gitignore
index 0e1f41dc8..945ed280e 100644
--- a/testcases/kernel/containers/utsname/.gitignore
+++ b/testcases/kernel/containers/utsname/.gitignore
@@ -1 +1,4 @@
-/utstest
+/utsname01
+/utsname02
+/utsname03
+/utsname04
diff --git a/testcases/kernel/containers/utsname/Makefile b/testcases/kernel/containers/utsname/Makefile
index 5efcbf648..9c0158c01 100644
--- a/testcases/kernel/containers/utsname/Makefile
+++ b/testcases/kernel/containers/utsname/Makefile
@@ -1,28 +1,11 @@
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
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone -lpthread -lrt $(LDLIBS)
+LDLIBS			:= -lclone $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/utsname/runutstests_noltp.sh b/testcases/kernel/containers/utsname/runutstests_noltp.sh
deleted file mode 100755
index 43cb7e26b..000000000
--- a/testcases/kernel/containers/utsname/runutstests_noltp.sh
+++ /dev/null
@@ -1,41 +0,0 @@
-#!/bin/sh
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
-
-oldhostname=`hostname`
-exit_code=0
-echo "unshare tests"
-for i in `seq 1 5`; do
-	echo "test $i (unshare)"
-	./utstest_noltp unshare $i
-	if [ $? -ne 0 ]; then
-		exit_code=$?
-	fi
-done
-echo "clone tests"
-for i in `seq 1 5`; do
-	echo "test $i (clone)"
-	./utstest_noltp clone $i
-	if [ $? -ne 0 ]; then
-		exit_code=$?
-	fi
-done
-hostname "$oldhostname"
-exit $exit_code
diff --git a/testcases/kernel/containers/utsname/utsname.h b/testcases/kernel/containers/utsname/utsname.h
new file mode 100644
index 000000000..4a88e2c91
--- /dev/null
+++ b/testcases/kernel/containers/utsname/utsname.h
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef UTSTEST_H
+#define UTSTEST_H
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
+static int dummy_child(LTP_ATTRIBUTE_UNUSED void *v)
+{
+	return 0;
+}
+
+static inline void check_newuts(void)
+{
+	int pid, status;
+
+	pid = ltp_clone_quick(CLONE_NEWUTS | SIGCHLD, dummy_child, NULL);
+	if (pid < 0)
+		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
+
+	SAFE_WAITPID(pid, &status, 0);
+}
+
+static inline int get_clone_unshare_enum(const char *str_op)
+{
+	int use_clone;
+
+	use_clone = T_NONE;
+
+	if (!str_op || !strcmp(str_op, "none"))
+		use_clone = T_NONE;
+	else if (!strcmp(str_op, "clone"))
+		use_clone = T_CLONE;
+	else if (!strcmp(str_op, "unshare"))
+		use_clone = T_UNSHARE;
+	else
+		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
+
+	return use_clone;
+}
+
+static inline pid_t clone_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
+{
+	pid_t pid;
+
+	pid = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
+	if (pid < 0)
+		tst_brk(TBROK | TERRNO, "ltp_clone_quick error");
+
+	return pid;
+}
+
+static inline pid_t unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_UNSHARE(clone_flags);
+
+		fn1(arg1);
+		exit(0);
+	}
+
+	return pid;
+}
+
+static inline pid_t plain_test(int (*fn1)(void *arg), void *arg1)
+{
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		fn1(arg1);
+		exit(0);
+	}
+
+	return pid;
+}
+
+static inline pid_t clone_unshare_test(int use_clone, unsigned long clone_flags,
+			       int (*fn1)(void *arg), void *arg1)
+{
+	pid_t pid = -1;
+
+	switch (use_clone) {
+	case T_NONE:
+		pid = plain_test(fn1, arg1);
+	break;
+	case T_CLONE:
+		pid = clone_test(clone_flags, fn1, arg1);
+	break;
+	case T_UNSHARE:
+		pid = unshare_test(clone_flags, fn1, arg1);
+	break;
+	default:
+		tst_brk(TBROK, "%s: bad use_clone option: %d", __func__, use_clone);
+	break;
+	}
+
+	return pid;
+}
+
+#endif
diff --git a/testcases/kernel/containers/utsname/utsname01.c b/testcases/kernel/containers/utsname/utsname01.c
new file mode 100644
index 000000000..077019abc
--- /dev/null
+++ b/testcases/kernel/containers/utsname/utsname01.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Clone two plain processes and check if both read the same hostname.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "utsname.h"
+
+static char *hostname1;
+static char *hostname2;
+
+static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
+
+	return 0;
+}
+
+static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
+
+	return 0;
+}
+
+static void run(void)
+{
+	int status1, status2;
+	pid_t pid1, pid2;
+
+	memset(hostname1, 0, HOST_NAME_MAX);
+	memset(hostname2, 0, HOST_NAME_MAX);
+
+	pid1 = clone_unshare_test(T_NONE, 0, child1_run, NULL);
+	pid2 = clone_unshare_test(T_NONE, 0, child2_run, NULL);
+
+	SAFE_WAITPID(pid1, &status1, 0);
+	SAFE_WAITPID(pid2, &status2, 0);
+
+	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
+		return;
+
+	TST_EXP_PASS(strcmp(hostname1, hostname2));
+}
+
+static void setup(void)
+{
+	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
+	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/containers/utsname/utsname02.c b/testcases/kernel/containers/utsname/utsname02.c
new file mode 100644
index 000000000..5f8bbe836
--- /dev/null
+++ b/testcases/kernel/containers/utsname/utsname02.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Clone two plain processes, change hostname in the first one then check if
+ * hostaname has changed inside the second one as well.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "utsname.h"
+
+#define HOSTNAME "LTP_HOSTNAME"
+
+static char *hostname1;
+static char *hostname2;
+static char originalhost[HOST_NAME_MAX];
+
+static void reset_hostname(void)
+{
+	SAFE_SETHOSTNAME(originalhost, strlen(originalhost));
+}
+
+static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	SAFE_SETHOSTNAME(HOSTNAME, strlen(HOSTNAME));
+	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	return 0;
+}
+
+static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
+
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid1, pid2;
+	int status1, status2;
+
+	memset(hostname1, 0, HOST_NAME_MAX);
+	memset(hostname2, 0, HOST_NAME_MAX);
+
+	pid1 = clone_unshare_test(T_NONE, 0, child1_run, NULL);
+	pid2 = clone_unshare_test(T_NONE, 0, child2_run, NULL);
+
+	SAFE_WAITPID(pid1, &status1, 0);
+	SAFE_WAITPID(pid2, &status2, 0);
+
+	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
+		return;
+
+	TST_EXP_PASS(strcmp(hostname1, HOSTNAME));
+	TST_EXP_PASS(strcmp(hostname2, HOSTNAME));
+
+	reset_hostname();
+}
+
+static void setup(void)
+{
+	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	memset(originalhost, 0, HOST_NAME_MAX);
+
+	SAFE_GETHOSTNAME(originalhost, HOST_NAME_MAX);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
+	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
+
+	reset_hostname();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/testcases/kernel/containers/utsname/utsname03.c b/testcases/kernel/containers/utsname/utsname03.c
new file mode 100644
index 000000000..b6579c11b
--- /dev/null
+++ b/testcases/kernel/containers/utsname/utsname03.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2007
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Clone two processes using CLONE_NEWUTS, change hostname from the first
+ * container and check if hostname didn't change inside the second one.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "utsname.h"
+
+#define HOSTNAME "LTP_HOSTNAME"
+
+static char *str_op = "clone";
+static int use_clone;
+static char *hostname1;
+static char *hostname2;
+static char originalhost[HOST_NAME_MAX];
+
+static void reset_hostname(void)
+{
+	SAFE_SETHOSTNAME(originalhost, strlen(originalhost));
+}
+
+static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	SAFE_SETHOSTNAME(HOSTNAME, strlen(HOSTNAME));
+	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	return 0;
+}
+
+static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
+
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid1, pid2;
+	int status1, status2;
+
+	memset(hostname1, 0, HOST_NAME_MAX);
+	memset(hostname2, 0, HOST_NAME_MAX);
+
+	pid1 = clone_unshare_test(use_clone, CLONE_NEWUTS, child1_run, NULL);
+	pid2 = clone_unshare_test(use_clone, CLONE_NEWUTS, child2_run, NULL);
+
+	SAFE_WAITPID(pid1, &status1, 0);
+	SAFE_WAITPID(pid2, &status2, 0);
+
+	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
+		return;
+
+	TST_EXP_PASS(strcmp(hostname1, HOSTNAME));
+	TST_EXP_PASS(strcmp(hostname2, originalhost));
+
+	reset_hostname();
+}
+
+static void setup(void)
+{
+	use_clone = get_clone_unshare_enum(str_op);
+
+	if (use_clone != T_CLONE && use_clone != T_UNSHARE)
+		tst_brk(TCONF, "Only clone and unshare clone are supported");
+
+	check_newuts();
+
+	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	memset(originalhost, 0, HOST_NAME_MAX);
+
+	SAFE_GETHOSTNAME(originalhost, HOST_NAME_MAX);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
+	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
+
+	reset_hostname();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
+		{},
+	},
+};
diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
new file mode 100644
index 000000000..d3aaf51b8
--- /dev/null
+++ b/testcases/kernel/containers/utsname/utsname04.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Drop root privileges, create a container with CLONE_NEWUTS and verify that
+ * we receive a permission error.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "utsname.h"
+
+static char *str_op = "clone";
+static int use_clone;
+
+static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
+{
+	return 0;
+}
+
+static void run(void)
+{
+	void *stack;
+	size_t stack_size = getpagesize() * 6;
+
+	stack = ltp_alloc_stack(stack_size);
+	if (stack == NULL)
+		tst_brk(TBROK, "Can't allocate stack");
+
+	tst_res(TINFO, "Dropping root privileges");
+
+	SAFE_SETRESUID(1000, 1000, 1000);
+
+	tst_res(TINFO, "clone() with CLONE_NEWUTS");
+
+	ltp_clone(CLONE_NEWUTS, child1_run, NULL, stack_size, stack);
+
+	TST_EXP_PASS(errno == EPERM);
+}
+
+static void setup(void)
+{
+	use_clone = get_clone_unshare_enum(str_op);
+
+	if (use_clone != T_CLONE && use_clone != T_UNSHARE)
+		tst_brk(TCONF, "Only clone and unshare clone are supported");
+
+	check_newuts();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
+		{},
+	},
+};
diff --git a/testcases/kernel/containers/utsname/utstest.c b/testcases/kernel/containers/utsname/utstest.c
deleted file mode 100644
index d22db79c8..000000000
--- a/testcases/kernel/containers/utsname/utstest.c
+++ /dev/null
@@ -1,356 +0,0 @@
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
-***************************************************************************
- * Copyright 2007 IBM
- * Author: Serge Hallyn <serue@us.ibm.com>
- *
- * test1:
-	P1: A=gethostname
-	P2: B=gethostname
-	Ensure(A==B)
-
- * test2:
-	P1: sethostname(A);
-	P2: (wait); B=gethostname
-	Ensure (A==B)
-
- * test3:
-	P1: A=gethostname; unshare(utsname); sethostname(newname); C=gethostname
-	P2: B=gethostname; (wait); (wait); D=gethostname
-	Ensure (A==B && A==D && C!=D)
-
- * test4:
-	P1: A=gethostname; unshare(utsname); (wait); C=gethostname
-	P2: B=gethostname; (wait); sethostname(newname); D=gethostname
-	Ensure (A==B && A==C && C!=D)
-
- * test5:
-	P1: drop_privs(); unshare(utsname); (wait); C=gethostname
-	P2: (wait); sethostname(B); D=gethostname
-	Ensure (B==C==D) and state is ok.
- *
- */
-
-#define _GNU_SOURCE 1
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "uts_namespace";
-int TST_TOTAL = 1;
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static void check_newuts(void)
-{
-	int pid, status;
-
-	if (tst_kvercmp(2, 6, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWUTS not supported");
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUTS, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUTS not supported");
-
-	SAFE_WAIT(NULL, &status);
-}
-
-int drop_root(void)
-{
-	int ret;
-	ret = setresuid(1000, 1000, 1000);
-	if (ret) {
-		perror("setresuid");
-		exit(4);
-	}
-	return 1;
-}
-
-#define HLEN 100
-#define NAME1 "serge1"
-#define NAME2 "serge2"
-
-int p1fd[2], p2fd[2];
-static char oldhost[HLEN];
-pid_t cpid;
-
-void picknewhostname(char *orig, char *new)
-{
-	memset(new, 0, HLEN);
-	if (strcmp(orig, NAME1) == 0)
-		strcpy(new, NAME2);
-	else
-		strcpy(new, NAME1);
-}
-
-void zeroize(char *s)
-{
-	memset(s, 0, HLEN);
-}
-
-char *tsttype;
-int P1(void *vtest)
-{
-	char hostname[HLEN], newhostname[HLEN], rhostname[HLEN];
-	int err;
-	int len;
-	int testnum;
-
-	testnum = atoi((char *)vtest);
-
-	close(p1fd[1]);
-	close(p2fd[0]);
-
-	switch (testnum) {
-	case 1:
-		gethostname(hostname, HLEN);
-		zeroize(rhostname);
-		len = read(p1fd[0], rhostname, HLEN);
-		if (strcmp(hostname, rhostname) == 0) {
-			tst_resm(TPASS, "test 1 (%s): success", tsttype);
-			tst_exit();
-		}
-		tst_brkm(TFAIL, NULL,
-			 "test 1 (%s): hostname 1 %s, hostname 2 %s",
-			 tsttype, hostname, rhostname);
-	case 2:
-		gethostname(hostname, HLEN);
-		picknewhostname(hostname, newhostname);
-		err = sethostname(newhostname, strlen(newhostname));
-		write(p2fd[1], "1", 1);
-		if (err == -1) {
-			tst_brkm(TFAIL, NULL,
-				 "test 2 (%s): failed to sethostname",
-				 tsttype);
-		}
-		zeroize(rhostname);
-		len = read(p1fd[0], rhostname, HLEN);
-		if (strcmp(newhostname, rhostname) == 0) {
-			tst_resm(TPASS, "test 2 (%s): success", tsttype);
-			tst_exit();
-		}
-		tst_brkm(TFAIL, NULL,
-			 "test 2 (%s) hostname 1 %s, hostname 2 %s",
-			 tsttype, newhostname, rhostname);
-	case 3:
-		gethostname(hostname, HLEN);
-		picknewhostname(hostname, newhostname);
-		err = sethostname(newhostname, strlen(newhostname));
-		write(p2fd[1], "1", 1);
-		if (err == -1) {
-			tst_brkm(TFAIL, NULL,
-				 "test 3 (%s): failed to sethostname",
-				 tsttype);
-		}
-
-		zeroize(rhostname);
-		len = read(p1fd[0], rhostname, HLEN);
-		if (strcmp(newhostname, rhostname) == 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "test 3 (%s): hostname 1 %s, hostname 2 %s, these should have been different",
-				 tsttype, newhostname, rhostname);
-		}
-		if (strcmp(hostname, rhostname) == 0) {
-			tst_resm(TPASS, "test 3 (%s): success", tsttype);
-			tst_exit();
-		}
-		tst_brkm(TFAIL,
-			 NULL,
-			 "test 3 (%s): hostname 1 %s, hostname 2 %s, should have been same",
-			 tsttype, hostname, rhostname);
-
-	case 4:
-		gethostname(hostname, HLEN);
-		write(p2fd[1], "1", 1);	/* tell p2 to go ahead and sethostname */
-		zeroize(rhostname);
-		len = read(p1fd[0], rhostname, HLEN);
-		gethostname(newhostname, HLEN);
-		if (strcmp(hostname, newhostname) != 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "test 4 (%s): hostname 1 %s, hostname 2 %s, should be same",
-				 tsttype, hostname, newhostname);
-		}
-		if (strcmp(hostname, rhostname) == 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "test 4 (%s): hostname 1 %s, hostname 2 %s, should be different",
-				 tsttype, hostname, rhostname);
-		}
-		tst_resm(TPASS, "test 4 (%s): successful", tsttype);
-		tst_exit();
-	case 5:
-		write(p2fd[1], "1", 1);	/* tell p2 to go ahead and sethostname */
-		zeroize(rhostname);
-		len = read(p1fd[0], rhostname, HLEN);
-		gethostname(newhostname, HLEN);
-		if (strcmp(rhostname, newhostname) != 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "test 5 (%s): hostnames %s and %s should be same",
-				 tsttype, rhostname, newhostname);
-		}
-		tst_resm(TPASS, "test 5 (%s): successful", tsttype);
-		tst_exit();
-	default:
-		break;
-	}
-	tst_exit();
-}
-
-int P2(void *vtest)
-{
-	char hostname[HLEN], newhostname[HLEN];
-	int len;
-	int testnum;
-
-	testnum = atoi((char *)vtest);
-
-	close(p1fd[0]);
-	close(p2fd[1]);
-
-	switch (testnum) {
-	case 1:
-		gethostname(hostname, HLEN);
-		write(p1fd[1], hostname, strlen(hostname));
-		break;
-	case 2:
-	case 3:
-		len = 0;
-		while (!len) {
-			len = read(p2fd[0], hostname, 1);
-		}
-		gethostname(hostname, HLEN);
-		write(p1fd[1], hostname, strlen(hostname));
-		break;
-	case 4:
-	case 5:
-		len = 0;
-		while (!len) {
-			len = read(p2fd[0], hostname, 1);
-		}
-		if (hostname[0] == '0') {
-			tst_resm(TPASS, "P2: P1 claims error");
-			return 0;
-		}
-		gethostname(hostname, HLEN);
-		picknewhostname(hostname, newhostname);
-		sethostname(newhostname, strlen(newhostname));
-		write(p1fd[1], newhostname, strlen(newhostname));
-		break;
-	default:
-		tst_resm(TFAIL, "undefined test: %d", testnum);
-		break;
-	}
-	return 0;
-}
-
-static void setup(void)
-{
-	gethostname(oldhost, HLEN);
-	tst_require_root();
-	check_newuts();
-}
-
-static void cleanup(void)
-{
-	sethostname(oldhost, strlen(oldhost));
-}
-
-#define UNSHARESTR "unshare"
-#define CLONESTR "clone"
-int main(int argc, char *argv[])
-{
-	int r, pid, use_clone = T_UNSHARE;
-	int testnum;
-	void *vtest;
-
-	setup();
-	if (argc != 3) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare> <testnum>",
-			 argv[0]);
-		tst_resm(TFAIL,
-			 " where clone or unshare specifies unshare method,");
-		tst_resm(TFAIL, " and testnum is between 1 and 5 inclusive");
-		exit(2);
-	}
-	if (pipe(p1fd) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2fd) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-
-	tsttype = UNSHARESTR;
-	if (strcmp(argv[1], "clone") == 0) {
-		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	}
-
-	testnum = atoi(argv[2]);
-
-	vtest = (void *)argv[2];
-	switch (testnum) {
-	case 1:
-	case 2:
-		r = do_clone_unshare_tests(T_NONE, 0, P1, vtest, P2, vtest);
-		break;
-	case 3:
-	case 4:
-		r = do_clone_unshare_tests(use_clone, CLONE_NEWUTS,
-					   P1, vtest, P2, vtest);
-		break;
-	case 5:
-		pid = fork();
-		if (pid == -1) {
-			perror("fork");
-			exit(2);
-		}
-		if (pid == 0) {
-			if (!drop_root()) {
-				tst_brkm(TFAIL, NULL, "failed to drop root.");
-			}
-			r = do_clone_unshare_test(use_clone, CLONE_NEWUTS,
-						  P1, vtest);
-			write(p2fd[1], "0", 1);	/* don't let p2 hang */
-			exit(0);
-		} else {
-			P2(vtest);
-		}
-		break;
-	default:
-		tst_resm(TFAIL,
-			 "testnum should be between 1 and 5 inclusive.");
-		break;
-	}
-
-	cleanup();
-	tst_exit();
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
