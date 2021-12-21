Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91490C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 07:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEF4E3C922F
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 08:03:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F60F3C4DBB
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 08:02:59 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C08427F734B
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 08:02:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1640070177; i=@fujitsu.com;
 bh=K6E1TFOHhhz4FxNC87FgTKfC9C2yP1vMojDMk/D/4qw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Uk8oHpnb8sp2Ck3CyE7vHw/lmbUlK05ABpaF6D3oxRsQR1KDlyGZHnnWXhwn/72TU
 UUTPDbDiUXbHpgZtMEbUZ8icSVnkdQuSOuHXDoATKyTohaUkPiColsusOOq2JgeWYU
 04hZsPj/NWFSbcsTAvl0pQo0khrj+vre12xZmHvUGHzcA0kjGfqCotcLJdtcE1dZJ8
 mJntViee+FUU8NqRqxJ1YQBzLsODcCrYKbDIT3IqbAlfw1p9Y/eIxg83b4bdHfhekr
 8nXfw75zMMOSoByp04BdUtyB8WJ3T2GhirMK2ZLmL/abRlvGbsXd/JycSNuA5cF14W
 EFESif117JeUg==
Received: from [100.115.7.142] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.ess.symcld.net id 1B/2C-14524-12C71C16;
 Tue, 21 Dec 2021 07:02:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsViZ8MxRVex5mC
 iwbPFEhbTXxxls1jxfQejxY9bN1gcmD32/V7H6nFmwRH2AKYo1sy8pPyKBNaMExtusRQ8ka64
 OMmrgbFdvIuRi0NI4CWjxOJl71kgnP2MEhsW72DsYuTkYBPQkLj2uJ0ZxBYREJF40f8BqIiDg
 1kgQuLPqTIQU1jASOJGhzRIBYuAqsS5v43MIGFeAReJt98jQMISAgoSUx6+BxvCCVRyaMYWVh
 BbSEBF4tftaUwgNq+AoMTJmU9YQGxmAQmJgy9eMEP0Kkrs37uREcKukJgxYxvbBEb+WUhaZiF
 pWcDItIrRKqkoMz2jJDcxM0fX0MBA19DQVNdU18jUVC+xSjdRL7VUtzy1uETXUC+xvFgvtbhY
 r7gyNzknRS8vtWQTIzBUU4pZ/+9g7O77qXeIUZKDSUmU93XpwUQhvqT8lMqMxOKM+KLSnNTiQ
 4wyHBxKErw2VUA5waLU9NSKtMwcYNzApCU4eJREeOeBpHmLCxJzizPTIVKnGI05PjyZu4iZo3
 nS8u3MQix5+XmpUuK8s0BKBUBKM0rz4AbB4vkSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWH
 eCyBTeDLzSuD2vQI6hQnoFKXw/SCnlCQipKQamGz6r+QlC0hv0W50+ubSrGop86BQpNKnWdul
 RGtx97n1G8qETk8XepXoeNNmx0Lrc8s+/+n8fT/F97pnMQf7q9ViJTqtip3m0mrXSli95Uxff
 9hwvOq35qMJt+af2ul0OW+Vz++MeN9Ud77F63/9zdLeVRLZK/QpvoS97sKpBJE5SqZtIurClb
 4N29oOzlmwfZtl/rN31zXCPfinKFdN+sR+9ZqJssdRm1c3LGMDHlyL0/RbZ2ijFOMeqZ/V7bG
 Prbhp7TyJh54z3/P+8eRNbV57yqqNcx3Pcs1Qie71jBziT7b6Cc04YaoalqP0K+nkj+qSxiKm
 aX/W7t/B1zOnS8IwPfKJoFhkTZ3ljWIlluKMREMt5qLiRABBJw2lYgMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-585.messagelabs.com!1640070177!4228!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20838 invoked from network); 21 Dec 2021 07:02:57 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-3.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 21 Dec 2021 07:02:57 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1BL72gAx029415
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
 Tue, 21 Dec 2021 07:02:49 GMT
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 21 Dec 2021 07:02:40 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <pvorel@suse.cz>
Date: Tue, 21 Dec 2021 15:03:23 -0500
Message-ID: <1640117003-627-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YcBSmpdWBnx/L/XY@pevik>
References: <YcBSmpdWBnx/L/XY@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/write06: Add new test
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
index 0000000..c175548
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
+ * The full description of O_APPEND is in open(2) man-pages:
+ * The file is opened in append mode.  Before each write(2), the
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
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
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
