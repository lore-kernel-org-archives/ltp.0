Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7FC6FA82
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 01:22:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455C13CAC20
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 03:22:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFCF23CAA04
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 03:22:06 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 30ADA602079
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 03:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1663204924; i=@fujitsu.com;
 bh=PN4+6iC5XZCufgBZR9cm/zzMVf9cabg87I4eH3nULXI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=k91+N3/lNw8m7jIwrS0jKzoCergbc9Q2Hw47BlGst/jDFU8S8bKoD+WY6tiz0H+sI
 j6EwYYR6kI38JQJefFSbCBbodKjuqp2BihcJr8nGabigD8xpzmK5D1Hkcd1jPmQWQ3
 kxCdP6BAPcKS6kZCJ24dmxLVHCuTorfwJOE0ot2JpO3mwDjSZEWED1pgg7h06bfNC9
 0Qa0DS44iJordwVEpA5CM0JCMeLSfXSyocYN5zquIwVU9hlN8DYMUt6e1NTNDPYD/e
 mNfzQKWv+PAadf3prfgUH1A9kVAz4F3aZjBo4VDCyaxOA4c0xLVNZ+P2CeLBYyGb5q
 4NJN95xXRNcqg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8MxSde6Tin
 Z4M4+PosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPlv0PMBZPtKuZOd25gPGDQxcjJISRwllGi
 /4ZNFyMXkH2ASeJI4wVGCGc7o8Sf59NYQarYBLQl7vTMYASxRQQkJDoa3rKD2MwCmhL3rhwGi
 wsLmEpMubCECcRmEVCV6H/yGqiXg4NXwEViQbMeSFhCQEFiysP3zCA2r4CgxMmZT1ggxkhIHH
 zxghmiRlHi6um9rBB2hUTj9ENMELaaxNVzm5gnMPLPQtI+C0n7AkamVYxWSUWZ6RkluYmZObq
 GBga6hoamuoa6RobmeolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpenmpJZsYgQGZUsx4
 cwdja99PvUOMkhxMSqK8THJKyUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeJMqgXKCRanpqRVpm
 TnA6IBJS3DwKInwslQDpXmLCxJzizPTIVKnGHU5ps7+t59ZiCUvPy9VSpx3Wg1QkQBIUUZpHt
 wIWKReYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMuwVkFU9mXgncpldARzABHWFkLQ9yREk
 iQkqqgWkiJ6/eCU0BjkNBflI+rXo7O9ecqdiQXSa+a3FPLduJdn/RduHaRe3Rc9S0ryw9vLn4
 7wIj187UoNjoykVW3fs37f0eZvVYe2no5WmZE6wq7b/9WX+moDRj++OoR35e9+89v3Rb5NIWo
 em3aioljz+5pRm09Vb39kSmL1eFGFJ28JbUXrrtK3vfItX5SKffhTangqpg7ioTkdyzMyfsq+
 NRCwreE/pI9/y0iVs2il8UrTouohU4tzF5O+N2p7LQhiXv3DY87O9mEIlR+ugbcLjjH5tSQ5v
 rxSV95m/PFdrKvpld4bB4Xcckw4X9jOHu1xqfpb7cFvhQ/czF7ukSWzsv6sxI4l/4KVc1h+GG
 hxJLcUaioRZzUXEiAHT9j4BPAwAA
X-Env-Sender: liaohj.jy@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1663204923!48579!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3314 invoked from network); 15 Sep 2022 01:22:03 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Sep 2022 01:22:03 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id CECD71000CC
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 02:22:02 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id C0E7D100078
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 02:22:02 +0100 (BST)
Received: from rhel-server--7.5 (10.167.215.42) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 15 Sep 2022 02:22:01 +0100
From: Liao Huangjie <liaohj.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 15 Sep 2022 09:21:42 +0800
Message-ID: <1663204902-4185-1-git-send-email-liaohj.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.42]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fork01:Convert into new api
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

From: Huangjie Liao <liaohj.jy@fujitsu.com>

Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
---
 testcases/kernel/syscalls/fork/fork01.c | 253 ++++++------------------
 1 file changed, 55 insertions(+), 198 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork01.c b/testcases/kernel/syscalls/fork/fork01.c
