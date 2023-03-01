Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7353FC64EC7
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 09:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3F823CDD3F
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 10:19:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B3963CBB18
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 10:19:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 88BF4600843
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 10:19:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DE2121A35;
 Wed,  1 Mar 2023 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677662381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TLzhEptLshhQ90nlKmnrUu32uv42GXFQleALbjP4x/M=;
 b=R5FSEqGoA9UP5A5LvGJd5CAI6bPavBHbmLU567dQLCBbK1+oHX+G+ynMCKsym5/8v9pAcJ
 Rxv2VNN0tHr6GxVjBRHFRH3sdVNUiaC8Qs3xvRYipLKY01CYAZVoZmZSQvd+idxEonD9V/
 aKBOPVOU4AEpzZUYKyta6IHpFHX24w0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 480DD13A3E;
 Wed,  1 Mar 2023 09:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jYCbD60Y/2M6BAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 01 Mar 2023 09:19:41 +0000
To: ltp@lists.linux.it
Date: Wed,  1 Mar 2023 10:17:37 +0100
Message-Id: <20230301091737.32083-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite ns_create using new LTP API
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

Removed ltp_clone_quick from ns_create and updated it with the new LTP
API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/share/ns_create.c | 89 ++++++++-----------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
index 3f09e71e0..c2e05640c 100644
--- a/testcases/kernel/containers/share/ns_create.c
+++ b/testcases/kernel/containers/share/ns_create.c
@@ -1,43 +1,34 @@
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
  * Creates a child process in the new specified namespace(s), child is then
  * daemonized and is running in the background. PID of the daemonized child
  * process is printed on the stdout. As the new namespace(s) is(are) maintained
  * by the daemonized child process it(they) can be removed by killing this
  * process.
- *
  */
 
-#define _GNU_SOURCE
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
+#define TST_NO_DEFAULT_MAIN
+
+#include <stdio.h>
 #include <string.h>
-#include <errno.h>
-#include "test.h"
-#include "lapi/sched.h"
+#include "tst_test.h"
 #include "ns_common.h"
 
-char *TCID = "ns_create";
+extern struct tst_test *tst_test;
 
+static struct tst_test test = {
+	.forks_child = 1, /* Needed by SAFE_CLONE */
+};
 
-void print_help(void)
+static void print_help(void)
 {
 	int i;
 
@@ -45,64 +36,56 @@ void print_help(void)
 
 	for (i = 1; params[i].name; i++)
 		printf("|,%s", params[i].name);
-	printf(">\nThe only argument is a comma separated list "
-	       "of namespaces to create.\nExample: ns_create net,ipc\n");
+
+	printf(">\n");
 }
 
-static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void child_fn(void)
 {
 	int i;
 
-	if (setsid() == -1) {
-		tst_resm(TINFO | TERRNO, "setsid");
-		exit(1);
-	}
-
-	if (chdir("/") == -1) {
-		tst_resm(TINFO | TERRNO, "chdir");
-		exit(1);
-	}
+	SAFE_SETSID();
+	SAFE_CHDIR("/");
 
-	/* close all inherrited file descriptors */
-	for (i = 0; i < sysconf(_SC_OPEN_MAX); i++)
+	for (i = 0; i < SAFE_SYSCONF(_SC_OPEN_MAX); i++)
 		close(i);
 
+	printf("pausing child\n");
 	pause();
-	return 0;
 }
 
-/*
- * ./ns_create <ipc,mnt,net,pid,user,uts>
- */
 int main(int argc, char *argv[])
 {
-	int pid, flags;
+	struct tst_clone_args args = { 0, SIGCHLD };
 	char *token;
+	int pid;
 
 	if (argc < 2) {
 		print_help();
 		return 1;
 	}
 
-	flags = 0;
+	tst_test = &test;
+
 	while ((token = strsep(&argv[1], ","))) {
 		struct param *p = get_param(token);
 
 		if (!p) {
-			tst_resm(TINFO, "Unknown namespace: %s", token);
+			printf("Unknown namespace: %s\n", token);
 			print_help();
 			return 1;
 		}
 
-		flags |= p->flag;
+		args.flags |= p->flag;
 	}
 
-	pid = ltp_clone_quick(flags | SIGCHLD, child_fn, NULL);
-	if (pid == -1) {
-		tst_resm(TINFO | TERRNO, "ltp_clone_quick");
-		return 1;
+	pid = SAFE_CLONE(&args);
+	if (!pid) {
+		child_fn();
+		return 0;
 	}
 
 	printf("%d", pid);
+
 	return 0;
 }
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
