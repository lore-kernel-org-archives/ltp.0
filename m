Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AAAC0015E
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 09:44:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1404F3CDDE0
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 11:44:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42A243C99AE
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 11:43:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 166941000228
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 11:43:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E28482195F;
 Mon, 17 Jul 2023 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689587034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YkA2Fe2TTxxLrvIfsN16ZGz6gBm7xvJf090rTx/SjP8=;
 b=x7sG7XyBXJdZCYRM6YEmVDiOUcvNXAW0Z3ifu/i09nlDb7fY5vVj+9VaCJz1ro1qf1n8Xu
 L8wcn+h4+7lDDOmie4jPzJ61hCcSzBexbU6h+rskRi3TlrAxhkMLwiM+0vGNpBK9MCRVKq
 GoyME++ZerKBHV1MFd18bWv+DfHHLUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689587034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YkA2Fe2TTxxLrvIfsN16ZGz6gBm7xvJf090rTx/SjP8=;
 b=nah8YhfdBSd6BgKzGXYR0NaTEzEB5r993CpgQk+MBAAH0FAKGGm0i7nubwPohuadC4hhUb
 iWAE6eHPBXOkEZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADD4F138F8;
 Mon, 17 Jul 2023 09:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c8tbKFoNtWQqUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jul 2023 09:43:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Jul 2023 11:43:48 +0200
Message-Id: <20230717094348.1105467-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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

Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Use getpagesize() to fix ppc64le (Cyril)
* Don't use ARRAY_SIZE(tcases) for mmap() size - define NUM_PAGES 3
instead (Vlastimil)

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/mremap06.c | 133 ++++++++++++++++++++
 3 files changed, 135 insertions(+)
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
index 000000000..758df66f0
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap06.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC
+ * Author: Vlastimil Babka <vbabka@suse.cz>
+ * https://bugzilla.suse.com/attachment.cgi?id=867254
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
+#define NUM_PAGES 3
+
+static int fd;
+static char *buf, *buf2;
+static int page_size, mmap_size, mremap_size;
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
+		val = buf[i * page_size];
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
+	buf = SAFE_MMAP(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	buf2 = mremap(buf + page_size, page_size, page_size,
+			MREMAP_MAYMOVE|MREMAP_FIXED, buf + mremap_size);
+	if (buf2 == MAP_FAILED)
+		tst_brk(TBROK, "mremap() failed");
+
+	if (tc->incompatible) {
+		ret = mprotect(buf + (tc->incompatible-1)*page_size, page_size, PROT_READ);
+		if (ret == -1)
+			tst_brk(TBROK, "mprotect() failed");
+	}
+
+	buf2 = mremap(buf + mremap_size, page_size, page_size,
+			MREMAP_MAYMOVE|MREMAP_FIXED, buf + page_size);
+	if (buf2 == MAP_FAILED)
+		tst_brk(TBROK, "mremap() failed");
+
+	if (!check_pages())
+		tst_res(TPASS, "mmap/mremap work properly");
+
+	SAFE_MUNMAP(buf, mremap_size);
+}
+
+static void setup(void)
+{
+	int ret, i;
+
+	page_size = getpagesize();
+	mmap_size = (NUM_PAGES+1) * page_size;
+	mremap_size = NUM_PAGES * page_size;
+
+	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
+
+	ret = fallocate(fd, 0, 0, mmap_size);
+	if (ret == -1)
+		tst_brk(TBROK, "fallocate() failed");
+
+	buf = SAFE_MMAP(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	for (i = 0; i < (int)ARRAY_SIZE(tcases)+1; i++)
+		buf[i*page_size] = 0x30 + i;
+
+	/* clear the page tables */
+	SAFE_MUNMAP(buf, mmap_size);
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
