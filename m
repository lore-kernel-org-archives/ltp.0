From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Feb 2021 16:56:58 +0100
Subject: [LTP] [PATCH v2 2/4] Add safe functions for io_uring to LTP
 library
In-Reply-To: <20210204110342.11821-2-mdoucha@suse.cz>
References: <20210204110342.11821-1-mdoucha@suse.cz>
 <20210204110342.11821-2-mdoucha@suse.cz>
Message-ID: <YB1qyucNa+aN3p2V@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/include/tst_safe_io_uring.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) Linux Test Project, 2021
> + */
> +
> +#ifndef TST_IO_URING_H__
> +#define TST_IO_URING_H__
> +
> +#include "config.h"
> +#include "lapi/io_uring.h"
> +
> +struct tst_io_uring {
> +	int fd;
> +	void *sqr_base, *cqr_base;
> +	/* buffer sizes in bytes for unmapping */
> +	size_t sqr_mapsize, cqr_mapsize;
> +
> +	/* Number of entries in the ring buffers */
> +	uint32_t sqr_size, cqr_size;
> +
> +	/* Submission queue pointers */
> +	struct io_uring_sqe *sqr_entries;
> +	const uint32_t *sqr_head, *sqr_mask, *sqr_flags, *sqr_dropped;
> +	uint32_t *sqr_tail, *sqr_array;
> +
> +	/* Completion queue pointers */
> +	const struct io_uring_cqe *cqr_entries;
> +	const uint32_t *cqr_tail, *cqr_mask, *cqr_overflow;
> +	uint32_t *cqr_head;
> +
nit: blank line.
> +};
...

> +++ b/lib/tst_safe_io_uring.c
...
> +	uring->sqr_base = safe_mmap(file, lineno, NULL, uring->sqr_mapsize,
> +		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, uring->fd,
> +		IORING_OFF_SQ_RING);
> +
> +	if (uring->sqr_base == MAP_FAILED)
> +		return -1;
IMHO this is not needed, safe_mmap() breaks on rval == MAP_FAILED.
> +
> +	uring->sqr_entries = safe_mmap(file, lineno, NULL,
> +		params->sq_entries * sizeof(struct io_uring_sqe),
> +		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, uring->fd,
> +		IORING_OFF_SQES);
> +
> +	if (uring->sqr_entries == MAP_FAILED)
> +		return -1;
And here.
> +
> +	uring->cqr_base = safe_mmap(file, lineno, NULL, uring->cqr_mapsize,
> +		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, uring->fd,
> +		IORING_OFF_CQ_RING);
> +
> +	if (uring->cqr_base == MAP_FAILED)
> +		return -1;
And here.

No need to repost, these two can be removed before merge.
The rest LGTM.

Kind regards,
Petr
