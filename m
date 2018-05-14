From: Anton Smorodskyi <asmorodskyi@suse.de>
Date: Mon, 14 May 2018 12:42:19 +0200
Subject: [LTP] [PATCH 1/1] ipneigh : Use new API
In-Reply-To: <20180514090718.32507-1-asmorodskyi@suse.com>
References: <20180514090718.32507-1-asmorodskyi@suse.com>
Message-ID: <dd054c34-b01b-6039-724c-aebdbe9ef0f9@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

please ignore this one , I sent updated version but due to my newbie 
skills with "git send-email" it sent it as separate patch.


sorry for inconvenience


On 05/14/2018 11:07 AM, Anton Smorodskyi wrote:
> Besides all obvious changes for moving to new API,
> also was done :
> 1. more generic variable names
> 2. add check for del command failure
> ---
>   testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 63 ++++++++++++-------------
>   1 file changed, 30 insertions(+), 33 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index 9af3aa31e..c2d03a565 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -18,8 +18,8 @@
>   
>   TCID=ipneigh01
>   NUMLOOPS=${NUMLOOPS:-50}
> -TST_TOTAL=2
> -TST_USE_LEGACY_API=1
> +TST_TESTFUNC=do_test
> +TST_CNT=2
>   . tst_net.sh
>   
>   do_setup()
> @@ -30,55 +30,52 @@ do_setup()
>   
>   do_test()
>   {
> -	local arp_show_cmd="$1"
> -	local arp_del_cmd="$2"
> +	local rhost=$(tst_ipaddr rhost)
> +	case $1 in
> +	1)
> +		local show_cmd="ip neigh show"
> +		local del_cmd="ip neigh del $rhost dev $(tst_iface)"
> +	;;
> +	2)
> +		if [ -n "$TST_IPV6" ] then
> +			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
> +		fi
> +		local show_cmd="arp -a"
> +		local del_cmd="arp -d $rhost"
> +	;;
> +	esac
>   
>   	local entry_name
>   	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
>   
> -	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
> -	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
> -	tst_resm TINFO "with '$arp_del_cmd'"
> +	tst_res TINFO "Stress auto-creation of $entry_name cache entry"
> +	tst_res TINFO "by pinging '$rhost' and deleting entry again"
> +	tst_res TINFO "with '$del_cmd'"
>   
>   	for i in $(seq 1 $NUMLOOPS); do
>   
>   		ping$TST_IPV6 -q -c1 $rhost > /dev/null
>   
>   		local k
> -		local ret=1
> -		# wait for arp entry at least 3 seconds
>   		for k in $(seq 1 30); do
> -			$arp_show_cmd | grep -q $rhost
> -			if [ $? -eq 0 ]; then
> -				ret=0
> -				break;
> +			$show_cmd | grep -q $rhost
> +			if [ $? -ne 0 ]; then
> +				tst_brk TFAIL "$entry_name entry '$rhost' not listed"
>   			fi
>   			tst_sleep 100ms
>   		done
>   
> -		[ "$ret" -ne 0 ] && \
> -			tst_brkm TFAIL "$entry_name entry '$rhost' not listed"
> +		$del_cmd
> +		if [ $? -ne 0 ]; then
> +			tst_brk TFAIL "fail to delete entry"
> +		fi
>   
> -		$arp_del_cmd
> -
> -		$arp_show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
> -			tst_brkm TFAIL "'$arp_del_cmd' failed, entry has " \
> +		$show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
> +			tst_brk TFAIL "'$del_cmd' failed, entry has " \
>   				       "$(tst_hwaddr rhost)' $i/$NUMLOOPS"
>   	done
>   
> -	tst_resm TPASS "verified adding/removing of $entry_name cache entry"
> +	tst_res TPASS "verified adding/removing of $entry_name cache entry"
>   }
>   
> -do_setup
> -
> -rhost=$(tst_ipaddr rhost)
> -
> -if [ -z "$TST_IPV6" ]; then
> -	do_test "arp -a" "arp -d $rhost"
> -else
> -	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
> -fi
> -
> -do_test "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
> -
> -tst_exit
> +tst_run
> \ No newline at end of file

-- 
Anton Smorodskyi <asmorodskyi@suse.com>
QA Engineer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 Nürnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard,
Graham Norton, HRB 21284 (AG Nürnberg)

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180514/a4c5e164/attachment.html>
