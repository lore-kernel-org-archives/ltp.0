From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 10 Apr 2018 10:42:51 +0800
Subject: [LTP] [PATCH v3 1/2] preadv/preadv03.c: Add new testcase
In-Reply-To: <20180409125757.GA26048@rei.lan>
References: <20180406130248.GB6328@rei>
 <1523244278-17751-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180409125757.GA26048@rei.lan>
Message-ID: <5ACC24AB.7080007@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your detailed review, and i will send v4 patch soon. :-)

Thanks,
Xiao Yang
On 2018/04/09 20:57, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
>> index eea606e..ec2af68 100644
>> --- a/testcases/kernel/syscalls/.gitignore
>> +++ b/testcases/kernel/syscalls/.gitignore
>> @@ -696,6 +696,8 @@
>>   /preadv/preadv01_64
>>   /preadv/preadv02
>>   /preadv/preadv02_64
>> +/preadv/preadv03
>> +/preadv/preadv03_64
>>   /profil/profil01
>>   /pselect/pselect01
>>   /pselect/pselect01_64
>> diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
>> new file mode 100644
>> index 0000000..077063a
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/preadv/preadv03.c
>> @@ -0,0 +1,146 @@
>> +/*
>> + * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
>> + * Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
> Can we use GPLv2+ instead of GPLv2 please?
>
>> + * This program is distributed in the hope that it would be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * alone with this program.
>> + */
>> +
>> +/*
>> + * Test Name: preadv03
> I would avoid the test name here as it does not add any useful
> information.
>
>> + * Test Description:
>> + * Check the basic functionality of the preadv(2) for the file
>> + * opened with O_DIRECT in all filesystem.
>> + * Preadv(2) should succeed to read the expected content of data
>> + * and after reading the file, the file offset is not changed.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include<stdlib.h>
>> +#include<string.h>
>> +#include<sys/uio.h>
>> +#include<sys/ioctl.h>
>> +#include<sys/mount.h>
>> +#include "tst_test.h"
>> +#include "preadv.h"
>> +
>> +#define MNTPOINT	"mntpoint"
>> +#define FNAME	MNTPOINT"/file"
>> +
>> +static int fd, blksz;
>> +static off_t org_off, tst_off;
>                            ^
> 	  The tst_ prefix is reserved for the test library, you should
> 	  not use it when naming test variables/functions.
>
>> +static ssize_t exp_sz;
>> +static char *pop_buf;
>> +static struct iovec *rd_iovec;
>> +
>> +static struct tcase {
>> +	int count;
>> +	off_t *offset;
>> +	ssize_t *size;
>> +	char content;
>> +} tcases[] = {
>> +	{1,&org_off,&exp_sz, 0x61},
>> +	{2,&org_off,&exp_sz, 0x61},
>> +	{1,&tst_off,&exp_sz, 0x62},
>> +};
>> +
>> +static void verify_direct_preadv(unsigned int n)
>> +{
>> +	int i;
>> +	char *vec;
>> +	struct tcase *tc =&tcases[n];
>> +
>> +	vec = rd_iovec->iov_base;
>> +	memset(vec, 0x00, blksz);
>> +
>> +	SAFE_LSEEK(fd, 0, SEEK_SET);
>> +
>> +	TEST(preadv(fd, rd_iovec, tc->count, *tc->offset));
>> +	if (TEST_RETURN<  0) {
>> +		tst_res(TFAIL | TTERRNO, "Preadv(O_DIRECT) fails");
>> +		return;
>> +	}
>> +
>> +	if (TEST_RETURN != *tc->size) {
>> +		tst_res(TFAIL, "Preadv(O_DIRECT) read %li bytes, expected %zi",
>> +			 TEST_RETURN, *tc->size);
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i<  *tc->size; i++) {
>> +		if (vec[i] != tc->content)
>> +			break;
>> +	}
>> +
>> +	if (i<  *tc->size) {
>> +		tst_res(TFAIL, "Buffer wrong at %i have %02x expected %02x",
>> +			 i, vec[i], tc->content);
>> +		return;
>> +	}
>> +
>> +	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != 0) {
>> +		tst_res(TFAIL, "Preadv(O_DIRECT) has changed file offset");
>> +		return;
>> +	}
>> +
>> +	tst_res(TPASS, "Preadv(O_DIRECT) read %zi bytes successfully "
>> +		 "with content '%c' expectedly", *tc->size, tc->content);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	int dev_fd;
>> +
>> +	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
>> +	if (ioctl(dev_fd, BLKSSZGET,&blksz)) {
>> +		SAFE_CLOSE(dev_fd);
>> +		tst_brk(TBROK | TERRNO, "ioctl(%s, BLKSSZGET) failed",
>> +			tst_device->dev);
>> +	}
> We do have SAFE_IOCTL() now :-).
>
>> +	SAFE_CLOSE(dev_fd);
>> +	tst_off = blksz;
>> +	exp_sz = blksz;
>> +
>> +	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT | O_DIRECT, 0644);
>> +
>> +	pop_buf = SAFE_MEMALIGN(blksz, blksz);
>> +	memset(pop_buf, 0x61, blksz);
>> +	SAFE_WRITE(1, fd, pop_buf, blksz);
>> +
>> +	memset(pop_buf, 0x62, blksz);
>> +	SAFE_WRITE(1, fd, pop_buf, blksz);
>> +
>> +	rd_iovec = SAFE_MEMALIGN(blksz, blksz + sizeof(size_t));
> Also I do not think that we actually have to align the iovec structure,
> AFAIC only the actual buffer, i.e. iov_base.
>
>> +	rd_iovec->iov_base = SAFE_MEMALIGN(blksz, blksz);
>> +	rd_iovec->iov_len = blksz;
> Also looking at the testcase definition, we pass iovcnt == 2 there but
> initialize only the first one here. I suppose that for the original
> testcase we relied on the fact that the global variable rd_iovec was
> initialized to 0 but that does not hold true for allocated memory.
>
> Anyway we should either set rd_iovec[1].iov_base = NULL and
> rd_iovec[1].iov_len = 0 or make it static global variable again...
>
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	free(pop_buf);
>> +	free(rd_iovec->iov_base);
>> +	free(rd_iovec);
>> +
>> +	if (fd>  0)
>> +		SAFE_CLOSE(fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = verify_direct_preadv,
>> +	.min_kver = "2.6.30",
>> +	.mntpoint = MNTPOINT,
>> +	.mount_device = 1,
>> +	.all_filesystems = 1,
>> +};
>> -- 
>> 1.8.3.1
>>
>>
>>



