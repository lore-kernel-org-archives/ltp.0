From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 9 Nov 2016 14:43:02 +0300
Subject: [LTP] [PATCH 1/1] network: portability: using tst_sleep instead
 of usleep
In-Reply-To: <20161108161351.16366-1-pvorel@suse.cz>
References: <20161108161351.16366-1-pvorel@suse.cz>
Message-ID: <58230BC6.8030608@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/08/2016 07:13 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/network/dhcp/dhcp_lib.sh              | 4 ++--
>   testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
> index 140619d..85f9b88 100755
> --- a/testcases/network/dhcp/dhcp_lib.sh
> +++ b/testcases/network/dhcp/dhcp_lib.sh
> @@ -26,12 +26,12 @@ stop_dhcp()
>   	while [ $count -le 10 ]; do
>   		pkill -x $dhcp_name
>   		[ "$(pgrep -x $dhcp_name)" ] || return 0
> -		usleep 100000
> +		tst_sleep 100ms
>   		count=$((count + 1))
>   	done
>   
>   	pkill -9 -x $dhcp_name
> -	usleep 100000
> +	tst_sleep 100ms
>   	[ "$(pgrep -x $dhcp_name)" ] && return 1 || return 0
>   }
>   
> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index 736d149..31d6cc6 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -52,7 +52,7 @@ do_test()
>   				ret=0
>   				break;
>   			fi
> -			usleep 100
> +			tst_sleep 100us

Patch applied. I've changed sleep time here to 'ms', it should have been 
"usleep 100000", so the patch is fixing it as well,
added comment about this in the patch.

Thanks,
Alexey

>   		done
>   
>   		[ "$ret" -ne 0 ] && \

