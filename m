From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 11:20:19 -0300
Subject: [LTP] [PATCH] futex/futex_wake04.c: fix issues with hugepages
 and usleep
In-Reply-To: <20181010104317.GB1990@rei>
References: <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org>
 <20181009210602.23261-1-rafael.tinoco@linaro.org> <20181010104317.GB1990@rei>
Message-ID: <8dbc9378-4394-7c90-21f1-f091efbef14f@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/10/18 7:43 AM, Cyril Hrubis wrote:
> Hi!
>> This commit fixes 2 observed issues:
>>
>> 1) usleep() time is too small if test is being executed in slower
>> terminal devices (specially embedded systems). Raising it to 0.001
>> seconds was enough to finish 10240 iterations in around 90 seconds in a
>> 4 vcpu kvm guest (fully emulated serial being used as console).
>>
>> 2) Test was changing number of hugepages during setup()/cleanup() phase
>> despite the system had (or not) available hugepages. This was causing
>> overhead of destroying (or creating) hugepages during the test
>> execution.  Now, if system has > 0 hugepages available, the test doesn't
>> touch it.
> 
> Can you please split this into separate patches? Generally it's
> considered a good practice to split unrelated changes like these.
> 
>> Link: https://bugs.linaro.org/show_bug.cgi?id=3984
>> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
>> ---
>>   testcases/kernel/syscalls/futex/futex_wake04.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
>> index 3c7038317..93d36ac33 100644
>> --- a/testcases/kernel/syscalls/futex/futex_wake04.c
>> +++ b/testcases/kernel/syscalls/futex/futex_wake04.c
>> @@ -76,14 +76,17 @@ static void setup(void)
>>   	tst_tmpdir();
>>   
>>   	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
>> -	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
>> +
>> +	if (!orig_hugepages)
> 
> Maybe <= 0 would be a bit more robust.
> 
>> +		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
>>   
>>   	TEST_PAUSE;
>>   }
>>   
>>   static void cleanup(void)
>>   {
>> -	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
>> +	if (!orig_hugepages)
>> +		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 0);
>>   
>>   	tst_rmdir();
>>   }
>> @@ -172,8 +175,9 @@ static void wakeup_thread2(void)
>>   				tst_strerrno(res));
>>   	}
>>   
>> +	/* 0.001 seconds: less might cause lockups for slower terminals */
> 
> I would avoid comments like this, you can check the git changelog to
> figure out why the value was changed.
> 
>>   	while (wait_for_threads(2))
>> -		usleep(100);
>> +		usleep(1000);
>>   
>>   	futex_wake(futex2, 1, 0);
>>   
>> -- 
>> 2.19.1
>>
> 

I missed these comments in the 2 v2 I sent. Please feel free to change 
or let me know if you prefer a v3. Tks a lot.
