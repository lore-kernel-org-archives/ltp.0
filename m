Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F45C43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 09:13:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBD443CA936
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 11:13:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1012B3CA92C
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 11:12:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2D0A6002F9
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 11:12:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5DD01FA58
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 09:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657789964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IiIGh7XtX/EgvKgLeeuD9FzEcBNrDskk2ihNXTw3rzY=;
 b=ZhiD+FltWuIDvaQXGsvBx6q0yYo8BzWgZ9Pv63nRdveaqE3zKKXgVV7zmRu38mUB6yak04
 Il3NaiYhmdUYwKvnUmUFViQy9Ftq2ZZD7ZTo/ndQruZpCANdZIBrEW/llq9SE8lqapJ5b8
 iB+5VbJhvCG/bnwDpeGkBfguzguyKro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657789964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IiIGh7XtX/EgvKgLeeuD9FzEcBNrDskk2ihNXTw3rzY=;
 b=BrItcLyYG+3P1fhhSixUNpWHEUHuRCayUOhP/5IcnmCd3smR8EtAvQTugRwnObBqDkfVOT
 /OoH7xInvzgVTzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A44713A61
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 09:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BCplBgzez2LAIwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 09:12:44 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Jul 2022 14:42:41 +0530
Message-Id: <20220714091241.26524-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Remove open05.c
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

Remove open05.c as same testcase for EACCES is covered in open08.c

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/open/.gitignore |   1 -
 testcases/kernel/syscalls/open/open05.c   | 140 ----------------------
 3 files changed, 142 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/open/open05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3847e8af2..9d58e0aa1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -909,7 +909,6 @@ open01A symlink01 -T open01
 open02 open02
 open03 open03
 open04 open04
-open05 open05
 open06 open06
 open07 open07
 open08 open08
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index 4309e3a72..001d874d6 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -2,7 +2,6 @@
 /open02
 /open03
 /open04
-/open05
 /open06
 /open07
 /open08
diff --git a/testcases/kernel/syscalls/open/open05.c b/testcases/kernel/syscalls/open/open05.c
deleted file mode 100644
index f5098be2d..000000000
--- a/testcases/kernel/syscalls/open/open05.c
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
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
- */
-
-/*
- * DESCRIPTION
- *	Testcase to check open(2) sets errno to EACCES correctly.
- *
- * ALGORITHM
- *	Create a file owned by root with no read permission for other users.
- *	Attempt to open it as ltpuser(1). The attempt should fail with EACCES.
- * RESTRICTION
- *	Must run test as root.
- */
-#include <errno.h>
-#include <pwd.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "open05";
-int TST_TOTAL = 1;
-
-static char fname[20];
-static int fd;
-
-static uid_t nobody_uid;
-
-static void cleanup(void);
-static void setup(void);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int e_code, status, retval = 0;
-	pid_t pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		pid = FORK_OR_VFORK();
-		if (pid == -1)
-			tst_brkm(TBROK, cleanup, "fork() failed");
-
-		if (pid == 0) {
-			if (seteuid(nobody_uid) == -1) {
-				tst_resm(TWARN, "seteuid() failed, errno: %d",
-					 errno);
-			}
-
-			TEST(open(fname, O_RDWR));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "open succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO != EACCES) {
-				retval = 1;
-				tst_resm(TFAIL, "Expected EACCES got %d",
-					 TEST_ERRNO);
-			} else {
-				tst_resm(TPASS, "open returned expected "
-					 "EACCES error");
-			}
-
-			/* set the id back to root */
-			if (seteuid(0) == -1)
-				tst_resm(TWARN, "seteuid(0) failed");
-
-			exit(retval);
-
-		} else {
-			/* wait for the child to finish */
-			wait(&status);
-			/* make sure the child returned a good exit status */
-			e_code = status >> 8;
-			if ((e_code != 0) || (retval != 0))
-				tst_resm(TFAIL, "Failures reported above");
-
-			close(fd);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	struct passwd *pw;
-
-	tst_require_root();
-
-	pw = SAFE_GETPWNAM(NULL, "nobody");
-	nobody_uid = pw->pw_uid;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-
-	sprintf(fname, "file.%d", getpid());
-
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-}
-
-static void cleanup(void)
-{
-	unlink(fname);
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-}
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
