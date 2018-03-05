From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Mar 2018 00:55:55 +0100
Subject: [LTP] [RFC PATCH v2 3/3] test_net.sh: Add checks for external
	commands
In-Reply-To: <20180215204714.14597-3-pvorel@suse.cz>
References: <20180215204714.14597-1-pvorel@suse.cz>
 <20180215204714.14597-3-pvorel@suse.cz>
Message-ID: <20180305235555.y6aux2wzjhcvw7mb@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> Alexey, if you don't ack previous patch please accept at least this one.
> As it fixes some real problems (netstat has been removed from
> openSUSE/SUSE).
> ---
>  testcases/lib/test_net.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index fa06e0991..ffb646d87 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -472,8 +472,10 @@ tst_netload()

>  	local sock_cmd=
>  	if [ "$type" = "sctp" ]; then
> +		tst_check_cmds netstat
>  		sock_cmd="netstat -naS | grep $port | grep -q LISTEN"
>  	else
> +		tst_check_cmds ss
>  		sock_cmd="ss -ln$(echo $type | head -c1) | grep -q $port"
>  	fi

> @@ -525,11 +527,14 @@ tst_ping()
>  	local dst_addr="${2:-$(tst_ipaddr rhost)}"; shift $(( $# >= 2 ? 2 : 0 ))
>  	local msg_sizes="$*"
>  	local msg="tst_ping IPv${TST_IPV6:-4} iface $src_iface, msg_size"
> +	local cmd="ping$TST_IPV6"
>  	local ret=0

> +	tst_check_cmds $cmd
> +
>  	# ping cmd use 56 as default message size
>  	for size in ${msg_sizes:-"56"}; do
> -		ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr \
> +		$cmd -I $src_iface -c $PING_MAX $dst_addr \
>  			-s $size -i 0 > /dev/null 2>&1
>  		ret=$?
>  		if [ $ret -eq 0 ]; then

Rebased and pushed (just check for ping$TST_IPV6).


Kind regards,
Petr
