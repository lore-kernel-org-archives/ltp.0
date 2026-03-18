Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D66B103E163
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:04:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 089363E5CAD
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:04:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E603C2A00
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:03:36 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0050C6006D4
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:03:35 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HMM7bl1188759
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tk7aoxr1cotwYpa1w
 9DAW8mwt4czZ/L1e0wngli+Z3Y=; b=HbS+OcCBQfnKwsrFdrJccP3VzHQAHDFOl
 HhiKsgpekaZpC+Vi7WB9S1vhHc9BBzl+s5Gm575cM+DQsvK2d6SImSLqbnJ7x00i
 NUdSiS2KzN1loPM+qklGlvpYqnHqHCtWrSAQ2vyJrOtcinnbFE9tMSI5hmHUcRhL
 c/Ag0hntNWOWQfAzcAEJv2slAXgabVG6P7mwFG41dG6ogQqnxPWqs03v3Myxa38f
 VW9yZ8p+hH8aNI+1yMIKVFtfLLQzSX8AK7/DI6LlXToKTDuHDEAAArysEaw9jIrU
 +qxlkasGPVGCkFzPj7Bm1jUBNnUThx0z5unLffp9AXz0lcW06dLDA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfkt2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I9koNh032343
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jwfs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IB3VRd61735350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AA5B2004F
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAF1E20040
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.26])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:30 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 16:33:27 +0530
Message-Id: <20260318110328.52031-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260318110328.52031-1-sachinp@linux.ibm.com>
References: <20260318110328.52031-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FNRq_2XAi2goLbcCOz59xUL5bKapRpZn
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba8686 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4TUbjP5cmmm0d-QyuwAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5MCBTYWx0ZWRfX7fBL2KbGT5Br
 aKvdgAEw543JO6zsNg7ndvPTFKaMD2wofqBmmLxOKFpukIsYroM41RBputQVwloU1VZrqaz0GwN
 gon+dH4+k1J/NJ4OK2jeLKEt8DHUezTNPsOFu4dF7KoXzoVpOlTTa8vHHE1GpMobTMyuWzKDpN5
 OqKsXdwKNpUL93K8RAOzvlnk+dDi4mHYQrt9DO1JLLiwn4+LuArp8HiB6HhbldojCK2C3oC1Pe2
 6f+yQhAEjPPeiq2i8eSU6NtWUWUlvBB7lfJXA6QQXdACJh0m6WIGWsGQet9vQAI5iff/OlbvB6S
 hYzXgTDu9h3Ki9zUAtT3nw5HwiHTXAASgYw7rRl8sx/AkDOzxnP4a5CWAVt+uqB4F5ymoL71zvm
 gjxn4XE9apu13cESnMzXz/XyDQoteZZzY3+3DsPEFAIxQtL6LHAh8UcCGU68xQMgYWnzGH1+wjU
 9uIamII3wGxCP27SfyA==
X-Proofpoint-GUID: FNRq_2XAi2goLbcCOz59xUL5bKapRpZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180090
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] [PATCH 1/2] io_uring: Test IORING READ and WRITE
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

This test validates basic read and write operations using io_uring.
It tests:
 1. IORING_OP_WRITE - Writing data to a file
 2. IORING_OP_READ - Reading data from a file
 3. Data integrity verification

This patch also introduces a header file for common functions.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/io_uring/.gitignore |   1 +
 .../kernel/syscalls/io_uring/io_uring03.c     | 145 +++++++++++
 .../syscalls/io_uring/io_uring_common.h       | 227 ++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring03.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring_common.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 2179e007c..7dc80fe29 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1898,6 +1898,7 @@ membarrier01 membarrier01
 
 io_uring01 io_uring01
 io_uring02 io_uring02
+io_uring03 io_uring03
 
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
index 749db17db..9382ae413 100644
--- a/testcases/kernel/syscalls/io_uring/.gitignore
+++ b/testcases/kernel/syscalls/io_uring/.gitignore
@@ -1,2 +1,3 @@
 /io_uring01
 /io_uring02
