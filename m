From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 May 2019 16:03:35 +0200
Subject: [LTP] [PATCH v1 1/2] syscalls/fstat{01,02}: rewrote testcases
In-Reply-To: <20190520055038.11499-1-camann@suse.com>
References: <20190520055038.11499-1-camann@suse.com>
Message-ID: <20190528140334.GA27526@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +++ b/testcases/kernel/syscalls/fstat/fstat.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) SUSE LLC, 2019
> + * Author: Christian Amann <camann@suse.com>
> + */
> +
> +#ifndef __FSTAT_H__
> +#define __FSTAT_H__
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include "lapi/syscalls.h"
> +
> +#define TEST_VARIANTS	2
> +#define TESTFILE	"test_file"
> +
> +static void syscall_info(void)
> +{
> +	if (tst_variant == 0) {
> +		tst_res(TINFO, "Testing libc fstat()");
> +		return;
> +	}
> +	tst_res(TINFO, "Testing syscall fstat()");
> +}
> +
> +static int tst_fstat(int fd, struct stat *statbuf)
> +{
> +	if (tst_variant == 0)
> +		return fstat(fd, statbuf);
> +	return tst_syscall(__NR_fstat, fd, statbuf);
> +}

Have you tested this wrapper with 32bit binary?

Because on x86 (among others) we do have fstat and fstat64 that differ
in the statbuf structure size (see man fstat NOTES). If I add a printf()
to print sizeof(struct stat) to the fstat01.c test on x86 I get 96 bytes
with _FILE_OFFSET_BITS=64 and 88 without, so I guess that this uses
wrong syscall with the _FILE_OFFSET_BITS=64 defined.

And actually there are three fstat variants there, the old_fstat, fstat
and fstat64, we could probably test all three variants but I guess that
old_fstat is actually not worth of the effort...

HINT: You can compile 32bit LTP on 64bit distribution with:
      ./configure CFLAGS=-m32 LDFLAGS=-m32.

-- 
Cyril Hrubis
chrubis@suse.cz
