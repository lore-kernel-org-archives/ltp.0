From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Oct 2016 18:03:46 +0200
Subject: [LTP] [PATCH v2 3/3] writev01: rewrite and drop partially valid
 iovec tests
In-Reply-To: <d6b408e9dcb22db9c362377a2d35876fdb6d7096.1475827191.git.jstancek@redhat.com>
References: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
 <d6b408e9dcb22db9c362377a2d35876fdb6d7096.1475827191.git.jstancek@redhat.com>
Message-ID: <20161010160346.GG1684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + *   Copyright (c) International Business Machines  Corp., 2001
> + *                 Linux Test Project, 2016
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;
> + */
> +
> +/*
> + * DESCRIPTION
> + *	Testcase to check the basic functionality of writev(2) system call.
> + *	Create IO vectors and attempt to writev various components of it.
> + */
> +
> +#include <errno.h>
> +#include <signal.h>
> +#include <sys/uio.h>
> +#include "tst_test.h"
> +
> +#define	CHUNK		64
> +#define	TESTFILE	"writev_data_file"
> +
> +static int valid_fd;
> +static int invalid_fd = -1;
> +static int pipe_fd[2];
> +
> +static char buf[CHUNK * 4];
> +
> +struct iovec iovec_badlen[] = {
> +	{ buf, -1 },
> +	{ buf + CHUNK, CHUNK },
> +	{ buf + CHUNK * 2, CHUNK },
> +};
> +
> +struct iovec iovec_simple[] = {
> +	{ buf, CHUNK },
> +};
> +
> +struct iovec iovec_zero_null[] = {
> +	{ buf, CHUNK },
> +	{ buf + CHUNK, 0 },
> +	{ NULL, 0 },
> +	{ NULL, 0 }
> +};
> +
> +struct testcase_t {
> +	const char *desc;
> +	int *pfd;
> +	struct iovec (*piovec)[];
> +	int iovcnt;
> +	int exp_ret;
> +	int exp_errno;
> +} testcases[] = {
> +	{
> +		.desc = "invalid iov_len",
> +		.pfd = &valid_fd,
> +		.piovec = &iovec_badlen,
> +		.iovcnt = ARRAY_SIZE(iovec_badlen),
> +		.exp_ret = -1,
> +		.exp_errno = EINVAL
> +	},
> +	{
> +		.desc = "invalid fd",
> +		.pfd = &invalid_fd,
> +		.piovec = &iovec_simple,
> +		.iovcnt = ARRAY_SIZE(iovec_simple),
> +		.exp_ret = -1,
> +		.exp_errno = EBADF
> +	},
> +	{
> +		.desc = "invalid iovcnt",
> +		.pfd = &valid_fd,
> +		.piovec = &iovec_simple,
> +		.iovcnt = -1,
> +		.exp_ret = -1,
> +		.exp_errno = EINVAL
> +	},
> +	{
> +		.desc = "zero iovcnt",
> +		.pfd = &valid_fd,
> +		.piovec = &iovec_simple,
> +		.iovcnt = 0,
> +		.exp_ret = 0,
> +	},
> +	{
> +		.desc = "NULL and zero length iovec",
> +		.pfd = &valid_fd,
> +		.piovec = &iovec_zero_null,
> +		.iovcnt = ARRAY_SIZE(iovec_zero_null),
> +		.exp_ret = CHUNK,
> +	},
> +	{
> +		.desc = "write to closed pipe",
> +		.pfd = &(pipe_fd[1]),
> +		.piovec = &iovec_simple,
> +		.iovcnt = ARRAY_SIZE(iovec_simple),
> +		.exp_ret = -1,
> +		.exp_errno = EPIPE,
> +	},
> +};
> +
> +void setup(void)
> +{
> +	sigset_t block_mask;
> +
> +	sigemptyset(&block_mask);
> +	sigaddset(&block_mask, SIGPIPE);
> +	sigprocmask(SIG_BLOCK, &block_mask, NULL);
> +
> +	valid_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	SAFE_PIPE(pipe_fd);
> +	SAFE_CLOSE(pipe_fd[0]);
> +}
> +
> +static void test_writev(unsigned int i)
> +{
> +	struct testcase_t *tcase = &testcases[i];
> +	int ret;
> +
> +	TEST(writev(*(tcase->pfd), *(tcase->piovec), tcase->iovcnt));
> +
> +	ret = (TEST_RETURN == tcase->exp_ret);
> +	if (TEST_RETURN < 0 || tcase->exp_ret < 0)
> +		ret &= (TEST_ERRNO == tcase->exp_errno);
> +
> +	if (ret) {
> +		tst_res(TPASS | TTERRNO, "%s, ret: %ld", tcase->desc,
> +			TEST_RETURN);
> +	} else {
> +		tst_res(TPASS | TTERRNO, "%s, ret: %ld", tcase->desc,
                         ^
			 TFAIL?

> +			TEST_RETURN);
> +	}

Also I would have created separate functions for failure/success tests
so that we can print more informative results, i.e. include the expected
errno in the TFAIL result message.

Apart from that this is much better than the original.

-- 
Cyril Hrubis
chrubis@suse.cz
