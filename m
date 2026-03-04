Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCD0EF8FEA
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:13:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 042CA3D9E97
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:13:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 079E63DC86E
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:12:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57AB52009FA
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:12:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F30E5BE15
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772633547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KokNK34COWL19GnoouV/xkPZ1hXqH/koPPMirLcfgps=;
 b=jhP1lDYEWz2oi+RQHcMHsSJ9L59Wyl6r2xlse8lCx4Rp+ePIV1bL64yRLI7PgbBy3mLnHm
 cbRZ63+a9GaW626Qi29JOq8xZcz/HDAYFNkB/YfF73pg1EounYZj9ZS1HJ/A5klSIHJzFI
 9F/P241EKtb7Wp75j5cNgMNBhFptj1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772633547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KokNK34COWL19GnoouV/xkPZ1hXqH/koPPMirLcfgps=;
 b=+fU3SxTg55yN+ukg/R5UravrNggPKyUrFmI5n23Rft+2MW2ZhZrk54N9fAgseBDFJrgTZX
 KgwyK53eHXt3ffCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jhP1lDYE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+fU3SxTg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772633547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KokNK34COWL19GnoouV/xkPZ1hXqH/koPPMirLcfgps=;
 b=jhP1lDYEWz2oi+RQHcMHsSJ9L59Wyl6r2xlse8lCx4Rp+ePIV1bL64yRLI7PgbBy3mLnHm
 cbRZ63+a9GaW626Qi29JOq8xZcz/HDAYFNkB/YfF73pg1EounYZj9ZS1HJ/A5klSIHJzFI
 9F/P241EKtb7Wp75j5cNgMNBhFptj1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772633547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KokNK34COWL19GnoouV/xkPZ1hXqH/koPPMirLcfgps=;
 b=+fU3SxTg55yN+ukg/R5UravrNggPKyUrFmI5n23Rft+2MW2ZhZrk54N9fAgseBDFJrgTZX
 KgwyK53eHXt3ffCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 601B73EA69
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eQKGFss9qGl3fwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 14:12:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 15:12:35 +0100
Message-ID: <20260304141236.9080-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304141236.9080-1-chrubis@suse.cz>
References: <20260304141236.9080-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 6F30E5BE15
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls: sysinfo01: Rewrite
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

Rewrite sysinfo01 into a proper syscall test. Now the test asserts that
the values we get in the sysinfo buffer make sense.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/sysinfo/sysinfo01.c | 218 +++++-------------
 1 file changed, 59 insertions(+), 159 deletions(-)

diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo01.c b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
index 2ea44a2be..9e7ff4ad6 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo01.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
@@ -1,176 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
- * Test Name :	sysinfo01
- *
- * Test description
- *  Verify that sysinfo() succeeds to get the system information and fills
- *  the structure passed.
- *
- * Expected Result :
- *  sysinfo() returns value 0 on success and the sysinfo structure should
- *  be filled with the system information.
- *
- * Algorithm:
- *  Setup :
- *   Setup for signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- * Test:
- *  Loop if the proper option is given.
- *  Execute the system call.
- *  Check return code, if system call failed (return=-1)
- *	Log the errno and Issue a FAIL message.
- *  Otherwise,
- *	if we are being called by another sysinfo test.
- *		Print the infomation that was returned for use by the calling
- *		test.
- *	otherwise,
- *		Report success.
- * Cleanup:
- *  Print errno log and/or timing stats if options given
- *  Delete the temporary directory created.
- *
- * USAGE:  <for command-line>
- *	sysinfo01 [-c n] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  None
- *
+/*\
+ * Verify that sysinfo() succeeds to get the system information and fills the
+ * structure passed. We do sanity checks on the returned values, either
+ * comparing it againts values from /proc/ files or by checking that the values
+ * are in sane e.g. free RAM <= total RAM.
  */
 
-#include <stdio.h>
-#include <errno.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/signal.h>
+#include <stdlib.h>
+#include <math.h>
 #include <sys/sysinfo.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "sysinfo01";
