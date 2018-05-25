From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 25 May 2018 11:42:04 +0200
Subject: [LTP] [RFC PATCH v4 4/4] tst_test.sh: Add TST_TEST_DATA and
 TST_TEST_DATA_IFS
In-Reply-To: <20180524152129.1067-4-pvorel@suse.cz>
References: <20180524152129.1067-1-pvorel@suse.cz>
 <20180524152129.1067-4-pvorel@suse.cz>
Message-ID: <20180525094204.GA1314@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +[source,sh]
> +-------------------------------------------------------------------------------
> +#!/bin/sh
> +#
> +# Example test with tests in a single function, using $TST_TEST_DATA and
> +# $TST_TEST_DATA_IFS
> +#
> +
> +TST_TESTFUNC=do_test
> +TST_TEST_DATA="foo:bar:d dd"
> +TST_TEST_DATA_IFS=":"
> +. tst_test.sh
> +
> +do_test()
> +{
> +	tst_res TPASS "Test $1 passed with data '$2'"
> +}
> +
> +tst_run
> +# output:
> +# test 1 TPASS: Test 1 passed with data 'foo'
> +# test 2 TPASS: Test 2 passed with data 'bar'
> +# test 3 TPASS: Test 3 passed with data 'd dd'
                        ^
			These should be now just 1 for all three tests,
			since it is the actual number of the test not
			position in the test data array, I guess that we
			may pass that in $3 if ever needed.
> +-------------------------------------------------------------------------------
> +
> +It's possible to pass data for function with '$TST_TEST_DATA'. Optional
> +'$TST_TEST_DATA_IFS' is used for splitting, default value is space.
> +
> +[source,sh]
> +-------------------------------------------------------------------------------
> +#!/bin/sh
> +#
> +# Example test with tests in a single function, using $TST_TEST_DATA and $TST_CNT
> +#
> +
> +TST_TESTFUNC=do_test
> +TST_CNT=2
> +TST_TEST_DATA="foo bar"
> +. tst_test.sh
> +
> +do_test()
> +{
> +	case $1 in
> +	1) tst_res TPASS "Test $1 passed with data '$2'";;
> +	2) tst_res TPASS "Test $1 passed with data '$2'";;
> +	esac
> +}
> +
> +tst_run
> +# output:
> +# test 1 TPASS: Test 1 passed with data 'foo'
> +# test 2 TPASS: Test 2 passed with data 'bar'

Shouldn't this now be?

# test 1 TPASS: Test 1 passed with data 'foo'
# test 2 TPASS: Test 2 passed with data 'foo'
# test 1 TPASS: Test 1 passed with data 'bar'
# test 2 TPASS: Test 2 passed with data 'bar'

> +-------------------------------------------------------------------------------
> +When '$TST_TEST_DATA' is used with '$TST_CNT', it's passed as whole string in
                                                      ^
						      This is no longer
						      true right?


> +'$2' ($1 is for the test number), '$TST_TEST_DATA_IFS' for splitting is not
> +specified, therefore using space as the default value. Similar it would be
> +using these variables with separate functions.
> +
>  2.3.2 Library variables
>  ^^^^^^^^^^^^^^^^^^^^^^^
>  
> @@ -1587,8 +1648,8 @@ these can be listed with passing help '-h' option to any test.
>  The function that prints the usage is passed in '$TST_USAGE', the help for
>  the options implemented in the library is appended when usage is printed.
>  
> -Lastly the fucntion '$PARSE_ARGS' is called with the option name in '$1' and,
> -if option has argument, its value in '$2'.
> +Lastly the fucntion '$PARSE_ARGS' is called with the option name in the '$1'
> +and, if option has argument, its value in the '$2'.
>  
>  [source,sh]
>  -------------------------------------------------------------------------------
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index cdcd33ced..34b2188ac 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -246,7 +246,7 @@ _tst_rescmp()
>  
>  tst_run()
>  {
> -	local _tst_i
> +	local _tst_i _tst_data
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
>  		for _tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> @@ -255,7 +255,7 @@ tst_run()
>  			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
>  			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
>  			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
> -			IPV6);;
> +			IPV6|TEST_DATA|TEST_DATA_IFS);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> @@ -352,27 +352,17 @@ tst_run()
>  
>  	#TODO check that test reports some results for each test function call
>  	while [ $TST_ITERATIONS -gt 0 ]; do
> -		if [ -n "$TST_CNT" ]; then
> -			if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
> -				for _tst_i in $(seq $TST_CNT); do
> -					local res=$(_tst_resstr)
> -					$TST_TESTFUNC$_tst_i
> -					_tst_rescmp "$res"
> -					TST_COUNT=$((TST_COUNT+1))
> -				done
> -			else
> -				for _tst_i in $(seq $TST_CNT); do
> -					local res=$(_tst_resstr)
> -					$TST_TESTFUNC $_tst_i
> -					_tst_rescmp "$res"
> -					TST_COUNT=$((TST_COUNT+1))
> -				done
> -			fi
> +		if [ -n "$TST_TEST_DATA" ]; then
> +			_tst_i=1
> +			tst_check_cmds cut
> +			while true; do
> +				tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
                                ^
				_tst_data here and below
> +				[ -z "$tst_data" ] && break
> +				_tst_run_tests "$tst_data"
> +				_tst_i=$((_tst_i+1))
> +			done
>  		else
> -			local res=$(_tst_resstr)
> -			$TST_TESTFUNC
> -			_tst_rescmp "$res"
> -			TST_COUNT=$((TST_COUNT+1))
> +			_tst_run_tests
>  		fi
>  		TST_ITERATIONS=$((TST_ITERATIONS-1))
>  	done
> @@ -380,6 +370,31 @@ tst_run()
>  	_tst_do_exit
>  }
>  
> +_tst_run_tests()
> +{
> +	local data="$1"
> +	local i

Shouldn't we prefix these two variables with _tst_ prefix as well?

> +	for i in $(seq ${TST_CNT:-1}); do
> +		if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
> +			_tst_run_test "$TST_TESTFUNC$i" $i "$data"
> +		else
> +			_tst_run_test "$TST_TESTFUNC" $i "$data"
> +		fi
> +	done
> +}
> +
> +_tst_run_test()
> +{
> +	local res=$(_tst_resstr)
> +	local fnc="$1"
> +	shift

And here as well, the _tst_ prefix?

> +	$fnc "$@"
> +	_tst_rescmp "$res"
> +	TST_COUNT=$((TST_COUNT+1))
> +}
> +
>  if [ -z "$TST_ID" ]; then
>  	_tst_filename=$(basename $0)
>  	TST_ID=${_tst_filename%%.*}
> @@ -404,6 +419,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>  		tst_brk TBROK "TST_TESTFUNC is not defined"
>  	fi
>  
> +	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
> +
>  	if [ -n "$TST_CNT" ]; then
>  		if ! tst_is_int "$TST_CNT"; then
>  			tst_brk TBROK "TST_CNT must be integer"
> -- 
> 2.16.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz
