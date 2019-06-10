From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 10 Jun 2019 17:06:46 +0800
Subject: [LTP] [PATCH v2] sysctl/sysctl02: Add new regression test for
 overflow file-max
In-Reply-To: <20190606114134.GB13068@rei.lan>
References: <1559817080-2991-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1559817930-2299-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190606114134.GB13068@rei.lan>
Message-ID: <5CFE1DA6.7010600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi cryil

> Hi!
> +{
> +	case $1 in
> +	1)sysctl_test_overflow ${check1};;
> +	2)sysctl_test_overflow ${check2};;
> +	3)sysctl_test_overflow ${check3};;
> +	4)sysctl_test_zero ${check4};;
> There is no point in having the numbers in check variables if we do case
> here, we can just pass it here.
OK. I will pass the number directly.

>> +	esac
>> +}
>> +
>> +sysctl_test_overflow()
>> +{
>> +	local old_value=$(cat "$dir""$name")
>> +
>> +	sysctl -w "fs.file-max"=$1>/dev/null 2>&1
>> +
>> +	local test_value=$(cat "$dir""$name")
>> +
>> +	echo ${test_value} |grep -q ${old_value}
>> +	if [ $? -eq 0 ]; then
>> +		tst_res TPASS "file-max overflow, reject it and keep old value."
>> +	else
>> +		tst_res TFAIL "file-max overflow and set it to ${test_value}."
>> +	fi
>> +	cleanup
>> +}
>> +
>> +sysctl_test_zero()
>> +{
>> +	sysctl -w "fs.file-max"=$1>/dev/null 2>&1
>> +	tst_res TINFO "if it doesn't report TPASS after 60s sleep, system crashes"
>> +	sleep 60
> What happens on the buggy kernel here?
>
> Does it crash reliably?
>
> It looks to me that reproducing this bug without KASAN enabled kernel
> would be really hard or even impossible, therefore the sleep here does
> not matter at all.
Yes.  It crashes always on my machine but not having crash log (under /var/crash) without CONFIF_KASAN, and it hangs when sleep 120s with CONFIG_KASAN=y.
I think it crashes or hangs because the file-max is equal to 0 and it causes some system services or daemons can not run normally. Test it makes no sense.

This is not what I want to test.  I only want to test whether trigger a KASAN error by setting 0.
I will send a v3 patch.

>> +	tst_res TPASS "file-max is set 0 and doesn't crash"
>> +}
>> +
>> +cleanup()
>> +{
>> +	sysctl -w "fs.""$name"=${orig_value}>/dev/null 2>&1
>> +}
>> +
>> +tst_run
>> -- 
>> 2.18.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



