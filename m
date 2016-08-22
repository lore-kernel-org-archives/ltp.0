From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 22 Aug 2016 15:51:56 +0300
Subject: [LTP] [RFC PATCH] test.sh: add SHOULD_PASS,
	SHOULD_FAIL functions
In-Reply-To: <20160822123140.GA18142@rei>
References: <1471617816-15339-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160822123140.GA18142@rei>
Message-ID: <57BAF56C.8070005@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 08/22/2016 03:31 PM, Cyril Hrubis wrote:
> Hi!
>> Sometimes we need to execute a command and call tst_resm TPASS/TFAIL
>> based on the command's exit status.
>>
>> The existing ROD() function can make 99% of the job, we just
>> need to let it know how the command's exit code should be
>> interpreted. This patch does it and introduce a couple of new
>> functions to help with the described situation.
>>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>> This is to help with situations like:
>>
>> echo 1.0 > memory.limit_in_bytes 2> /dev/null
>> if [ $? -ne 0 ]; then
>>    tst_resm TPASS "return value is $?"
>> else
>>    tst_resm TFAIL "return value is 0"
>> fi
>>
>> which could be transformed to:
>>
>> SHOULD_FAIL echo 1.0 \> memory.limit_in_bytes
> 
> This is quite nice. Maybe it would better be named EXPECT_FAIL and
> EXPECT_PASS or something but SHOULD_ prefix is fine as well.

Ok, will rename to EXPECT_*.

> 
> We should include documentation for these in this commit as well.

Ok.

> 
> A few comments to the implementation below.
> 
>>  testcases/lib/test.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 files changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
>> index bd66109..ca2c00b 100644
>> --- a/testcases/lib/test.sh
>> +++ b/testcases/lib/test.sh
>> @@ -220,12 +220,17 @@ ROD_SILENT()
>>  	fi
>>  }
>>  
>> -ROD()
>> +ROD_DISPATCHER()
>>  {
>> +	local act
>>  	local cmd
>>  	local arg
>>  	local file
>>  	local flag
>> +	local ret
>> +
>> +	act="$1"
>> +	shift
>>  
>>  	for arg; do
>>  		file="${arg#\>}"
>> @@ -251,9 +256,46 @@ ROD()
>>  		$@
>>  	fi
>>  
>> -	if [ $? -ne 0 ]; then
>> -		tst_brkm TBROK "$@ failed"
>> -	fi
>> +	ret=$?
> 
> Why don't we just return from this function here and let the caller
> examine the $?

No specific reason. Will put the handling of $? into the callers of
ROD_DISPATCHER, and rename ROD_DISPATCHER to something like ROD_BASE,
since now it doesn't "dispatch".

> 
>> +	case "$act" in
>> +		0) # break on failure
>> +		if [ $ret -ne 0 ]; then
>> +			tst_brkm TBROK "$@ failed"
>> +		fi;;
>> +
>> +		1) # the command should pass
>> +		if [ $ret -eq 0 ]; then
>> +			tst_resm TPASS "$@ passed as expected"
>> +		else
>> +			tst_resm TFAIL "$@ failed unexpectedly"
>> +		fi;;
>> +
>> +		2) # the command should fail
>> +		if [ $ret -ne 0 ]; then
>> +			tst_resm TPASS "$@ failed as expected"
>> +		else
>> +			tst_resm TFAIL "$@ passed unexpectedly"
>> +		fi;;
>> +
>> +		*) tst_brkm TBROK "unknown action '$act'";;
>> +	esac
>> +}
>> +
>> +ROD()
>> +{
>> +	ROD_DISPATCHER 0 $@
>> +}
>> +
>> +SHOULD_PASS()
>> +{
>> +	ROD_DISPATCHER 1 $@
>> +}
>> +
>> +SHOULD_FAIL()
>> +{
>> +	# redirect stderr since we expect the command to fail
>> +	ROD_DISPATCHER 2 $@ 2> /dev/null
>>  }
> 
> I think that we should quote the $@ in these functions.
> 
> Try for yourself:
> 
> 8<------------------------------------
> 
> #!/bin/sh
> 
> d()
> {
>         echo "-------------"
>         for i; do
>                 echo $i
>         done
>         echo "-------------"
> }
> 
> dd()
> {
>         d "$@"
> }
> 
> 
> d a b c
> dd a b c
> d "a b c"
> dd "a b c"
> 
> 8<------------------------------------
> 
> If you unquote the $@ in dd() the "a b c" in the last call would be separated
> on spaces.
> 

Got it. Thank you.
