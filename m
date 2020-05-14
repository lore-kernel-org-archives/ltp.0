From: Vikas Kumar <vikas.kumar2@arm.com>
Date: Thu, 14 May 2020 22:58:31 +0530
Subject: [LTP] [PATCH V4 1/1] syscall: Add io_uring test
In-Reply-To: <20200514172831.27854-1-vikas.kumar2@arm.com>
References: <20200514172831.27854-1-vikas.kumar2@arm.com>
Message-ID: <20200514172831.27854-2-vikas.kumar2@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added Linux asynchronous I/O API Test for io_uring_setup(),
io_uring_register() and io_uring_enter().
This test will check io_uring api basic operation.

Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Cc: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/io_uring/Makefile   |   8 +
 .../kernel/syscalls/io_uring/io_uring01.c     | 191 ++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/Makefile
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring01.c

diff --git a/testcases/kernel/syscalls/io_uring/Makefile b/testcases/kernel/syscalls/io_uring/Makefile
new file mode 100644
index 000000000..24cd01ba8
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2020 ARM Embedded Technologies Private Ltd. All rights reserved.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
new file mode 100644
index 000000000..d250b2966
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 ARM Embedded Technologies Private Ltd.
+ * All rights reserved.
+ * Author: Vikas Kumar <vikas.kumar2@arm.com>
+ *
+ * Added Test for Linux asynchronous I/O raw API:
+ * io_uring_setup(), io_uring_register() and io_uring_enter().
+ */
+
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/io_uring.h"
+
+static struct tcase{
+	int test_count;
+	int flag;
+} tcases[] = {{1, 0}, };
+
+#define QUEUE_DEPTH 1
+#define BLOCK_SZ    1024
+
+struct io_sq_ring {
+	unsigned *head;
+	unsigned *tail;
+	unsigned *ring_mask;
+	unsigned *ring_entries;
+	unsigned *flags;
+	unsigned *array;
+};
+
+struct io_cq_ring {
+	unsigned *head;
+	unsigned *tail;
+	unsigned *ring_mask;
+	unsigned *ring_entries;
+	struct io_uring_cqe *cqes;
+};
+
+struct submitter {
+	int ring_fd;
+	struct io_sq_ring sq_ring;
+	struct io_uring_sqe *sqes;
+	struct io_cq_ring cq_ring;
+};
+
+struct file_info {
+	off_t buff_sz;
+	struct iovec iovecs[];
+};
+
+struct submitter *s;
+struct file_info *fi;
+sigset_t sig;
+
+int setup_io_uring_test(struct submitter *s)
+{
+	struct io_sq_ring *sring = &s->sq_ring;
+	struct io_cq_ring *cring = &s->cq_ring;
+	struct io_uring_params p;
+	void *ptr;
+
+	memset(&p, 0, sizeof(p));
+	s->ring_fd = io_uring_setup(QUEUE_DEPTH, &p);
+	if (s->ring_fd == -1) {
+		tst_res(TFAIL | TTERRNO, "io_uring setup return error");
+		return 1;
+	}
+
+	//submission queue ring buffer mapping
+	ptr = SAFE_MMAP(0, p.sq_off.array + p.sq_entries * sizeof(__u32),
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+		s->ring_fd, IORING_OFF_SQ_RING);
+	if (ptr == MAP_FAILED)
+		return 1;
+
+	// save global submission queue struct info
+	sring->head = ptr + p.sq_off.head;
+	sring->tail = ptr + p.sq_off.tail;
+	sring->ring_mask = ptr + p.sq_off.ring_mask;
+	sring->ring_entries = ptr + p.sq_off.ring_entries;
+	sring->flags = ptr + p.sq_off.flags;
+	sring->array = ptr + p.sq_off.array;
+
+	//submission queue entries ring buffer mapping
+	s->sqes = SAFE_MMAP(0, p.sq_entries * sizeof(struct io_uring_sqe),
+			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+			s->ring_fd, IORING_OFF_SQES);
+	if (s->sqes == MAP_FAILED)
+		return 1;
+
+	//completion queue ring buffer mapping
+	ptr = SAFE_MMAP(0,
+		p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe),
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+		s->ring_fd, IORING_OFF_CQ_RING);
+	if (ptr == MAP_FAILED)
+		return 1;
+
+	//save global completion queue struct info
+	cring->head = ptr + p.cq_off.head;
+	cring->tail = ptr + p.cq_off.tail;
+	cring->ring_mask = ptr + p.cq_off.ring_mask;
+	cring->ring_entries = ptr + p.cq_off.ring_entries;
+	cring->cqes = ptr + p.cq_off.cqes;
+
+	return 0;
+}
+
+int submit_to_uring_sq(struct submitter *s)
+{
+	unsigned index = 0, tail = 0, next_tail = 0;
+	struct io_sq_ring *sring = &s->sq_ring;
+	struct io_uring_sqe *sqe;
+	int ret;
+
+	fi = SAFE_MALLOC(sizeof(*fi));
+	if (!fi)
+		return 1;
+
+	fi->buff_sz = BLOCK_SZ;
+	fi->iovecs[index].iov_base = (void *)fi;
+	fi->iovecs[index].iov_len = (size_t)fi->buff_sz;
+
+	ret = io_uring_register(s->ring_fd, IORING_REGISTER_BUFFERS,
+			fi->iovecs, QUEUE_DEPTH);
+	if (ret != 0) {
+		tst_res(TFAIL | TTERRNO, "io_uring register return error");
+		return 1;
+	}
+
+	//Submission queue entry addition to the tail of the SQE ring buffer
+	next_tail = tail = *sring->tail;
+	next_tail++;
+	index = tail & *s->sq_ring.ring_mask;
+	sqe = &s->sqes[index];
+	sqe->flags = 0;
+	sqe->opcode = IORING_OP_NOP;
+	sqe->addr = (unsigned long) fi->iovecs;
+	sqe->user_data = (unsigned long long) fi;
+	sring->array[index] = index;
+	tail = next_tail;
+
+	//Kernel to notice the tail update
+	if (*sring->tail != tail)
+		*sring->tail = tail;
+
+	ret =  io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, &sig);
+	if (ret < 0) {
+		tst_res(TFAIL | TTERRNO, "io_uring enter return error");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void setup(void)
+{
+	int ret;
+
+	s = SAFE_MALLOC(sizeof(*s));
+	if (!s)
+		return;
+
+	memset(s, 0, sizeof(*s));
+	ret = setup_io_uring_test(s);
+	if (ret)
+		tst_res(TFAIL | TTERRNO, "io_uring setup status: %d", ret);
+}
+
+static void run(void)
+{
+	int ret;
+
+	ret = submit_to_uring_sq(s);
+	if (ret)
+		tst_res(TFAIL | TTERRNO, "io_uring submit status: %d", ret);
+	else
+		tst_res(TPASS, "functionality of io_uring() is correct");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.17.1

