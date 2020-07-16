From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Jul 2020 16:33:52 +0200
Subject: [LTP] [PATCH V8] syscall: Add io_uring related tests
In-Reply-To: <20200714032408.9201-1-vikas.kumar2@arm.com>
References: <20200714032408.9201-1-vikas.kumar2@arm.com>
Message-ID: <20200716143352.GA11713@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've finished the test code and pushed, thanks.

I've changed it so that it actually reads data and checks the result,
and also properly unmaps the buffers (fixes failures with -i 10 passed
to the test), the diff is attached below.

Also I will have to check if we need the read/write barriers, I guess
that the way we use the interface it's safe, since the syscalls provide
natural boundary between kernel and userspace. But they would be needed
for a different tests anyways.

Also I had to remove the IORING_SETUP_IOPOLL flag since that made all
SQEs fail with EOPNOTSUPP for me.

The diff:

diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index bcfc2fd7b..70151bb85 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2020 ARM Ltd. All rights reserved.
  * Author: Vikas Kumar <vikas.kumar2@arm.com>
  *
+ * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
+ *
  * Tests for asynchronous I/O raw API i.e io_uring_setup(), io_uring_register()
  * and io_uring_enter(). This tests validate basic API operation by creating a
  * submission queue and a completion queue using io_uring_setup(). User buffer
@@ -17,6 +19,8 @@
 #include "tst_test.h"
 #include "lapi/io_uring.h"
 
+#define TEST_FILE "test_file"
+
 #define QUEUE_DEPTH 1
 #define BLOCK_SZ    1024
 
