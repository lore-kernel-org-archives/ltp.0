From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jun 2017 20:39:08 +0200
Subject: [LTP] [RFC PATCH v6 0/2] *** Rmmod causes failures of netns
 based tests ***
In-Reply-To: <4f361d07-3ee7-2b6b-8775-3641dcc30bf1@oracle.com>
References: <20170616015652.11169-1-pvorel@suse.cz>
 <66ae64fd-d7e2-45cc-002e-8c952ae68579@oracle.com>
 <4f361d07-3ee7-2b6b-8775-3641dcc30bf1@oracle.com>
Message-ID: <20170616183908.eh2k7gxni76vdv3a@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> diff --git a/testcases/network/dhcp/dhcp_lib.sh
> b/testcases/network/dhcp/dhcp_lib.sh
> index 85f9b88..5001232 100755
> --- a/testcases/network/dhcp/dhcp_lib.sh
> +++ b/testcases/network/dhcp/dhcp_lib.sh
> @@ -40,8 +40,7 @@ init()
>         tst_require_root
>         tst_check_cmds cat $dhcp_name awk ip pgrep pkill dhclient

> -       veth_loaded=
> -       lsmod | grep -q '^veth ' && veth_loaded=1
> +       lsmod | grep -q '^veth ' && veth_loaded=yes || veth_loaded=no

>         tst_resm TINFO "create veth interfaces"
>         ip li add $iface0 type veth peer name $iface1 || \
> @@ -68,6 +67,8 @@ init()

>  cleanup()
>  {
> +       [ -z "$veth_loaded" ] && return
> +
>         stop_dhcp



        stop_dhcp
+
+       [ -z "$veth_loaded" ] && return


>         pkill -f "dhclient -$ipv $iface1"
> @@ -81,9 +82,7 @@ cleanup()

>         [ $veth_added ] && ip li del $iface0

> -       if [ -z $veth_loaded ]; then
> -               lsmod | grep -q '^veth ' && rmmod veth
> -       fi
> +       [ "$veth_loaded" = "no" ] && lsmod | grep -q '^veth ' && rmmod veth

>         tst_rmdir
>  }

Thank you for a quick fix. This looks good, just one thing: I suppose stop_dhcp in
cleanup() must be run before return.

Could you please push it?

Sorry for putting wrong version (v6) in subject.

Kind regards,
Petr
