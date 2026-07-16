Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282FAC44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 09:44:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD5643E735A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 11:44:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B6993E1CD6
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 11:43:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50EEB1A0036B
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 11:43:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED2EC788C0;
 Thu, 16 Jul 2026 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784195034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GZETH2NMm5xDqf0/BbY0T/vVLv/PtQiUy30/apPvFkA=;
 b=rOfFnFZfBLyhOCkETfwDNmLuat8ReZ/oeOIojphBSIbBZlfdvUsP0TutcReqrZqe81XHp5
 j9v8hOihjEoqFAk/9RoF/1K/WDr1oXN2Pq/o6AWm4Bqw5S41f39jgnmExT07jNEa23gUqS
 QGaEU+Hvwo5TW38xd62PYG1Cco1mjZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784195034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GZETH2NMm5xDqf0/BbY0T/vVLv/PtQiUy30/apPvFkA=;
 b=SB8tcdAMI5xb0oWCLeAtAKiWwnPOLVxeKTC37pkerfrqOzQWKN8I2Qlk3jH66K6KhvDUny
 jCL0MLzEklXRVsCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NBz0XJbl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=12eV5PK+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784195033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GZETH2NMm5xDqf0/BbY0T/vVLv/PtQiUy30/apPvFkA=;
 b=NBz0XJbldYR26EC4xGwMKM38geZqDH+qYewTKMHJ8xcgw7AjkkfATQdX2bWGwnwRCwDQnC
 oRRJx5ZmMMqoClfn9aFkMVJADdlV+bjNWWlR4SWmAgaDO+B3pLDCRorOX3W2Gp7AZPAY6v
 TC23T9/ZPVgM9PGiwMYc4BdD8DdupiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784195033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GZETH2NMm5xDqf0/BbY0T/vVLv/PtQiUy30/apPvFkA=;
 b=12eV5PK+BHwEYp4WNJOKs7Pd+vWc8QEGKKAHTMtBdr3fMApaF6tbOO3PSGAyTG5EehYOO6
 8Hbb9td7jr2G6aCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF655779AD;
 Thu, 16 Jul 2026 09:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mqTHJ9mnWGoMJQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Jul 2026 09:43:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jul 2026 11:43:52 +0200
MIME-Version: 1.0
Message-Id: <20260716-rewrite_inode_testing_suite-v1-1-b6fee6f0d0ba@suse.com>
X-B4-Tracking: v=1; b=H4sIANinWGoC/x3MQQqDMBBG4avIrA1oDKntVaQEMX/tbGKZiVUQ7
 25w+b3FO0ghDKVXdZDgz8pLKmjriqbvmGYYjsVkG+ubR+uNYBPOCJyWiJChmdMcdC3NRNdNzvr
 e9e5J5fATfHi/78P7PC//km2ZbQAAAA==
X-Change-ID: 20260716-rewrite_inode_testing_suite-d43c42684849
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784195033; l=52093;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=7E4MnGpnVPVdQ6nQQBipmIKuqgdcSOg226gMBi3gC14=;
 b=wuf8VlDPuKKrekqclpaN8LKQsethkmW/d/Dp0oqZjjGfde/BjyAL+ItIOAvr5CqrNyTHwyO4q
 2UECRzbBybPCGQV3s2c3dM7v4n6Pj6UHoNv7iiOxvCo5FWUe0BwBPgu
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED2EC788C0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inode: convert to new API and merge into a single test
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

The inode01 and inode02 tests shared the same directory/file tree engine
and differed only in tree dimensions and in whether the workload ran in
a single process or across several parallel workers.

inode01 now covers both scenarios, so inode02 is removed together with
its entries in runtest/fs, runtest/fs_readonly and the .gitignore. Note
this drops inode02 as a test id; its runtest/fs_readonly slot is left as
a gap so unrelated test_robind entries keep their numbers.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/fs                           |   1 -
 runtest/fs_readonly                  |   1 -
 testcases/kernel/fs/inode/.gitignore |   1 -
 testcases/kernel/fs/inode/inode01.c  | 864 +++++----------------------------
 testcases/kernel/fs/inode/inode02.c  | 902 -----------------------------------
 5 files changed, 124 insertions(+), 1645 deletions(-)

diff --git a/runtest/fs b/runtest/fs
index 1d753e0ddfdc0eee077a937cb6901a02a9e4aa48..3d0137ee738972000299fd1213a342ea9bacdcf7 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -43,7 +43,6 @@ fs_inod01 fs_inod $TMPDIR 10 10 10
 linker01 linktest.sh
 openfile01 openfile -f10 -t10
 inode01 inode01
-inode02 inode02
 stream01 stream01
 stream02 stream02
 stream03 stream03
diff --git a/runtest/fs_readonly b/runtest/fs_readonly
index dc70d28d8ad3b99d18dac022650b4e455fe0b954..c29c7e55177de59839cd8145aac32307d3c0ae01 100644
--- a/runtest/fs_readonly
+++ b/runtest/fs_readonly
@@ -37,7 +37,6 @@ test_robind36 test_robind.sh -c "rwtest -N iogen01 -i 120s -s read,write -Da -Dv
 test_robind37 test_robind.sh -c "fs_inod . 10 10 1"
 test_robind38 test_robind.sh -c "openfile -f10 -t10"
 test_robind39 test_robind.sh -c "inode01"
-test_robind40 test_robind.sh -c "inode02"
 test_robind41 test_robind.sh -c "stream01"
 test_robind42 test_robind.sh -c "stream02"
 test_robind43 test_robind.sh -c "stream03"
diff --git a/testcases/kernel/fs/inode/.gitignore b/testcases/kernel/fs/inode/.gitignore
index 92d90357aff879c5611b65d36182ead624d91496..13f7f27fa97d19652e3f05d79306682b83eb2db2 100644
--- a/testcases/kernel/fs/inode/.gitignore
+++ b/testcases/kernel/fs/inode/.gitignore
@@ -1,2 +1 @@
 /inode01
-/inode02
diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index a7387e8686ea3bdb369197b900424cdced88c4b5..94ccb6f49585dee6c0c660247a6960ab8b23946f 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -1,779 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines Corp., 2002
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Exercise filesystem metadata and buffered I/O by building mixed trees of
+ * directories and regular files, writing each file's pathname repeatedly,
+ * then traversing the tree again to verify every object's type, size and
+ * contents.
  *
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
+ * Two scenarios are run:
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * - a single process building one small tree, and
+ * - several workers building independent larger trees in parallel to add
+ *   concurrent load, started simultaneously through a checkpoint.
  */
 
