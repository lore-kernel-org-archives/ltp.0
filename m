Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EF9C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 15:57:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E2AC3CD4D2
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 16:57:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1566A3CACA3
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 16:56:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43740600C7D
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 16:56:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35E311FD80
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678895813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eFsX11CpxPMoHG3JqV1Z6e3iZX6Bef1hP30J/18ktDU=;
 b=txOeA8zdAAGCHflJXc/qXKaOln2RTxIH+3Jau/Pn315aIOE6GMdS8fBjxdC2tPL0d1RWQr
 gQigc8wV7R6YlYvt0D7JMKarPzB9ZIywe2GY2tweYb3mNzsv9aApEJuQ2y3VZLILm4PMco
 FT9AQ/TdxjTzQviQZcTkvouP0kcB8B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678895813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eFsX11CpxPMoHG3JqV1Z6e3iZX6Bef1hP30J/18ktDU=;
 b=TYaKFqfwhBldfKpweiXh4Qo7wXz6pskKtfLg6JmYKKZfsckcn9jUDgHxj/1sTWmR2bQ4Qo
 nDwfARedsh3d83Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF78113A2F
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 15:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iG7GHMTqEWRUeQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 15:56:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 Mar 2023 21:26:50 +0530
Message-Id: <20230315155650.12469-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mknod02.c: Simplify and convert to new LTP API
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

Simply test when parent directory does not have set-group-ID bit set,
new node gets GID from effective GID of the process and does not inherit
the group ownership from its parent directory.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mknod/mknod02.c | 316 +++-------------------
 1 file changed, 36 insertions(+), 280 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index 594473e24..b1885fed1 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -1,301 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
+ *     07/2001 Ported by Wayne Boyer
+ *   Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Name: mknod02
- *
- * Test Description:
- *  Verify that mknod(2) succeeds when used to create a filesystem
- *  node with set group-ID bit set on a directory without set group-ID bit set.
- *  The node created should have set group-ID bit set and its gid should be
- *  equal to that of its parent directory.
- *
- * Expected Result:
- *  mknod() should return value 0 on success and node created should have
- *  set group-ID bit set, its gid should be equal to that of its parent
- *  directory.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  mknod02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  This test should be run by 'super-user' (root) only.
+/*\
+ * [Description]
  *
+ * Verify that if mknod(2) creates a filesystem node in a directory which
+ * does not have the set-group-ID bit set, new node will not inherit the
+ * group ownership from its parent directory and its group ID will be the
+ * effective group ID of the process.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-#define LTPUSER		"nobody"
-#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
-#define MODE_SGID       S_IFIFO | S_ISGID | S_IRWXU | S_IRWXG | S_IRWXO
-#define DIR_TEMP	"testdir_2"
-#define TNODE		"tnode_%d"
+#define MODE_DIR 0777
+#define MODE1	0010777
+#define MODE_SGID	02000
 
-struct stat buf;		/* struct. to hold stat(2) o/p contents */
-struct passwd *user1;		/* struct. to hold getpwnam(3) o/p contents */
+#define TEMP_DIR "testdir"
+#define TEMP_NODE "testnode"
 
-char *TCID = "mknod02";
-int TST_TOTAL = 1;
-char node_name[PATH_MAX];	/* buffer to hold node name created */
+static struct stat buf;
+static struct passwd *user_nobody;
+static gid_t gid_nobody;
 
-gid_t group1_gid, group2_gid, mygid;	/* user and process group id's */
-uid_t save_myuid, user1_uid;	/* user and process user id's */
-pid_t mypid;			/* process id */
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-	int fflag;
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
-		 *  Attempt to create a filesystem node with group-id bit set
-		 *  on a directory without group id bit set such that,
-		 *  the node created by mknod(2) should have group-id (sgid)
-		 *  bit set and node's gid should be equal to that of its
-		 *  parent directory.
-		 */
-		TEST(mknod(node_name, MODE_SGID, 0));
-
-		/* Check return code from mknod(2) */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "mknod(%s, %#o, 0)  failed, errno=%d : %s",
-				 node_name, MODE_SGID, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			continue;
-		}
-		/* Set the functionality flag */
-		fflag = 1;
-
-		/* Check for node's creation */
-		if (stat(node_name, &buf) < 0) {
-			tst_resm(TFAIL, "stat() of %s failed, errno:%d",
-				 node_name, TEST_ERRNO);
-
-			/* unset functionality flag */
-			fflag = 0;
-		}
-
-		/* Verify mode permissions of node */
-		if (!(buf.st_mode & S_ISGID)) {
-			tst_resm(TFAIL, "%s: Incorrect modes, setgid "
-				 "bit not set", node_name);
-			/* unset flag as functionality fails */
-			fflag = 0;
-		}
-
-		/* Verify group ID of node */
-		if (buf.st_gid != mygid) {
-			tst_resm(TFAIL, "%s: Incorrect group",
-				 node_name);
-			/* unset flag as functionality fails */
-			fflag = 0;
-		}
-		if (fflag) {
-			tst_resm(TPASS, "Functionality of mknod(%s, "
-				 "%#o, 0) successful",
-				 node_name, MODE_SGID);
-		}
-
-		/* Remove the node for the next go `round */
-		if (unlink(node_name) == -1) {
-			tst_resm(TWARN, "unlink(%s) failed, errno:%d %s",
-				 node_name, errno, strerror(errno));
-		}
-	}
+	user_nobody = SAFE_GETPWNAM("nobody");
+	gid_nobody = user_nobody->pw_gid;
 
