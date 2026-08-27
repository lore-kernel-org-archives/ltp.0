Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C495C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:23:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E2E73CD693
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:23:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0209C3C0E10
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:22:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C9C61A001E0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:22:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 834FC1F841;
 Thu, 27 Aug 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGzMfptUH5a4WMNOuA3uuq6cZYDQZBYaIBhPvB2U/jw=;
 b=vBr6oFF+UjTgNfavZdT9dTUqCVbDfUwsFs4mMRLwTZC00XnOCDIjxMK6X8pvH3qOhC4zRr
 EcYPlMGlgNqkZpkpNlaw6ICfCvuQ2YW0MUkobje1d1gmFr5ZFGPN3moMKsSd1GK30Xn1ZO
 MtoCumQcDQnsQORrmuM98V31P8qP7SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGzMfptUH5a4WMNOuA3uuq6cZYDQZBYaIBhPvB2U/jw=;
 b=WYLJqtxt4wLjk2Uk1PWv8GZwnlNovquTXjnM+cKtIbLX1ROI3l9UP992VyMXjAtrUImND0
 ZWdGVaR/NSSP+zCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1wMEVNLL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4SbVk6PV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGzMfptUH5a4WMNOuA3uuq6cZYDQZBYaIBhPvB2U/jw=;
 b=1wMEVNLLsUXD49/qJMTB4Fk9fVAwVUwfb9pPOJIv3OsRYDxLaggI7bmG1nR3XlShXEdkjL
 pELqMWJd7J1BmWiZsVOIAx82kBuNExI51Hv2mQdBmxeMLguiX+NFHR6YKOO8A+cnaUtUgk
 fwHscay1MhD/2uIyYz/4AOMNp5+NGCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGzMfptUH5a4WMNOuA3uuq6cZYDQZBYaIBhPvB2U/jw=;
 b=4SbVk6PVg0IJlkjtDShTw9oExLsSB/r3ta3fWA3jPC52iXKS2rU0cDSe9+k2sXmVU5OEld
 du3m22qHg9zG8rBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F441352D;
 Thu, 27 Aug 2026 08:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8LKfF8rzj2oQNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 08:22:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 10:22:33 +0200
MIME-Version: 1.0
Message-Id: <20260827-convert_fallocate_suite-v5-1-650ab2acdac1@suse.com>
References: <20260827-convert_fallocate_suite-v5-0-650ab2acdac1@suse.com>
In-Reply-To: <20260827-convert_fallocate_suite-v5-0-650ab2acdac1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787818954; l=12662;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gge87CXNj14iMXKogTb1E3dUf7bfXA3OcihdZ8jMh44=;
 b=CGNrZZARgUNI4I8vn4K57RI/5GmY5aqR6dmGrc4bFsy+gHDg+xYgwH50zCuGPv0H/EZ+ujlfy
 9GOkTr+YeU0Byz7anVwrrLB1QudjODYP07eNcBMVFYerbaTFaWx5tYo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 834FC1F841
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] fallocate01: Convert to new API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Convert the fallocate01 test case from the legacy LTP API (test.h) to the
new tst_test API using a table-driven struct tcase[] and TST_EXP_* macros.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/fallocate/fallocate01.c | 344 +++++++---------------
 1 file changed, 101 insertions(+), 243 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index d21936eba..97c3ee3e4 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -1,274 +1,132 @@
