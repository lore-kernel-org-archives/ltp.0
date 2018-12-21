From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 21 Dec 2018 15:27:20 +0000
Subject: [LTP] [PATCH v2 1/4] cgroup_regression_test.sh ported to newlib
In-Reply-To: <20181221143507.GB27446@dell5510>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181220182149.48326-2-cristian.marussi@arm.com>
 <20181221143507.GB27446@dell5510>
Message-ID: <d5a4fb0d-ca6f-d0e5-0016-af83c32930a3@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

On 21/12/2018 14:35, Petr Vorel wrote:
> Hi Cristian,
> 
> ...
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> ...
>> -cd $LTPROOT/testcases/bin
> You left this even after second commit. It's not needed.

because I misunderstood your indication in the previous mail

>> * Remove absolute (/bin/kill) and relative paths and cd into
$LTPROOT/testcases/bin

getting it like "remove A and remove B AND then CD into..." o.O

my bad ...:D I'll fix it

> 
>> +TST_TESTFUNC=do_test
>> +TST_SETUP=do_setup
>> +TST_CLEANUP=do_cleanup
>> +TST_CNT=10
>> +TST_NEEDS_ROOT=1
>> +TST_NEEDS_CMDS="dmesg mountpoint mount umount cat kill find mkdir rmdir grep"
> Test needs also using temporary directory (as it creates directories):
> TST_NEEDS_TMPDIR=1

Fine. I missed that.

> 
> 
>> -export TCID="cgroup_regression_test"
>> -export TST_TOTAL=10
>> -export TST_COUNT=1
>> +. tst_test.sh
> 
>> -failed=0
>> +do_setup()
>> +{
>> +	cd $LTPROOT/testcases/bin
> And here.
> 
o.O

> ...
>> +do_cleanup()
>> +{
>> +	cd $LTPROOT/testcases/bin
> One more time.
> 
o.O

> ...
>> -for ((cur = 1; cur <= $TST_TOTAL; cur++))
>> +do_test()
>>  {
>> -	export TST_COUNT=$cur
>> +	local cur=$1
> 
>>  	test_$cur
>>  }
> 
> do_test() function is not needed at all, looping can be done automatically:
> Remove underscore from test functions (s/test_([0-9]+)/test$1/)
> and change setup: TST_TESTFUNC=test
> 
> See
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#user-content-2-3-1-basic-test-interface
> 
Sure.

> 
> Kind regards,
> Petr
> 

Regards

Cristian
