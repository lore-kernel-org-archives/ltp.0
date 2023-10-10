Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DA2CD68EC
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 05:29:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8A533C2DA4
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 07:29:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96D693CD667
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 07:28:49 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C3C1200A1F
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 07:28:47 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="123745605"
X-IronPort-AV: E=Sophos;i="6.03,211,1694703600"; d="scan'208";a="123745605"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2023 14:28:45 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 17D69CD7E3
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 14:28:43 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3BBD8D5010
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 14:28:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D4DE56B4CE
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 14:28:41 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8E7331A0072;
 Tue, 10 Oct 2023 13:28:41 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 10 Oct 2023 13:28:28 +0800
Message-Id: <1696915709-6304-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27926.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27926.005
X-TMASE-Result: 10--7.651400-10.000000
X-TMASE-MatchedRID: nybEIMbK/e3yq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxULiR
 FJnWDxkl6AvNUUvmjHZWTBAeKqaX9Spe4ofkluPsqug9vIA2WODZobCTg4s1LNodkNYFbOrOd93
 A76AVNsB34VOGRdhrB+vbgxb5qGOHA5/BSwKJDDGVd49c0zgWM79cAlQW5YprrblmM/aFaC+Trr
 +C1WNmxS/KXR4/4Lv6EC9CQs9quavxwBnpUKCN8ovefyp1glN0fS0Ip2eEHnz3IzXlXlpamPoLR
 4+zsDTtH/zyL+gBqiz/3AHWg+yiHODVA73OkmBtPC6ogX+UTBJSJJUUwHA3Ig==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/fchownat02: Convert to new API
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat02.c     | 134 ++++++------------
 1 file changed, 40 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index c39b0a919..6ed530a3b 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -1,96 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
+ * Copyright (c) Linux Test Project, 2003-2023
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.
- */
-/*
- * Test Description:
- *   Verify that,
- *   The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
- *   not be dereferenced if the pathname is a symbolic link.
  */
 
-#define _GNU_SOURCE
+/*\
+ * [Description]
+ *
+ * Verify that,
+ * The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
+ * not be dereferenced if the pathname is a symbolic link.
+ */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "fchownat.h"
-#include "lapi/fcntl.h"
+#include "tst_test.h"
 
 #define TESTFILE	"testfile"
 #define TESTFILE_LINK	"testfile_link"
 
-char *TCID = "fchownat02";
-int TST_TOTAL = 1;
-
 static int dir_fd;
 static uid_t set_uid = 1000;
 static gid_t set_gid = 1000;
-static void setup(void);
-static void cleanup(void);
-static void test_verify(void);
-static void fchownat_verify(void);
-
-int main(int ac, char **av)
-{
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
-			fchownat_verify();
-	}
-
-	cleanup();
-	tst_exit();
-}
+static struct stat c_buf, l_buf;
 
 static void setup(void)
 {
-	struct stat c_buf, l_buf;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
 
-	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
 
-	SAFE_SYMLINK(cleanup, TESTFILE, TESTFILE_LINK);
+	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
 
-	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
+	SAFE_STAT(TESTFILE_LINK, &c_buf);
 
-	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
+	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
 
 	if (l_buf.st_uid == set_uid || l_buf.st_gid == set_gid) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "link_uid(%d) == set_uid(%d) or link_gid(%d) == "
 			 "set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
 			 set_gid);
@@ -99,38 +46,37 @@ static void setup(void)
 
 static void fchownat_verify(void)
 {
-	TEST(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
-		      AT_SYMLINK_NOFOLLOW));
+	TST_EXP_POSITIVE(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
+			 AT_SYMLINK_NOFOLLOW), "fchownat(%d, %s, %d, %d, "
+			 "AT_SYMLINK_NOFOLLOW)",
+			 dir_fd, TESTFILE_LINK, set_uid, set_gid);
 
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "fchownat() failed, errno=%d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-	} else {
-		test_verify();
-	}
-}
+	SAFE_STAT(TESTFILE_LINK, &c_buf);
 
-static void test_verify(void)
-{
-	struct stat c_buf, l_buf;
-
-	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
-
-	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
+	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
 
 	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
-	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
-		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
+		c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
+		tst_res(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
 	} else {
-		tst_resm(TFAIL,
-			 "fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
-			 "link_uid=%d set_uid=%d | gid=%d link_gid=%d "
-			 "set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
-			 c_buf.st_gid, l_buf.st_gid, set_gid);
+		tst_res(TFAIL,
+			"fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
+			"link_uid=%d set_uid=%d | gid=%d link_gid=%d "
+			"set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
+			c_buf.st_gid, l_buf.st_gid, set_gid);
 	}
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	if (dir_fd > -1)
+		close(dir_fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = fchownat_verify,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
