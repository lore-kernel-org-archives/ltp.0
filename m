From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 May 2021 23:56:24 +0200
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the
 new API
In-Reply-To: <20210519084655.52780-3-xieziyao@huawei.com>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-3-xieziyao@huawei.com>
Message-ID: <YKbbCLUlaICqSIK5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xie,

> +++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
...
> + * Copyright (c) International Business Machines  Corp., 2014
Again, missing copyright.

> +/*\
> + * [Description]
>   *
> - * DESCRIPTION
> - *        Testcase copied from sendfile02.c to test the basic functionality of
> - *        the sendfile(2) system call on large file. There is a kernel bug which
> - *        introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
> + * Testcase copied from sendfile02.c to test the basic functionality of
> + * the sendfile(2) system call on large file. There is a kernel bug which
> + * introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
If 8f9c0119d7ba caused a regression it shouldn't be in .tags (it contains
commits which are fixes and should be backported). Also it's a question if it's
useful info, because this commit is mentioned in 5d73320a96fcc (fixing commit).

>   *
> - * ALGORITHM
> - *        1. call sendfile(2) with offset at 0
> - *        2. call sendfile(2) with offset at 3GB
> + * [Algorithm]
>   *
> - * USAGE:  <for command-line>
> - *  sendfile09 [-c n] [-i n] [-I x] [-P x] [-t]
> - *     where,
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> + * 1. Call sendfile(2) with offset at 0;
> + * 2. Call sendfile(2) with offset at 3GB.
>   *
> + * [Restrictions]
>   *
> - * RESTRICTIONS
> - *        Only supports 64bit systems and kernel 2.6.33 or above
> + * Only supports 64bit systems and kernel 2.6.33 or above.
nit: Maybe: Only 64bit systems are supported.

I'm not a native speaker, but "Only supports" sounds wrong to me.
Also although I'd keep .min_kver, mentioning it is IMHO necessary -
why to repeat info we have in .tags? We still do that, but IMHO we should
stop doing it. And this ancient version is certainly not worth duplicity
(latest tested kernel is 3.10 [1]).

sendfile09.c:58: WARNING: Missing a blank line after declarations
sendfile09.c:75: WARNING: Missing a blank line after declarations
sendfile09.c:80: WARNING: Comparisons should place the constant on the right side of the test
sendfile09.c:82: WARNING: quoted string split across lines
sendfile09.c:86: WARNING: quoted string split across lines
sendfile09.c:90: WARNING: quoted string split across lines

>   */
> -#include <stdio.h>
> -#include <errno.h>
> +
>  #include <fcntl.h>
>  #include <sys/stat.h>
>  #include <sys/sendfile.h>
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <inttypes.h>
Again, only these are needed:

#include <inttypes.h>
#include <sys/sendfile.h>

#include "tst_test.h"
#include "lapi/abisize.h"

> -static void cleanup(void);
> -static void setup(void);
> +#ifndef OFF_T
> +#define OFF_T off_t
> +#endif
I wonder where OFF_T comes from and if we can just simply use off_t.

> -#define ONE_GB (INT64_C(1) << 30)
> +#define ONE_GB		(INT64_C(1) << 30)
> +#define IN_FILE		"in_file"
> +#define OUT_FILE	"out_file"

:...
> +static void setup(void)
>  {
> -	int i;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> -
> -	/* make a temporary directory and cd to it */
> -	tst_tmpdir();
> -
> -	if (!tst_fs_has_free(NULL, ".", 5, TST_GB))
> -		tst_brkm(TCONF, cleanup, "sendfile(2) on large file"
> -			" needs 5G free space.");
> +	if (!tst_fs_has_free(".", 5, TST_GB))
> +		tst_brk(TCONF, "Test on large file needs 5G free space");

> -	/* create a 4G file */
> -	fd = SAFE_CREAT(cleanup, in_file, 00700);
> -	for (i = 1; i <= (4 * 1024); i++) {
> -		SAFE_LSEEK(cleanup, fd, 1024 * 1024 - 1, SEEK_CUR);
> -		SAFE_WRITE(cleanup, 1, fd, "C", 1);
> +	int fd = SAFE_CREAT(IN_FILE, 00700);
> +	for (int i = 1; i <= (4 * 1024); ++i) {
This will lead to error in old compilers:
error: 'for' loop initial declarations are only allowed in C99 mode
https://travis-ci.org/github/pevik/ltp/jobs/771837120
https://travis-ci.org/github/pevik/ltp/jobs/771837126

It must be:

int i;

...
for (i = 1; i <= (4 * 1024); ++i) {

Thus probably better to declare fd before as well.

int i, fd;

...
> +static void run(unsigned int i)
>  {
...
> +	off_t before_pos, after_pos;
> +	before_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
> +
> +	TEST(sendfile(out_fd, in_fd, &offset, tc[i].count));
> +	after_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
> +
> +	if (TST_RET != tc[i].exp_retval)
> +		tst_res(TFAIL, "sendfile(2) failed to return expected value, "
> +			       "expected: %" PRId64 ", got: %ld",
> +			tc[i].exp_retval, TST_RET);
> +	else if (offset != tc[i].exp_updated_offset)
> +		tst_res(TFAIL, "sendfile(2) failed to update OFFSET parameter to "
> +			       "expected value, expected: %" PRId64 ", got: %" PRId64,
> +			tc[i].exp_updated_offset, (int64_t)(offset));
> +	else if (before_pos != after_pos)
> +		tst_res(TFAIL, "sendfile(2) updated the file position of in_fd "
> +			       "unexpectedly, expected file position: %" PRId64
> +			       ", actual file position %" PRId64,
> +			(int64_t)(before_pos), (int64_t)(after_pos));
Yes, we probably cannot avoid splitting string here, unless TST_EXP_FAIL() can
be used here.

I'd avoid 2 in "sendfile(2).

> +	else
> +		tst_res(TPASS, "sendfile(2) with %s", tc[i].desc);

Again, minor things, I can fix them before merge.

Kind regards,
Petr
