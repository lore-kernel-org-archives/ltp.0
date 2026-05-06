Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED660CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:39:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B05923E2C53
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 20:39:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52B933E1FBC
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A8651A0098B
 for <ltp@lists.linux.it>; Wed,  6 May 2026 20:37:57 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6468Reo22230519
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=sMHG6cQDm4YeLahHPk0hNgqoWk7EcybSAGYbYIFuY
 1c=; b=HoUzL7OWvkfld/Pp/RdE1itEj5bCbuUteQHui7X1UrIZNCfnmG1D+5zkI
 K4LLou5vdcnDfpv1F/h/LKdi8XIQ0M5i1gHAL/OglhzOvSka172qGDqTW+ahQOTX
 BfODjCyaqwEW1KAAcPI15Fq1stj1oJRj+UuK6DyuCEKMSLt9w+iDDYihA4Q11pv/
 ASxvGPNskTnaLgZMt0M1CT+jnD+l+0xicmEC2DqSqKy9W3XHbu91L2EOhMYG/Son
 RDvmHCrZMlVkjmT7RzbUefV7/YfmymyQyPJeLqfhV29L46553EwN8yemjqPxxipl
 IETpQil2i+fKdZcTDdZs0lxx1PCTw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1j9aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646IOS5B010771
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yf9v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 06 May 2026 18:37:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646Ibq9s52035960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 6 May 2026 18:37:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E73320043
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAB4020040
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.100.23])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:37:51 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 00:07:47 +0530
Message-Id: <20260506183750.97191-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ul6kyw8-DYsUT_jBhNj-oIOGA_BGtP_C
X-Proofpoint-GUID: Ul6kyw8-DYsUT_jBhNj-oIOGA_BGtP_C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MiBTYWx0ZWRfX5cKIdk2xALD1
 LGTsSK+V1cE4KJ8bwXhUp09F0s/ojuZuLS9m1hrEGjG0amdShDX4ZwXkHukrxKDJFuAkEhPhi+U
 LchCkA1jhiKQ8cGB4DIowozqG837csTFh21Mtw1eTLWFeYsal1aTpUQDYdF1ptJlKzi9xbmOYg9
 425LXHHmq7nK0bNrJ4yDOXP6rxTbV7+/NSd15Q0D/ajXjGGhe7zVkQ+uaLoDhuKOG4nDNkEZNSX
 FPrxOZIaxQyq78XBIrRwineESM3CCP+N1iYaTckhSHgYmxGnZkFtXnHASguqaUBadaGtOMYH5Vl
 GIwm8+jQ+C/18x90I7gqG7hMw+At5thZTyLlW99PFXUj0xoXpRo5rGXIxeMsI1AfGePslMIOGHk
 gcfuhNfoXUCC4SapZMCmP5LQO4/mKhPisKY8VRDkUAtyidq6XYeaDwRdcxAbKiA+3NuMJc4egbX
 zma6fOrRM9wLpz2JlUg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb8a83 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=IcgqxEhh3HAFs1W3iaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060182
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/4] io_uring: Add io_uring04 test for vectored I/O
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

Add new test case io_uring04.c to validate IORING_OP_READV and
IORING_OP_WRITEV operations with uniform buffer sizes.

Test performs:
- Vectored write using multiple uniform buffers (4 x 1024 bytes)
- Vectored read back into multiple uniform buffers
- Data integrity verification across all vectors

Also add helper functions to io_uring_common.h:
- io_uring_init_iovec_pattern(): Initialize iovec buffers with patterns
- io_uring_clear_iovec(): Clear iovec buffers by zeroing data
- io_uring_verify_iovec(): Verify data integrity between write/read iovecs

