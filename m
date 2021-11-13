Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F16C433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 09:30:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E20B93C8FDB
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 10:30:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A09AE3C7047
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 10:30:43 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C4271401634
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 10:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638437441; i=@fujitsu.com;
 bh=EfZaehL2AFyrYA2I3jZ1WclNPI20YNTgTDhHlAl0KNs=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ATm4ESw0B/YyHSiMlTqJ6vIYhL9S8yuA1iWH6h0xFY2YvzbchoA6/pN/rjbM/G6gp
 Z0TzLxm3E2PwaRITKWXFfMHCDORSxzva78um0+MDSXUlAkBoNLTzrO9BTd/ze6XnZX
 fU+PfgDKyeUkUBax5uyoCnokGLiaAmggYrdpSHYgxT3mptrWWdsSuwyh63spXVsJ0x
 Qltq3uO/0+82ycTOaR65LEu7dddN0Dno1qwkgEDqH0jM/x3KRg3LPOXZvFiyj2+6qh
 cXwtKCpBxPLsqDIGmJLMa3HTVDw23Gnt5IuA0TAJxZJn+Mg0GKjq62CDANpid8IEvS
 s2ssQ7u4RBFhA==
Received: from [100.115.34.229] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 38/29-02703-14298A16;
 Thu, 02 Dec 2021 09:30:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsViZ8MxSddh0op
 Eg5f3LCxWfN/B6MDose/3OtYAxijWzLyk/IoE1ox/OxezFiz2qvjy8jBTA+NDqy5GLg4hgbOM
 ErcWbmCFcHYySdzbOZUdwtnHKPFn2lkgh5ODTUBD4trjdmYQW0RAQqKj4S1YnFlATWL31WNsI
 LawgJnE9I0vwOIsAqoST2/+ZwGxeQXcJK5smgEWlxBQkJjy8D0zRFxQ4uTMJywQcyQkDr54wQ
 xRoyixf+9GRgi7QmLGjG1sELaaxNVzm5gnMPLPQtI+C0n7AkamVYzWSUWZ6RkluYmZObqGBga
 6hoamusamukYGJnqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIGBmVKsfGYH
 46dL3/QOMUpyMCmJ8iokrUgU4kvKT6nMSCzOiC8qzUktPsQow8GhJMH7bAJQTrAoNT21Ii0zB
 xglMGkJDh4lEd4rE4HSvMUFibnFmekQqVOMuhzvn8xdxCzEkpeflyolznsRZIYASFFGaR7cCF
 jEXmKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzGsMsoonM68EbtMroCOYgI44PGs5yBEliQg
 pqQamfpEgoZiE3PVWnex/UjhYSis3l0Rt1p+raLJl6/+kedGWmh/fh3De23FNXmXJ0eaZAl4N
 s0Larye6at9f/j9X42SRKe+O+5/nHngrkZj72D7w4qUmQftz8tfj33HaZV2/dvB/lwBzf7Uze
 9CsFyHuh9VmCAStnZFz0uakRMtWxz/CVkf+7p2Q/DxhmaD4krUTrhwQ5ZOSO7LspMzL7AiPTd
 my9r9bNM6sLO8X/qD05NnDb1cDCuvv3f9z+MD9NjfLlGSXjnuGRxSPiBx8flhwsozoy7ehgQv
 cv2203qW0WlFa0lFr05xEd0tB7xdz7/6WvHyw8uoFI4dp+m7LXteeMjricyfA3i5T5pSusXKQ
 EktxRqKhFnNRcSIA5IvJ8FMDAAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-7.tower-571.messagelabs.com!1638437440!102293!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24723 invoked from network); 2 Dec 2021 09:30:40 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 2 Dec 2021 09:30:40 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 77C4E10034F
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 09:30:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6AC421000FE
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 09:30:42 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 2 Dec 2021 09:30:34 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 12 Nov 2021 19:09:21 -0500
Message-ID: <1636762161-26777-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pwrite04: Convert to new API
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

1) use SAFE macro
2) remove useless write() operations
3) simplify pwrite() operations before using O_APPEND

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/pwrite/pwrite04.c | 307 ++++++----------------------
 1 file changed, 66 insertions(+), 241 deletions(-)

diff --git a/testcases/kernel/syscalls/pwrite/pwrite04.c b/testcases/kernel/syscalls/pwrite/pwrite04.c
index 4a2825b..2b5ab35 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite04.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite04.c
@@ -1,267 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
+ * Copyright (c) Linux Test Project, 2021
+ * Copyright (c) International Business Machines  Corp., 2002
+ * ported from SPIE, section2/filesuite/pread_pwrite.c, by Airong Zhang
  */
 
