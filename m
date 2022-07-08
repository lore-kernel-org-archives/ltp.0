Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CAEC43334
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 17:06:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 034F53CA455
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 19:06:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AD313CA369
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 19:06:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D947140033D
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 19:06:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2BF821F01
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657299997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GeLTutLSJRhvAyq3oeqZEZlqXExsJ7GcxV1BcYrEtIQ=;
 b=MU0mXr/y+ndwgZCvMTQkHwcYzDDkrQSUwqWa8mWzhJoNCYd+P4tfqWtVWmJjN2xM7jMnX5
 yC/W0zE/Eyf+VAwrJLVWaOIEZ+BzahDFDQQGGYqZDeC8Ovp01MXwrMimocG4BpUMWuAgTB
 Ac0PZLRiACQrVdOK0LpB+Jw6Yd5NxTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657299997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GeLTutLSJRhvAyq3oeqZEZlqXExsJ7GcxV1BcYrEtIQ=;
 b=vJ6U5HQhQt0kGzRUFg5+HzSw9fPjYLZoGHFapXw+mdIPVXH+6/OmunEDvCn9YIzVtQ3uJz
 QLsfLWmlamluTMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3067D13A80
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 17:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q5qWOBxkyGKOGwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 08 Jul 2022 17:06:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Jul 2022 22:36:34 +0530
Message-Id: <20220708170634.842-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fstat02.c: simplify using TST_EXP_*() macros
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

Simplifying the tests using TST_EXP_*() macros and removing the
unnecessary header includes

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/fstat/fstat02.c | 59 ++++-------------------
 1 file changed, 9 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 2f9632edf..2142ae3e6 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -4,17 +4,14 @@
  *  07/2001 Ported by Wayne Boyer
  *  05/2019 Ported to new library: Christian Amann <camann@suse.com>
  */
-/*
+
+/*\ [Description]
+ *
  * Tests if fstat() returns correctly and reports correct file information
  * using the stat structure.
  */
 
-#include <errno.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <sys/types.h>
 #include "tst_test.h"
-#include "tst_safe_macros.h"
 
 #define TESTFILE        "test_file"
 #define LINK_TESTFILE   "link_test_file"
@@ -29,50 +26,12 @@ static int fildes;
 
 static void run(void)
 {
-	int fail = 0;
-
-	TEST(fstat(fildes, &stat_buf));
-
-	if (TST_RET != 0) {
-		tst_res(TFAIL | TTERRNO, "fstat() failed");
-		return;
-	}
-
-	fail = 0;
-	if (stat_buf.st_uid != user_id) {
-		tst_res(TFAIL, "stat_buf.st_uid = %i expected %i",
-			stat_buf.st_uid, user_id);
-		fail++;
-	}
-
-	if (stat_buf.st_gid != group_id) {
-		tst_res(TFAIL, "stat_buf.st_gid = %i expected %i",
-			stat_buf.st_gid, group_id);
-		fail++;
-	}
-
-	if (stat_buf.st_size != FILE_SIZE) {
-		tst_res(TFAIL, "stat_buf.st_size = %li expected %i",
-			(long)stat_buf.st_size, FILE_SIZE);
-		fail++;
-	}
-
-	if ((stat_buf.st_mode & 0777) != FILE_MODE) {
-		tst_res(TFAIL, "stat_buf.st_mode = %o expected %o",
-			(stat_buf.st_mode & 0777), FILE_MODE);
-		fail++;
-	}
-
-	if (stat_buf.st_nlink != NLINK) {
-		tst_res(TFAIL, "stat_buf.st_nlink = %li expected %i",
-			(long)stat_buf.st_nlink, NLINK);
-		fail++;
-	}
-
-	if (fail)
-		return;
-
-	tst_res(TPASS, "fstat() reported correct values.");
+	TST_EXP_PASS(fstat(fildes, &stat_buf));
+	TST_EXP_EQ_LI(stat_buf.st_uid, user_id);
+	TST_EXP_EQ_LI(stat_buf.st_gid, group_id);
+	TST_EXP_EQ_LI(stat_buf.st_size, FILE_SIZE);
+	TST_EXP_EQ_LI(stat_buf.st_mode & 0777, FILE_MODE);
+	TST_EXP_EQ_LI(stat_buf.st_nlink, NLINK);
 }
 
 static void setup(void)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