Update runtest/syscalls and .gitignore to include the new test.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V6 changes:
- Split io_uring04.c into 3 independent tests
- Linux to v5 https://lore.kernel.org/ltp/69fb33a1.5d0a0220.337e29.6038@mx.google.com/T/#t

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
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/io_uring/.gitignore |  1 +
 .../kernel/syscalls/io_uring/io_uring04.c     | 84 ++++++++++++++++++
 .../syscalls/io_uring/io_uring_common.h       | 86 +++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f790e8f84..6b047b5fd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1904,6 +1904,7 @@ membarrier01 membarrier01
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
index 000000000..8361b5df0
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*\
+ * Test basic IORING_OP_READV and IORING_OP_WRITEV operations.
+ *
+ * This test validates basic vectored read and write operations using
+ * io_uring with uniform buffer sizes. It performs:
+ * 1. IORING_OP_WRITEV - Writing data using multiple uniform buffers
+ * 2. IORING_OP_READV - Reading data back into multiple uniform buffers
+ * 3. Data integrity verification across all vectors
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
+
+static void run(void)
+{
+	int fd = -1;
+	int total_size = NUM_VECS * VEC_SIZE;
+
+	io_uring_init_iovec_pattern(write_iovs, NUM_VECS, 'A', 1);
+	io_uring_clear_iovec(read_iovs, NUM_VECS);
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO, "Writing %d bytes using %d vectors",
+		total_size, NUM_VECS);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, NUM_VECS,
+			      0, total_size, &sig);
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO, "Reading %d bytes using %d vectors",
+		total_size, NUM_VECS);
+	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS,
+			      0, total_size, &sig);
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
diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
index aa31339fb..523f686f8 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring_common.h
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -275,4 +275,90 @@ static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
 		expected_size);
 }
 
+/*
+ * Initialize iovec buffers with pattern
+ * @iovs: array of iovec structures
+ * @nvecs: number of iovecs
+ * @base_char: base character for pattern (must be 'A'-'Z')
+ * @use_rotating: if non-zero, use rotating pattern; if zero, use simple repeat
+ */
+static inline void io_uring_init_iovec_pattern(struct iovec *iovs, int nvecs,
+					       char base_char, int use_rotating)
+{
+	int i;
+	size_t j;
+	char *buf;
+
+	if (base_char < 'A' || base_char > 'Z')
+		tst_brk(TBROK, "base_char must be 'A'-'Z', got '%c'",
+			base_char);
+
+	for (i = 0; i < nvecs; i++) {
+		if (iovs[i].iov_len == 0)
+			continue;
+
+		buf = (char *)iovs[i].iov_base;
+		if (use_rotating) {
+			/* Each vector has a different rotating pattern */
+			for (j = 0; j < iovs[i].iov_len; j++)
+				buf[j] = 'A' + ((base_char - 'A' + i + j) % 26);
+		} else {
+			for (j = 0; j < iovs[i].iov_len; j++)
+				buf[j] = 'A' + ((base_char - 'A' + i) % 26);
+		}
+	}
+}
+
+/*
+ * Clear iovec buffers by zeroing all data
+ */
+static inline void io_uring_clear_iovec(struct iovec *iovs, int nvecs)
+{
+	int i;
+
+	for (i = 0; i < nvecs; i++)
+		memset(iovs[i].iov_base, 0, iovs[i].iov_len);
+}
+
+/*
+ * Verify data integrity between write and read iovecs
+ * Stops test execution on verification failure
+ */
+static inline void io_uring_verify_iovec(struct iovec *write_iovs,
+					 struct iovec *read_iovs, int nvecs)
+{
+	int i;
+	size_t j;
+
+	for (i = 0; i < nvecs; i++) {
+		if (write_iovs[i].iov_len != read_iovs[i].iov_len) {
+			tst_brk(TFAIL,
+				"iovec %d length mismatch: write=%zu read=%zu",
+				i, write_iovs[i].iov_len, read_iovs[i].iov_len);
+		}
+
+		if (memcmp(write_iovs[i].iov_base, read_iovs[i].iov_base,
+			   write_iovs[i].iov_len) != 0) {
+			for (j = 0; j < write_iovs[i].iov_len; j++) {
+				char *wbuf = (char *)write_iovs[i].iov_base;
+				char *rbuf = (char *)read_iovs[i].iov_base;
+
+				if (wbuf[j] != rbuf[j]) {
+					tst_res(TINFO,
+						"Vector %d: first mismatch at "
+						"offset %zu: wrote 0x%02x, "
+						"read 0x%02x",
+						i, j,
+						(unsigned char)wbuf[j],
+						(unsigned char)rbuf[j]);
+					break;
+				}
+			}
+			tst_brk(TFAIL, "data mismatch in vector %d", i);
+		}
+	}
+
+	tst_res(TPASS, "data integrity verified across %d vectors", nvecs);
+}
+
 #endif /* IO_URING_COMMON_H */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
