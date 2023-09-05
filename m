Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74609C83F33
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 13:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9996E3CEB64
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 15:31:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE9543C995F
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 15:31:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D8C77201733
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 15:31:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10B481FDEB
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693920681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CHIgbnU86A3ySDbH1UxOImH4ABoF3LnvxxWWob+PCY=;
 b=mCVWMOkx+/HAgqGmfUogR/uiRzVNKIQGS5bOZRFWeHg09pylNewn9OWjagfLDnAbM6BcMl
 3UDt7kZdKbMFGQwUVLhD6uByYlarRbeCVws8b2DZyeFGzSxs/tvQWTH0QR/vU3KjhU6LPm
 X02WHrX5jQQIPhrV0DPh2E9rkMI6VEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693920681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CHIgbnU86A3ySDbH1UxOImH4ABoF3LnvxxWWob+PCY=;
 b=xhKDLLEhKeCox2DkSWGVyP1g+1nMrWVzgzDQLjeKQlv6TZz0ptsBKe7BNIMK2Pmpe5TDFu
 gyiGsA1bjvYzMADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F42713499
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 13:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o2JBG6gt92TrNwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 05 Sep 2023 13:31:20 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 18:58:45 +0530
Message-ID: <20230905133118.23912-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825063932.30875-4-akumar@suse.de>
References: <20230825063932.30875-4-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/mmap14: Rewrite test using new LTP API
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

Changes in v2:
- Check RLIMIT_MEMLOCK before trying to map locked pages


 testcases/kernel/syscalls/mmap/mmap14.c | 138 ++++++++----------------
 1 file changed, 46 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index 31632601b..fba07ef3c 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -1,124 +1,78 @@
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
+#define MMAPSIZE        (1UL<<21)
 #define LINELEN         256
 
-char *TCID = "mmap14";
-int TST_TOTAL = 1;
-
 static char *addr;
-
 static void getvmlck(unsigned int *lock_sz);
-static void setup(void);
-static void cleanup(void);
+static struct rlimit rlim;
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
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
+	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &rlim);
 }
 
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
+		tst_brk(TFAIL | TERRNO, "Getting locked memory size failed");
 
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
+	if (((sz_before * 1024) + MMAPSIZE) > rlim.rlim_cur)
+		tst_brk(TBROK, "Trying to exceed RLIMIT_MEMLOCK limit");
 
-static void cleanup(void)
-{
+	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
+
+	if (addr != MAP_FAILED) {
+		tst_res(TPASS, "mmap() with MAP_LOCKED flag passed");
+	} else {
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
+	.setup = setup,
+	.test_all = run
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
