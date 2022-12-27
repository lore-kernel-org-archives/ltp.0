Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBAEC10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 05:33:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEA303CB831
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 06:33:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3A853CB80A
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 06:32:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D0BE6005D0
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 06:32:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52B0621AA5
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 05:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1672119170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/a4ico6sn74saFg1WSlhCfyIhjwYCLUGmc1Y22Bt/9w=;
 b=kXjBgm21+p/3/GbcnENbWXUiVmwaqHuCVC3O04ne0GZBqA2LdFK3NbFv3r5mQxQHn3rzbU
 /QP9hJJztpo90yWPIMiblkXpaFB/+jtu7s4YUSl4KEocHsFbMay5EXs0MjXbjoPjN5UFih
 cZBen4oaUvsxpNYUJ7qp3oUudyBfra0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1672119170;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/a4ico6sn74saFg1WSlhCfyIhjwYCLUGmc1Y22Bt/9w=;
 b=hzQGp61earVHxcnlfHEkOEmxCRk+QwwjhLMQXVEU/8cl2nNZKa+MFTTGZzQWwuZf+9Mdmr
 MM4OmWQ9sn1OyuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4052138F2
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 05:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0FC8IIGDqmOjPwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 05:32:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 27 Dec 2022 11:02:47 +0530
Message-Id: <20221227053247.1855-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setreuid01.c: remove the test
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

Test scenarios in setreuid01.c is covered in setreuid03.c with
better approach, hence remove it [1]

[1] https://lore.kernel.org/ltp/Y6Vsgkx%2FVcY%2F78vs@pevik/

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/setreuid/.gitignore |   2 -
 .../kernel/syscalls/setreuid/setreuid01.c     | 176 ------------------
 2 files changed, 178 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/setreuid/setreuid01.c

diff --git a/testcases/kernel/syscalls/setreuid/.gitignore b/testcases/kernel/syscalls/setreuid/.gitignore
index 52690606c..b67a23fbc 100644
--- a/testcases/kernel/syscalls/setreuid/.gitignore
+++ b/testcases/kernel/syscalls/setreuid/.gitignore
@@ -1,5 +1,3 @@
-/setreuid01
-/setreuid01_16
 /setreuid02
 /setreuid02_16
 /setreuid03
diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
deleted file mode 100644
index 54ba2d7a8..000000000
--- a/testcases/kernel/syscalls/setreuid/setreuid01.c
+++ /dev/null
@@ -1,176 +0,0 @@
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
- * Author: William Roske
- * Co-pilot: Dave Fenner
- */
-
-/*
- * Testcase to test the basic functionality of setreuid(2) system call.
- */
-
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-static void setup(void);
-static void cleanup(void);
-
-TCID_DEFINE(setreuid01);
-int TST_TOTAL = 5;
-
-static uid_t ruid, euid;	/* real and effective user ids */
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
-		 * TEST CASE:
-		 *  Don't change either real or effective uid
-		 */
-		ruid = getuid();	/* get real uid */
-		UID16_CHECK(ruid, setreuid, cleanup);
-
-		euid = geteuid();	/* get effective uid */
-		UID16_CHECK(euid, setreuid, cleanup);
-
-		TEST(SETREUID(cleanup, -1, -1));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setreuid -  Don't change either real or effective uid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setreuid -  Don't change either real or effective uid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  change effective to effective uid
-		 */
-
-		TEST(SETREUID(cleanup, -1, euid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setreuid -  change effective to effective uid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setreuid -  change effective to effective uid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  change real to real uid
-		 */
-
-		TEST(SETREUID(cleanup, ruid, -1));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setreuid -  change real to real uid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setreuid -  change real to real uid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  change effective to real uid
-		 */
-
-		TEST(SETREUID(cleanup, -1, ruid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setreuid -  change effective to real uid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setreuid -  change effective to real uid returned %ld",
-				 TEST_RETURN);
-		}
-
-		/*
-		 * TEST CASE:
-		 *  try to change real to current real
-		 */
-
-		TEST(SETREUID(cleanup, ruid, ruid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setreuid -  try to change real to current real failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setreuid -  try to change real to current real returned %ld",
-				 TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
