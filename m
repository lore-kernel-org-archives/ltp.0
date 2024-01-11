Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF1AC4707B
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 02:20:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5058B3CE4EF
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 03:20:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA6023C768C
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:19:58 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 17B821A00A3E
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:19:57 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="145251669"
X-IronPort-AV: E=Sophos;i="6.04,185,1695654000"; d="scan'208";a="145251669"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 11:19:55 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 51278CA241
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:19:53 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 75798F6910
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:19:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F3D92005019F
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:19:52 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id BCFB01A0070
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:19:51 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 11 Jan 2024 10:19:50 +0800
Message-Id: <20240111021951.1784735-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110182913.GA1768734@pevik>
References: <20240110182913.GA1768734@pevik>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28112.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28112.004
X-TMASE-Result: 10--4.595900-10.000000
X-TMASE-MatchedRID: J3TEshnsAz6H/OjJ1CEsvE7nLUqYrlslFIuBIWrdOeOU8ftiyKjZrXlb
 NLJMhGktx8cx3E6pg15WTBAeKqaX9Spe4ofkluPsiH95tLFH8edZ+CK+BxQ9k224tW2R9/7QDui
 v1PSTVn4QT82YoBmnzDFTm2Y2SkL+qFxsFrCmzTTTfU1/F+PbM6VjgXyvS9c//NbvBEf2bLkbJA
 HWhH3kCoTei6L3bqIN3XPw9QFitX4Dn8FLAokMMc36paW7ZnFofrTt+hmA5bI8zUakDfUiKxFEt
 97pQ+C8ardV3Qj27xsD087g4LiNvIHcC7KYYAdEVV4ZZmbE3Yxa9oWcYwi86jxzAG47ocHfKYU5
 gkls+qmaIuBZNVsPT4Ay6p60ZV62SwOSQ/fMiOrdB/CxWTRRu+rAZ8KTspSzxfw793fSnsqfrgX
 IXOkHtwOs/PyFdbi1DbIZjoFs4tXhL1BrvcjQ+TdLEO1eJ6bElbcflqlVXWhYXasXKJE1pn/lgG
 y0KlfmT1VL0zswEA0e89suUG5ol7mrEnDXnASMB0RtcVvgTmh+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] dup06: Convert to new API
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
 testcases/kernel/syscalls/dup/dup06.c | 145 ++++++++++----------------
 1 file changed, 55 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup06.c b/testcases/kernel/syscalls/dup/dup06.c
index e3f8070bf..e7dfbbac8 100644
--- a/testcases/kernel/syscalls/dup/dup06.c
+++ b/testcases/kernel/syscalls/dup/dup06.c
@@ -1,41 +1,23 @@
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
+ * Ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
+ * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2003-2024
  */
 
-/*
-  WHAT:  Does dup return -1 on the 21st file?
-  HOW:   Create up to _NFILE (20) files and check for -1 return on the
-         next attempt
-         Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
-*/
+/*\
+ * [Description]
+ *
+ * Test for dup(2) syscall with max open file descriptors.
+ */
 
-#include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/param.h>
-#include "test.h"
+#include <stdlib.h>
+#include "tst_test.h"
 
-char *TCID = "dup06";
-int TST_TOTAL = 1;
+static int *pfildes;
+static int minfd, maxfd, freefds;
+static char pfilname[40];
 
 static int cnt_free_fds(int maxfd)
 {
@@ -45,70 +27,53 @@ static int cnt_free_fds(int maxfd)
 		if (fcntl(maxfd, F_GETFD) == -1 && errno == EBADF)
 			freefds++;
 
-	return (freefds);
+	return freefds;
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
-
-		unlink(pfilname);
-
-		for (i = 0; i < min + 5; i++) {
-			if (fildes[i] != 0 && fildes[i] != -1)
-				close(fildes[i]);
-
-			fildes[i] = 0;
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	minfd = getdtablesize();	/* get number of files allowed open */
+	maxfd = minfd + 5;
+	freefds = cnt_free_fds(minfd);
+	pfildes = SAFE_MALLOC(maxfd * sizeof(int));
+	memset(pfildes, -1, maxfd * sizeof(int));
+	sprintf(pfilname, "./dup06.%d\n", getpid());
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-	tst_tmpdir();
+	if (pfildes != NULL)
+		free(pfildes);
 }
 
-static void cleanup(void)
+static void run(void)
 {
-	tst_rmdir();
+	int i;
+
+	pfildes[0] = SAFE_CREAT(pfilname, 0666);
+	for (i = 1; i < maxfd; i++) {
+		pfildes[i] = dup(pfildes[i - 1]);
+		if (pfildes[i] == -1)
+			break;
+	}
+	if (i < freefds)
+		tst_res(TFAIL, "Not enough files duped");
+	else if (i > freefds)
+		tst_res(TFAIL, "Too many files duped");
+	else
+		tst_res(TPASS, "Test passed.");
+
+	SAFE_UNLINK(pfilname);
+
+	for (i = 0; i < maxfd; i++) {
+		if (pfildes[i] != 0 && pfildes[i] != -1)
+			SAFE_CLOSE(pfildes[i]);
+	}
 }
+
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