@@ -25,7 +29,7 @@ static struct tcase {
 	unsigned int register_opcode;
 	unsigned int enter_flags;
 } tcases[] = {
-	{IORING_SETUP_IOPOLL, IORING_REGISTER_BUFFERS, IORING_OP_READ_FIXED},
+	{0, IORING_REGISTER_BUFFERS, IORING_OP_READ_FIXED},
 };
 
 struct io_sq_ring {
@@ -52,22 +56,22 @@ struct submitter {
 	struct io_cq_ring cq_ring;
 };
 
-struct buff_info {
-	unsigned int buff_sz;
-	struct iovec iovecs[];
-};
-
 static struct submitter sub_ring;
 static struct submitter *s = &sub_ring;
-static struct buff_info *bi;
 static sigset_t sig;
+static struct iovec *iov;
+
+
+static void *sptr;
+static size_t sptr_size;
+static void *cptr;
+static size_t cptr_size;
 
 static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
 {
 	struct io_sq_ring *sring = &s->sq_ring;
 	struct io_cq_ring *cring = &s->cq_ring;
 	struct io_uring_params p;
-	void *ptr;
 
 	memset(&p, 0, sizeof(p));
 	p.flags |= tc->setup_flags;
@@ -75,24 +79,25 @@ static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
 	if (s->ring_fd != -1) {
 		tst_res(TPASS, "io_uring_setup() passed");
 	} else {
-		tst_res(TFAIL | TTERRNO, "io_uring_setup() failed");
+		tst_res(TFAIL | TERRNO, "io_uring_setup() failed");
 		return 1;
 	}
 
+	sptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
+
 	/* Submission queue ring buffer mapping */
-	ptr = SAFE_MMAP(0, p.sq_off.array +
-			p.sq_entries * sizeof(unsigned int),
+	sptr = SAFE_MMAP(0, sptr_size,
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_POPULATE,
 			s->ring_fd, IORING_OFF_SQ_RING);
 
 	/* Save global submission queue struct info */
-	sring->head = ptr + p.sq_off.head;
-	sring->tail = ptr + p.sq_off.tail;
-	sring->ring_mask = ptr + p.sq_off.ring_mask;
-	sring->ring_entries = ptr + p.sq_off.ring_entries;
-	sring->flags = ptr + p.sq_off.flags;
-	sring->array = ptr + p.sq_off.array;
+	sring->head = sptr + p.sq_off.head;
+	sring->tail = sptr + p.sq_off.tail;
+	sring->ring_mask = sptr + p.sq_off.ring_mask;
+	sring->ring_entries = sptr + p.sq_off.ring_entries;
+	sring->flags = sptr + p.sq_off.flags;
+	sring->array = sptr + p.sq_off.array;
 
 	/* Submission queue entries ring buffer mapping */
 	s->sqes = SAFE_MMAP(0, p.sq_entries *
@@ -101,59 +106,107 @@ static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
 			MAP_SHARED | MAP_POPULATE,
 			s->ring_fd, IORING_OFF_SQES);
 
+	cptr_size = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
+
 	/* Completion queue ring buffer mapping */
-	ptr = SAFE_MMAP(0,
-			p.cq_off.cqes + p.cq_entries *
-			sizeof(struct io_uring_cqe),
+	cptr = SAFE_MMAP(0, cptr_size,
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_POPULATE,
 			s->ring_fd, IORING_OFF_CQ_RING);
 
 	/* Save global completion queue struct info */
-	cring->head = ptr + p.cq_off.head;
-	cring->tail = ptr + p.cq_off.tail;
-	cring->ring_mask = ptr + p.cq_off.ring_mask;
-	cring->ring_entries = ptr + p.cq_off.ring_entries;
-	cring->cqes = ptr + p.cq_off.cqes;
+	cring->head = cptr + p.cq_off.head;
+	cring->tail = cptr + p.cq_off.tail;
+	cring->ring_mask = cptr + p.cq_off.ring_mask;
+	cring->ring_entries = cptr + p.cq_off.ring_entries;
+	cring->cqes = cptr + p.cq_off.cqes;
 
 	return 0;
 }
 
+static void check_buffer(char *buffer, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (buffer[i] != 'a') {
+			tst_res(TFAIL, "Wrong data@offset %zu", i);
+			break;
+		}
+	}
+
+	if (i == len)
+		tst_res(TPASS, "Buffer filled in correctly");
+}
+
+static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
+{
+	struct io_cq_ring *cring = &s->cq_ring;
+	unsigned int head = *cring->head;
+	unsigned int events = 0;
+
+	for (head = *cring->head; head != *cring->tail; head++) {
+		struct io_uring_cqe *cqe = &cring->cqes[head & *s->cq_ring.ring_mask];
+
+		events++;
+
+		if (cqe->res < 0) {
+			tst_res(TFAIL, "CQE result %s", tst_strerrno(-cqe->res));
+		} else {
+			struct iovec *iovecs = (void*)cqe->user_data;
+
+			if (cqe->res == BLOCK_SZ)
+				tst_res(TPASS, "CQE result %i", cqe->res);
+			else
+				tst_res(TFAIL, "CQE result %i expected %i", cqe->res, BLOCK_SZ);
+
+			check_buffer(iovecs[0].iov_base, cqe->res);
+		}
+	}
+
+	*cring->head = head;
+
+	if (exp_events == events) {
+		tst_res(TPASS, "Got %u completion events", events);
+		return;
+	}
+
+	tst_res(TFAIL, "Got %u completion events expected %u",
+	        events, exp_events);
+}
+
 static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
 {
 	unsigned int index = 0, tail = 0, next_tail = 0;
 	struct io_sq_ring *sring = &s->sq_ring;
 	struct io_uring_sqe *sqe;
-	void  *iov_base;
-	size_t iov_len;
 	int ret;
 
-	bi = SAFE_MALLOC(sizeof(*bi));
-	iov_len = BLOCK_SZ;
-	iov_base = SAFE_MALLOC(iov_len);
-	memset(iov_base, 0, iov_len);
-	bi->iovecs[index].iov_base = (void *)iov_base;
-	bi->iovecs[index].iov_len = (size_t)iov_len;
+	memset(iov->iov_base, 0, iov->iov_len);
 
 	ret = io_uring_register(s->ring_fd, tc->register_opcode,
-				bi->iovecs, QUEUE_DEPTH);
+				iov, QUEUE_DEPTH);
 	if (ret == 0) {
 		tst_res(TPASS, "io_uring_register() passed");
 	} else {
-		tst_res(TFAIL | TTERRNO, "io_uring_register() failed");
+		tst_res(TFAIL | TERRNO, "io_uring_register() failed");
 		return 1;
 	}
 
+	int fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
+
 	/* Submission queue entry addition to SQE ring buffer tail */
 	tail = *sring->tail;
-	next_tail = tail;
-	next_tail++;
+	next_tail = tail + 1;
 	index = tail & *s->sq_ring.ring_mask;
 	sqe = &s->sqes[index];
 	sqe->flags = 0;
+	sqe->fd = fd;
 	sqe->opcode = tc->enter_flags;
-	sqe->addr = (unsigned long)bi->iovecs;
-	sqe->user_data = (unsigned long long)bi;
+	sqe->addr = (unsigned long)iov->iov_base;
+	sqe->len = BLOCK_SZ;
+	sqe->off = 0;
+	sqe->user_data = (unsigned long long)iov;
 	sring->array[index] = index;
 	tail = next_tail;
 
@@ -161,14 +214,16 @@ static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
 	if (*sring->tail != tail)
 		*sring->tail = tail;
 
-	ret =  io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, &sig);
-	if (ret >= 0) {
-		tst_res(TPASS, "io_uring_enter() passed");
+	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, &sig);
+	if (ret == 1) {
+		tst_res(TPASS, "io_uring_enter() waited for 1 event");
 	} else {
-		tst_res(TFAIL | TTERRNO, "io_uring_enter() failed");
+		tst_res(TFAIL | TERRNO, "io_uring_enter() returned %i", ret);
+		SAFE_CLOSE(fd);
 		return 1;
 	}
 
+	SAFE_CLOSE(fd);
 	return 0;
 }
 
@@ -177,24 +232,37 @@ static void cleanup_io_uring_test(void)
 	io_uring_register(s->ring_fd, IORING_UNREGISTER_BUFFERS,
 			  NULL, QUEUE_DEPTH);
 	SAFE_MUNMAP(s->sqes, sizeof(struct io_uring_sqe));
+	SAFE_MUNMAP(cptr, cptr_size);
+	SAFE_MUNMAP(sptr, sptr_size);
+	SAFE_CLOSE(s->ring_fd);
 }
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	memset(s, 0, sizeof(*s));
 	if (setup_io_uring_test(s, tc))
 		return;
 
-	if (submit_to_uring_sq(s, tc))
-		return;
+	if (!submit_to_uring_sq(s, tc))
+		drain_uring_cq(s, 1);
 
 	cleanup_io_uring_test();
 }
 
+static void setup(void)
+{
+	io_uring_setup_supported_by_kernel();
+	tst_fill_file(TEST_FILE, 'a', 1024, 1);
+}
+
 static struct tst_test test = {
-	.setup = io_uring_setup_supported_by_kernel,
+	.setup = setup,
 	.test = run,
+	.needs_tmpdir = 1,
 	.tcnt = ARRAY_SIZE(tcases),
+	.bufs = (struct tst_buffers []) {
+		{&iov, .iov_sizes = (int[]){BLOCK_SZ, -1}},
+		{}
+	}
 };

-- 
Cyril Hrubis
chrubis@suse.cz
