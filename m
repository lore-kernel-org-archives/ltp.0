Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446ADC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 06:22:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFB183C9174
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 07:22:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5255E3C5709
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:22:38 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F22921400E1C
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:22:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639981356; i=@fujitsu.com;
 bh=aGA+PN1rC0aCfBFWh5Tpv92SA1Etju/e5RilSeISOLs=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=DWXBuAiizsx/gT+eRf6kYW41L8eqvRVKyMBqjl+0JJsSPbl8+D6LIOrS1wuscc9N1
 3sOOrBGSVMpykz8epzBmsx2ey8oHXlYvL0AIZgJusEzDPHeZFZ7lkVuHtZYNdFZHpe
 XcSAfGj3RZlW1mowM5kDQM2bN3Gkl1E4V2+IA5Dwweh4s6BFjYn1Iqbf5taN1FZ0n0
 w4BtkpmmjhCFQPn93xrVmN5+B5FK8T5ux0ejXuawyuW8mtpn4pjaEtgLgw3Qbfeom4
 tlUoD01vGVU6mBkBZz4uR8Zespp0aJx2M3ZuHW8APeep7DNJuQCUb60k/+SnwnzkDB
 sWpLyjCPCdFXA==
Received: from [100.115.6.114] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.ess.symcld.net id 4A/64-14524-B2120C16;
 Mon, 20 Dec 2021 06:22:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8ORqKuteCD
 RYNJfZovpL46yWaz4voPRgclj3+91rB5nFhxhD2CKYs3MS8qvSGDN2PdpPlPBJ+mKu39bWBsY
 e8S7GDk5hAS2MEp0/w3sYuQCshcwSbSt62WEcPYzSvy9vIkFpIpNQEPi2uN2ZhBbREBU4vP0c
 2A2s4CNxL6rE8BsYQEjia1v74LVswioSmze+ZoRxOYVcJNY9PYDWI2EgILElIfvwWxOARWJi3
 eesUFcoSyx69o6Zoh6QYmTM5+wQMyXkDj44gVUr6LE/r0bGSHsCokZM7axQdhqElfPbWKewCg
 4C0n7LCTtCxiZVjFaJRVlpmeU5CZm5ugaGhjoGhqa6prpGppZ6iVW6SbqpZbqlqcWl+ga6iWW
 F+ulFhfrFVfmJuek6OWllmxiBAZ2SjHbyh2MK/t+6h1ilORgUhLlFejemyjEl5SfUpmRWJwRX
 1Sak1p8iFGGg0NJgtdK7kCikGBRanpqRVpmDjDKYNISHDxKIryTZYHSvMUFibnFmekQqVOMxh
 wfnsxdxMzRPGn5dmYhlrz8vFQpcV4TBaBSAZDSjNI8uEGw6L/EKCslzMvIwMAgxFOQWpSbWYI
 q/4pRnINRSZiXGWQKT2ZeCdy+V0CnMAGdohS+H+SUkkSElFQD05RuHtHg1t8PwxuL633thJJn
 1/36N+l+6JKLbj/zP9/NvnLF5IdZdEu+xVmF/acSZrjIhEovKNkfUsrPaxrheG3qPGWmUN+ru
 tztrm+vZzbxpOXfi+UVT5xqrbrsUubtY90/ZI93yv17M+Wt0JkTS0WO3v0+rXnLJ5Z/h3hKV1
 rLxHvcnse1eZrcPnHdx69apLPf3VA/1KVq5VzZOX9t0u3p7gfEZ+U/Ul71e5mGXUT2+TcfMwQ
 UKpNmnDLeEKSfL/R5v6Kj+LWu7c6BLPfj3kzw01fZ1yX5I0xFoi1VYYvHwtsVXAEssT7qVVk7
 zVxVc24sWevQtDTo5XpL9aUOZTcjOKvKpT0uhyieW2GqxFKckWioxVxUnAgAYZJh2nkDAAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-12.tower-591.messagelabs.com!1639981354!159827!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5900 invoked from network); 20 Dec 2021 06:22:35 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-12.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Dec 2021 06:22:35 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 852C71009FA;
 Mon, 20 Dec 2021 06:22:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 79A20100239;
 Mon, 20 Dec 2021 06:22:34 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 06:22:22 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <chrubis@suse.cz>
Date: Mon, 20 Dec 2021 14:23:04 -0500
Message-ID: <1640028184-20297-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YbMyhM7/wqbGCdgk@yuki>
References: <YbMyhM7/wqbGCdgk@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/write06: Add new test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Like pwrite04.c, test the write() system call with O_APPEND.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/write/.gitignore |  1 +
 testcases/kernel/syscalls/write/write06.c  | 95 ++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
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
index 0000000..ea30d73
--- /dev/null
+++ b/testcases/kernel/syscalls/write/write06.c
@@ -0,0 +1,95 @@
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
+ * The full description of O_APPEND is in open(2) man-pages:
+ * O_APPEND
+ *        The file is opened in append mode.  Before each write(2), the
+ * file offset is positioned at the end of the file, as if with lseek(2).
+ * The modification of the file offset and the write operation are
+ * performed as a single atomic step.
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
+static void verify_write(void)
+{
+	off_t off;
+	struct stat statbuf;
+
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC);
+	SAFE_WRITE(1, fd, write_buf[0], K2);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND);
+	SAFE_FSTAT(fd, &statbuf);
+	if (statbuf.st_size != K2)
+		tst_res(TFAIL, "file size is %ld != K2", statbuf.st_size);
+
+	off = SAFE_LSEEK(fd, K1, SEEK_SET);
+	if (off != K1)
+		tst_brk(TBROK, "Failed to seek to K1");
+
+	SAFE_WRITE(1, fd, write_buf[1], K1);
+
+	off = SAFE_LSEEK(fd, 0, SEEK_CUR);
+	if (off != K3)
+		tst_res(TFAIL, "Wrong offset after write %zu expected %u", off, K3);
+	else
+		tst_res(TPASS, "Offset is correct after write %zu", off);
+
+	SAFE_FSTAT(fd, &statbuf);
+	if (statbuf.st_size != K3)
+		tst_res(TFAIL, "Wrong file size after append %zu expected %u", statbuf.st_size, K3);
+	else
+		tst_res(TPASS, "Correct file size after append %u", K3);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	memset(write_buf[0], 0, K2);
+	memset(write_buf[1], 1, K1);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
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
+	.bufs = (struct tst_buffers[]) {
+		{&write_buf[0], .size = K2},
+		{&write_buf[1], .size = K1},
+		{}
+	}
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
