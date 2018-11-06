From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Tue, 6 Nov 2018 14:48:28 +0800
Subject: [LTP] [PATCH] kernel/syscall/setrlimit05.c: use a legal bad
 address for mips
In-Reply-To: <5BE0F5EC.6010500@cn.fujitsu.com>
References: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
 <5BE0F5EC.6010500@cn.fujitsu.com>
Message-ID: <0aba9f25-9032-6abd-9118-fbcd5248c12f@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 11/06/2018 10:01 AM, Xiao Yang wrote:
> Hi Hongzhi,
>
> Do you try to build CONFIG_SYSCTL_SYSCALL and run sysctl04 on mips32?
> It seems that (void *) -1 is used in sysctl04.c as well.  Perhaps, you 
> can fix
> the issue together if sysctl04 gets the same error on mips32. :-)

Thank you for your help.
I find that there is no glibc wrapper for syscall() but other syscall 
APIs do.

Sometimes, glibc converts struct32 to struct64, this behavior maybe has an
effect on result.

--Hongzhi

>
> Best Regards,
> Xiao Yang
> On 2018/11/05 15:30, Hongzhi.Song wrote:
>> This testcase fails on mips32. The process is killed by SIGBUS which
>> doesn't return EFAULT as expect.
>>
>> This is because:
>> ((void *)-1) is not a legal bad address which causes the process
>> killed by SIGBUG on mips.
>>
>> 'tst_get_bad_addr()' returns an address that should work on mips
>> and other arches.
>>
>> Signed-off-by: Hongzhi.Song<hongzhi.song@windriver.com>
>> ---
>>   testcases/kernel/syscalls/setrlimit/setrlimit05.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c 
>> b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
>> index e716722..57b0b82 100644
>> --- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
>> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
>> @@ -31,9 +31,13 @@ static void verify_setrlimit(void)
>>       int status;
>>       pid_t pid;
>>
>> +    void *bad_addr;
>> +
>> +    bad_addr = tst_get_bad_addr(NULL);
>> +
>>       pid = SAFE_FORK();
>>       if (!pid) {
>> -        TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
>> +        TEST(setrlimit(RLIMIT_NOFILE,(struct rlimit *)bad_addr));
>>           if (TST_RET != -1) {
>>               tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
>>               exit(0);
>
>
>
>

