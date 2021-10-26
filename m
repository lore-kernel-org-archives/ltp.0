Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324AEC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 03:43:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B4360ED4
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 03:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25B4360ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60C8C3C6711
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 05:43:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BB3A3C2C95
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 05:43:02 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C7391000ED1
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 05:42:54 +0200 (CEST)
X-QQ-mid: bizesmtp31t1635219768tc1g0s3v
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 26 Oct 2021 11:42:43 +0800 (CST)
X-QQ-SSF: 0140000000200020B000B00A0000000
X-QQ-FEAT: dpyQmELDBxEZU3JAXJaWVzqn4jHe2EKHvsK0542VZmL6TCCBBqUuWcnUIWLdL
 3bPmRwy6jKxBI3AycFFiBCzJ73DBWOIOJJhLoHK2LvU5xibBXw+azR7bQbDn+tyAWV/HkOh
 ZxPMC6T7gblRxcS0rLRCUWWkHo4p7EdOieXvNwXGeJXaiMUVaIGWIDJPvQTBX6kip2wUB3p
 iX3kvo/aAyOG8hnLTJf1BGhJKkVPrudr8j4uyctRkJayIW3pWfkyWPKl26GLIwIHSA5p+7P
 3OpnRe7O+iOWo+x4wESRDMl36ixT/G9HOPa0Ihls8UGR84znJvpTqHVHRMpiZ5cxu/jyKgo
 33cqrMM64Ie+IASBCxtVMQwd/dBtw==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 26 Oct 2021 11:42:41 +0800
Message-Id: <20211026034241.1605-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] link/link02: Convert to new API
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 testcases/kernel/syscalls/link/link02.c | 81 +++++++------------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
index 6ac340c72..c074d71b0 100644
--- a/testcases/kernel/syscalls/link/link02.c
+++ b/testcases/kernel/syscalls/link/link02.c
@@ -34,23 +34,14 @@
  */

 /*
- * Tests that link(2) succeds.
+ * [Description]
+ *
+ * Tests that link(2) succeeds.
  */

-#include <sys/types.h>
-#include <fcntl.h>
+#include <unistd.h>
 #include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "link02";
-int TST_TOTAL = 1;
+#include "tst_test.h"

 #define OLDPATH "oldpath"
 #define NEWPATH "newpath"
@@ -59,57 +50,31 @@ static void verify_link(void)
 {
 	struct stat fbuf, lbuf;

-	TEST(link(OLDPATH, NEWPATH));
-
-	if (TEST_RETURN == 0) {
-		SAFE_STAT(cleanup, OLDPATH, &fbuf);
-		SAFE_STAT(cleanup, NEWPATH, &lbuf);
-		if (fbuf.st_nlink > 1 && lbuf.st_nlink > 1 &&
-		    fbuf.st_nlink == lbuf.st_nlink) {
-			tst_resm(TPASS, "link("OLDPATH","NEWPATH") "
-			         "returned 0 and link counts match");
-		} else {
-			tst_resm(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
-				 " but stat lin count do not match %d %d",
-				 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
-		}
-		SAFE_UNLINK(cleanup, NEWPATH);
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-		         "link("OLDPATH","NEWPATH") returned %ld",
-		         TEST_RETURN);
-	}
-}
-
-int main(int ac, char **av)
-{
-	int lc;
+	TST_EXP_PASS(link(OLDPATH, NEWPATH));

-	tst_parse_opts(ac, av, NULL, NULL);
+	if (!TST_PASS)
+		return;

-	setup();
+	SAFE_STAT(OLDPATH, &fbuf);
+	SAFE_STAT(NEWPATH, &lbuf);

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		verify_link();
+	if (fbuf.st_nlink > 1 && fbuf.st_nlink == lbuf.st_nlink) {
+		tst_res(TPASS, "link("OLDPATH","NEWPATH") "
+                                 "returned 0 and stat link counts match");
+	} else {
+		tst_res(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
+                                 " but stat link counts do not match %d %d",
+                                 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
 	}
-
-	cleanup();
-	tst_exit();
 }

 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_TOUCH(cleanup, OLDPATH, 0700, NULL);
+	SAFE_TOUCH(OLDPATH, 0700, NULL);
 }

-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+    .test_all = verify_link,
+    .setup = setup,
+    .needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
