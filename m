From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Fri, 12 Jul 2019 17:20:38 +0800
Subject: [LTP] [PATCH V2] getrlimit03: adjust a bit of code to
 compatiable with mips32
In-Reply-To: <1691784527.32812965.1562915669160.JavaMail.zimbra@redhat.com>
References: <1562826026-158569-1-git-send-email-hongzhi.song@windriver.com>
 <408194681.32599099.1562831328308.JavaMail.zimbra@redhat.com>
 <c0c07134-f5a8-b4d3-c210-c58c36653423@windriver.com>
 <1691784527.32812965.1562915669160.JavaMail.zimbra@redhat.com>
Message-ID: <c15e6a0a-34dd-100a-2a42-066a1e23f206@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 7/12/19 3:14 PM, Jan Stancek wrote:
> ----- Original Message -----
>> On 7/11/19 3:48 PM, Jan Stancek wrote:
>>> ----- Original Message -----
>>>> Error info:
>>>> getrlimit03.c:104: FAIL: __NR_prlimit64(0) had rlim_cur =
>>>> ffffffffffffffff but __NR_getrlimit(0) had rlim_cur = 7fffffff
>>>>
>>>> According to kernel code: [arch/mips/include/uapi/asm/resource.h]
>>>> RLIM_INFINITY is set to 0x7fffffffUL instead of ULONG_MAX on mips32.
>>>>
>>>> /*
>>>>    * SuS says limits have to be unsigned.
>>>>    * Which makes a ton more sense anyway,
>>>>    * but we keep the old value on MIPS32,
>>>>    * for compatibility:
>>>>    */
>>>> #ifndef __mips64
>>>> # define RLIM_INFINITY      0x7fffffffUL
>>>> #endif
>>>>
>>>> Adding conditional statement about mips to fix this.
>>>>
>>>> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
>>>> ---
>>>>    testcases/kernel/syscalls/getrlimit/getrlimit03.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>>>> b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>>>> index e4d56c4..1903558 100644
>>>> --- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>>>> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
>>>> @@ -61,7 +61,13 @@ struct rlimit_ulong {
>>>>    	unsigned long rlim_cur;
>>>>    	unsigned long rlim_max;
>>>>    };
>>>> +#ifdef __mips
>>>> +#ifndef __mips64
>>>> +const unsigned long RLIM_INFINITY_UL = 0x7fffffffUL;
>>>> +#else
>>>>    const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
>>>> +#endif
>>>> +#endif
>>> Hi,
>>>
>>> This will break every other arch, because it's now undefined everywhere
>>> except mips.
>>
>> Is there a good way to filter mips32?
> Maybe something like:
>
> #include "lapi/abisize.h"
>
> #if defined(__mips__) && defined(TST_ABI32)
> const unsigned long RLIM_INFINITY_UL = 0x7fffffffUL;
> #else
> const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
> #endif


TST_ABI32 looks like not work, and I sent patch-V3 using __mips and __mips64.

--Hongzhi


>
>> I tried
>>
>>   ?65 #ifdef __mips
>>   ?66 #ifndef __mips64
>>   ?67 const unsigned long RLIM_INFINITY_UL = 0x7fffffffUL;
>>   ?68 #endif
>>   ?69 const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
>>   ?70 #else
>>   ?71 const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
>>   ?72 #endif
>>
>> but mips32 thinks the RLIM_INFINITY_UL micro is redefined.
>>
>>
>>>>    
>>>>    static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
>>>>    {
>>>> @@ -101,8 +107,8 @@ static int compare_u64_ulong(int resource, uint64_t
>>>> val_u64,
>>>>    {
>>>>    	if ((val_u64 > RLIM_INFINITY_UL && val_ul != RLIM_INFINITY_UL) ||
>>>>    	    (val_u64 <= RLIM_INFINITY_UL && val_ul != val_u64)) {
>>>> -		tst_res(TFAIL, "__NR_prlimit64(%d) had %s = %" PRIx64 " but "
>>>> __NR_getrlimit_ulong_str "(%d) had %s = %lx",
>>>> -			resource, kind, val_u64,
>>>> +		tst_res(TFAIL, "SIGNED_GETRLIMIT = %d __WORDSIZE %d ULONG_MAX = %lu
>>>> RLIM_INFINITY_UL = %lu __NR_prlimit64(%d) had %s = %" PRIx64 " but "
>>>> __NR_getrlimit_ulong_str "(%d) had %s = %lx",
>>>> +			SIGNED_GETRLIMIT, __WORDSIZE, ULONG_MAX, RLIM_INFINITY_UL, resource,
>>> I suggest to split it into another tst_res() message, line above is nearly
>>> 200 characters.
>>
>> Sorry, I shouldn't append debug code to patch.
>>
>> --Hongzhi
>>
>>
>>> Regards,
>>> Jan
>>>
>>>> kind, val_u64,
>>>>    			resource, kind, val_ul);
>>>>    		return -1;
>>>>    	}
>>>> --
>>>> 2.8.1
>>>>
>>>>
>>>> --
>>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>>>
