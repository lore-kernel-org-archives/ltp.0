Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5116C001DE
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 15:36:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D94AF3CD1B2
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 17:36:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F5B03CD0F9
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 17:35:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 651FD10009BA
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 17:35:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C00520321
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691508951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aUcgWuESnd4//ZzLMdGN2JaQOz9TYPfuUw5iKCInUiI=;
 b=Tmjdz4ArpzYTYwezJSTF3E9ILQFn6B7H6nKEwdD/fzb2FQpqxxYBjZBEQ/3RRmsrZ1N/x6
 8hISiZS7TLJpQ7XUTJwB0Y0TykuQ9cEymqb7IzPxVBSJZdHvHibfaUawNHKWEo0Xv3T6Ve
 OmsoaUcgG/tiYRhXHttfBGnTK6VeoMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691508951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aUcgWuESnd4//ZzLMdGN2JaQOz9TYPfuUw5iKCInUiI=;
 b=M2FvwONxInwdTWY0fZA1NBqs4tbvju5Qeoe9vx+nSBdxI1f+91HiNUFo3hfc0RLIhyBRmo
 nuJWH993O9qpaTBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 381AE139D1
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 15:35:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LrVQBNdg0mSWVgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Aug 2023 15:35:51 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Aug 2023 21:05:46 +0530
Message-ID: <20230808153549.22777-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] sbrk01: Refactor the test using new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/sbrk/sbrk01.c | 121 +++++-------------------
 1 file changed, 26 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
index ce26b1503..109b1d125 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -1,111 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR		: William Roske
- *  CO-PILOT		: Dave Fenner
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/*
- * DESCRIPTION
- *	1.) test sbrk(8192) should return successfully.
- *	2.) test sbrk(-8192) should return successfully.
+ *  AUTHOR : William Roske, CO-PILOT : Dave Fenner
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-
-#include "test.h"
+/*\
+ * [Description]
+ *
+ * Verify that sbrk() successfully increments or decrements the program's
+ * data break.
+ */
 
-char *TCID = "sbrk01";
+#include "tst_test.h"
 
-static struct test_case_t {
+static struct tcase {
 	long increment;
-} test_cases[] = {
+} tcases[] = {
+	{0},
 	{8192},
-	{-8192},
+	{-8192}
 };
 
-static void setup(void);
-static void sbrk_verify(const struct test_case_t *);
-static void cleanup(void);
-
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			sbrk_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void sbrk_verify(const struct test_case_t *test)
+static void run(unsigned int i)
 {
 	void *tret;
+	struct tcase *tc = &tcases[i];
 
-	tret = sbrk(test->increment);
-	TEST_ERRNO = errno;
+	tret = sbrk(tc->increment);
+	TST_ERR = errno;
 
-	if (tret == (void *)-1) {
-		tst_resm(TFAIL | TTERRNO, "sbrk - Increase by %ld bytes failed",
-			 test->increment);
-	} else {
-		tst_resm(TPASS, "sbrk - Increase by %ld bytes returned %p",
-			 test->increment, tret);
-	}
+	if (tret == (void *) -1)
+		tst_res(TFAIL | TTERRNO, "sbrk(%ld) failed", tc->increment);
+	else
+		tst_res(TPASS, "sbrk(%ld) returned %p", tc->increment, tret);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases)
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
