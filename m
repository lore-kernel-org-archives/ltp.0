Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03881C001B3
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 19:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4157A3CC202
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 21:49:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39A023C99D8
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 21:49:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 540F3200756
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 21:49:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F32DF1FFF9;
 Mon,  3 Jul 2023 19:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688413754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9jLzNFbr92YroenPOc7Q2lc4FujymFdUp2WsqN+gA4Q=;
 b=X/rXwEnpCOZbknVAl8AqsYiQ5BKVjedtEkT8lCbnn29WbTF+jkRPep2ZTKeJJvD5ghjc7C
 vLJk+Hg7ctngpQJnFGJwwBlP9wKBEH5gl372as5k9bAAp/wICpHgX/+u4VQnguYdQOAXfa
 8bSK/wsJl9gkRS8mgSxoIz3ZWiplMa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688413754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9jLzNFbr92YroenPOc7Q2lc4FujymFdUp2WsqN+gA4Q=;
 b=vY913CkRPQAL4V9KsqO8zNnILo9Uc/9utm4MweSziw12E5RFojx2Pg1CujDTjcWHrepd0e
 KGb9wXswIVNWd/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B25501358E;
 Mon,  3 Jul 2023 19:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jEapKTkmo2RQWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 19:49:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  3 Jul 2023 21:49:04 +0200
Message-Id: <20230703194904.445661-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for 7e7757876f25
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
Cc: Jiri Slaby <jirislaby@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Affected system reports:

mremap06.c:69: TINFO: all pages with compatible mapping
mremap06.c:90: TPASS: mmap/mremap work properly
mremap06.c:69: TINFO: third page's mapping incompatible
mremap06.c:90: TPASS: mmap/mremap work properly
mremap06.c:69: TINFO: first page's mapping incompatible
mremap06.c:56: TFAIL: page 1 wrong value 2 (0x32)
mremap06.c:56: TFAIL: page 2 wrong value 3 (0x33)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@Cyril: I plan to add SAFE_FALLOCATE() (3 other sources),
SAFE_MPROTECT() (7 other sources) and SAFE_MREMAP()
(2 other sources), but as a separate effort.

Kind regards,
Petr

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/mremap06.c | 129 ++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b29151186..008bca508 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -845,6 +845,7 @@ mremap02 mremap02
 mremap03 mremap03
 mremap04 mremap04
 mremap05 mremap05
+mremap06 mremap06
 
 msgctl01 msgctl01
 msgctl02 msgctl02
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
index 833e1b883..ec15a19cd 100644
--- a/testcases/kernel/syscalls/mremap/.gitignore
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -3,3 +3,4 @@
 /mremap03
 /mremap04
 /mremap05
+/mremap06
diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
new file mode 100644
index 000000000..b7aa5549f
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap06.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC
+ * Author: Vlastimil Babka <vbabka@suse.cz>
+ * LTP port: Petr Vorel <pvorel@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Bug reproducer for 7e7757876f25 ("mm/mremap: fix vm_pgoff in vma_merge() case 3")
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define PAGE_SIZE 4096
+#define MMAP_SIZE ((ARRAY_SIZE(tcases)+1)*PAGE_SIZE)
+#define MREMAP_SIZE (ARRAY_SIZE(tcases)*PAGE_SIZE)
+
+static int fd;
+static char *buf, *buf2;
+
+static struct tcase {
+	size_t incompatible;
+	const char *desc;
+} tcases[] = {
+	{
+		.desc = "all pages with compatible mapping",
+	},
+	{
+		.incompatible = 3,
+		.desc = "third page's mapping incompatible",
+	},
+	{
+		.incompatible = 1,
+		.desc = "first page's mapping incompatible",
+	},
+};
+
+static int check_pages(void)
+{
+	int fail = 0, i;
+	char val;
+
+	for (i = 0; i < (int)ARRAY_SIZE(tcases); i++) {
+		val = buf[i * PAGE_SIZE];
+		if (val != 0x30 + i) {
+			tst_res(TFAIL, "page %d wrong value %d (0x%x)", i, val - 0x30, val);
+			fail = 1;
+		}
+	}
+
+	return fail;
+}
+
+static void do_test(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int ret;
+
+	tst_res(TINFO, "%s", tc->desc);
+
+	buf = SAFE_MMAP(0, MMAP_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	buf2 = mremap(buf + PAGE_SIZE, PAGE_SIZE, PAGE_SIZE,
+			MREMAP_MAYMOVE|MREMAP_FIXED, buf + MREMAP_SIZE);
+	if (buf2 == MAP_FAILED)
+		tst_brk(TBROK, "mremap() failed");
+
+	if (tc->incompatible) {
+		ret = mprotect(buf + (tc->incompatible-1)*PAGE_SIZE, PAGE_SIZE, PROT_READ);
+		if (ret == -1)
+			tst_brk(TBROK, "mprotect() failed");
+	}
+
+	buf2 = mremap(buf + MREMAP_SIZE, PAGE_SIZE, PAGE_SIZE,
+			MREMAP_MAYMOVE|MREMAP_FIXED, buf + PAGE_SIZE);
+	if (buf2 == MAP_FAILED)
+		tst_brk(TBROK, "mremap() failed");
+
+	if (!check_pages())
+		tst_res(TPASS, "mmap/mremap work properly");
+
+	SAFE_MUNMAP(buf, MREMAP_SIZE);
+}
+
+static void setup(void)
+{
+	int ret, i;
+
+	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
+
+	ret = fallocate(fd, 0, 0, MMAP_SIZE);
+	if (ret == -1)
+		tst_brk(TBROK, "fallocate() failed");
+
+	buf = SAFE_MMAP(0, MMAP_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	for (i = 0; i < (int)ARRAY_SIZE(tcases)+1; i++)
+		buf[i * PAGE_SIZE] = 0x30 + i;
+
+	/* clear the page tables */
+	SAFE_MUNMAP(buf, MMAP_SIZE);
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
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "7e7757876f25"},
+		{}
+	},
+};
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
