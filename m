From: Lei Li <rocklee_104@outlook.com>
Date: Mon, 9 Nov 2015 10:00:40 +0800
Subject: [LTP] [PATCH] commands/mkswap: Added new testcase to test
 mkswap(8).
In-Reply-To: <1446692628-12706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1446692628-12706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <BLU436-SMTP1923895FA6B242E57BC28CDCF150@phx.gbl>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +setup()
> +{
> +	tst_require_root
> +
> +	tst_check_cmds losetup free mkswap
> +
> +	tst_tmpdir
> +
> +	TST_CLEANUP=cleanup
> +
> +	tst_acquire_device
> +
> +	local path=`losetup -a | grep "$TMPDIR"  | awk '{print $3}' | \
> +		cut -d '(' -f2 | cut -d ')' -f1`
> +	DEVICE_SIZE=$((`ls -l $path | awk '{print $5}'`/1024))
Hi!
	This testcase uses a loop device instead of a block device, but 
tst_acquire_device may offer you a block device, /opt/ltp/runltp -b 
/dev/sdb1 for example, then, "path" may be invilidate, and syntax error 
occurs in the line :

DEVICE_SIZE=$((`ls -l $path | awk '{print $5}'`/1024))

So, examination whether the "path" is validate is necessary.

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
> +	local ret=0
> +
> +	local before=`free | grep "Swap" | awk '{print $2}'`
> +
> +	if [ -z "$4" ]; then
> +		local swapsize=$DEVICE_SIZE
> +	else
> +		local swapsize=$4
> +	fi
> +
> +	if [ "$1" = "-p" ]; then
> +		local pagesize=$2
> +	else
> +		local pagesize=$PAGE_SIZE
> +	fi
> +
> +	if [ "$1" = "-L" ]; then
> +		local swap_op="-L"
> +		local swapfile=$2
> +	elif [ "$1" = "-U" ]; then
> +		local swap_op="-U"
> +		local swapfile=$2
> +	else
> +		local swap_op=""
> +		local swapfile=$3
> +	fi
> +
> +	swapon $swap_op $swapfile 2>/dev/null
> +	if [ $? -ne 0 ]; then
> +		tst_resm TINFO "can not do swapon on $swapfile."
> +		if [ $pagesize -ne $PAGE_SIZE ]; then
> +			return $ret
> +		fi
> +
> +		if [ $swapsize -gt $DEVICE_SIZE ]; then
> +			return $ret
> +		fi
> +	fi
> +
> +	local after=`free | grep "Swap" | awk '{print $2}'`
> +
> +	local est=16
> +	if [ $((after-before)) -lt $((swapsize-pagesize/1024-est)) ] || \
> +		[ $((after-before)) -gt $((swapsize-pagesize/1024+est)) ]; then
> +		ret=1
> +	fi

How do you get this formula? I'm a newbie here :-)

> +
> +	swapoff $swap_op $swapfile 2>/dev/null
> +	if [ $? -ne 0 ]; then
> +		tst_resm TINFO "can not do swapoff on $swapfile."
> +	fi
> +
> +	return $ret
> +}
> +
> +mkswap_test()
> +{
> +	local mkswap_op=$1
> +	local op_arg=$2
> +	local device=$3
> +	local size=$4
> +
> +	local mkswap_cmd="mkswap $mkswap_op $op_arg $device $size"
> +
> +	${mkswap_cmd} >temp 2>&1
> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unknown option|invalid option|Usage" temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "'${mkswap_cmd}' not supported."
> +			return
> +		else
> +			tst_resm TFAIL "'${mkswap_cmd}' failed."
> +			cat temp
> +			return
> +		fi
> +	fi
> +
> +	if [ -n "$device" ]; then
> +		mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "'${mkswap_cmd}' failed, not expected."
> +			return
> +		fi
> +	fi
> +
> +	tst_resm TPASS "'${mkswap_cmd}' passed."
> +}
> +
> +test1()
> +{
> +	mkswap_test "" "" "$TST_DEVICE"
> +}
> +
> +test2()
> +{
> +	mkswap_test "" "" "$TST_DEVICE" "10000"
> +}
> +
> +test3()
> +{
> +	mkswap_test "-f" "" "$TST_DEVICE" "30000"
> +}
The size of loop device is 20000 currently, but there is no guarantee 
that value will not be changed in the future. "10000" and "30000" may be 
inappropriate at that time.In my opinion, it is more reasonable like this:

test2()
{
	mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"
}

test3()
{
	mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"
}
> +
> +test4()
> +{
> +	mkswap_test "-c" "" "$TST_DEVICE"
> +}
> +
> +test5()
> +{
> +	mkswap_test "-p" "2048" "$TST_DEVICE"
> +}
> +
> +test6()
> +{
> +	mkswap_test "-L" "testswap" "$TST_DEVICE"
> +}
> +
> +test7()
> +{
> +	mkswap_test "-v1" "" "$TST_DEVICE"
> +}
> +
> +test8()
> +{
> +	mkswap_test "-U" "ffffffff-ffff-ffff-ffff-ffffffffffff" "$TST_DEVICE"
> +}
> +
> +test9()
> +{
> +	mkswap_test "-V"
> +}
> +
> +test10()
> +{
> +	mkswap_test "-h"
> +}
> +
> +setup
> +
> +for i in $(seq 1 ${TST_TOTAL})
> +do
> +	test$i
> +done
> +
> +tst_exit
>

-- 
Rock Lee
rocklee_104@outlook.com
