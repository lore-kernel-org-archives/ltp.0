From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Mar 2017 09:34:03 +0800
Subject: [LTP] [PATCH 3/3] syscalls/getxattr04.c: Add new regression test
In-Reply-To: <20170302162310.GB8152@rei.lan>
References: <1488451056-24535-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1488451056-24535-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170302162310.GB8152@rei.lan>
Message-ID: <58B8C80B.8080503@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/03/03 0:23, Cyril Hrubis wrote:
Hi Cyril

Thanks for your comment, i will send v2 patch soon.

Regards,
Xiao Yang
> Hi!
>> + * Copyright (c) 2017 Fujitsu Ltd.
>> + * Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * alone with this program.
>> + *
>> + */
>> +
>> +/*
>> + * This is a regression test for the race between getting an existing
>> + * xattr and setting/removing a large xattr.  This bug leads to that
>> + * getxattr() fails to get an existing xattr and returns ENOATTR in xfs
>> + * filesystem.
>> + *
>> + * Thie bug has been fixed in:
>> + *
>> + * commit 5a93790d4e2df73e30c965ec6e49be82fc3ccfce
>> + * Author: Brian Foster<bfoster@redhat.com>
>> + * Date:   Wed Jan 25 07:53:43 2017 -0800
>> + *
>> + * xfs: remove racy hasattr check from attr ops
>> + */
>> +
>> +#include "config.h"
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<string.h>
>> +#include<unistd.h>
>> +#include<signal.h>
>> +
>> +#ifdef HAVE_SYS_XATTR_H
>> +# include<sys/xattr.h>
>> +#endif
>> +
>> +#include "tst_test.h"
>> +
>> +#ifdef HAVE_SYS_XATTR_H
>> +
>> +#define MNTPOINT	"mntpoint"
>> +#define TEST_FILE	MNTPOINT "/file"
>> +#define TRUSTED_BIG	"trusted.big"
>> +#define TRUSTED_SMALL	"trusted.small"
>> +
>> +static int mount_flag;
>> +static int end;
> This should be volatile since it's changed from a signal handler.
>
>> +static char big_value[512];
>> +static char small_value[32];
>> +
>> +static void sigproc(int sig)
>> +{
>> +	end = sig;
>> +}
>> +
>> +static void loop_getxattr(void)
>> +{
>> +	int res;
>> +
>> +	while (1) {
>> +		res = getxattr(TEST_FILE, TRUSTED_SMALL, NULL, 0);
>> +		if (res == -1) {
>> +			if (errno == ENODATA) {
>> +				tst_res(TFAIL, "getxattr() failed to get an "
>> +					"existing attribute");
>> +			} else {
>> +				tst_res(TFAIL | TERRNO,
>> +					"getxattr() failed without ENOATTR");
>> +			}
>> +
>> +			return;
>> +		}
>> +
>> +		if (end)
>> +			break;
> Why not just while (!end) { ... } ?
>
>> +	}
>> +
>> +	tst_res(TPASS, "getxattr() succeeded to get an existing attribute");
>> +}
>> +
>> +static void verify_getxattr(void)
>> +{
>> +	pid_t pid;
>> +	int n;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		loop_getxattr();
>> +		_exit(0);
>                    ^
> 		  Why _exit()? We are not calling this code from a
> 		  signal handler, are we?
>
> Also why don't we call exit() in the loop_getxattr() function?
>
>> +	}
>> +
>> +	for (n = 0; n<  99; n++) {
>> +		SAFE_SETXATTR(TEST_FILE, TRUSTED_BIG, big_value,
>> +				sizeof(big_value), XATTR_CREATE);
>> +		SAFE_REMOVEXATTR(TEST_FILE, TRUSTED_BIG);
>> +	}
>> +
>> +	kill(pid, SIGUSR1);
>> +	tst_reap_children();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_SIGNAL(SIGUSR1, sigproc);
>> +
>> +	SAFE_MKDIR(MNTPOINT, 0755);
>> +	SAFE_MKFS(tst_device->dev, "xfs", NULL, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, "xfs", 0, NULL);
>> +	mount_flag = 1;
> You should make use of the mount_device flag introduced meanwhile:
>
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2214-testing-with-a-block-device
>
>> +	SAFE_TOUCH(TEST_FILE, 0644, NULL);
>> +
>> +	memset(big_value, 'a', sizeof(big_value));
>> +	memset(small_value, 'a', sizeof(small_value));
>> +
>> +	SAFE_SETXATTR(TEST_FILE, TRUSTED_SMALL, small_value,
>> +			sizeof(small_value), XATTR_CREATE);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (mount_flag)
>> +		tst_umount(MNTPOINT);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tid = "getxattr04",
>> +	.needs_tmpdir = 1,
>> +	.needs_root = 1,
>> +	.needs_device = 1,
>> +	.forks_child = 1,
>> +	.test_all = verify_getxattr,
>> +	.setup = setup,
>> +	.cleanup = cleanup
>> +};
>> +
>> +#else /* HAVE_SYS_XATTR_H */
>> +	TST_TEST_TCONF("<sys/xattr.h>  does not exist.");
>> +#endif
>> -- 
>> 1.8.3.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



