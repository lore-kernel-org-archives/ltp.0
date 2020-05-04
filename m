From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 4 May 2020 20:49:07 +0800
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <20200504051107.edvfiqloegt3ak5o@vireshk-i7>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
 <20200430085742.1663-2-yangx.jy@cn.fujitsu.com>
 <20200504051107.edvfiqloegt3ak5o@vireshk-i7>
Message-ID: <b74eac89-11fc-9a7c-c337-ffe6f19ec7b8@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/4/20 1:11 PM, Viresh Kumar wrote:
> On 30-04-20, 16:57, Xiao Yang wrote:
>> 1) Drop .min_kver flag directly because of two following reasons:
>>     a) pidfd_open(2) may be backported to old kernel which is less
>>        than v5.3 so kernel version check is meaningless.
>>     b) tst_syscall() can report TCONF if pidfd_open(2) is not supported.
>> 2) For pidfd_open03.c, check if pidfd_open(2) is not supported before
>>     calling fork() and remove unnecessary TEST().
>>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>>   .../kernel/syscalls/pidfd_open/pidfd_open01.c      |  1 -
>>   .../kernel/syscalls/pidfd_open/pidfd_open02.c      |  1 -
>>   .../kernel/syscalls/pidfd_open/pidfd_open03.c      | 14 +++++++++-----
>>   3 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> index 293e93b63..983dcdccb 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> @@ -32,6 +32,5 @@ static void run(void)
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
>> index 48470e5e1..2fc3b3a5f 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> @@ -27,11 +27,9 @@ static void run(void)
>>   		exit(EXIT_SUCCESS);
>>   	}
>>   
>> -	TEST(pidfd_open(pid, 0));
>> -
>> -	fd = TST_RET;
>> +	fd = pidfd_open(pid, 0);
>>   	if (fd == -1)
>> -		tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
>> +		tst_brk(TFAIL | TERRNO, "pidfd_open() failed");
> Unrelated change, please drop it.

Hi Viresh,

Yes, It is unrelated change and just a small cleanup.

My commit message has mentioned it and I don't want to do the cleanup in 
seperate patch.

>
>>   
>>   	TST_CHECKPOINT_WAKE(0);
>>   
>> @@ -49,8 +47,14 @@ static void run(void)
>>   		tst_res(TPASS, "pidfd_open() passed");
>>   }
>>   
>> +static void setup(void)
>> +{
>> +	// Check if pidfd_open(2) is not supported
>> +	tst_syscall(__NR_pidfd_open, -1, 0);
>> +}
>> +
>>   static struct tst_test test = {
>> -	.min_kver = "5.3",
>> +	.setup = setup,
>>   	.test_all = run,
>>   	.forks_child = 1,
>>   	.needs_checkpoints = 1,
> Please have a look at fsopen_supported_by_kernel() in lapi/fsmount.h
> and make such a helper.

First, I want to explain my check point:

Passing invalid argument can check the support of pidfd_open(2) by 
ENOSYS errno and we don't need to close the pidfd.

Second, I don't like the implementation of fsopen_supported_by_kernel() 
and give some suggestions:

a) syscall()/tst_syscall() is enough to check the support of 
pidfd_open(2) and 'tst_kvercmp(5, 2, 0)) < 0' will skip the check

 ??? if a kernel on distribution is newer than v5.2 but drop the support 
of pidfd_open(2) on purpose.

b) tst_syscall() has checked ENOSYS error so we can simple 
fsopen_supported_by_kernel() by replacing syscall() with tst_syscalls().

Like the following implementation:

-------------------------------------------------------

void fsopen_supported_by_kernel(void)
{
 ??? /* Check if the syscall is supported on a kernel */
 ??? TEST(tst_syscall(__NR_fsopen, NULL, 0));
 ??? if (TST_RET != -1)
 ??? ??? SAFE_CLOSE(TST_RET);
}

-------------------------------------------------------

Please correct me if I give some wrong info.

Thanks,

Xiao Yang

>