index 00d7c45c4..8ba712805 100644
--- a/testcases/kernel/syscalls/fork/fork01.c
+++ b/testcases/kernel/syscalls/fork/fork01.c
@@ -1,91 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Author: Kathy Olmsted
+ * Co-Pilot: Steve Shaw
+ */
+
+/*\
+ *[Description]
  *
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
- *
- *    OS Test - Silicon Graphics, Inc.
- *    TEST IDENTIFIER	: fork01
- *    EXECUTED BY	: anyone
- *    TEST TITLE	: Basic test for fork(2)
- *    PARENT DOCUMENT	: frktds02
- *    TEST CASE TOTAL	: 2
- *    WALL CLOCK TIME	: 1
- *    CPU TYPES		: ALL
- *    AUTHOR		: Kathy Olmsted
- *    CO-PILOT		: Steve Shaw
- *    DATE STARTED	: 06/17/92
- *    INITIAL RELEASE	: UNICOS 7.0
- *    TEST CASES
- *	1.) fork returns without error
- *	2.) fork returns the pid of the child
- *    INPUT SPECIFICATIONS
- *	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *    OUTPUT SPECIFICATIONS
- *    DURATION
- *	Terminates - with frequency and infinite modes.
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *    RESOURCES
- *	None
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *    SPECIAL PROCEDURAL REQUIREMENTS
- *	None
- *    INTERCASE DEPENDENCIES
- *	None
- *    DETAILED DESCRIPTION
- *	Setup:
- *	Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	Test:
- *	 Loop if the proper options are given.
- *        fork()
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *        CHILD:
- *           determine PID
- *           write to PID to a file and close the file
- *           exit
- *        PARENT:
- *           wait for child to exit
- *           read child PID from file
- *           compare child PID to fork() return code and report
- *           results
- *
- *	  Cleanup:
- *           Print errno log and/or timing stats if options given
+ * This case tests fork()'s basic function.
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
@@ -93,142 +19,73 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "test.h"
+#include <unistd.h>
+#include <stdio.h>
+#include "tst_test.h"
 
 #define	KIDEXIT	42
-static void setup();
-static void cleanup();
-
 #define LINE_SZ	20
 #define FILENAME "childpid"
 
-char *TCID = "fork01";
-int TST_TOTAL = 2;
+static char buf[LINE_SZ];
 
-/*
- * child_pid - the child side of the test
- *             determine the PID and write to a file
- */
-static void child_pid(void)
+static void do_child(void)
 {
+	int fd;
 
-	int fildes;
-	char tmp_line[LINE_SZ];
-
-	fildes = creat(FILENAME, 0700);
-	sprintf(tmp_line, "%d\n", getpid());
-	write(fildes, tmp_line, LINE_SZ);
-	close(fildes);
-
+	fd = creat(FILENAME, 0700);
+	sprintf(buf, "%d\n", getpid());
+	SAFE_WRITE(1, fd, buf, LINE_SZ);
+	SAFE_CLOSE(fd);
 }
 
-/*
- * parent_pid - the parent side of the test
- *              read the value determined by the child
- *              compare and report results
- */
-static void parent_pid(void)
+static void check_child_pid(int pid)
 {
+	int fd;
+	pid_t child_pid;
 
-	int fildes;
-	char tmp_line[LINE_SZ];
-	pid_t child_id;
+	fd = SAFE_OPEN(FILENAME, O_RDWR);
+	SAFE_READ(1, fd, buf, LINE_SZ);
 
-	fildes = open(FILENAME, O_RDWR);
-	if (fildes == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "parent open failed. errno: %d (%s)\n",
-			 errno, strerror(errno));
+	child_pid = atoi(buf);
+	if (child_pid != pid) {
+		tst_res(TFAIL, "child reported a pid of %d. parent received %d from fork()",
+				child_pid, pid);
 	} else {
-		if (read(fildes, tmp_line, LINE_SZ) == 0) {
-			tst_brkm(TBROK, cleanup,
-				 "fork(): parent failed to read PID from file errno: %d (%s)",
-				 errno, strerror(errno));
-		} else {
-			child_id = atoi(tmp_line);
-			if (TEST_RETURN != child_id) {
-				tst_resm(TFAIL,
-					 "child reported a pid of %d. parent received %ld from fork()",
-					 child_id, TEST_RETURN);
-			} else {
-				tst_resm(TPASS,
-					 "child pid and fork() return agree: %d",
-					 child_id);
-			}
-		}
-		close(fildes);
-	}
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	int fails;
-	int kid_status, wait_status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		fails = 0;
-
-		TEST(fork());
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			tst_resm(TBROK, "unable to continue");
-		}
-		if (TEST_RETURN == 0) {
-			/* child */
-			child_pid();
-			exit(KIDEXIT);
-		} else {
-			/* parent */
-			tst_resm(TPASS, "fork() returned %ld",
-				 TEST_RETURN);
-			/* wait for the child to complete */
-			wait_status = waitpid(TEST_RETURN, &kid_status, 0);
-
-			if (wait_status == TEST_RETURN) {
-				if (kid_status != KIDEXIT << 8) {
-					tst_resm(TBROK,
-						 "incorrect child status returned on wait(): %d",
-						 kid_status);
-					fails++;
-				}
-			} else {
-				tst_resm(TBROK,
-					 "wait() for child status failed with %d errno: %d : %s",
-					 wait_status, errno,
-					 strerror(errno));
-				fails++;
-			}
-			if (fails == 0) {
-				/* verification tests */
-				parent_pid();
-			}
-		}		/* TEST_RETURN */
+		tst_res(TPASS, "child pid and fork() return agree: %d", pid);
 	}
 
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd);
 }
 
-static void setup(void)
+static void verify_fork(void)
 {
+	int kid_status, term_pid, pid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
+	pid = SAFE_FORK();
+	if (!pid) {
+		do_child();
+		exit(KIDEXIT);
+	}
 
-static void cleanup(void)
-{
+	term_pid = SAFE_WAITPID(pid, &kid_status, 0);
+	if (term_pid == pid) {
+		if (kid_status != KIDEXIT << 8)
+			tst_res(TFAIL, "incorrect child status returned %d", kid_status);
+		else
+			tst_res(TPASS, "correct child status returned %d", kid_status);
 
-	tst_rmdir();
+		check_child_pid(pid);
+	} else {
+		tst_res(TFAIL, "waitpid() returns %d instead of  expected pid %d", term_pid, pid);
+	}
 
+	tst_reap_children();
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.test_all = verify_fork,
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
