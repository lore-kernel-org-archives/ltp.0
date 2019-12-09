From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 9 Dec 2019 11:13:24 +0800
Subject: [LTP] [PATCH] cpuhotplug05.sh: Rewrite test case
In-Reply-To: <7b7c1e8a-1db1-bf9f-96ff-01803416120e@suse.cz>
References: <20191202101943.17335-1-ice_yangxiao@163.com>
 <7b7c1e8a-1db1-bf9f-96ff-01803416120e@suse.cz>
Message-ID: <31fe4c0c-863e-4ba6-d8d7-1af909013fb7@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Thanks for your comment.
Also sorry for the late reply.

On 12/4/19 11:11 PM, Martin Doucha wrote:
> On 12/2/19 11:19 AM, Xiao Yang wrote:
>> +do_test()
>> +{
> First of all, your patch changes the test scenario. The original
> scenario is this:
> (setup) Deactivate selected CPU
> 1. Check that load statistics are zero or empty for selected CPU
> 2. Activate selected CPU
> 3. Check that load statistics are valid for selected CPU
> 4. Deactivate selected CPU
> (cleanup) Activate selected CPU
>
> I have a few kernel builds where step 3 correctly detects regression.
>
> Your changed scenario looks like this:
> 1. Activate selected CPU
> 2. Check that load statistics are non-zero for selected CPU
> 3. Deactivate selected CPU
> 4. Check that load statistics are empty for selected CPU
> (cleanup) Return selected CPU back to original state
>
> Your new scenario has two problems:
>
> - You have to run at least two test loops to verify that reactivating a
> CPU doesn't break /proc/stat entries.

I think running cpuhotplug05.sh with -i 2 can verfiy this point.

Perhaps we can add -i option to runtest/cpuhotplug, or do you prefer to 
keep the original scenario?

>
> - You only check that load statistics are non-zero. This works with sar
> because the program already normalizes load statistics for you. But it
> won't detect the regression mentioned above because the bug sets one of
> the entries to something absurdly high. This will confuse sar enough to
> print all load values as 0 but it'll pass your checks.

Good point.

I will looking into the code of sar.

>
> In addition to checking that at least some values are non-zero, you need
> to check a few more things:
> - Call `getconf CLK_TCK` to find /proc/stat timer resolution
> - Calculate system uptime in seconds
> - Check that sum of all /proc/stat values for selected CPU is less than
> or equal to (timer resolution * (uptime+1))
I will try to add them as you suggested.
> - Also consider doing the above check for all CPUs to increase test
> coverage.

Is it necessary to add above check for all CPUs?

This test is designed to test specified CPU so you can test each CPU by 
using -c option.


Thanks,

Xiao Yang

>
>> +	for field in $(seq 2 11); do
>> +		field_value=$(grep "^cpu${cpu_num}" /proc/stat | awk "{print \$$field}")
>> +		[ "$field_value" != "0" ] && passed=1
>>   	done
>>   
>> -	if [ $check_passed -eq 0 ]; then
>> -		tst_resm TFAIL "No change in the CPU statistics"
>> -		tst_exit
>> +	if [ $passed -eq 0 ]; then
>> +		tst_res TFAIL \
>> +			"all field of online cpu{cpu_num} shows zero in /proc/stat"
>> +		return 1
>>   	fi
> It'd be better to write this check (including the upper bound check
> explained above) entirely in Awk.
>
> if ! awk "[test script]" /proc/stat; then
> 	tst_res TFAIL ...
> 	return 1
> fi
>

