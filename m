From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Jul 2020 10:14:27 +0800
Subject: [LTP] [PATCH v2] syscalls/ioctl09: Add test for BLKRRPART ioctl
 syscalls/ioctl09: Add test for BLKRRPART ioctl
In-Reply-To: <20200720145646.GA20216@yuki.lan>
References: <172872545.1186681.1594187187385.JavaMail.zimbra@redhat.com>
 <1594188398-14148-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200720145646.GA20216@yuki.lan>
Message-ID: <f6c267e1-d53c-382c-f9c7-beebb138acc5@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>> Fixes #699
> 
> Looks good a couple of minor comments below.
Thanks for your review.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> Acked-by: Jan Stancek <jstancek@redhat.com>
>> ---
>> v1->v2:
>> code style fix(below 80 characters)
>>   runtest/syscalls                           |   1 +
>>   testcases/kernel/syscalls/ioctl/.gitignore |   1 +
>>   testcases/kernel/syscalls/ioctl/ioctl09.c  | 126 +++++++++++++++++++++
>>   3 files changed, 128 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/ioctl/ioctl09.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 5b3a0862f..aaa81e4ee 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -529,6 +529,7 @@ ioctl05      ioctl05
>>   ioctl06      ioctl06
>>   ioctl07      ioctl07
>>   ioctl08      ioctl08
>> +ioctl09      ioctl09
>>   
>>   ioctl_loop01 ioctl_loop01
>>   ioctl_loop02 ioctl_loop02
>> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
>> index 3a3d49adc..5fff7a61d 100644
>> --- a/testcases/kernel/syscalls/ioctl/.gitignore
>> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
>> @@ -6,6 +6,7 @@
>>   /ioctl06
>>   /ioctl07
>>   /ioctl08
>> +/ioctl09
>>   /ioctl_loop01
>>   /ioctl_loop02
>>   /ioctl_loop03
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
>> new file mode 100644
>> index 000000000..b39ef9874
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
>> @@ -0,0 +1,126 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
>> + *
>> + * Basic test for the BLKRRPART ioctl, it is the same as blockdev
>> + * --rereadpt command.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <sys/mount.h>
>> +#include <stdbool.h>
>> +#include "lapi/loop.h"
>> +#include "tst_test.h"
>> +
>> +static char dev_path[1024];
>> +static int dev_num, attach_flag, dev_fd;
>> +static char loop_partpath[1026], sys_loop_partpath[1026];
>> +
>> +static void change_partition(const char *const cmd[])
>> +{
>> +	int ret;
>> +
>> +	ret = tst_cmd(cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
>> +	switch (ret) {
>> +	case 0:
>> +	break;
>> +	case 255:
>> +		tst_res(TCONF, "parted binary not installed or failed");
>> +	break;
> 
> We do have .needs_cmds in the test structure so we don't have to handle
> 255 here, the test will not start if parted is not installed.
> 
>> +	default:
>> +		tst_res(TCONF, "parted exited with %i", ret);
> 
> Shouldn't this be TBROK?
> 
> Or at least tst_brk() because we will proceed with the test as it is and
> possibly fail the test since parted haven't modified the binary. Or does
> parted return non-zero when it succeeds?
> 
> Generally if we are going to handle only one failure case we can write it as:
> 
> 	ret = tst_cmd(...);
> 	if (ret)
> 		tst_brk(TBROK, "parted returned %i", ret);
Yes, you are right. We don't need to handle 255 and should use tst_brk.
> 
>> +	break;
>> +	}
>> +}
>> +
>> +static void check_partition(int part_num, bool value)
>> +{
>> +	int ret;
>> +
>> +	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp%d",
>> +		dev_num, dev_num, part_num);
>> +	sprintf(loop_partpath, "%sp%d", dev_path, part_num);
>> +
>> +	ret = access(sys_loop_partpath, F_OK);
>> +	if (ret == 0)
>> +		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
>> +			sys_loop_partpath);
>> +	else
>> +		tst_res(value ? TFAIL : TPASS, "access %s fails",
>> +			sys_loop_partpath);
>> +
>> +	ret = access(loop_partpath, F_OK);
>> +	if (ret == 0)
>> +		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
>> +			loop_partpath);
>> +	else
>> +		tst_res(value ? TFAIL : TPASS, "access %s fails",
>> +			loop_partpath);
>> +}
>> +
>> +static void verify_ioctl(void)
>> +{
>> +	const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
>> +					      "mklabel", "msdos", "mkpart",
>> +					      "primary", "ext4", "1M", "10M",
>> +					      NULL};
>> +	const char *const cmd_parted_new[] = {"parted", "-s", "test.img",
>> +					      "mklabel", "msdos", "mkpart",
>> +					      "primary", "ext4", "1M", "10M",
>> +					      "mkpart", "primary", "ext4",
>> +					      "10M", "20M", NULL};
>> +	struct loop_info loopinfo = {0};
>> +
>> +	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>> +	if (dev_num < 0)
>> +		tst_brk(TBROK, "Failed to find free loop device");
> 
> Shouldn't we move the tst_find_free_loopdev() to the test setup?
Yes.
> 
>> +	tst_fill_file("test.img", 0, 1024 * 1024, 20);
> 
> I wonder if the recently introduced tst_prealloc_file() would make the
> test a bit faster. Have you tried that?
Now, I tried it.  time ./ioctl09 -i 100
by using tst_fill_file, the avergage(I tested 10 times)
real    0m13.467s
user    0m0.550s
sys     0m1.71s
by using tst_prealloc_file, the avergage
real    0m13.44s
user    0m0.60s
sys     0m1.56s

It seems that using tst_prealloc_file faster a bit. I will use this new 
api. Also I will move tst_prealloc_file into setup because it doesn't 
need to create test.img each time.

Best Regards
Yang Xu
> 
>> +	change_partition(cmd_parted_old);
>> +
>> +	tst_attach_device(dev_path, "test.img");
>> +	attach_flag = 1;
>> +
>> +	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
>> +	loopinfo.lo_flags =  LO_FLAGS_PARTSCAN;
>> +	SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &loopinfo);
>> +	check_partition(1, true);
>> +	check_partition(2, false);
>> +
>> +	change_partition(cmd_parted_new);
>> +	TST_RETRY_FUNC(ioctl(dev_fd, BLKRRPART, 0), TST_RETVAL_EQ0);
>> +	check_partition(1, true);
>> +	check_partition(2, true);
>> +
>> +	SAFE_CLOSE(dev_fd);
>> +	tst_detach_device(dev_path);
>> +	attach_flag = 0;
>> +	unlink("test.img");
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (dev_fd > 0)
>> +		SAFE_CLOSE(dev_fd);
>> +	if (attach_flag)
>> +		tst_detach_device(dev_path);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.cleanup = cleanup,
>> +	.test_all = verify_ioctl,
>> +	.needs_root = 1,
>> +	.needs_drivers = (const char *const []) {
>> +		"loop",
>> +		NULL
>> +	},
>> +	.needs_cmds = (const char *const []) {
>> +		"parted",
>> +		NULL
>> +	},
>> +	.needs_tmpdir = 1,
>> +};
>> -- 
>> 2.23.0
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


