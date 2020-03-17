From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 21:59:50 +0100
Subject: [LTP] [PATCH 1/1] Added Refrence for Linux Asynchronous IO APIs
 in LTP
In-Reply-To: <20200313062058.7058-2-vikas.kumar2@arm.com>
References: <20200313062058.7058-1-vikas.kumar2@arm.com>
 <20200313062058.7058-2-vikas.kumar2@arm.com>
Message-ID: <20200317205950.GB22450@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vikas,

Maybe first line of the commit message should be simple:
"syscalls: Add io_uring tests".

> Added Linux Asynchronous IO(AIO) family of APIs in LTP
> AIO API: io_uring_setup(), io_uring_register(), io_uring_enter()

> Refrences for Linux AIO-

FYI: you can add version to your patch set by -vN (this patch should have been
sent with -v2).

I need to look into io_uring, so this time it's just about small errors and
formatting.

The main problem I see is that the test actually does not test much. What was
your intention to test?  Name of the test and directory suggests you want to
test all 3 syscalls, but you actually test just one flag for
io_uring_register(). It'd be good add a more tests (or we can merge your commit
and add more tests ourselves).

Maybe take some examples from doc? https://kernel.dk/io_uring.pdf mentions at
least https://git.kernel.dk/cgit/fio/tree/t/io_uring.c.

> https://lwn.net/Articles/776703/
> https://kernel.dk/io_uring.pdf
> https://www.mankier.com/2/io_uring_setup
> https://www.mankier.com/2/io_uring_register
> https://www.mankier.com/2/io_uring_enter

I'd remove these docs links.

> Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>

> ---
> ---
>  configure.ac                                  |   3 +
>  include/lapi/io_uring.h                       | 180 ++++++++++++++++++
>  testcases/kernel/syscalls/io_uring/.gitignore |   1 +
>  testcases/kernel/syscalls/io_uring/Makefile   |  25 +++
>  .../kernel/syscalls/io_uring/io_uring01.c     |  85 +++++++++
>  5 files changed, 294 insertions(+)
>  create mode 100644 include/lapi/io_uring.h
>  create mode 100644 testcases/kernel/syscalls/io_uring/.gitignore
>  create mode 100644 testcases/kernel/syscalls/io_uring/Makefile
>  create mode 100644 testcases/kernel/syscalls/io_uring/io_uring01.c