-/* 10/31/2002	Port to LTP	robbiew@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-
-			   /* inode1.c */
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
-CALLS:	mkdir, stat, open
-
-	run using TERM mode
-
->KEYS:  < file system management I/O
->WHAT:  < Do the system's file system management and I/O functions work
-	< correctly?
->HOW:   < Construct a directory tree, create files in it, and verify
-	< that this was done as expected.
->BUGS:  <
-======================================================================*/
-/* modified by dale 25-Jul-84 */
-
-/************************************************/
-#define PATH_STRING_LENGTH  100
-#define NAME_LENGTH  8
-#define MAX_PATH_STRING_LENGTH  (PATH_STRING_LENGTH - NAME_LENGTH)
-#define MAX_DEPTH   3
-#define MAX_BREADTH 3
-#define FILE_LENGTH 100
-#define DIRECTORY_MODE  00777
-#define FILE_MODE       00777
-
-/* #define PRINT 		 define to get list while running */
-
-#define TRUE  1
-#define FALSE 0
-#define READ  0
-#define WRITE 1
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <errno.h>
-
-/** LTP Port **/
-#include "test.h"
-
-void blexit(void);
-void blenter(void);
-void setup(void);
-void fail_exit(void);
-void anyfail(void);
-void ok_exit(void);
-
-#define FAILED 0
-#define PASSED 1
-
-int local_flag = PASSED;
-int block_number;
-FILE *temp;
-
-char *TCID = "inode01";		/* Test program identifier.    */
-int TST_TOTAL = 2;		/* Total number of test cases. */
-/**************/
-
-#ifdef LINUX
-#include <string.h>
-#endif
-
-char name[NAME_LENGTH + 1];
-char path_string[PATH_STRING_LENGTH + 1];
-char read_string[PATH_STRING_LENGTH + 1];
-char write_string[PATH_STRING_LENGTH + 1];
-char rm_string[200];
-
-FILE *list_stream = NULL;
-int file_id;
-int list_id;
-
-int increment_name(), get_next_name(), mode(), escrivez();
-
-int main(void)
+#include "tst_test.h"
+
+static struct tcase {
+	unsigned int depth;
+	unsigned int fanout;
+	unsigned int repetitions;
+	unsigned int workers;
+	const char *desc;
+} tcases[] = {
+	{3, 4, 100, 1, "single-process small tree"},
+	{6, 6, 8, 5, "parallel larger trees"},
+};
+
+static void create_tree(const struct tcase *tc, const char *parent,
+			unsigned int level, unsigned int *id)
 {
-	char root[16];		//as pids can get much longer
-	int gen_ret_val, ch_ret_val, level;
-	int ret_val;
-	int generate(), check();
-	char path_list_string[PATH_STRING_LENGTH + 1];
-	int status;
-	int len;
-	int term();
-	int snp_ret;
-
-	strcpy(path_string, "inode");
-	sprintf(root, "A%d", getpid());
-	strcat(path_string, root);
-
-	strcpy(rm_string, "rm -rf ");
-	strcat(rm_string, path_string);
-
-	setup();
-
-	if (signal(SIGTERM, (void (*)())term) == SIG_ERR) {
-		fprintf(temp, "\tSIGTERM signal set failed!, errno=%d\n",
-			errno);
-		fail_exit();
-	}
-
-	blenter();
-
-	/********************************/
-	/*                              */
-	/*  make the root directory for */
-	/*  the tree                    */
-	/*                              */
-	/********************************/
-
-	ret_val = mkdir(path_string, DIRECTORY_MODE);
-
-	if (ret_val == -1) {
-		perror("mkdir error");
-		fprintf(temp, "\tcreating directory '%s'\n", path_string);
-		fprintf(temp, "\t\n%s Impossible to create directory %s\n",
-			root, path_string);
-		fail_exit();
-	}
-#ifdef PRINT
-	printf("\n%s\n", path_string);
-#endif
-
-	/****************************************/
-	/*                                      */
-	/*  create the "path_list" file, in     */
-	/*  which the list of generated paths   */
-	/*  will be stored so that they later   */
-	/*  may be checked                      */
-	/*                                      */
-	/****************************************/
-
-	snp_ret = snprintf(path_list_string, sizeof(path_list_string),
-		"%s/path_list",	path_string);
-	if (snp_ret < 0 || snp_ret >= sizeof(path_list_string)) {
-		tst_resm(TBROK, "snprintf(path_list_string,..) returned %d",
-			snp_ret);
-		fail_exit();
-	}
-	list_id = creat(path_list_string, FILE_MODE);
-	if (list_id == -1) {
-		fprintf(temp,
-			"\t\n%s The path_list file cannot be created, errno=%d \n",
-			root, errno);
-		fail_exit();
-	}
-
-	/****************************************/
-	/*                                      */
-	/*   and store its name in path_list    */
-	/*                                      */
-	/****************************************/
-
-	strcpy(write_string, path_string);
-	len = strlen(write_string);
-	write_string[len++] = 'D';
-	write_string[len] = '\0';
-	escrivez(write_string);
-
-	/****************************************/
-	/*                                      */
-	/*   generate the directory-file tree   */
-	/*                                      */
-	/****************************************/
+	unsigned int i;
+	int create_file = level & 1;
 
-	level = 0;
+	if (level >= tc->depth)
+		return;
 
-#ifdef PRINT
-	printf("\n\t%s\n\n", "GENERATING:");
-#endif
+	for (i = 0; i < tc->fanout; i++, create_file = !create_file) {
+		char path[PATH_MAX];
 
-	gen_ret_val = generate(path_string, level);
+		snprintf(path, sizeof(path), "%s/%08u", parent, ++*id);
+		if (create_file) {
+			int fd = SAFE_OPEN(path, O_WRONLY | O_CREAT | O_TRUNC, 0777);
+			unsigned int j;
 
-	if (gen_ret_val) {
-		fprintf(temp,
-			"Failure occured in generate routine, return value %d\n",
-			gen_ret_val);
-		local_flag = FAILED;
-	}
-
-	blexit();
-	blenter();
-
-	close(list_id);
-	list_id = open(path_list_string, READ);
-	if (list_id == -1) {
-		fprintf(temp,
-			"\t\n%s The path_list file cannot be opened for reading, errno=%d\n",
-			root, errno);
-		fail_exit();
-	}
-	list_stream = fdopen(list_id, "r");
-
-	/****************************************/
-	/*                                      */
-	/*   check the directory-file tree      */
-	/*      for correctness                 */
-	/*                                      */
-	/****************************************/
-
-#ifdef PRINT
-	printf("\n\t%s\n\n", "CHECKING:");
-#endif
-
-	ch_ret_val = check();
-
-	if (ch_ret_val) {
-		fprintf(temp,
-			"Failure occured in check routine, return value %d\n",
-			ch_ret_val);
-		local_flag = FAILED;
-	}
-
-	status = fclose(list_stream);
-	if (status != 0) {
-		fprintf(temp,
-			"Failed to close list_stream: ret=%d errno=%d (%s)\n",
-			status, errno, strerror(errno));
-		local_flag = FAILED;
-	}
-
-	blexit();
-
-	/*
-	 * Now fork and exec a system call to remove the directory.
-	 */
-
-#ifdef DEBUG
-	fprintf(temp, "\nClean up:\trm string = %s\n", rm_string);
-#endif
-	fflush(stdout);
-	fflush(temp);
-
-	status = system(rm_string);
-
-	if (status) {
-		fprintf(temp, "Caution-``%s'' may have failed\n", rm_string);
-		fprintf(temp, "rm command exit status = %d\n", status);
+			for (j = 0; j < tc->repetitions; j++)
+				SAFE_WRITE(SAFE_WRITE_ALL, fd, path, strlen(path));
+			SAFE_CLOSE(fd);
+		} else {
+			SAFE_MKDIR(path, 0777);
+			create_tree(tc, path, level + 1, id);
+		}
 	}
-
-	/****************************************/
-	/*                                      */
-	/*         .....and exit main           */
-	/*                                      */
-	/****************************************/
-
-	anyfail();
-	/***** NOT REACHED ******/
-	tst_exit();
 }
 
-int generate(char *string, int level)
-
-/****************************************/
-/*					*/
-/*   generate recursively a tree of	*/
-/*   directories and files:  within   	*/
-/*   created directory, an alternating	*/
-/*   series of files and directories 	*/
-/*   are constructed---until tree	*/
-/*   breadth and depth limits are	*/
-/*   reached or an error occurs		*/
-/*					*/
-/****************************************/
-/***************************/
-/*  string[]      	   */
-/*  the directory path     */
-/*  string below which a   */
-/*  tree is generated      */
-/*                         */
-/***************************/
-
-/***************************/
-/* level                   */
-/* the tree depth variable */
-/*                         */
-/***************************/
+static void verify_file(const struct tcase *tc, const char *path)
 {
-	int switch_flag;
-	int ret_val = 0;
-	int new_ret_val, len, ret_len;
-	char new_string[PATH_STRING_LENGTH + 1];
-	int new_level;
-	int i, j;		/* iteration counters */
-	int snp_ret;
-
-	switch_flag = level & TRUE;
-	if (strlen(string) >= MAX_PATH_STRING_LENGTH) {
-
-		/********************************/
-		/*                              */
-		/*   Maximum path name length   */
-		/*          reached             */
-		/*                              */
-		/********************************/
-
-		fprintf(temp, "\tMaximum path_name length reached.\n");
-		return (-1);
-	} else if (level < MAX_DEPTH) {
-		for (i = 0; i <= MAX_BREADTH; i++) {
-			get_next_name();
-			snp_ret = snprintf(new_string, sizeof(new_string),
-				"%s/%s", string, name);
-			if (snp_ret < 0 || snp_ret >= sizeof(new_string)) {
-				tst_resm(TBROK, "snprintf(new_string,..) "
-					"returned %d", snp_ret);
-				fail_exit();
-			}
-
-			/****************************************/
-			/*                                      */
-			/*    switch between creating files     */
-			/*    and making directories            */
-			/*                                      */
-			/****************************************/
-
-			if (switch_flag) {
-				switch_flag = FALSE;
-
-				/****************************************/
-				/*                                      */
-				/*        create a new file             */
-				/*                                      */
-				/****************************************/
-
-				file_id = creat(new_string, FILE_MODE);
-				if (file_id == -1) {
-					fprintf(temp,
-						"\tImpossible to create file %s, errno=%d\n",
-						new_string, errno);
-					return (-2);
-				}
-#ifdef PRINT
-				printf("%d  %s F\n", level, new_string);
-#endif
-
-				/****************************************/
-				/*                                      */
-				/*            write to it               */
-				/*                                      */
-				/****************************************/
-
-				len = strlen(new_string);
-				for (j = 1; j <= FILE_LENGTH; j++) {
-					ret_len =
-					    write(file_id, new_string, len);
-					if (ret_len != len) {
-						fprintf(temp,
-							"\tUnsuccessful write to file %s, expected return of %d, got %d, errno=%d\n",
-							new_string, len,
-							ret_len, errno);
-						return (-3);
-					}
-				}
-				close(file_id);
-
-				/****************************************/
-				/*                                      */
-				/*   and store its name in path_list    */
-				/*                                      */
-				/****************************************/
-
-				strcpy(write_string, new_string);
-				len = strlen(write_string);
-				write_string[len++] = 'F';
-				write_string[len] = '\0';
-				escrivez(write_string);
-			} else {
-				switch_flag = TRUE;
-
-				/****************************************/
-				/*                                      */
-				/*       or make a directory            */
-				/*                                      */
-				/****************************************/
-
-				ret_val = mkdir(new_string, DIRECTORY_MODE);
-
-				if (ret_val != 0) {
-					fprintf(temp,
-						"\tImpossible to create directory %s, errno=%d\n",
-						new_string, errno);
-					return (-5);
-				}
-#ifdef PRINT
-				printf("%d  %s D\n", level, new_string);
-#endif
-
-				/****************************************/
-				/*                                      */
-				/*     store its name in path_list      */
-				/*                                      */
-				/****************************************/
-
-				strcpy(write_string, new_string);
-				len = strlen(write_string);
-				write_string[len++] = 'D';
-				write_string[len] = '\0';
-				escrivez(write_string);
-
-				/****************************************/
-				/*                                      */
-				/*      and generate a new level        */
-				/*                                      */
-				/****************************************/
+	char buf[PATH_MAX];
+	char extra;
+	struct stat st;
+	size_t len = strlen(path);
+	unsigned int i;
+	int fd = SAFE_OPEN(path, O_RDONLY);
+
+	SAFE_FSTAT(fd, &st);
+	if (!S_ISREG(st.st_mode))
+		tst_brk(TFAIL, "%s is not a regular file", path);
+
+	if (st.st_size != (off_t)(len * tc->repetitions)) {
+		tst_brk(TFAIL, "%s has size %lld, expected %zu", path,
+			(long long)st.st_size, len * tc->repetitions);
+	}
 
-				new_level = level + 1;
-				new_ret_val = generate(new_string, new_level);
-				if (new_ret_val < ret_val)
-					ret_val = new_ret_val;
-			}
-		}
+	for (i = 0; i < tc->repetitions; i++) {
+		SAFE_READ(1, fd, buf, len);
+		if (memcmp(buf, path, len))
+			tst_brk(TFAIL, "%s contains unexpected data at record %u",
+				path, i);
+	}
 
-		/********************************/
-		/*                              */
-		/*    Maximum breadth reached   */
-		/*                              */
-		/********************************/
+	if (SAFE_READ(SAFE_READ_ANY, fd, &extra, 1))
+		tst_brk(TFAIL, "%s has data after the expected records", path);
 
-		return (ret_val);
-	} else
-		    /********************************/
-		/*                             */
-		/*    Maximum depth reached    */
-		/*                             */
- /********************************/
-		return 0;
+	SAFE_CLOSE(fd);
 }
 
-int check(void)
-
-/****************************************/
-/*					*/
-/*   check for file and directory	*/
-/*   correctness by reading records	*/
-/*   from the path_list and attempting	*/
-/*   to determine if the corresponding	*/
-/*   files or directories are as 	*/
-/*   created 				*/
-/*					*/
-/****************************************/
+static void verify_tree(const struct tcase *tc, const char *parent,
+			unsigned int level, unsigned int *id)
 {
-	int len, path_mode, val, ret_len, j;
-
-	for (;;) {
-
-		/****************************************/
-		/*                                      */
-		/*  read a path string from path_list   */
-		/*                                      */
-		/****************************************/
+	unsigned int i;
+	int create_file = level & 1;
 
-		if (fscanf(list_stream, "%s", path_string) == EOF) {
+	if (level >= tc->depth)
+		return;
 
-#ifdef PRINT
-			printf("\nEnd of path_list file reached \n");
-#endif
-
-			return 0;
-		}
-#ifdef PRINT
-		printf("%s\n", path_string);
-#endif
+	for (i = 0; i < tc->fanout; i++, create_file = !create_file) {
+		char path[PATH_MAX];
 
-		len = strlen(path_string);
-		len--;
-		if (path_string[len] == 'F') {
-
-		/********************************/
-			/*                              */
-			/*    this should be a file     */
-			/*                              */
-		/********************************/
-
-			path_string[len] = '\0';
-			file_id = open(path_string, READ);
-			if (file_id <= 0) {
-				fprintf(temp,
-					"\tImpossible to open file %s, errno=%d\n",
-					path_string, errno);
-				return (-1);
-			}
-
-			else {
-				/********************************/
-				/*                              */
-				/*    check its contents        */
-				/*                              */
-				/********************************/
-
-				len = strlen(path_string);
-				for (j = 1; j <= FILE_LENGTH; j++) {
-					ret_len =
-					    read(file_id, read_string, len);
-					if (len != ret_len) {
-						fprintf(temp,
-							"\tFile read error for file %s, expected return of %d, got %d, errno=%d\n",
-							path_string, len,
-							ret_len, errno);
-						return (-3);
-					}
-					read_string[len] = '\0';
-					val = strcmp(read_string, path_string);
-					if (val != 0) {
-						fprintf(temp,
-							"\tContents of file %s are different than expected: %s\n",
-							path_string,
-							read_string);
-						return (-4);
-					}
-				}
-				close(file_id);
-			}	/* else for */
-			if (ret_len <= 0) {
-				fprintf(temp, "\tImpossible to read file %s\n",
-					path_string);
-				return (-2);
-			}
+		snprintf(path, sizeof(path), "%s/%08u", parent, ++*id);
+		if (create_file) {
+			verify_file(tc, path);
 		} else {
+			struct stat st;
 
-		/********************************/
-			/*                              */
-			/*  otherwise..........         */
-			/*  it should be a directory    */
-			/*                              */
-		/********************************/
-
-			path_string[len] = '\0';
-			path_mode = mode(path_string);
-			if (path_mode == -1) {
-				fprintf(temp,
-					"\tPreviously created directory path %s was not open\n",
-					path_string);
-				return (-4);
-			}
-			if ((040000 & path_mode) != 040000) {
-				fprintf(temp,
-					"\tPath %s was not recognized to be a directory\n",
-					path_string);
-				fprintf(temp, "\tIts mode is %o\n", path_mode);
-				return (-5);
-			}
-		}
-	}			/* while */
-}
-
-int get_next_name(void)
-
-/****************************************/
-/*					*/
-/*   get the next---in a dictionary	*/
-/*   sense---file or directory name	*/
-/*					*/
-/****************************************/
-{
-	static int k;
-	int i;
-	int last_position;
-
-	last_position = NAME_LENGTH - 1;
-	if (k == 0) {
-
-		/************************/
-		/*                      */
-		/*   initialize name    */
-		/*                      */
-		/************************/
-
-		for (i = 0; i < NAME_LENGTH; i++)
-			name[i] = 'a';
-		name[NAME_LENGTH] = '\0';
-		k++;
-	}
-					    /********************************/
-	/*                              */
-	else
-		increment_name(last_position);	/* i.e., beginning at the last  */
-	/* position                     */
-	/*                              */
-					    /********************************/
-	return 0;
-}
-
-int increment_name(int position)
-
-/****************************************/
-/*					*/
-/*  recursively revise the letters in 	*/
-/*  a name to get the lexiographically	*/
-/*  next name				*/
-/*					*/
-/****************************************/
-{
-	int next_position;
-
-	if (name[position] == 'z')
-		if (position == 0) {
-			fprintf(temp,
-				"\tERROR: There are no more available names\n");
-			fail_exit();
-		} else {
-			name[position] = 'a';	       /**********************/
-			next_position = --position;	/*                    */
-			increment_name(next_position);	/*  increment the     */
-			/*  previous letter   */
-			/*                    */
-						       /**********************/
+			SAFE_STAT(path, &st);
+			if (!S_ISDIR(st.st_mode))
+				tst_brk(TFAIL, "%s is not a directory", path);
+			verify_tree(tc, path, level + 1, id);
 		}
-				  /*********************************/
-	/*                               */
-	else
-		name[position]++;	/* otherwise, increment this one */
-	return 0;		/*                               */
-				  /*********************************/
-}
-
-int mode(char *path_string)
-
-/****************************************/
-/*					*/
-/*   determine and return the mode of	*/
-/*   the file named by path_string 	*/
-/*					*/
-/****************************************/
-{
-	struct stat buf;
-	int ret_val, mod;
-
-	ret_val = stat(path_string, &buf);
-	if (ret_val == -1)
-		return (-1);
-	else {
-		mod = buf.st_mode;
-		return (mod);
 	}
 }
 
-int escrivez(char *string)
+static void run_worker(const struct tcase *tc)
 {
-	char write_string[PATH_STRING_LENGTH + 1];
-	int len, ret_len;
-
-	strcpy(write_string, string);
-	len = strlen(write_string);
-	write_string[len] = '\n';
-	len++;
-	ret_len = write(list_id, write_string, len);
-	if (len != ret_len) {
-		fprintf(temp,
-			"\tA string of deviant length %d written to path_list, errno=%d\n",
-			ret_len, errno);
-		fail_exit();
-	}
-	return 0;
+	char root[PATH_MAX];
+	struct stat st;
+	unsigned int id = 0;
+
+	TST_CHECKPOINT_WAIT(0);
+	snprintf(root, sizeof(root), "inode.%d", getpid());
+	SAFE_MKDIR(root, 0777);
+	create_tree(tc, root, 0, &id);
+
+	SAFE_STAT(root, &st);
+	if (!S_ISDIR(st.st_mode))
+		tst_brk(TFAIL, "%s is not a directory", root);
+
+	id = 0;
+	verify_tree(tc, root, 0, &id);
+	tst_res(TPASS, "Created and verified %u objects in %s", id + 1, root);
+	tst_purge_dir(root);
+	SAFE_RMDIR(root);
+	exit(0);
 }
 
-int term(void)
+static void run(unsigned int n)
 {
-	int status;
-
-	fprintf(temp, "\tterm - got SIGTERM, cleaning up.\n");
+	const struct tcase *tc = &tcases[n];
+	unsigned int i;
 
-	if (list_stream != NULL)
-		fclose(list_stream);
-	close(list_id);
-	close(file_id);
+	tst_res(TINFO, "Testing %s (depth=%u fanout=%u repetitions=%u workers=%u)",
+		tc->desc, tc->depth, tc->fanout, tc->repetitions, tc->workers);
 
-	status = system(rm_string);
-	if (status) {
-		fprintf(temp, "Caution - ``%s'' may have failed.\n", rm_string);
-		fprintf(temp, "rm command exit status = %d\n", status);
+	for (i = 0; i < tc->workers; i++) {
+		if (!SAFE_FORK())
+			run_worker(tc);
 	}
 
-	ok_exit();
-	/***NOT REACHED***/
-	return 0;
-
-}
-
-/** LTP Port **/
-/*
- * setup
- *
- * Do set up - here its a dummy function
- */
-void setup(void)
-{
-	tst_tmpdir();
-	temp = stderr;
-}
-
-/*
- * Function: blexit()
- *
- * Description: This function will exit a block, a block may be a lo
-gical unit
- *              of a test. It will report the status if the test ie
-fail or
- *              pass.
- */
-void blexit(void)
-{
-	(local_flag == PASSED) ? tst_resm(TPASS, "Test block %d", block_number)
-	    : tst_resm(TFAIL, "Test block %d", block_number);
-	block_number++;
-	return;
-}
-
-/*
- * Function: blenter()
- *
- * Description: Print message on entering a new block
- */
-void blenter(void)
-{
-	local_flag = PASSED;
-	return;
+	TST_CHECKPOINT_WAKE2(0, tc->workers);
 }
 
-/*
- * fail_exit()
- *
- * Exit on failure
- */
-void fail_exit(void)
-{
-	tst_brkm(TFAIL, tst_rmdir, "Test failed");
-}
-
-/*
- *
- * Function: anyfail()
- *
- * Description: Exit a test.
- */
-void anyfail(void)
-{
-	(local_flag == FAILED) ? tst_resm(TFAIL, "Test failed")
-	    : tst_resm(TPASS, "Test passed");
-	tst_rmdir();
-	tst_exit();
-}
-
-/*
- * ok_exit
- *
- * Calling block passed the test
- */
-void ok_exit(void)
-{
-	local_flag = PASSED;
-	return;
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.timeout = 300,
+};
diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
deleted file mode 100644
index 43e406d545c65b88a6e185a269f0d1b62bef2201..0000000000000000000000000000000000000000
--- a/testcases/kernel/fs/inode/inode02.c
+++ /dev/null
@@ -1,902 +0,0 @@
-/*
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
- */
-
-/* 11/01/2002	Port to LTP	robbiew@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-
-			   /*inode02.c */
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
-CALLS:	mkdir, stat, open
-
-	Run with TERM mode.
-
->KEYS:  < file system and I/O management, system resource constraints.
->WHAT:  < Can the system handle a heavy load on the file system I/O
-	< functions?
->HOW:   < Create several identical process that call inode02.c.  This
-	< will simulate the multi-user environment, and hopefully uncover
-	< conflicts that might occur in "real life" use.
->BUGS:  <
-======================================================================*/
-
-#define PATH_STRING_LENGTH  1024
-#define NAME_LENGTH  8
-#define MAX_PATH_STRING_LENGTH  (PATH_STRING_LENGTH - NAME_LENGTH - 40)
-#define DIRECTORY_MODE  00777
-#define FILE_MODE       00777
-
-#define MKDIR_STRING_LENGTH  (MAX_PATH_STRING_LENGTH + 7)
-
-/* #define DEBUG	 you can watch the generation with this flag */
-
-#define TRUE  1
-#define FALSE 0
-#define READ  0
-#define WRITE 1
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <signal.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/wait.h>
-
-#ifdef LINUX
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#endif
-
-#define MAXCHILD	25
-int allchild[MAXCHILD + 1];
-
-char name[NAME_LENGTH + 1];
-char path_string[PATH_STRING_LENGTH + 1];
-char read_string[PATH_STRING_LENGTH + 1];
-char write_string[PATH_STRING_LENGTH + 1];
-char remove_string[PATH_STRING_LENGTH + 10];
-int parent_pid;
-int nchild;
-
-FILE *list_stream = NULL;
-int list_id;
-int file_id;
-
-int increment_name(), get_next_name(), mode(), escrivez(), massmurder();
-int max_depth, max_breadth, file_length;
-int bd_arg(char *);
-
-#ifdef LINUX
-void (*sigset(int, void (*)(int))) (int);
-#endif
-
-/** LTP Port **/
-#include "test.h"
-
-void setup(void);
-void fail_exit(void);
-void anyfail(void);
-void ok_exit(void);
-void forkfail(void);
-void terror(char *);
-int instress(void);
-
-#define FAILED 0
-#define PASSED 1
-
-int local_flag = PASSED;
-FILE *temp;
-
-char *TCID = "inode02";		/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
-/**************/
-
-int main(int argc, char *argv[])
-{
-	int pid, tree(), p, status;
-	int count, child;
-	register int i;
-	int term();
-
-	setup();
-
-	parent_pid = getpid();
-
-	if (sigset(SIGTERM, (void (*)())term) == SIG_ERR) {
-		tst_resm(TBROK, "\tSIGTERM sigset set failed, errno=%d",
-			 errno);
-		exit(1);
-	}
-
-	/************************************************/
-	/*                                              */
-	/*  Input the parameters for the directory---   */
-	/*  file trees which are to be generated        */
-	/*                                              */
-	/************************************************/
-
-	if (argc < 2) {
-		max_depth = 6;
-		max_breadth = 5;
-		file_length = 8;
-		nchild = 5;
-	} else if (argc < 5) {
-		tst_resm(TCONF, "Bad argument count.");
-		printf
-		    ("\tinode02 max_depth max_breadth file_length #children\n\tdefault: inode02 6 5 8 5\n");
-		exit(1);
-	} else {
-		i = 1;
-		if (sscanf(argv[i++], "%d", &max_depth) != 1)
-			bd_arg(argv[i - 1]);
-		if (sscanf(argv[i++], "%d", &max_breadth) != 1)
-			bd_arg(argv[i - 1]);
-		if (sscanf(argv[i++], "%d", &file_length) != 1)
-			bd_arg(argv[i - 1]);
-		if (sscanf(argv[i++], "%d", &nchild) != 1)
-			bd_arg(argv[i - 1]);
-		if (nchild > MAXCHILD) {
-			fprintf(temp, "too many children - max is %d\n",
-				MAXCHILD);
-			exit(1);
-		}
-	}
-
-	/************************************************/
-	/*                                              */
-	/*  Generate and check nchild trees             */
-	/*                                              */
-	/************************************************/
-
-	for (p = 0; p < nchild; p++) {
-		pid = fork();
-		if (pid == 0) {
-			tree();
-		} else {
-			if (pid < 1) {
-				terror
-				    ("Fork failed (may be OK if under stress)");
-				massmurder();
-				if (instress()) {
-					ok_exit();
-				}
-				forkfail();
-			}
-		}
-	}
-
-	count = 0;
-	while ((child = wait(&status)) > 0) {
-#ifdef DEBUG
-		tst_resm(TINFO, "Test %d exited status = %d\n", child, status);
-#endif
-		if (status) {
-			fprintf(temp, "Test %d failed - expected 0 exit.\n",
-				child);
-			local_flag = FAILED;
-		}
-		count++;
-	}
-
-	if (count != nchild) {
-		tst_resm(TFAIL, "Wrong number of children waited on!");
-		tst_resm(TFAIL, "Saw %d, expected %d", count, nchild);
-		local_flag = FAILED;
-	}
-
-	/************************************************/
-	/*                                              */
-	/*  And report the results..........            */
-	/*                                              */
-	/************************************************/
-
-	anyfail();
-	/** NOT REACHED **/
-	tst_exit();
-}
-
-int bd_arg(char *str)
-{
-	fprintf(temp,
-		"Bad argument - %s - could not parse as number.\n\tinode02 [max_depth] [max_breadth] [file_length] [#children]\n\tdefault: inode02 6 5 8 5\n",
-		str);
-	exit(1);
-}
-
-int tree(void)
-
-/************************************************/
-/*						*/
-/*  		      TREE			*/
-/*						*/
-/*   generate a tree of directories and files   */
-/*   and save the path names in the path_list	*/
-/*   file 					*/
-/*						*/
-/*   then, read the path names and attempt to   */
-/*   access the corresponding directories and	*/
-/*   files					*/
-/*						*/
-/************************************************/
-{
-	int gen_ret_val, ch_ret_val, exit_val, level;
-	int ret_val;
-	int generate(), check();
-	char path_list_string[PATH_STRING_LENGTH + 10];
-	int len;
-	int status;
-	int snp_ret;
-
-	/********************************/
-	/*                              */
-	/*  make the root directory for */
-	/*  the tree                    */
-	/*                              */
-	/********************************/
-
-	sprintf(path_string, "inode02.%d", getpid());
-
-	ret_val = mkdir(path_string, DIRECTORY_MODE);
-
-	if (ret_val == -1) {
-		tst_resm(TBROK,
-			 "Reason: Impossible to create directory %s, errno=%d\n",
-			 path_string, errno);
-		exit(-5);
-	}
-
-	strcpy(remove_string, "rm -rf ");
-	strcat(remove_string, path_string);
-
-#ifdef DEBUG
-	tst_resm(TINFO, "\n%s\n", path_string);
-#endif
-
-	/****************************************/
-	/*                                      */
-	/*  create the "path_list" file, in     */
-	/*  which the list of generated paths   */
-	/*  will be stored so that they later   */
-	/*  may be checked                      */
-	/*                                      */
-	/****************************************/
-
-	snp_ret = snprintf(path_list_string, sizeof(path_list_string),
-		"%s/path_list",	path_string);
-	if (snp_ret < 0 || snp_ret >= sizeof(path_list_string)) {
-		tst_resm(TBROK, "snprintf(path_list_string,..) returned %d",
-			snp_ret);
-		exit(-1);
-	}
-	list_id = creat(path_list_string, FILE_MODE);
-	if (list_id == -1) {
-		fprintf(temp,
-			"\nThe path_list file '%s' cannot be created, errno=%d\n",
-			path_list_string, errno);
-		exit(-7);
-	}
-
-	/****************************************/
-	/*                                      */
-	/*   and store its name in path_list    */
-	/*                                      */
-	/****************************************/
-
-	strcpy(write_string, path_string);
-	len = strlen(write_string);
-	write_string[len++] = 'D';
-	write_string[len] = '\0';
-	escrivez(write_string);
-
-	/****************************************/
-	/*                                      */
-	/*   generate the directory-file tree   */
-	/*                                      */
-	/****************************************/
-
-	level = 0;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "\n\t%s\n\n", "GENERATING:");
-#endif
-
-	gen_ret_val = generate(path_string, level);
-	close(list_id);
-	list_id = open(path_list_string, READ);
-	if (list_id == -1) {
-		fprintf(temp,
-			"\nThe path_list file cannot be opened for reading, errno=%d\n",
-			errno);
-		exit(-8);
-	}
-	list_stream = fdopen(list_id, "r");
-
-	/****************************************/
-	/*                                      */
-	/*   check the directory-file tree      */
-	/*      for correctness                 */
-	/*                                      */
-	/****************************************/
-
-#ifdef DEBUG
-	tst_resm(TINFO, "\n\t%s\n\n", "CHECKING:");
-#endif
-
-	ch_ret_val = check();
-
-	exit_val = MIN(ch_ret_val, gen_ret_val);
-
-	status = fclose(list_stream);
-	if (status != 0) {
-		fprintf(temp,
-			"Failed to close list_stream: ret=%d errno=%d (%s)\n",
-			status, errno, strerror(errno));
-		exit(-8);
-	}
-
-	/*
-	 * Remove file.
-	 */
-
-	status = system(remove_string);
-	if (status) {
-		fprintf(temp, "Caution - `%s' failed.\n", remove_string);
-		fprintf(temp, "Status returned %d.\n", status);
-	}
-
-	/****************************************/
-	/*                                      */
-	/*         .....and exit main           */
-	/*                                      */
-	/****************************************/
-
-	exit(exit_val);
-}
-
-int generate(char *string, int level)
-
-/****************************************/
-/*					*/
-/*   generate recursively a tree of	*/
-/*   directories and files:  within   	*/
-/*   created directory, an alternating	*/
-/*   series of files and directories 	*/
-/*   are constructed---until tree	*/
-/*   breadth and depth limits are	*/
-/*   reached or an error occurs		*/
-/*					*/
-/****************************************/
-/***************************/
-/*  string:                */
-/*  the directory path     */
-/*  string below which a   */
-/*  tree is generated      */
-/*                         */
-/***************************/
-
-/***************************/
-/* level:                  */
-/* the tree depth variable */
-/*                         */
-/***************************/
-{
-	int switch_flag;
-	int ret_val = 0;
-	int new_ret_val, len, ret_len;
-	char new_string[PATH_STRING_LENGTH + 1];
-	int new_level;
-	int i, j;		/* iteration counters */
-	int snp_ret;
-
-	switch_flag = level & TRUE;
-	if (strlen(string) >= MAX_PATH_STRING_LENGTH) {
-
-		/********************************/
-		/*                              */
-		/*   Maximum path name length   */
-		/*          reached             */
-		/*                              */
-		/********************************/
-
-		fprintf(temp, "\nMaximum path_name length reached\n");
-		return (-1);
-	} else if (level < max_depth) {
-		for (i = 0; i <= max_breadth; i++) {
-			get_next_name();
-			snp_ret = snprintf(new_string, sizeof(new_string),
-				"%s/%s", string, name);
-			if (snp_ret < 0 || snp_ret >= sizeof(new_string)) {
-				tst_resm(TBROK, "snprintf(new_string,..) "
-					"returned %d", snp_ret);
-				exit(-1);
-			}
-
-			/****************************************/
-			/*                                      */
-			/*    switch between creating files     */
-			/*    and making directories            */
-			/*                                      */
-			/****************************************/
-
-			if (switch_flag) {
-				switch_flag = FALSE;
-
-				/****************************************/
-				/*                                      */
-				/*        create a new file             */
-				/*                                      */
-				/****************************************/
-
-				file_id = creat(new_string, FILE_MODE);
-				if (file_id == -1) {
-					fprintf(temp,
-						"\nImpossible to create file %s, errno=%d\n",
-						new_string, errno);
-					return (-2);
-				}
-#ifdef DEBUG
-				tst_resm(TINFO, "%d  %s F\n", level,
-					 new_string);
-#endif
-
-				/****************************************/
-				/*                                      */
-				/*            write to it               */
-				/*                                      */
-				/****************************************/
-
-				len = strlen(new_string);
-				for (j = 1; j <= file_length; j++) {
-					ret_len =
-					    write(file_id, new_string, len);
-					if (ret_len != len) {
-						fprintf(temp,
-							"\nUnsuccessful write to file %s, errno=%d\n",
-							new_string, errno);
-						return (-3);
-					}
-				}
-				close(file_id);
-
-				/****************************************/
-				/*                                      */
-				/*   and store its name in path_list    */
-				/*                                      */
-				/****************************************/
-
-				strcpy(write_string, new_string);
-				len = strlen(write_string);
-				write_string[len++] = 'F';
-				write_string[len] = '\0';
-				escrivez(write_string);
-			} else {
-				switch_flag = TRUE;
-
-				/****************************************/
-				/*                                      */
-				/*       or make a directory            */
-				/*                                      */
-				/*  (mknod can only be called when in   */
-				/*   super user mode)                   */
-				/*                                      */
-				/****************************************/
-
-				ret_val = mkdir(new_string, DIRECTORY_MODE);
-
-				if (ret_val != 0) {
-					fprintf(temp,
-						"\nImpossible to create directory %s, errno=%d\n",
-						new_string, errno);
-					return (-5);
-				}
-#ifdef DEBUG
-				tst_resm(TINFO, "%d  %s D\n", level,
-					 new_string);
-#endif
-
-				/****************************************/
-				/*                                      */
-				/*     store its name in path_list      */
-				/*                                      */
-				/****************************************/
-
-				strcpy(write_string, new_string);
-				len = strlen(write_string);
-				write_string[len++] = 'D';
-				write_string[len] = '\0';
-				escrivez(write_string);
-
-				/****************************************/
-				/*                                      */
-				/*      and generate a new level        */
-				/*                                      */
-				/****************************************/
-
-				new_level = level + 1;
-				new_ret_val = generate(new_string, new_level);
-				if (new_ret_val < ret_val)
-					ret_val = new_ret_val;
-			}
-		}
-
-		/********************************/
-		/*                              */
-		/*    Maximum breadth reached   */
-		/*                              */
-		/********************************/
-
-		return (ret_val);
-	} else
-		    /********************************/
-		/*                             */
-		/*    Maximum depth reached    */
-		/*                             */
- /********************************/
-		return 0;
-}
-
-int check(void)
-
-/****************************************/
-/*					*/
-/*   check for file and directory	*/
-/*   correctness by reading records	*/
-/*   from the path_list and attempting	*/
-/*   to determine if the corresponding	*/
-/*   files or directories are as 	*/
-/*   created 				*/
-/*					*/
-/****************************************/
-{
-	int len, path_mode, val, ret_len, j;
-
-	for (;;) {
-
-		/****************************************/
-		/*                                      */
-		/*  read a path string from path_list   */
-		/*                                      */
-		/****************************************/
-
-		if (fscanf(list_stream, "%s", path_string) == EOF) {
-
-#ifdef DEBUG
-			tst_resm(TINFO, "\nEnd of path_list file reached \n");
-#endif
-
-			return 0;
-		}
-#ifdef DEBUG
-		tst_resm(TINFO, "%s\n", path_string);
-#endif
-
-		len = strlen(path_string);
-		len--;
-		if (path_string[len] == 'F') {
-
-		/********************************/
-			/*                              */
-			/*    this should be a file     */
-			/*                              */
-		/********************************/
-
-			path_string[len] = '\0';
-			file_id = open(path_string, READ);
-			if (file_id <= 0) {
-				fprintf(temp,
-					"\nImpossible to open file %s, errno=%d\n",
-					path_string, errno);
-				return (-1);
-			}
-
-			else {
-				/********************************/
-				/*                              */
-				/*    check its contents        */
-				/*                              */
-				/********************************/
-
-				ret_len = 0;
-				len = strlen(path_string);
-				for (j = 1; j <= file_length; j++) {
-					ret_len =
-					    read(file_id, read_string, len);
-					if (len != ret_len) {
-						fprintf(temp,
-							"\nFile read error for file %s, errno=%d\n",
-							path_string, errno);
-						return (-3);
-					}
-					read_string[len] = '\0';
-					val = strcmp(read_string, path_string);
-					if (val != 0) {
-						fprintf(temp,
-							"\nContents of file %s are different than expected: %s\n",
-							path_string,
-							read_string);
-						return (-4);
-					}
-				}
-				close(file_id);
-			}	/* else for */
-			if (ret_len <= 0) {
-				fprintf(temp,
-					"\nImpossible to read file %s, errno=%d\n",
-					path_string, errno);
-				return (-2);
-			}
-		} else {
-
-		/********************************/
-			/*                              */
-			/*  otherwise..........         */
-			/*  it should be a directory    */
-			/*                              */
-		/********************************/
-
-			path_string[len] = '\0';
-			path_mode = mode(path_string);
-			if (path_mode == -1) {
-				fprintf(temp,
-					"\nPreviously created directory path %s was not open\n",
-					path_string);
-				return (-4);
-			}
-			if ((040000 & path_mode) != 040000) {
-				fprintf(temp,
-					"\nPath %s was not recognized to be a directory\n",
-					path_string);
-				fprintf(temp, "Its mode is %o\n", path_mode);
-				return (-5);
-			}
-		}
-	}			/* while */
-}
-
-int get_next_name(void)
-
-/****************************************/
-/*					*/
-/*   get the next---in a dictionary	*/
-/*   sense---file or directory name	*/
-/*					*/
-/****************************************/
-{
-	static int k;
-	int i;
-	int last_position;
-
-	last_position = NAME_LENGTH - 1;
-	if (k == 0) {
-
-		/************************/
-		/*                      */
-		/*   initialize name    */
-		/*                      */
-		/************************/
-
-		for (i = 0; i < NAME_LENGTH; i++)
-			name[i] = 'a';
-		name[NAME_LENGTH] = '\0';
-		k++;
-	}
-					    /********************************/
-	/*                              */
-	else
-		increment_name(last_position);	/* i.e., beginning at the last  */
-	/* position                     */
-	/*                              */
-					    /********************************/
-	return 0;
-}
-
-int increment_name(int position)
-
-/****************************************/
-/*					*/
-/*  recursively revise the letters in 	*/
-/*  a name to get the lexiographically	*/
-/*  next name				*/
-/*					*/
-/****************************************/
-{
-	int next_position;
-
-	if (name[position] == 'z')
-		if (position == 0) {
-			fprintf(temp,
-				"ERROR: There are no more available names\n");
-			exit(-1);
-		} else {
-			name[position] = 'a';	       /**********************/
-			next_position = --position;	/*                    */
-			increment_name(next_position);	/*  increment the     */
-			/*  previous letter   */
-			/*                    */
-						       /**********************/
-		}
-				  /*********************************/
-	/*                               */
-	else
-		name[position]++;	/* otherwise, increment this one */
-	return 0;		/*                               */
-				  /*********************************/
-}
-
-int mode(char *path_string)
-
-/****************************************/
-/*					*/
-/*   determine and return the mode of	*/
-/*   the file named by path_string 	*/
-/*					*/
-/****************************************/
-{
-	struct stat buf;
-	int ret_val, mod;
-
-	ret_val = stat(path_string, &buf);
-	if (ret_val == -1)
-		return (-1);
-	else {
-		mod = buf.st_mode;
-		return (mod);
-	}
-}
-
-int escrivez(char *string)
-{
-	char write_string[PATH_STRING_LENGTH + 1];
-	int len, ret_len;
-
-	strcpy(write_string, string);
-	len = strlen(write_string);
-	write_string[len] = '\n';
-	len++;
-	ret_len = write(list_id, write_string, len);
-	if (len != ret_len) {
-		fprintf(temp,
-			"A string of deviant length %d written to path_list, errno=%d\n",
-			ret_len, errno);
-		exit(-2);
-	}
-	return 0;
-}
-
-int term(void)
-{
-	int status;
-
-	fflush(temp);
-	if (parent_pid == getpid()) {
-		massmurder();	/* kill kids */
-		fprintf(temp, "\term1 - SIGTERM received by parent.\n");
-		fflush(temp);
-	} else {
-		fprintf(temp, "\tchild - got SIGTERM signal.\n");
-		if (list_stream != NULL)
-			fclose(list_stream);
-		close(list_id);
-		close(file_id);
-		status = system(remove_string);
-		if (status) {
-			fprintf(temp, "Caution - ``%s'' returned status %d\n",
-				remove_string, status);
-		}
-		exit(0);
-	}
-	return 0;
-}
-
-int massmurder(void)
-{
-	int i;
-	for (i = 0; i < MAXCHILD; i++) {
-		if (allchild[i]) {
-			kill(allchild[i], SIGTERM);
-		}
-	}
-	return 0;
-}
-
-/** LTP Port **/
-/*
- * setup
- *
- * Do set up - here its a dummy function
- */
-void setup(void)
-{
-	tst_tmpdir();
-	temp = stderr;
-}
-
-/*
- * fail_exit()
- *
- * Exit on failure
- */
-void fail_exit(void)
-{
-	tst_brkm(TFAIL, tst_rmdir, "Test failed");
-}
-
-/*
- *
- * Function: anyfail()
- *
- * Description: Exit a test.
- */
-void anyfail(void)
-{
-	(local_flag == FAILED) ? tst_resm(TFAIL, "Test failed")
-	    : tst_resm(TPASS, "Test passed");
-	tst_rmdir();
-	tst_exit();
-}
-
-/*
- * ok_exit
- *
- * Calling block passed the test
- */
-void ok_exit(void)
-{
-	local_flag = PASSED;
-	return;
-}
-
-/*
- * forkfail()
- *
- * exit on failure
- */
-void forkfail(void)
-{
-	tst_brkm(TBROK, tst_rmdir, "Reason: %s", strerror(errno));
-}
-
-/*
- * Function: terror
- *
- * Description: prints error message this may not be because some part of the
- *              test case failed, for example fork() failed. We will log this
- *              failure as TBROK instead of TFAIL.
- */
-void terror(char *message)
-{
-	tst_resm(TBROK, "Reason: %s:%s", message, strerror(errno));
-	return;
-}
-
-/*
- * instress
- *
- * Assume that we are always running under stress, so this function will
- * return > 0 value always.
- */
-int instress(void)
-{
-	tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-		 " etc are likely to fail.\n");
-	return 1;
-}

---
base-commit: 00ee4a27e72788b88c75b747761eb986d1d7b758
change-id: 20260716-rewrite_inode_testing_suite-d43c42684849

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