+/io_uring03
diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
new file mode 100644
index 000000000..53d4feae5
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ *
+ * Test IORING_OP_READ and IORING_OP_WRITE operations.
+ *
+ * This test validates basic read and write operations using io_uring.
+ * It tests:
+ * 1. IORING_OP_WRITE - Writing data to a file
+ * 2. IORING_OP_READ - Reading data from a file
+ * 3. Data integrity verification
+ */
+
+#include "io_uring_common.h"
+
+#define TEST_FILE "io_uring_test_file"
+#define QUEUE_DEPTH 2
+#define BLOCK_SZ 4096
+
+static char write_buf[BLOCK_SZ];
+static char read_buf[BLOCK_SZ];
+static struct io_uring_submit s;
+static sigset_t sig;
+
+static void test_write_read(void)
+{
+	int fd;
+	size_t i;
+
+	/* Prepare write buffer with pattern */
+	for (i = 0; i < BLOCK_SZ; i++)
+		write_buf[i] = 'A' + (i % 26);
+
+	/* Open file for writing */
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	/* Test IORING_OP_WRITE */
+	tst_res(TINFO, "Testing IORING_OP_WRITE");
+	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf, BLOCK_SZ, 0);
+
+	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_WRITE, &sig) == 0)
+		tst_res(TPASS, "IORING_OP_WRITE completed successfully");
+
+	/* Sync to ensure data is written */
+	SAFE_FSYNC(fd);
+
+	/* Test IORING_OP_READ */
+	tst_res(TINFO, "Testing IORING_OP_READ");
+	memset(read_buf, 0, BLOCK_SZ);
+	io_uring_submit_sqe(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0);
+
+	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_READ, &sig) == 0)
+		tst_res(TPASS, "IORING_OP_READ completed successfully");
+
+	/* Verify data integrity */
+	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0) {
+		tst_res(TPASS, "Data integrity verified");
+	} else {
+		tst_res(TFAIL, "Data mismatch after read");
+		for (i = 0; i < BLOCK_SZ && i < 64; i++) {
+			if (write_buf[i] != read_buf[i]) {
+				tst_res(TINFO, "First mismatch at offset %zu: "
+					"wrote 0x%02x, read 0x%02x",
+					i, write_buf[i], read_buf[i]);
+				break;
+			}
+		}
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static void test_partial_io(void)
+{
+	int fd;
+	size_t half = BLOCK_SZ / 2;
+	size_t i;
+
+	tst_res(TINFO, "Testing partial I/O operations");
+
+	/* Prepare buffer */
+	for (i = 0; i < BLOCK_SZ; i++)
+		write_buf[i] = 'a' + (i % 26);
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	/* Write first half */
+	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf, half, 0);
+	if (io_uring_wait_cqe(&s, half, IORING_OP_WRITE, &sig) == 0)
+		tst_res(TPASS, "Partial write (first half) succeeded");
+
+	/* Write second half */
+	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf + half,
+			    half, half);
+	if (io_uring_wait_cqe(&s, half, IORING_OP_WRITE, &sig) == 0)
+		tst_res(TPASS, "Partial write (second half) succeeded");
+
+	SAFE_FSYNC(fd);
+
+	/* Read back in one operation */
+	memset(read_buf, 0, BLOCK_SZ);
+	io_uring_submit_sqe(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0);
+	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_READ, &sig) == 0)
+		tst_res(TPASS, "Full read after partial writes succeeded");
+
+	/* Verify */
+	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0)
+		tst_res(TPASS, "Partial I/O data integrity verified");
+	else
+		tst_res(TFAIL, "Partial I/O data mismatch");
+
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	io_uring_setup_queue(&s, QUEUE_DEPTH);
+	test_write_read();
+	test_partial_io();
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
+		{"linux-git", "5d17b4a4b48c"},
+		{"linux-git", "2b188cc1bb85"},
+		{}
+	}
+};
diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
new file mode 100644
index 000000000..df05a0759
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ *
+ * Common definitions and helper functions for io_uring tests
+ */
+
+#ifndef IO_URING_COMMON_H
+#define IO_URING_COMMON_H
+
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/io_uring.h"
+
+/* Common structures for io_uring ring management */
+struct io_sq_ring {
+	unsigned int *head;
+	unsigned int *tail;
+	unsigned int *ring_mask;
+	unsigned int *ring_entries;
+	unsigned int *flags;
+	unsigned int *array;
+};
+
+struct io_cq_ring {
+	unsigned int *head;
+	unsigned int *tail;
+	unsigned int *ring_mask;
+	unsigned int *ring_entries;
+	struct io_uring_cqe *cqes;
+};
+
+struct io_uring_submit {
+	int ring_fd;
+	struct io_sq_ring sq_ring;
+	struct io_uring_sqe *sqes;
+	struct io_cq_ring cq_ring;
+	void *sq_ptr;
+	size_t sq_ptr_size;
+	void *cq_ptr;
+	size_t cq_ptr_size;
+};
+
+/*
+ * Setup io_uring instance with specified queue depth
+ * Returns 0 on success, -1 on failure
+ */
+static inline int io_uring_setup_queue(struct io_uring_submit *s,
+				       unsigned int queue_depth)
+{
+	struct io_sq_ring *sring = &s->sq_ring;
+	struct io_cq_ring *cring = &s->cq_ring;
+	struct io_uring_params p;
+
+	memset(&p, 0, sizeof(p));
+	s->ring_fd = io_uring_setup(queue_depth, &p);
+	if (s->ring_fd < 0) {
+		tst_brk(TBROK | TERRNO, "io_uring_setup() failed");
+		return -1;
+	}
+
+	s->sq_ptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
+
+	/* Map submission queue ring buffer */
+	s->sq_ptr = SAFE_MMAP(0, s->sq_ptr_size, PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_POPULATE, s->ring_fd,
+			      IORING_OFF_SQ_RING);
+
+	/* Save submission queue pointers */
+	sring->head = s->sq_ptr + p.sq_off.head;
+	sring->tail = s->sq_ptr + p.sq_off.tail;
+	sring->ring_mask = s->sq_ptr + p.sq_off.ring_mask;
+	sring->ring_entries = s->sq_ptr + p.sq_off.ring_entries;
+	sring->flags = s->sq_ptr + p.sq_off.flags;
+	sring->array = s->sq_ptr + p.sq_off.array;
+
+	/* Map submission queue entries */
+	s->sqes = SAFE_MMAP(0, p.sq_entries * sizeof(struct io_uring_sqe),
+			    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+			    s->ring_fd, IORING_OFF_SQES);
+
+	s->cq_ptr_size = p.cq_off.cqes +
+			 p.cq_entries * sizeof(struct io_uring_cqe);
+
+	/* Map completion queue ring buffer */
+	s->cq_ptr = SAFE_MMAP(0, s->cq_ptr_size, PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_POPULATE, s->ring_fd,
+			      IORING_OFF_CQ_RING);
+
+	/* Save completion queue pointers */
+	cring->head = s->cq_ptr + p.cq_off.head;
+	cring->tail = s->cq_ptr + p.cq_off.tail;
+	cring->ring_mask = s->cq_ptr + p.cq_off.ring_mask;
+	cring->ring_entries = s->cq_ptr + p.cq_off.ring_entries;
+	cring->cqes = s->cq_ptr + p.cq_off.cqes;
+
+	return 0;
+}
+
+/*
+ * Cleanup io_uring instance and unmap all memory regions
+ */
+static inline void io_uring_cleanup_queue(struct io_uring_submit *s,
+					  unsigned int queue_depth)
+{
+	if (s->sqes)
+		SAFE_MUNMAP(s->sqes, queue_depth * sizeof(struct io_uring_sqe));
+	if (s->cq_ptr)
+		SAFE_MUNMAP(s->cq_ptr, s->cq_ptr_size);
+	if (s->sq_ptr)
+		SAFE_MUNMAP(s->sq_ptr, s->sq_ptr_size);
+	if (s->ring_fd > 0)
+		SAFE_CLOSE(s->ring_fd);
+}
+
+/*
+ * Submit a single SQE to the submission queue
+ * For basic read/write operations (non-vectored)
+ */
+static inline void io_uring_submit_sqe(struct io_uring_submit *s, int fd,
+				       int opcode, void *buf, size_t len,
+				       off_t offset)
+{
+	struct io_sq_ring *sring = &s->sq_ring;
+	unsigned int tail, index;
+	struct io_uring_sqe *sqe;
+
+	tail = *sring->tail;
+	index = tail & *sring->ring_mask;
+	sqe = &s->sqes[index];
+
+	memset(sqe, 0, sizeof(*sqe));
+	sqe->opcode = opcode;
+	sqe->fd = fd;
+	sqe->addr = (unsigned long)buf;
+	sqe->len = len;
+	sqe->off = offset;
+	sqe->user_data = opcode;
+
+	sring->array[index] = index;
+	tail++;
+
+	/* Update tail to make SQE visible to kernel */
+	*sring->tail = tail;
+}
+
+/*
+ * Submit a vectored SQE to the submission queue
+ * For readv/writev operations
+ */
+static inline void io_uring_submit_sqe_vec(struct io_uring_submit *s, int fd,
+					   int opcode, struct iovec *iovs,
+					   int nr_vecs, off_t offset)
+{
+	struct io_sq_ring *sring = &s->sq_ring;
+	unsigned int tail, index;
+	struct io_uring_sqe *sqe;
+
+	tail = *sring->tail;
+	index = tail & *sring->ring_mask;
+	sqe = &s->sqes[index];
+
+	memset(sqe, 0, sizeof(*sqe));
+	sqe->opcode = opcode;
+	sqe->fd = fd;
+	sqe->addr = (unsigned long)iovs;
+	sqe->len = nr_vecs;
+	sqe->off = offset;
+	sqe->user_data = opcode;
+
+	sring->array[index] = index;
+	tail++;
+
+	/* Update tail to make SQE visible to kernel */
+	*sring->tail = tail;
+}
+
+/*
+ * Wait for and validate a completion queue entry
+ * Returns 0 on success, -1 on failure
+ */
+static inline int io_uring_wait_cqe(struct io_uring_submit *s,
+				    int expected_res, int expected_opcode,
+				    sigset_t *sig)
+{
+	struct io_cq_ring *cring = &s->cq_ring;
+	struct io_uring_cqe *cqe;
+	unsigned int head;
+	int ret;
+
+	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, sig);
+	if (ret < 0) {
+		tst_res(TFAIL | TERRNO, "io_uring_enter() failed");
+		return -1;
+	}
+
+	head = *cring->head;
+	if (head == *cring->tail) {
+		tst_res(TFAIL, "No completion event received");
+		return -1;
+	}
+
+	cqe = &cring->cqes[head & *cring->ring_mask];
+
+	if (cqe->user_data != (uint64_t)expected_opcode) {
+		tst_res(TFAIL, "Unexpected user_data: got %llu, expected %d",
+			cqe->user_data, expected_opcode);
+		*cring->head = head + 1;
+		return -1;
+	}
+
+	if (cqe->res != expected_res) {
+		tst_res(TFAIL, "Operation failed: res=%d, expected=%d",
+			cqe->res, expected_res);
+		*cring->head = head + 1;
+		return -1;
+	}
+
+	*cring->head = head + 1;
+	return 0;
+}
+
+#endif /* IO_URING_COMMON_H */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
