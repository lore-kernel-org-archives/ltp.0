Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA970103E160
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A05463E5CAB
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:04:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14BBC3E57EA
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:03:39 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C65C1A00FFE
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:03:37 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I9dWkB737432
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GiZlC1D1kkG3eujJT
 LxLAUEn8Fiokn3XSFKriryWJqw=; b=K89lXpwhSwtAnagnG2y+A5WQEX7nxEfJa
 yHbnH5I2Q0p1+X7xD4wX0DoA09ucId+Pc1o3lo78wjZthFH1VLPUSdBCEjFs/lOC
 UWOGNfLly91Lv2lXLBR092Z1UTPtM4ZTKbYLHKbl1z/LXfarvSQq6kq4L6FI8CBD
 +rjG2Ce7VEPmmiiB+cQqe6XgjlasItPePYzvz+9xmnIdPyVBMCr/JjgEOOv/52cw
 njVp0EQUejfQCYDVJnZdx4rkVj2OIACXeqg4kQ+n/1D19rHH4Wc2E5bWLEMa/6s2
 ewS4hRh5t+xH5mM/Zh3+1HaReGpHtWcCl+/GinKlnNQpLtk0uR5jQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs9gw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I91IuV013997
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy5qhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IB3WVj61735352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E14552004F
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A56E20040
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.26])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:31 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 16:33:28 +0530
Message-Id: <20260318110328.52031-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260318110328.52031-1-sachinp@linux.ibm.com>
References: <20260318110328.52031-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69ba8687 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=TSZxUyTAg8EgoU-MXZ4A:9
X-Proofpoint-ORIG-GUID: bWfsTbZTtGl3vb_Vc_bPDu1agJPxsxGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5MCBTYWx0ZWRfX0r0Ix9i2VnAN
 6jlql9gUgyuX8s2jVVap+GeNGzF2v9wt+dnHCXRCegiX27IBd8iH0uqHkHGzCAf7XqtYv4wV+hC
 28cC51xxqSRz3oGsqgls1WNFiXqADIZF/qFI+z5kR/ZanttzytctqRwq1TYXnErT08DWh+TAVhW
 MxygyfdU8eNRHTDHnYrW5t5WokEKT55Z8dV8WX6YGYhaUBDbLNbKSLkGNZ5Os+Pw5OyMbXmkJvy
 g++bWgkdULreBcCZ/vgDnqf9Fiph2n0nPbnU2FEmQopj0UDdmbhAsyb0j4qC4NDlQIRLg3aJPEm
 l+F2YEON64gfpJh9H+ecg5CloZSyimWwi04fqB1aqthQmif9Ol9Vl9SvpNUViARpx5F2cnvwhly
 rVysKDtOqKxfPY8vAXu5R2l0ay0ANkWEKW8CQNKgeArrrzrh6t1U75Q3mdm7KkGNC/82kP4JNz0
 MW1g7HHsw6bs8JAJSOA==
X-Proofpoint-GUID: bWfsTbZTtGl3vb_Vc_bPDu1agJPxsxGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180090
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] [PATCH 2/2] io_uring: Test READV and WRITEV operations
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
It tests:
 1. IORING_OP_WRITEV - Writing data using multiple buffers (scatter)
 2. IORING_OP_READV - Reading data into multiple buffers (gather)
 3. Data integrity verification across multiple iovecs
 4. Edge cases with different iovec configurations

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/io_uring/.gitignore |   1 +
 .../kernel/syscalls/io_uring/io_uring04.c     | 248 ++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7dc80fe29..100ae7706 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1899,6 +1899,7 @@ membarrier01 membarrier01
 io_uring01 io_uring01
 io_uring02 io_uring02
 io_uring03 io_uring03
