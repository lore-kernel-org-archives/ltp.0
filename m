From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 4 May 2020 19:31:23 +0800
Subject: [LTP] [PATCH 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200504050937.oassdcfg4x5zh4nm@vireshk-i7>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
 <20200504050937.oassdcfg4x5zh4nm@vireshk-i7>
Message-ID: <e666a91d-1ffd-0f5f-131e-966ff763b14e@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/4/20 1:09 PM, Viresh Kumar wrote:
> On 30-04-20, 16:57, Xiao Yang wrote:
>> pidfd_open(2) will set close-on-exec flag on the file descriptor as it
>> manpage states, so check close-on-exec flag by fcntl(2).
>>
>> Also avoid compiler warning by replacing (long) TST_RET with (int) pidfd:
>> ------------------------------------------------------
>> In file included from pidfd_open01.c:9:
>> pidfd_open01.c: In function ?run?:
>> ../../../../include/tst_test.h:76:41: warning: format ?%i? expects argument of type ?int?, but argument 5 has type ?long int? [-Wformat=]
>>     76 |   tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
>>        |                                         ^~~~~~~~~
>> ../../../../include/tst_safe_macros.h:224:5: note: in expansion of macro ?tst_brk?
>>    224 |     tst_brk(TBROK | TERRNO,                          \
>>        |     ^~~~~~~
>> pidfd_open01.c:20:9: note: in expansion of macro ?SAFE_FCNTL?
>>     20 |  flag = SAFE_FCNTL(TST_RET, F_GETFD);
> This log isn't useful as the warning started coming after your change
> only and not before.

Hi Viresh,

Thanks for your review.

Right?just add a hint why I use pidfd instead so I want to keep it.

Of course?I will mention that my change introduces the compiler warning 
in v2 patch.

>
>> ------------------------------------------------------
>>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>>   .../kernel/syscalls/pidfd_open/pidfd_open01.c  | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> index 93bb86687..293e93b63 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> @@ -6,17 +6,27 @@
>>    * Basic pidfd_open() test, fetches the PID of the current process and tries to
>>    * get its file descriptor.
>>    */
>> +
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>>   #include "tst_test.h"
>>   #include "lapi/pidfd_open.h"
>>   
>>   static void run(void)
>>   {
>> -	TEST(pidfd_open(getpid(), 0));
>> +	int pidfd = 0, flag = 0;
> None of these need to be initialized.

Initialization or not initialization are both fine for me.

Do you have any strong reason to drop Initialization?

>
>> +
>> +	pidfd = pidfd_open(getpid(), 0);
>> +	if (pidfd == -1)
>> +		tst_brk(TFAIL | TERRNO, "pidfd_open(getpid(), 0) failed");
> This could have been written as:
>          TEST(pidfd = pidfd_open(getpid(), 0));

Why do you want to keep TEST()? I don't think it is necessary:

1) pidfd and TERRNO are enough to check return value and errno.

2) It is OK for testcase to not use TEST().

Thanks,

Xiao Yang

>
>> +
>> +	flag = SAFE_FCNTL(pidfd, F_GETFD);
>>   
>> -	if (TST_RET == -1)
>> -		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
>> +	SAFE_CLOSE(pidfd);
>>   
>> -	SAFE_CLOSE(TST_RET);
>> +	if (!(flag & FD_CLOEXEC))
>> +		tst_brk(TFAIL, "pidfd_open(getpid(), 0) didn't set close-on-exec flag");
>>   
>>   	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
>>   }
>> -- 
>> 2.21.0
>>
>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200504/7f2e00c4/attachment.htm>
