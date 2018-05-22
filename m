From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 May 2018 12:42:20 +0200
Subject: [LTP] [RFC PATCH v2 1/2] tst_test.sh: Add TST_TEST_DATA and
 TST_TEST_DATA_IFS
In-Reply-To: <20180516161820.3077-2-pvorel@suse.cz>
References: <20180516161820.3077-1-pvorel@suse.cz>
 <20180516161820.3077-2-pvorel@suse.cz>
Message-ID: <20180522104220.GA27975@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  tst_run()
>  {
> -	local tst_i
> +	local tst_i tst_data
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
>  		for tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> @@ -255,7 +255,7 @@ tst_run()
>  			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
>  			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
>  			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
> -			IPV6);;
> +			IPV6|TEST_DATA|TEST_DATA_IFS);;
>  			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
>  			esac
>  		done
> @@ -352,18 +352,30 @@ tst_run()
>  			if type test1 > /dev/null 2>&1; then
>  				for tst_i in $(seq $TST_CNT); do
>  					local res=$(tst_resstr)
> -					$TST_TESTFUNC$tst_i
> +					$TST_TESTFUNC$tst_i $tst_i $TST_TEST_DATA
>  					tst_rescmp "$res"
>  					TST_COUNT=$((TST_COUNT+1))
>  				done
>  			else
>  				for tst_i in $(seq $TST_CNT); do
>  					local res=$(tst_resstr)
> -					$TST_TESTFUNC $tst_i
> +					$TST_TESTFUNC $tst_i $TST_TEST_DATA
>  					tst_rescmp "$res"
>  					TST_COUNT=$((TST_COUNT+1))
>  				done
>  			fi

So in this implementation we cannot use IFS to separate the arguments,
without that it's kind of useless as we can pass anything in global
variable anyway...

> +		elif [ -n "$TST_TEST_DATA" ]; then
> +			tst_i=1
> +			tst_check_cmds cut
> +			while true; do
> +				tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$tst_i)"
> +				[ -z "$tst_data" ] && break
> +				local res=$(tst_resstr)
> +				$TST_TESTFUNC $tst_i "$tst_data"
> +				tst_rescmp "$res"
> +				TST_COUNT=$((TST_COUNT+1))
> +				tst_i=$((tst_i+1))
> +			done
>  		else
>  			local res=$(tst_resstr)
>  			$TST_TESTFUNC
> @@ -400,6 +412,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>  		tst_brk TBROK "TST_TESTFUNC is not defined"
>  	fi

Uff, the maze of if conditions is getting out of hand a bit.

Why dont we move innter part of the while [ $TST_ITERATION -gt 0 ] loop
to a separate tst_run_tests() function and add the ability to pass data
in $1 there. Then we can do something as:

	while [ $TST_INTERATION -gt 0 ]; then
	      if [ -n $TST_TEST_DATA ]; then
	          for tst_data in ...; do
		      tst_run_tests "$tst_data"
		  done
	      else
	           tst_run_tests
	      fi
	done


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
