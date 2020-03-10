From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Mar 2020 16:00:06 +0100
Subject: [LTP] [PATCH] Added refrence for Linux Asynchronous I/O
 io_uring System calls
In-Reply-To: <20200306094504.26175-1-vikas.kumar2@arm.com>
References: <20200306094504.26175-1-vikas.kumar2@arm.com>
Message-ID: <20200310150006.GA24561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
> new file mode 100644
> index 000000000..fc2821dd9
> --- /dev/null
> +++ b/include/lapi/io_uring.h
> @@ -0,0 +1,218 @@
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
> +
> +
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +
> +#ifdef __alpha__
> +/*
> + * alpha is the only exception, all other architectures
> + * have common numbers for new system calls.
> + */
> +# ifndef __NR_io_uring_setup
> +#  define __NR_io_uring_setup		535
> +# endif
> +# ifndef __NR_io_uring_enter
> +#  define __NR_io_uring_enter		536
> +# endif
> +# ifndef __NR_io_uring_register
> +#  define __NR_io_uring_register	537
> +# endif
> +#else /* !__alpha__ */
> +# ifndef __NR_io_uring_setup
> +#  define __NR_io_uring_setup		425
> +# endif
> +# ifndef __NR_io_uring_enter
> +#  define __NR_io_uring_enter		426
> +# endif
> +# ifndef __NR_io_uring_register
> +#  define __NR_io_uring_register	427
> +# endif
> +#endif

These numbers has to be added into the include/lapi/syscalls/*.in files
instead.

> +/*
> + * sqe->flags
> + */
> +#define IOSQE_FIXED_FILE	(1U << 0)	/* use fixed fileset */
> +#define IOSQE_IO_DRAIN		(1U << 1)	/* issue after inflight IO */
> +#define IOSQE_IO_LINK		(1U << 2)	/* links next sqe */
> +#define IOSQE_IO_HARDLINK	(1U << 3)	/* like LINK, but stronger */
> +
> +/*
> + * io_uring_setup() flags
> + */
> +#define IORING_SETUP_IOPOLL	(1U << 0)	/* io_context is polled */
> +#define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
> +#define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
> +#define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
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
> +/*
> + * sqe->fsync_flags
> + */
> +#define IORING_FSYNC_DATASYNC	(1U << 0)
> +
> +/*
> + * sqe->timeout_flags
> + */
> +#define IORING_TIMEOUT_ABS	(1U << 0)
> +
> +/*
> + * IO completion data structure (Completion Queue Entry)
> + */
> +struct io_uring_cqe {
> +	__u64	user_data;	/* sqe->data submission passed back */
> +	__s32	res;		/* result code for this event */
> +	__u32	flags;
> +};

We do prefer stdint in unserspace code, which would be uint64_t, int32_t
and uint32_t in this case.

> +/*
> + * Magic offsets for the application to mmap the data it needs
> + */
> +#define IORING_OFF_SQ_RING		0ULL
> +#define IORING_OFF_CQ_RING		0x8000000ULL
> +#define IORING_OFF_SQES			0x10000000ULL
> +
> +/*
> + * Filled with the offset for mmap(2)
> + */
> +struct io_sqring_offsets {
> +	__u32 head;
> +	__u32 tail;
> +	__u32 ring_mask;
> +	__u32 ring_entries;
> +	__u32 flags;
> +	__u32 dropped;
> +	__u32 array;
> +	__u32 resv1;
> +	__u64 resv2;
> +};
> +
> +/*
> + * sq_ring->flags
> + */
> +#define IORING_SQ_NEED_WAKEUP	(1U << 0) /* needs io_uring_enter wakeup */
> +
> +struct io_cqring_offsets {
> +	__u32 head;
> +	__u32 tail;
> +	__u32 ring_mask;
> +	__u32 ring_entries;
> +	__u32 overflow;
> +	__u32 cqes;
> +	__u64 resv[2];
> +};
> +
> +/*
> + * io_uring_enter(2) flags
> + */
> +#define IORING_ENTER_GETEVENTS	(1U << 0)
> +#define IORING_ENTER_SQ_WAKEUP	(1U << 1)
> +
> +/*
> + * Passed in for io_uring_setup(2). Copied back with updated info on success
> + */
> +struct io_uring_params {
> +	__u32 sq_entries;
> +	__u32 cq_entries;
> +	__u32 flags;
> +	__u32 sq_thread_cpu;
> +	__u32 sq_thread_idle;
> +	__u32 features;
> +	__u32 resv[4];
> +	struct io_sqring_offsets sq_off;
> +	struct io_cqring_offsets cq_off;
> +};
> +
> +/*
> + * io_uring_params->features flags
> + */
> +#define IORING_FEAT_SINGLE_MMAP		(1U << 0)
> +#define IORING_FEAT_NODROP		(1U << 1)
> +#define IORING_FEAT_SUBMIT_STABLE	(1U << 2)
> +
> +/*
> + * io_uring_register(2) opcodes and arguments
> + */
> +#define IORING_REGISTER_BUFFERS		0
> +#define IORING_UNREGISTER_BUFFERS	1
> +#define IORING_REGISTER_FILES		2
> +#define IORING_UNREGISTER_FILES		3
> +#define IORING_REGISTER_EVENTFD		4
> +#define IORING_UNREGISTER_EVENTFD	5
> +#define IORING_REGISTER_FILES_UPDATE	6
> +
> +struct io_uring_files_update {
> +	__u32 offset;
> +	__u32 resv;
> +	__aligned_u64 /* __s32 * */ fds;

Hmm, this one would be uint64_t __attribute__((aligned(8)))

> +};

All these constants and structures has to be guarded in order to avoid
conflicting definitions once they are added to libc.

For constants we can simply do:

#ifndef FOO
# define FOO xyz
#endif

The structures can probably be guarded together with the functions that
take them as parameters so for example:

#ifndef HAVE_IO_URING_SETUP
struct io_uring_params {
...
};

int io_uring_setup(...)
{
	...
}
#endif

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
> -- 
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
