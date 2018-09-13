From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Sep 2018 15:41:05 +0800
Subject: [LTP] [PATCH] hotplug/cpu_hotplug05.sh: Fix obsolete output of
 offline CPU
In-Reply-To: <1531899217-27690-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1531899217-27690-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <5B9A1491.5070407@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Ping :-)

Thanks,
Xiao Yang
On 2018/07/18 15:33, Xiao Yang wrote:
> With sysstat-11.7.1, running cpu_hotplug05.sh got the following error:
> ---------------------------------------------------------------------
> cpuhotplug05 1 TBROK: Field 3 is '%user', '0.00' expected
> ---------------------------------------------------------------------
>
> According to commit 970cae1 and 1f71a6f, sar/sadf didn't display offline
> CPU since sysstat-11.7.1.  It is reasonable for offline CPU to get nothing.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh     | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index 59c8324..ab81684 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -108,12 +108,18 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
>  		tst_brkm TBROK "SAR output file is empty"
>  	fi
>  
> -	for i in $(seq 3 8); do
> -		field=$(get_field "$offline_status" "$i")
> -		if [ "$field" != "0.00" ]; then
> -			tst_brkm TBROK "Field $i is '$field', '0.00' expected"
> -		fi
> -	done
> +	cpu_field=$(get_field "$offline_status" "2")
> +	if [ "${cpu_field}" = "CPU" ]; then
> +		# Since sysstat-11.7.1, sar/sadf didn't display offline CPU
> +		tst_resm TINFO "SAR didn't display offline CPU"
> +	else
> +		for i in $(seq 3 8); do
> +			field=$(get_field "$offline_status" "$i")
> +			if [ "$field" != "0.00" ]; then
> +				tst_brkm TBROK "Field $i is '$field', '0.00' expected"
> +			fi
> +		done
> +	fi
>  
>  	# Online the CPU
>  	if ! online_cpu ${CPU_TO_TEST}; then



