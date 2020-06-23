From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jun 2020 15:45:32 +0200
Subject: [LTP] [PATCH V6] syscall: Add io_uring related tests
In-Reply-To: <20200601053550.3848-1-vikas.kumar2@arm.com>
References: <20200601053550.3848-1-vikas.kumar2@arm.com>
Message-ID: <20200623134532.GA13219@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Sorry for the delays, I've been quite bussy lately.

> ---
>  include/lapi/io_uring.h                       |  12 ++
>  testcases/kernel/syscalls/io_uring/Makefile   |   7 +
>  .../kernel/syscalls/io_uring/io_uring01.c     | 196 ++++++++++++++++++
>  3 files changed, 215 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/io_uring/Makefile
>  create mode 100644 testcases/kernel/syscalls/io_uring/io_uring01.c
> 
> diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
> index 5fde58e22..8e47501a5 100644
> --- a/include/lapi/io_uring.h
> +++ b/include/lapi/io_uring.h
> @@ -280,4 +280,16 @@ int io_uring_enter(int fd, unsigned int to_submit, unsigned int min_complete,
>  }
>  #endif /* HAVE_IO_URING_ENTER */
>  
> +void io_uring_setup_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 1, 0)) < 0) {
> +		TEST(syscall(__NR_io_uring_setup, NULL, 0));
> +		if (TST_RET != -1)
> +			SAFE_CLOSE(TST_RET);
> +		else if (TST_ERR == ENOSYS)
> +			tst_brk(TCONF,
> +				"Test not supported on kernel version < v5.1");
> +	}
> +}
> +
>  #endif /* IO_URING_H__ */
> diff --git a/testcases/kernel/syscalls/io_uring/Makefile b/testcases/kernel/syscalls/io_uring/Makefile
> new file mode 100644
> index 000000000..94a19de2f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2020 ARM Ltd.  All rights reserved.
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
> new file mode 100644
> index 000000000..92bf5cb44
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 ARM Ltd. All rights reserved.
> + * Author: Vikas Kumar <vikas.kumar2@arm.com>
> + *
> + * Tests for asynchronous I/O raw API i.e io_uring_setup(), io_uring_register()
> + * and io_uring_enter(). This tests validate basic API operation by creating a
> + * submission queue and a completion queue using io_uring_setup(). User buffer
> + * registered in the kernel for long term operation using io_uring_register().
> + * This tests initiates I/O operations with the help of io_uring_enter().
> + */
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/io_uring.h"
> +
> +#define QUEUE_DEPTH 1
> +#define BLOCK_SZ    1024
> +
> +static struct tcase {
> +	unsigned int setup_flags;
> +	unsigned int register_opcode;
> +	unsigned int enter_flags;
> +} tcases[] = {
> +	{IORING_SETUP_IOPOLL, IORING_REGISTER_BUFFERS, IORING_OP_READ_FIXED},
> +};
> +
> +struct io_sq_ring {
> +	unsigned int *head;
> +	unsigned int *tail;
> +	unsigned int *ring_mask;
> +	unsigned int *ring_entries;
> +	unsigned int *flags;
> +	unsigned int *array;
> +};
> +
> +struct io_cq_ring {
> +	unsigned int *head;
> +	unsigned int *tail;
> +	unsigned int *ring_mask;
> +	unsigned int *ring_entries;
> +	struct io_uring_cqe *cqes;
> +};
> +
> +struct submitter {
> +	int ring_fd;
> +	struct io_sq_ring sq_ring;
> +	struct io_uring_sqe *sqes;
> +	struct io_cq_ring cq_ring;
> +};
> +
> +struct buff_info {
> +	unsigned int buff_sz;
> +	struct iovec iovecs[];
> +};
> +
> +static struct submitter *s;
> +static struct buff_info *bi;
> +static sigset_t sig;
> +
> +static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
> +{
> +	struct io_sq_ring *sring = &s->sq_ring;
> +	struct io_cq_ring *cring = &s->cq_ring;
> +	struct io_uring_params p;
> +	void *ptr;
> +
> +	memset(&p, 0, sizeof(p));
> +	p.flags |= tc->setup_flags;
> +	s->ring_fd = io_uring_setup(QUEUE_DEPTH, &p);
> +	if (s->ring_fd == -1) {
> +		tst_res(TFAIL | TTERRNO, "io_uring_setup() failed");
> +		return 1;
> +	}
> +
> +	/* Submission queue ring buffer mapping */
> +	ptr = SAFE_MMAP(0, p.sq_off.array +
> +			p.sq_entries * sizeof(unsigned int),
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_POPULATE,
> +			s->ring_fd, IORING_OFF_SQ_RING);
> +	if (ptr == MAP_FAILED)
> +		return 1;

SAFE_MMAP() CANNOT! fail, it will exit the test if mmap() has failed.

> +	/* Save global submission queue struct info */
> +	sring->head = ptr + p.sq_off.head;
> +	sring->tail = ptr + p.sq_off.tail;
> +	sring->ring_mask = ptr + p.sq_off.ring_mask;
> +	sring->ring_entries = ptr + p.sq_off.ring_entries;
> +	sring->flags = ptr + p.sq_off.flags;
> +	sring->array = ptr + p.sq_off.array;
> +
> +	/* Submission queue entries ring buffer mapping */
> +	s->sqes = SAFE_MMAP(0, p.sq_entries *
> +			sizeof(struct io_uring_sqe),
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_POPULATE,
> +			s->ring_fd, IORING_OFF_SQES);
> +	if (s->sqes == MAP_FAILED)
> +		return 1;

Here as well.

> +	/* Completion queue ring buffer mapping */
> +	ptr = SAFE_MMAP(0,
> +			p.cq_off.cqes + p.cq_entries *
> +			sizeof(struct io_uring_cqe),
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_POPULATE,
> +			s->ring_fd, IORING_OFF_CQ_RING);
> +	if (ptr == MAP_FAILED)
> +		return 1;

And here as well.

> +	/* Save global completion queue struct info */
> +	cring->head = ptr + p.cq_off.head;
> +	cring->tail = ptr + p.cq_off.tail;
> +	cring->ring_mask = ptr + p.cq_off.ring_mask;
> +	cring->ring_entries = ptr + p.cq_off.ring_entries;
> +	cring->cqes = ptr + p.cq_off.cqes;
> +
> +	return 0;
> +}
> +
> +static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
> +{
> +	unsigned int index = 0, tail = 0, next_tail = 0;
> +	struct io_sq_ring *sring = &s->sq_ring;
> +	struct io_uring_sqe *sqe;
> +	void  *iov_base;
> +	size_t iov_len;
> +	int ret;
> +
> +	bi = SAFE_MALLOC(sizeof(*bi));
> +	iov_len = BLOCK_SZ;
> +	iov_base = SAFE_MALLOC(iov_len);
> +	memset(iov_base, 0, iov_len);
> +	bi->iovecs[index].iov_base = (void *)iov_base;
> +	bi->iovecs[index].iov_len = (size_t)iov_len;
> +
> +	ret = io_uring_register(s->ring_fd, tc->register_opcode,
> +				bi->iovecs, QUEUE_DEPTH);
> +	if (ret != 0) {
> +		tst_res(TFAIL | TTERRNO, "io_uring_register() failed");
> +		return 1;
> +	}
> +
> +	/* Submission queue entry addition to SQE ring buffer tail */
> +	tail = *sring->tail;
> +	next_tail = tail;
> +	next_tail++;
> +	index = tail & *s->sq_ring.ring_mask;
> +	sqe = &s->sqes[index];
> +	sqe->flags = 0;
> +	sqe->opcode = tc->enter_flags;
> +	sqe->addr = (unsigned long)bi->iovecs;
> +	sqe->user_data = (unsigned long long)bi;
> +	sring->array[index] = index;
> +	tail = next_tail;
> +
> +	/* Kernel to notice the tail update */
> +	if (*sring->tail != tail)
> +		*sring->tail = tail;
> +
> +	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, &sig);
> +	if (ret < 0) {
> +		tst_res(TFAIL | TTERRNO, "io_uring_enter() failed");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	s = SAFE_MALLOC(sizeof(*s));

There is no need to malloc() this, we can just keep it as a global
variable and pass &s to the functions below.

> +	memset(s, 0, sizeof(*s));
> +
> +	if (setup_io_uring_test(s, tc)) {
> +		tst_res(TFAIL | TTERRNO, "io_uring_setup error");

The setup_io_uring_test() prints the failure message, there is no need
to print a more generic and useless one here as well.

> +		return;
> +	}
> +	if (submit_to_uring_sq(s, tc)) {
> +		tst_res(TFAIL | TTERRNO, "io_uring_submit error");

Here as well, no need to print second message.

> +		return;
> +	}

Where is the cleanup_io_uring_test() that unamps the buffers?

> +	tst_res(TPASS, "functionality of io_uring API is correct");

Maybe we should as well print TPASS for each operation we do, i.e. for
each TFAIL message in setup_io_uring_test() and submit_io_uring_test().

> +}
> +
> +static struct tst_test test = {
> +	.setup = io_uring_setup_supported_by_kernel,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> +
> -- 
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
