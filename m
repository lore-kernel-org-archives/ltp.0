Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C23F532D4
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 05:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8706F3E2718
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 06:23:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 276153E48A7
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:22:51 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5D6401000D37
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:22:50 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NFxMEd826235; Tue, 24 Mar 2026 05:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5dkAhpz73onyDY6Zr
 itGDwYPw5Wg8tbnm446fFoWyss=; b=YIqNowWZ/NYSawZFT3OnVIjyBSDMG0hFk
 qzOd8TMY3nPwH3JU4nuPzkdpRvQ3bqr/SJ6rG+J/KEeKsF4TjMtlTYYa6dObaUvk
 rmOwgQwdTvKyGRETnle+EiQjhSwfp+71kTxH8W6qwQW+1LXrDiGcso4qPLzgkE/l
 4PHOYzFpSdepVvkJ+o/9bfcdTkV2QmHOWE9KorFE87kqoyVc6HEXBUmJdWIwxQTG
 LAv//ZG3JujOjdda52iEsMWgYdYDJ0WaENEcs+2zfxQJGLILZTDT8YHOxUgaaexl
 w9j5ZmF2uIHIx1Q3+kgaLji+31VVXqtCxfUAOkt6G3P5jUdnXZeww==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq9xch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:22:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O4rDX6004392;
 Tue, 24 Mar 2026 05:22:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2014s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:22:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O5Mj0e41943328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 05:22:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 862542004B;
 Tue, 24 Mar 2026 05:22:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A747520043;
 Tue, 24 Mar 2026 05:22:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.76.226])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 05:22:44 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 24 Mar 2026 10:52:40 +0530
Message-Id: <20260324052241.21455-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260324052241.21455-1-sachinp@linux.ibm.com>
References: <20260324052241.21455-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5lM6-aYosLxHAnzs8oVP_FXKZylo88w7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0MiBTYWx0ZWRfXzQ6c5LBRUkna
 w5a5V+ToOpfO10CKHmOq7Bo+JiA+MBTZcnAyEwkRIlmw/bxaPx+yZ4uS+Lh8idsbHqJMzP5tcNo
 QV3ZqGCRZ0FmPEWw9rMee141ZueFgSwzoytrCw779gEvUSP7NJ2qAwv1YXb5CTybOFQztK8ILS8
 HoJnxSFCdmez/gCdwgEvURb/l+BXOSa1ymXn7G8KueuTN24E71O0RqCKUGg1tjE7FARLEyHguaV
 F5zTxygrPJ/XX6+0bbNWMhvY+gmO+iSkHZQIqfMIoKpRRPS74XOx1DwE0ERk4I8MKVZ77AyfGz/
 5/xJlBPzI7nxkQkb/UkMPGaGhstYLJan8s+IkO8lrgfTPYbIc44tFKbMd9fNjl2uT7jGdccRWba
 keJU/d0bQL1DEylGeCIcKPdbGXfLH1o5Y6TiK6xeSIzG/L373oo4wz/SFTpbwDkEgfH1TBM/Rg6
 rbNmrx1pPvSQTf6YnZg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c21fa8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=IxLW_WojrLQKLWgPVKsA:9
X-Proofpoint-GUID: 5lM6-aYosLxHAnzs8oVP_FXKZylo88w7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240042
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] io_uring: Test READV and WRITEV operations
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

This test validates vectored read and write operations using io_uring.

1. IORING_OP_WRITEV - Writing data using multiple buffers (scatter)
2. IORING_OP_READV - Reading data into multiple buffers (gather)
3. Data integrity verification across multiple iovecs
4. Edge cases with different iovec configurations including zero
   buffer length

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/io_uring/.gitignore |   1 +
 .../kernel/syscalls/io_uring/io_uring04.c     | 216 ++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7dc80fe29..eacf946c5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1899,6 +1899,7 @@ membarrier01 membarrier01
 io_uring01 io_uring01
 io_uring02 io_uring02
 io_uring03 io_uring03
+io_uring04 io_uring04
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
index 9382ae413..36cd24662 100644
--- a/testcases/kernel/syscalls/io_uring/.gitignore
+++ b/testcases/kernel/syscalls/io_uring/.gitignore
@@ -1,3 +1,4 @@
 /io_uring01
 /io_uring02
 /io_uring03
