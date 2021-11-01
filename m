Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53FC433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 08:30:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBA160F0F
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 08:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBBA160F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96E513C70B9
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 09:30:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA8C93C7002
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 09:30:26 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A861F140143F
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 09:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635755423; i=@fujitsu.com;
 bh=otwYL/9nTc7hoBJqwQ/hWKxV+Sg8gmA3EikNFX5Rl7M=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 b=WZrO0j+BRvW9YIv/xex/QJWzsIztsoRXnfYiLB2dqctGsWpQmTTSX8NhFSoJUWuJj
 N9uPzs9+k5HPKQKuvUo45ysFojANa6gJ4FkUFPHweBNVpCD0CLe/TAmt5EM0ghoZdL
 pU+E37uK46RMd2ufkzpxrCxY+UqDYMTqfBvz3HjlRyGfJhMRf/MyaewHcKsHJnWIu3
 KCx6P7l/o+rVndS0Ww8kAOYRSPTTQ3ZSCcXyYIogAsP/zksmR1XO8m864eksF4GaIx
 JZ5A/xxohAL8gdZVuqaTnO9oXVJ7IPF3P8nPQtJO1lW9jsArVnY1lHh+Jltw20oz5w
 Zwzab8qC2WC/A==
Received: from [100.113.5.34] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id F0/E6-01506-F95AF716;
 Mon, 01 Nov 2021 08:30:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRWlGSWpSXmKPExsViZ8MxSXfu0vp
 Eg9bXchYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bb38EFs5sYK14/mc/YwLg5rYuRi0NI4Cyj
 xOm2zexdjJxAzk4mif+/2SES+xglLmx6AZZgE9CQuPa4nRnEFhGQkOhoeAsWZxZQk9h99Rgbi
 C0sECJx8Os+sDiLgIrEopPLgWwODl4BV4mfd/RBwhICChJTHr4HG8MrIChxcuYTFogxmhKt23
 9DjZSXaN46mxmiXlFi/96NjBB2hcSMGdvYIGw1iavnNjFPYBSYhWTULCSjZiEZtYCReRWjZVJ
 RZnpGSW5iZo6uoYGBrqGhsa6JrqGxgV5ilW6SXmqpbnJqXklRIlBWL7G8WK+4Mjc5J0UvL7Vk
 EyMwgFMKWZp2MP5+9UHvEKMkB5OSKG/7ovpEIb6k/JTKjMTijPii0pzU4kOMMhwcShK89guBc
 oJFqempFWmZOcBogklLcPAoifBeWQyU5i0uSMwtzkyHSJ1i1OXYeXTeImYhlrz8vFQpcd6vS4
 CKBECKMkrz4EbAIvsSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHe1yBX8mTmlcBtegV0BBP
 QEfvEakCOKElESEk1MNV8CL7DxTxz1ySj/EnMc6/n1C5MvVd7JPdl13G51E0lTL7bbx+0jHTj
 clOY9DvSWvxUynHd37+qmvZkGrcaTpfm82p799Dp94saGyUlv/gZ93w/hrh+2fAteB6zlObBv
 jdL8v/NN11l83U9wyRVBp5b0ewWVpyx31/Giy9eN7lqkmD7tP0bxLkf8yRqzDo38Yye7EmVnU
 eP2X4/raGUkXRCZM6TpJOGD8tnu7glsnEEP0nrFklQny7iPvXF3GCZDWLT84059xR6+7NpH4h
 I7sqf82Jx58r7E7b0dc57X1UnvKq/dOn3p5bsj9KW3HvTLsz1NCaj+nxH7hHtvqm/9+wrs97O
 1md41zJ1SrB1uhJLcUaioRZzUXEiAAXl6ttnAwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-11.tower-245.messagelabs.com!1635755421!228762!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2606 invoked from network); 1 Nov 2021 08:30:21 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 1 Nov 2021 08:30:21 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id CAA9110046D
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 08:30:20 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id BD36F10045A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 08:30:20 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Mon, 1 Nov 2021 08:29:56 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 1 Nov 2021 04:29:46 -0400
Message-ID: <1635755386-4012-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pread02: Convert to new API and merge
 pread03 into pread02
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
Content-Type: multipart/mixed; boundary="===============1175898160=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1175898160==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