> diff --git a/configure.ac b/configure.ac
> index c9ec39fce..a50f793e9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -88,6 +88,9 @@ AC_CHECK_FUNCS([ \
>      getdents \
>      getdents64 \
>      io_pgetevents \
> +    io_uring_setup \
> +    io_uring_register \
> +    io_uring_enter \
>      kcmp \
>      mkdirat \
>      mknodat \
> diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
> new file mode 100644
> index 000000000..9fd96728e
> --- /dev/null
> +++ b/include/lapi/io_uring.h
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 ARM. All rights reserved.
> + * Author: Vikas Kumar <vikas.kumar2@arm.com>
> + */
> +
> +#ifndef IO_URING_H__
> +#define IO_URING_H__
> +
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/uio.h>
You also need <stdlib.h> (for malloc(), compiler warns you if you compile the
test).

> +
> +
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +
> +
Sorry for formatting nit: here are unnecessary blank lines (although they are
needed to make code readable, one is usually enough). Also blank lines before }
(end of function) doesn't help readability. On the other hand you sometimes
don't put space after comma in function arguments.

> +#ifndef HAVE_IO_URING_SETUP || HAVE_IO_URING_REGISTER || HAVE_IO_URING_ENTER
This is wrong (if you compile it, you'll see it).

This would work
#if !(defined(HAVE_IO_URING_SETUP) || defined(HAVE_IO_URING_REGISTER) || defined(HAVE_IO_URING_ENTER))

but I guess checking existence of first definition would be enough:
#ifndef IOSQE_FIXED_FILE
> +
> +
> +/* sqe->flags */
> +#define IOSQE_FIXED_FILE	(1U << 0)	/* use fixed fileset */
> +#define IOSQE_IO_DRAIN		(1U << 1)	/* issue after inflight IO */
> +#define IOSQE_IO_LINK		(1U << 2)	/* links next sqe */
> +#define IOSQE_IO_HARDLINK	(1U << 3)	/* like LINK, but stronger */
> +
> +/* io_uring_setup() flags */
> +#define IORING_SETUP_IOPOLL	(1U << 0)	/* io_context is polled */
> +#define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
> +#define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
> +#define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
> +
> +/* sqe->fsync_flags */
> +#define IORING_FSYNC_DATASYNC	(1U << 0)
> +
> +/* sqe->timeout_flags */
> +#define IORING_TIMEOUT_ABS	(1U << 0)
> +
> +/* Magic offsets for the application to mmap the data it needs */
> +#define IORING_OFF_SQ_RING		0ULL
> +#define IORING_OFF_CQ_RING		0x8000000ULL
> +#define IORING_OFF_SQES			0x10000000ULL
> +
> +/* sq_ring->flags */
> +#define IORING_SQ_NEED_WAKEUP	(1U << 0) /* needs io_uring_enter wakeup */
> +
> +/* io_uring_enter(2) flags */
> +#define IORING_ENTER_GETEVENTS	(1U << 0)
> +#define IORING_ENTER_SQ_WAKEUP	(1U << 1)
> +
> +/* io_uring_params->features flags */
> +#define IORING_FEAT_SINGLE_MMAP		(1U << 0)
> +#define IORING_FEAT_NODROP		(1U << 1)
> +#define IORING_FEAT_SUBMIT_STABLE	(1U << 2)
> +
> +/* io_uring_register(2) opcodes and arguments */
> +#define IORING_REGISTER_BUFFERS		0
> +#define IORING_UNREGISTER_BUFFERS	1
> +#define IORING_REGISTER_FILES		2
> +#define IORING_UNREGISTER_FILES		3
> +#define IORING_REGISTER_EVENTFD		4
> +#define IORING_UNREGISTER_EVENTFD	5
> +#define IORING_REGISTER_FILES_UPDATE	6
> +
> +#endif 
> +
> +
> +
> +#ifndef HAVE_IO_URING_SETUP || HAVE_IO_URING_REGISTER || HAVE_IO_URING_ENTER
I didn't get why you repeat the condition?
> +
> +enum {
> +	IORING_OP_NOP,
> +	IORING_OP_READV,
> +	IORING_OP_WRITEV,
> +	IORING_OP_FSYNC,
> +	IORING_OP_READ_FIXED,
> +	IORING_OP_WRITE_FIXED,
> +	IORING_OP_POLL_ADD,
> +	IORING_OP_POLL_REMOVE,
> +	IORING_OP_SYNC_FILE_RANGE,
> +	IORING_OP_SENDMSG,
> +	IORING_OP_RECVMSG,
> +	IORING_OP_TIMEOUT,
> +	IORING_OP_TIMEOUT_REMOVE,
> +	IORING_OP_ACCEPT,
> +	IORING_OP_ASYNC_CANCEL,
> +	IORING_OP_LINK_TIMEOUT,
> +	IORING_OP_CONNECT,
> +
> +	/* this goes last, obviously */
> +	IORING_OP_LAST,
> +};
> +
> +/* IO completion data structure (Completion Queue Entry) */
> +struct io_uring_cqe {
> +	uint64_t	user_data;	/* sqe->data submission passed back */
> +	int32_t 	res;		/* result code for this event */
> +	uint32_t	flags;
> +};
> +
> +/* Filled with the offset for mmap(2) */
> +struct io_sqring_offsets {
> +	uint32_t head;
> +	uint32_t tail;
> +	uint32_t ring_mask;
> +	uint32_t ring_entries;
> +	uint32_t flags;
> +	uint32_t dropped;
> +	uint32_t array;
> +	uint32_t resv1;
> +	uint64_t resv2;
> +};
> +
> +struct io_cqring_offsets {
> +	uint32_t head;
> +	uint32_t tail;
> +	uint32_t ring_mask;
> +	uint32_t ring_entries;
> +	uint32_t overflow;
> +	uint32_t cqes;
> +	uint64_t resv[2];
> +};
> +
> +/* Passed in for io_uring_setup(2). Copied back with updated info on success */
> +struct io_uring_params {
> +	uint32_t sq_entries;
> +	uint32_t cq_entries;
> +	uint32_t flags;
> +	uint32_t sq_thread_cpu;
> +	uint32_t sq_thread_idle;
> +	uint32_t features;
> +	uint32_t resv[4];
> +	struct io_sqring_offsets sq_off;
> +	struct io_cqring_offsets cq_off;
> +};
> +
> +
> +struct io_uring_files_update {
> +	uint32_t offset;
> +	uint32_t resv;
> +	uint64_t __attribute__((aligned(8))) fds;
> +};
> +
> +#endif 
> +
> +
> +#ifndef HAVE_IO_URING_REGISTER
> +int io_uring_register(int fd, unsigned int opcode, void *arg,
> +		      unsigned int nr_args)
> +{
> +	return tst_syscall(__NR_io_uring_register, fd, opcode, arg, nr_args);
> +}
> +#endif /* HAVE_IO_URING_REGISTER */
> +
> +
> +#ifndef HAVE_IO_URING_SETUP
> +int io_uring_setup(unsigned int entries, struct io_uring_params *p)
> +{
> +	return tst_syscall(__NR_io_uring_setup, entries, p);
> +}
> +#endif /* HAVE_IO_URING_SETUP */
> +
> +#ifndef HAVE_IO_URING_ENTER
> +int io_uring_enter(int fd, unsigned int to_submit, unsigned int min_complete,
> +		   unsigned int flags, sigset_t *sig)
> +{
> +	return tst_syscall(__NR_io_uring_enter, fd, to_submit, min_complete,
> +			flags, sig, _NSIG / 8);
> +}
> +#endif /* HAVE_IO_URING_ENTER */
> +
> +
> +
> +#endif /* IO_URING_H__ */
> +
> +
> diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
> new file mode 100644
> index 000000000..cac043b6c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/.gitignore
> @@ -0,0 +1 @@
> +/io_submit01
> diff --git a/testcases/kernel/syscalls/io_uring/Makefile b/testcases/kernel/syscalls/io_uring/Makefile
> new file mode 100644
> index 000000000..268d2e74b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2001
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
This verbose GPL text should be replaced by:
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 ARM Embedded Technologies Private Ltd. All rights reserved.

> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +LDLIBS			+= $(AIO_LIBS)
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
> new file mode 100644
> index 000000000..9bfbc78c1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 ARM Embedded Technologies Private Ltd. All rights reserved.
> + * Author: Vikas Kumar <vikas.kumar2@arm.com>
> + *
> + * Use new Linux AIO API io_uring_*().
> + */
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <fcntl.h>
> +
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#include "lapi/syscalls.h"
> +#include "lapi/io_uring.h"
> +
> +
> +#define DEPTH	1
> +
> +struct io_uring_params param_iouring;
> +int fd, ret;
> +struct iovec iovecs; 
> +void *iov_base_addr; 
> +int iov_size = 64; 
iov_size is used just in setup(), should be moved there.
> +
> +static struct tcase {
> +	int test_count;
You don't use test_count at all. What do you wanted to have it for?
> +	int test_no;
> +} tcases[] = {
> +	/* TEST IO URING REGISTER BUFFERS*/
This commit is IMHO useless.

> +	{1, IORING_REGISTER_BUFFERS},
> +};
Well, I've noted that this does not cover much.

> +
> +static void setup(void)
> +{
> +	
> +	memset(&param_iouring, 0, sizeof(param_iouring));
> +
> +	param_iouring.flags |= IORING_SETUP_IOPOLL;
> +
> +	fd = io_uring_setup(DEPTH, &param_iouring);
> +	if (!fd)
> +		tst_brk(TBROK | TERRNO, "io_uring_setup() returned %d", fd);
> +
> +	iov_base_addr = malloc(sizeof(iov_size));
> +
> +	iovecs.iov_base = iov_base_addr;
> +	iovecs.iov_len = iov_size;
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	io_uring_register(fd, IORING_UNREGISTER_BUFFERS, NULL,DEPTH);
> +	memset(&param_iouring, 0, sizeof(param_iouring));
> +	free(iov_base_addr);
> +}
> +
> +
> +static void verify_io_submit(unsigned int n)
> +{
> +	struct tcase *t = &tcases[n];
You don't use t at all...
> +	int ret;
> +
> +	ret = io_uring_register(fd, IORING_REGISTER_BUFFERS, &iovecs,DEPTH);
you should use it like
> +	ret = io_uring_register(fd, t->flag, &iovecs,DEPTH);
We usually use TEST() macro...
> +
> +	if (ret == 0) {
> +		tst_res(TPASS, "io_uring_register() return %d",ret);
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "io_uring_register() returned %d",ret);

... something like this:
	TEST(io_uring_register(fd, tc->flag, &iovecs, DEPTH));
	if (TST_RET == -1) {
		tst_res(TFAIL | TTERRNO, "io_uring_register() returned %d", ret);
		return;
	}

	tst_res(TPASS, "io_uring_register() return %d",ret);


Kind regards,
Petr
