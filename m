From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Sep 2021 15:19:45 +0200
Subject: [LTP] [PATCH] syscalls/pread01: Convert to new API
In-Reply-To: <1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com>
Message-ID: <YS998a/fPdH5aZh8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dai,

LGTM, few notes below, I can fix everything before merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  testcases/kernel/syscalls/pwrite/pwrite01.c | 336 +++++-----------------------
>  1 file changed, 57 insertions(+), 279 deletions(-)

> diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
> index 937160a..83b0bdf 100644
> --- a/testcases/kernel/syscalls/pwrite/pwrite01.c
> +++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
> @@ -1,86 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
As you haven't added your license, I'll add LTP project license.
> + * 07/2001 Ported by Wayne Boyer
>   */

...
> +/*\
> + * [Description]
>   *
> - * Test Description:
>   *  Verify the functionality of pwrite() by writing known data using pwrite()
>   *  to the file at various specified offsets and later read from the file from
>   *  various specified offsets, comparing the data written aganist the data
typo: aganist -> against. Going to fix it before merge.
>   *  read using read().

...
> -#define _XOPEN_SOURCE 500
>  #define TEMPFILE	"pwrite_file"
>  #define K1              1024
>  #define K2              (K1 * 2)
> @@ -88,249 +25,90 @@
>  #define K4              (K1 * 4)
>  #define NBUFS           4

You kept using kilobyte constants. IMHO it'd be more readable just to use numeric (1024, 2048, 3072, 4096), but
let's keep it.


> -char *TCID = "pwrite01";
> -int TST_TOTAL = 1;
> -int fildes;			/* file descriptor for tempfile */
> -char *write_buf[NBUFS];		/* buffer to hold data to be written */
> +static int fildes;
> +char *write_buf[NBUFS];
> +char *read_buf[NBUFS];
write_buf and read_buf should also be static.

...
> +static void verify_pwrite(void)
>  {
> +	SAFE_PWRITE(1, fildes, write_buf[0], K1, 0);
> +	l_seek(fildes, 0, SEEK_CUR, 0);
> +	l_seek(fildes, K1 / 2, SEEK_SET, K1 / 2);

> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	SAFE_PWRITE(1, fildes, write_buf[2], K1, K2);
> +	l_seek(fildes, 0, SEEK_CUR, K1 / 2);
> +	l_seek(fildes, K3, SEEK_SET, K3);

> -	TEST_PAUSE;
> +	SAFE_WRITE(1, fildes, write_buf[3], K1);
> +	l_seek(fildes, 0, SEEK_CUR, K4);

> -	/* Allocate/Initialize the write buffer with known data */
> -	init_buffers();
> +	SAFE_PWRITE(1, fildes, write_buf[1], K1, K1);

> -	tst_tmpdir();
> +	check_file_contents();

> -	/* Creat a temporary file used for mapping */
> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> -		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
> -			 TEMPFILE, errno, strerror(errno));
> -	}
> +	l_seek(fildes, 0, SEEK_SET, 0);
your code:
static void verify_pread(void)
{
	SAFE_PREAD(1, fildes, read_buf[2], K1, K2);

	l_seek(fildes, 0, SEEK_CUR, K4);

	l_seek(fildes, 0, SEEK_SET, 0);

	SAFE_PREAD(1, fildes, read_buf[3], K1, K3);

	l_seek(fildes, 0, SEEK_CUR, 0);

	SAFE_READ(1, fildes, read_buf[0], K1);

	l_seek(fildes, 0, SEEK_CUR, K1);

	SAFE_PREAD(1, fildes, read_buf[1], K1, K1);

	l_seek(fildes, 0, SEEK_CUR, K1);

	compare_bufers();

	l_seek(fildes, K4, SEEK_SET, K4);
}

nit: having blank line after each line?

how about something like:

static void verify_pread(void)
{
	SAFE_PREAD(1, fildes, read_buf[2], K1, K2);
	l_seek(fildes, 0, SEEK_CUR, K4);
	l_seek(fildes, 0, SEEK_SET, 0);

	SAFE_PREAD(1, fildes, read_buf[3], K1, K3);
	l_seek(fildes, 0, SEEK_CUR, 0);

	SAFE_READ(1, fildes, read_buf[0], K1);
	l_seek(fildes, 0, SEEK_CUR, K1);

	SAFE_PREAD(1, fildes, read_buf[1], K1, K1);
	l_seek(fildes, 0, SEEK_CUR, K1);

	compare_bufers();

	l_seek(fildes, K4, SEEK_SET, K4);
}

The rest LGTM.

Kind regards,
Petr
