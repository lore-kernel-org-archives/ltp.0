From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 21 May 2021 11:29:09 +0800
Subject: [LTP] [PATCH 1/2] syscalls/sendfile: Convert sendfile08 to the
 new API
In-Reply-To: <YKbUah2GaIHb6f19@pevik>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-2-xieziyao@huawei.com> <YKbUah2GaIHb6f19@pevik>
Message-ID: <5527040d-6b16-a40d-98df-179d5cae28c6@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>> +++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
> I'd put your or LTP copyright (as your wish) because test was significantly
> changed. (We had some copyright issues in the past thus it's better to state it.)
> ...
>> +/*\
>> + * [Description]
>> + *
>>    * Bug in the splice code has caused the file position on the write side
>>    * of the sendfile system call to be incorrectly set to the read side file
>>    * position. This can result in the data being written to an incorrect offset.
>>    *
>> - * This is a regression test for kernel commit
>> - * 2cb4b05e7647891b46b91c07c9a60304803d1688
>> + * This is a regression test for kernel commit 2cb4b05e7647.
> 
> nit: I wonder if we want to repeat what we already declare in .min_kver.
> This is not specific to this patch, we keep doing it, but IMHO necessary
> and we should stop that.
Agree with you.

>>    */
> 
>> -#include <sys/sendfile.h>
>> -#include <sys/stat.h>
>> -#include <sys/types.h>
>> -#include <errno.h>
>> -#include <fcntl.h>
>>   #include <stdio.h>
>> +#include <fcntl.h>
>>   #include <string.h>
>>   #include <unistd.h>
>> -#include "test.h"
>> -#include "safe_macros.h"
>> +#include <sys/stat.h>
>> +#include <sys/types.h>
>> +#include <sys/sendfile.h>
> 
> nit: it looks to me that only <stdio.h> <string.h> <sys/sendfile.h> are needed.
+1

> But maybe others are needed and included in other headers.
> 
> Also only these were needed in legacy API:
> #include <sys/sendfile.h>
> #include <errno.h>
> #include "test.h"
> #include "safe_macros.h"
> But <errno.h> is needed only for legacy API => use just these 3 mentioned above.
> 
> ...
>> +	char buf[BUFSIZ];
>> +	SAFE_LSEEK(out_fd, 0, SEEK_SET);
> nit: sendfile08.c:43: WARNING: Missing a blank line after declarations
> It's actually more readable to have blank line after char buf[BUFSIZ];
+1

> 
>> +	SAFE_READ(0, out_fd, buf, BUFSIZ);
>> +
>> +	if (!strncmp(buf, TEST_MSG_ALL, strlen(TEST_MSG_ALL)))
>> +		tst_res(TPASS, "sendfile(2) copies data correctly");
>> +	else
>> +		tst_res(TFAIL, "sendfile(2) copies data incorrectly. "
>> +			       "Expect \"%s%s\", got \"%s\"",
>> +			TEST_MSG_OUT, TEST_MSG_IN, buf);
> 
> sendfile08.c:50: WARNING: quoted string split across lines
> 
> 	if (!strncmp(buf, TEST_MSG_ALL, strlen(TEST_MSG_ALL))) {
> 		tst_res(TPASS, "sendfile() copied data correctly");
> 		return;
> 	}
> 
> 	tst_res(TFAIL, "sendfile() copied data incorrectly: '%s', expected '%s%s'",
> 			buf, TEST_MSG_OUT, TEST_MSG_IN);
> 
> i.e. not splitting string, get some space by return instead else,
> we don't mind using single quote (code is more readable),
> removing also 2 in sendfile(2) (2 is man section, but that's just confusing).
> 
> Changes are minor, if we agre on that it can be done during merge.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> .
> 

Hi, Petr,

Thanks for your review and agree with changes above.

BTW, would you mind adding your changes to the v2 version? Please see: 
https://patchwork.ozlabs.org/project/ltp/list/?series=244863

Thank you,
Ziyao
