Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FC7C83F12
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 11:29:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 052403CCB2F
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 13:29:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34EFB3CBDBF
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 13:28:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B68B01BB9C0B
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 13:28:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34FC32185A
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693481332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7h8hj5syjYVzVfq2ErTP3mLtg75OdLxkApdO9mDzVU8=;
 b=E2P2IEcNCgSFEbIZpPXzgAELCE/7vNkXil1u4Ygt4S87bjvka9jesxFnB/SsScW97X653u
 losmgmZbsjpRnlm8wBQvGePDSF3CCQ+fc6SKxvkbuo2ZMo+yDbI1sCrqf1OV8gAp4E9iSI
 Z1Tx02NUaGgrb8EbGN797ArubAS9mJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693481332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7h8hj5syjYVzVfq2ErTP3mLtg75OdLxkApdO9mDzVU8=;
 b=QHJ4ujn07Wdj+ccGfxWh8ill5a6KTnwfCD2+WC9TFtZk2RIHX1XN3s+/L0t4mCNyN7XLrD
 9dgziUtKlkrmKxBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C52DE13583
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 11:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3aUJJXN58GSTWwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 11:28:51 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 31 Aug 2023 16:58:48 +0530
Message-ID: <20230831112849.22126-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap22: Add new test for validating mmap's
 EINVAL scenarios
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
 testcases/kernel/syscalls/mmap/mmap22.c | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap22.c

diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
new file mode 100644
index 000000000..98e8b05e2
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, mmap() call fails with errno EINVAL when
+ *
+ * - length argument is 0.
+ * - flags contains none of MAP_PRIVATE, MAP_SHARED, or MAP_SHARED_VALIDATE.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define TEMPFILE "mmapfile"
+#define MMAPSIZE 1024
+static size_t page_sz;
+static int fd;
+
+static struct tcase {
+	size_t length;
+	int prot;
+	int flags;
+} tcases[] = {
+	{0, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED},
+	{MMAPSIZE, PROT_READ | PROT_WRITE, MAP_FILE},
+};
+
+static void setup(void)
+{
+	char *buf;
+
+	page_sz = getpagesize();
+	buf = SAFE_MALLOC(page_sz);
+	memset(buf, 'A', page_sz);
+
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, page_sz);
+	free(buf);
+}
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TESTPTR(mmap(0, tc->length, tc->prot, tc->flags, fd, 0));
+
+	if (TST_RET_PTR != MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() was successful unexpectedly");
+		SAFE_MUNMAP(TST_RET_PTR, page_sz);
+	} else if (TST_ERR == EINVAL) {
+		tst_res(TPASS, "mmap() failed with errno EINVAL");
+	} else {
+		tst_res(TFAIL | TERRNO, "mmap() failed but unexpected errno");
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
