Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE08C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 16:12:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844483CE24B
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 17:12:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2093C99B6
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 17:12:08 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 712F310005FB
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 17:12:06 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="146617701"
X-IronPort-AV: E=Sophos;i="6.05,210,1701097200"; d="scan'208";a="146617701"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 01:12:04 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C41ADD3EA9
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id F267ECFB6D
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 77B5322EAEF
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:00 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 28A061A015F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 00:12:00 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 00:11:59 +0800
Message-Id: <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121161159.4106646-1-ruansy.fnst@fujitsu.com>
References: <20240121161159.4106646-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28134.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28134.000
X-TMASE-Result: 10--15.455300-10.000000
X-TMASE-MatchedRID: +CEtI/x1ZGbyq/cli2hvDU7nLUqYrlslFIuBIWrdOeNrL/5mlYISizib
 ESY8R8hiQMOJEqjTDACExML3RSdglkobO+54PiwGzfqlpbtmcWgjj7vsWFoKJVBlq5zqMfbIXKR
 lcbNFm4VzaEDCnhZCKOVSqAnChoNGLOxS5plkCO2RgPzABkqxIJ+Z30eyNnRTTPm/MsQarwO+Yp
 N3FsaosvJmcSXS3R672ba8my9z2q3EJl9JO3abaSoiRKlBVkYIjlRp8uau9oZP3Eb4+bLT+j3vM
 QJZlrWj+AKG3VQemT2Ikpm0xikifj+7nvNv6fe6+GYt8f/VhTsyLlxWhS9T9mFHVj+6F+rIqswZ
 Nzn0DJCEdOGB6wv49h84WfmE/WgvhVgj6N6wwHDRCUFHAmq1Iyxhn4W9FFDdbobCYBj8BS+/jz9
 RTmfNFP3eQDUiYD5gY8pCBshfjK43KXWd30Ii3RRFJJyf5BJerSFs54Y4wbX6C0ePs7A07cNbTF
 VOzjU8rt99qDwi8mkgvyivFAhkA8vQ2KRNTDeUPAfC7yrPwY8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] getxattr01: Convert to new API
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
 .../kernel/syscalls/getxattr/getxattr01.c     | 188 ++++++------------
 1 file changed, 61 insertions(+), 127 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index cec802a33..e11f00d46 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -1,28 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2011  Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * Copyright (c) Linux Test Project, 2012-2024
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Basic tests for getxattr(2) and make sure getxattr(2) handles error
  * conditions correctly.
  *
@@ -35,22 +19,11 @@
  * 4. Verify the attribute got by getxattr(2) is same as the value we set
  */
 
-#include "config.h"
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
+#include "tst_test.h"
 #ifdef HAVE_SYS_XATTR_H
 # include <sys/xattr.h>
 #endif
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "getxattr01";
 
 #ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
@@ -58,85 +31,51 @@ char *TCID = "getxattr01";
 #define XATTR_TEST_VALUE_SIZE 20
 #define BUFFSIZE 64
 
-static void setup(void);
-static void cleanup(void);
-
-char filename[BUFSIZ];
+static char filename[BUFSIZ];
 
