From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 11:33:17 +0200
Subject: [LTP] RFC:[PATCH v1] Added test case to test mmap with
 MAP_SHARED_VALIDATE flag
In-Reply-To: <20201005085555.2072-1-paulson@zilogic.com>
References: <20201005085555.2072-1-paulson@zilogic.com>
Message-ID: <20201014093317.GA31816@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch adds a new test case for the mmap syscall. It tests the
> MAP_SHARED_VALIDATE flag of mmap. The code checks if MAP_SHARED_VALIDATE
> returns EOPNOTSUPP when mapped with an invalid flag value. It does so by
> setting the unused bits of the flag argument.
> Git Hub Issue link - https://github.com/linux-test-project/ltp/issues/298
> 
> Signed-off-by: Paulson Raja L. <paulson@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> 
> ---
>  testcases/kernel/syscalls/mmap/mmap18.c | 66 +++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap18.c
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
> new file mode 100644
> index 000000000..e9ed4dfa6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap18.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
> + * Email: code@zilogic.com
> + */
> +
> +/*
> + * Test mmap with MAP_SHARED_VALIDATE flag
> + *
> + * We are testing the MAP_SHARED_VALIDATE flag of mmap() syscall. To check
> + * if there is an invalid flag value, the MAP_SHARED_VALIDATE returns
> + * EOPNOTSUPP.The unused bits in the MAP_SHARED_VALIDATE is found,
> + * and by setting the unused bits of the flag argument the flag value
> + * becomes invalid and the error EOPNOTSUPP is produced as expected.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <linux/mman.h>
> +#include <errno.h>
> +#include "tst_test.h"
> +
> +#define TEST_FILE "file_to_mmap"
> +#define TEST_FILE_SIZE 1024
> +#define TEST_FILE_MODE 0600
> +
> +static int fd_file;
> +static void *mapped_address;
> +
> +static void setup(void)
> +{
> +	fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, TEST_FILE_MODE);
> +	if (tst_fill_file(TEST_FILE, 'a', TEST_FILE_SIZE, 1))
> +		tst_brk(TBROK, "Could not fill Testfile !");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_file > 0)
> +		SAFE_CLOSE(fd_file);
> +	if (mapped_address != MAP_FAILED && mapped_address != NULL)
> +		SAFE_MUNMAP(mapped_address, TEST_FILE_SIZE);
> +}
> +
> +static void test_mmap(void)
> +{
> +	mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
> +			(1 << 7) | (1 << 9) | MAP_SHARED_VALIDATE, fd_file, 0);

Can't we just pass MAP_ANONYMOUS here instead of having a backing file
for the mapping?

> +	if (mapped_address != MAP_FAILED)
> +		tst_res(TFAIL | TERRNO, "mmap() is successful,but it should have failed");
> +	else if (errno == EOPNOTSUPP)
> +		tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP");
> +	else
> +		tst_res(TFAIL | TERRNO, "mmap() failed with the unexpected error");
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = test_mmap,
> +	.min_kver = "4.15",
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
