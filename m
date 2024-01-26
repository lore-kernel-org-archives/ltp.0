Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF45DC47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 06:26:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 319CB3CE1AF
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 07:26:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48FA93CD3BC
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 07:25:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 595F020093F
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 07:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706250349; x=1737786349;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lVf8lwYDj0Vn7uDvC7NIMT2IqxsATKFh33lGTMunwT4=;
 b=B+qQXNEJpZlir9J51r+c3hALJxCqvZBWaDzI1FTNVhOLVwLPRzWkpnZk
 vxx/oTvgcgzd9J5pxy5WkIEuWd/iibi+mBFmjL4vnYgR/ZiJXYLR6HO1S
 k82t7NN4g2tdzrCusZZwae9IAMHwgtoMPBlB4FHvaEp11cicemm0czVIZ
 5MyZp1/deap5m/dxlpUVNcTGeT7SauexweyxEUa9JXCg0sBasXNclmFC6
 gpZXN4GeaZaNw0QFlPkPslJ17Y+5Y6G3ENSDh1iaPOqWaZsBqHwxaN8HA
 aU7DcFEUzmaWfnVVt8HoVtib8bHf/5XL3vUJSZZtJxU0GuTdTB/HP0Cv6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="126748995"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; d="scan'208";a="126748995"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 15:25:45 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 88652DC14B
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:25:42 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B16BDBDC8B
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:25:41 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 468A120059322
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:25:41 +0900 (JST)
Received: from irides.. (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id F157D1A006C
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 14:25:40 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 14:25:40 +0800
Message-Id: <20240126062540.2596279-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126062540.2596279-1-ruansy.fnst@fujitsu.com>
References: <20240126062540.2596279-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.005
X-TMASE-Result: 10--8.556400-10.000000
X-TMASE-MatchedRID: 8R18cQDv3dnyq/cli2hvDU7nLUqYrlslFIuBIWrdOeNrL/5mlYISizib
 ESY8R8hiQMOJEqjTDACExML3RSdglgU0om6w5sPzkYD8wAZKsSBr2qJoNIuCjf+aPQT1cxlGd93
 A76AVNsB34VOGRdhrB+vbgxb5qGOHA5/BSwKJDDGVd49c0zgWM79cAlQW5YprrblmM/aFaC+Trr
 +C1WNmxS/KXR4/4Lv6EC9CQs9quavsR84ORZreslVeGWZmxN2MHhysWPN3OzibKItl61J/yZ+in
 TK0bC9eKrauXd3MZDUb7Ul726xKAumeD8tsEd8opbhRvroerCtH8A8EzrwiS3T1+YGd0/3t
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] fchownat02: Convert to new API
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat02.c     | 133 +++++-------------
 1 file changed, 37 insertions(+), 96 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index 6dd1e024e..db8f662dc 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -1,135 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+ * Copyright (c) Linux Test Project, 2014-2024
  */
-/*
- * Test Description:
- *   Verify that,
+
+/*\
+ * [Description]
+ *
+ * Verify that,
  *   The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
  *   not be dereferenced if the pathname is a symbolic link.
  */
 
 #define _GNU_SOURCE
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
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
 
 static void setup(void)
 {
 	struct stat c_buf, l_buf;
 
-	tst_require_root();
-
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
-	SAFE_SYMLINK(cleanup, TESTFILE, TESTFILE_LINK);
-
-	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
-
-	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
+	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
+	SAFE_STAT(TESTFILE_LINK, &c_buf);
+	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
 
 	if (l_buf.st_uid == set_uid || l_buf.st_gid == set_gid) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "link_uid(%d) == set_uid(%d) or link_gid(%d) == "
-			 "set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
-			 set_gid);
+		tst_brk(TBROK | TERRNO,
+			"link_uid(%d) == set_uid(%d) or link_gid(%d) == "
+			"set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
+			set_gid);
 	}
 }
 
-static void fchownat_verify(void)
-{
-	TEST(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
-		      AT_SYMLINK_NOFOLLOW));
-
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "fchownat() failed, errno=%d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
-	} else {
-		test_verify();
-	}
-}
-
-static void test_verify(void)
+static void run(void)
 {
 	struct stat c_buf, l_buf;
 
-	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
+	TST_EXP_PASS_SILENT(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
+				     AT_SYMLINK_NOFOLLOW));
 
-	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
+	SAFE_STAT(TESTFILE_LINK, &c_buf);
+	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
 
 	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
 	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
-		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
+		tst_res(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
 	} else {
-		tst_resm(TFAIL,
-			 "fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
-			 "link_uid=%d set_uid=%d | gid=%d link_gid=%d "
-			 "set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
-			 c_buf.st_gid, l_buf.st_gid, set_gid);
+		tst_res(TFAIL,
+			"fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
+			"link_uid=%d set_uid=%d | gid=%d link_gid=%d set_gid=%d",
+			c_buf.st_uid, l_buf.st_uid, set_uid,
+			c_buf.st_gid, l_buf.st_gid, set_gid);
 	}
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
