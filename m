Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E2FC6FD1D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 10:37:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42F063C992B
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 12:37:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF57D3CA860
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:25 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4EAB01A0081B
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680604644; i=@fujitsu.com;
 bh=ARJNbcV5nRgJfwnnaWIH4WcCi7RXzYiyxka9MusD5w8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=UefZrXE+cObdbhnEMsxEVAFP+HLVs+bbKqY2nvjnUfMplwPpusOhjVGMFE6LQpAkm
 49vdjcPpbFG0ecAwz83ugO0Lex0nV5GlvcU83H+0gXgRHXwhwSeNMrFZL+54qx+kem
 Ooqd9RAh6hMgqiN53tt2rdXkpeLAQHr3x4UTMARI3exYeVOpgOzkfx76suOqcKq/cG
 NawkxjLQ2LZ+FL0tfTxgMcrSh1hzxF2GSToRiRWsjNQtVQj/L2Vzv6C2OXi5KifyBm
 phviprX7WnOiOE45Kgy8rwbOqh8ziXD2XsQ7lD7c+XpNyFXmjd9QQIGkQt5vOFPtYz
 /ZUanhJlUgD+A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8ORqPv4r3a
 KwaZmfYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNaP95we2gi0aFR9+fWBuYFyv0MXIxSEkcJZR
 4s3hg2wQzgEmic6ZR5ghnD2MEiu7pjN1MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6B
 VYjLGAtsfLmEhYQm0VARWLzn31gNq+Ap8SMZ6dZQWwJAQWJKQ/fg83hFPCS+LV8JZgtBFSz+X
 M/I0S9oMTJmU9YIOZLSBx88YIZoldJoq31CtScConG6YeYIGw1iavnNjFPYBSchaR9FpL2BYx
 MqxjNilOLylKLdM30kooy0zNKchMzc/QSq3QT9VJLdfPyi0oydA31EsuL9VKLi/WKK3OTc1L0
 8lJLNjECwzelOOHxDsZ5fX/1DjFKcjApifI+2qidIsSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC1
 +41UE6wKDU9tSItMwcYSzBpCQ4eJRFe4T9Aad7igsTc4sx0iNQpRkUpcV4jYAQKCYAkMkrz4N
 pg8XuJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDv/F9AU3gy80rgpr8CWswEtLg1SgNkcUk
 iQkqqgcnw64kPZjfLcrY/TZK7fMwrbdF304z8NXcjzWrv/7TyTTAVD5r2e8pR2d3HWZ/+WNsR
 l3Tj+nz17l0lf2RF2hn+xzMqME9w6LgXrn2mwZKn1baQN63wy/XZaoriqcLZ074zvr1XvGRN1
 5xPP1b65S17I3Wsvpu7RnLaD7bCHvH39vPqRRsS93xc7zB/TuOPS7EzPxTf2FjuPYf5eufWj3
 8fRdmGvjz8Zu/2S45+Hpt1p28vEzj2L6PPum63V75LGCdD2ManJWt+xX/me5if7HjVecvUQ5u
 FM64kV7Lm/Tme/WLfu4RLs+00O34ecNHM7LRS0Nic5rv44l+2vXzO/QGuku5ptrF6sUeKrNem
 nlFiKc5INNRiLipOBADUG+qmWgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-745.messagelabs.com!1680604643!1527477!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2403 invoked from network); 4 Apr 2023 10:37:23 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-22.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 10:37:23 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 2BA08100225
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:23 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 1DCC1100222
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:23 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 11:37:21 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 18:36:33 +0800
Message-ID: <1680604594-16596-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] syscalls/mlock03: Convert into new api
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

Also remove tst_require_root. Test mlock/munlock instead of mlock by default.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock03.c | 137 +++++++---------------
 1 file changed, 43 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
index 8bc65701c..0fc3fa8ed 100644
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -1,119 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
  * Copyright (C) 2010  Red Hat, Inc.
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
+ */
+
+/*\
+ * [Description]
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * This case is designed to test kernel whether met a problem with shortening
+ * [stack] mapping through several loops of mlock/munlock of /proc/self/maps.
  */
+
 #include <sys/mman.h>
 #include <stdio.h>
 #include <string.h>
-#include "test.h"
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #define KB 1024
 
-char *TCID = "mlock03";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
+static void verify_mlock(void)
 {
-	int lc;
 	long from, to;
 	long first = -1, last = -1;
 	char b[KB];
 	FILE *fp;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	fp = SAFE_FOPEN("/proc/self/maps", "r");
+	while (!feof(fp)) {
+		if (!fgets(b, KB - 1, fp))
+			break;
+		b[strlen(b) - 1] = '\0';
+		if (sscanf(b, "%lx-%lx", &from, &to) != 2) {
+			tst_res(TFAIL, "parse %s start and end address failed",
+					b);
+			continue;
+		}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		fp = fopen("/proc/self/maps", "r");
-		if (fp == NULL)
-			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
-		while (!feof(fp)) {
-			if (!fgets(b, KB - 1, fp))
-				break;
-			b[strlen(b) - 1] = '\0';
-			sscanf(b, "%lx-%lx", &from, &to);
+		/* Record the initial stack size. */
+		if (strstr(b, "[stack]") != NULL)
+			first = (to - from) / KB;
 
-			/* Record the initial stack size. */
-			if (lc == 0 && strstr(b, "[stack]") != NULL)
-				first = (to - from) / KB;
+		tst_res(TINFO, "mlock[%lx,%lx]", from, to);
+		if (mlock((const void *)from, to - from) == -1)
+			tst_res(TINFO | TERRNO, "mlock failed");
 
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
+		tst_res(TINFO, "munlock [%lx,%lx]", from, to);
+		if (munlock((void *)from, to - from) == -1)
+			tst_res(TINFO | TERRNO, "munlock failed");
 
-			/* Record the final stack size. */
-			if (strstr(b, "[stack]") != NULL)
-				last = (to - from) / KB;
-		}
-		fclose(fp);
+		/* Record the final stack size. */
+		if (strstr(b, "[stack]") != NULL)
+			last = (to - from) / KB;
 	}
-	tst_resm(TINFO, "starting stack size is %ld", first);
-	tst_resm(TINFO, "final stack size is %ld", last);
+	SAFE_FCLOSE(fp);
+
+	tst_res(TINFO, "starting stack size is %ld", first);
+	tst_res(TINFO, "final stack size is %ld", last);
 	if (last < first)
-		tst_resm(TFAIL, "stack size is decreased.");
+		tst_res(TFAIL, "stack size is decreased.");
 	else
-		tst_resm(TPASS, "stack size is not decreased.");
-
-	cleanup();
-	tst_exit();
+		tst_res(TPASS, "stack size is not decreased.");
 }
 
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
+static struct tst_test test = {
+	.test_all = verify_mlock,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
