Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE0E108B91E
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:48:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D3573E30A0
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:48:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 571DC3E279C
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:51 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 907C31A007F6
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:50 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K3S5BG967663; Fri, 20 Mar 2026 12:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XYeEfaBYEFp1hGZ3y
 m6oCFo9ZN3ALClX1XSfH/1f36Y=; b=DP1lJ+UlboJEqX8foQ/RW+A9+t7wyYT7V
 gn98nQyJ8pledb1ivbAdQ5Lh5oMtiTL0hx3gu58K4bcvkpjsxTwp1VFrLriRjBVM
 QK7Ry4jF11TpXLKZL1GBw6LAx3DjOwDqzG8luNo9RfvKnRjaZDbFhRofxrBruWdZ
 OQ+Ec872OOnlU5qXwIZHqfFTFNEuflIuVUyscxFSHHOyBcswDiNRoIOu0/s2ssJr
 doeRMHcPT2w9J6i+ms6ANbGN2sQCTTcawbBnizSYD+uoYa0co0nl4k/pUW3PQb0j
 pf8Qorbv1qXu1ExLE++MQOV2QexI1TH82H/ChD8I5HjtgUcHb7m4A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3danuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KBQGT0004581;
 Fri, 20 Mar 2026 12:47:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sqapq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KClkDP59572626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 12:47:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5493D20043;
 Fri, 20 Mar 2026 12:47:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AB0620040;
 Fri, 20 Mar 2026 12:47:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.5.99])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 12:47:45 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 18:17:41 +0530
Message-Id: <20260320124742.75946-3-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260320124742.75946-1-sachinp@linux.ibm.com>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd41f4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uawTaGMWo2TYs5MRpMYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwMCBTYWx0ZWRfX65px2NDJr5aH
 NmYYoBvZBJ06qjlygKY6+ovAnoZ7JI9pIq+2sGoIMzkaKzsCrd5bqyw037q/3PJ/lPNJZbodpqU
 VkkDYTyGcTSyK9w+I6+7dx/rhY8F/NiuNhhCZJJWBs/tUi9FniRlFEF1aawzmU8nklhMHyGL/Ss
 g1VN6OoTCxLbIuVOc/vKbgMaRmhr+lLBDeIkwNgBjd/WvNqQjWzJ96UtZS5YviYDEt9a9XYOaza
 F8yRIWgFsFjmkAgbcGYCs+5eJ8KTs1cDQWtvJk5mo+kbWrTtjzr8k8TL9+NXCHFGITa+M5MnxSF
 DdU8tgsTrQc96hth5XhamNcCZppgCtC/aiCcQvuycFIDss4cD8DDpT75HtVyPFysdNazqACd1oO
 3c5gMJomTo42hwF9ivgA3a4r40Fa9SjLdAucEtVxD85iqjv2ewfnk3gtrxgq4ISKktGTB2ptL3w
 R0xwlm7pqux8Kz/ahcw==
X-Proofpoint-GUID: XIGLQWrV8Jg-iiYqSzrol6IUdynhNPlr
X-Proofpoint-ORIG-GUID: XIGLQWrV8Jg-iiYqSzrol6IUdynhNPlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200100
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] io_uring: Test READV and WRITEV operations
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
4. Edge cases with different iovec configurations

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/io_uring/.gitignore |   1 +
 .../kernel/syscalls/io_uring/io_uring04.c     | 231 ++++++++++++++++++
 3 files changed, 233 insertions(+)
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
index 000000000..27d1c509b
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -0,0 +1,231 @@
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
+static void verify_vector_data(char write_bufs[][VEC_SIZE],
+			       char read_bufs[][VEC_SIZE],
+			       size_t num_vecs, const char *test_name)
+{
+	size_t i, j;
+
+	for (i = 0; i < num_vecs; i++) {
+		if (memcmp(write_bufs[i], read_bufs[i], VEC_SIZE) != 0) {
+			tst_res(TFAIL, "%s: data mismatch in vector %zu",
+				test_name, i);
+			for (j = 0; j < VEC_SIZE && j < 64; j++) {
+				if (write_bufs[i][j] != read_bufs[i][j]) {
+					tst_res(TINFO, "Vector %zu: first mismatch at "
+						"offset %zu: wrote 0x%02x, read 0x%02x",
+						i, j, write_bufs[i][j], read_bufs[i][j]);
+					break;
+				}
+			}
+			return;
+		}
+	}
+
+	tst_res(TPASS, "%s: data integrity verified across %zu vectors",
+		test_name, num_vecs);
+}
+
+static void test_writev_readv(void)
+{
+	int fd;
+	int total_size = NUM_VECS * VEC_SIZE;
+
+	tst_res(TINFO, "Testing IORING_OP_WRITEV and IORING_OP_READV");
+
+	prepare_write_buffers();
+	prepare_read_buffers();
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO, "Writing %d bytes using %d vectors", total_size, NUM_VECS);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, NUM_VECS,
+			      0, total_size, &sig,
+			      "IORING_OP_WRITEV completed successfully");
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO, "Reading %d bytes using %d vectors", total_size, NUM_VECS);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS,
+			      0, total_size, &sig,
+			      "IORING_OP_READV completed successfully");
+
+	verify_vector_data(write_bufs, read_bufs, NUM_VECS, "Basic vectored I/O");
+
+	SAFE_CLOSE(fd);
+}
+
+static void test_partial_vectors(void)
+{
+	int fd;
+	struct iovec partial_write[2];
+	struct iovec partial_read[2];
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
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, partial_write, 2, 0,
+			      expected_size, &sig,
+			      "Partial IORING_OP_WRITEV (2 vectors) succeeded");
+
+	SAFE_FSYNC(fd);
+
+	/* Read back using 2 vectors */
+	partial_read[0] = read_iovs[0];
+	partial_read[1] = read_iovs[1];
+
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, partial_read, 2, 0,
+			      expected_size, &sig,
+			      "Partial IORING_OP_READV (2 vectors) succeeded");
+
+	verify_vector_data(write_bufs, read_bufs, 2, "Partial vector I/O");
+
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
+	int expected_size = 512 + 1024 + 256;
+
+	tst_res(TINFO, "Testing vectors with varying sizes");
+
+	io_uring_init_buffer_pattern(buf1, 512, 'X');
+	io_uring_init_buffer_pattern(buf2, 1024, 'Y');
+	io_uring_init_buffer_pattern(buf3, 256, 'Z');
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
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, var_write, 3, 0,
+			      expected_size, &sig,
+			      "IORING_OP_WRITEV with varying sizes succeeded");
+
+	SAFE_FSYNC(fd);
+
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, var_read, 3, 0,
+			      expected_size, &sig,
+			      "IORING_OP_READV with varying sizes succeeded");
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
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