-int TST_TOTAL = 1;
+static struct sysinfo *sys_buf;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	struct sysinfo *sys_buf;
-	int lc;
-	float l1, l2, l3;
-	unsigned long l1_up, l2_up, l3_up;
-
-	sys_buf = malloc(sizeof(struct sysinfo));
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* Global setup */
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(sysinfo(sys_buf));
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			/* To gather stats on errnos returned, log the errno */
-			tst_brkm(TFAIL, cleanup, "sysinfo() Failed, errno=%d"
-				 " : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			/* Test succeeded */
-
-			/* This portion of the code generates information
-			 * used by sysinfo03 to test the functionality of
-			 * sysinfo.
-			 */
-
-			if (ac == 2 && !strncmp(av[1], "TEST3", 5)) {
-				tst_resm(TINFO, "Generating info for "
-					 "sysinfo03");
-				l1 = sys_buf->loads[0] / 60000.0;
-				l2 = sys_buf->loads[1] / 60000.0;
-				l3 = sys_buf->loads[2] / 60000.0;
-				l1_up = l1 * 100;
-				l2_up = l2 * 100;
-				l3_up = l3 * 100;
-				sys_buf->loads[0] = sys_buf->loads[0] / 10;
-				sys_buf->loads[1] = sys_buf->loads[1] / 10;
-				sys_buf->loads[2] = sys_buf->loads[2] / 10;
-				printf("uptime %lu\n", sys_buf->uptime);
-				printf("load1 %lu\n", sys_buf->loads[0]);
-				printf("load2 %lu\n", sys_buf->loads[1]);
-				printf("load3 %lu\n", sys_buf->loads[2]);
-				printf("l1 %lu\n", l1_up);
-				printf("l2 %lu\n", l2_up);
-				printf("l3 %lu\n", l3_up);
-				printf("totalram %lu\n", sys_buf->totalram);
-				printf("freeram  %lu\n", sys_buf->freeram);
-				printf("sharedram %lu\n", sys_buf->sharedram);
-				printf("bufferram %lu\n", sys_buf->bufferram);
-				printf("totalswap %lu\n",
-				       sys_buf->totalswap / (1024 * 1024));
-				printf("freeswap %lu\n", sys_buf->freeswap);
-				printf("procs %lu\n",
-				       (unsigned long)sys_buf->procs);
-			} else {
-				tst_resm(TPASS,
-					 "Test to check the return code PASSED");
-			}
-		}
+	long uptime;
+	float load1, load5, load15;
+	float sys_load1, sys_load5, sys_load15;
+	unsigned long totalswap, totalswap_kb;
+	unsigned long totalram, totalram_kb;
+
+	TST_EXP_PASS(sysinfo(sys_buf));
+
+	if (!TST_PASS)
+		return;
+
+	SAFE_FILE_SCANF("/proc/uptime", "%ld", &uptime);
+	SAFE_FILE_SCANF("/proc/loadavg", "%f %f %f", &load1, &load5, &load15);
+	totalram = SAFE_READ_MEMINFO("MemTotal:");
+	totalswap = SAFE_READ_MEMINFO("SwapTotal:");
+
+	if (sys_buf->uptime < uptime || sys_buf->uptime - uptime > 2) {
+		tst_res(TFAIL, "uptime: %ld, expected between %ld and %ld",
+			sys_buf->uptime, uptime, uptime + 2);
+	} else {
+		tst_res(TPASS, "uptime: %ld (>= %ld)", sys_buf->uptime, uptime);
 	}
 
-	cleanup();
-	tst_exit();
+	sys_load1 = sys_buf->loads[0] / 65536.0;
+	sys_load5 = sys_buf->loads[1] / 65536.0;
+	sys_load15 = sys_buf->loads[2] / 65536.0;
 
-}
-
-/*
- * setup()
- *	performs one time setup
- *
- */
-void setup(void)
-{
+	/* Compare loads with tolerance */
+	if (fabs(sys_load1 - load1) > 0.1 || fabs(sys_load5 - load5) > 0.1 || fabs(sys_load15 - load15) > 0.1) {
+		tst_res(TFAIL, "loadavg: %.2f %.2f %.2f, expected ~%.2f %.2f %.2f",
+			sys_load1, sys_load5, sys_load15, load1, load5, load15);
+	} else {
+		tst_res(TPASS, "loadavg: %.2f %.2f %.2f", sys_load1, sys_load5, sys_load15);
+	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	totalram_kb = ((unsigned long long)sys_buf->totalram * sys_buf->mem_unit) / 1024;
+	totalswap_kb = ((unsigned long long)sys_buf->totalswap * sys_buf->mem_unit) / 1024;
 
-	umask(0);
+	TST_EXP_EQ_LU(totalram_kb, totalram);
+	TST_EXP_EQ_LU(totalswap_kb, totalswap);
 
-	TEST_PAUSE;
+	TST_EXP_LE_LU(sys_buf->freeram, sys_buf->totalram);
+	TST_EXP_LE_LU(sys_buf->sharedram, sys_buf->totalram);
+	TST_EXP_LE_LU(sys_buf->bufferram, sys_buf->totalram);
+	TST_EXP_LE_LU(sys_buf->freeswap, sys_buf->totalswap);
 }
 
-/*
- * cleanup()
- *
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.bufs = (struct tst_buffers[]) {
+		{&sys_buf, .size = sizeof(*sys_buf)},
+		{}
+	}
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
