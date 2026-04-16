Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D0F8A16B
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:17:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545A23E1962
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:17:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79E4F3E189F
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:16:46 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A2BF1400BC5
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:16:44 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FNrqRu089155
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=VsMoFGp0vLzFXlE6/KanojvhHoGHoLaPwKITlWZrg
 m4=; b=OlP8atb99qm1IK8TZePDzMgUbDuu83c5EFpS7cmMpdNefPzXTWi+QSu9Q
 ANVbNeT/sdjpqV0MoQl2HbP1zgHgWmAFq+gLec911hR9lHQdyEbkrp3eSwRWdXUn
 4RSRUvkq2Ls91pKAllcQUVJJLndnnpa8ELw4fqnfwq6y06SzvNYwq333fvkTAajW
 BhHr/n8SYJ4/+OnIZjxYSs4RDzES0a0Ifh0icUdk33r5ld0q/fynwjztM1aNLZQt
 EuKq8iUzQWig6gRs+ofKp33YAukVOJ/e23xEXxsKGx+SpVqD91Wtatxnyxr4TWtf
 WfLlvgQhZBtkyozr+JETff4C926Mg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rn9q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GBuSM9030721
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yjw2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GCGdIn41681362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF60C20049
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42D5220040
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.36.193])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:16:39 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 17:46:37 +0530
Message-Id: <20260416121638.11858-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMiBTYWx0ZWRfX05gqEiggm473
 NWVeczNuAUlx2vckyhjWgSnDWz4j70YTLqMbQdgxNJzba7GVvh4WWf1n6JvTznwrJfqm6uOBqag
 8IWUhEsEuMeIrGkpgEC08DsLt2rXTArGIpbD8ULyLxwfQ0qguJzLThuXL486IpxMJU7DtuarkPq
 18PBoKaOPP5a6HDh0nUmfUsA+R8s9ciDJDEYXEM/lsv3VbBEZmdpEHYGTUoJCz6/GCyicr5jxdz
 8jCu22T7aV65UlnLZWcYB8CSyHdp5vVDDoKa4Lmj6EjfCikHUnWK8UjLOFA1gD60Cifi9YXaUds
 cw4CJMH54MYanZKcp1nYD2gV6Yqo2Djt3MkoEaT7Yfu76Iehxx3sXKmzfaK4NwvrchW8jUJEF4G
 t4MjBV/K/8Koleq94h7I05+0mtxGMjhujb/1pl2XyHOm+/Syhw6/EqXUvQhzu8szmzv8LVmj1MT
 ozCVZZhhjuZEtPwmvfg==
X-Proofpoint-ORIG-GUID: z0S20KVi5zr8CrJM34Po6kG4I2km8gWR
X-Proofpoint-GUID: z0S20KVi5zr8CrJM34Po6kG4I2km8gWR
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e0d32a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wt60Mp07Bq2YeaRHpIsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160112
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] io_uring: Add test for READV and WRITEV
 operations
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
V5 changes:
- Add clear_iovec_buffers() at the top of run()
- Link to v4 https://lore.kernel.org/ltp/20260416062302.15804-1-sachinp@linux.ibm.com/T/

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
 .../kernel/syscalls/io_uring/io_uring04.c     | 223 ++++++++++++++++++
 3 files changed, 225 insertions(+)
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
index 000000000..6b6bb711d
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -0,0 +1,223 @@
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
+	clear_iovec_buffers(read_iovs, NUM_VECS);
+
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
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