-struct test_case {
+static struct tcase {
 	char *fname;
 	char *key;
 	char *value;
 	size_t size;
 	int exp_err;
-};
-struct test_case tc[] = {
-	{			/* case 00, get non-existing attribute */
-	 .fname = filename,
-	 .key = "user.nosuchkey",
-	 .value = NULL,
-	 .size = BUFFSIZE - 1,
-	 .exp_err = ENODATA,
-	 },
-	{			/* case 01, small value buffer */
-	 .fname = filename,
-	 .key = XATTR_TEST_KEY,
-	 .value = NULL,
-	 .size = 1,
-	 .exp_err = ERANGE,
-	 },
-	{			/* case 02, get existing attribute */
-	 .fname = filename,
-	 .key = XATTR_TEST_KEY,
-	 .value = NULL,
-	 .size = BUFFSIZE - 1,
-	 .exp_err = 0,
-	 },
+} tcases[] = {
+	/* case 00, get non-existing attribute */
+	{ filename, "user.nosuchkey", NULL, BUFFSIZE - 1, ENODATA },
+	/* case 01, small value buffer */
+	{ filename, XATTR_TEST_KEY, NULL, 1, ERANGE },
+	/* case 02, get existing attribute */
+	{ filename, XATTR_TEST_KEY, NULL, BUFFSIZE - 1, 0 },
 };
 
-int TST_TOTAL = sizeof(tc) / sizeof(tc[0]) + 1;
-
-int main(int argc, char *argv[])
+static void run(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < (int)ARRAY_SIZE(tc); i++) {
-			TEST(getxattr(tc[i].fname, tc[i].key, tc[i].value,
-				      tc[i].size));
-
-			if (TEST_ERRNO == tc[i].exp_err) {
-				tst_resm(TPASS | TTERRNO, "expected behavior");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
-					 "- expected errno %d - Got",
-					 tc[i].exp_err);
-			}
-		}
-
-		if (TEST_RETURN != XATTR_TEST_VALUE_SIZE) {
-			tst_resm(TFAIL,
-				 "getxattr() returned wrong size %ld expected %d",
-				 TEST_RETURN, XATTR_TEST_VALUE_SIZE);
-			continue;
-		}
-
-		if (memcmp(tc[i - 1].value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
-			tst_resm(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
-				 XATTR_TEST_VALUE, tc[i - 1].value);
-		else
-			tst_resm(TPASS, "Got the right value");
+	struct tcase *tc = &tcases[n];
+
+	TEST(getxattr(tc->fname, tc->key, tc->value, tc->size));
+	if (TST_ERR == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "expected behavior");
+	} else {
+		tst_res(TFAIL | TTERRNO, "unexpected behavior"
+			"- expected errno %d - Got",
+			tc->exp_err);
 	}
 
-	cleanup();
-	tst_exit();
+	/* The last check:
+	 *  Verify the attribute got by getxattr(2) is same as the value we set
+	 */
+	if (n == ARRAY_SIZE(tcases) - 1) {
+		if (TST_RET != XATTR_TEST_VALUE_SIZE)
+			tst_res(TFAIL,
+				"getxattr() returned wrong size %ld expected %d",
+				TST_RET, XATTR_TEST_VALUE_SIZE);
+
+		if (memcmp(tc->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
+			tst_res(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
+					XATTR_TEST_VALUE, tc->value);
+		else
+			tst_res(TPASS, "Got the right value");
+	}
 }
 
 static void setup(void)
@@ -144,41 +83,36 @@ static void setup(void)
 	int fd;
 	unsigned int i;
 
-	tst_require_root();
-
-	tst_tmpdir();
-
 	/* Create test file and setup initial xattr */
 	snprintf(filename, BUFSIZ, "getxattr01testfile");
-	fd = SAFE_CREAT(cleanup, filename, 0644);
+	fd = SAFE_CREAT(filename, 0644);
 	close(fd);
-	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
-		     strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
-		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
-				 "mount without user_xattr option");
-		}
-	}
 
-	/* Prepare test cases */
-	for (i = 0; i < ARRAY_SIZE(tc); i++) {
-		tc[i].value = malloc(BUFFSIZE);
-		if (tc[i].value == NULL) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Cannot allocate memory");
-		}
-	}
+	SAFE_SETXATTR(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+		      strlen(XATTR_TEST_VALUE), XATTR_CREATE);
 
-	TEST_PAUSE;
+	for (i = 0; i < ARRAY_SIZE(tcases); i++)
+		tcases[i].value = SAFE_MALLOC(BUFFSIZE);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++)
+		if (tcases[i].value != NULL)
+			free(tcases[i].value);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
+
 #else /* HAVE_SYS_XATTR_H */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
-}
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
