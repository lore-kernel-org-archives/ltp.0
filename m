From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Aug 2017 18:31:10 +0300
Subject: [LTP] [RFC PATCH v8 07/11] lib/test_net.sh: Add function
 reset_ltp_netspace()
In-Reply-To: <20170818164437.13556-8-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-8-pvorel@suse.cz>
Message-ID: <245506e0-b0a6-3066-a35f-ad5e7509e4fc@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/18/2017 07:44 PM, Petr Vorel wrote:
> This function is useful when we know we broke netns (e.g. by unloading
> network driver).
>
> It was necessary to introduce new variable LTP_NETNS_CUSTOM, as after
> resetting network namespace there is no way to reset LTP_NETNS variable
> for subsequent tests and therefore is (for non-custom variant) always
> needed to set it even if netns itself is setup.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index c4399f637..6c2fb6803 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -21,6 +21,16 @@
>  
>  [ -z "$TST_LIB_LOADED" ] && . test.sh
>  
> +set_ltp_netns_var()
> +{
> +	if [ -z "$LTP_NETNS_CUSTOM" ]; then
> +		pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
> +		export LTP_NETNS="ns_exec $pid net,mnt"
> +	else
> +		export LTP_NETNS="$LTP_NETNS_CUSTOM"
> +	fi
> +}
> +
>  init_ltp_netspace()
>  {
>  	local pid=
> @@ -41,8 +51,7 @@ init_ltp_netspace()
>  
>  	export TST_INIT_NETNS="no"
>  
> -	pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
> -	export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
> +	set_ltp_netns_var
>  
>  	tst_restore_ipaddr
>  	tst_restore_ipaddr rhost
> @@ -50,6 +59,18 @@ init_ltp_netspace()
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

Hmm, if there was custom netns you would break it anyway with this
function and change to LTP one.

I guess we should leave it unsupported for route rmmod test unless we
figure out the right solution.

Also, what if we reset only ltp veth pair, i.e.:

reset_ltp_netspace()
{
    ...
    [ "$(tst_iface)" != "ltp_ns_veth2" ] || return
    ip li del ltp_ns_veth2 2>/dev/null
}

init_ltp_netspace()
{
    ...

    pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
    export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"

    if ! ip li sh $LHOST_IFACES > /dev/null 2>&1; then
        ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
        ROD ns_ifmove ltp_ns_veth1 $pid
    fi
    ...
}

> +	init_ltp_netspace
> +}
> +
>  # Run command on remote host.
>  # Options:
>  # -b run in background
> @@ -636,7 +657,9 @@ export UPLOAD_REGFILESIZE="${UPLOAD_REGFILESIZE:-1024}"
>  export MCASTNUM_NORMAL="${MCASTNUM_NORMAL:-20}"
>  export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-4000}"
>  
> -[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
> +if [ -n "$TST_USE_NETNS" ]; then
> +	[ "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace || set_ltp_netns_var
> +fi

Best regards,
Alexey

