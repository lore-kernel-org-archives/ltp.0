Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590AECCF2E3
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792413362; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=HmfemE0WPleoGTwmNna4XoGATXj6jqrVImu0c3q7H/0=;
 b=kh/BssmcfYe5ZAigxH19L9/uFJwWTzReJVlYoNGzKcGnLBilm0b5TzFL2E0dIrBJRs0Ln
 r2tAIC7xTBxGSe9RIytHoWVcbME/AQCB3A7np/49Byj4jjk5mvhvVMsxO7d51x4CZL898Jr
 pvLsbO5L3M1dwbTb6Hhe/QpT+rtaPXM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C2FD3EA64B
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 14:36:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACBDB3E9AD7
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:35:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 83A011400175
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792413339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6UanoN8sWcmN1lGOn42ogzn1WWDrPZoQC8vuLgVneAI=;
 b=UGVsB2Sz31H3xmhZypASdscOkJxv5qLBe25li1/XHbIkJGT/bysyHi1rRFtObOlBmJycL3
 xigT0AsTy0UaGauF8sDsK7+2BWB8/6NOoEuvLwFPmq0+s5wE3zTdyNf66g96H+0hHB2rhu
 1tIn/uflMmZlm5ZSGIYCrC8SuX8TEZY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-98D1GJa2PwaoClRDXrx4Rg-1; Mon,
 19 Oct 2026 12:35:38 +0000
X-MC-Unique: 98D1GJa2PwaoClRDXrx4Rg-1
X-Mimecast-MFC-AGG-ID: 98D1GJa2PwaoClRDXrx4Rg_1792413337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77A63195606F
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:35:37 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BED0418004D2
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:35:36 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 14:35:31 +0200
Message-ID: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LNJVKzOs6HLqQaar54gWmBv7O_4lP5LzF0iVuIzbo84_1792413337
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nextafter01: Check exact results and convert to new
 API
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test can hardly fail. Block 1 accepts nextafter(1.0, 1.1) whenever
(answer + 1.0) / 2 rounds to 1.0 as a float, which is also true when
nextafter() returns 1.0 unchanged. Block 2 never recomputes 'check'
and compares the stale value from block 1, which is exactly 1.0, so its
'check != 1.0' condition is always false and any return value passes.
Only the x == y case in block 3 is really verified. The file header also
names the test "scalb".

Compare the results with the exact next doubles instead: 1.0 + 2^-52
above and 1.0 - 2^-53 below. Both are exactly representable, so a plain
equality test is sufficient. Rewrite the test with the new API while at
it and fix the description.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/misc/math/nextafter/nextafter01.c | 145 +++++---------------
 1 file changed, 33 insertions(+), 112 deletions(-)

diff --git a/testcases/misc/math/nextafter/nextafter01.c b/testcases/misc/math/nextafter/nextafter01.c
index f4b212d4daa2..a74b7dc8e974 100644
--- a/testcases/misc/math/nextafter/nextafter01.c
+++ b/testcases/misc/math/nextafter/nextafter01.c
@@ -1,127 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
+ * Copyright (c) International Business Machines Corp., 2002
+ * Copyright (c) 2026 Jan Stancek <jstancek@redhat.com>
  */
 
-/* 01/02/2003	Port to LTP	avenkat@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-
-/*
- * NAME
- *      scalb
+/*\
+ * Verify that nextafter() returns the next representable double in the
+ * direction of its second argument:
  *
- * CALLS
- *      nextafter(3C)
- *
- * ALGORITHM
- *	Check results from the above functions against expected values.
- *
- * RESTRICTIONS
- * 	Checks for basic functionality, nothing fancy
+ * - nextafter(1.0, 1.1) is 1.0 + 2^-52 (DBL_EPSILON)
+ * - nextafter(1.0, 0.9) is 1.0 - 2^-53
+ * - nextafter(1.0, 1.0) is 1.0
  */
 
-#include <errno.h>
 #include <math.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include "test.h"
+#include "tst_test.h"
 
-#define	FAILED 0
-#define	PASSED 1
+/* DBL_EPSILON spelled out, as sparse does not know __DBL_EPSILON__ */
+#define EPSILON (1.0 / (1ULL << 52))
 
-char *TCID = "nextafter01";
+static struct tcase {
+	double x;
+	double y;
+	double exp;
+} tcases[] = {
+	{1.0, 1.1, 1.0 + EPSILON},
+	{1.0, 0.9, 1.0 - EPSILON / 2},
+	{1.0, 1.0, 1.0},
+};
 
-int local_flag = PASSED;
-int block_number;
-FILE *temp;
-int TST_TOTAL = 1;
-
-void setup();
-void blenter();
-void blexit();
-
-/*--------------------------------------------------------------*/
-int main()
+static void run(unsigned int n)
 {
-	double answer;
-	double check;		/* tmp variable */
+	struct tcase *tc = &tcases[n];
+	double ret = nextafter(tc->x, tc->y);
 
-	setup();		/* temp file is now open */
-/*--------------------------------------------------------------*/
-	blenter();
-
-	answer = nextafter(1.0, 1.1);
-	check = (answer + 1.0) / 2;
-	if ((check != answer) && ((float)check != 1.0)) {
-		fprintf(temp, "nextafter returned %e, expected answer or 1.0\n",
-			answer);
-		local_flag = FAILED;
+	if (ret == tc->exp) {
+		tst_res(TPASS, "nextafter(%g, %g) == %.17g", tc->x, tc->y, ret);
+	} else {
+		tst_res(TFAIL, "nextafter(%g, %g) == %.17g, expected %.17g",
+			tc->x, tc->y, ret, tc->exp);
 	}
-
-	blexit();
-/*--------------------------------------------------------------*/
-	blenter();
-
-	answer = nextafter(1.0, 0.9);
-	if ((check != answer) && (check != 1.0)) {
-		fprintf(temp, "nextafter returned %e, expected answer or 1.0\n",
-			answer);
-		local_flag = FAILED;
-	}
-
-	blexit();
-/*--------------------------------------------------------------*/
-	blenter();
-
-	answer = nextafter(1.0, 1.0);
-	if (answer != 1.0) {
-		fprintf(temp, "nextafter 3 returned %e, expected 1.0\n",
-			answer);
-		local_flag = FAILED;
-	}
-
-	blexit();
-/*--------------------------------------------------------------*/
-
-	tst_exit();
 }
 
-/*--------------------------------------------------------------*/
-
-/*****	*****	LTP Port	*****/
-
-/* FUNCTIONS */
-
-void setup()
-{
-	temp = stderr;
-}
-
-void blenter()
-{
-	local_flag = PASSED;
-}
-
-void blexit()
-{
-	if (local_flag == PASSED)
-		tst_resm(TPASS, "Test passed");
-	else
-		tst_resm(TFAIL, "Test failed");
-}
-
-/*****	*****		*****/
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
