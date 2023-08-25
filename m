Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D34C71133
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 06:40:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BB8D3CC36F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:40:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EEEC3CC441
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 794B11400331
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E26F1224A8
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692945585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6Kcez72jlsExLfH6D2XgUJlT17MtHsHEZ6Kg1xzbrM=;
 b=tnD7yV67/NtY5YvgakeReG2UDRvXyhdCJu4xKqRrROpEWKxLZfdi1SzCNdsgx+yv6U0OTo
 sepxyTCLkqQkH3XnSTOUhX8Ig82oLK0Ccv2rVubSI1ADjlg18CkVfCUAHh3TMavsuGeXvV
 IU+g629RQxv2i1iEZnlGdkbou4PNuPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692945585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6Kcez72jlsExLfH6D2XgUJlT17MtHsHEZ6Kg1xzbrM=;
 b=sD4Vcsgl5TAofBnw+g9ewNFxL7GqPx1XZx/5WG4+ymqDt2mhv2e0etyWKSJvEe8vrgc/b/
 D+B1+23qYuQXYPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FB33138F9
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZmStE7FM6GSMLwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 12:08:42 +0530
Message-ID: <20230825063932.30875-5-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825063932.30875-1-akumar@suse.de>
References: <20230825063932.30875-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] syscalls/mmap15: Rewrite test using new LTP API
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
 testcases/kernel/syscalls/mmap/mmap15.c | 117 +++++++-----------------
 1 file changed, 35 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index 443a37eb8..643ed3a8b 100644
--- a/testcases/kernel/syscalls/mmap/mmap15.c
+++ b/testcases/kernel/syscalls/mmap/mmap15.c
@@ -1,113 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
  *  Written by Robbie Williamson
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
- * Test Description: Test that a normal page cannot be mapped into a high
- * memory region.
+/*\
+ * [Description]
+ *
+ * Verify that, a normal page cannot be mapped into a high memory region,
+ * and mmap() call fails with either ENOMEM or EINVAL errno.
  */
 
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/abisize.h"
-
-char *TCID = "mmap15";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #ifdef __ia64__
-# define HIGH_ADDR (void *)(0xa000000000000000UL)
+# define HIGH_ADDR ((void *)(0xa000000000000000UL))
 #else
-# define HIGH_ADDR (void *)(-page_size)
+# define HIGH_ADDR ((void *)(-page_size))
 #endif
 
+#define TEMPFILE "mmapfile"
 static long page_size;
+static int fd;
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc, fd;
-	void *addr;
-
 #ifdef TST_ABI32
-	tst_brkm(TCONF, NULL, "This test is only for 64bit");
+	tst_brkm(TCONF, NULL, "Test is not applicable for 32-bit systems.");
 #endif
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	setup();
+	TESTPTR(mmap(HIGH_ADDR, page_size, PROT_READ, MAP_SHARED | MAP_FIXED, fd, 0));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	if (TST_RET_PTR != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() into high mem region succeeded unexpectedly");
+		SAFE_MUNMAP(TST_RET_PTR, page_size);
+		return;
+	} else if (TST_RET_PTR == MAP_FAILED && (TST_ERR == ENOMEM || TST_ERR == EINVAL))
+		tst_res(TPASS | TERRNO, "mmap() failed with expected errno");
+	else
+		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected errno");
 
-		fd = SAFE_OPEN(cleanup, "testfile", O_RDWR | O_CREAT, 0666);
-
-		/* Attempt to mmap into highmem addr, should get ENOMEM */
-		addr = mmap(HIGH_ADDR, page_size, PROT_READ,
-			    MAP_SHARED | MAP_FIXED, fd, 0);
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL, "mmap into high region "
-				 "succeeded unexpectedly");
-			munmap(addr, page_size);
-			close(fd);
-			continue;
-		}
-
-		if (errno != ENOMEM && errno != EINVAL) {
-			tst_resm(TFAIL | TERRNO, "mmap into high region "
-				 "failed unexpectedly");
-		} else {
-			tst_resm(TPASS | TERRNO, "mmap into high region "
-				 "failed as expected");
-		}
-
-		SAFE_CLOSE(cleanup, fd);
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd);
 }
 
 static void setup(void)
 {
-	tst_require_root();
-
-	tst_tmpdir();
-
 	page_size = getpagesize();
-
-	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
