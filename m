From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 19 May 2020 08:44:56 +0200
Subject: [LTP] [PATCH 1/2] tst_test.sh: Fix calling not yet loaded
 cleanup function
In-Reply-To: <20200519063740.GA7756@dell5510>
References: <20200518130132.19312-1-pvorel@suse.cz>
 <1a41aca6-f774-08da-bf7b-b33806b48923@jv-coder.de>
 <20200519063740.GA7756@dell5510>
Message-ID: <eb30b7e2-fb61-cdcb-b24b-6deb5512f4a4@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>> Is it really important, that test is started? Shouldn't it be enough if we
>> got to the point, where the test
>> could be started. Moving TST_RUN_STARTED out of the condition would reduce
>> repetition.
> Well, if you look into the code, there is tst_require_cmds call in if clause,
> which should pass:
>
> 	#TODO check that test reports some results for each test function call
> 	while [ $TST_ITERATIONS -gt 0 ]; do
> 		if [ -n "$TST_TEST_DATA" ]; then
> 			tst_require_cmds cut tr wc
> 			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
> 			for _tst_i in $(seq $_tst_max); do
> 				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
> 				TST_RUN_STARTED=1
> 				_tst_run_tests "$_tst_data"
> 			done
> 		else
> 			TST_RUN_STARTED=1
> 			_tst_run_tests
> 		fi
> 		TST_ITERATIONS=$((TST_ITERATIONS-1))
> 	done

At this point setup was executed right? So if tst_require_cmds fails, it 
should execute cleanup, to
revert whatever setup did, no?
Oh I guess changing the condition to "setup run _or_ test run" will make 
this work.
But is there really a reason for having both variables? I guess the 
reason they exist at all is to ensure,
that the cleanup function is already defined. But that should be true, 
as soon as tst_run is executed.
So maybe one single variable that is set, when TST_RUN is executed is 
sufficient.
In my opinion the decision to execute of cleanup shouldn't be too 
complicated. The cleanup function
should be able to handle an abort anytime during test execution anyway. 
So it should be callable, as soon
as it is defined. At least when tst_run is executed, it should be ok to 
call cleanup.

J?rg
