Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65104C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736932413; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mnNlQ3AzO1CqVm7EzUgwXn1pH+cqJZi/+HbERHt5r7o=;
 b=BPhYubGLfiOtMQpY0jzmI7ZYS8AQlx0Gev7fZoLh13g/9nIxzAnaTN9J+v/x6Gfu3IvLf
 aWMN2XpKUrMABBC2c3OveKrPXLKhkdsZCzggtTbXaoLll04QFqIbCc0FcXCiq47UWro4G12
 qYmwePTlvDZBrwEv8e/5+X85EX7eaDw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3BF93C7B5E
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:13:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF5C63C7A3C
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:12:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2CFC9141555E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736932344; x=1768468344;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/8Mcbb+6jPfvHHwXEL5AFxAFS9C8bedoK6Hes4x5C3s=;
 b=RfeEwwlcXZJOChIJcEJ4QNQF8A09Lq0+bz+bbPEbtnmIR9a+TaOBuvVW
 OEVDoPl3P60uPD8GT9hD9xyKBLFPSxUJ5SwQw+HczeVpXCGf7kMYeaWoI
 XJXUKr0L9eBJSMkWaPfbXVXVCdxh0qV4gX/0mfkajSIFo25ScNnOT4L3G
 0/6eNIyN5JOSDRFxtIiA0hVH0ApUQirET3gdCagdYBvLd41gl7zl/7Hh+
 56IhKPPze32AywCrmnTbfF16Z4q8XP9gKh4KjNWX4bkb0r9XXsXtLMyVj
 Na52MgECw/naRYz5oyAm6PB2ph7QJ+F4yAaB+zpvuM+shK6ATc5YbqV9g g==;
X-CSE-ConnectionGUID: DFQ6Js29TeuJEGOlOdbH+w==
X-CSE-MsgGUID: 3Xuyj5kQTsGBT5LTRyQMIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="165499721"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; d="scan'208";a="165499721"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 18:12:21 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 45B87E6148
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 15D68BDC87
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A71FC20071A37
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 18:12:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 422A01A0071;
 Wed, 15 Jan 2025 17:12:19 +0800 (CST)
To: ltp@lists.linux.it,
	liwang@redhat.com
Date: Wed, 15 Jan 2025 17:12:17 +0800
Message-ID: <20250115091218.2630891-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
References: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.006
X-TMASE-Result: 10--8.233700-10.000000
X-TMASE-MatchedRID: 8R18cQDv3dnyq/cli2hvDU7nLUqYrlslFIuBIWrdOeNrL/5mlYISizib
 ESY8R8hiQMOJEqjTDADuNT8xdcEnQ5LaPACgg26O194/5X9VfCx0bXWCb2qGLhd+xtxH8FsxxH8
 MA9IoRM934VOGRdhrB+vbgxb5qGOHA5/BSwKJDDGVd49c0zgWM79cAlQW5YprrblmM/aFaC+Trr
 +C1WNmxS/KXR4/4Lv6EC9CQs9quavsR84ORZresovefyp1glN0fS0Ip2eEHnz3IzXlXlpamPoLR
 4+zsDTthUfR2rvBju7hrbidVvQoxU1qBXXL5B6SOtcYPJknCfeY7rpZg0lJ4qIUwiD7vcgW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] fchownat02: Convert to new API
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat02.c     | 132 +++++-------------
 1 file changed, 33 insertions(+), 99 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index 6dd1e024e..d8e4e0cfe 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -1,135 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * Copyright (c) Linux Test Project, 2014-2025
+ */
+
+/*\
+ * [Description]
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * Verify that:
  *
- * You should have received a copy of the GNU General Public License along
- * with this program.
- */
-/*
- * Test Description:
- *   Verify that,
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
-static int dir_fd;
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
+	TST_EXP_PASS_SILENT(fchownat(AT_FDCWD, TESTFILE_LINK, set_uid, set_gid,
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
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
