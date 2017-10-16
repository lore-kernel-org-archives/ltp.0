From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 16 Oct 2017 13:09:58 +0800
Subject: [LTP] [PATCH] Test for CVE-2017-2618 in setprocattr
In-Reply-To: <87k2007ayp.fsf@our.domain.is.not.set>
References: <20170831074404.26337-1-fenggw-fnst@cn.fujitsu.com>
 <87k2007ayp.fsf@our.domain.is.not.set>
Message-ID: <34f4f25a-e6c2-39c3-a836-619e29729eae@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi, Richard

Thanks for your review, but it looks like this patch has been pushed.
I will send a new patch to add the check.

Best Regards,
Guangwen Feng

在 10/12/2017 09:27 PM, Richard Palethorpe 写道:
> Hello,
> 
> Guangwen Feng writes:
> 
>> +
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include "tst_test.h"
>> +
>> +#define LOOPS	100
>> +#define PATH_ATTRFS	"/proc/self/attr/fscreate"
> 
> Will this exist on all systems? I am guessing that if SELINUX is not
> configured in the kernel then this won't exist. So it is probably best
> to exit with TCONF if we can not find it.
> 
>> +
>> +static void do_test(void)
>> +{
>> +	int i, fd;
>> +
>> +	for (i = 0; i < LOOPS; i++) {
>> +		if (!SAFE_FORK()) {
>> +			fd = SAFE_OPEN(PATH_ATTRFS, O_WRONLY);
>> +			write(fd, "\n", 1);
>> +			SAFE_CLOSE(fd);
>> +			exit(0);
>> +		}
>> +
>> +		tst_reap_children();
>> +	}
>> +
>> +	tst_res(TPASS, "Bug not reproduced");
>> +}
>> +
>> +static struct tst_test test = {
>> +	.forks_child = 1,
>> +	.test_all = do_test,
>> +};
>> --
>> 2.9.4
> 
> Otherwise this looks good.
> 
> --
> Thank you,
> Richard.
> 
> 
> 


