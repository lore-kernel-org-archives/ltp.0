Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648AEC25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:54:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1A633D006A
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:54:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BE493C0562
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:54 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 738ED1400BED
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C171621F04;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjxI1X+r1h4ei7+xP1hmWJMiplKNEUIPL4A37cf9YhY=;
 b=usIDALmKwGrAwcvJViPrfFjdAJpkeGziQhB7it1xs6z8OV+Rey3NNYtuSzcd7SuXUO3jj0
 m5SrVX6zusn5ThGLZ8GhVYQmNKrTOaRIU/OPOYi2Irm46Imp5EAPGOsKDSw9zy5pZxWtBt
 6CsN1Sbgr+rB3YG99ZrctQwQAjCWoqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjxI1X+r1h4ei7+xP1hmWJMiplKNEUIPL4A37cf9YhY=;
 b=TMWW5BAavTwSFr+Z5I6vqxIpF+um8gzNo4fcsoyMwxBZI8jB/JMJINYK7xKxtwbMRLg5jx
 212M3vYQOhpCl3Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WLG9NUv9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5a0IG3U2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjxI1X+r1h4ei7+xP1hmWJMiplKNEUIPL4A37cf9YhY=;
 b=WLG9NUv9jB6yV3i3POANjGcrMYW25tWXfbuu+2ROZpZqtouidFPrQpV8xDFodRjWKHq7MY
 23jiK0L9pnvVhjLvu5/bWNX7veDELAXBH34T31je2/bXbCiPQ9eMhxBCVLhjPzxZebZEba
 eyLkk5eSGnk9BJqr+IzQX3V6fN/x3so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjxI1X+r1h4ei7+xP1hmWJMiplKNEUIPL4A37cf9YhY=;
 b=5a0IG3U26NEyBe60Aiaem3EkBZR2nDE4ABme/Vyf450++Yq2pUjrZnwazj5lzrZUh7Ss+H
 GyiGhr0npg+mxDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912A313A7A;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QPJzIj99TGYMPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 10:53:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 12:53:46 +0200
Message-ID: <20240521105348.126316-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521105348.126316-1-pvorel@suse.cz>
References: <20240521105348.126316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email, suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C171621F04
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] Refactor fork14 using new LTP API
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

Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: replace .skip_in_compat = 1 with .needs_abi_bits = 64 ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Change from .skip_in_32bit = 1 to .needs_abi_bits = 64

 testcases/kernel/syscalls/fork/fork14.c | 209 +++++++++++-------------
 1 file changed, 95 insertions(+), 114 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index 93af2ebac..d61864b52 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -1,143 +1,124 @@
-/*********************************************************************
+// SPDX-License-Identifier: GPL-2.0-only
+/*
  * Copyright (C) 2014  Red Hat, Inc.
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
+ * This test is a reproducer for kernel 3.5:
+ * 7edc8b0ac16c ("mm/fork: fix overflow in vma length when copying mmap on clone")
  *
- * This test is a reporducer for this patch:
- *              https://lkml.org/lkml/2012/4/24/328
- * Since vma length in dup_mmap is calculated and stored in a unsigned
+ * Since VMA length in dup_mmap() is calculated and stored in a unsigned
  * int, it will overflow when length of mmaped memory > 16 TB. When
- * overflow occur, fork will  incorrectly succeed. The patch above
- * fixed it.
- ********************************************************************/
+ * overflow occurs, fork will incorrectly succeed. The patch above fixed it.
+ */
 
-#include <sys/mman.h>
+#include "tst_test.h"
+#include <stdlib.h>
 #include <sys/wait.h>
-#include <stdio.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/abisize.h"
-
-char *TCID = "fork14";
-int TST_TOTAL = 1;
-
-#define GB		(1024 * 1024 * 1024L)
 
-/* set mmap threshold to 16TB */
 #define LARGE		(16 * 1024)
 #define EXTENT		(16 * 1024 + 10)
 
-static char **pointer_vec;
+static char **memvec;
 
-static void setup(void);
-static void cleanup(void);
-static int  fork_test(void);
-
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
-
-		reproduced = fork_test();
-		if (reproduced == 0)
-			tst_resm(TPASS, "fork failed as expected.");
-	}
-	cleanup();
-	tst_exit();
-}
+	int i, j, ret;
+	pid_t pid;
+	void *mem;
+	int prev_failed = 0;
+	int passed = 1;
+	int failures = 0;
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	memset(memvec, 0, EXTENT);
 
-	pointer_vec = SAFE_MALLOC(cleanup, EXTENT * sizeof(char *));
-}
+	for (i = 0; i < EXTENT; i++) {
+		mem = mmap(NULL, 1 * TST_GB,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS,
+			0, 0);
 
-static void cleanup(void)
-{
-	free(pointer_vec);
-}
+		if (mem == MAP_FAILED) {
+			failures++;
 
-static int fork_test(void)
-{
-	int i, j, prev_failed = 0, fails = 0, cnt = 0;
-	int reproduced = 0;
-	void *addr;
+			tst_res(TINFO, "mmap() failed");
 
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
-			 */
-			if (fails == 11) {
-				tst_brkm(TCONF, cleanup, "mmap() fails too many"
-					 "times, so we are almost impossible to"
-					 " get an vm_area_struct sized 16TB.");
+			if (failures > 10) {
+				tst_brk(TCONF, "mmap() fails too many "
+					"times, so it's almost impossible to "
+					"get a vm_area_struct sized 16TB");
 			}
-		} else {
-			pointer_vec[i] = addr;
+
+			continue;
 		}
-		cnt++;
 
-		switch (tst_fork()) {
-		case -1:
+		memvec[i] = mem;
+
+		pid = fork();
+
+		if (pid == -1) {
+			/* keep track of the failed fork() and verify that next one
+			 * is failing as well.
+			 */
 			prev_failed = 1;
-		break;
-		case 0:
+			continue;
+		}
+
+		if (!pid)
 			exit(0);
-		default:
-			SAFE_WAITPID(cleanup, -1, NULL, 0);
 
-			if (prev_failed > 0 && i >= LARGE) {
-				tst_resm(TFAIL, "Fork succeeds incorrectly");
-				reproduced = 1;
-				goto clear_memory_map;
-			}
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
+		tst_res(TDEBUG, "fork() passed at %d attempt", i);
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
+	.needs_abi_bits = 64,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "7edc8b0ac16c"},
+		{}
+	}
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