-/******************************************************************************
- *				 fallocate01.c
- *	Mon Dec 24 2007
- *	Copyright (c) International Business Machines  Corp., 2007
- *	Emali : sharyathi@in.ibm.com
- ******************************************************************************/
-
-/***************************************************************************
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-***************************************************************************/
-
-/*****************************************************************************
- *
- *	OS Test - International Business Machines Corp. 2007.
- *
- *	TEST IDENTIFIER	: fallocate01
- *
- *	EXECUTED BY		: anyone
- *
- *	TEST TITLE		: Basic test for fallocate()
- *
- *	TEST CASE TOTAL	: 2
- *
- *	CPU ARCHITECTURES	: PPC,X86, X86_64
- *
- *	AUTHOR			: Sharyathi Nagesh
- *
- *	CO-PILOT			:
- *
- *	DATE STARTED		: 24/12/2007
- *
- *	TEST CASES
- *	(Working of fallocate under 2 modes)
- *	 1) DEFAULT 2)FALLOC_FL_KEEP_SIZE
- *
- *	INPUT SPECIFICATIONS
- *		No input needs to be specified
- *		  fallocate() in puts are generated randomly
- *
- *	OUTPUT SPECIFICATIONS
- *		Output describing whether test cases passed or failed.
- *
- *	ENVIRONMENTAL NEEDS
- *		Test Needs to be executed on file system supporting ext4
- *   LTP {TMP} Needs to be set to such a folder
- *
- *	SPECIAL PROCEDURAL REQUIREMENTS
- *		None
- *
- *	DETAILED DESCRIPTION
- *		This is a test case for fallocate() system call.
- *		This test suite tests basic working of fallocate under different modes
- *		It trys to fallocate memory blocks and write into that block
- *
- *		Total 2 Test Cases :-
- *		(1) Test Case for DEFAULT MODE
- *		(2) Test Case for FALLOC_FL_KEEP_SIZE
- *
- *	Setup:
- *		Setup file on which fallocate is to be called
- *		Set up 2 files for each mode
- *
- *	Test:
- *		Loop if the proper options are given.
- *		Execute system call
- *		Check return code, if system call did fail
- *		lseek to some random location with in allocate block
- *		write data into the locattion Report if any error encountered
- *		PASS the test otherwise
- *
- *	Cleanup:
- *		Cleanup the temporary folder
- *
-*************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Author: Sharyathi Nagesh <sharyathi@in.ibm.com>
+ * Copyright (c) Linux Test Project, 2008-2024
+ */
+
+/*\
+ * Basic test for :manpage:`fallocate(2)` covering the two preallocation
+ * modes and their effect on the file size.
+ *
+ * A file is pre-populated to 12 blocks and a single extra block is
+ * preallocated past the end of the file. The test verifies that the
+ * resulting file size matches the mode semantics and that the newly
+ * allocated region is writable.
+ *
+ * [Algorithm]
+ *
+ * - Populate the working file with 12 blocks of block_size bytes.
+ * - Preallocate one block at the end of the file.
+ * - In DEFAULT_MODE the file grows to 13 blocks.
+ * - In FALLOC_FL_KEEP_SIZE mode the file size stays at 12 blocks.
+ * - Seek into the newly allocated region and write a byte to it.
+ */
 
 #define _GNU_SOURCE
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <endian.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/syscall.h>
-#include <unistd.h>
-#include <inttypes.h>
-#include <sys/utsname.h>
-
-#include "test.h"
-#include "tso_safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fallocate.h"
-#include "lapi/fcntl.h"
 
+#define MNTPOINT "mntpoint"
+#define FNAME MNTPOINT "/tfile"
 #define BLOCKS_WRITTEN 12
 
-void get_blocksize(int);
-void populate_files(int fd);
-void runtest(int, int, loff_t);
-
-char *TCID = "fallocate01";
-char fname_mode1[255], fname_mode2[255];	/* Files used for testing */
-int fd_mode1, fd_mode2;
-int TST_TOTAL = 2;
-loff_t block_size;
-int buf_size;
-
-/******************************************************************************
- * Performs all one time clean up for this test on successful
- * completion,  premature exit or  failure. Closes all temporary
- * files, removes all temporary directories exits the test with
- * appropriate return code by calling tst_exit() function.
-******************************************************************************/
-void cleanup(void)
-{
+static int fd = -1;
+static int block_size;
 
-	if (close(fd_mode1) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fname_mode1);
-	if (close(fd_mode2) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fname_mode2);
-	tst_rmdir();
-}
+static struct tcase {
+	int mode;
+	int expected_blocks;
+	const char *desc;
+} tcases[] = {
+	{0, BLOCKS_WRITTEN + 1, "DEFAULT_MODE"},
+	{FALLOC_FL_KEEP_SIZE, BLOCKS_WRITTEN, "FALLOC_FL_KEEP_SIZE"},
+};
 
-/*****************************************************************************
- * Performs all one time setup for this test. This function is
- * used to create temporary dirs and temporary files
- * that may be used in the course of this test
- ******************************************************************************/
-void setup(void)
+static void populate_file(void)
 {
-	/* Create temporary directories */
-	TEST_PAUSE;
+	char buf[block_size];
 
-	tst_tmpdir();
+	for (int blocks = 0; blocks < BLOCKS_WRITTEN; blocks++) {
+		for (int i = 0; i < block_size; i++)
+			buf[i] = 'A' + (i % 26);
 
-	sprintf(fname_mode1, "tfile_mode1_%d", getpid());
-	fd_mode1 = SAFE_OPEN(cleanup, fname_mode1, O_RDWR | O_CREAT, 0700);
-	get_blocksize(fd_mode1);
-	populate_files(fd_mode1);
-
-	sprintf(fname_mode2, "tfile_mode2_%d", getpid());
-	fd_mode2 = SAFE_OPEN(cleanup, fname_mode2, O_RDWR | O_CREAT, 0700);
-	populate_files(fd_mode2);
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, block_size);
+	}
 }
 
-/*****************************************************************************
- * Gets the block size for the file system
- ******************************************************************************/
-void get_blocksize(int fd)
+static void setup(void)
 {
 	struct stat file_stat;
 
-	if (fstat(fd, &file_stat) < 0)
-		tst_resm(TFAIL | TERRNO,
-			 "fstat failed while getting block_size");
-
-	block_size = file_stat.st_blksize;
-	buf_size = block_size;
-}
-
-/*****************************************************************************
- * Writes data into the file
- ******************************************************************************/
+	TEST(fallocate(-1, 0, 0, 0));
+	if (TST_ERR == ENOSYS)
+		tst_brk(TCONF, "fallocate() not supported");
 
