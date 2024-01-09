Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1730C47073
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 10:27:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 333823CE504
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 11:27:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F8833CD0F8
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 11:27:09 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91008140111E
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 11:27:07 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="145568551"
X-IronPort-AV: E=Sophos;i="6.04,182,1695654000"; d="scan'208";a="145568551"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 19:27:07 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C440AD618B
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 19:27:03 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0742012E97D
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 19:27:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 84EE82008631E
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 19:27:02 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 29D421A0070
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:27:02 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jan 2024 18:27:01 +0800
Message-Id: <20240109102701.812960-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109095026.792527-1-ruansy.fnst@fujitsu.com>
References: <20240109095026.792527-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28108.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28108.006
X-TMASE-Result: 10--14.321800-10.000000
X-TMASE-MatchedRID: DUsWLlwCIVCH/OjJ1CEsvE7nLUqYrlslFIuBIWrdOeOU8ftiyKjZrXlb
 NLJMhGktx8cx3E6pg15WTBAeKqaX9Spe4ofkluPsiH95tLFH8edZ+CK+BxQ9k224tW2R9/7QDui
 v1PSTVn4QT82YoBmnzDFTm2Y2SkL+XhvAA0pOb6LNgrlT5Ajc7jEvENg7dSUMycmFNidOeD02rz
 KWrdiyknui8opdVfyWLCfCG45dNV3iATtmJziXsxMxKDqgAFSzv1wCVBblimutuWYz9oVoL5/p6
 742jA2BoIP+VSYj94JX2cPw5LGAfdWKNmKtnvU1i95/KnWCU3RULRRq00o2mZsoi2XrUn/Jn6Kd
 MrRsL14qtq5d3cxkNQ9lVMtVBr0ZS/gzYjX2Sa5yx2SSeH+2LQCN01beODRgdKdkMyLayNA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] dup07: Convert to new API
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
 testcases/kernel/syscalls/dup/dup07.c | 160 +++++++-------------------
 1 file changed, 41 insertions(+), 119 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup07.c b/testcases/kernel/syscalls/dup/dup07.c
index a100f5d58..bccee0776 100644
--- a/testcases/kernel/syscalls/dup/dup07.c
+++ b/testcases/kernel/syscalls/dup/dup07.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
- *    ported from SPIE, section2/iosuite/dup3.c, by Airong Zhang
- *   Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
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
+ * Copyright (c) International Business Machines  Corp., 2002
+ *  ported from SPIE, section2/iosuite/dup3.c, by Airong Zhang
+ * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
  */
 
 /*
@@ -27,116 +13,52 @@
   HOW:   Creat a file with each access mode; dup each file descriptor;
          stat each file descriptor and compare mode of each pair
 */
+/*\
+ * [Description]
+ *
+ * Verify that the file descriptor created by dup(2) syscall has the same
+ * access mode as the old one.
+ */
 
-#include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
-
-char *TCID = "dup07";
-int TST_TOTAL = 3;
+#include "tst_test.h"
 
 static const char *testfile = "dup07";
 
-static void setup(void);
-static void cleanup(void);
+static struct tcase {
+	char *mode_desc;
+	int mode;
+} tcases[] = {
+	{"read only", 0444},
+	{"write only", 0222},
+	{"read/write", 0666},
+};
 
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
-	struct stat retbuf;
-	struct stat dupbuf;
-	int rdoret, wroret, rdwret;
-	int duprdo, dupwro, duprdwr;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		if ((rdoret = creat(testfile, 0444)) == -1) {
-			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
+	int oldfd, dupfd;
+	struct stat oldbuf, dupbuf;
+	struct tcase *tc = &tcases[n];
+
+	oldfd = SAFE_CREAT(testfile, tc->mode);
+	dupfd = TST_EXP_FD_SILENT(dup(oldfd), "dup() %s file", tc->mode_desc);
+	if (TST_PASS) {
+		SAFE_FSTAT(oldfd, &oldbuf);
+		SAFE_FSTAT(dupfd, &dupbuf);
+
+		if (oldbuf.st_mode != dupbuf.st_mode) {
+			tst_res(TFAIL, "%s and dup do not match", tc->mode_desc);
 		} else {
-			if ((duprdo = dup(rdoret)) == -1) {
-				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
-			} else {
-				fstat(rdoret, &retbuf);
-				fstat(duprdo, &dupbuf);
-				if (retbuf.st_mode != dupbuf.st_mode) {
-					tst_resm(TFAIL,
-						 "rdonly and dup do not match");
-				} else {
-					tst_resm(TPASS,
-					         "Passed in read mode.");
-				}
-				close(duprdo);
-			}
-			close(rdoret);
+			tst_res(TPASS, "Passed in %s mode.", tc->mode_desc);
 		}
-
-		unlink(testfile);
-		
-		if ((wroret = creat(testfile, 0222)) == -1) {
-			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
-		} else {
-			if ((dupwro = dup(wroret)) == -1) {
-				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
-			} else {
-				fstat(wroret, &retbuf);
-				fstat(dupwro, &dupbuf);
-				if (retbuf.st_mode != dupbuf.st_mode) {
-					tst_resm(TFAIL,
-						 "wronly and dup do not match");
-				} else {
-					tst_resm(TPASS,
-					         "Passed in write mode.");
-				}
-				close(dupwro);
-			}
-			close(wroret);
-
-		}
-
-		unlink(testfile);
-
-		if ((rdwret = creat(testfile, 0666)) == -1) {
-			tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
-		} else {
-			if ((duprdwr = dup(rdwret)) == -1) {
-				tst_resm(TFAIL, "Unable to dup '%s'", testfile);
-			} else {
-				fstat(rdwret, &retbuf);
-				fstat(duprdwr, &dupbuf);
-				if (retbuf.st_mode != dupbuf.st_mode) {
-					tst_resm(TFAIL,
-						 "rdwr and dup do not match");
-				} else {
-					tst_resm(TPASS,
-					         "Passed in read/write mode.");
-				}
-				close(duprdwr);
-			}
-			close(rdwret);
-		}
-		
-		unlink(testfile);
+		SAFE_CLOSE(dupfd);
 	}
+	SAFE_CLOSE(oldfd);
 
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_tmpdir();
+	SAFE_UNLINK(testfile);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
