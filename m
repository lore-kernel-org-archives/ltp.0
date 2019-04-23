From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Apr 2019 10:24:39 +0200
Subject: [LTP] [PATCH v1] syscalls/copy_file_range: add/restructured
	tests
In-Reply-To: <20190423070100.15005-1-camann@suse.com>
References: <20190423070100.15005-1-camann@suse.com>
Message-ID: <20190423082439.GA6401@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

good work. Some details below, not really related to copy_file_range() syscall.

> copy_file_range01:
> 	restructured testcase, removed unnecessary code,
> 	improved readability and shortened output (only
> 	failures get printed now).

> copy_file_range02:
> 	add testcases which test basic functions and error
> 	handling of the syscall.

> copy_file_range03:
> 	add testcase to check if this operation updates
> 	timestamps accordingly.

> Signed-off-by: Christian Amann <camann@suse.com>
> ---
>  .../kernel/syscalls/copy_file_range/.gitignore     |   2 +
>  .../syscalls/copy_file_range/copy_file_range.h     |  31 +++
>  .../syscalls/copy_file_range/copy_file_range01.c   | 229 +++++++++++----------
>  .../syscalls/copy_file_range/copy_file_range02.c   | 123 +++++++++++
>  .../syscalls/copy_file_range/copy_file_range03.c   |  78 +++++++
>  5 files changed, 355 insertions(+), 108 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>  create mode 100644 testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>  create mode 100644 testcases/kernel/syscalls/copy_file_range/copy_file_range03.c


1) You're missing newly added copy_file_range0{2,3} into runtest/syscalls.

2) There are some failures in old distros caused by variables initialised inside
for loop: error [1] [2]:

copy_file_range01.c: In function 'setup':
copy_file_range01.c:216:2: error: 'for' loop initial declarations are only allowed in C99 or C11 mode
  for (int i = 0; i < (int)(page_size * 4); i++)
  ^

...
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +
> +#ifndef __COPY_FILE_RANGE_H__
> +#define __COPY_FILE_RANGE_H__
> +
> +#include "lapi/syscalls.h"
> +
> +#define SUCCESS		0
I wonder if using <stdbool.h> and true/false wouldn't be better.
I know it's C++, but we're using this header in some tests already.
(than it'd be good to do the same approach in
testcases/kernel/syscalls/ioctl/ioctl08.c, other files defining it are still
using test.h - legacy API, so they're waiting for a cleanup).
+ you define SUCCESS also in copy_file_range02.c, which is using this header, so
it's redundant there.
> +
> +#define MNTPOINT	"mnt_point"
> +#define FILE_SRC_PATH   "file_src"
> +#define FILE_DEST_PATH  "file_dest"
> +#define FILE_RDONL_PATH "file_rdonl"
> +#define FILE_DIR_PATH	"file_dir"
> +#define FILE_MNTED_PATH	MNTPOINT"/file_mnted"
> +
> +
> +#define CONTENT "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345\n"
> +
> +static int sys_copy_file_range(int fd_in, loff_t *off_in,
> +		int fd_out, loff_t *off_out, size_t len, unsigned int flags)
> +{
> +	return tst_syscall(__NR_copy_file_range, fd_in, off_in, fd_out,
> +			off_out, len, flags);
> +}

According to man copy_file_range(2) there is also glibc implementation since
glibc 2.27 (in io/copy_file_range-compat.c, with tests in io/tst-copy_file_range.c).
Maybe it'd be good to test also this via .test_variants [3]. That'd require
autotools check for libc implementation.

...
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> @@ -1,5 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) Linux Test Project, 2017
> + * Copyright (c) Linux Test Project, 2019
>   *
>   * This program is free software;  you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -12,55 +13,28 @@
>   * the GNU General Public License for more details.
>   */

> +/*
> + * This tests the fundamental functionalities of the copy_file_range
> + * syscall. It does so by copying the contents of one file into
> + * another using various different combinations for length and
> + * input/output offsets.
> + *
> + * After a copy is done this test checks if the contents of both files
> + * are equal at the given offsets. It is also inspected if the offsets
> + * of the file descriptors are advanced correctly.
> + */
> +
>  #define _GNU_SOURCE
nitpicking: Any idea why _GNU_SOURCE is needed? It's in a man page, but even
when compiling without -D_FORTIFY_SOURCE=2 it does not complain.

...
> +static void openFiles(void)
I guess we prefer underscore instead of camel case style (i.e. open_files).
> +{
> +	fd_in  = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY);
> +	fd_out = SAFE_OPEN(FILE_DEST_PATH, O_CREAT | O_WRONLY | O_TRUNC, 0644);
> +}
> +
> +static void closeFiles(void)
Same here.
> +{
> +	if (fd_out > 0)
> +		SAFE_CLOSE(fd_out);
> +	if (fd_in  > 0)
> +		SAFE_CLOSE(fd_in);
>  }
...

Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/523356189/log.txt
[2] https://api.travis-ci.org/v3/job/523356184/log.txt
[3] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2229-testing-similar-syscalls-in-one-test
