Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61545C02183
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736932390; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nV9oBe548q4qAj1F5T2dklhoigvgEw7UBTZsP8ot9wA=;
 b=G2PLriYm718qn36OcgRqGdRFJjRcMnAYaLcWC8mWGAXy8BJggkAdzAEna6P1GE0gz9r2W
 C3vRj/S146N3F1D85ILQhheJKCdg1tkkXojbqoK1GBRA/yYCFJP6gyXxnDaTAx1ZIdMhIjD
 kt0YuTisU6TrCpQYy/5ke2+5wgE94j4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFB533C7B5A
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:13:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E1A43C7A3C
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:12:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A55065616C
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736932345; x=1768468345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NtZKE8OFTKGxUvMBw7hjyrp7si3fYdkA5+48mdVlFMY=;
 b=dPc5MeCBNCvlzo4pbQTuWB6w9+NOI3dolxTRuedzdGXHr3q3qc6j9cly
 F92EayMa2zPbQGjfIbL3nvPugzqu+dBWb2Xwsynq3zOsBEQO5SzhRKRpK
 q+vBYZtCr5T25+J20Br0LjUSpRo+bGLmtDBLjNCIkEghyj9aeIZo1ZNM/
 xSbc9FJJvXiZdckFbCfMMujIJqvF83bHkYVnRqpJziMAYQr8osdPmdSB6
 Q9ijMZRQPU2zfx+t9xYFlmD2HWYa1wiDrvD2u2knxpwxlsYvC/bH6FqcQ
 e9j+tcvNuLxPe+W1tAU6MYVuB0lodWZv/s2blAdfe6Hv867bq6sYxnvV4 w==;
X-CSE-ConnectionGUID: dSp0d47VT5iZdW2omLKf+g==
X-CSE-MsgGUID: cUS7OuugRjyNUPPNbFVF9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="186576231"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; d="scan'208";a="186576231"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 18:12:22 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 089D0DE67A
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D611BD88D9
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E97920071A37
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id DECB01A000B;
 Wed, 15 Jan 2025 17:12:18 +0800 (CST)
To: ltp@lists.linux.it,
	liwang@redhat.com
Date: Wed, 15 Jan 2025 17:12:16 +0800
Message-ID: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.006
X-TMASE-Result: 10--10.855600-10.000000
X-TMASE-MatchedRID: I8bbGwZUBfT5hD2hwXOXS0hwlOfYeSqx+KgiyLtJrSBjtMlSv+S5nHv3
 EJJrdBuxTOCZcxBO5FhrW/tgjC4+AS/7QU2czuUNtw+xHnsmQjM8V13UNOVlwWPZr2NA6vZGzEB
 dkYlGYZRFFrjTpX9jDBP91RdGQH6y2DJQA8IHlR37IK6Q1+r9ntmhsJODizUsvnhgJqkfm0BexH
 VWV7Fz7/hck8AZNqI8q4tDHpM//bIvt8akOOKRVm03YawHJvPCSLyuC617NWmcpGufbGiAqNTnG
 wqnA9/JQdPidGokcMNLwDFQTTd3sDa7IBuOPthEXYWcmn4D4qsfimmlcABuNyS30GKAkBxWF9Vs
 0wSXPdZ/sjVG8keo4hAvQkLParmrT1Kh7SiNNRuVF2HD8EHNp5Ry1HDTPOXax2rmrhwncOoYQb1
 oGZV/vOLzNWBegCW2wgn7iDBesS3fd+P6wwCt84RtqopBKUBln9FRkwO5e2DpWBiooOggjYd2V7
 TsTXKx4EO6FZVg1Q2aOfAjZhyWcg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] fchownat01: Convert to new API
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1. convert to new API
2. move error tests to fchownat03
3. check if uid/gid is correctly set

---
V1: https://lore.kernel.org/ltp/20240126062540.2596279-1-ruansy.fnst@fujitsu.com/T/#u

Changes:
 * Move error tests from fchownat01 to fchownat03
 * fchownat01: Add check if file's ownership changed successfully
 * fchownat02: Use AT_FDCWD instead of dir_fd

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat01.c     | 160 ++++++------------
 1 file changed, 50 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 7771c111a..6768fdd77 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -1,133 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2006
- *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
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
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2007-2025
  */
-/*
- * DESCRIPTION
- *	This test case will verify basic function of fchownat
- *	added by kernel 2.6.16 or up.
+
+/*\
+ * [Description]
+ *
+ * Verify basic function of fchownat() added by kernel 2.6.16 or up.
  */
 
 #define _GNU_SOURCE
+#include "tst_test.h"
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-
-#define TESTFILE	"testfile"
-
-static void setup(void);
-static void cleanup(void);
+#define TESTFILE1	"testfile1"
+#define TESTFILE2	"testfile2"
 
+static uid_t set_uid = 1000;
+static gid_t set_gid = 1000;
 static int dir_fd;
-static int fd;
-static int no_fd = -1;
 static int cu_fd = AT_FDCWD;
 
-static struct test_case_t {
-	int exp_ret;
-	int exp_errno;
-	int flag;
-	int *fds;
-	char *filenames;
-} test_cases[] = {
-	{0, 0, 0, &dir_fd, TESTFILE},
-	{-1, ENOTDIR, 0, &fd, TESTFILE},
-	{-1, EBADF, 0, &no_fd, TESTFILE},
-	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
-	{0, 0, 0, &cu_fd, TESTFILE},
+static struct tcase {
+	int *fd;
+	char *filename;
+} tcases[] = {
+	{ &dir_fd, TESTFILE1, },
+	{ &cu_fd, TESTFILE2, },
 };
 
-char *TCID = "fchownat01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void fchownat_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
+static void fchownat_verify(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			fchownat_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
+	struct tcase *tc = &tcases[n];
+	struct stat stat_buf;
+	int fd = *tc->fd;
+	const char *filename = tc->filename;
+
+	TST_EXP_PASS_SILENT(fchownat(fd, filename, set_uid, set_gid, 0));
+
+	/* check if the file's ownership changed successfully */
+	SAFE_STAT(filename, &stat_buf);
+	if (stat_buf.st_uid == set_uid && stat_buf.st_gid == set_gid)
+		tst_res(TPASS, "fchownat(%d, %s, %d, %d, 0)",
+			fd, filename, set_uid, set_gid);
+	else
+		tst_res(TFAIL, "fchownat() fails because uid(%d) != set(%d) || "
+			"gid(%d) != set(%d)",
+			stat_buf.st_uid, set_uid,
+			stat_buf.st_gid, set_gid);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
-
-	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
-
-	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
-}
-
-static void fchownat_verify(const struct test_case_t *test)
-{
-	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
-		      getegid(), test->flag));
-
-	if (TEST_RETURN != test->exp_ret) {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() returned %ld, expected %d, errno=%d",
-			 TEST_RETURN, test->exp_ret, test->exp_errno);
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "fchownat() returned the expected errno %d: %s",
-			 test->exp_ret, strerror(test->exp_errno));
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+	SAFE_TOUCH(TESTFILE1, 0600, NULL);
+	SAFE_TOUCH(TESTFILE2, 0600, NULL);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0)
-		close(fd);
-
 	if (dir_fd > 0)
-		close(dir_fd);
-
-	tst_rmdir();
+		SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = fchownat_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
