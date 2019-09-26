From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 26 Sep 2019 14:37:08 +0200
Subject: [LTP] [PATCH] open_posix/conformance/clock/1.1: Deterministic
 timing
In-Reply-To: <20190926122546.GA27993@rei>
References: <20190925092958.125325-1-lkml@jv-coder.de>
 <20190926122546.GA27993@rei>
Message-ID: <ae7daebd-0a33-823c-1434-56a081480c0e@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Am 26.09.2019 um 14:25 schrieb Cyril Hrubis:
> Hi!
>> On some systems the loop with 8 million iterations takes a very long time.
>> This patches changes it to busy loop for five seconds.
>>
>> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> ---
>>   .../conformance/interfaces/clock/1-1.c                 | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock/1-1.c
>> index 9c48cd979..cce5beea9 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock/1-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock/1-1.c
>> @@ -17,20 +17,22 @@
>>   #include <time.h>
>>   #include <stdio.h>
>>   #include <unistd.h>
>> +#include <time.h>
>>   #include "posixtest.h"
>>   
>> -#define LARGENUMBER 8000000
>> +#define BUSY_LOOP_SECONDS 5
>>   int main(void)
>>   {
>>   	clock_t c1, c2;
>>   	double sec1, sec2;
>> -	int i;
>> +	time_t end;
>>   
>>   	c1 = clock();
>>   	sec1 = c1 / CLOCKS_PER_SEC;
>>   
>> -	for (i = 0; i < LARGENUMBER; i++) {
>> -		// keep busy so CPU time increases
>> +	end = time(NULL) + BUSY_LOOP_SECONDS;
>> +
>> +	while (end >= time(NULL)) {
>>   		clock();
>>   	}
> clock_gettime() with CLOCK_MONOTONIC would be better fit there, since
> the wall clock can be changed by ntp and generally is not guaranteed to
> be monotonic...
I was actually thinking the same, but decided to use time() because of 
a) it doesn't matter much as long as some time passes by and b) 
monotonic clocks are an optional feature in posix.
>>   
>> -- 
>> 2.20.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
