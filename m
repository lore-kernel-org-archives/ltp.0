From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Sep 2017 10:17:51 +0300
Subject: [LTP] [RFC PATCH v9 2/7] network/stress: Add library helper for
 stress testing
In-Reply-To: <20170824234436.18145-3-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-3-pvorel@suse.cz>
Message-ID: <b43be661-9e80-ca2a-66ce-f44b2499cca7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/25/2017 02:44 AM, Petr Vorel wrote:
> + use it in interface stress tests
>
> test_net_stress.sh:
> * test_net_stress.sh library is intended to be used throughout all
>   stress tests reduce duplicity and use code from test_net.sh where
>   possible instead of legacy scripts in testcases/network/stress/ns-tools/.
> * TCID set automatically from basename.
> * Add "unused network" related variables. So far used only IPv4 ones.
> * Functions from if-lib.sh moved and (and some renamed) to
>   test_net_stress.sh as they are going to be reused in other tests (not
>   just interface stress tests).
>
> Interfaces stress tests:
> * Interfaces tests use test_net_stress.sh.
> * Remove restore_ipaddr from cleanup functions as these functions would
>   break netns testing with RTNETLINK errors. Use them just in setup during
>   if-mtu-change where are really needed.

...

> diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
> index 637fa6389..03e6ba9d6 100644
> --- a/testcases/network/stress/interface/if-mtu-change
> +++ b/testcases/network/stress/interface/if-mtu-change
> @@ -18,9 +18,6 @@
>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
>  
>  TST_TOTAL=2
> -TCID=if-mtu-change
> -
> -. if-lib.sh
>  
>  TST_CLEANUP="do_cleanup"
>  
> @@ -33,9 +30,12 @@ CHANGE6_VALUES="1280 1445 1335 1390 1500 1280 1500 1280 1335 1500"
>  [ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
>  saved_mtu=
>  
> +. test_net_stress.sh
> +
> +

TST_IPV6 not defined in this case, sourced the library before the usage
of this variable.


> +
> +# Prefix of the Multicast Address
> +MCAST_IPV4_ADDR_PREFIX="224.10"
> +# Multicast Address
> +MCAST_IPV4_ADDR="${MCAST_IPV4_ADDR_PREFIX}.10.1"
> +
> +LINK_TOTAL=$(echo $LHOST_HWADDRS | wc -w)
> +RHOST_LINK_TOTAL=$(echo $RHOST_HWADDRS | wc -w)
> +[ $LINK_TOTAL -ne $RHOST_LINK_TOTAL ] && \
> +	tst_brkm TBROK "the number of element in LHOST_HWADDRS differs from RHOST_HWADDRS" \
> +	"($LINK_TOTAL vs. $RHOST_LINK_TOTAL," \
> +	"LHOST_HWADDRS: '$LHOST_HWADDRS' RHOST_HWADDRS: '$RHOST_HWADDRS')"

Didn't find the place where you need these variables. Are you going to
use them somewhere or they are here just for checking network configuration?

I've removed them and applied the patch.

Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170908/0a7d287b/attachment.html>
