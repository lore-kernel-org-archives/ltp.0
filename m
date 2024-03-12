Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C7FC54E58
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 15:49:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DA863CFD6C
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 16:49:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26F733C7FFE
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:48:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5EA0A60B029
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:48:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E48F5D6DE;
 Tue, 12 Mar 2024 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710258529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XmOU/jyw2H6OltGUYeHJtVAsI1QQidi21pFktKWmL8U=;
 b=CTaZptrNCElqaGEWoMnbvV9ixEwFKW9ZeGWWECmQCs1xe3I1Ur/1aWOqBYlUWlgqHc5soU
 j1w+vzKSAKNwWmWpr7NYAavL+ju2nSU3ILEV1EFTuInUlPf/WQbEnYoPyh4DuV32zQokhs
 oSdaWcKYaiP5ACfHscaVV6gfhJ0o+ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710258529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XmOU/jyw2H6OltGUYeHJtVAsI1QQidi21pFktKWmL8U=;
 b=aR61+F/Q+o5ha49BBmBm/jmU9KS65x8PMk/ZujnLDNaJ0k/ijn5p9qZJwQ0RuE2PnwjzuW
 qjiyYKUw+to1qFBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710258529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XmOU/jyw2H6OltGUYeHJtVAsI1QQidi21pFktKWmL8U=;
 b=CTaZptrNCElqaGEWoMnbvV9ixEwFKW9ZeGWWECmQCs1xe3I1Ur/1aWOqBYlUWlgqHc5soU
 j1w+vzKSAKNwWmWpr7NYAavL+ju2nSU3ILEV1EFTuInUlPf/WQbEnYoPyh4DuV32zQokhs
 oSdaWcKYaiP5ACfHscaVV6gfhJ0o+ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710258529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XmOU/jyw2H6OltGUYeHJtVAsI1QQidi21pFktKWmL8U=;
 b=aR61+F/Q+o5ha49BBmBm/jmU9KS65x8PMk/ZujnLDNaJ0k/ijn5p9qZJwQ0RuE2PnwjzuW
 qjiyYKUw+to1qFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F8A21364F;
 Tue, 12 Mar 2024 15:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D1zTCGF58GVDPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 12 Mar 2024 15:48:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Mar 2024 16:48:47 +0100
Message-Id: <20240312154847.16379-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CTaZptrN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="aR61+F/Q"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 6E48F5D6DE
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Refactor fork14 using new LTP API
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
SAFE_MMAP() usage
Check if memvec is NULL before munmap() and free()

 testcases/kernel/syscalls/fork/fork14.c | 197 ++++++++++--------------
 1 file changed, 81 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index 93af2ebac..a1cf13c3e 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -1,143 +1,108 @@
-/*********************************************************************
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
  * Copyright (C) 2014  Red Hat, Inc.
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- *
- * This test is a reporducer for this patch:
- *              https://lkml.org/lkml/2012/4/24/328
+ * This test is a reporducer for this patch: https://lkml.org/lkml/2012/4/24/328
  * Since vma length in dup_mmap is calculated and stored in a unsigned
  * int, it will overflow when length of mmaped memory > 16 TB. When
- * overflow occur, fork will  incorrectly succeed. The patch above
- * fixed it.
- ********************************************************************/
+ * overflow occur, fork will incorrectly succeed. The patch above fixed it.
+ */
 
-#include <sys/mman.h>
-#include <sys/wait.h>
-#include <stdio.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/abisize.h"
+#include "tst_test.h"
 
-char *TCID = "fork14";
-int TST_TOTAL = 1;
+#ifndef TST_ABI32
 
-#define GB		(1024 * 1024 * 1024L)
+#include <stdlib.h>
+#include <sys/wait.h>
 
-/* set mmap threshold to 16TB */
 #define LARGE		(16 * 1024)
 #define EXTENT		(16 * 1024 + 10)
 
-static char **pointer_vec;
-
-static void setup(void);
-static void cleanup(void);
-static int  fork_test(void);
+static char **memvec;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc, reproduced;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-/*
- * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
- * Since a 32bit program can't mmap so many memory.
- */
-#ifdef TST_ABI32
-	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
-#endif
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	int i, j, ret;
+	pid_t pid;
+	void *mem;
+	int prev_failed = 0;
+	int passed = 1;
 
-		reproduced = fork_test();
-		if (reproduced == 0)
-			tst_resm(TPASS, "fork failed as expected.");
-	}
-	cleanup();
-	tst_exit();
-}
+	for (i = 0; i < EXTENT; i++) {
+		mem = SAFE_MMAP(NULL, 1 * TST_GB,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS,
+			0, 0);
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+		memvec[i] = mem;
 
-	pointer_vec = SAFE_MALLOC(cleanup, EXTENT * sizeof(char *));
-}
+		pid = fork();
 
-static void cleanup(void)
-{
-	free(pointer_vec);
-}
-
-static int fork_test(void)
-{
-	int i, j, prev_failed = 0, fails = 0, cnt = 0;
-	int reproduced = 0;
-	void *addr;
-
-	for (i = 0; i < EXTENT; i++) {
-		addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-		if (addr == MAP_FAILED) {
-			pointer_vec[i] = NULL;
-			fails++;
-			/*
-			 * EXTENT is "16*1024+10", if fails count exceeds 10,
-			 * we are almost impossible to get an vm_area_struct
-			 * sized 16TB
+		if (pid == -1) {
+			/* keep track of the failed fork() and verify that next one
+			 * is failing as well.
 			 */
-			if (fails == 11) {
-				tst_brkm(TCONF, cleanup, "mmap() fails too many"
-					 "times, so we are almost impossible to"
-					 " get an vm_area_struct sized 16TB.");
-			}
-		} else {
-			pointer_vec[i] = addr;
+			prev_failed = 1;
+			continue;
 		}
-		cnt++;
 
-		switch (tst_fork()) {
-		case -1:
-			prev_failed = 1;
-		break;
-		case 0:
+		if (!pid)
 			exit(0);
-		default:
-			SAFE_WAITPID(cleanup, -1, NULL, 0);
-
-			if (prev_failed > 0 && i >= LARGE) {
-				tst_resm(TFAIL, "Fork succeeds incorrectly");
-				reproduced = 1;
-				goto clear_memory_map;
-			}
+
+		ret = waitpid(pid, NULL, 0);
+		if (ret == -1 && errno != ECHILD)
+			tst_brk(TBROK | TERRNO, "waitpid() error");
+
+		if (prev_failed && i >= LARGE) {
+			passed = 0;
+			break;
 		}
+
+		prev_failed = 0;
+
+		tst_res(TINFO, "fork() passed at %d attempt", i);
 	}
 
-clear_memory_map:
-	for (j = 0; j < cnt; j++) {
-		if (pointer_vec[j])
-			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
+	for (j = 0; j < i; j++) {
+		if (memvec[j])
+			SAFE_MUNMAP(memvec[j], 1 * TST_GB);
 	}
 
-	return reproduced;
+	if (passed)
+		tst_res(TPASS, "fork() failed as expected");
+	else
+		tst_res(TFAIL, "fork() succeeded incorrectly");
 }
+
+static void setup(void)
+{
+	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
+	memset(memvec, 0, EXTENT);
+}
+
+static void cleanup(void)
+{
+	for (long i = 0; i < EXTENT; i++) {
+		if (memvec && memvec[i])
+			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
+	}
+
+	if (memvec)
+		free(memvec);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
+
+#else /* TST_ABI32 */
+	TST_TEST_TCONF("Test doesn't supports 32bits architecture");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
