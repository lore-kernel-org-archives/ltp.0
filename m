From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 5 Mar 2019 15:53:59 +0800
Subject: [LTP] [PATCH v1] pwritev2: Add new test for pwritev2 flag
	RWF_APPEND
In-Reply-To: <20190303165556.14574-1-tarun@zilogic.com>
References: <20190303165556.14574-1-tarun@zilogic.com>
Message-ID: <5C7E2B17.10100@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Tarun,

I have pushed Jinhui's patchset including pwritev201 and pwritev202, so 
could you rebase your patch?
Besides, some comments below. :-)

On 2019/03/04 0:55, tarun wrote:
> From: Tarun183<tarun@zilogic.com>
>
>      Signed-off-by: tarun.t.u<tarun@zilogic.com>
>      Signed-off-by: vaishnavi.d<vaishnavi.d@zilogic.com>
> ---
>   include/lapi/pwritev2.h                       |  35 ++++++
>   include/lapi/syscalls/arm.in                  |   1 +
>   include/lapi/syscalls/i386.in                 |   1 +
>   include/lapi/syscalls/powerpc.in              |   1 +
>   include/lapi/syscalls/powerpc64.in            |   1 +
>   include/lapi/syscalls/s390.in                 |   1 +
>   include/lapi/syscalls/s390x.in                |   1 +
>   include/lapi/syscalls/sparc.in                |   1 +
>   include/lapi/syscalls/sparc64.in              |   1 +
>   include/lapi/syscalls/x86_64.in               |   1 +
>   m4/ltp-pwritev2.m4                            |   9 ++
>   runtest/syscalls                              |   2 +
>   testcases/kernel/syscalls/pwritev2/.gitignore |   1 +
>   testcases/kernel/syscalls/pwritev2/Makefile   |  24 ++++
>   .../kernel/syscalls/pwritev2/pwritev201.c     | 108 ++++++++++++++++++
>   15 files changed, 188 insertions(+)
>   create mode 100644 include/lapi/pwritev2.h
>   create mode 100644 m4/ltp-pwritev2.m4
>   create mode 100644 testcases/kernel/syscalls/pwritev2/.gitignore
>   create mode 100644 testcases/kernel/syscalls/pwritev2/Makefile
>   create mode 100644 testcases/kernel/syscalls/pwritev2/pwritev201.c
>
> diff --git a/include/lapi/pwritev2.h b/include/lapi/pwritev2.h
> new file mode 100644
> index 000000000..7e243e1d1
> --- /dev/null
> +++ b/include/lapi/pwritev2.h
> @@ -0,0 +1,35 @@
> +//SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Referred from linux kernel -github/torvalds/linux/include/uapi/linux/fs.h
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2019
> + * Email: code@zilogic.com
> + */
> +#ifndef LAPI_PWRITEV2_H
> +#define LAPI_PWRITEV2_H
> +
> +#include<stdint.h>
> +#include<unistd.h>
> +#include "lapi/syscalls.h"
> +#include "config.h"
> +
> +#if !defined(HAVE_PWRITEV2)
> +
> +/* LO_HI_LONG taken from glibc */
> +# define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val))>>  32)
> +
> +ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
> +		int flags)
> +{
> +	return tst_syscall(__NR_pwritev2, fd, iov, iovcnt,
> +			   LO_HI_LONG(offset), flags);
> +}
> +#endif
> +
> +/*
> + * Flag for pwritev2
> + */
> +#ifndef RWF_APPEND
> +# define RWF_APPEND		0x00000010U
> +#endif
> +
> +#endif /* LAPI_PWRITEV2_H */
> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index e720b08ea..552790d9d 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -348,3 +348,4 @@ mlock2 (__NR_SYSCALL_BASE+390)
>   copy_file_range (__NR_SYSCALL_BASE+391)
>   preadv2 (__NR_SYSCALL_BASE+392)
>   statx (__NR_SYSCALL_BASE+397)
> +pwritev2 (__NR_SYSCALL_BASE+393)
> diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
> index 2fb018837..58526bea2 100644
> --- a/include/lapi/syscalls/i386.in
> +++ b/include/lapi/syscalls/i386.in
> @@ -346,3 +346,4 @@ mlock2 376
>   copy_file_range 377
>   preadv2 378
>   statx 383
> +pwritev2 379
> diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
> index d16f9f9a4..dcf8bb15f 100644
> --- a/include/lapi/syscalls/powerpc.in
> +++ b/include/lapi/syscalls/powerpc.in
> @@ -353,3 +353,4 @@ mlock2 378
>   copy_file_range 379
>   preadv2 380
>   statx 383
> +pwritev2 381
> diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
> index d16f9f9a4..dcf8bb15f 100644
> --- a/include/lapi/syscalls/powerpc64.in
> +++ b/include/lapi/syscalls/powerpc64.in
> @@ -353,3 +353,4 @@ mlock2 378
>   copy_file_range 379
>   preadv2 380
>   statx 383
> +pwritev2 381
> diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
> index 401943892..6d0c895fa 100644
> --- a/include/lapi/syscalls/s390.in
> +++ b/include/lapi/syscalls/s390.in
> @@ -336,3 +336,4 @@ execveat 354
>   mlock2 374
>   copy_file_range 375
>   preadv2 376
> +pwritev2 377
> diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
> index e156b0903..8105b5598 100644
> --- a/include/lapi/syscalls/s390x.in
> +++ b/include/lapi/syscalls/s390x.in
> @@ -335,3 +335,4 @@ execveat 354
>   mlock2 374
>   copy_file_range 375
>   preadv2 376
> +pwritev2 377
> diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
> index b7bb1358a..20a21a9ce 100644
> --- a/include/lapi/syscalls/sparc.in
> +++ b/include/lapi/syscalls/sparc.in
> @@ -341,3 +341,4 @@ execveat 350
>   mlock2 356
>   copy_file_range 357
>   preadv2 358
> +pwritev2 359
> diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
> index a211df8f1..36ab39420 100644
> --- a/include/lapi/syscalls/sparc64.in
> +++ b/include/lapi/syscalls/sparc64.in
> @@ -317,3 +317,4 @@ execveat 350
>   mlock2 356
>   copy_file_range 357
>   preadv2 358
> +pwritev2 359
> diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
> index dae5769f5..4e161eb71 100644
> --- a/include/lapi/syscalls/x86_64.in
> +++ b/include/lapi/syscalls/x86_64.in
> @@ -313,3 +313,4 @@ mlock2 325
>   copy_file_range 326
>   preadv2 327
>   statx 332
> +pwritev2 328
> diff --git a/m4/ltp-pwritev2.m4 b/m4/ltp-pwritev2.m4
> new file mode 100644
> index 000000000..10183d861
> --- /dev/null
> +++ b/m4/ltp-pwritev2.m4
> @@ -0,0 +1,9 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2019 Zilogic Systems Pvt Ltd. All rights reserved.
> +dnl Author: code@zilogic.com
> +
> +dnl LTP_CHECK_PWRITEV2
> +dnl ----------------------------
> +AC_DEFUN([LTP_CHECK_PWRITEV2],[
> +AC_CHECK_FUNCS(pwritev2,,)
> +])
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 8d5dcd014..444068d74 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1547,3 +1547,5 @@ statx06 statx06
>   statx07 statx07
>
>   membarrier01 membarrier01
> +
> +pwritev201   pwritev201
> diff --git a/testcases/kernel/syscalls/pwritev2/.gitignore b/testcases/kernel/syscalls/pwritev2/.gitignore
> new file mode 100644
> index 000000000..a9e43db82
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pwritev2/.gitignore
> @@ -0,0 +1 @@
> +pwritev2
> diff --git a/testcases/kernel/syscalls/pwritev2/Makefile b/testcases/kernel/syscalls/pwritev2/Makefile
> new file mode 100644
> index 000000000..21b65cf86
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pwritev2/Makefile
> @@ -0,0 +1,24 @@
> +#
> +#  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> +#  Email: code@zilogic.com
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
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> new file mode 100644
> index 000000000..638084b83
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2019
> + * Email: code@zilogic.com
> + */
> +
> +/*
> + * Test pwritev2
> + *
> + * This code test the behaviour of  RWF_APPEND in pwritev2
> + *
> + * case 1:
> + * With offset of zero and RWF_APPEND in pwritev2
> + * Excepted result: Current file offset should not update.
> + *
> + * case 2:
> + * With offset of "5" and RWF_APPEND in pwritev2
> + * Excepted result: Current file offset should not update.
> + *
> + * case 3:
> + * With offset of -1 and RWF_APPEND in pwritev2
> + * Excepted result: Current file offset should get update to current value.
> + *
> + * Testcases:
> + * Test1: Getting offset value from written file.
> + * Test2: Getting written data from file to verify written data by using LSEEK.
> + *
> + * Minimum Kernel version required is 4.16.
> + */
> +
> +#define _GNU_SOURCE
> +#include<stdio.h>
> +#include<string.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_get_bad_addr.h"
> +#include "lapi/pwritev2.h"
> +
> +#define TESTFILE0 "testfile0"
> +#define TESTFILE1 "testfile1"
> +#define TESTFILE2 "testfile2"
> +#define MODE 0644
> +#define OLD_OFFSET 14
> +#define UPDATED_OFFSET 25
> +
> +static struct test_case {
> +	char *filename;
> +	off_t offset;
> +	off_t exp_offset;
> +
> +} tcases[] = {
> +	{.filename = TESTFILE0, .offset = 0, .exp_offset = OLD_OFFSET},
> +	{.filename = TESTFILE1, .offset = 5, .exp_offset = OLD_OFFSET},
> +	{.filename = TESTFILE2, .offset = -1, .exp_offset = UPDATED_OFFSET},
> +};
> +
> +static void run_test(unsigned int i)
> +{
> +	struct iovec vector;
> +	struct test_case *tc =&tcases[i];
> +	char *std_data = "Linux Torvalds";
> +	char *append_data = "Hello World";
> +	char test_data[strlen(append_data) + 1];
> +	off_t cur_offset;
> +	int fd;
> +
> +	memset(test_data, 0, sizeof(test_data));
> +
> +	fd = SAFE_OPEN(tc->filename, O_RDWR | O_CREAT, MODE);
> +	SAFE_WRITE(1, fd, std_data, strlen(std_data));

Running pwritev201 in loops by -i option got the following error:
-----------------------------------------------------
pwritev203.c:60: PASS: Returned offset 14 as expected
pwritev203.c:68: PASS: Data appended as expected
pwritev203.c:57: FAIL: Returned offset 25 inspite of RWF_APPEND flag
-----------------------------------------------------

In this case, we should avoid appending data to the end of file 
repeatedly by truncating file.

> +
> +	vector.iov_base = append_data;
> +	vector.iov_len = strlen(append_data);
> +
> +	TEST(pwritev2(fd,&vector, 1, tc->offset, RWF_APPEND));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "pwritev2() returned with %ld",
> +			TST_RET);
> +		return;
> +	}
> +
> +	cur_offset = SAFE_LSEEK(fd, 0, SEEK_CUR);
> +	if (cur_offset != tc->exp_offset)
> +		tst_res(TFAIL,
> +			"Returned offset %ld inspite of RWF_APPEND flag",
> +			tc->exp_offset);
> +	else
> +		tst_res(TPASS, "Returned offset %ld as expected",
> +			tc->exp_offset);

Is it necessary for the test to continue if we get mismatched offset?

> +
> +	SAFE_LSEEK(fd, -(strlen(append_data)), SEEK_END);
> +
> +	SAFE_READ(0, fd, test_data, sizeof(test_data));
> +	if (strcmp(append_data, test_data) != 0)
> +		tst_res(TFAIL, "Data not appended as expected");
> +	else
> +		tst_res(TPASS, "Data appended as expected");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run_test,
> +	.min_kver = "4.16",

Some distros have backported RWF_APPEND flag into old kernels, so it 
seems better to use EOPNOTSUPP
returned by pwritev2() instead of kernel version to check the support of 
RWF_APPEND flag.

Best Regards,
Xiao Yang
> +	.needs_tmpdir = 1,
> +};