-void populate_files(int fd)
-{
-	char buf[buf_size + 1];
-	int index;
-	int blocks;
-	int data;
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0700);
 
-	for (blocks = 0; blocks < BLOCKS_WRITTEN; blocks++) {
-		for (index = 0; index < buf_size; index++)
-			buf[index] = 'A' + (index % 26);
-		buf[buf_size] = '\0';
-		if ((data = write(fd, buf, buf_size)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
-	}
+	SAFE_FSTAT(fd, &file_stat);
+	block_size = (int)file_stat.st_blksize;
 }
 
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
-	loff_t expected_size;
-	int lc;
+	struct tcase *tc = &tcases[n];
+	struct stat file_stat;
+	loff_t offset, len, pos, write_offset, expected_size;
+
+	/* Reset the backing file to a pristine 12-block state per run. */
+	SAFE_FTRUNCATE(fd, 0);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	populate_file();
+
+	offset = SAFE_LSEEK(fd, 0, SEEK_END);
+	len = block_size;
+	expected_size = (loff_t)tc->expected_blocks * block_size;
+
+	TEST(fallocate(fd, tc->mode, offset, len));
+	if (TST_RET != 0) {
+		if (TST_ERR == EOPNOTSUPP) {
+			tst_res(TCONF | TTERRNO,
+				"fallocate(%s, %lld, %lld) not supported",
+				tc->desc, (long long)offset, (long long)len);
+			return;
+		}
 
-	tst_parse_opts(ac, av, NULL, NULL);
+		tst_res(TFAIL | TTERRNO,
+			"fallocate(%s, %lld, %lld) failed",
+			tc->desc, (long long)offset, (long long)len);
+		return;
+	}
 
-	setup();
+	tst_res(TPASS, "fallocate(%s, %lld, %lld) passed",
+		tc->desc, (long long)offset, (long long)len);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	SAFE_FSTAT(fd, &file_stat);
+	TST_EXP_EQ_LI(file_stat.st_size, expected_size);
 
-		expected_size = BLOCKS_WRITTEN * block_size + block_size;
-		runtest(0, fd_mode1, expected_size);
+	write_offset = len / 2;
+	pos = SAFE_LSEEK(fd, write_offset, SEEK_CUR);
+	TST_EXP_EQ_LI(pos, offset + write_offset);
 
-		expected_size = BLOCKS_WRITTEN * block_size;
-		runtest(FALLOC_FL_KEEP_SIZE, fd_mode2, expected_size);
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_POSITIVE(write(fd, "A", 1),
+			 "write into the newly allocated region");
 }
 
-/*****************************************************************************
- * Calls the system call, with appropriate parameters and writes data
- ******************************************************************************/
-void runtest(int mode, int fd, loff_t expected_size)
+static void cleanup(void)
 {
-	loff_t offset;
-	loff_t len = block_size;
-	loff_t write_offset, lseek_offset;
-	offset = lseek(fd, 0, SEEK_END);
-	struct stat file_stat;
-	errno = 0;
-
-	TEST(fallocate(fd, mode, offset, len));
-	/* check return code */
-	if (TEST_RETURN != 0) {
-		if (TEST_ERRNO == EOPNOTSUPP || TEST_ERRNO == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fallocate system call is not implemented");
-		}
-		tst_resm(TFAIL | TTERRNO,
-			 "fallocate(%d, %d, %" PRId64 ", %" PRId64 ") failed",
-			 fd, mode, offset, len);
-		return;
-	} else {
-		tst_resm(TPASS,
-			 "fallocate(%d, %d, %" PRId64 ", %" PRId64
-			 ") returned %ld", fd, mode, offset, len,
-			 TEST_RETURN);
-	}
-
-	if (fstat(fd, &file_stat) < 0)
-		tst_resm(TFAIL | TERRNO, "fstat failed after fallocate()");
-
-	if (file_stat.st_size != expected_size)
-		tst_resm(TFAIL | TERRNO,
-			 "fstat test fails on fallocate (%d, %d, %" PRId64 ", %"
-			 PRId64 ") Failed on mode", fd, mode, offset, len);
-
-	write_offset = random() % len;
-	lseek_offset = lseek(fd, write_offset, SEEK_CUR);
-	if (lseek_offset != offset + write_offset) {
-		tst_resm(TFAIL | TERRNO,
-			 "lseek fails in fallocate(%d, %d, %" PRId64 ", %"
-			 PRId64 ") failed on mode", fd, mode, offset, len);
-		return;
-	}
-	//Write a character to file at random location
-	TEST(write(fd, "A", 1));
-	/* check return code */
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO,
-			 "write fails in fallocate(%d, %d, %" PRId64 ", %"
-			 PRId64 ") failed", fd, mode, offset, len);
-	} else {
-		tst_resm(TPASS,
-			 "write operation on fallocated(%d, %d, %"
-			 PRId64 ", %" PRId64 ") returned %ld", fd, mode,
-			 offset, len, TEST_RETURN);
-	}
+	if (fd != -1)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
