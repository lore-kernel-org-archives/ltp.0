From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Jun 2019 09:26:19 +0800
Subject: [LTP] [PATCH v3] sysctl/sysctl02: Add new regression test for
 overflow file-max
In-Reply-To: <20190620120122.GB31382@dell5510>
References: <20190606114134.GB13068@rei.lan>
 <1560156706-13617-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190620120122.GB31382@dell5510>
Message-ID: <5D0C323B.5020505@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi,
>
> LGTM, below are just small formatting issues.
> I'm going to merge it with these changes below.
>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   runtest/commands                      |  1 +
>>   testcases/commands/sysctl/sysctl02.sh | 96 +++++++++++++++++++++++++++
>>   2 files changed, 97 insertions(+)
>>   create mode 100755 testcases/commands/sysctl/sysctl02.sh
> ...
>> +sysctl_test_overflow()
>> +{
>> +	local old_value=$(cat "$dir""$name")
>> +
>> +	sysctl -w "fs.file-max"=$1>/dev/null 2>&1
>> +
>> +	local test_value=$(cat "$dir""$name")
> again, why 2 stings instead of one?
> local test_value=$(cat "$dir$name")
Hi Petr

  I use 2 strings because sysctl uses "fs.file-max" but cat uses "fs/file-max" file.
  Your big changes look good to me.  Thanks for your changes.

>> +
>> +	echo ${test_value} |grep -q ${old_value}
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TPASS "file-max overflow, reject it and keep old value."
> Please don't use dot
>
>> +	else
>> +		tst_res TFAIL "file-max overflow and set it to ${test_value}."
> Here as well.
>
>> +	fi
>> +	cleanup
>> +}
>> +
>> +sysctl_test_zero()
>> +{
>> +	sysctl -w "fs.file-max"=0>/dev/null 2>&1
> Please use -q option instead of redirecting.
>> +	[ ! -f "$syms_file" ]&&  tst_brk TCONF \
>> +		"$syms_file was not supported"
>> +	cat $syms_file  |grep kasan_report>/dev/null 2>&1
>> +	if [ $? -eq 0 ]; then
> Also grep has -q, no need to use pipe:
>
> if grep -q kasan_report $syms_file; then
>
>> +		dmesg | grep "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax">/dev/null
> -q here as well.
>
>> +		if [ $? -eq 0 ]; then
>> +			tst_res TFAIL "file-max is set 0 and trigger a KASAN error"
>> +		else
>> +			tst_res TPASS \
>> +				"file-max is set 0 and doesn't trigger a KASAN error"
> Probably can be on single line.
>
>> +		fi
>> +	else
>> +		tst_res TCONF "kernel doesn't support KASAN"
>> +	fi
>> +}
>> +
>> +cleanup()
>> +{
>> +	sysctl -w "fs.""$name"=${orig_value}>/dev/null 2>&1
> It's safe not quote string ($name is safe, but you can of course)
> sysctl -q -w fs.$name=$orig_value
>
>> +}
>> +
>> +tst_run
>
> .
>



