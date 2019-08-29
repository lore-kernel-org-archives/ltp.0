From: He Zhe <zhe.he@windriver.com>
Date: Thu, 29 Aug 2019 21:08:02 +0800
Subject: [LTP] [PATCH] syscalls: rt_sigwaitinfo01: Fix failure for MIPS
 arches
In-Reply-To: <4200333.8516580.1566933979370.JavaMail.zimbra@redhat.com>
References: <1566544121-147769-1-git-send-email-zhe.he@windriver.com>
 <4200333.8516580.1566933979370.JavaMail.zimbra@redhat.com>
Message-ID: <45ccbb16-aaf7-6016-4719-3968c45ce201@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 8/28/19 3:26 AM, Jan Stancek wrote:
>
> ----- Original Message -----
>> From: He Zhe <zhe.he@windriver.com>
>>
>> rt_sigtimedwait01 fails as follow on MIPS arches
>> rt_sigtimedwait01    1  TFAIL  :  .../sigwaitinfo01.c:58: test_empty_set
>> (.../sigwaitinfo01.c: 148): Unexpected failure:
>> TEST_ERRNO=EINVAL(22): Invalid argument
>>
>> As this case purposely bypasses glibc, it should align with the size of
>> kernel
>> definition of sigset_t which is different from other arches.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/uapi/asm/signal.h#n15
>>
>> This patch adds specific case for MIPS.
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
>> b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
>> index 5a32ce1..5c2fa99 100644
>> --- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
>> +++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
>> @@ -128,9 +128,16 @@ static int my_sigtimedwait(const sigset_t * set,
>> siginfo_t * info,
>>  static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
>>  			      struct timespec *timeout)
>>  {
>> -
>> -	/* The last argument is (number_of_signals)/(bits_per_byte), which are 64
>> and 8, resp. */
>> -	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout, 8);
>> +	/* The last argument is (number_of_signals)/(bits_per_byte), which are 64
>> and 8, resp,
>> +	 * except for MIPS which are 128 and 8, resp.
>> +	 */
>> +	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout,
>> +#ifdef __mips__
>> +		16
>> +#else
>> +		8
>> +#endif
> Hi,
>
> looking at kernel SYSCALL_DEFINE4(rt_sigtimedwait,..), the size is
> used in this check:
>         if (sigsetsize != sizeof(sigset_t))                                                                                                                   
>                 return -EINVAL; 
>
> So I'm wondering if need to have an absolute value here, and if we can't
> replace it with sizeof(sigset_t) or _NSIG / 8?

Thanks, I did try with sizeof(sigset_t) but it gave 128 bytes for MIPS.
_NSIG works well. I'll send v2.

Zhe

>
> Regards,
> Jan
>