-/*
- * NAME
- *      pwrite04.c (ported from SPIE, section2/filesuite/pread_pwrite.c,
- *      	        by Airong Zhang)
+/*\
+ * [Description]
  *
- * TEST SUMMARY
- *	Test the pwrite() system call with O_APPEND.
+ * Test the pwrite() system call with O_APPEND.
  *
- * USAGE
- *  	pwrite04
+ * Writing 2k data to the file, close it and reopen it with O_APPEND.
  *
+ * POSIX requires that opening a file with the O_APPEND flag should have no effect on the
+ * location at which pwrite() writes data. However, on Linux, if a file is opened with
+ * O_APPEND, pwrite() appends data to the end of the file, regardless of the value of offset.
  */
 
-#define _XOPEN_SOURCE 500
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <memory.h>
-#include <errno.h>
-#include "test.h"
-
-char *TCID = "pwrite04";
-int TST_TOTAL = 1;
-int local_flag;
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_prw.h"
 
-#define PASSED 1
-#define FAILED 0
+#define K1              1024
+#define K2              (K1 * 2)
+#define K3              (K1 * 3)
+#define DATA_FILE       "pwrite04_file"
 
-int block_cnt = 0;
+static int fd = -1;
+static char *write_buf[2];
 
-#define K1    		1024
-#define K2    		(K1 * 2)
-#define K3    		(K1 * 3)
-#define K4    		(K1 * 4)
-#define K5    		(K1 * 5)
-#define	NBUFS 		4
-#define DATA_FILE	"pwrite04_file"
-
-char name[256], fname[256];
-
-void init_buffers(char *[]);
-void l_seek(int, off_t, int, off_t);
-static void cleanup(void);
-
-int main(int ac, char *av[])
+static void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
 {
-	int fd;
-	int nbytes;
-	char *wbuf[NBUFS];
-	struct stat statbuf;
-	int lc;
-
-	strcpy(name, DATA_FILE);
-	sprintf(fname, "%s.%d", name, getpid());
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	tst_tmpdir();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		init_buffers(wbuf);
-		local_flag = PASSED;
-
-		if ((fd = open(fname, O_RDWR | O_CREAT, 0666)) < 0) {
-			tst_resm(TBROK, "open failed: fname = %s, errno = %d",
-				 fname, errno);
-			cleanup();
-		}
-		/*
-		 * pwrite() K1 of data (0's) at offset 0.
-		 */
-		if ((nbytes = pwrite(fd, wbuf[0], K1, 0)) != K1) {
-			tst_resm(TFAIL,
-				 "pwrite at 0 failed: nbytes=%d, errno=%d",
-				 nbytes, errno);
-			cleanup();
-		}
-
-		/*
-		 * We should still be at offset 0.
-		 */
-		l_seek(fd, 0, SEEK_CUR, 0);
-
-		/*
-		 * lseek() to a non K boundary, just to be different.
-		 */
-		l_seek(fd, K1 / 2, SEEK_SET, K1 / 2);
-
-		/*
-		 * pwrite() K1 of data (2's) at offset K2.
-		 */
-		if ((nbytes = pwrite(fd, wbuf[2], K1, K2)) != K1) {
-			tst_resm(TFAIL,
-				 "pwrite at K2 failed: nbytes=%d, errno=%d",
-				 nbytes, errno);
-			cleanup();
-		}
-
-		/*
-		 * We should still be at our non K boundary.
-		 */
-		l_seek(fd, 0, SEEK_CUR, K1 / 2);
-
-		/*
-		 * lseek() to an offset of K3.
-		 */
-		l_seek(fd, K3, SEEK_SET, K3);
-
-		/*
-		 * This time use a normal write() of K1 of data (3's) which should
-		 * take place at an offset of K3, moving the file pointer to K4.
-		 */
-		if ((nbytes = write(fd, wbuf[3], K1)) != K1) {
-			tst_resm(TFAIL, "write failed: nbytes=%d, errno=%d",
-				 nbytes, errno);
-			cleanup();
-		}
-
-		/*
-		 * We should be at offset K4.
-		 */
-		l_seek(fd, 0, SEEK_CUR, K4);
-
-		/*
-		 * pwrite() K1 of data (1's) at offset K1.
-		 */
-		if ((nbytes = pwrite(fd, wbuf[1], K1, K1)) != K1) {
-			tst_resm(TFAIL, "pwrite failed: nbytes=%d, errno=%d",
-				 nbytes, errno);
-			cleanup();
-		}
-
-	/*--------------------------------------------------------------*/
-
-		/*
-		 * Now test that O_APPEND takes precedence over any
-		 * offset specified by pwrite(), but that the file
-		 * pointer remains unchanged.  First, close then reopen
-		 * the file and ensure it is already K4 in length and
-		 * set the file pointer to it's midpoint, K2.
-		 */
-		close(fd);
-		if ((fd = open(fname, O_RDWR | O_APPEND, 0666)) < 0) {
-			tst_resm(TBROK, "open failed: fname = %s, errno = %d",
-				 fname, errno);
-			cleanup();
-		}
-		if (fstat(fd, &statbuf) == -1) {
-			tst_resm(TFAIL, "fstat failed: errno = %d", errno);
-			cleanup();
-		}
-		if (statbuf.st_size != K4) {
-			tst_resm(TFAIL, "file size is %ld != K4",
-				 statbuf.st_size);
-			cleanup();
-		}
-		l_seek(fd, K2, SEEK_SET, K2);
-
-		/*
-		 * Finally, pwrite() some K1 of data at offset 0.
-		 * What we should end up with is:
-		 *      -The file pointer should still be at K2.
-		 *      -The data should have been written to the end
-		 *       of the file (O_APPEND) and should be K5 in size.
-		 */
-		if ((nbytes = pwrite(fd, wbuf[0], K1, 0)) != K1) {
-			tst_resm(TFAIL,
-				 "pwrite at 0 failed: nbytes=%d, errno=%d",
-				 nbytes, errno);
-
-		}
-		l_seek(fd, 0, SEEK_CUR, K2);
-		if (fstat(fd, &statbuf) == -1) {
-			tst_resm(TFAIL, "fstat failed: errno = %d", errno);
-
-		}
-		if (statbuf.st_size != K5) {
-			tst_resm(TFAIL, "file size is %ld != K4",
-				 statbuf.st_size);
-
-		}
-		tst_resm(TPASS, "O_APPEND test passed.");
-
-	/*------------------------------------------------------------------------*/
-
-		close(fd);
-		unlink(fname);
-	}			/* end for */
-	cleanup();
-	tst_exit();
+	off_t offloc;
 
