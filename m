Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC53C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:04:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 637A33C986F
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 13:04:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EC903C87EF
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BBAE51A01122
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 288EB221CF
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657191809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmRE93Z9rZN1nl1Rp+oTe6IFLVGv86rxr6L1q6RZabM=;
 b=0m11GgPcP2OBfKiFu0PgjkM5P0zrIzfrl58Tv8ubShd9GQrhFy4gi7i2oh6Yw4eLasvOXf
 QNW9Z+VCsOd91ixOcFTVrFd3+c40iTTJ3kncfC9A6RERetWgtWQ0CyJPhhLyPjnOORWMs9
 p1FqipmSgA8tw9eFO5LvRhelP6AwaRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657191809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmRE93Z9rZN1nl1Rp+oTe6IFLVGv86rxr6L1q6RZabM=;
 b=p/WGHOS8Rl5mAcwcazj+vIWci562+JTmqlGxSk1WioCJ30gTyY8NCuwK4V8AdBr2zQiy02
 XhSOcpuODz4knGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D8B813A33
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gibFF4C9xmJPRwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 07 Jul 2022 11:03:28 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 16:33:12 +0530
Message-Id: <20220707110319.24665-3-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707110319.24665-1-akumar@suse.de>
References: <20220707110319.24665-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/9] Remove rename02.c
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

rename02.c is redundant as same testcase is covered in rename01.c

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/rename/.gitignore |   1 -
 testcases/kernel/syscalls/rename/rename02.c | 192 --------------------
 3 files changed, 194 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rename/rename02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 88c31db06..8139c37d6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1132,7 +1132,6 @@ removexattr02 removexattr02
 
 rename01 rename01
 rename01A symlink01 -T rename01
-rename02 rename02
 rename03 rename03
 rename04 rename04
 rename05 rename05
diff --git a/testcases/kernel/syscalls/rename/.gitignore b/testcases/kernel/syscalls/rename/.gitignore
index 6c10aeabd..f95cf7d21 100644
--- a/testcases/kernel/syscalls/rename/.gitignore
+++ b/testcases/kernel/syscalls/rename/.gitignore
@@ -1,5 +1,4 @@
 /rename01
-/rename02
 /rename03
 /rename04
 /rename05
diff --git a/testcases/kernel/syscalls/rename/rename02.c b/testcases/kernel/syscalls/rename/rename02.c
deleted file mode 100644
index 51c278faa..000000000
--- a/testcases/kernel/syscalls/rename/rename02.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/* $Id: rename02.c,v 1.8 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: rename02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for rename(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) rename(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the rename(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	rename(2).
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "rename02";
-int TST_TOTAL = 1;
-
-int fd;
-char fname[255], mname[255];
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call rename(2)
-		 */
-		TEST(rename(fname, mname));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "rename(%s, %s) Failed, errno=%d : %s",
-				 fname, mname, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "rename(%s, %s) returned %ld",
-				 fname, mname, TEST_RETURN);
-			if (unlink(mname) == -1) {
-				tst_resm(TWARN,
-					 "unlink(%s) Failed, errno=%d : %s",
-					 mname, errno, strerror(errno));
-			}
-			SAFE_TOUCH(cleanup, fname, 0700, NULL);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "./tfile_%d", getpid());
-	sprintf(mname, "./rnfile_%d", getpid());
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-}
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