1) merge pread03 into pread02
2) use TST_EXP_FAIL2 macro

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 runtest/syscalls                           |   2 -
 testcases/kernel/syscalls/pread/.gitignore |   2 -
 testcases/kernel/syscalls/pread/pread02.c  | 307 +++++------------------------
 testcases/kernel/syscalls/pread/pread03.c  | 214 --------------------
 4 files changed, 53 insertions(+), 472 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/pread/pread03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b193168..c37412d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -996,8 +996,6 @@ pread01 pread01
 pread01_64 pread01_64
 pread02 pread02
 pread02_64 pread02_64
-pread03 pread03
-pread03_64 pread03_64
 
 preadv01 preadv01
 preadv01_64 preadv01_64
diff --git a/testcases/kernel/syscalls/pread/.gitignore b/testcases/kernel/syscalls/pread/.gitignore
index d1cd839..99bdf99 100644
--- a/testcases/kernel/syscalls/pread/.gitignore
+++ b/testcases/kernel/syscalls/pread/.gitignore
@@ -2,5 +2,3 @@
 /pread01_64
 /pread02
 /pread02_64
-/pread03
-/pread03_64
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index aa194f6..54c1a4a 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -1,295 +1,94 @@
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
+ * 07/2001 Ported by Wayne Boyer
  */
 
-/*
- * Test Name: pread02
- *
- * Test Description:
- *  Verify that,
- *   1) pread() fails when attempted to read from an unnamed pipe.
- *   2) pread() fails if the specified offset position was invalid.
- *
- * Expected Result:
- *  1) pread() should return -1 and set errno to ESPIPE.
- *  2) pread() should return -1 and set errno to EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create a temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
+/*\
+ * [Description]
  *
- * Usage:  <for command-line>
- *  pread02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Tests basic error handling of the pread syscall.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
+ * - ESPIPE when attempted to read from an unnamed pipe
+ * - EINVAL if the specified offset position was invalid
+ * - EISDIR when fd refers to a directory
  */
 
-#define _XOPEN_SOURCE 500
-
-#include <errno.h>
-#include <unistd.h>
 #include <fcntl.h>
+#include <stdlib.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define TEMPFILE	"pread_file"
+#define PREAD_TEMPFILE  "pread_file"
+#define PREAD_TEMPDIR	"pread_dir"
 #define K1              1024
 #define NBUFS           4
 
-char *TCID = "pread02";
-int TST_TOTAL = 2;
-
-char *write_buf[NBUFS];		/* buffer to hold data to be written */
-char *read_buf[NBUFS];		/* buffer to hold data read from file */
-int pfd[2];			/* pair of file descriptors */
-int fd1;
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-int setup1();			/* setup function for test #1 */
-int setup2();			/* setup function for test #2 */
-int no_setup();
-void init_buffers();		/* function to initialize/allocate buffers */
+char *write_buf[NBUFS];
+char *read_buf[NBUFS];
+static int pfd[2];
+static int fd[2];
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int fd;
+struct test_case_t {
+	int *fd;
 	size_t nb;
 	off_t offst;
 	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	1, K1, 0, "file descriptor is a PIPE or FIFO", ESPIPE, setup1}, {
-	2, K1, -1, "specified offset is -ve or invalid", EINVAL, setup2}, {
-	0, 0, 0, NULL, 0, no_setup}
+} tcases[] = {
+	{&pfd[0], K1, 0, "file descriptor is a PIPE or FIFO", ESPIPE},
+	{&fd[0], K1, -1, "specified offset is -ve or invalid", EINVAL},
+	{&fd[1], K1, 0, "file descriptor is a directory", EISDIR}
 };
 
