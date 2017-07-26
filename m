From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 26 Jul 2017 17:44:18 +0300
Subject: [LTP] [RFC PATCH v7 07/11] lib/test_net.sh: Add function
 reset_ltp_netspace()
In-Reply-To: <20170721040407.868-8-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-8-pvorel@suse.cz>
Message-ID: <46f0e647-8683-88b5-1ead-5287be4ae05d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 21.07.2017 7:04, Petr Vorel wrote:
> This function is useful when we know we broke netns (e.g. by unloading
> network driver).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 0cafe1514..cecb0bab2 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -42,7 +42,7 @@ init_ltp_netspace()
>  	export TST_INIT_NETNS="no"
>  
>  	pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
> -	export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
> +	export LTP_NETNS="ns_exec $pid net,mnt"

It is better to reset LTP_NETNS variable before calling
init_ltp_netspace in reset_ltp_netspace().

Thanks,
Alexey

>  
>  	tst_restore_ipaddr
>  	tst_restore_ipaddr rhost
> @@ -50,6 +50,18 @@ init_ltp_netspace()
>  	tst_wait_ipv6_dad
>  }
>  
> +# Force to reset netns.
> +reset_ltp_netspace()
> +{
> +	[ -n "$TST_USE_NETNS" ] || return
> +
> +	tst_resm TINFO "reset netns"
> +	ip link delete ltp_ns_veth2 2> /dev/null
> +	rm -f /var/run/netns/ltp_ns
> +	pkill ns_create
> +	init_ltp_netspace
> +}
> +
>  # Run command on remote host.
>  # Options:
>  # -b run in background


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170726/7e04e5c7/attachment.html>
