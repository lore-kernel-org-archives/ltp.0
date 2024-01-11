Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDBAC47073
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 02:20:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F1A43CE4EF
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 03:20:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFCDC3C1CE0
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:19:58 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB5C810009B0
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:19:57 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="125173878"
X-IronPort-AV: E=Sophos;i="6.04,185,1695654000"; d="scan'208";a="125173878"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 11:19:56 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6866BCD6C4
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:19:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 983DDDAE87
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:19:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 31AD46B4F1
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:19:52 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E29A61A0072
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:19:51 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 11 Jan 2024 10:19:51 +0800
Message-Id: <20240111021951.1784735-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111021951.1784735-1-ruansy.fnst@fujitsu.com>
References: <20240110182913.GA1768734@pevik>
 <20240111021951.1784735-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28112.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28112.004
X-TMASE-Result: 10--12.210800-10.000000
X-TMASE-MatchedRID: NQO42YVKKvCH/OjJ1CEsvE7nLUqYrlslFIuBIWrdOeOU8ftiyKjZrXlb
 NLJMhGktx8cx3E6pg15WTBAeKqaX9Spe4ofkluPsiH95tLFH8edZ+CK+BxQ9k224tW2R9/7QDui
 v1PSTVn4QT82YoBmnzDFTm2Y2SkL+qFxsFrCmzTTTfU1/F+PbM6VjgXyvS9c/592Swrd60Unr5/
 zvfXByhRczzmUKaAg4ChtHDYUVfz5jc4vsClPvE6Ul1aQUvopW9avse85ISVrMB0kPsl40w4L+H
 Y1rw++wq/t8RQsHcFTQBJymlx/WEbCuDuYv1cxahdD+G7U5X/T4uJ1REX4MHYELcwIQurOoiERa
 Zd+PxAHi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq9dxhi1jC2DlPYIAT3/Ipu3x1AXiqvt4t0Vr4B
 ZbPkr0V7PYz3ErGUl
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] dup07: Convert to new API
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
 testcases/kernel/syscalls/dup/dup07.c | 173 +++++++-------------------
 1 file changed, 44 insertions(+), 129 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup07.c b/testcases/kernel/syscalls/dup/dup07.c
index a100f5d58..fd7792133 100644
--- a/testcases/kernel/syscalls/dup/dup07.c
+++ b/testcases/kernel/syscalls/dup/dup07.c
@@ -1,142 +1,57 @@
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
+ * Ported from SPIE, section2/iosuite/dup3.c, by Airong Zhang
+ * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2003-2024
  */
 
-/*
-  WHAT:  Is the access mode the same for both file descriptors?
-          0: read only?
-          1: write only?
-          2: read/write?
-  HOW:   Creat a file with each access mode; dup each file descriptor;
-         stat each file descriptor and compare mode of each pair
-*/
-
-#include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
+/*\
+ * [Description]
+ *
+ * Verify that the file descriptor created by dup(2) syscall has the same
+ * access mode as the old one.
+ */
 
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
-		} else {
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
-		}
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
+		if (oldbuf.st_mode != dupbuf.st_mode)
+			tst_res(TFAIL, "%s and dup do not match", tc->mode_desc);
+		else
+			tst_res(TPASS, "Passed in %s mode.", tc->mode_desc);
+
+		SAFE_CLOSE(dupfd);
 	}
+	SAFE_CLOSE(oldfd);
 
-	cleanup();
-	tst_exit();
+	SAFE_UNLINK(testfile);
 }
 
-static void setup(void)
-{
-	tst_tmpdir();
-}
-
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
