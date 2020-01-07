From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jan 2020 16:21:08 +0100
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <20191218131533.15323-1-mdoucha@suse.cz>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz>
Message-ID: <20200107152108.GA27182@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Changes since v1:
> - XFS keeps some free blocks even when write() failed with ENOSPC. Repeat
>   fallocate() until it gets ENOSPC, too.
> - Deallocate only part of the file.
> - Add description of test scenario in the header comment.
> - Increase test device size to 1GB to avoid unrealistic Btrfs edge cases.

Do we really need 1GB here? That quadruples the runtime. Aren't we good
with just 512MB, that would just double it?

> Changes since v2:
> - Deallocate whole file on Btrfs, otherwise the PUNCH_HOLE check will fail.
>   Btrfs deallocates only complete file extents by design.
> 
>  .../kernel/syscalls/fallocate/fallocate05.c   | 116 ++++++++++++++----
>  1 file changed, 89 insertions(+), 27 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
> index 17034e5b1..34faabbe8 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate05.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
> @@ -1,75 +1,134 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
>   */
>  
>  /*
>   * Tests that writing to fallocated file works when filesystem is full.
> + * Test scenario:
> + * - fallocate() some empty blocks
> + * - fill the filesystem
> + * - write() into the preallocated space
> + * - try to fallocate() more blocks until we get ENOSPC
> + * - write() into the extra allocated space
> + * - deallocate part of the file
> + * - write() to the end of file to check that some blocks were freed
>   */
>  
>  #define _GNU_SOURCE
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <errno.h>
> +#include <string.h>
>  #include <fcntl.h>
>  #include "tst_test.h"
>  #include "lapi/fallocate.h"
>  
>  #define MNTPOINT "mntpoint"
> -#define FALLOCATE_SIZE (1024*1024)
> +#define FALLOCATE_BLOCKS 16
> +#define DEALLOCATE_BLOCKS 4
>  #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
>  
>  static int fd;
> +static char *buf = NULL;

There is no point in setting global variable to zero/NULL.

>  static void run(void)
>  {
> -	char buf[FALLOCATE_SIZE];
> -	ssize_t ret;
> +	long bufsize, extsize, tmp;
> +	blksize_t blocksize;
> +	struct stat statbuf;
>  
>  	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
>  
> -	if (fallocate(fd, 0, 0, FALLOCATE_SIZE)) {
> -		if (errno == EOPNOTSUPP) {
> -			tst_res(TCONF | TERRNO, "fallocate() not supported");
> +	/*
> +	 * Use real FS block size, otherwise fallocate() call will test
> +	 * different things on different platforms
> +	 */
> +	SAFE_FSTAT(fd, &statbuf);
> +	blocksize = statbuf.st_blksize;
> +	bufsize = FALLOCATE_BLOCKS * blocksize;
> +	buf = realloc(buf, bufsize);
> +
> +	if (!buf) {
> +		SAFE_CLOSE(fd);
> +		tst_brk(TBROK, "Buffer allocation failed");
> +	}

Why realloc()? Each filesystem is tested in separately forked process so
buf can't be anything but NULL here.

So this should just simply be SAFE_MALLOC() and this piece of code, the
part that gets the blocksize and allocates the buffer should be moved
into the test setup() function that is executed also once per
filesystem. And the free should be in the test cleanup().

That way we would allocate the buffer only once if the test was executed
with -i option.

> +	TEST(fallocate(fd, 0, 0, bufsize));
> +
> +	if (TST_RET) {
> +		if (TST_ERR == ENOTSUP) {
>  			SAFE_CLOSE(fd);
> -			return;
> +			tst_brk(TCONF | TTERRNO, "fallocate() not supported");
>  		}
>  
> -		tst_brk(TBROK | TERRNO,
> -			"fallocate(fd, 0, 0, %i)", FALLOCATE_SIZE);
> +		tst_brk(TBROK | TTERRNO, "fallocate(fd, 0, 0, %ld)", bufsize);
>  	}
>  
>  	tst_fill_fs(MNTPOINT, 1);
>  
> -	ret = write(fd, buf, sizeof(buf));
> +	TEST(write(fd, buf, bufsize));
>  
> -	if (ret < 0)
> -		tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
> +	if (TST_RET < 0)
> +		tst_res(TFAIL | TTERRNO, "write() failed unexpectedly");
> +	else if (TST_RET != bufsize)
> +		tst_res(TFAIL,
> +			"Short write(): %ld bytes (expected %zu)",
> +			TST_RET, bufsize);
>  	else
> -		tst_res(TPASS, "write() wrote %zu bytes", ret);
> +		tst_res(TPASS, "write() wrote %ld bytes", TST_RET);
> +
> +	/*
> +	 * Some file systems may still have a few extra blocks that can be
> +	 * allocated.
> +	 */
> +	for (TST_RET = 0, extsize = 0; !TST_RET; extsize += blocksize) {
> +		TEST(fallocate(fd, 0, bufsize + extsize, blocksize));
> +	}

This is minor, but LKML prefers not to have curly braces around single
line blocks.

> +	if (TST_RET != -1)
> +		tst_brk(TFAIL, "Invalid fallocate() return value %ld",
> +			TST_RET);

Isn't this line under 80 chars even with the TST_RET); at the end?

> -	ret = fallocate(fd, 0, FALLOCATE_SIZE, FALLOCATE_SIZE);
> -	if (ret != -1)
> -		tst_brk(TFAIL, "fallocate() succeeded unexpectedly");
> +	if (TST_ERR != ENOSPC)
> +		tst_brk(TFAIL | TTERRNO, "fallocate() should fail with ENOSPC");
>  
> -	if (errno != ENOSPC)
> -		tst_brk(TFAIL | TERRNO, "fallocate() should fail with ENOSPC");
> +	/* The loop above always counts 1 more block than it should. */
> +	extsize -= blocksize;
> +	tst_res(TINFO, "fallocate()d %ld extra blocks on full FS",
> +		extsize / blocksize);
>  
> -	tst_res(TPASS | TERRNO, "fallocate() on full FS");
> +	for (tmp = extsize; tmp > 0; tmp -= TST_RET) {
> +		TEST(write(fd, buf, MIN(bufsize, tmp)));
>  
> -	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, FALLOCATE_SIZE);
> -	if (ret == -1) {
> -		if (errno == EOPNOTSUPP)
> +		if (TST_RET <= 0)
> +			tst_brk(TFAIL | TTERRNO, "write() failed unexpectedly");

tst_brk(TFAIL, is not allowed at the moment, see:

https://github.com/linux-test-project/ltp/issues/462

The only current solution is to tst_res() + return

Also shouldn't we check for the write size here as well?

> +	}
> +
> +	tst_res(TPASS, "fallocate() on full FS");
> +
> +	/* Btrfs deallocates only complete extents, not individual blocks */
> +	if (!strcmp(tst_device->fs_type, "btrfs")) {
> +		tmp = bufsize + extsize;
> +	} else {
> +		tmp = DEALLOCATE_BLOCKS * blocksize;
> +	}
> +
> +	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
> +		tmp));

Here as well, isn't the line under 80 chars?



Other than these minor things the changes looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
