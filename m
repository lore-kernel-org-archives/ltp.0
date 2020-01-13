From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 13 Jan 2020 15:38:16 +0800
Subject: [LTP] [PATCH v2] syscalls/pipe12: add new test for pipe when
 write bytes > PIPE_BUF
In-Reply-To: <20200110133746.GB14140@rei.lan>
References: <1577269768-30118-1-git-send-mail-xuyang2018.jy@cn.fujitsu.com>
 <1578365634-19825-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200110133746.GB14140@rei.lan>
Message-ID: <90d369da-1340-d919-e9e5-f819d028daf9@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi?
> Hi!
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/pipe/pipe12.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> + *
>> + * Test Description:
>> + * A pipe has a limited capacity. If the pipe with non block mode is full,
>> + * then a write(2) will fail and get EAGAIN error. Otherwise, from 1 to
>> + * PIPE_BUF bytes may be written.
>> + */
>> +#define _GNU_SOURCE
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <fcntl.h>
>> +#include "tst_test.h"
>> +#include "lapi/fcntl.h"
>> +
>> +static int fds[2];
>> +static char *wrbuf;
>> +static char *rdbuf;
>> +static ssize_t max_size, invalid_size;
>> +
>> +static struct tcase {
>> +	int full_flag;
>> +	int need_offset;
> 
> This could be called just offset, it does not have to be boolean either,
> we just need to write offset bytes from a buffer before we attempt to
> write to the pipe.
OK.
> 
>> +	char *message;
>> +} tcases[] = {
>> +	{1, 0, "Test on full pipe"},
>                   "Write to full pipe"
>> +	{0, 1, "Test on non full pipe from 1 offset"},
> 		 "Write to non-empty pipe"
>> +	{0, 0, "Test on non full pipe from 0 offset"},
>                        "Write to empty pipe"
>> +};
>> +
OK.
>> +static void verify_pipe(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +
>> +	memset(rdbuf, 0, max_size);
>> +
>> +	tst_res(TINFO, "%s", tc->message);
>> +	if (tc->full_flag) {
>> +		SAFE_WRITE(1, fds[1], wrbuf, max_size);
>> +		TEST(write(fds[1], "x", 1));
>> +		if (TST_RET == 0) {
> 			write is required to return -1 here which is
> 			what we have to check against i.e, TST_RET != -1
> 			means fail
>> +			tst_res(TFAIL, "write succeeded unexpectedly");
>> +			goto clean_pipe_buf;
>> +		}
>> +		if (TST_ERR == EAGAIN)
>> +			tst_res(TPASS | TTERRNO, "write failed as expected");
>> +		else
>> +			tst_res(TFAIL | TTERRNO, "write failed, expected EAGAIN but got");
>> +	} else {
>> +		if (tc->need_offset)
>> +			SAFE_WRITE(1, fds[1], "x", 1);
>> +		TEST(write(fds[1], wrbuf, invalid_size));
>> +		if (TST_RET == -1) {
>> +			tst_res(TFAIL, "write failed unexpectedly");
>> +			goto clean_pipe_buf;
>> +		}
>> +		if (TST_RET == invalid_size)
>> +			tst_res(TFAIL, "write size %ld larger than PIPE_BUF %ld", TST_RET, max_size);
>> +		else
>> +			tst_res(TPASS, "write size %ld between [1, %ld]", TST_RET, max_size);
> 
> 		Here as well, write is supposed to return the number of
> 		bytes written so in this case the TST_RET must be
> 		max_size - tcase->offset which is all we have to check
> 		for, anything else than that means failure.
I have seen pipe_write kernel code[1], it only merged small size write 
but not large size write(large size write will still page-align size, in 
other word, it uses new page). So, I think it is why man-pages said 
"from 1 to n bytes may be written". It may exist a hole when we use a 
unalign offset and the sequent align-page write. I think it is normal 
and don't need to mean failure.  "TST_RET is max_size - tcase->offset" 
is ok when we use [0,N*page_size-1] [page_size,page_buf-1] write or 
[0,a-1] [a, page_buf-1] write.

The other reason for it I guess beacause looking for a hole  may drop 
peformance when pipe buf is large.

Also, we can print write btyes by ioctl(fd, FIONREAD, &nbytes) command
(cover this ioctl test point).

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pipe.c#n431
> 
>> +	}
>> +
>> +clean_pipe_buf:
>> +	SAFE_READ(0, fds[0], rdbuf, max_size);
>> +}
>> +
>> +
>> +static void cleanup(void)
>> +{
>> +	if (fds[0] > 0)
>> +		SAFE_CLOSE(fds[0]);
>> +	if (fds[1] > 0)
>> +		SAFE_CLOSE(fds[1]);
>> +	if (wrbuf)
>> +		free(wrbuf);
>> +	if (rdbuf)
>> +		free(rdbuf);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +
>> +	TEST(pipe(fds));
>> +	if (TST_RET == -1) {
>> +		tst_brk(TBROK | TTERRNO, "pipe");
>> +		return;
>> +	}
> 
> This is exactly what SAFE_PIPE() does.
> 
OK.
>> +	max_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
>> +	invalid_size = max_size + 4096;
>> +	wrbuf = SAFE_MALLOC(invalid_size);
>> +	rdbuf = SAFE_MALLOC(max_size);
>> +	memset(wrbuf, 'x', invalid_size);
>> +
>> +	SAFE_FCNTL(fds[1], F_SETFL, O_NONBLOCK);
>> +	SAFE_FCNTL(fds[0], F_SETFL, O_NONBLOCK);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = verify_pipe,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +};
>> -- 
>> 2.18.0
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


