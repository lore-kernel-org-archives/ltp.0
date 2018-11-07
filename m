From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Nov 2018 16:38:55 +0100
Subject: [LTP] [PATCH v2 1/2] syscalls/fremovexattr: Add fremovexattr()
 tests
In-Reply-To: <20181105002536.29715-1-rafael.tinoco@linaro.org>
References: <CABdQkv_WgpXPyeNzKRBhkgRg4vMPU7oRCgC1i=tv_TSEkg7buw@mail.gmail.com>
 <20181105002536.29715-1-rafael.tinoco@linaro.org>
Message-ID: <20181107153855.GA8153@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Test Name: fremovexattr01
> + *
> + * Description:
> + * Like removexattr(2), fremovexattr(2) also removes an extended attribute,
> + * identified by a name, from a file but, instead of using a filename path, it
> + * uses a descriptor. This test verifies that a simple call to fremovexattr(2)
> + * removes, indeed, a previously set attribute key/value from a file.
> + */
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +# include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define ENOATTR ENODATA
> +
> +#define XATTR_TEST_KEY "user.testkey"
> +#define XATTR_TEST_VALUE "this is a test value"
> +#define XATTR_TEST_VALUE_SIZE 20
> +
> +#define MNTPOINT "mntpoint"
> +#define FNAME MNTPOINT"/fremovexattr01testfile"
> +
> +static int fd = -1;
> +static char *got_value;

Why not just static char got_value[XATTR_TEST_VALUE_SIZE]?

> +static void verify_fremovexattr(void)
> +{
> +	SAFE_FSETXATTR(fd, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +			XATTR_TEST_VALUE_SIZE, XATTR_CREATE);
> +
> +	TEST(fremovexattr(fd, XATTR_TEST_KEY));
> +
> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO, "fremovexattr(2) failed");
> +		return;
> +	}
> +
> +	memset(got_value, 0, XATTR_TEST_VALUE_SIZE);
> +
> +	TEST(fgetxattr(fd, XATTR_TEST_KEY, got_value, XATTR_TEST_VALUE_SIZE));
> +
> +	if (TST_RET >= 0) {
> +		tst_res(TFAIL, "fremovexattr(2) did not remove attribute");
> +		return;
> +	}
> +
> +	if (TST_RET < 0 && TST_ERR != ENOATTR) {
> +		tst_brk(TBROK, "fremovexattr(2) could not verify removal");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "fremovexattr(2) removed attribute as expected");
> +}
> +
> +static void cleanup(void)
> +{
> +	free(got_value);
> +
> +	close(fd);
        ^
	if (fd > 0)
		SAFE_CLOSE(fd);

	would be slightly better here as it would emit
	warning if the close() has failed.

> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(FNAME, 0644, NULL);
> +
> +	fd = SAFE_OPEN(FNAME, O_RDWR, NULL);
                                      ^
				      open() is a variable argument
				      function and the third argument is
				      an integer but only in a case that
				      we passed O_CREAT in the flags, if
				      we are not creating the file
				      it should be omitted

So if we want to create the file, we don't have to call the SAFE_TOUCH()
but pass O_CREAT in the flags and pass the mode as third argument here
as:

	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0644);


> +	TEST(fremovexattr(fd, XATTR_TEST_KEY));
> +
> +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP) {
> +		tst_brk(TCONF, "fremovexattr(2) not supported");
> +		return;
                ^
		No need for the return here.

> +	}
> +
> +	got_value = SAFE_MALLOC(XATTR_TEST_VALUE_SIZE);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = verify_fremovexattr,
> +	.cleanup = cleanup,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};
> +
> +#else /* HAVE_SYS_XATTR_H */
> +TST_TEST_TCONF("<sys/xattr.h> does not exist");
> +#endif
> diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
> new file mode 100644
> index 000000000..5585b6abe
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Linaro Limited. All rights reserved.
> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
> + */
> +
> +/*
> + * Test Name: fremovexattr02
> + *
> + * Test cases::
> + * 1) fremovexattr(2) fails if the named attribute does not exist.
> + * 2) fremovexattr(2) fails if file descriptor is not valid.
> + * 3) fremovexattr(2) fails if named attribute has an invalid address.
> + *
> + * Expected Results:
> + * fremovexattr(2) should return -1 and set errno to ENODATA.
> + * fremovexattr(2) should return -1 and set errno to EBADF.
> + * fremovexattr(2) should return -1 and set errno to EFAULT.
> + */
> +
> +#include "config.h"
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +# include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define XATTR_TEST_KEY "user.testkey"
> +
> +#define MNTPOINT "mntpoint"
> +#define FNAME MNTPOINT"/fremovexattr02testfile"
> +
> +static int fd = -1;
> +
> +struct test_case {
> +	int fd;
> +	char *key;
> +	char *value;
> +	char *gotvalue;
> +	int size;
> +	int exp_ret;
> +	int exp_err;
> +};
> +
> +struct test_case tc[] = {
> +	{				/* case 1: attribute does not exist */
> +	 .key = XATTR_TEST_KEY,
> +	 .exp_ret = -1,
> +	 .exp_err = ENODATA,
> +	 },
> +	{				/* case 2: file descriptor is invalid */
> +	 .fd = -1,
> +	 .key = XATTR_TEST_KEY,
> +	 .exp_ret = -1,
> +	 .exp_err = EBADF,
> +	 },
> +	{				/* case 3: bad name attribute */
> +	 .exp_ret = -1,
> +	 .exp_err = EFAULT,
> +	},
> +};
> +
> +static void verify_fremovexattr(unsigned int i)
> +{
> +	TEST(fremovexattr(tc[i].fd, tc[i].key));
> +
> +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
> +		tst_brk(TCONF, "fremovexattr(2) not supported");
> +
> +	if (tc[i].exp_ret == TST_RET) {
> +
> +		if (tc[i].exp_err) {
> +			if (tc[i].exp_err == TST_ERR) {
> +				tst_res(TPASS, "fremovexattr(2) passed");
> +				return;
> +			}
> +		} else  {
> +			tst_res(TPASS, "fremovexattr(2) passed");
> +			return;
> +		}
> +	}
> +
> +	tst_res(TFAIL | TTERRNO, "fremovexattr(2) failed");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	size_t i = 0;
> +
> +	SAFE_TOUCH(FNAME, 0644, NULL);
> +	fd = SAFE_OPEN(FNAME, O_RDWR, NULL);

Here as well no need for the SAFE_TOUCH().

> +	for (i = 0; i < ARRAY_SIZE(tc); i++) {
> +
> +		if (tc[i].fd != -1)
> +			tc[i].fd = fd;
> +
> +		if (!tc[i].key && tc[i].exp_err == EFAULT)
> +			tc[i].key = tst_get_bad_addr(cleanup);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = verify_fremovexattr,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};

I'm wondering if we need the all_filesystem here, I guess that the
ENODATA test will reach down to the filesystem driver, so it's probably
relevant here.

> +#else /* HAVE_SYS_XATTR_H */
> +TST_TEST_TCONF("<sys/xattr.h> does not exist");
> +#endif
> -- 
> 2.19.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
