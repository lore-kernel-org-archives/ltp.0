From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Tue, 6 Nov 2018 14:36:58 +0800
Subject: [LTP] [PATCH] kernel/syscall/setrlimit05.c: use a legal bad
 address for mips
In-Reply-To: <20181105152237.GA3478@rei>
References: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
 <20181105152237.GA3478@rei>
Message-ID: <5665e310-b1f1-60e5-6aa7-289eba6cf6a9@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 11/05/2018 11:22 PM, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
>> index e716722..57b0b82 100644
>> --- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
>> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
>> @@ -31,9 +31,13 @@ static void verify_setrlimit(void)
>>   	int status;
>>   	pid_t pid;
>>   
>> +    void *bad_addr;
>> +
>> +    bad_addr = tst_get_bad_addr(NULL);
> It would be better if we called this only once in the test setup()
> function as the function actually maps a page of memory, the test may
> fail if we pass large enough -i parameter.

This case just runs one time. But I still send V2 with using setup() to 
apply memory.

--Hongzhi

>
>>   	pid = SAFE_FORK();
>>   	if (!pid) {
>> -		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
>> +		TEST(setrlimit(RLIMIT_NOFILE,(struct rlimit *)bad_addr));
>>   		if (TST_RET != -1) {
>>   			tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
>>   			exit(0);
>> -- 
>> 2.8.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