+	offloc = SAFE_LSEEK(fdesc, offset, whence);
+	if (offloc != checkoff) {
+		tst_brk(TFAIL, "%ld = lseek(%d, %ld, %d) != %ld",
+			offloc, fdesc, offset, whence, checkoff);
+	}
 }
 
-/*------------------------------------------------------------------------*/
-
-/*
- * init_buffers() allocates wbuf[] array
- * as follows:
- * wbuf[0] has 0's, wbuf[1] has 1's, wbuf[2] has 2's, and wbuf[3] has 3's.
- */
-void init_buffers(char *wbuf[])
+static void verify_pwrite(void)
 {
-	int i;
+	struct stat statbuf;
 
-	for (i = 0; i < NBUFS; i++) {
-		wbuf[i] = malloc(K1);
-		if (wbuf[i] == NULL) {
-			tst_brkm(TBROK, NULL, "ib: malloc failed: errno=%d",
-				 errno);
-		}
-		memset(wbuf[i], i, K1);
-	}
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	SAFE_PWRITE(1, fd, write_buf[0], K2, 0);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND, 0666);
+	SAFE_FSTAT(fd, &statbuf);
+	if (statbuf.st_size != K2)
+		tst_res(TFAIL, "file size is %ld != K2", statbuf.st_size);
+
+	/* Appends data to the end of the file regardless of offset. */
+	l_seek(fd, K1, SEEK_SET, K1);
+	SAFE_PWRITE(1, fd, write_buf[1], K1, 0);
+	l_seek(fd, 0, SEEK_CUR, K1);
+	SAFE_FSTAT(fd, &statbuf);
+	if (statbuf.st_size != K3)
+		tst_res(TFAIL, "file size is %ld != K3", statbuf.st_size);
+
+	tst_res(TPASS, "O_APPEND test passed.");
+	SAFE_CLOSE(fd);
 }
 
-/*
- * l_seek() is a local front end to lseek().
- * "checkoff" is the offset at which we believe we should be at.
- * Used to validate pwrite doesn't move the offset.
- */
-void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
+static void setup(void)
 {
-	off_t offloc;
-
-	if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
-		tst_brkm(TFAIL, NULL,
-			 "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
-			 offloc, fdesc, offset, whence, checkoff, errno);
-	}
+	write_buf[0] = SAFE_MALLOC(K2);
+	memset(write_buf[0], 0, K2);
+	write_buf[1] = SAFE_MALLOC(K1);
+	memset(write_buf[0], 1, K1);
 }
 
-/*
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- *	Print test timing stats and errno log if test executed with options.
- *	Close the testfile if still opened.
- *	Remove temporary directory and sub-directories/files under it
- *	created during setup().
- *	Exit the test program with normal exit code.
- */
-void cleanup(void)
+static void cleanup(void)
 {
+	free(write_buf[0]);
+	free(write_buf[1]);
 
-	tst_rmdir();
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 
+	SAFE_UNLINK(DATA_FILE);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_pwrite,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