-	/* Change the directory back to temporary directory */
-	SAFE_CHDIR(cleanup, "..");
-
-	/*
-	 * Invoke cleanup() to delete the test directories created
-	 * in the setup() and exit main().
-	 */
-	cleanup();
-
-	tst_exit();
+	SAFE_MKDIR(TEMP_DIR, MODE_DIR);
+	SAFE_CHOWN(TEMP_DIR, -1, gid_nobody);
 }
 
-/*
- * setup(void) - performs all ONE TIME setup for this test.
- *	Exit the test program on receipt of unexpected signals.
- *	Create a temporary directory used to hold test directories created
- *	and change the directory to it.
- *	Verify that pid of process executing the test is root.
- *	Create a test directory on temporary directory and set the ownership
- *	of test directory to ltp user and process.
- *	Set the effective uid/gid of the process to that of ltp user.
- */
-void setup(void)
+static void run(void)
 {
-	tst_require_root();
-
-	/* Capture unexpected signals */
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Make a temp dir and cd to it */
-	tst_tmpdir();
-
-	/* fix permissions on the tmpdir */
-	if (chmod(".", 0711) != 0) {
-		tst_brkm(TBROK, cleanup, "chmod() failed");
-	}
-
-	/* Save the real user id of the current test process */
-	save_myuid = getuid();
-
-	/* Save the process id of the current test process */
-	mypid = getpid();
-
-	/* Get the node name to be created in the test */
-	sprintf(node_name, TNODE, mypid);
-
-	/* Get the uid/gid of ltpuser */
-	if ((user1 = getpwnam(LTPUSER)) == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Couldn't determine if %s was in /etc/passwd",
-			 LTPUSER);
-	}
-	user1_uid = user1->pw_uid;
-	group1_gid = user1->pw_gid;
-
-	/* Get the effective group id of the test process */
-	group2_gid = getegid();
+	SAFE_CHDIR(TEMP_DIR);
+	TST_EXP_PASS(mknod(TEMP_NODE, MODE1, 0), "mknod(%s, %o, 0)", TEMP_NODE, MODE1);
 
-	/*
-	 * Create a test directory under temporary directory with the
-	 * specified mode permissions, with uid/gid set to that of guest
-	 * user and the test process.
-	 */
-	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
+	SAFE_STAT(TEMP_NODE, &buf);
+	TST_EXP_EQ_LI(buf.st_gid, 0);
 
-	/*
-	 * Verify that test directory created with expected permission modes
-	 * and ownerships.
-	 */
-	SAFE_STAT(cleanup, DIR_TEMP, &buf);
-
-	/* Verify modes of test directory */
-	if (buf.st_mode & S_ISGID) {
-		tst_brkm(TBROK, cleanup,
-			 "%s: Incorrect modes, setgid bit set", DIR_TEMP);
-	}
-
-	/* Verify group ID of test directory */
-	if (buf.st_gid != group2_gid) {
-		tst_brkm(TBROK, cleanup, "%s: Incorrect group", DIR_TEMP);
-	}
-
-	/*
-	 * Set the effective group id and user id of the test process
-	 * to that of guest user.
-	 */
-	SAFE_SETGID(cleanup, group1_gid);
-	if (setreuid(-1, user1_uid) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to set process uid to that of ltp user");
-	}
-
-	/* Save the real group ID of the current process */
-	mygid = getgid();
-
-	/* Change directory to DIR_TEMP */
-	SAFE_CHDIR(cleanup, DIR_TEMP);
+	SAFE_UNLINK(TEMP_NODE);
+	SAFE_CHDIR("..");
 }
 
-/*
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	Print test timing stats and errno log if test executed with options.
- *	Restore the real/effective user id of the process changed during
- *	setup().
- *	Remove temporary directory and sub-directories/files under it
- *	created during setup().
- *	Exit the test program with normal exit code.
- */
-void cleanup(void)
-{
-
-	/*
-	 * Restore the effective uid of the process changed in the
-	 * setup().
-	 */
-	if (setreuid(-1, save_myuid) < 0) {
-		tst_brkm(TBROK, NULL,
-			 "resetting process real/effective uid failed");
-	}
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1
+};
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
