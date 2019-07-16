From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Tue, 16 Jul 2019 17:07:58 +0800
Subject: [LTP] [PATCH V4] getrlimit03: adjust a bit of code to
 compatiable with mips32
In-Reply-To: <1694827109.292834.1563260827076.JavaMail.zimbra@redhat.com>
References: <1563185037-236824-1-git-send-email-hongzhi.song@windriver.com>
 <1563185037-236824-2-git-send-email-hongzhi.song@windriver.com>
 <1694827109.292834.1563260827076.JavaMail.zimbra@redhat.com>
Message-ID: <c852fb75-25d9-455b-dabb-96542c1106d6@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 7/16/19 3:07 PM, Jan Stancek wrote:
>
> ----- Original Message -----
>> Error info:
>> getrlimit03.c:104: FAIL: __NR_prlimit64(0) had rlim_cur =
>> ffffffffffffffff but __NR_getrlimit(0) had rlim_cur = 7fffffff
>>
>> According to kernel code: [arch/mips/include/uapi/asm/resource.h]
>> RLIM_INFINITY is set to 0x7fffffffUL instead of ULONG_MAX on mips32.
>>
>>   /*
>>   * SuS says limits have to be unsigned.
>>   * Which makes a ton more sense anyway,
>>   * but we keep the old value on MIPS32,
>>   * for compatibility:
>>   */
>>   #ifndef __mips64
>>   # define RLIM_INFINITY      0x7fffffffUL
>>   #endif
>>
>> Adding conditional statement about mips to fix this.
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
>> ---
>>   testcases/kernel/syscalls/getrlimit/getrlimit03.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>> b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>> index e4d56c4..03bd821 100644
>> --- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>> @@ -26,6 +26,7 @@
>>   
>>   #include "tst_test.h"
>>   #include "lapi/syscalls.h"
>> +#include "lapi/abisize.h"
>>   
>>   /**
>>    * Linux provides an "old" getrlimit syscall handler that uses signed long,
>> @@ -61,7 +62,12 @@ struct rlimit_ulong {
>>   	unsigned long rlim_cur;
>>   	unsigned long rlim_max;
>>   };
>> -const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
>> +
>> +#if defined(__mips) && defined(TST_ABI32)
> I see several tests already use __mips__, why did you go with __mips here?
> Anyway, I'm fine with the patch.


I just find kernel uses __mips, but I will change to __mips__ with patch-v5.

Thanks.

--Hongzhi


>
>> +	const unsigned long RLIM_INFINITY_UL = 0x7fffffffUL;
>> +#else
>> +	const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
>> +#endif
>>   
>>   static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
>>   {
>> --
>> 2.8.1
>>
>>
