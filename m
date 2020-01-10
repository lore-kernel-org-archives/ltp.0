From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Jan 2020 14:37:46 +0100
Subject: [LTP] [PATCH v2] syscalls/pipe12: add new test for pipe when
 write bytes > PIPE_BUF
In-Reply-To: <1578365634-19825-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1577269768-30118-1-git-send-mail-xuyang2018.jy@cn.fujitsu.com>
 <1578365634-19825-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200110133746.GB14140@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pipe/pipe12.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * Test Description:
> + * A pipe has a limited capacity. If the pipe with non block mode is full,
> + * then a write(2) will fail and get EAGAIN error. Otherwise, from 1 to
> + * PIPE_BUF bytes may be written.
> + */
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +
> +static int fds[2];
> +static char *wrbuf;
> +static char *rdbuf;
> +static ssize_t max_size, invalid_size;
> +
> +static struct tcase {
> +	int full_flag;
> +	int need_offset;

This could be called just offset, it does not have to be boolean either,
we just need to write offset bytes from a buffer before we attempt to
write to the pipe.

> +	char *message;
> +} tcases[] = {
> +	{1, 0, "Test on full pipe"},
                 "Write to full pipe"
> +	{0, 1, "Test on non full pipe from 1 offset"},
		 "Write to non-empty pipe"
> +	{0, 0, "Test on non full pipe from 0 offset"},
                      "Write to empty pipe"
> +};
> +
> +static void verify_pipe(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	memset(rdbuf, 0, max_size);
> +
> +	tst_res(TINFO, "%s", tc->message);
> +	if (tc->full_flag) {
> +		SAFE_WRITE(1, fds[1], wrbuf, max_size);
> +		TEST(write(fds[1], "x", 1));
> +		if (TST_RET == 0) {
			write is required to return -1 here which is
			what we have to check against i.e, TST_RET != -1
			means fail
> +			tst_res(TFAIL, "write succeeded unexpectedly");
> +			goto clean_pipe_buf;
> +		}
> +		if (TST_ERR == EAGAIN)
> +			tst_res(TPASS | TTERRNO, "write failed as expected");
> +		else
> +			tst_res(TFAIL | TTERRNO, "write failed, expected EAGAIN but got");
> +	} else {
> +		if (tc->need_offset)
> +			SAFE_WRITE(1, fds[1], "x", 1);
> +		TEST(write(fds[1], wrbuf, invalid_size));
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL, "write failed unexpectedly");
> +			goto clean_pipe_buf;
> +		}
> +		if (TST_RET == invalid_size)
> +			tst_res(TFAIL, "write size %ld larger than PIPE_BUF %ld", TST_RET, max_size);
> +		else
> +			tst_res(TPASS, "write size %ld between [1, %ld]", TST_RET, max_size);

		Here as well, write is supposed to return the number of
		bytes written so in this case the TST_RET must be
		max_size - tcase->offset which is all we have to check
		for, anything else than that means failure.

> +	}
> +
> +clean_pipe_buf:
> +	SAFE_READ(0, fds[0], rdbuf, max_size);
> +}
> +
> +
> +static void cleanup(void)
> +{
> +	if (fds[0] > 0)
> +		SAFE_CLOSE(fds[0]);
> +	if (fds[1] > 0)
> +		SAFE_CLOSE(fds[1]);
> +	if (wrbuf)
> +		free(wrbuf);
> +	if (rdbuf)
> +		free(rdbuf);
> +}
> +
> +static void setup(void)
> +{
> +
> +	TEST(pipe(fds));
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "pipe");
> +		return;
> +	}

This is exactly what SAFE_PIPE() does.

> +	max_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
> +	invalid_size = max_size + 4096;
> +	wrbuf = SAFE_MALLOC(invalid_size);
> +	rdbuf = SAFE_MALLOC(max_size);
> +	memset(wrbuf, 'x', invalid_size);
> +
> +	SAFE_FCNTL(fds[1], F_SETFL, O_NONBLOCK);
> +	SAFE_FCNTL(fds[0], F_SETFL, O_NONBLOCK);
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_pipe,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> -- 
> 2.18.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
