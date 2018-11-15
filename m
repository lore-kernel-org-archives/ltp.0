From: subash <subash@zilogic.com>
Date: Thu, 15 Nov 2018 09:37:00 -0000
Subject: [LTP] [PATCH v4] Testing statx syscall Timestamp fields
References: <20181109103057.4473-1-subash@zilogic.com>
 <20181113155546.GC11121@rei.lan>
Message-ID: <33a19bb69841c667ce537998c3396bc5.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

>> +#include <time.h>
>> +#include "tst_test.h"
>> +
>> +static inline void safe_clock_getres(const char *file, const int
>> lineno,
>> +	clockid_t clk_id, struct timespec *res)
>> +{
>> +	int rval;
>> +
>> +	rval = clock_getres(clk_id, res);
>> +	if (rval == -1)
>                ^
> 	       rval != 0 is a bit more robust
>
>> +		tst_brk(TBROK | TERRNO,
>> +			"%s:%d:, clock_getres() failed", file, lineno);
>                                ^              ^
>                                |              We should print the
> parameters here
> 			       No comma here please.
>> +
>> +}
>> +

Since file and lineno are error indicating parameters and not the actual
function arguments we preferred printing it before the actual error
message.

Also as the second parameter is a structure we weren't sure if it is
necessary to print individual structure members. That is why we preferred
printing a plain error message with just the lineno and file name.




>> +static struct tst_test test = {
>> +	.cleanup = cleanup,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.test = test_statx,
>> +	.min_kver = "4.11",
>> +	.needs_root = 1,
>> +	.needs_tmpdir = 1,
>> +	.mntpoint = MOUNT_POINT,
>> +	.mount_device = 1,
>> +	.dev_fs_type = "ext4",
>> +	.dev_min_size = 512,
>
> Again do we really need 512MB for the test?
>
> I doubt so.
>
>> +	.mnt_flags = MS_STRICTATIME,
>> +};
>
> Otherwise it's good.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



For the ext4 to provide nanosecond precision to the timestamp fields the
INODE size has to be atleast 256bytes.

If the file system size is smaller than 512MB then by default the INODE
size will be only 128bytes and hence will not support birth time and nano
second precision.


With Regards
Subash G

