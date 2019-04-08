From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 8 Apr 2019 09:55:25 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/sigpending02.c: Add libc
 sigpending() detection && reset sighandler_counter
In-Reply-To: <20190405090620.GA8149@dell5510>
References: <1554451660-30245-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1554451660-30245-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190405090620.GA8149@dell5510>
Message-ID: <5CAAAA0D.9090805@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Cyril

Pushed with left-shift break. :-)
Thanks a lot.

Best Regards,
Xiao Yang
On 2019/04/05 17:06, Petr Vorel wrote:
> Hi Xiao,
>
> whole patchset LGTM.
> ...
>> +++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
>> @@ -13,6 +13,7 @@
>>    * Test 2: Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT.
>>    */
>> +#include "config.h"
>>   #include "tst_test.h"
>>   #include "ltp_signal.h"
>>   #include "lapi/syscalls.h"
>> @@ -36,7 +37,12 @@ static int tested_sigpending(sigset_t *sigset)
>>   {
>>   	switch (tst_variant) {
>>   	case 0:
>> +#ifndef HAVE_SIGPENDING
>> +		tst_brk(TCONF, "libc sigpending() is not implemented");
>> +#else
>>   		return sigpending(sigset);
>> +#endif
>> +		break;
> very minor nit: shift left break (to be on the same level as case).
>
>>   	case 1:
>>   		return tst_syscall(__NR_sigpending, sigset);
>>   	case 2:
> Kind regards,
> Petr
>
>
>



