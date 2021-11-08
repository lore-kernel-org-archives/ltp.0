Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F1BC433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 05:33:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33636124D
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 05:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B33636124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 288123C7635
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 06:33:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763A23C77B9
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 06:32:44 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 775F810005F1
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 06:32:43 +0100 (CET)
X-QQ-mid: bizesmtp52t1636349557twk6x3d5
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 08 Nov 2021 13:32:34 +0800 (CST)
X-QQ-SSF: 0140000000200040C000000A0000000
X-QQ-FEAT: B0D4DPF8NcRTlO3UBxzNqNljYOg7jGyCcZhkTefQjSwz0ykQF+yX2oaL6Fj23
 G2zPou0V/GMM5Y4NGehPHNHURg10vpuPoBrO7801UH5pJukjCsnZTV0goZahmULL2kylMuO
 jWaq1VzR+9nTvV/oCZiregB0Ayhd49m4U2vaOSf3mYFdnnJ+PykMs8wl2j2SGqhgqMppRge
 LsQb3Ifq6tRDwhVzuGc3/0ELzIHNCJ+b9xKIPKC03tB853FwK9Nmhsia0gPAb0PXSUWyIoO
 Q1H9Tzn6gRrsPS4EtPY5d+bkHjEtKzw4PxO0Wl4ll1+Dv4JLGBgEzhr3cJvzBov/O4BtqYL
 kpiqJdBC5+F1++Xr1Dgz8NxEzo6gg==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Mon,  8 Nov 2021 13:32:25 +0800
Message-Id: <20211108053225.23442-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211108053225.23442-1-tangmeng@uniontech.com>
References: <20211108053225.23442-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] fchdir/fchdir02: Convert to new API
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
 testcases/kernel/syscalls/fchdir/fchdir02.c | 103 ++------------------
 1 file changed, 8 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/fchdir/fchdir02.c b/testcases/kernel/syscalls/fchdir/fchdir02.c
index cf11bf6b9..b0ba9ad58 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir02.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir02.c
@@ -1,110 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
  */

 /*
- * NAME
- *	fchdir02.c
- *
  * DESCRIPTION
  *	fchdir02 - try to cd into a bad directory (bad fd).
- *
- * CALLS
- *	fchdir()
- *
- * ALGORITHM
- *	loop if that option was specified
- *	call fchdir() with an invalid file descriptor
- *	check the errno value
- *	  issue a PASS message if we get EBADF - errno 9
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  fchdir02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */

-#include "test.h"
+#include "tst_test.h"

-#include <errno.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "fchdir02";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_fchdir(void)
 {
 	const int bad_fd = -5;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(fchdir(bad_fd));
-
-		if (TEST_RETURN != -1)
-			tst_brkm(TFAIL, cleanup, "call succeeded unexpectedly");
-
-		if (TEST_ERRNO == EBADF)
-			tst_resm(TPASS, "failed as expected with EBADF");
-		else
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "call failed unexpectedly");
-	}

-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL(fchdir(bad_fd), EBADF);
 }

-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = verify_fchdir,
+	.needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
