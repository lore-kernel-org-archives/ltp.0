From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Aug 2016 17:11:20 +0300
Subject: [LTP] [PATCH 1/4] memcg/functional: rewrite
In-Reply-To: <20160622133444.GD13962@rei.lan>
References: <1465917893-32074-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160622133444.GD13962@rei.lan>
Message-ID: <57B71388.9090106@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 06/22/2016 04:34 PM, Cyril Hrubis wrote:
> Hi!
>>  # Record the test result of a test case
>>  # $1 - The result of the test case, $PASS or $FAIL
>> @@ -55,7 +82,6 @@ result()
>>  		tst_resm TPASS "$info"
>>  	else
>>  		tst_resm TFAIL "$info"
>> -		: $(( failed += 1 ))
>>  	fi
> 
> Can we get rid of the result() function?
> 
> Since the failures are now counted in the test.sh library it does not
> make a sense to define special result reporting function.

Yes, we can.

One thing to notice that in the current code there are many places like
this:

echo 1.0 > memory.limit_in_bytes 2> /dev/null
result $(( !($? != 0) )) "return value is $?"

I don't think it will be a good idea to transform them all to:

echo 1.0 > memory.limit_in_bytes 2> /dev/null
if [ $? -ne 0 ]; then
   tst_resm TPASS "return value is $?"
else
   tst_resm TFAIL "return value is 0"
fi

A possible solution could be using help functions similar to ROD():

SHOULD_FAIL echo 1.0 \> memory.limit_in_bytes

which will output:

TPASS: echo 1.0 > memory.limit_in_bytes failed as expected

I have an RFC patch for that. I'll send it shortly.

> 
>> @@ -83,7 +109,7 @@ warmup()
>>  {
>>  	pid=$1
>>  
>> -	echo "Warming up for test: $cur_id, pid: $pid"
>> +	tst_resm TINFO "Warming up pid: $pid"
>>  	kill -s USR1 $pid 2> /dev/null
>>  	sleep 1
>>  	kill -s USR1 $pid 2> /dev/null
>> @@ -91,10 +117,10 @@ warmup()
>>  
>>  	kill -0 $pid
>>  	if [ $? -ne 0 ]; then
>> -		result $FAIL "cur_id=$cur_id"
>> +		result $FAIL ""
>                               ^
> Shouldn't we print here something as:
> 
> "process died after warmup"
> 
> Or even better wait the pid and print the exit value as well.

Ok. Will do.

> 
> 
> Otherwise this looks fine.
> 
