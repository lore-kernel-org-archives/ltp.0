From: jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 1 Mar 2019 15:13:04 +0800
Subject: [LTP] [PATCH 3/3] syscalls/pwitev202: Add new testcase
In-Reply-To: <5C778C53.6080400@cn.fujitsu.com>
References: <1550218263-5961-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1550218263-5961-3-git-send-email-huangjh.jy@cn.fujitsu.com>
 <5C778C53.6080400@cn.fujitsu.com>
Message-ID: <5C78DB80.1000106@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

Thanks for your suggestion, I will update the patchset.

Thanks,
Jinhui Huang

On 2019/02/28 15:22, Xiao Yang wrote:
> Hi Jinhui,
>
> On 2019/02/15 16:11, Jinhui huang wrote:
>> Check various errnos for the pwitev202().
> Typo? pwitev2() seems proper.
>
>> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
>> ---
>>  runtest/syscalls                                |   2 +
>>  testcases/kernel/syscalls/pwritev2/.gitignore   |   2 +
>>  testcases/kernel/syscalls/pwritev2/pwritev202.c | 117 ++++++++++++++++++++++++
>>  3 files changed, 121 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/pwritev2/pwritev202.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 04f5269..27cc1dc 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -909,6 +909,8 @@ pwritev03_64 pwritev03_64
>>  
>>  pwritev201 pwritev201
>>  pwritev201_64 pwritev201_64
>> +pwritev202 pwritev202
>> +pwritev202_64 pwritev202_64
>>  
>>  quotactl01 quotactl01
>>  quotactl02 quotactl02
>> diff --git a/testcases/kernel/syscalls/pwritev2/.gitignore b/testcases/kernel/syscalls/pwritev2/.gitignore
>> index 46270c3..40030d9 100644
>> --- a/testcases/kernel/syscalls/pwritev2/.gitignore
>> +++ b/testcases/kernel/syscalls/pwritev2/.gitignore
>> @@ -1,2 +1,4 @@
>>  /pwritev201
>>  /pwritev201_64
>> +/pwritev202
>> +/pwritev202_64
>> diff --git a/testcases/kernel/syscalls/pwritev2/pwritev202.c b/testcases/kernel/syscalls/pwritev2/pwritev202.c
>> new file mode 100644
>> index 0000000..d0f8868
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/pwritev2/pwritev202.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
>> + */
>> +/*
>> + * Description:
>> + * Check various errnos for pwritev2(2).
>> + * 1) pwritev2() fails and sets errno to EINVAL if iov_len is invalid.
>> + * 2) pwritev2() fails and sets errno to EINVAL if the vector count iovcnt is
>> + *    less than zero.
>> + * 3) pwritev2() fails and sets errno to EOPNOTSUPP if flag is invalid.
>> + * 4) pwritev2() fails and sets errno to EFAULT when attempts to read into a
>> + *    invalid address.
> Typo? Invalid address is actually used to test write instead of read.
>
>> + * 5) pwritev2() fails and sets errno to EBADF if file descriptor is invalid.
>> + * 6) pwritev2() fails and sets errno to EBADF if file descriptor is not open
>> + *    for reading.
> Typo? fd2 is actually opened with O_RDONLY.
>
> Best Regards,
> Xiao Yang
>> + * 7) pwritev2() fails and sets errno to ESPIPE if fd is associated with a pipe.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/uio.h>
>> +#include <unistd.h>
>> +
>> +#include "tst_test.h"
>> +#include "lapi/pwritev2.h"
>> +
>> +#define CHUNK           64
>> +
>> +static int fd1;
>> +static int fd2;
>> +static int fd3 = -1;
>> +static int fd4[2];
>> +
>> +static char buf[CHUNK];
>> +
>> +static struct iovec wr_iovec1[] = {
>> +	{buf, -1},
>> +};
>> +
>> +static struct iovec wr_iovec2[] = {
>> +	{buf, CHUNK},
>> +};
>> +
>> +static struct iovec wr_iovec3[] = {
>> +	{NULL, CHUNK},
>> +};
>> +
>> +static struct tcase {
>> +	int *fd;
>> +	struct iovec *name;
>> +	int count;
>> +	off_t offset;
>> +	int flag;
>> +	int exp_err;
>> +} tcases[] = {
>> +	{&fd1, wr_iovec1, 1, 0, 0, EINVAL},
>> +	{&fd1, wr_iovec2, -1, 0, 0, EINVAL},
>> +	{&fd1, wr_iovec2, 1, 1, -1, EOPNOTSUPP},
>> +	{&fd1, wr_iovec3, 1, 0, 0, EFAULT},
>> +	{&fd3, wr_iovec2, 1, 0, 0, EBADF},
>> +	{&fd2, wr_iovec2, 1, 0, 0, EBADF},
>> +	{&fd4[0], wr_iovec2, 1, 0, 0, ESPIPE},
>> +};
>> +
>> +static void verify_pwritev2(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +
>> +	TEST(pwritev2(*tc->fd, tc->name, tc->count, tc->offset, tc->flag));
>> +
>> +	if (TST_RET == 0) {
>> +		tst_res(TFAIL, "pwritev2() succeeded unexpectedly");
>> +		return;
>> +	}
>> +
>> +	if (TST_ERR == tc->exp_err) {
>> +		tst_res(TPASS | TTERRNO, "pwritev2() failed as expected");
>> +		return;
>> +	}
>> +
>> +	tst_res(TFAIL | TTERRNO, "pwritev2() failed unexpectedly, expected %s",
>> +		tst_strerrno(tc->exp_err));
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	fd1 = SAFE_OPEN("file1", O_RDWR | O_CREAT, 0644);
>> +	SAFE_FTRUNCATE(fd1, getpagesize());
>> +	fd2 = SAFE_OPEN("file2", O_RDONLY | O_CREAT, 0644);
>> +	SAFE_PIPE(fd4);
>> +
>> +	wr_iovec3[0].iov_base = tst_get_bad_addr(NULL);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (fd1 > 0)
>> +		SAFE_CLOSE(fd1);
>> +
>> +	if (fd2 > 0)
>> +		SAFE_CLOSE(fd2);
>> +
>> +	if (fd4[0] > 0)
>> +		SAFE_CLOSE(fd4[0]);
>> +
>> +	if (fd4[1] > 0)
>> +		SAFE_CLOSE(fd4[1]);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = verify_pwritev2,
>> +	.needs_tmpdir = 1,
>> +};
> .
>


