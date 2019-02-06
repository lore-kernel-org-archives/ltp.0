From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Feb 2019 08:52:00 +0100
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190128134656.27979-1-metan@ucw.cz>
References: <20190128134656.27979-1-metan@ucw.cz>
Message-ID: <20190206075159.GA13396@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> From: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> We are attempting to trigger the EAGAIN path for the RWF_NOWAIT flag.

> In order to do so the test runs three threads:

> * nowait_reader: reads from a random offset from a random file with
>                  RWF_NOWAIT flag and expects to get EAGAIN and short
>                  read sooner or later

> * writer_thread: rewrites random file in order to keep the underlying device
>                  bussy so that pages evicted from cache cannot be faulted
typo => busy
>                  immediatelly
typo => immediately

...
> +++ b/testcases/kernel/syscalls/preadv2/preadv203.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*
> + * This is a basic functional test for RWF_NOWAIT flag, we are attempting to
> + * force preadv2() either to return a short read or EAGAIN with three
> + * concurelntly running threads:
typo => concurrently

> + *
> + *  nowait_reader: reads from a random offset from a random file with
> + *                 RWF_NOWAIT flag and expects to get EAGAIN and short
> + *                 read sooner or later
> + *
> + *  writer_thread: rewrites random file in order to keep the underlying device
> + *                 bussy so that pages evicted from cache cannot be faulted
typo => busy

> + *                 immediatelly
typo => immediately

> + *
> + *  cache_dropper: attempts to evict pages from a cache in order for reader to
> + *                 hit evicted page sooner or later
> + */
> +
> +/*
> + * If test fails with EOPNOTSUPP you have likely hit a glibc bug:
> + *
> + * https://sourceware.org/bugzilla/show_bug.cgi?id=23579
> + *
> + * Which can be worked around by calling preadv2() directly by syscall() such as:
> + *
> + * static ssize_t sys_preadv2(int fd, const struct iovec *iov, int iovcnt,
> + *                            off_t offset, int flags)
> + * {
> + *	return syscall(SYS_preadv2, fd, iov, iovcnt, offset, offset>>32, flags);
> + * }
I wonder if we want either warn user or run it both via (g)libc wrapper and
directly the syscall.

BTW testing on kernel 4.20.0, glibc 2.28 with sys_preadv2() and still get TBROK
EOPNOTSUPP. I tried to test on ext[2-4], btrfs. I wonder what I'm missing.

Kind regards,
Petr
