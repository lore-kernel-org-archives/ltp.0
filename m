Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EDFC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 08:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96DAB3C1D4C
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 09:16:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0D0C3C0B78
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 09:16:48 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2D916000BE
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 09:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638778607; i=@fujitsu.com;
 bh=nOMsQ5OQPuchjtkHV61y9E/Gb8rf3xpCF1R/OaXUEjc=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=yg71ZMOuPrQCP3J4hoGBntfsP7y1sst6s3gW4vG9C0qTBU1ZIKxHO4Vfgz1PRy/eC
 zkcH3Vam40Jrp8sfBKBMSSgfnUhi1tdbnaDDsL111iRaNMMAy44QS9N0QDfn+X6mqA
 568iKexl/4PhgP8sR7Ecf8gJRhCL4UwBc1s6j9YWEmHdH1wfmvDgzWE7R5Uo3c5jR1
 27nfVEfakP/cFC1543Fl84e+AcgWV+yzJJfxgFpvdt5c8PWbk3KNjF/ymQQ02hJybV
 erbQ0o1wTlIJgmsg1zylMQHprgP/SK5QP1RsADC9LGW77HxA4ne7+ya1ewT3K7nFT7
 6GSYZmzbJMNUw==
Received: from [100.115.1.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 2E/4E-06911-EE6CDA16;
 Mon, 06 Dec 2021 08:16:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8ORqPvu2Np
 Eg76FWhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8al5ReZCvqkKto/NrM1ML4W7WLk5BASOMso
 cWOiYxcjF5C9k0niX89JRghnH6PEhYnrGUGq2AQ0JK49bmcGsUUEJCQ6Gt6yg9jMAmoSu68eY
 wOxhQX0JR53zGACsVkEVCRmbNnICmLzCrhJPP27C6xeQkBBYsrD98wQcUGJkzOfsEDMkZA4+O
 IFM0SNosT+vRsZIewKiRkztrFB2GoSV89tYp7AyD8LSfssJO0LGJlWMVolFWWmZ5TkJmbm6Bo
 aGOgaGprqmugaGVvqJVbpJuqlluqWpxaX6BrqJZYX66UWF+sVV+Ym56To5aWWbGIEBmVKMcv7
 HYxNfT/1DjFKcjApifL+v7M6UYgvKT+lMiOxOCO+qDQntfgQowwHh5IEr+LhtYlCgkWp6akVa
 Zk5wAiBSUtw8CiJ8E4BSfMWFyTmFmemQ6ROMRpzfHgydxEzR/Ok5duZhVjy8vNSpcR5Nx8FKh
 UAKc0ozYMbBIvcS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEefeCTOHJzCuB2/cK6BQmoFN
 i+leDnFKSiJCSamCKdktdvOfhrIAf5zP9oyseef8uNzppr+57fErPDlUumbyf13cGMdpoT2N/
 fmotV/tfP462oIV7k2Zv1iqd0OKqbBa5K2cn7ymp6XvX2POespkr4rVxEluKYIX1lLmN4sLrM
 zpun3nEFDvf6G3+qbNzDjDbPjvM96FpmX1I/THzq0Leq7s4N8vuUthtdqbDKcA9mklo6TKBsx
 dedVaEK1o9K11Z1+ntW3i5ZWOr8+dHP52/TOJ/7Jwc1lA+xU1I8N9kTY8F2p/FviSy7uCtrmn
 +fzJKobus+sIf83yNhqBEhsXvvm19O/fLecnZC9b9nnODbUqzzOU5Zd5f2K//ajScccPudaJ4
 rj131brTB5crsRRnJBpqMRcVJwIAYDEEkFcDAAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-5.tower-587.messagelabs.com!1638778606!199456!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8557 invoked from network); 6 Dec 2021 08:16:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-5.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Dec 2021 08:16:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 1C70F1009FC
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 08:16:46 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0F7C21009E7
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 08:16:46 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 6 Dec 2021 08:16:34 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 6 Dec 2021 16:17:14 -0500
Message-ID: <1638825434-10768-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/write06: Add new test
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

Like pwrite04.c, test the write() system call with O_APPEND.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/write/.gitignore |  1 +
 testcases/kernel/syscalls/write/write06.c  | 94 ++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/write/write06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bcf3d56..32fcda4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1699,6 +1699,7 @@ write02 write02
 write03 write03
 write04 write04
 write05 write05
+write06 write06
 
 writev01 writev01
 writev02 writev02
diff --git a/testcases/kernel/syscalls/write/.gitignore b/testcases/kernel/syscalls/write/.gitignore
index 7f36194..8529aae 100644
--- a/testcases/kernel/syscalls/write/.gitignore
+++ b/testcases/kernel/syscalls/write/.gitignore
@@ -3,3 +3,4 @@
 /write03
 /write04
 /write05
+/write06
diff --git a/testcases/kernel/syscalls/write/write06.c b/testcases/kernel/syscalls/write/write06.c
new file mode 100644
index 0000000..c62a266
--- /dev/null
+++ b/testcases/kernel/syscalls/write/write06.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Dai Shili <daisl.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test the write() system call with O_APPEND.
+ *
+ * Writing 2k data to the file, close it and reopen it with O_APPEND.
+ * Verify that the file size is 3k and offset is moved to the end of the file.
+ */
+
+#include <stdlib.h>
+#include <inttypes.h>
+#include "tst_test.h"
+#include "tst_safe_prw.h"
+
+#define K1              1024
+#define K2              (K1 * 2)
+#define K3              (K1 * 3)
+#define DATA_FILE       "write06_file"
+
+static int fd = -1;
+static char *write_buf[2];
+
+static void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
+{
+	off_t offloc;
+
+	offloc = SAFE_LSEEK(fdesc, offset, whence);
+	if (offloc != checkoff) {
+		tst_res(TFAIL, "%" PRId64 " = lseek(%d, %" PRId64 ", %d) != %" PRId64,
+			(int64_t)offloc, fdesc, (int64_t)offset, whence, (int64_t)checkoff);
+	}
+}
+
+static void verify_write(void)
+{
+	int fail = 0;
+	struct stat statbuf;
+
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	SAFE_WRITE(1, fd, write_buf[0], K2);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND, 0666);
+	SAFE_FSTAT(fd, &statbuf);
+	if (statbuf.st_size != K2) {
+		fail++;
+		tst_res(TFAIL, "file size is %ld != K2", statbuf.st_size);
+	}
+
+	l_seek(fd, K1, SEEK_SET, K1);
+	SAFE_WRITE(1, fd, write_buf[1], K1);
+	l_seek(fd, 0, SEEK_CUR, K3);
+	SAFE_FSTAT(fd, &statbuf);
+	if (statbuf.st_size != K3) {
+		fail++;
+		tst_res(TFAIL, "file size is %ld != K3", statbuf.st_size);
+	}
+
+	if (!fail)
+		tst_res(TPASS, "O_APPEND test passed.");
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	write_buf[0] = SAFE_MALLOC(K2);
+	memset(write_buf[0], 0, K2);
+	write_buf[1] = SAFE_MALLOC(K1);
+	memset(write_buf[0], 1, K1);
+}
+
+static void cleanup(void)
+{
+	free(write_buf[0]);
+	free(write_buf[1]);
+
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+
+	SAFE_UNLINK(DATA_FILE);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_write,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
