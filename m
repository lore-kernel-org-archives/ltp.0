From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 20 Nov 2015 13:36:12 +0800
Subject: [LTP] [PATCH v4] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <20151119134112.GD28969@rei.lan>
References: <564A8F4B.4070504@cn.fujitsu.com>
 <1447837977-11734-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20151119134112.GD28969@rei.lan>
Message-ID: <564EB14C.7090906@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 2015/11/19 21:41, Cyril Hrubis wrote:
> Hi!
>> +	if [ "$mkswap_op" = "-L" ] || [ "$mkswap_op" = "-U" ]; then
>> +		local swapfile=$op_arg
>> +	else
>> +		mkswap_op=
>> +		local swapfile=$TST_DEVICE
>> +	fi
> 
> What I asked you to do is to pass either the label or uuid for -L and -U
> as $3 and $TST_DEVICE otherwise to the mkswap_test function. Then we can
> just pass it in mkswap_test to the verify function so that we do not
> have to do this ugly if. Ok?
> 
> Looking at the code we would have to actually pass "-L label" and
> "-U uuid" or $TST_DEVICE. But that would be way nicer than spreading ifs
> arounds.
> 

OK, I got it now, thanks!
Sorry for my misunderstanding...

Best Regards,
Guangwen Feng

>> +	swapon $mkswap_op $swapfile 2>/dev/null
>> +	if [ $? -ne 0 ]; then
>> +		tst_resm TINFO "Can not do swapon on $swapfile."
>> +		if [ $pagesize -ne $PAGE_SIZE ]; then
>> +			tst_resm TINFO "Page size specified by 'mkswap -p' \
>> +is not equal to system's page size."
>> +			tst_resm TINFO "Swapon failed expectedly."
>> +			return 0
>> +		fi
>> +
>> +		if [ $swapsize -gt $DEVICE_SIZE ]; then
>> +			tst_resm TINFO "Device size specified by 'mkswap' \
>> +greater than real size."
>> +			tst_resm TINFO "Swapon failed expectedly."
>> +			return 0
>> +		fi
>> +
>> +		tst_resm TINFO "Swapon failed unexpectedly."
>> +		return 1
>> +	fi
>> +
>> +	local after=`awk '/SwapTotal/ {print $2}' /proc/meminfo`
>> +
>> +	local diff=$((after-before))
>> +	local filesize=$((swapsize-pagesize/1024))
>> +
>> +	local ret=0
>> +
>> +	# In general, the swap increment by doing swapon should be equal to
>> +	# the device size minus a page size, however for some kernels, the
>> +	# increment we get is not exactly equal to that value, but is equal
>> +	# to the value minus an extra page size, e.g. on RHEL5.11GA.
>> +	if [ $diff -ne $filesize ] && \
>> +		[ $diff -ne $((filesize-pagesize/1024)) ]; then
>> +		ret=1
>> +	fi
> 
> This looks good now, thanks for the detailed description.
> 
>> +	swapoff $mkswap_op $swapfile 2>/dev/null
>> +	if [ $? -ne 0 ]; then
>> +		tst_resm TINFO "Can not do swapoff on $swapfile."
> 
>                          I would change this to TWARN so that we make
> 			 sure that tester would notice
> 			 the failure in test results.
> 
>> +	fi
>> +
>> +	return $ret
>> +}
> 
> 
> The rest looks good to me.
> 
