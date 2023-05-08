Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F937C77B73
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 09:32:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D818D3CB564
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 11:32:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 068903CB55F
 for <ltp@lists.linux.it>; Mon,  8 May 2023 11:31:58 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5446A10005B4
 for <ltp@lists.linux.it>; Mon,  8 May 2023 11:31:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683538316; i=@fujitsu.com;
 bh=W8Z2Rj2+L6oKNP5/uciwFgaaR5FONyrqgdwB2YQqTI0=;
 h=From:To:Cc:Subject:Date:Message-Id;
 b=fldCnMI+8y5XIfv0U6dpN72tHrM9U8en3FjU9t4nPxlG31r03WrKsENylGVDAh+fM
 d5rBj1KIs7rG6Q8bfLEwNMIj7XTSeR3E6Lg7CUw7efrRPL2/lm8WpJoI13JUf3XLs9
 GoKHM0d6VjNXh0K4PX1N8nfXrQctq95owioekgPMupiC+amWsZ+p6giF6jdJYz9z1z
 h8OhJALOjkkFabHiNwOz1rG8AwcXb4zrbXsvgPHVHFPkpALI4w2A/4xgY2+3xmmD0T
 jDHUHCai6gFO8w3lmlW9gMOLbSfeoMmoTbkvwGR1uiQUWuufsmoT4EMRC0TtLIxaSS
 GkBFx3kNhGAhw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRWlGSWpSXmKPExsViZ8ORpNt9MCL
 FoHupucWK7zsYHRg99v1exxrAGMWamZeUX5HAmtHy6TZzwT/Nik/Hr7E1MD5Q7GLk4hAS2Mgo
 sWT/fxYIZzqTxNTZ35i6GDk52AQ0JZ51LmAGsUUExCSub3jFCmIzC6hLfD3+CCwuLGAl8WXCG
 rB6FgFViXk3/oLFeQU8JPY+WgAWlxBQkJjy8D0zhK0mcfXcJuYJjFwLGBlWMZoVpxaVpRbpGh
 rrJRVlpmeU5CZm5uglVukm6qWW6panFpfoGukllhfrpRYX6xVX5ibnpOjlpZZsYgR6OaVYfe8
 Oxv27/uodYpTkYFIS5TU9GJYixJeUn1KZkVicEV9UmpNafIhRhoNDSYK3bVtEipBgUWp6akVa
 Zg4w4GDSEhw8SiK8pzYCpXmLCxJzizPTIVKnGHU5zq+7tJdZiCUvPy9VSpz32X6gIgGQoozSP
 LgRsOC/xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY1wtkCk9mXgncpldARzABHeF/ORzkiJ
 JEhJRUA1Nqw6W2PMPNZYs7Y02b2lnKZVdmPLK+cubvrfWnvdzYGUsYVcy1VV/5NbxnvnrigNW
 EauZN5g/5fyxyStSs7TtzcEtEX0KTQf4lXusWB6XsLN1tK59qPWqVMZW64zj7gNDavQ+yA/a4
 7PwaXtl6JyWk96aK+sKExBf9+xh1Ph+zNZBOZbf9Ou2zSWkehyXrrWiHr53dpRtz76hYHAu4a
 e6k2tdXuL332qJfdS7lVhNe71+07K5DY0B38cQtdpIZ34Idzy8Njnry+Whi2zq+7a5H8nbLPm
 x4u6t08+EUbVuH4o3vzt9lsEoNTH2Y80tzrunmqDcqvEeu63QZ7tu9Qsdk0/2IOzscdzXff1E
 7W4mlOCPRUIu5qDgRADH4Ltn5AgAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-571.messagelabs.com!1683538315!411472!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17090 invoked from network); 8 May 2023 09:31:55 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-7.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 8 May 2023 09:31:55 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 9BE5C1CF;
 Mon,  8 May 2023 10:31:55 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id AEB7E1C2;
 Mon,  8 May 2023 10:31:54 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon,  8 May 2023 17:31:50 +0800
Message-Id: <1683538310-9085-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/mlock03: Convert into new api
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This case is a regression test on old RHEL5.6.
You can see the following url:
https://bugzilla.redhat.com/show_bug.cgi?id=643426

Still keep this case is meaningful because we can test
whether kernel has bug on stack guard page reporting
through /proc/self/maps in the future.

Also remove tst_require_root. Test mlock/munlock instead
of mlock by default.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock03.c | 131 ++++++++--------------
 1 file changed, 47 insertions(+), 84 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
index 8bc65701c..429fb1c2a 100644
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -1,5 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2010  Red Hat, Inc.
+ */
+
+/*\
+ * [Description]
+ *
+ * This case is a regression test on old RHEL5.
+ *
  * Stack size mapping is decreased through mlock/munlock call.
+ * See the following url:
+ * https://bugzilla.redhat.com/show_bug.cgi?id=643426
  *
  * This is to test kernel if it has a problem with shortening [stack]
  * mapping through several loops of mlock/munlock of /proc/self/maps.
@@ -11,109 +22,61 @@
  * munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]
  *
  * with more iterations - could drop to 0KiB.
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
+			tst_brk(TBROK, "parse %s start and end address failed",
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
