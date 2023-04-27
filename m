Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F7C77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 05:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E0113CBAC0
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 07:44:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ECB93CAD68
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 07:44:42 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C09E510009F3
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 07:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1682574279; i=@fujitsu.com;
 bh=h6/7f73tsGXaTDEwUQ2R72QEep2kbTFGyyPuky+MBtM=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=LsKDUyMG6DUuOm+WJJ5A0oDweZ1q2mQXpw5nQLLBwZL2xUKP/s01cgE+VMcuSzezl
 J5LyJvCNZvc7qNrx8HGkhSFUc+LL69rLueEjQG0PhIRnTd+YaItny0I1HPM02kC7vJ
 t7qijHlABA96N6kQCFJ3igKHCbXPRnI7kN8grYZIf2E4oKp/3z+cANcHV8KhGYAJSe
 waxOHyeNFVQfIUIaPbD/UPZMu9Stu6EL50sxBgykP7FoUEpVMfcir/3Ua8asZY3hZx
 c5ZELctml2rX8iMabEoHXNuYERun1QjNuZI06o/wEYyj+4UoT19Py/zjojOhTf+QmO
 sxatjqFM+ML/A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRWlGSWpSXmKPExsViZ8ORpHuM2yv
 F4M9eWYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePlyS/sBVNVKg5f2MncwDhftouRi0NI4BSj
 xJL7P5khnH1MEv/uPWOCchgl5kzYxdLFyMnBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXE
 4gtLJAq0f1vGiOIzSKgKrHm50wwm1fAU2LFjG6wegkBBYkpD9+DzeEU0JbYsOQPUA0H0DItiT
 8b1SHKBSVOznzCAjFeU6J1+2+oVfISzVtnM0OMUZJoa73CCmFXSrR++MUCYatJXD23iXkCo9A
 sJKNmIRk1C8moBYzMqxjNi1OLylKLdA3N9ZKKMtMzSnITM3P0Eqt0E/VSS3Xz8otKMnQN9RLL
 i/VSi4v1iitzk3NS9PJSSzYxAsM9pTgldAfjpF1/9Q4xSnIwKYnytqR7pgjxJeWnVGYkFmfEF
 5XmpBYfYpTh4FCS4F3N5pUiJFiUmp5akZaZA4w9mLQEB4+SCC8bF1Cat7ggMbc4Mx0idYpRUU
 qctxYkIQCSyCjNg2uDxfslRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8asDkIcSTmVcCN/0
 V0GImoMXlDB4gi0sSEVJSDUxr244r1v+dr337/zvdDYaHNetuGOeoZs5qq+vNZ9nLw63tLeTF
 lSKznn3NuVNHvlirn1/vVnxTymuHzYlXzvr+Tv/6MhSXJKSrHHzqFsPBupiJc6b7E0PLW7OKc
 7dkXO+8sufSA7lc9ww18XMW0ewWgltvu0Wwx+r0/kxrz7xy1c1mG69ny7ktDmdeZnevWHW+vm
 h+OOMVGQGnL5vmPrOy2tyWa9ndcltTZ3dFzseL/S7586v3m/JYXv3s/HqH55t3ql81QuVfr9j
 w8sj8nNzDBruen+NKVD+y9BHX7KtTGUWSj5i5u+QsEV+TcX7nJJdtOQvvv1rL8Pm1ogzzBhch
 a7evAvnrX4suaTLt61ZiKc5INNRiLipOBACPTZF2cgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-728.messagelabs.com!1682574278!205673!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3466 invoked from network); 27 Apr 2023 05:44:38 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-11.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Apr 2023 05:44:38 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id DC6BF1C8
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 06:44:37 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id D09A21B1
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 06:44:37 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 27 Apr 2023 06:44:36 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 27 Apr 2023 13:44:24 +0800
Message-ID: <1682574265-12953-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1827762.iFF2E32hkL@localhost>
References: <1827762.iFF2E32hkL@localhost>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?q?=5BPATCH_v2_1/2=5D_syscalls/mlock03=EF=BC=9ARemo?=
 =?utf-8?q?ve_meaningless_case?=
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

This case is used to read start address and end address
from /proc/self/maps. Then check stack range whether be shorten.

AFAIK, kernel doesn't have this similar bug and man-pages
also doesn't mention it.

So let's remove this meaningful case.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                           |   1 -
 testcases/kernel/syscalls/mlock/.gitignore |   1 -
 testcases/kernel/syscalls/mlock/mlock03.c  | 119 ---------------------
 3 files changed, 121 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/mlock/mlock03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9c23a4248..b58a58c74 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -765,7 +765,6 @@ mknodat02 mknodat02
 
 mlock01 mlock01
 mlock02 mlock02
-mlock03 mlock03 -i 20
 mlock04 mlock04
 
 mlock201 mlock201
diff --git a/testcases/kernel/syscalls/mlock/.gitignore b/testcases/kernel/syscalls/mlock/.gitignore
index 306574bbc..566f0cfcc 100644
--- a/testcases/kernel/syscalls/mlock/.gitignore
+++ b/testcases/kernel/syscalls/mlock/.gitignore
@@ -1,4 +1,3 @@
 /mlock01
 /mlock02
-/mlock03
 /mlock04
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
deleted file mode 100644
index 8bc65701c..000000000
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- * Stack size mapping is decreased through mlock/munlock call.
- *
- * This is to test kernel if it has a problem with shortening [stack]
- * mapping through several loops of mlock/munlock of /proc/self/maps.
- *
- * From:
- * munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]
- *
- * To:
- * munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]
- *
- * with more iterations - could drop to 0KiB.
- *
- * Copyright (C) 2010  Red Hat, Inc.
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
- */
-#include <sys/mman.h>
-#include <stdio.h>
-#include <string.h>
-#include "test.h"
-
-#define KB 1024
-
-char *TCID = "mlock03";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	long from, to;
-	long first = -1, last = -1;
-	char b[KB];
-	FILE *fp;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		fp = fopen("/proc/self/maps", "r");
-		if (fp == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
-		while (!feof(fp)) {
-			if (!fgets(b, KB - 1, fp))
-				break;
-			b[strlen(b) - 1] = '\0';
-			sscanf(b, "%lx-%lx", &from, &to);
-
-			/* Record the initial stack size. */
-			if (lc == 0 && strstr(b, "[stack]") != NULL)
-				first = (to - from) / KB;
-
-			switch (lc & 1) {
-			case 0:
-				if (mlock((const void *)from, to - from) == -1)
-					tst_resm(TINFO | TERRNO,
-						 "mlock failed");
-				break;
-			case 1:
-				if (munlock((void *)from, to - from) == -1)
-					tst_resm(TINFO | TERRNO,
-						 "munlock failed");
-				break;
-			default:
-				break;
-			}
-			tst_resm(TINFO, "%s from %lx to %0lx",
-				 (lc & 1) ? "munlock" : "mlock", from, to);
-
-			/* Record the final stack size. */
-			if (strstr(b, "[stack]") != NULL)
-				last = (to - from) / KB;
-		}
-		fclose(fp);
-	}
-	tst_resm(TINFO, "starting stack size is %ld", first);
-	tst_resm(TINFO, "final stack size is %ld", last);
-	if (last < first)
-		tst_resm(TFAIL, "stack size is decreased.");
-	else
-		tst_resm(TPASS, "stack size is not decreased.");
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
