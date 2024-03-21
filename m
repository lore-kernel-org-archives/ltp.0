Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599CCC54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711016026; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=89MzoOvdQn+b++0fmQ4W/l2XVDY+q/PzOK39AoY3BAc=;
 b=CV9EJkdvsrB27EB35mZYsXJCiYqP3JzPP8pZ/7D92cHI/1bJnAhzOU80hS86b2o3TgVP5
 cUzqHkyKMUW7/zT7omQmeva1OwPz8miS8ef/kgaqHcikXxMLzLW9mDiY+ZeXUUNdrOj7luM
 WGLqKQ8puB6vKKWFSL5UDdit+V42eso=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42043CFBBB
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 11:13:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C383CB289
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 11:13:25 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 824D01400164
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 11:13:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711016004; x=1742552004;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Dhl7eG4mi4eX5/FNuqnlL4Ts1xSCVcAIYTXDIlE68O0=;
 b=MaAJNn/PnwZjhIGS7BOD1kFWRUxHiQKhEGMhVdSn4pNTjjGWTRPGrHTh
 Q7F+32MRSTg4FmPQsRdlBcV1WBx+tm6AOXc3GVLL1iq9jgeZbfkZgLPoh
 okkTPan8zWvwj/Om8c1mBSlzSix/ZF2KUHsqeZ18XN+Lpwrg4nXLdHhPq
 afoPBi5fn1JTlNi7Fg8uW8qtxAjwjUkgXkF4RpCIftpHJvErav9luLDa9
 qAxga+YLqWdrNp6QIY21jRm5mlxr4xcDz33catAlCuCym8vf+E3Z1CG6H
 L3IEQFX8+OIGt/iY99OLKzBxt37g6fSVLX7sC9AbEf2hh7lvVJUxv+dTy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="152887960"
X-IronPort-AV: E=Sophos;i="6.07,142,1708354800"; d="scan'208";a="152887960"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 19:13:21 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D57CC21A4
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:13:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AC81106CB2
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:13:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DB65020098E21
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 19:13:17 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 678421A006B
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 18:13:17 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 21 Mar 2024 18:13:17 +0800
Message-Id: <20240321101317.3840699-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
References: <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28264.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28264.006
X-TMASE-Result: 10--15.944200-10.000000
X-TMASE-MatchedRID: +CEtI/x1ZGbyq/cli2hvDU7nLUqYrlslFIuBIWrdOeNrL/5mlYISizib
 ESY8R8hiQMOJEqjTDACExML3RSdglkobO+54PiwGzfqlpbtmcWgjj7vsWFoKJVBlq5zqMfbIXKR
 lcbNFm4VzaEDCnhZCKOVSqAnChoNGLOxS5plkCO2RgPzABkqxIJ+Z30eyNnRTTPm/MsQarwO+Yp
 N3FsaosvJmcSXS3R6787nu31iyiq28gZlQTTVSpkz7FUUjXG1jmGrGwE7uWstHpEd1UrzmFcvUB
 RfNgv+CfCx6K1iYRP1xqEY2j6cWqS+3xqQ44pFWzr16YOzjZ10YH39vFLryE5sgafD1fXNhqCgi
 pHiRLo6IAwwM2kIVLF2WVzVdeoHbz39Q5AO5oKmYh7QjWI3JDJOOVzRd/XVO9EdQ8iIYu4C/jz9
 RTmfNFP3eQDUiYD5gY8pCBshfjK43KXWd30Ii3RRFJJyf5BJerSFs54Y4wbX6C0ePs7A07QKmAR
 N5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] getxattr01: Convert to new API
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
 .../kernel/syscalls/getxattr/getxattr01.c     | 196 +++++-------------
 1 file changed, 54 insertions(+), 142 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index cec802a33..4db5456b0 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -1,142 +1,64 @@
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
- * There are 4 test cases:
+ * There are 3 test cases:
+ *
  * 1. Get an non-existing attribute,
  *    getxattr(2) should return -1 and set errno to ENODATA
  * 2. Buffer size is smaller than attribute value size,
  *    getxattr(2) should return -1 and set errno to ERANGE
- * 3. Get attribute, getxattr(2) should succeed
- * 4. Verify the attribute got by getxattr(2) is same as the value we set
+ * 3. Get attribute, getxattr(2) should succeed, and the attribute got by
+ *    getxattr(2) should be same as the value we set
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
-#ifdef HAVE_SYS_XATTR_H
-# include <sys/xattr.h>
-#endif
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "getxattr01";
+#include "tst_test.h"
+#include <sys/xattr.h>
 
-#ifdef HAVE_SYS_XATTR_H
-#define XATTR_TEST_KEY "user.testkey"
-#define XATTR_TEST_VALUE "this is a test value"
-#define XATTR_TEST_VALUE_SIZE 20
-#define BUFFSIZE 64
+#define XATTR_TEST_NOKEY	"user.nosuchkey"
+#define XATTR_TEST_KEY		"user.testkey"
+#define XATTR_TEST_VALUE	"this is a test value"
+#define XATTR_TEST_VALUE_SIZE	20
+#define BUFFSIZE		64
 
-static void setup(void);
-static void cleanup(void);
+static char filename[BUFSIZ];
 
-char filename[BUFSIZ];
-
-struct test_case {
-	char *fname;
+static struct tcase {
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
+	{ .key = XATTR_TEST_NOKEY, .size = BUFFSIZE - 1, .exp_err = ENODATA },
+	{ .key = XATTR_TEST_KEY, .size = 1, .exp_err = ERANGE },
+	{ .key = XATTR_TEST_KEY, .size = BUFFSIZE - 1 },
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
+	struct tcase *tc = &tcases[n];
+
+	if (tc->exp_err == 0) {
+		TST_EXP_VAL(getxattr(filename, tc->key, tc->value, tc->size),
+			    XATTR_TEST_VALUE_SIZE);
+		if (memcmp(tc->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
+			tst_res(TFAIL, "Wrong value, expect '%s' got '%s'",
+				XATTR_TEST_VALUE, tc->value);
 		else
-			tst_resm(TPASS, "Got the right value");
+			tst_res(TPASS, "getxattr() retrieved expected value");
+	} else {
+		TST_EXP_FAIL(getxattr(filename, tc->key, tc->value, tc->size),
+			     tc->exp_err);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
@@ -144,41 +66,31 @@ static void setup(void)
 	int fd;
 	unsigned int i;
 
-	tst_require_root();
-
-	tst_tmpdir();
-
 	/* Create test file and setup initial xattr */
 	snprintf(filename, BUFSIZ, "getxattr01testfile");
-	fd = SAFE_CREAT(cleanup, filename, 0644);
-	close(fd);
-	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
-		     strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
-		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
-				 "mount without user_xattr option");
-		}
-	}
+	fd = SAFE_CREAT(filename, 0644);
+	SAFE_CLOSE(fd);
 
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
-}
-#else /* HAVE_SYS_XATTR_H */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++)
+		free(tcases[i].value);
 }
-#endif
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
