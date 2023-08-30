Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D3C83F15
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 13:25:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC733CC002
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 15:25:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12FED3CC006
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 15:25:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E2C81201104
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 15:25:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0CF71F45F;
 Wed, 30 Aug 2023 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693401929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJYkjmxRBSwINqAw1NZvUlR6DUbwm2TSGivoK21XIgk=;
 b=ppDnCGPZajXN1Cm0ZkwstWViu/VFDFj2acf7l39b/vagqn1Qeuc2m/yolJOtPpa8AnpeQp
 lADa4ymdXSYpft+v/ZYntqAqy7ZcXHtCqga20exnYfgGsy/Hikcaww4PBmzS5X/wxP+N1g
 qdogu/t8Daexta2gFQcbjg3ue332Otk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693401929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJYkjmxRBSwINqAw1NZvUlR6DUbwm2TSGivoK21XIgk=;
 b=W2gUxkUqVBmN1j3e96e8CkiDsMiu+NHKXAzXRC1fvVCrVXhjiYF4dPcyayw1EqXDfDUNvh
 CYux/0f+OEeOm5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3B3E13441;
 Wed, 30 Aug 2023 13:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8AphJklD72QXaAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Aug 2023 13:25:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 30 Aug 2023 15:25:27 +0200
Message-Id: <20230830132528.26521-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230830132528.26521-1-andrea.cervesato@suse.de>
References: <20230830132528.26521-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] Refactor personality01 using new API
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
 .../syscalls/personality/personality01.c      | 93 +++++--------------
 1 file changed, 23 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/syscalls/personality/personality01.c b/testcases/kernel/syscalls/personality/personality01.c
index b646e2a9b..47fb66256 100644
--- a/testcases/kernel/syscalls/personality/personality01.c
+++ b/testcases/kernel/syscalls/personality/personality01.c
@@ -1,24 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2016 Linux Test Project
  * Copyright (c) International Business Machines  Corp., 2001
  *  03/2001 - Written by Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Tries to set different personalities.
  *
  * We set the personality in a child process since it's not guaranteed that we
@@ -26,19 +17,17 @@
  * bit archs.
  */
 
-#include "test.h"
-#include <sys/personality.h>
-
-char *TCID = "personality01";
+#include "tst_test.h"
+#include "lapi/personality.h"
 
 #define PAIR(id) {id, #id}
 
 struct personalities {
-	unsigned long int pers;
+	unsigned long pers;
 	const char *name;
 };
 
-struct personalities pers[] = {
+static struct personalities pers[] = {
 	PAIR(PER_LINUX),
 	PAIR(PER_LINUX_32BIT),
 	PAIR(PER_SVR4),
@@ -62,60 +51,24 @@ struct personalities pers[] = {
 	PAIR(PER_HPUX),
 };
 
-int TST_TOTAL = ARRAY_SIZE(pers);
-
-static void do_child(unsigned int i)
+static void run(unsigned int i)
 {
-	int ret;
+	pid_t pid;
 
-	ret = personality(pers[i].pers);
-	if (ret < 0) {
-		tst_resm(TFAIL | TERRNO, "personality(%s) failed", pers[i].name);
-		return;
-	}
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_PERSONALITY(pers[i].pers);
 
-	ret = personality(0xffffffff);
+		TST_EXP_EXPR((unsigned long)SAFE_PERSONALITY(0xffffffff) == pers[i].pers,
+			"%s personality is set",
+			 pers[i].name);
 
-	if ((unsigned long)ret != pers[i].pers) {
-		tst_resm(TFAIL,
-			 "%s: wrong personality read back %d expected %lu",
-			 pers[i].name, ret, pers[i].pers);
 		return;
 	}
-
-	tst_resm(TPASS, "personality(%s)", pers[i].name);
-}
-
-static void verify_personality(unsigned int i)
-{
-	pid_t pid;
-
-	pid = tst_fork();
-	switch (pid) {
-	case 0:
-		do_child(i);
-		tst_exit();
-	break;
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-	break;
-	default:
-		tst_record_childstatus(NULL, pid);
-	break;
-	}
 }
 
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++) {
-			verify_personality(i);
-		}
-	}
-
-	tst_exit();
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(pers),
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
