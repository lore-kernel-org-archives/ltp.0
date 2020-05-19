From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 19 May 2020 07:05:08 +0200
Subject: [LTP] [PATCH 1/2] tst_test.sh: Fix calling not yet loaded
 cleanup function
In-Reply-To: <20200518130132.19312-1-pvorel@suse.cz>
References: <20200518130132.19312-1-pvorel@suse.cz>
Message-ID: <1a41aca6-f774-08da-bf7b-b33806b48923@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

>   	TST_DO_EXIT=1
>   
> -	if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
> +	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_RUN_STARTED" -a \
> +		-n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
In the description you write "[after] running either setup or test 
function". But this implementation
is "after running setup and test function". Cleanup should also be 
executed, if only setup was run right?
>   
> @@ -592,9 +594,11 @@ tst_run()
>   			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
>   			for _tst_i in $(seq $_tst_max); do
>   				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
> +				TST_RUN_STARTED=1
>   				_tst_run_tests "$_tst_data"
>   			done
>   		else
> +			TST_RUN_STARTED=1
>   			_tst_run_tests
>   		fi
Is it really important, that test is started? Shouldn't it be enough if 
we got to the point, where the test
could be started. Moving TST_RUN_STARTED out of the condition would 
reduce repetition.

J?rg
