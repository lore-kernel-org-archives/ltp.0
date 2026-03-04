Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF95EF9001
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:14:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D8643DCE2A
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 17:14:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85D973C1BA2
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 17:14:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E8C85600ABE
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 17:14:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F9AF3F943
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772640855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RvsEPWQmnwRxp2uxrhUD36NcS07AioMrVyxeGQDYZJs=;
 b=QOvnBiAcwAV0VumyAIQOPkJqKesS58VIAw/BVaZBm17VDrbd4v7hOjhMkoDj/qv13Ozm5E
 b6FY3S3SueX0/wuGZTE6PEt0p2MJVoHzQdnHA1xXWrpQbTT6sqa4akalayfBquzUd61AAf
 NMscVSctZtGJiRf6bBU2CZWwHb33P+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772640855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RvsEPWQmnwRxp2uxrhUD36NcS07AioMrVyxeGQDYZJs=;
 b=o3nGLikqL7SSTrlfs7yRfgijZtHtwiR9pE+vSQzbTB+KYctvCvyjnu/GyDILMourWE6R30
 1eHOQ6QlU4t+3NBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QOvnBiAc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o3nGLikq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772640855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RvsEPWQmnwRxp2uxrhUD36NcS07AioMrVyxeGQDYZJs=;
 b=QOvnBiAcwAV0VumyAIQOPkJqKesS58VIAw/BVaZBm17VDrbd4v7hOjhMkoDj/qv13Ozm5E
 b6FY3S3SueX0/wuGZTE6PEt0p2MJVoHzQdnHA1xXWrpQbTT6sqa4akalayfBquzUd61AAf
 NMscVSctZtGJiRf6bBU2CZWwHb33P+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772640855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RvsEPWQmnwRxp2uxrhUD36NcS07AioMrVyxeGQDYZJs=;
 b=o3nGLikqL7SSTrlfs7yRfgijZtHtwiR9pE+vSQzbTB+KYctvCvyjnu/GyDILMourWE6R30
 1eHOQ6QlU4t+3NBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 211443EA6D
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jNNNB1daqGkiBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 16:14:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 17:14:25 +0100
Message-ID: <20260304161425.12461-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F9AF3F943
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: newuname01: Convert to the new library.
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/newuname/newuname01.c     | 186 ++++--------------
 1 file changed, 39 insertions(+), 147 deletions(-)

diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index 2b9349e35..6a4f1a50c 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -1,161 +1,53 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007                                   */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        newuname01.c                                           */
-/*                                                                            */
-/* Description: This tests the newuname() syscall                      */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* newuname01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   newuname01                                             */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
-#include <unistd.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (c) Linux Test Project, 2024
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that uname() succeeds and correctly identifies the system as Linux.
+ * The rest of the values, when possible, are matched againts the strings from
+ * /proc/sys/kernel/. The only value we cannot easily assert is the machine
+ * field which is the architecture the kernel was compiled for, which would
+ * require special handling per each architecture.
+ */
+
+#define _GNU_SOURCE
 #include <sys/utsname.h>
-#include <errno.h>
-#include <stdio.h>
-#include <sys/stat.h>
-#include <stdlib.h>
-
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
-char *TCID = "newuname01";
-int testno;
-int TST_TOTAL = 1;
+static struct utsname *name;
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
+static void run(void)
 {
+	char proc_val[1024] = {};
 
-	tst_rmdir();
+	TST_EXP_PASS(tst_syscall(__NR_uname, name), "uname(name)");
 
-	tst_exit();
-}
+	if (!TST_PASS)
+		return;
 
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
-{
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+	TST_EXP_EQ_STR(name->sysname, "Linux");
 
-int main(int ac, char **av)
-{
-	struct utsname name;
-	int lc;
+	SAFE_FILE_SCANF("/proc/sys/kernel/hostname", "%1023[^\n]", proc_val);
+	TST_EXP_EQ_STR(name->nodename, proc_val);
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	SAFE_FILE_SCANF("/proc/sys/kernel/osrelease", "%1023[^\n]", proc_val);
+	TST_EXP_EQ_STR(name->release, proc_val);
 
-	setup();
+	SAFE_FILE_SCANF("/proc/sys/kernel/version", "%1023[^\n]", proc_val);
+	TST_EXP_EQ_STR(name->version, proc_val);
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(tst_syscall(__NR_uname, &name));
-			if (TEST_RETURN == -1) {
-				tst_brkm(TFAIL, cleanup, "%s failed - errno = %d : %s",
-					 TCID, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TPASS,
-					 "newuname call succeed: return value = %ld ",
-					 TEST_RETURN);
-				TEST(strcmp(name.sysname, "Linux"));	//Linux ?
-				if (TEST_RETURN == 0) {
-					tst_resm(TINFO, "This system is %s",
-						 name.sysname);
-					tst_resm(TINFO,
-						 "The system infomation is :");
-					tst_resm(TINFO,
-						 "System is %s on %s hardware",
-						 name.sysname, name.machine);
-
-					tst_resm(TINFO, "Nodename is %s",
-						 name.nodename);
-					tst_resm(TINFO, "Version is %s, %s",
-						 name.release, name.version);
-					tst_resm(TINFO, "Domainname is %s ",
-						 *(&name.machine + 1));
-					cleanup();
-					tst_exit();
-				} else {
-					tst_resm(TFAIL,
-						 "%s failed - errno = %d : %s",
-						 TCID, TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-					tst_resm(TINFO,
-						 "This system is not Linux");
-					cleanup();
-					tst_exit();
-				}
-
-			}
+	SAFE_FILE_SCANF("/proc/sys/kernel/domainname", "%1023[^\n]", proc_val);
+	TST_EXP_EQ_STR(name->domainname, proc_val);
+}
 
-		}
+static struct tst_test test = {
+	.test_all = run,
+	.bufs = (struct tst_buffers []) {
+		{&name, .size = sizeof(*name)},
+		{}
 	}
-	tst_exit();
-}
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
