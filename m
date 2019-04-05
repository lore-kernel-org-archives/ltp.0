From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 15:33:17 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/sigpending02.c: Add libc
 sigpending() detection && reset sighandler_counter
In-Reply-To: <20190405072112.GB31213@dell5510>
References: <1554433793-19702-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1554433793-19702-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190405072112.GB31213@dell5510>
Message-ID: <5CA704BD.3090804@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/04/05 15:21, Petr Vorel wrote:
> Hi Xiao,
>
>> 1) bionic(Android libc) doesn't implement libc sigpending() currently,
>>     so we can skip it on Android by the detection.
>> 2) Fix sigpending02 -i n by resetting sighandler_counter variable.
> Good catch, thanks!
>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> ...
>> +++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
>> @@ -13,6 +13,7 @@
>>    * Test 2: Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT.
>>    */
>> +#include "config.h"
>>   #include "tst_test.h"
>>   #include "ltp_signal.h"
>>   #include "lapi/syscalls.h"
>> @@ -36,7 +37,11 @@ static int tested_sigpending(sigset_t *sigset)
>>   {
>>   	switch (tst_variant) {
>>   	case 0:
>> +#ifndef HAVE_SIGPENDING
>> +		tst_brk(TCONF, "libc sigpending() is not implemented");
>> +#else
>>   		return sigpending(sigset);
>> +#endif
>>   	break;
> NOTE: I removed this break with 6d5b03aa9 ("Remove unnecessary breaks"),
> so you need to add it when rebasing this commit.
Hi Petr,

Sure, i will add it in v3 patch. :-)

Best Regards,
Xiao Yang
>
>>   	case 1:
>>   		return tst_syscall(__NR_sigpending, sigset);
>> @@ -60,6 +65,8 @@ static void test_sigpending(void)
>>   	int i; /* loop index */
>> +	sighandler_counter = 0;
>> +
>>   	/* set up signal mask and handler */
>>   	sigset_t only_SIGUSR, old_mask;
>>   	sighandler_t old_sighandler1, old_sighandler2;
> Kind regards,
> Petr
>
>
> .
>



