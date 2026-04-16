Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F1BF433FE
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 06:23:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BC443E2637
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:23:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BD153CAFD1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 08:23:10 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F2D9600742
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 08:23:09 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FHUmtn2130784
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=I8a3z9fVE4aEIOukIM3XKHEamKdcN8Nh6Bj8671wn
 88=; b=JwSHv39aGn/qSEdS95AQTkv5yrqo3avVRgILWC0ZPxG8Ld/b7dXICzMra
 soQ2Al2CB9oISyLtIU7jEaOcpcTYeccmzGjJh7l6yLqsn6ZNwEOIR1yOiUVTgIEg
 KIrA9AuAEAIjnhy9FsZYyjg6kLPRcvYyT6WLEsF/kD1oW3rPy/q+7uR4ykO2ZDIc
 fTzofbnuguRTxidfZptc5pORv2q331xdh9R0NS6UfaM/lCw4I2C5kwATbn/FV04a
 OGTezTwNGsMKsG6x8wFyZZz9Vz86/Yt85AzqLoZ/tbuEwYB1wjO2Vx9Dt882CBko
 i5KZz9d90QGwVxUqvA7KT56bT1wYQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nm0dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G2iYlG003379
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh938e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63G6N4US31588796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5399E20043
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A158A20040
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.69.136])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:23:03 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 11:53:02 +0530
Message-Id: <20260416062302.15804-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uPWDA3LTATqn2DZHzfKqKrzuepKOauHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1NyBTYWx0ZWRfX104w52WgTKh+
 Sc0Uc5cfq/EGZ/p+uiCY9OP/SSZWT/HADq/U+6A3KPhK30gvdO9A2LoxqKi5GjqKgfX43BkzcPL
 SqYpVURmMT4SQYf+8Mu/nhmvbsaM9D/r7Gy3mZCNvt409Q6rECSury49YKzw+0dVUWb5S2OQ1F5
 15GMBsJRjuNghUmhs0kIsRPvfzwFFFFIsIJAvQVv2XH06oegUiYgux7u7Qy2R0VbtL1zC43D420
 BVekbgqz3k4lhGU7eMcLNR0liP48Iknj7t5PYS8J93nEP1fCCd6QIUkl7w7i7KbniNUPxlKrCWa
 TJI2FHdNjaP4TnJ1DpiNQq7/JIDEdI3iemh6gI92lmRpFaZ1DJ+ay3WhemvmJ0Fxw5LTFKFdAA1
 Y2ZvqPf4b+ZExbTcmOakK0SrF/EsZpock+GqYC59XCNL3HvYjPdW9kO0hDHVNeh8WqFryT1ege6
 jNG1cE4ZhFYYxqcPhbA==
X-Proofpoint-ORIG-GUID: uPWDA3LTATqn2DZHzfKqKrzuepKOauHP
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e0804b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=p1uXUT2nn1jiVixas2kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160057
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] io_uring: Add test for READV and WRITEV operations
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

Add a test to validate vectored read and write operations using io_uring.

1. IORING_OP_WRITEV - Writing data using multiple buffers (scatter)
2. IORING_OP_READV - Reading data into multiple buffers (gather)
3. Data integrity verification across multiple iovecs
4. Edge cases with different iovec configurations including zero
   buffer length

Additionally merge io_uring_init_buffer_pattern() into unified
init_iovec_buffers() function that supports both rotating and
simple character patterns

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V4 changes:
- Updated commit message to remove references to non-existent function
- Removed extra blank line before test_writev_readv()
- Link to v3 https://lore.kernel.org/ltp/20260416042531.81093-1-sachinp@linux.ibm.com/T/

V3 changes (2/3 io_uring04 only):
- 1/3 and 3/3 from the patch series already merged.
- Merged prepare_read_buffers() and clear_iovec_buffers() into
single clear_iovec_buffers() function
- Merged io_uring_init_buffer_pattern() into unified
init_iovec_buffers() function that supports both rotating and
simple character patterns
- Removed io_uring_init_buffer_pattern() from io_uring_common.h as it's
only used in io_uring04.c
- Link to V2: https://lore.kernel.org/ltp/b4653e3f-ac9b-4a24-8d3f-51677c488e8c@linux.ibm.com/T/

V2 changes:
- Use guarded buffer(including iovec) allocation
- Move setup/cleanup code from run to appropriate path
- Add a function to map the OP to the enum name
- Define and use generic cleanup functions
- Add a buffer size 0 in the middle of the iovec
- Simplify setup_io_uring_test to use common code.
- Link to V1: https://lore.kernel.org/ltp/20260320124742.75946-1-sachinp@linux.ibm.com/T/#t

Changes after RFC patch series:
- Addressed review comments
- Refactored io_uring01 test to use common code
- Removed git tags
- Link to RFC: https://lore.kernel.org/ltp/20260318110328.52031-1-sachinp@linux.ibm.com/T/#t

---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/io_uring/.gitignore |   1 +
 .../kernel/syscalls/io_uring/io_uring04.c     | 221 ++++++++++++++++++
 .../syscalls/io_uring/io_uring_common.h       |  13 --
 4 files changed, 223 insertions(+), 13 deletions(-)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5025b259f..aa7a91d97 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1901,6 +1901,7 @@ membarrier01 membarrier01
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
index 000000000..7ff0b194f
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*\
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
+/*
+ * Initialize iovec buffers with pattern
+ * @iovs: array of iovec structures
+ * @nvecs: number of iovecs
+ * @base_char: base character for pattern
+ * @use_rotating: if true, use rotating pattern; if false, use simple repeat
+ */
+static void init_iovec_buffers(struct iovec *iovs, int nvecs,
+				char base_char, int use_rotating)
+{
+	int i;
+	size_t j;
+	char *buf;
+
+	for (i = 0; i < nvecs; i++) {
+		if (iovs[i].iov_len == 0)
+			continue;
+
+		buf = (char *)iovs[i].iov_base;
+		if (use_rotating) {
+			/* Each vector has a different rotating pattern */
+			for (j = 0; j < iovs[i].iov_len; j++)
+				buf[j] = base_char + i + (j % 26);
+		} else {
+			for (j = 0; j < iovs[i].iov_len; j++)
+				buf[j] = base_char + i;
+		}
+	}
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
+	init_iovec_buffers(var_write_iovs, 4, 'X', 0);
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
+	init_iovec_buffers(write_iovs, NUM_VECS, 'A', 1);
+	clear_iovec_buffers(read_iovs, NUM_VECS);
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
diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index aa31339fb..7816b55dc 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring_common.h
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -230,19 +230,6 @@ static inline void io_uring_wait_cqe(struct io_uring_submit *s,
 	*cring->head = head + 1;
 }
 
-/*
- * Initialize buffer with a repeating character pattern
- * Useful for creating test data with predictable patterns
- */
-static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
-						char pattern)
-{
-	size_t i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = pattern;
-}
-
 /*
  * Submit and wait for a non-vectored I/O operation
  * Combines io_uring_submit_sqe() and io_uring_wait_cqe() with result reporting
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
