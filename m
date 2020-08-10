From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Mon, 10 Aug 2020 15:56:39 +0200
Subject: [LTP] [PATCH v2 2/3] syscalls/clock_nanosleep: add a test case
 for bad timespec address
In-Reply-To: <20200810125719.GC11869@yuki.lan>
References: <20200807113950.69052-1-Filip.Bozuta@syrmia.com>
 <20200807113950.69052-3-Filip.Bozuta@syrmia.com>
 <20200810125719.GC11869@yuki.lan>
Message-ID: <ceb37d42-c6db-4438-efe8-221f1da0d556@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

thanks for the review!

On 10.8.20. 14:57, Cyril Hrubis wrote:
> Hi!
>> This patch introduces test cases for already existing test
>> for syscall 'clock_nanosleep()' (clock_nanosleep01). These test
>> cases are for situations when bad timespec addresses are passed
>> for arguments 'request' and 'remain' in which case errno
>> EFAULT ('Bad address') is expected to be set.
>>
>> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
>> ---
>>   .../clock_nanosleep/clock_nanosleep01.c       | 35 +++++++++++++++++--
>>   1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
>> index 4542995f2..66108ed8e 100644
>> --- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
>> +++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
>> @@ -20,6 +20,8 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>>   enum test_type {
>>   	NORMAL,
>>   	SEND_SIGINT,
>> +	BAD_TS_ADDR_REQ,
>> +	BAD_TS_ADDR_REM,
>>   };
>>   
>>   #define TYPE_NAME(x) .ttype = x, .desc = #x
>> @@ -78,6 +80,22 @@ static struct test_case tcase[] = {
>>   		.exp_ret = -1,
>>   		.exp_err = EINTR,
>>   	},
>> +	{
>> +		TYPE_NAME(BAD_TS_ADDR_REQ),
>> +		.clk_id = CLOCK_REALTIME,
>> +		.flags = 0,
>> +		.exp_ret = -1,
>> +		.exp_err = EFAULT,
>> +	},
>> +	{
>> +		TYPE_NAME(BAD_TS_ADDR_REM),
>> +		.clk_id = CLOCK_REALTIME,
>> +		.flags = 0,
>> +		.tv_sec = 10,
>> +		.tv_nsec = 0,
>> +		.exp_ret = -1,
>> +		.exp_err = EFAULT,
>> +	},
>>   };
>>   
>>   static struct tst_ts *rq;
>> @@ -106,24 +124,37 @@ void setup(void)
>>   	SAFE_SIGNAL(SIGINT, sighandler);
>>   }
>>   
>> +void cleanup(void) {}
> Please just pass NULL to the tst_get_bad_addr() instead.
>
> Also it should be called only once in the test setup, as I explained for
> the previous patch.

Yes I will change this and send v3 for this patch soon. I will pass NULL 
and move the tst_get_bad_addr() in test setup() same as in the first 
patch. Thanks for the explanation!

>
>>   static void do_test(unsigned int i)
>>   {
>>   	struct test_variants *tv = &variants[tst_variant];
>>   	struct test_case *tc = &tcase[i];
>>   	pid_t pid = 0;
>> +	void *request, *remain;
>>   
>>   	memset(rm, 0, sizeof(*rm));
>>   	rm->type = rq->type;
>>   
>>   	tst_res(TINFO, "case %s", tc->desc);
>>   
>> -	if (tc->ttype == SEND_SIGINT)
>> +	if (tc->ttype == SEND_SIGINT || tc->ttype == BAD_TS_ADDR_REM)
>>   		pid = create_sig_proc(SIGINT, 40, 500000);
> Does the kernel access the remaining time only if the call gets
> interrupted by a signal?
Yes, the the 'remain' argument is accessed only in a case when call gets 
interrupted by a signal and in case it is not NULL and if flag 
TIMER_ABSTIME is not set, the argument gets updated with the remaining 
time from the timeout. For that reason a signal should be set in this 
test case so that the test fails with expected errno (EFAULT) when 
kernel tries to access the argument.
>
> I guess that this would be better written down in comment.
>
> Generally LTP testcases usually have short documentation in a comment
> just after the license and copyright. In this case it should be
> something as:
>
> /*
>   * EINVAL - negative tv_nsec
>   * EINVAL - tv_nsec > 1s
>   * ...
>   * EFAULT - invalid request pointer
>   * EFAULT - invalid remain pointer while interrupted by a signal
>   */

Thanks for pointing this out. I will put these short comment 
explanations in my v3 version of this patch.

Best regards,

Filip

>>   	tst_ts_set_sec(rq, tc->tv_sec);
>>   	tst_ts_set_nsec(rq, tc->tv_nsec);
>>   
>> -	TEST(tv->func(tc->clk_id, tc->flags, tst_ts_get(rq), tst_ts_get(rm)));
>> +	if (tc->ttype == BAD_TS_ADDR_REQ)
>> +		request = tst_get_bad_addr(cleanup);
>> +	else
>> +		request = tst_ts_get(rq);
>> +
>> +	if (tc->ttype == BAD_TS_ADDR_REM)
>> +		remain = tst_get_bad_addr(cleanup);
>> +	else
>> +		remain = tst_ts_get(rm);
>> +
>> +	TEST(tv->func(tc->clk_id, tc->flags, request, remain));
>>   
>>   	if (tv->func == libc_clock_nanosleep) {
>>   		/*
>> -- 
>> 2.25.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
