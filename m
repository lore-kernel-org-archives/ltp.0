Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B73C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737016842; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=LhbHV7WDg6IiunWQaTLyMlZurvQsZYsaeDOHf21h1RE=;
 b=GDpjmk3tF07jkRV02cADbKkk+ne5O7pRzFphJGHY4rd5Jfv6Zr7aiLG/2b/z6nzTBYS0z
 jEqe/OyQxCqeuVv9fZz0TFJsK0zxIkJUPeiDL9BnIxAhk3O0mQsgq4DcDJ4AZhSXpyQQV6N
 uXf+XvrTuutH4354OPguhdaWfpccjh8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2BA83C7B99
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:40:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B133C7827
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:40:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E288414225A2
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737016819; x=1768552819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hriHyRw/Q7xlad6WPFlY4zaA8K1zjuxcx9h9fgHpf5c=;
 b=p6qTdEai/G00XM4yyFgzrzRipelV6tKfnv/0H+vkriR93o7NVoysX6Qj
 Dz39sOAYV7QrPsAlDG1Qkivvb3ANIaU/LzPYRebx5NEyEZ8vKKvA4d0Gq
 cVWJp+yC/DPsKRPOx6LwF2usFiBdVH9f6TKqkPXegPPxdfrXkFfjkTNWH
 VWzT1RghcrxpLxD//UB+Ws4fuSxzC/26mbwpJFUVAmqVSE5qhn8jEjQSn
 KG64w6B8+r+vaQHJi7jG2pUsX4aMYxftbkrwn+u4zfVnZXCxAd8w3y46C
 wzhelhx7BsuS5LeCGfywL7rAl0sj4fYw8q3WWPkruJudRTYa3fguDSLTb A==;
X-CSE-ConnectionGUID: qViTl9ihR1upn1YsftuFpg==
X-CSE-MsgGUID: nm6GVIqvSc+DEw7Uq18bkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="174741047"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; d="scan'208";a="174741047"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 17:40:17 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CC58E8523
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 63EF0D0905
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E2C7C6B9AD
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:14 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 751FE1A0074;
 Thu, 16 Jan 2025 16:40:14 +0800 (CST)
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com,
	pvorel@suse.cz
Date: Thu, 16 Jan 2025 16:40:12 +0800
Message-ID: <20250116084013.503341-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.006
X-TMASE-Result: 10--9.031900-10.000000
X-TMASE-MatchedRID: asSAQPhJDBvyq/cli2hvDU7nLUqYrlslFIuBIWrdOeNrL/5mlYISizib
 ESY8R8hiQMOJEqjTDACExML3RSdglgU0om6w5sPzkYD8wAZKsSBr2qJoNIuCjf+aPQT1cxlGd93
 A76AVNsDDKKXtpTQT/sXFiwp0ACd2ziy8MZTDuT2lJdWkFL6KVvWr7HvOSElanIbVnspHA4rmn1
 MY2amWUUPHgqX8A7utGoq5PC0a+a3ijhzYaH7Q4xMxKDqgAFSzjkDrBOJwwnQxkLdkW7C5qtn/o
 cIR7L314vM1YF6AJbbCCfuIMF6xLd934/rDAK3zhG2qikEpQGUnCa5yvIApnWUOrfoAYGmHrVuJ
 vH9fJcQSqK+kndKB3sr440oZgDYM
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] fchownat02: Convert to new API
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
 .../kernel/syscalls/fchownat/fchownat02.c     | 138 ++++--------------
 1 file changed, 32 insertions(+), 106 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index 6dd1e024e..10b4f5e3c 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -1,135 +1,61 @@
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
+ * Copyright (c) Linux Test Project, 2014-2025
  */
-/*
- * Test Description:
- *   Verify that,
- *   The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
- *   not be dereferenced if the pathname is a symbolic link.
+
+/*\
+ * [Description]
+ *
+ * Verify that fchownat() will operate on symbolic links when
+ * AT_SYMLINK_NOFOLLOW is used.
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
+		tst_brk(TBROK,
+			"uid link(%d) == set(%d) or gid link(%d) == set(%d)",
+			l_buf.st_uid, set_uid, l_buf.st_gid, set_gid);
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
+	TST_EXP_PASS(fchownat(AT_FDCWD, TESTFILE_LINK, set_uid, set_gid, AT_SYMLINK_NOFOLLOW),
+		     "fchownat(%d, %s, %d, %d, %d)",
+		     AT_FDCWD, TESTFILE_LINK, set_uid, set_gid, AT_SYMLINK_NOFOLLOW);
 
-	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
+	SAFE_STAT(TESTFILE_LINK, &c_buf);
+	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
 
-	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
-	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
-		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
-	} else {
-		tst_resm(TFAIL,
-			 "fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
-			 "link_uid=%d set_uid=%d | gid=%d link_gid=%d "
-			 "set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
-			 c_buf.st_gid, l_buf.st_gid, set_gid);
-	}
+	TST_EXP_EXPR(c_buf.st_uid != set_uid && l_buf.st_uid == set_uid,
+		     "fchownat() correctly operated on symlink user ID");
+	TST_EXP_EXPR(c_buf.st_gid != set_gid && l_buf.st_gid == set_gid,
+		     "fchownat() correctly operated on symlink group ID");
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