+io_uring03 io_uring04
 
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
index 000000000..fa61f0962
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ *
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
+
+static char write_bufs[NUM_VECS][VEC_SIZE];
+static char read_bufs[NUM_VECS][VEC_SIZE];
+static struct iovec write_iovs[NUM_VECS];
+static struct iovec read_iovs[NUM_VECS];
+static struct io_uring_submit s;
+static sigset_t sig;
+
+static void prepare_write_buffers(void)
+{
+	size_t i, j;
+
+	for (i = 0; i < NUM_VECS; i++) {
+		for (j = 0; j < VEC_SIZE; j++) {
+			/* Each vector has a different pattern */
+			write_bufs[i][j] = 'A' + i + (j % 26);
+		}
+		write_iovs[i].iov_base = write_bufs[i];
+		write_iovs[i].iov_len = VEC_SIZE;
+	}
+}
+
+static void prepare_read_buffers(void)
+{
+	size_t i;
+
+	for (i = 0; i < NUM_VECS; i++) {
+		memset(read_bufs[i], 0, VEC_SIZE);
+		read_iovs[i].iov_base = read_bufs[i];
+		read_iovs[i].iov_len = VEC_SIZE;
+	}
+}
+
+static void test_writev_readv(void)
+{
+	int fd;
+	size_t i, j;
+	int total_size = NUM_VECS * VEC_SIZE;
+
+	tst_res(TINFO, "Testing IORING_OP_WRITEV and IORING_OP_READV");
+
+	prepare_write_buffers();
+	prepare_read_buffers();
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	/* Test IORING_OP_WRITEV */
+	tst_res(TINFO, "Writing %d bytes using %d vectors", total_size, NUM_VECS);
+	io_uring_submit_sqe_vec(&s, fd, IORING_OP_WRITEV, write_iovs,
+				NUM_VECS, 0);
+
+	if (io_uring_wait_cqe(&s, total_size, IORING_OP_WRITEV, &sig) == 0)
+		tst_res(TPASS, "IORING_OP_WRITEV completed successfully");
+
+	SAFE_FSYNC(fd);
+
+	/* Test IORING_OP_READV */
+	tst_res(TINFO, "Reading %d bytes using %d vectors", total_size, NUM_VECS);
+	io_uring_submit_sqe_vec(&s, fd, IORING_OP_READV, read_iovs,
+				NUM_VECS, 0);
+
+	if (io_uring_wait_cqe(&s, total_size, IORING_OP_READV, &sig) == 0)
+		tst_res(TPASS, "IORING_OP_READV completed successfully");
+
+	/* Verify data integrity for each vector */
+	for (i = 0; i < NUM_VECS; i++) {
+		if (memcmp(write_bufs[i], read_bufs[i], VEC_SIZE) != 0) {
+			tst_res(TFAIL, "Data mismatch in vector %zu", i);
+			for (j = 0; j < VEC_SIZE && j < 64; j++) {
+				if (write_bufs[i][j] != read_bufs[i][j]) {
+					tst_res(TINFO, "Vector %zu: first mismatch at "
+						"offset %zu: wrote 0x%02x, read 0x%02x",
+						i, j, write_bufs[i][j], read_bufs[i][j]);
+					break;
+				}
+			}
+			SAFE_CLOSE(fd);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Data integrity verified across all %d vectors", NUM_VECS);
+	SAFE_CLOSE(fd);
+}
+
+static void test_partial_vectors(void)
+{
+	int fd;
+	struct iovec partial_write[2];
+	struct iovec partial_read[2];
+	size_t i;
+	int expected_size;
+
+	tst_res(TINFO, "Testing partial vector operations");
+
+	prepare_write_buffers();
+	prepare_read_buffers();
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	/* Write using only 2 vectors */
+	partial_write[0] = write_iovs[0];
+	partial_write[1] = write_iovs[1];
+	expected_size = 2 * VEC_SIZE;
+
+	io_uring_submit_sqe_vec(&s, fd, IORING_OP_WRITEV, partial_write, 2, 0);
+	if (io_uring_wait_cqe(&s, expected_size, IORING_OP_WRITEV, &sig) == 0)
+		tst_res(TPASS, "Partial IORING_OP_WRITEV (2 vectors) succeeded");
+
+	SAFE_FSYNC(fd);
+
+	/* Read back using 2 vectors */
+	partial_read[0] = read_iovs[0];
+	partial_read[1] = read_iovs[1];
+
+	io_uring_submit_sqe_vec(&s, fd, IORING_OP_READV, partial_read, 2, 0);
+	if (io_uring_wait_cqe(&s, expected_size, IORING_OP_READV, &sig) == 0)
+		tst_res(TPASS, "Partial IORING_OP_READV (2 vectors) succeeded");
+
+	/* Verify only the first 2 vectors */
+	for (i = 0; i < 2; i++) {
+		if (memcmp(write_bufs[i], read_bufs[i], VEC_SIZE) != 0) {
+			tst_res(TFAIL, "Partial vector data mismatch at vector %zu", i);
+			SAFE_CLOSE(fd);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Partial vector data integrity verified");
+	SAFE_CLOSE(fd);
+}
+
+static void test_varying_sizes(void)
+{
+	int fd;
+	struct iovec var_write[3];
+	struct iovec var_read[3];
+	char buf1[512], buf2[1024], buf3[256];
+	char rbuf1[512], rbuf2[1024], rbuf3[256];
+	size_t i;
+	int expected_size = 512 + 1024 + 256;
+
+	tst_res(TINFO, "Testing vectors with varying sizes");
+
+	/* Prepare buffers with different sizes */
+	for (i = 0; i < 512; i++)
+		buf1[i] = 'X';
+	for (i = 0; i < 1024; i++)
+		buf2[i] = 'Y';
+	for (i = 0; i < 256; i++)
+		buf3[i] = 'Z';
+
+	var_write[0].iov_base = buf1;
+	var_write[0].iov_len = 512;
+	var_write[1].iov_base = buf2;
+	var_write[1].iov_len = 1024;
+	var_write[2].iov_base = buf3;
+	var_write[2].iov_len = 256;
+
+	memset(rbuf1, 0, 512);
+	memset(rbuf2, 0, 1024);
+	memset(rbuf3, 0, 256);
+
+	var_read[0].iov_base = rbuf1;
+	var_read[0].iov_len = 512;
+	var_read[1].iov_base = rbuf2;
+	var_read[1].iov_len = 1024;
+	var_read[2].iov_base = rbuf3;
+	var_read[2].iov_len = 256;
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	/* Write with varying sizes */
+	io_uring_submit_sqe_vec(&s, fd, IORING_OP_WRITEV, var_write, 3, 0);
+	if (io_uring_wait_cqe(&s, expected_size, IORING_OP_WRITEV, &sig) == 0)
+		tst_res(TPASS, "IORING_OP_WRITEV with varying sizes succeeded");
+
+	SAFE_FSYNC(fd);
+
+	/* Read back with varying sizes */
+	io_uring_submit_sqe_vec(&s, fd, IORING_OP_READV, var_read, 3, 0);
+	if (io_uring_wait_cqe(&s, expected_size, IORING_OP_READV, &sig) == 0)
+		tst_res(TPASS, "IORING_OP_READV with varying sizes succeeded");
+
+	/* Verify each buffer */
+	if (memcmp(buf1, rbuf1, 512) == 0 &&
+	    memcmp(buf2, rbuf2, 1024) == 0 &&
+	    memcmp(buf3, rbuf3, 256) == 0) {
+		tst_res(TPASS, "Varying size vector data integrity verified");
+	} else {
+		tst_res(TFAIL, "Varying size vector data mismatch");
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	io_uring_setup_queue(&s, QUEUE_DEPTH);
+	test_writev_readv();
+	test_partial_vectors();
+	test_varying_sizes();
+	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
+}
+
+static void setup(void)
+{
+	io_uring_setup_supported_by_kernel();
+	sigemptyset(&sig);
+	memset(&s, 0, sizeof(s));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/io_uring_disabled", "0",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "2b188cc1bb85"},
+		{"linux-git", "f67676d160c6"},
+		{}
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
