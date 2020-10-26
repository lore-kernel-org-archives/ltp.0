From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2020 08:06:41 +0100
Subject: [LTP] [PATCH 3/5] network/virt: skip setting neighbour table if
 tunnel doesn't have hwaddr
In-Reply-To: <20201015122056.20715-3-alexey.kodanev@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
 <20201015122056.20715-3-alexey.kodanev@oracle.com>
Message-ID: <20201026070641.GD21306@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

good idea.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index 80b9bcc90..f62120347 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -229,10 +229,13 @@ virt_minimize_timeout()
>  	local mac_loc="$(cat /sys/class/net/ltp_v0/address)"
>  	local mac_rmt="$(tst_rhost_run -c 'cat /sys/class/net/ltp_v0/address')"

> -	ROD_SILENT "ip ne replace $ip_virt_remote lladdr \
> -		    $mac_rmt nud permanent dev ltp_v0"
> -	tst_rhost_run -s -c "ip ne replace $ip_virt_local lladdr \
> -			     $mac_loc nud permanent dev ltp_v0"
> +	if [ "$mac_loc" ]; then
NOTE: I guess it's safe to check only $mac_rmt (and not $mac_rmt)

> +		ROD_SILENT "ip ne replace $ip_virt_remote lladdr \
> +			    $mac_rmt nud permanent dev ltp_v0"
> +		tst_rhost_run -s -c "ip ne replace $ip_virt_local lladdr \
> +				     $mac_loc nud permanent dev ltp_v0"
> +	fi
> +
>  	virt_tcp_syn=$(sysctl -n net.ipv4.tcp_syn_retries)
>  	ROD sysctl -q net.ipv4.tcp_syn_retries=1
>  }

Kind regards,
Petr
