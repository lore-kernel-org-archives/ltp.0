From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 07 Jul 2021 10:42:55 +0100
Subject: [LTP] [PATCH] wait403: Reproduce undefined INT_MIN negation
In-Reply-To: <ce948ff6-4115-338c-7990-d27df8658534@jv-coder.de>
References: <20210706142325.11347-1-rpalethorpe@suse.com>
 <ce948ff6-4115-338c-7990-d27df8658534@jv-coder.de>
Message-ID: <87czru7940.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi Richard,
>
> On 7/6/2021 4:23 PM, Richard Palethorpe via ltp wrote:
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>   runtest/syscalls                           |  1 +
>>   testcases/kernel/syscalls/wait4/.gitignore |  1 +
>>   testcases/kernel/syscalls/wait4/wait403.c  | 40 ++++++++++++++++++++++
>>   3 files changed, 42 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/wait4/wait403.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 98fe3c02e..128eaadd2 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1663,6 +1663,7 @@ wait02 wait02
>>     wait401 wait401
>>   wait402 wait402
>> +wait403 wait403
>>     waitpid01 waitpid01
>>   waitpid02 waitpid02
>> diff --git a/testcases/kernel/syscalls/wait4/.gitignore b/testcases/kernel/syscalls/wait4/.gitignore
>> index 9313eb72c..577f73479 100644
>> --- a/testcases/kernel/syscalls/wait4/.gitignore
>> +++ b/testcases/kernel/syscalls/wait4/.gitignore
>> @@ -1,2 +1,3 @@
>>   /wait401
>>   /wait402
>> +/wait403
>> diff --git a/testcases/kernel/syscalls/wait4/wait403.c b/testcases/kernel/syscalls/wait4/wait403.c
>> new file mode 100644
>> index 000000000..262351b7c
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/wait4/wait403.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
>> + */
>> +
>> +/*
>> + * [Description]
>> + *
>> + * Check wait4(INT_MIN, ...) is not allowed. The pid is negated before
>> + * searching for a group with that pid. Negating INT_MIN is not
>> + * defined so UBSAN will be triggered if enabled.
>> + *
>> + * If the bug is present, but UBSAN is not enabled, then it should
>> + * result in ECHILD.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <errno.h>
>> +#define _USE_BSD
>> +#include <sys/types.h>
>> +#include <sys/resource.h>
>> +#include <sys/wait.h>
>> +#include "tst_test.h"
>> +
>> +static void run(void)
>> +{
>> +	int status = 1;
>> +	struct rusage rusage;
>> +
>> +	TST_EXP_FAIL2(wait4(-2147483648, &status, 0, &rusage), ESRCH,
>> +		      "wait4 fails with ESRCH");
> Could this use INT_MIN instead of the literal value? If not a comment
> would be nice, especially because there is already wait4(INT_MIN, ...) 
> in the description.

OK, I will roll another patch.

>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "dd83c161fbcc"},
>> +	}
>> +};
>
> Otherwise:
>
> Acked-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Thanks.

>
>
> Joerg


-- 
Thank you,
Richard.
