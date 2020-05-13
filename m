From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 May 2020 14:03:22 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <20200513055533.ipmghf2oacc22mzy@vireshk-i7>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
 <20200513012626.1571-2-yangx.jy@cn.fujitsu.com>
 <20200513055533.ipmghf2oacc22mzy@vireshk-i7>
Message-ID: <5EBB8DAA.5080509@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/5/13 13:55, Viresh Kumar wrote:
> On 13-05-20, 09:26, Xiao Yang wrote:
>> 1) Drop .min_kver flag directly because of two following reasons:
>>     a) pidfd_open(2) may be backported to old kernel which is less
>>        than v5.3 so kernel version check is meaningless.
>>     b) tst_syscall() can report TCONF if pidfd_open(2) is not supported.
>> 2) For pidfd_open03.c, check if pidfd_open(2) is not supported before
>>     calling fork().
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> Reviewed-by: Viresh Kumar<viresh.kumar@linaro.org>
>
> You can not apply someone's tag without them explicitly asking you to.
Hi Viresh,

OK, I can remove it.

>
>> ---
>>   testcases/kernel/syscalls/pidfd_open/pidfd_open01.c |  1 -
>>   testcases/kernel/syscalls/pidfd_open/pidfd_open02.c |  1 -
>>   testcases/kernel/syscalls/pidfd_open/pidfd_open03.c | 12 +++++++++++-
>>   3 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> index ba1580bc7..6f5114f68 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> @@ -29,6 +29,5 @@ static void run(void)
>>   }
>>
>>   static struct tst_test test = {
>> -	.min_kver = "5.3",
>>   	.test_all = run,
>>   };
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
>> index dc86cae7a..a7328ddfe 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
>> @@ -51,7 +51,6 @@ static void run(unsigned int n)
>>   }
>>
>>   static struct tst_test test = {
>> -	.min_kver = "5.3",
>>   	.tcnt = ARRAY_SIZE(tcases),
>>   	.test = run,
>>   	.setup = setup,
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> index 48470e5e1..9e27ee75e 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> @@ -49,8 +49,18 @@ static void run(void)
>>   		tst_res(TPASS, "pidfd_open() passed");
>>   }
>>
>> +static void setup(void)
>> +{
>> +	int pidfd = -1;
>> +
>> +	// Check if pidfd_open(2) is not supported
>> +	pidfd = tst_syscall(__NR_pidfd_open, getpid(), 0);
>> +	if (pidfd != -1)
>> +		SAFE_CLOSE(pidfd);
>> +}
>> +
>
> This only fixes the 3rd test, the other two will have an issue now.

Could you tell which issue happen? Thanks a lot.
The other two don't need the extra check because the implementation of 
pidfd_open() can do it well.  For 3rd test, I want to check the support 
of pidfs_open() before doing fork().

Thanks,
Xiao Yang
>
>>   static struct tst_test test = {
>> -	.min_kver = "5.3",
>> +	.setup = setup,
>>   	.test_all = run,
>>   	.forks_child = 1,
>>   	.needs_checkpoints = 1,
>> --
>> 2.21.0
>>
>>
>