+/io_uring04
diff --git a/testcases/kernel/syscalls/io_uring/io_uring04.c b/testcases/kernel/syscalls/io_uring/io_uring04.c
new file mode 100644
index 000000000..48479df1f
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*
+ * Test IORING_OP_READV and IORING_OP_WRITEV operations.
+ *
+ * This test validates vectored read and write operations using io_uring.
+ * It tests:
+ * 1. IORING_OP_WRITEV - Writing data using multiple buffers (scatter)
+ * 2. IORING_OP_READV - Reading data into multiple buffers (gather)
+ * 3. Data integrity verification across multiple iovecs
+ * 4. Edge cases with different iovec configurations
+ */
+
+#include "io_uring_common.h"
+
+#define TEST_FILE "io_uring_test_file"
+#define QUEUE_DEPTH 2
+#define NUM_VECS 4
+#define VEC_SIZE 1024
+#define VAR_BUF1_SIZE 512
+#define VAR_BUF2_SIZE 1024
+#define VAR_BUF3_SIZE 256
+
+static struct iovec *write_iovs, *read_iovs;
+static struct iovec *var_write_iovs, *var_read_iovs;
+static struct io_uring_submit s;
+static sigset_t sig;
+
+static void prepare_write_buffers(void)
+{
+	size_t i, j;
+	char *buf;
+
+	for (i = 0; i < NUM_VECS; i++) {
+		buf = (char *)write_iovs[i].iov_base;
+		for (j = 0; j < write_iovs[i].iov_len; j++) {
+			/* Each vector has a different pattern */
+			buf[j] = 'A' + i + (j % 26);
+		}
+	}
+}
+
+static void prepare_read_buffers(void)
+{
+	size_t i;
+
+	for (i = 0; i < NUM_VECS; i++)
+		memset(read_iovs[i].iov_base, 0, read_iovs[i].iov_len);
+}
+
+static void clear_iovec_buffers(struct iovec *iovs, int nvecs)
+{
+	int i;
+
+	for (i = 0; i < nvecs; i++)
+		memset(iovs[i].iov_base, 0, iovs[i].iov_len);
+}
+
+static void verify_iovec_data(struct iovec *write_iovs, struct iovec *read_iovs,
+			      int nvecs, const char *test_name)
+{
+	int i;
+	size_t j;
+
+	for (i = 0; i < nvecs; i++) {
+		if (write_iovs[i].iov_len != read_iovs[i].iov_len) {
+			tst_res(TFAIL, "%s: iovec %d length mismatch: write=%zu read=%zu",
+				test_name, i, write_iovs[i].iov_len, read_iovs[i].iov_len);
+			return;
+		}
+
+		if (memcmp(write_iovs[i].iov_base, read_iovs[i].iov_base,
+			   write_iovs[i].iov_len) != 0) {
+			tst_res(TFAIL, "%s: data mismatch in vector %d", test_name, i);
+			for (j = 0; j < write_iovs[i].iov_len && j < 64; j++) {
+				char *wbuf = (char *)write_iovs[i].iov_base;
+				char *rbuf = (char *)read_iovs[i].iov_base;
+				if (wbuf[j] != rbuf[j]) {
+					tst_res(TINFO, "Vector %d: first mismatch at "
+						"offset %zu: wrote 0x%02x, read 0x%02x",
+						i, j, wbuf[j], rbuf[j]);
+					break;
+				}
+			}
+			return;
+		}
+	}
+
+	tst_res(TPASS, "%s: data integrity verified across %d vectors",
+		test_name, nvecs);
+}
+
+
+static void test_writev_readv(void)
+{
+	int fd;
+	int total_size = NUM_VECS * VEC_SIZE;
+
+	tst_res(TINFO, "Testing IORING_OP_WRITEV and IORING_OP_READV");
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO, "Writing %d bytes using %d vectors", total_size, NUM_VECS);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, NUM_VECS,
+			      0, total_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO, "Reading %d bytes using %d vectors", total_size, NUM_VECS);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS,
+			      0, total_size, &sig);
+
+	verify_iovec_data(write_iovs, read_iovs, NUM_VECS, "Basic vectored I/O");
+
+	SAFE_CLOSE(fd);
+}
+
+static void test_partial_vectors(void)
+{
+	int fd;
+	int half_size = 2 * VEC_SIZE;
+
+	tst_res(TINFO, "Testing partial vector operations");
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	/* Write first half using first 2 vectors at offset 0 */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, 2, 0,
+			      half_size, &sig);
+
+	/* Write second half using next 2 vectors at offset half_size */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, &write_iovs[2], 2,
+			      half_size, half_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	/* Read back entire file using all 4 vectors */
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS, 0,
+			      NUM_VECS * VEC_SIZE, &sig);
+
+	verify_iovec_data(write_iovs, read_iovs, NUM_VECS, "Partial vector I/O");
+
+	SAFE_CLOSE(fd);
+}
+
+static void test_varying_sizes(void)
+{
+	int fd;
+	int expected_size = VAR_BUF1_SIZE + VAR_BUF2_SIZE + VAR_BUF3_SIZE;
+
+	tst_res(TINFO, "Testing vectors with varying sizes including zero-length buffer");
+
+	io_uring_init_buffer_pattern(var_write_iovs[0].iov_base, VAR_BUF1_SIZE, 'X');
+	io_uring_init_buffer_pattern(var_write_iovs[2].iov_base, VAR_BUF2_SIZE, 'Y');
+	io_uring_init_buffer_pattern(var_write_iovs[3].iov_base, VAR_BUF3_SIZE, 'Z');
+
+	clear_iovec_buffers(var_read_iovs, 4);
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, var_write_iovs, 4, 0,
+			      expected_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, var_read_iovs, 4, 0,
+			      expected_size, &sig);
+
+	verify_iovec_data(var_write_iovs, var_read_iovs, 4, "Varying size vector I/O with zero-length buffer");
+
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	test_writev_readv();
+	test_partial_vectors();
+	test_varying_sizes();
+}
+
+static void setup(void)
+{
+	io_uring_setup_supported_by_kernel();
+	sigemptyset(&sig);
+	memset(&s, 0, sizeof(s));
+	io_uring_setup_queue(&s, QUEUE_DEPTH, 0);
+	prepare_write_buffers();
+	prepare_read_buffers();
+}
+
+static void cleanup(void)
+{
+	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&write_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE, VEC_SIZE, VEC_SIZE, -1}},
+		{&read_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE, VEC_SIZE, VEC_SIZE, -1}},
+		{&var_write_iovs, .iov_sizes = (int[]){VAR_BUF1_SIZE, 0, VAR_BUF2_SIZE, VAR_BUF3_SIZE, -1}},
+		{&var_read_iovs, .iov_sizes = (int[]){VAR_BUF1_SIZE, 0, VAR_BUF2_SIZE, VAR_BUF3_SIZE, -1}},
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