-int main(int ac, char **av)
+static void verify_pread(unsigned int n)
 {
-	int lc;
-	int i;
-	int fildes;		/* file descriptor of test file */
-	size_t nbytes;		/* no. of bytes to be written */
-	off_t offset;		/* offset position in the specified file */
-	char *test_desc;	/* test specific error message */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	struct test_case_t *tc = &tcases[n];
 
-		/* loop through the test cases */
-		for (i = 0; Test_cases[i].desc != NULL; i++) {
-			fildes = Test_cases[i].fd;
-			test_desc = Test_cases[i].desc;
-			nbytes = Test_cases[i].nb;
-			offset = Test_cases[i].offst;
-
-			if (fildes == 1) {
-				fildes = pfd[0];
-			} else if (fildes == 2) {
-				fildes = fd1;
-			}
-
-			/*
-			 * Call pread() with the specified file descriptor,
-			 * no. of bytes to be read from specified offset.
-			 * and verify that call should fail with appropriate
-			 * errno set.
-			 */
-			TEST(pread(fildes, read_buf[0], nbytes, offset));
-
-			/* Check for the return code of pread() */
-			if (TEST_RETURN != -1) {
-				tst_brkm(TFAIL, cleanup, "pread() returned "
-					 "%ld, expected -1, errno:%d",
-					 TEST_RETURN, Test_cases[i].exp_errno);
-			}
-
-			/*
-			 * Verify whether expected errno is set.
-			 */
-			if (TEST_ERRNO == Test_cases[i].exp_errno) {
-				tst_resm(TPASS, "pread() fails, %s, errno:%d",
-					 test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "pread() fails, %s, unexpected "
-					 "errno:%d, expected:%d", test_desc,
-					 TEST_ERRNO, Test_cases[i].exp_errno);
-			}
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL2(pread(*tc->fd, read_buf[0], tc->nb, tc->offst), tc->exp_errno,
+		"pread(%d, %zu, %ld, %s, %d)", *tc->fd, tc->nb, tc->offst, tc->desc, tc->exp_errno);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *           Initialize/allocate write buffer.
- *           Call individual setup function.
- */
 void setup(void)
 {
-	int i;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Allocate/Initialize the read/write buffer with known data */
-	init_buffers();
-
-	/* Call individual setup functions */
-	for (i = 0; Test_cases[i].desc != NULL; i++) {
-		Test_cases[i].setupfunc();
-	}
-}
-
-/*
- * no_setup() - This function simply returns.
- */
-int no_setup(void)
-{
-	return 0;
-}
-
-/*
- * setup1() - setup function for a test condition for which pread()
- *            returns -ve value and sets errno to ESPIPE.
- *
- *  Create an unnamed pipe using pipe().
- *  Write some known data to the write end of the pipe.
- *  return 0.
- */
-int setup1(void)
-{
-	/* Create a pair of unnamed pipe */
-	SAFE_PIPE(cleanup, pfd);
-
-	/* Write known data (0's) of K1 bytes */
-	if (write(pfd[1], write_buf[0], K1) != K1) {
-		tst_brkm(TBROK, cleanup, "write to pipe failed: errno=%d : %s",
-			 errno, strerror(errno));
-	}
-
-	return 0;
-}
-
-/*
- * setup2 - setup function for a test condition for which pread()
- *          returns -ve value and sets errno to EINVAL.
- *
- *  Create a temporary directory and a file under it.
- *  return 0.
- */
-int setup2(void)
-{
-
-	tst_tmpdir();
+	int count;
 
-	/* Creat a temporary file used for mapping */
-	if ((fd1 = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
+	for (count = 0; count < NBUFS; count++) {
+		write_buf[count] = SAFE_MALLOC(K1);
+		read_buf[count] = SAFE_MALLOC(K1);
+		memset(write_buf[count], count, K1);
 	}
 
-	return 0;
-}
-
-/*
- * init_buffers() - allocate/Initialize write_buf array.
- *
- *  Allocate read/write buffer.
- *  Fill the write buffer with the following data like,
- *    write_buf[0] has 0's, write_buf[1] has 1's, write_buf[2] has 2's
- *    write_buf[3] has 3's.
- */
-void init_buffers(void)
-{
-	int count;		/* counter variable for loop */
+	SAFE_PIPE(pfd);
+	SAFE_WRITE(1, pfd[1], write_buf[0], K1);
 
-	/* Allocate and Initialize write buffer with known data */
-	for (count = 0; count < NBUFS; count++) {
-		write_buf[count] = malloc(K1);
-		read_buf[count] = malloc(K1);
+	fd[0] = SAFE_OPEN(PREAD_TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-		if ((write_buf[count] == NULL) || (read_buf[count] == NULL)) {
-			tst_brkm(TBROK, NULL,
-				 "malloc() failed on read/write buffers");
-		}
-		memset(write_buf[count], count, K1);
-	}
+	SAFE_MKDIR(PREAD_TEMPDIR, 0777);
+	fd[1] = SAFE_OPEN(PREAD_TEMPDIR, O_RDONLY);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- *  Deallocate the memory allocated to read/write buffers.
- *  Close the temporary file.
- *  Remove the temporary directory created.
- */
-void cleanup(void)
+static void cleanup(void)
 {
 	int count;
+	int i;
 
-	/* Free the memory allocated for the read/write buffer */
 	for (count = 0; count < NBUFS; count++) {
 		free(write_buf[count]);
 		free(read_buf[count]);
 	}
 
-	/* Close the temporary file created in setup2 */
-	SAFE_CLOSE(NULL, fd1);
-
-	tst_rmdir();
-
+	for (i = 0; i < 2; i++) {
+		if (pfd[i] > 0)
+			SAFE_CLOSE(pfd[i]);
+		if (fd[i] > 0)
+			SAFE_CLOSE(fd[i]);
+	}
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_pread,
+};
diff --git a/testcases/kernel/syscalls/pread/pread03.c b/testcases/kernel/syscalls/pread/pread03.c
deleted file mode 100644
index 51819e7..0000000
--- a/testcases/kernel/syscalls/pread/pread03.c
+++ /dev/null
@@ -1,214 +0,0 @@
-/*
- *
- *   Copyright (C) Bull S.A. 2001
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
- * Test Name: pread03
- *
- * Test Description:
- *  Verify that,
- *   1) pread() fails when fd refers to a directory.
- *
- *
- * Expected Result:
- *   1) pread() should return -1 and set errno to EISDIR.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *   Create a temporary directory.
- *   Get the currect directory name
- *   Open temporary directory
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *      if errno set == expected errno
- *              Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *              Issue sys call fails with unexpected errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  pread03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	04/2002 Ported by André Merlier
- *
- * RESTRICTIONS:
- *  None.
- */
-
-#define _XOPEN_SOURCE 500
-
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <sys/file.h>
-
-#include "test.h"
-
-#define PREAD_TEMPDIR	"test"
-#define K1              2048
-#define NBUFS           1
-
-char *TCID = "pread03";
-int TST_TOTAL = 1;
-
-char *read_buf[NBUFS];		/* buffer to hold data read from file */
-int fd1;
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void init_buffers();		/* function to initialize/allocate buffers */
-
-int main(int ac, char **av)
-{
-	int lc;
-	size_t nbytes;		/* no. of bytes to be written */
-	off_t offset;		/* offset position in the specified file */
-	char *test_desc;	/* test specific error message */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* Check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		test_desc = "EISDIR";
-		nbytes = K1;
-		offset = 20;
-
-		TEST(pread(fd1, read_buf[0], nbytes, offset));
-
-		/* Check for the return code of pread() */
-		if (TEST_RETURN != -1) {
-			tst_brkm(TFAIL, cleanup, "pread() returned "
-				 "%ld, expected -1, errno:%d\n",
-				 TEST_RETURN, EISDIR);
-		}
-
-		/*
-		 * Verify whether expected errno is set.
-		 */
-		if (TEST_ERRNO == EISDIR) {
-			tst_resm(TPASS,
-				 "pread() fails with expected error EISDIR errno:%d",
-				 TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "pread() fails, %s, unexpected "
-				 "errno:%d, expected:%d\n", test_desc,
-				 TEST_ERRNO, EISDIR);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- *           create temporary directory and open it
- */
-void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Allocate the read buffer */
-	init_buffers();
-
-	tst_tmpdir();
-
-	/*
-	 * create a temporary directory
-	 */
-	if (mkdir(PREAD_TEMPDIR, 0777) != 0) {
-		tst_resm(TFAIL, "mkdir() failed to create" " test directory");
-		exit(1);
-
-	}
-
-	/* open temporary directory used for test */
-	if ((fd1 = open(PREAD_TEMPDIR, O_RDONLY)) < 0) {
-		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
-			 PREAD_TEMPDIR, errno, strerror(errno));
-	}
-}
-
-/*
- * init_buffers() - allocate/Initialize write_buf array.
- *
- *  Allocate read buffer.
- */
-void init_buffers(void)
-{
-	int count;		/* counter variable for loop */
-
-	/* Allocate and Initialize read buffer */
-	for (count = 0; count < NBUFS; count++) {
-		read_buf[count] = malloc(K1);
-
-		if (read_buf[count] == NULL) {
-			tst_brkm(TBROK, NULL,
-				 "malloc() failed on read buffers");
-		}
-	}
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- *  Close/Remove the temporary directory created.
- */
-void cleanup(void)
-{
-	int count;
-
-	/* Free the memory allocated for the read buffer */
-	for (count = 0; count < NBUFS; count++) {
-		free(read_buf[count]);
-	}
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-
-}
-- 
1.8.3.1


--===============1175898160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1175898160==--
