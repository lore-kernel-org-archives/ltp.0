From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 4 Dec 2019 16:11:34 +0100
Subject: [LTP] [PATCH] cpuhotplug05.sh: Rewrite test case
In-Reply-To: <20191202101943.17335-1-ice_yangxiao@163.com>
References: <20191202101943.17335-1-ice_yangxiao@163.com>
Message-ID: <7b7c1e8a-1db1-bf9f-96ff-01803416120e@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/2/19 11:19 AM, Xiao Yang wrote:
> +do_test()
> +{

First of all, your patch changes the test scenario. The original
scenario is this:
(setup) Deactivate selected CPU
1. Check that load statistics are zero or empty for selected CPU
2. Activate selected CPU
3. Check that load statistics are valid for selected CPU
4. Deactivate selected CPU
(cleanup) Activate selected CPU

I have a few kernel builds where step 3 correctly detects regression.

Your changed scenario looks like this:
1. Activate selected CPU
2. Check that load statistics are non-zero for selected CPU
3. Deactivate selected CPU
4. Check that load statistics are empty for selected CPU
(cleanup) Return selected CPU back to original state

Your new scenario has two problems:

- You have to run at least two test loops to verify that reactivating a
CPU doesn't break /proc/stat entries.

- You only check that load statistics are non-zero. This works with sar
because the program already normalizes load statistics for you. But it
won't detect the regression mentioned above because the bug sets one of
the entries to something absurdly high. This will confuse sar enough to
print all load values as 0 but it'll pass your checks.

In addition to checking that at least some values are non-zero, you need
to check a few more things:
- Call `getconf CLK_TCK` to find /proc/stat timer resolution
- Calculate system uptime in seconds
- Check that sum of all /proc/stat values for selected CPU is less than
or equal to (timer resolution * (uptime+1))
- Also consider doing the above check for all CPUs to increase test
coverage.

> +	for field in $(seq 2 11); do
> +		field_value=$(grep "^cpu${cpu_num}" /proc/stat | awk "{print \$$field}")
> +		[ "$field_value" != "0" ] && passed=1
>  	done
>  
> -	if [ $check_passed -eq 0 ]; then
> -		tst_resm TFAIL "No change in the CPU statistics"
> -		tst_exit
> +	if [ $passed -eq 0 ]; then
> +		tst_res TFAIL \
> +			"all field of online cpu{cpu_num} shows zero in /proc/stat"
> +		return 1
>  	fi

It'd be better to write this check (including the upper bound check
explained above) entirely in Awk.

if ! awk "[test script]" /proc/stat; then
	tst_res TFAIL ...
	return 1
fi

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
