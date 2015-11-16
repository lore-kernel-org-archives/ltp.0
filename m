From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Nov 2015 17:31:10 +0100
Subject: [LTP] [PATCH v3] commands/mkswap: Added new testcase to test
 mkswap(8).
In-Reply-To: <1447316635-22076-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <56440923.8000609@cn.fujitsu.com>
 <1447316635-22076-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20151116163110.GG17888@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +TCID=mkswap01
> +TST_TOTAL=10
> +. test.sh
> +
> +setup()
> +{
> +	tst_require_root
> +
> +	tst_check_cmds blkid blockdev free mkswap
                        ^
			uuidgen is missing here

> +	tst_tmpdir
> +
> +	TST_CLEANUP=cleanup
> +
> +	tst_acquire_device
> +
> +	UUID=`uuidgen`
> +
> +	DEVICE_SIZE=$((`blockdev --getsize64 $TST_DEVICE`/1024))
> +
> +	PAGE_SIZE=`getconf PAGE_SIZE`
> +}
> +
> +cleanup()
> +{
> +	tst_release_device
> +
> +	tst_rmdir
> +}
> +
> +mkswap_verify()
> +{
> +	local mkswap_op=$1
> +	local op_arg=$2
> +	local device=$3
> +	local size=$4
> +
> +	local ret=0
> +
> +	local before=`free | grep "Swap" | awk '{print $2}'`

We can do better with:

awk '/SwapTotal/ {print $2}' /proc/meminfo

No need to call free and no need to use grep :).

> +	local swapsize=${4:-$DEVICE_SIZE}
> +
> +	if [ "$mkswap_op" = "-p" ]; then
> +		local pagesize=$op_arg
> +	else
> +		local pagesize=$PAGE_SIZE
> +	fi
> +
> +	if [ "$mkswap_op" = "-L" ] || [ "$mkswap_op" = "-U" ]; then
> +		local swapfile=$op_arg
> +	else
> +		mkswap_op=
> +		local swapfile=$device
> +	fi

Can you actually pass the device for the test instead of passing
$TST_DEVICE which is kind of pointles when you can use $TST_DEVICE in
the mkswap_test() for the mkswap command?

> +	swapon $mkswap_op $swapfile 2>/dev/null
> +	if [ $? -ne 0 ]; then
> +		tst_resm TINFO "Can not do swapon on $swapfile."
> +		if [ $pagesize -ne $PAGE_SIZE ]; then
> +			tst_resm TINFO "Page size specified by 'mkswap -p' \
> +is not equal to system's page size."
> +			tst_resm TINFO "Swapon failed expectedly."
> +			return $ret
                              ^
                        Just do return 0 here, it's more confusing as
			it should be as this is.
> +		fi
> +
> +		if [ $swapsize -gt $DEVICE_SIZE ]; then
> +			tst_resm TINFO "Device size specified by 'mkswap' \
> +greater than real size."
> +			tst_resm TINFO "Swapon failed expectedly."
> +			return $ret

Here as well.

> +		fi
> +
> +		tst_resm TINFO "Swapon failed unexpectedly."
> +		return 1
> +	fi
> +
> +	local after=`free | grep "Swap" | awk '{print $2}'`

Here you can simplify the command as well.

> +	local est=16

You shoud intialize the ret=0 here.

> +	if [ $((after-before)) -lt $((swapsize-pagesize/1024-est)) ] || \
> +		[ $((after-before)) -gt $((swapsize-pagesize/1024+est)) ]; then
> +		ret=1
> +	fi

What is the story behind the est? It should probably be worth comment
when the size could be 16kB off or at least on which system does this
happens.

And I would compute the difference only once and store it to a variable,
but that is minor.

> +	swapoff $mkswap_op $swapfile 2>/dev/null
> +	if [ $? -ne 0 ]; then
> +		tst_resm TINFO "Can not do swapoff on $swapfile."
> +	fi
> +
> +	return $ret

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
