From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Nov 2018 16:42:01 +0300
Subject: [LTP] [PATCH] lib/tst_test.sh: don't call _tst_do_exit()
 recursively with tst_brk()
In-Reply-To: <20181127090439.GA23733@dell5510>
References: <1542729786-4097-1-git-send-email-alexey.kodanev@oracle.com>
 <20181127090439.GA23733@dell5510>
Message-ID: <f96d10e9-fb35-fe98-0ab0-3fd0c7891c42@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 11/27/2018 12:04 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> With this patch, "safe" functions such as "ROD" and "tst_rhost_run -s"
>> can be used in a test cleanup function, i.e. in case of an error, "safe"
>> command won't recursively call the cleanup function again but will only
>> print the warning message about the failure.
> 
>> This behavior is consistent with the LTP C library.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  testcases/lib/tst_test.sh |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>> index 16081fa..e84cf7f 100644
>> --- a/testcases/lib/tst_test.sh
>> +++ b/testcases/lib/tst_test.sh
>> @@ -41,6 +41,7 @@ trap "tst_brk TBROK 'test interrupted'" INT
>>  _tst_do_exit()
>>  {
>>  	local ret=0
>> +	TST_DO_EXIT=1
> 
>>  	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
>>  	     -z "$TST_NO_CLEANUP" ]; then
>> @@ -123,6 +124,11 @@ tst_brk()
>>  	local res=$1
>>  	shift
> 
>> +	if [ "$TST_DO_EXIT" = 1 ]; then
>> +		tst_res TWARN "$@"
>> +		return
>> +	fi
>> +
>>  	tst_res "$res" "$@"
>>  	_tst_do_exit
>>  }
> 
> Shouldn't we return explicitly after any tst_brk_ call in tst_rhost_run()?
> Without that we get warning twice, when called from cleanup.
> test 2 TWARN: tst_rhost_run: command not defined
> test 2 TWARN: tst_rhost_run: command not defined
> 
> This should fix it:
> 
> diff --git testcases/lib/tst_net.sh testcases/lib/tst_net.sh
> index d1206e285..385e3bf5c 100644
> --- testcases/lib/tst_net.sh
> +++ testcases/lib/tst_net.sh
> @@ -140,8 +140,11 @@ tst_rhost_run()
>  	local user="root"
>  	local cmd=
>  	local safe=0
> +	local ttype=TWARN
>  	local bg=
>  
> +	[ "$safe" -eq 1 ] && ttype=TWARN
> +

ttype=TBROK?

>  	OPTIND=0
>  
>  	while getopts :bBsc:u: opt; do
> @@ -161,9 +164,7 @@ tst_rhost_run()
>  	OPTIND=0
>  
>  	if [ -z "$cmd" ]; then
> -		[ "$safe" -eq 1 ] && \
> -			tst_brk_ TBROK "tst_rhost_run: command not defined"
> -		tst_res_ TWARN "tst_rhost_run: command not defined"
> +		tst_brk_ $ttype "tst_rhost_run: command not defined"
>  		return 1

I think we should only remove tst_res_ TWARN here. Otherwise it will exit
the test for non-safe option too.



>  	fi
>  
> @@ -182,8 +183,10 @@ tst_rhost_run()
>  	echo "$output" | grep -q 'RTERR$' && ret=1
>  	if [ $ret -eq 1 ]; then
>  		output=$(echo "$output" | sed 's/RTERR//')
> -		[ "$safe" -eq 1 ] && \
> +		if [ "$safe" -eq 1 ]; then
>  			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
> +			return 1
> +		fi


It looks as if someone forgot that tst_brk_ terminates the test :)


>  	fi
>  
>  	[ -z "$out" -a -n "$output" ] && echo "$output"


> 
> 
> Other option is really run $TST_CLEANUP function only once, but that's
> inconsistent with C library :-(. Code would be simple:
> 
> diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
> index adfaea47e..beb1275ba 100644
> --- testcases/lib/tst_test.sh
> +++ testcases/lib/tst_test.sh
> @@ -44,6 +44,7 @@ _tst_do_exit()
>  
>  	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
>  	     -z "$TST_NO_CLEANUP" ]; then
> +		TST_NO_CLEANUP=1
>  		$TST_CLEANUP
>  	fi
>  
> And we should update doc.
> 

OK, we should add similar "WARNING" from 2.2 section to 2.3, right?

"WARNING: Calling tst_brk() in test 'cleanup()' does not exit the test as well
and 'TBROK' is converted to 'TWARN'."

> Kind regards,
> Petr
> 

