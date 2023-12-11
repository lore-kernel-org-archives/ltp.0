Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E20C4332F
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 20:49:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 184993CF846
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 21:49:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B08603CB7AB
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 21:49:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6BE7F600AFC
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 21:49:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2DF91FBBF
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 20:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702327749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuVxwer6XN8tKkd4PEQKCO067A+UrzghIiGp+hVVMB4=;
 b=CFWAeBKcJdnKq3PdfCJcOEOU6h/+K0Bpc1u0KUCPRgElrPKyoamIIRCsw+4z3THfdpw2YN
 ecARjodbjp0pjXjlspxcQ/z6pnrNKXYueYttKM2jLZGh86c9SJk2YZfPB2HFrzqEOTU5yW
 iS9uvAL/oSFDM5bhoYVyE405FxAocQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702327749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuVxwer6XN8tKkd4PEQKCO067A+UrzghIiGp+hVVMB4=;
 b=D9D9SOy66go5eSgUHP2WcDE0AFqM53n5kDb50vTkOvWsg0gmJOECFdQ8PedtKkgh9By/Za
 7z26z/xRVc+YGjDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702327749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuVxwer6XN8tKkd4PEQKCO067A+UrzghIiGp+hVVMB4=;
 b=CFWAeBKcJdnKq3PdfCJcOEOU6h/+K0Bpc1u0KUCPRgElrPKyoamIIRCsw+4z3THfdpw2YN
 ecARjodbjp0pjXjlspxcQ/z6pnrNKXYueYttKM2jLZGh86c9SJk2YZfPB2HFrzqEOTU5yW
 iS9uvAL/oSFDM5bhoYVyE405FxAocQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702327749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuVxwer6XN8tKkd4PEQKCO067A+UrzghIiGp+hVVMB4=;
 b=D9D9SOy66go5eSgUHP2WcDE0AFqM53n5kDb50vTkOvWsg0gmJOECFdQ8PedtKkgh9By/Za
 7z26z/xRVc+YGjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E180E133DE
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 20:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RmLFNsR1d2VzHwAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 20:49:08 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Dec 2023 21:49:06 +0100
Message-ID: <20231211204908.7212-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZUEd79N7aiC_VCDO@yuki>
References: <ZUEd79N7aiC_VCDO@yuki>
MIME-Version: 1.0
X-Spamd-Result: default: False [8.82 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[100.00%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.896]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/mmap15: Rewrite test using new LTP API
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
 testcases/kernel/syscalls/mmap/mmap15.c | 115 +++++++-----------------
 1 file changed, 34 insertions(+), 81 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index 443a37eb8..42005a9ec 100644
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
+	tst_brk(TCONF, "Test is not applicable for 32-bit systems.");
 #endif
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	setup();
+	TESTPTR(mmap(HIGH_ADDR, page_size, PROT_READ, MAP_SHARED | MAP_FIXED, fd, 0));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
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
+	if (TST_RET_PTR != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() into high mem region succeeded unexpectedly");
+		SAFE_MUNMAP(TST_RET_PTR, page_size);
+		return;
 	}
+	if (TST_ERR == ENOMEM || TST_ERR == EINVAL)
+		tst_res(TPASS | TERRNO, "mmap() failed with expected errno");
+	else
+		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected errno");
 
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
+	.needs_tmpdir = 1
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
