From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 14 Dec 2018 16:40:17 +0800
Subject: [LTP] [PATCH] openposix/strncpy1-1: Fix compiler errors/warnings
In-Reply-To: <20181214083313.GA18691@rei>
References: <20181211123931.GC27346@rei>
 <1544611203-22197-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20181214083313.GA18691@rei>
Message-ID: <5C136C71.5040104@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/12/14 16:33, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   .../conformance/interfaces/strncpy/1-1.c           |   10 +++++++---
>>   testcases/open_posix_testsuite/include/posixtest.h |    2 ++
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
>> index 396bd60..7006b5f 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
>> @@ -61,10 +61,14 @@ int main(void)
>>           sample_str_1 = random_string(i);
>>           num_bytes = rand() % i;
>>
>> -        #pragma GCC diagnostic push
>> -        #pragma GCC diagnostic ignored "-Wstringop-truncation"
>> +	#if GCC_VERSION>= 80100
>> +	# pragma GCC diagnostic push
>> +	# pragma GCC diagnostic ignored "-Wstringop-truncation"
>> +	#endif
>>           ret_str = strncpy(sample_str_2, sample_str_1, num_bytes);
>> -        #pragma GCC diagnostic pop
>> +	#if GCC_VERSION>= 80100
>> +	# pragma GCC diagnostic pop
>> +	#endif
> That looks even more silly than the original. I do not think that it's
> reasonable to mess up the code that bad only to surpress a single
> warning.
>
> So what abour removing the pragmas entirely?
>
Hi Cyril,

I didn't get any failure after removing the pragmas on older/newer gcc, 
so i think

we can remove it directly.


Best Regards,
Xiao Yang



