Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649B7C3DA66
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 06:40:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A483A3CC45F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:40:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 691DD3CC454
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A689060091D
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FE44224A8
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692945583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUfdK30E1rgjzar8YUyqLjoTCZx9DddAReB4hIfyDYI=;
 b=q2wRsQ4yvD6t1ys9ikZnAO81SKxW2qgVqF4WVfHtYh5vCtbiTA+Fop/r3zDDKgBaGcyOQX
 2IUH5Y1SoaBmV6vdBPvf0ndTIpQrsXYOjR0egUrVgb9v9n9XpP2GsiT9uTgHTbUs4herr1
 SOHmjQ7f3ckruW+cAVm2fRPB++quYRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692945583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUfdK30E1rgjzar8YUyqLjoTCZx9DddAReB4hIfyDYI=;
 b=gfROgQ/OrY06/BC+wUTdQSiB+qunfnWKxMB7dUqiLfv69YFR4GwSc+5n9DbTRcdara56Cq
 bs43rzOEmBKG6ACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE5AF138F9
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Eo1EI65M6GSGLwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:42 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 12:08:41 +0530
Message-ID: <20230825063932.30875-4-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825063932.30875-1-akumar@suse.de>
References: <20230825063932.30875-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] syscalls/mmap14: Rewrite test using new LTP API
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
 testcases/kernel/syscalls/mmap/mmap14.c | 135 +++++++-----------------
 1 file changed, 40 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index 31632601b..2bc63ae58 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -1,124 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Description:
- *  Verify MAP_LOCKED works fine.
- *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and this region should be locked into memory.
+ * Verify that, mmap() call with MAP_LOCKED flag successfully locks
+ * the mapped pages into memory.
  */
-#include <stdio.h>
-#include <sys/mman.h>
 
-#include "test.h"
+#include <stdio.h>
+#include "tst_test.h"
 
-#define TEMPFILE        "mmapfile"
-#define MMAPSIZE        (1UL<<20)
+#define MMAPSIZE        (1UL<<16)
 #define LINELEN         256
 
-char *TCID = "mmap14";
-int TST_TOTAL = 1;
-
 static char *addr;
-
 static void getvmlck(unsigned int *lock_sz);
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	unsigned int sz_before;
-	unsigned int sz_after;
-	unsigned int sz_ch;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		getvmlck(&sz_before);
-
-		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
-			    -1, 0);
-
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		getvmlck(&sz_after);
-
-		sz_ch = sz_after - sz_before;
-		if (sz_ch == MMAPSIZE / 1024) {
-			tst_resm(TPASS, "Functionality of mmap() "
-					"successful");
-		} else {
-			tst_resm(TFAIL, "Expected %luK locked, "
-					"get %uK locked",
-					MMAPSIZE / 1024, sz_ch);
-		}
-
-		if (munmap(addr, MMAPSIZE) != 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-	}
-
-	cleanup();
-	tst_exit();
-}
 
 void getvmlck(unsigned int *lock_sz)
 {
-	int ret;
 	char line[LINELEN];
-	FILE *fstatus = NULL;
+	FILE *fp = NULL;
 
-	fstatus = fopen("/proc/self/status", "r");
-	if (fstatus == NULL)
-		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
+	fp = fopen("/proc/self/status", "r");
+	if (fp == NULL)
+		tst_brk(TFAIL | TERRNO, "could not open status file");
 
-	while (fgets(line, LINELEN, fstatus) != NULL)
+	while (fgets(line, LINELEN, fp) != NULL) {
 		if (strstr(line, "VmLck") != NULL)
 			break;
+	}
 
-	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
-	if (ret != 1)
-		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
+	if (sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz) != 1)
+		tst_brk(TFAIL | TERRNO, "Get lock size failed");
 
-	fclose(fstatus);
+	fclose(fp);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
+	unsigned int sz_before, sz_after, sz_diff;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	getvmlck(&sz_before);
 
-	TEST_PAUSE;
-}
+	addr = mmap(0, MMAPSIZE, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
 
-static void cleanup(void)
-{
+	if (addr != MAP_FAILED)
+		tst_res(TPASS, "mmap() with MAP_LOCKED flag passed");
+	else {
+		tst_res(TFAIL | TERRNO, "mmap() failed");
+		return;
+	}
+
+	getvmlck(&sz_after);
+	sz_diff = sz_after - sz_before;
+	TST_EXP_EQ_LU(MMAPSIZE / 1024, sz_diff);
+
+	SAFE_MUNMAP(addr, MMAPSIZE);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
