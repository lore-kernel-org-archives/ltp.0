Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B99BC83F10
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 11:26:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CEB53CBEDF
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 13:26:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B8523CB6FB
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 13:26:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F5326096BE
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 13:26:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B30D51F853
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 11:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693481192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Inyhj5OZneYlbgjZQ35AlUQc8Z8fCLksW583ahQ6gag=;
 b=put5gkddUtbkKKc+E+SArxbagyYcDdrWCEKA9QKvJgOSlh3/9I3yNlb6PU4dG2s0UOIlWb
 4yGLJp40cUShctrxOOAzNgW7jfdzwWvx6vql8F+TF/7DRCF5rdhwILb8sqsG/h42JUgbXN
 lD+uwdpjd5In+Wx+tFG2tB0nXezp4P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693481192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Inyhj5OZneYlbgjZQ35AlUQc8Z8fCLksW583ahQ6gag=;
 b=/5LXrm0jzl/Xh1bPMZkAIs/TTCWaZEBfr/HyqFJ58ZyU8U9rvBoIWByR4yWA4DwHI5D+i4
 3aqSxI0yfwsMl5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA41B13583
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 11:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6708Kud48GQgWgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 11:26:31 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 31 Aug 2023 16:49:33 +0530
Message-ID: <20230831112629.21510-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap21: Add new test for mmap's ENOMEM case
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

To be more precise in this test and checking for ENOMEM on exact mapping
when limit is crossed, I could only think of counting the existing
mappings from /proc/$pid/maps and counting the remaining possible
mappings. Is there any better approach if we want to test this for exact
case?

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap21.c | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap21.c

diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
new file mode 100644
index 000000000..76002edb3
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap21.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, mmap(2) fails with errno ENOMEM when process's
+ * maximum number of mappings would have been exceeded.
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+#define TEMPFILE "mmapfile"
+static int fd;
+static size_t page_sz;
+static int max_map;
+
+static void setup(void)
+{
+	page_sz = getpagesize();
+
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+
+	SAFE_FILE_SCANF("/proc/sys/vm/max_map_count", "%d   ", &max_map);
+	tst_res(TINFO, "max_map_count: %d", max_map);
+}
+
+static void run(void)
+{
+	int i;
+	char *addr[max_map];
+
+	for (i = 0; i < max_map; i++) {
+		TESTPTR(mmap(0, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
+		if (TST_RET_PTR != MAP_FAILED) {
+			addr[i] = TST_RET_PTR;
+		} else {
+			if (TST_ERR == ENOMEM) {
+				tst_res(TINFO, "New successful mappings before exhausting the limit: %d", i);
+				tst_res(TPASS, "mmap() failed with ENOMEM");
+			} else {
+				tst_res(TINFO, "New successful mappings before mmap() failed: %d", i);
+				tst_res(TFAIL | TERRNO, "mmap() failed with unexpected errno");
+			}
+			break;
+		}
+	}
+
+	if (i == max_map)
+		tst_res(TFAIL, "mmap() crossed max_map_count limit, no of new mmapings: %d", i);
+
+	while (--i >= 0)
+		SAFE_MUNMAP(addr[i], page_sz);
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
+	.test_all = run,
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
