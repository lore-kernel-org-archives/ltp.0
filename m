Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1235CEF8FEA
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:13:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C62153DC6D0
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:13:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 394DB3DC5C0
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:12:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3124600A4D
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:12:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB4963F8F6
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772633547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUpw2MDTper7TKItLFyFZH0O3wLIVG4zHbkTjtBrp4=;
 b=T4FL0ngx/ze2Cbg3temNszx4nupbg2rw1zX/heZG2j1CuzzAbmtwwKoGXtaeph3KAtWXYg
 iAnUjprKeGkbXzF5KtC07iTLtjML5MwQRtuPnrS037rrjY1CSKHuKFjNYVJiiv1y09/19b
 G0OCjQxxCQXQt4uRck97TBb/cfSnAqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772633547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUpw2MDTper7TKItLFyFZH0O3wLIVG4zHbkTjtBrp4=;
 b=BKCXqAmcvxsnP+nqhGZ/WL6pNdftxI1ulpCNuU8dX/cOxEAeXDn0bUnnPu4z3fZ5eV0KIi
 BiUK0F28ltfbPqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772633547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUpw2MDTper7TKItLFyFZH0O3wLIVG4zHbkTjtBrp4=;
 b=T4FL0ngx/ze2Cbg3temNszx4nupbg2rw1zX/heZG2j1CuzzAbmtwwKoGXtaeph3KAtWXYg
 iAnUjprKeGkbXzF5KtC07iTLtjML5MwQRtuPnrS037rrjY1CSKHuKFjNYVJiiv1y09/19b
 G0OCjQxxCQXQt4uRck97TBb/cfSnAqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772633547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUpw2MDTper7TKItLFyFZH0O3wLIVG4zHbkTjtBrp4=;
 b=BKCXqAmcvxsnP+nqhGZ/WL6pNdftxI1ulpCNuU8dX/cOxEAeXDn0bUnnPu4z3fZ5eV0KIi
 BiUK0F28ltfbPqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE7C23EA69
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 37qULcs9qGl6fwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 14:12:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 15:12:36 +0100
Message-ID: <20260304141236.9080-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304141236.9080-1-chrubis@suse.cz>
References: <20260304141236.9080-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls: sysinfo02: Convert to the new library
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
 testcases/kernel/syscalls/sysinfo/sysinfo02.c | 138 ++----------------
 1 file changed, 15 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo02.c b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
index 4ce06e0a7..5bbbdc35c 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo02.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
@@ -1,137 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
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
- * Test Name :	sysinfo02
- *
- * Test description
- *  Verify that sysinfo() returns the correct error for an invalid address structure.
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
- *  Pass an invalid address to the structure.
- *  Check return code, if system call failed (return=-1)
- *	Test case passed, Issue functionality pass message
- *  Otherwise,
- *	Issue Functionality-Fail message.
- * Cleanup:
- *  Print errno log and/or timing stats if options given
- *  Delete the temporary directory created.
- *
- * USAGE:  <for command-line>
- *	sysinfo02 [-c n] [-i n] [-I x] [-P x] [-t]
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
+ * Verify that sysinfo() returns EFAULT for an invalid address structure.
  */
 
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/signal.h>
 #include <sys/sysinfo.h>
-#include <stdint.h>
-
-#include "test.h"
-
-#define INVALID_ADDRESS ((uintptr_t)-1)
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+static struct sysinfo *bad_info;
 
-char *TCID = "sysinfo02";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	struct sysinfo *sysinfo_buf;
-	int lc;
-
-	sysinfo_buf = (void *)INVALID_ADDRESS;
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
-		TEST(sysinfo(sysinfo_buf));
-		/* check return code */
-		if (TEST_RETURN != 0 && TEST_ERRNO == EFAULT) {
-			/* Test succeeded as it was supposed to return -1 */
-			tst_resm(TPASS,
-				 "Test to check the error code %d PASSED",
-				 TEST_ERRNO);
-		} else {
-			/* Test Failed */
-			tst_brkm(TFAIL, cleanup, "sysinfo() Failed, Expected -1 "
-				 "returned %d/n", TEST_ERRNO);
-		}
-	}
-	cleanup();
-	tst_exit();
-
+	bad_info = tst_get_bad_addr(NULL);
 }
 
-/*
- * setup()
- *	performs one time setup
- *
- */
-void setup(void)
+static void run(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	umask(0);
-
-	TEST_PAUSE;
+	TST_EXP_FAIL(sysinfo(bad_info), EFAULT);
 }
 
-/*
- * cleanup()
- *
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
