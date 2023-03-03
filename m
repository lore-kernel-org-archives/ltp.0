Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AA7C678D4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 09:45:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2E053CB9A5
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 10:45:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 657AC3C9DD2
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 10:45:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E14B1000910
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 10:44:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DE2C203EC;
 Fri,  3 Mar 2023 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677836698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wciEQIU2gRHWfk3PJWUkV7348oANv/4etpJXtNAzCUw=;
 b=s/L9wmVVVl6flDz0/lRPiluGKKV48CHAQIoGTPT746UOm+37BFGNH0Bk4tzr+xe+DaFhJ1
 V2skgTidp2+O2IrCDklTt/jFMhizm4B/OXZBh6ZZz2Mm3JkFreLcervoCM8OkU5pKuyQrL
 jxxHBDh84q9y460qVan+X6yJrf+UvSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677836698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wciEQIU2gRHWfk3PJWUkV7348oANv/4etpJXtNAzCUw=;
 b=EjzJztbcUzf9hqPHJt2OmbWhCmuWx4PTr6gl/JiaSAYNlOfv3BdTPJ8ud+CgrvvVmJj+JK
 5mAaGUmkSgjaUSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16EC81329E;
 Fri,  3 Mar 2023 09:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kNOkA5rBAWQydQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 03 Mar 2023 09:44:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  3 Mar 2023 10:42:53 +0100
Message-Id: <20230303094253.20952-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite ns_exec tool using new LTP API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/share/ns_exec.c | 137 +++++++-------------
 1 file changed, 47 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
index 4abd1063b..982979218 100644
--- a/testcases/kernel/containers/share/ns_exec.c
+++ b/testcases/kernel/containers/share/ns_exec.c
@@ -1,44 +1,34 @@
-/* Copyright (c) 2015 Red Hat, Inc.
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
- *
- * Written by Matus Marhefka <mmarhefk@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Red Hat, Inc.
+ *               Matus Marhefka <mmarhefk@redhat.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- ***********************************************************************
  * Enters the namespace(s) of a process specified by a PID and then executes
  * the indicated program inside that namespace(s).
- *
  */
 
-#define _GNU_SOURCE
-#include <sys/syscall.h>
-#include <sys/types.h>
+#define TST_NO_DEFAULT_MAIN
+
+#include <stdio.h>
 #include <sys/wait.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "test.h"
-#include "lapi/syscalls.h"
-#include "lapi/sched.h"
+#include "tst_test.h"
 #include "ns_common.h"
 
-char *TCID = "ns_exec";
-int ns_fd[NS_TOTAL];
-int ns_fds;
+extern struct tst_test *tst_test;
+
+static struct tst_test test = {
+	.forks_child = 1, /* Needed by SAFE_CLONE */
+};
 
+static int ns_fd[NS_TOTAL];
+static int ns_fds;
 
-void print_help(void)
+static void print_help(void)
 {
 	int i;
 
@@ -46,30 +36,24 @@ void print_help(void)
 
 	for (i = 1; params[i].name; i++)
 		printf("|,%s", params[i].name);
+
 	printf("> <PROGRAM> [ARGS]\nSecond argument indicates the types"
-	       " of a namespaces maintained by NS_PID\nand is specified"
-	       " as a comma separated list.\nExample: ns_exec 1234 net,ipc"
-	       " ip a\n");
+		" of a namespaces maintained by NS_PID\nand is specified"
+		" as a comma separated list.\nExample: ns_exec 1234 net,ipc"
+		" ip a\n");
 }
 
-static int open_ns_fd(const char *pid, const char *ns)
+static void open_ns_fd(const char *pid, const char *ns)
 {
 	int fd;
-	char file_buf[30];
+	char file_buf[64];
 
 	sprintf(file_buf, "%s/%s/ns/%s", PROC_PATH, pid, ns);
 
-	fd = open(file_buf, O_RDONLY);
-	if (fd > 0) {
-		ns_fd[ns_fds] = fd;
-		++ns_fds;
-		return 0;
-	} else if (fd == -1 && errno != ENOENT) {
-		tst_resm(TINFO | TERRNO, "open");
-		return -1;
-	}
+	fd = SAFE_OPEN(file_buf, O_RDONLY);
+	ns_fd[ns_fds] = fd;
 
-	return 0;
+	++ns_fds;
 }
 
 static void close_ns_fd(void)
@@ -77,31 +61,16 @@ static void close_ns_fd(void)
 	int i;
 
 	for (i = 0; i < ns_fds; i++)
-		close(ns_fd[i]);
+		SAFE_CLOSE(ns_fd[i]);
 }
 
-static int child_fn(void *arg)
-{
-	char **args = (char **)arg;
-
-	execvp(args[3], args+3);
-	tst_resm(TINFO | TERRNO, "execvp");
-	return 1;
-}
-
-/*
- * ./ns_exec <NS_PID> <ipc,mnt,net,pid,user,uts> <PROGRAM> [ARGS]
- */
 int main(int argc, char *argv[])
 {
-	int i, rv, pid;
+	struct tst_clone_args args = { 0, SIGCHLD };
+	int i, status, pid;
 	char *token;
 
-	rv = syscall(__NR_setns, -1, 0);
-	if (rv == -1 && errno == ENOSYS) {
-		tst_resm(TINFO, "setns is not supported in the kernel");
-		return 1;
-	}
+	tst_test = &test;
 
 	if (argc < 4) {
 		print_help();
@@ -109,49 +78,37 @@ int main(int argc, char *argv[])
 	}
 
 	memset(ns_fd, 0, sizeof(ns_fd));
+
 	while ((token = strsep(&argv[2], ","))) {
 		struct param *p = get_param(token);
 
 		if (!p) {
-			tst_resm(TINFO, "Unknown namespace: %s", token);
+			printf("Unknown namespace: %s\n", token);
 			print_help();
 			return 1;
 		}
 
-		if (open_ns_fd(argv[1], token) != 0)
-			return 1;
+		open_ns_fd(argv[1], token);
 	}
 
-	if (ns_fds == 0) {
-		tst_resm(TINFO, "no namespace entries in /proc/%s/ns/",
-			 argv[1]);
+	if (!ns_fds) {
+		printf("no namespace entries in /proc/%s/ns/\n", argv[1]);
 		return 1;
 	}
 
-	for (i = 0; i < ns_fds; i++) {
-		if (syscall(__NR_setns, ns_fd[i], 0) == -1) {
-			tst_resm(TINFO | TERRNO, "setns");
-			close_ns_fd();
-			return 1;
-		}
-	}
+	for (i = 0; i < ns_fds; i++)
+		SAFE_SETNS(ns_fd[i], 0);
 
-	pid = ltp_clone_quick(SIGCHLD, (void *)child_fn, (void *)argv);
-	if (pid == -1) {
-		tst_resm(TINFO | TERRNO, "ltp_clone_quick");
-		close_ns_fd();
-		return 1;
-	}
+	pid = SAFE_CLONE(&args);
+	if (!pid)
+		SAFE_EXECVP(argv[3], argv+3);
 
-	if (waitpid(pid, &rv, 0) == -1) {
-		tst_resm(TINFO | TERRNO, "waitpid");
-		return 1;
-	}
+	SAFE_WAITPID(pid, &status, 0);
 
 	close_ns_fd();
 
-	if (WIFEXITED(rv))
-		return WEXITSTATUS(rv);
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
 
 	return 0;
 }
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
