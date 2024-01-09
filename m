Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADDC46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 09:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8F313CE511
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 10:50:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C581D3CD1B9
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 10:50:34 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA6296008A0
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 10:50:32 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="145417047"
X-IronPort-AV: E=Sophos;i="6.04,182,1695654000"; d="scan'208";a="145417047"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 18:50:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4F5ECD2B2D
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:50:28 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 73213D5014
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:50:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B56F2007C3E6
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:50:27 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 976B61A0070
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 17:50:26 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jan 2024 17:50:26 +0800
Message-Id: <20240109095026.792527-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28108.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28108.006
X-TMASE-Result: 10--6.799900-10.000000
X-TMASE-MatchedRID: qmqewXN7IpiH/OjJ1CEsvE7nLUqYrlslFIuBIWrdOeOU8ftiyKjZrXlb
 NLJMhGktx8cx3E6pg15WTBAeKqaX9Spe4ofkluPsiH95tLFH8edZ+CK+BxQ9k224tW2R9/7QDui
 v1PSTVn4QT82YoBmnzDFTm2Y2SkL+0eczgee7i1O5x7uAXGEprQRryDXHx6oXS7NxD4SLUR1FmB
 b8AoJ5yoTei6L3bqINd3Jxd2GlC9SGAgWc66O+H5V3j1zTOBYz+LidURF+DB0foSOaijzG1oL+H
 Y1rw++wq/t8RQsHcFTH6+B60Ji4pUUZABEzaC4/VV4ZZmbE3YyBs03RHrzjM1QuGn5b9r2Z2f+h
 whHsvfXi8zVgXoAltsZfJcPORGlUC24oEZ6SpSkj80Za3RRg8BiQU8vakiTsDm0/gjdFxLjvSnQ
 uKnyQrM7Mqkyenj9SJs421rzWBfk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] dup06: Convert to new API
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
 testcases/kernel/syscalls/dup/dup06.c | 141 ++++++++++----------------
 1 file changed, 52 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup06.c b/testcases/kernel/syscalls/dup/dup06.c
index e3f8070bf..84fc260a1 100644
--- a/testcases/kernel/syscalls/dup/dup06.c
+++ b/testcases/kernel/syscalls/dup/dup06.c
@@ -1,42 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2002
- *    ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
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
+ *  ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
+ * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
-  WHAT:  Does dup return -1 on the 21st file?
-  HOW:   Create up to _NFILE (20) files and check for -1 return on the
-         next attempt
-         Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
-*/
-
-#include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/param.h>
-#include "test.h"
+/*\
+ * [Description]
+ *
+ * Test for dup(2) syscall with max open file descriptors.
+ */
 
-char *TCID = "dup06";
-int TST_TOTAL = 1;
+#include <stdlib.h>
+#include "tst_test.h"
 
+static int *pfildes;
+static int minfd, maxfd, freefds;
+static char pfilname[40];
 static int cnt_free_fds(int maxfd)
 {
 	int freefds = 0;
@@ -48,67 +28,50 @@ static int cnt_free_fds(int maxfd)
 	return (freefds);
 }
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int *fildes, i;
-	int min;
-	int freefds;
-	int lc;
-	const char *pfilname = "dup06";
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	min = getdtablesize();
-	freefds = cnt_free_fds(min);
-	fildes = malloc((min + 5) * sizeof(int));
-
-	for (i = 0; i < min + 5; i++)
-		fildes[i] = 0;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		unlink(pfilname);
-
-		if ((fildes[0] = creat(pfilname, 0666)) == -1) {
-			tst_resm(TFAIL, "Cannot open first file");
-		} else {
-			for (i = 1; i < min + 5; i++) {
-				if ((fildes[i] = dup(fildes[i - 1])) == -1)
-					break;
-			}
-			if (i < freefds) {
-				tst_resm(TFAIL, "Not enough files duped");
-			} else if (i > freefds) {
-				tst_resm(TFAIL, "Too many files duped");
-			} else {
-				tst_resm(TPASS, "Test passed.");
-			}
-		}
+	minfd = getdtablesize();	/* get number of files allowed open */
+	maxfd = minfd + 5;
+	freefds = cnt_free_fds(minfd);
+	pfildes = SAFE_MALLOC(maxfd * sizeof(int));
+	memset(pfildes, -1, maxfd * sizeof(int));
+	sprintf(pfilname, "./dup06.%d\n", getpid());
+}
 
-		unlink(pfilname);
+static void cleanup(void)
+{
+	if (pfildes != NULL)
+		free(pfildes);
+}
 
-		for (i = 0; i < min + 5; i++) {
-			if (fildes[i] != 0 && fildes[i] != -1)
-				close(fildes[i]);
+static void run(void)
+{
+	int i;
 
-			fildes[i] = 0;
-		}
+	pfildes[0] = SAFE_CREAT(pfilname, 0666);
+	for (i = 1; i < maxfd; i++) {
+		if ((pfildes[i] = dup(pfildes[i - 1])) == -1)
+			break;
+	}
+	if (i < freefds) {
+		tst_res(TFAIL, "Not enough files duped");
+	} else if (i > freefds) {
+		tst_res(TFAIL, "Too many files duped");
+	} else {
+		tst_res(TPASS, "Test passed.");
 	}
 
-	cleanup();
-	tst_exit();
-}
+	SAFE_UNLINK(pfilname);
 
-static void setup(void)
-{
-	tst_tmpdir();
+	for (i = 0; i < maxfd; i++) {
+		if (pfildes[i] != 0 && pfildes[i] != -1)
+			SAFE_CLOSE(pfildes[i]);
+	}
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
