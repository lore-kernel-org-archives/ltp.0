Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E28108B919
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:48:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCD463E2B49
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:48:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 668D73E2724
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:50 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 780D9600718
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:49 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2VLmU999732; Fri, 20 Mar 2026 12:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0PAM311pXxOYtmI7r
 ArdUwiIL8zKmKXZTtRXTExvhX4=; b=gcRXT2cXxp1AVMl6Mu9+QAiXGJtCN7ELz
 Geklh0kkrSe+EhOs/BrP1sOCmA/8p8fqenQYytXZiX7ES+uE41VewG5RLoh+28rU
 zmSYYOPFgLDOO28jKuL7xTDX2ivK5JgDt4e/vqLI68fkSOx7hb96As/t/WFvtfgS
 ix2I0Rrit1enREYD3EEGQcVZdznHNqbEoccO/mxzl0HYKVjn3eM4oiCMm3EHBXWx
 g11gq0eQDu2+2oXx8GWcMG1V24BqKrZ7XqDIJblm5/tM3SzQf1l6zJf0Hcv5jg1c
 IzL7Lcm531007/2v7+d9jlB8cWv8UzcvyLItY2ayS9RB9OcwC/pWw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3danuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K8EE8l015601;
 Fri, 20 Mar 2026 12:47:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nq5pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KCljZc39190922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 12:47:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F34CC2004B;
 Fri, 20 Mar 2026 12:47:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69D2E20040;
 Fri, 20 Mar 2026 12:47:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.5.99])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 12:47:44 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 18:17:40 +0530
Message-Id: <20260320124742.75946-2-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260320124742.75946-1-sachinp@linux.ibm.com>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd41f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DBcWgPPY1eiOcN69OxwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwMCBTYWx0ZWRfX6HKGmLzQY/mR
 HnRRZ1IbiP1tn2NGF43V8KZuqqxTZsvQ0dZ1qRDm42QzkaXfppTogrcQJuutKkmJcTn77YOXkpL
 ExwV4tvlVniGtpmZFcWe7eTw0tYyQ5Cb+EwWM6NsMCS8xp913f/0psPBQEe51btPI47W/LRdXU1
 //pCUNprKIf3uM0P8e3aQ+t8LOlpN50+ZhWOrYgtr9+8OO+tCAZmb0CezH557TFjbXKEaDayiaq
 fOLjXOuxLVG8WYU2cMq8buP34lQf346zJvBogiY5Mht2IGdaukqLriKujfCCJViuog2wUry8OS8
 wPq3vINCUdv2LIvweArcfHr77iWo3ULnou8NxJPB+LdAWk+W9/jPm/x64YXHhuVtFSI2LjS5805
 ffABRHvUf7WDp0yTYceRNtINSroNudrRsmpX+hdFPPK05zjxt9EeYMZGpNpi7FEaLqQKyT5SuXc
 e0VctNAKNI3qscDdK0A==
