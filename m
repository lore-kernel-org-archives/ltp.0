Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4D1CD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 563B63E2C34
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:35:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B20833CB935
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:34:26 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 412E46006FA
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:34:24 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6470HhKb2531361
 for <ltp@lists.linux.it>; Thu, 7 May 2026 07:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zOn0+vu1z380XNq3r
 Z7LaX3wq1z/VwCoIXfAp3FTuxA=; b=m5emLiT4DWqBs+o1oNISGbSGAXLuWf/A0
 w7oKwGrzSIiYBwhbC6TrE/YUTqD82yn9q83+FqziFXsOM2/c1HaRAqIbPUcMsj91
 Iy/kefG6nJOElI3CHe6GssjIFs2Lu3UyC+xuWXlKwHmTMJadaGhswb7aVJdu2Pnw
 pkRtVs/2gCQxUDcBxLtDdp6rHJyyG1dmtW9a0HgkkajSQGvghO2c95/LU01kmD80
 w9TEPPeXsTgbmsNrTtcW7CtoBH1sqN6EnzVuXrWDWtuRyzViw6An//ZqLB+yJBF7
 mG5SOXoe053SL1+Yu7AMPiJ1xvPqKh6vW9TwI7N73nV5qAAZQGRrw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1ms7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:34:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6477OQ0R005978
 for <ltp@lists.linux.it>; Thu, 7 May 2026 07:34:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yhr85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:34:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6477YKH547579544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 7 May 2026 07:34:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62C552004D
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:34:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F22B520040
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:34:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.69.33])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:34:19 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 13:04:15 +0530
Message-Id: <20260507073417.64123-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260507073417.64123-1-sachinp@linux.ibm.com>
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6d2CqwZfoh-QWOCMxXsxFnyqJ-zGB9sd
X-Proofpoint-GUID: 6d2CqwZfoh-QWOCMxXsxFnyqJ-zGB9sd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2OCBTYWx0ZWRfX9QAlNIFLOfyT
 lV2WVefcrEzYTADMMi+wc4PtP8+ys6OrPgqgNgjoq9VNRpqyYkAEbGk1Tny6gz8xW3BHOO6SRCt
 BYY4uR9QT4l/uT50BNTB9afw4lzW5VV/Ne7seH9MAxlLQ9BVJrxPeJg+bBJ/7KfUS0HPYPUJfVz
 SV3U73t1mr8dao7Oz4/cGoPd+ItrrMrLe/4U3GMayAU48LHl235r+L1m9Y/m4xNKO5qLXJzQEM2
 fcCk4PWkj45w4fu5yfLWPY74xDneGxYALR3yghHpblBBaMitRh0v/PH9iP27h8ErF3VxYPVd7iV
 tfpNrXP3tX6j26EqSZQ6gfbcBJlu6Oo3ffnCeV13YEjlqzEGhtE0wf/Z/1e1bIKOkflgmYxXsYR
 trrv1+ppXv8ILoMh6VC0NQPWQCdPZ5sGy/PJ8FNoNQNUgTbtgfanpl0c/Rb62o3bcF0nBpLv5ji
 TdOUM2In4ZSF6UU9GQw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc407f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OS0R9qBVti0dcaTN2e4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070068
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] io_uring: Add io_uring05 test for partial
 vector operations
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

Add new test case io_uring05.c to validate vectored I/O operations
using partial vector sets with different file offsets.

The test performs:
- IORING_OP_WRITEV: Write first half using first 2 vectors at offset 0
- IORING_OP_WRITEV: Write second half using next 2 vectors at offset 2048
- IORING_OP_READV: Read entire file using all 4 vectors
- Data integrity verification across all vectors

This validates that io_uring correctly handles partial vector operations
and maintains data integrity when using different vector subsets with
specific file offsets.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V2 changes:
- Updated subject prefix to align with rest of the series
- Declare fd as static with file scope.
- Reset fd at the top of run(), and close it in cleanup()
- Remove extra blank line from description
- Link to v1 https://lore.kernel.org/ltp/20260506183750.97191-1-sachinp@linux.ibm.com/T/#t

---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/io_uring/.gitignore |  1 +
 .../kernel/syscalls/io_uring/io_uring05.c     | 98 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6b047b5fd..bab0e8f3b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1905,6 +1905,7 @@ io_uring01 io_uring01
 io_uring02 io_uring02
 io_uring03 io_uring03
 io_uring04 io_uring04
+io_uring05 io_uring05
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
index 36cd24662..bce7048cd 100644
--- a/testcases/kernel/syscalls/io_uring/.gitignore
+++ b/testcases/kernel/syscalls/io_uring/.gitignore
@@ -2,3 +2,4 @@
 /io_uring02
 /io_uring03
 /io_uring04
+/io_uring05
diff --git a/testcases/kernel/syscalls/io_uring/io_uring05.c b/testcases/kernel/syscalls/io_uring/io_uring05.c
new file mode 100644
index 000000000..ea58a8222
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring05.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*\
+ * Test partial vector operations with IORING_OP_READV and IORING_OP_WRITEV.
+ *
+ * This test validates vectored I/O operations using partial vector sets
+ * and different file offsets. It performs:
+ * 1. IORING_OP_WRITEV - Writing first half using first 2 vectors at offset 0
+ * 2. IORING_OP_WRITEV - Writing second half using next 2 vectors at offset
+ *    2048
+ * 3. IORING_OP_READV - Reading entire file using all 4 vectors
+ * 4. Data integrity verification across all vectors
+ */
+
+#include "io_uring_common.h"
+
+#define TEST_FILE "io_uring_test_file"
+#define QUEUE_DEPTH 2
+#define NUM_VECS 4
+#define VEC_SIZE 1024
+
+static struct iovec *write_iovs, *read_iovs;
+static struct io_uring_submit s;
+static sigset_t sig;
+static int fd = -1;
+
+static void run(void)
+{
+	int half_size = 2 * VEC_SIZE;
+
+	fd = -1;
+
+	io_uring_init_iovec_pattern(write_iovs, NUM_VECS, 'A', 1);
+	io_uring_clear_iovec(read_iovs, NUM_VECS);
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO, "Writing first half using first 2 vectors at offset 0");
+	/* Write first half using first 2 vectors at offset 0 */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, 2, 0,
+			      half_size, &sig);
+
+	tst_res(TINFO,
+		"Writing second half using next 2 vectors at offset %d",
+		half_size);
+	/* Write second half using next 2 vectors at offset half_size */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, &write_iovs[2], 2,
+			      half_size, half_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO, "Reading entire file using all 4 vectors");
+	/* Read back entire file using all 4 vectors */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS, 0,
+			      NUM_VECS * VEC_SIZE, &sig);
+
+	io_uring_verify_iovec(write_iovs, read_iovs, NUM_VECS);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	io_uring_setup_supported_by_kernel();
+	sigemptyset(&sig);
+	memset(&s, 0, sizeof(s));
+	io_uring_setup_queue(&s, QUEUE_DEPTH, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+
+	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&write_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE,
+						   VEC_SIZE, VEC_SIZE, -1}},
+		{&read_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE,
+						  VEC_SIZE, VEC_SIZE, -1}},
+		{}
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/io_uring_disabled", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