X-Proofpoint-GUID: dbh4kemqgwEkfd98ysCOcpBo-euq58lf
X-Proofpoint-ORIG-GUID: dbh4kemqgwEkfd98ysCOcpBo-euq58lf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200100
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] io_uring: Test IORING READ and WRITE operations
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
 .../kernel/syscalls/io_uring/io_uring03.c     | 130 +++++++++
 .../syscalls/io_uring/io_uring_common.h       | 265 ++++++++++++++++++
 4 files changed, 397 insertions(+)
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
index 000000000..0a73a331a
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 IBM
+ * Author: Sachin Sant <sachinp@linux.ibm.com>
+ */
+/*
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
+static void init_buffer(char start_char)
+{
+	size_t i;
+
+	for (i = 0; i < BLOCK_SZ; i++)
+		write_buf[i] = start_char + (i % 26);
+}
+
+static void verify_data_integrity(const char *test_name)
+{
+	size_t i;
+
+	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0) {
+		tst_res(TPASS, "%s data integrity verified", test_name);
+	} else {
+		tst_res(TFAIL, "%s data mismatch", test_name);
+		for (i = 0; i < BLOCK_SZ && i < 64; i++) {
+			if (write_buf[i] != read_buf[i]) {
+				tst_res(TINFO, "First mismatch at offset %zu: "
+					"wrote 0x%02x, read 0x%02x",
+					i, write_buf[i], read_buf[i]);
+				break;
+			}
+		}
+	}
+}
+
+static void test_write_read(void)
+{
+	int fd;
+
+	init_buffer('A');
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	tst_res(TINFO, "Testing IORING_OP_WRITE");
+	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf, BLOCK_SZ, 0,
+			  &sig, "IORING_OP_WRITE completed successfully");
+
+	SAFE_FSYNC(fd);
+
+	tst_res(TINFO, "Testing IORING_OP_READ");
+	memset(read_buf, 0, BLOCK_SZ);
+	io_uring_do_io_op(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0,
+			  &sig, "IORING_OP_READ completed successfully");
+
+	verify_data_integrity("Basic I/O");
+
+	SAFE_CLOSE(fd);
+}
+
+static void test_partial_io(void)
+{
+	int fd;
+	size_t half = BLOCK_SZ / 2;
+
+	tst_res(TINFO, "Testing partial I/O operations");
+
+	init_buffer('a');
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
+
+	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf, half, 0,
+			  &sig, "Partial write (first half) succeeded");
+
+	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf + half, half,
+			  half, &sig, "Partial write (second half) succeeded");
+
+	SAFE_FSYNC(fd);
+
+	memset(read_buf, 0, BLOCK_SZ);
+	io_uring_do_io_op(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0,
+			  &sig, "Full read after partial writes succeeded");
+
+	verify_data_integrity("Partial I/O");
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
+	}
+};
diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
new file mode 100644
index 000000000..4162b5571
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
@@ -0,0 +1,265 @@
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
+ * Internal helper to submit a single SQE to the submission queue
+ * Used by both vectored and non-vectored I/O operations
+ */
+static inline void io_uring_submit_sqe_internal(struct io_uring_submit *s,
+						int fd, int opcode,
+						unsigned long addr,
+						unsigned int len,
+						off_t offset)
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
+	sqe->addr = addr;
+	sqe->len = len;
+	sqe->off = offset;
+	sqe->user_data = opcode;
+
+	sring->array[index] = index;
+	tail++;
+
+	*sring->tail = tail;
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
+	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
+				     len, offset);
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
+	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)iovs,
+				     nr_vecs, offset);
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
+			(unsigned long long)cqe->user_data, expected_opcode);
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
+/*
+ * Initialize buffer with a repeating character pattern
+ * Useful for creating test data with predictable patterns
+ */
+static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
+						char pattern)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		buf[i] = pattern;
+}
+
+/*
+ * Submit and wait for a non-vectored I/O operation
+ * Combines io_uring_submit_sqe() and io_uring_wait_cqe() with result reporting
+ */
+static inline void io_uring_do_io_op(struct io_uring_submit *s, int fd,
+				     int op, void *buf, size_t len,
+				     off_t offset, sigset_t *sig,
+				     const char *msg)
+{
+	io_uring_submit_sqe(s, fd, op, buf, len, offset);
+
+	if (io_uring_wait_cqe(s, len, op, sig) == 0)
+		tst_res(TPASS, "%s", msg);
+}
+
+/*
+ * Submit and wait for a vectored I/O operation
+ * Combines io_uring_submit_sqe_vec() and io_uring_wait_cqe() with
+ * result reporting
+ */
+static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
+					 int op, struct iovec *iovs,
+					 int nvecs, off_t offset,
+					 int expected_size, sigset_t *sig,
+					 const char *msg)
+{
+	io_uring_submit_sqe_vec(s, fd, op, iovs, nvecs, offset);
+
+	if (io_uring_wait_cqe(s, expected_size, op, sig) == 0)
+		tst_res(TPASS, "%s", msg);
+}
+
+#endif /* IO_URING_COMMON_H */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
