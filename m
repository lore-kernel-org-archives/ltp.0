From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Dec 2016 13:47:32 +0300
Subject: [LTP] [PATCH 1/3] test_net.sh: fix netns when defined
 LHOST_IFACES or RHOST_IFACES
In-Reply-To: <20161221230422.26696-1-pvorel@suse.cz>
References: <20161221230422.26696-1-pvorel@suse.cz>
Message-ID: <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 12/22/2016 02:04 AM, Petr Vorel wrote:
> Tested with:
> TST_USE_NETNS=1 LHOST_IFACES=localpeer RHOST_IFACES=remotepeer \
>    ./testscripts/network.sh -6

Any good reason to do that?

Thanks,
Alexey

>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/lib/test_net.sh | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index f5321d73a..7d82e8962 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -22,15 +22,15 @@
>   
>   init_ltp_netspace()
>   {
> +	LHOST_IFACES=${LHOST_IFACES:-"ltp_ns_veth2"}
> +	RHOST_IFACES=${RHOST_IFACES:-"ltp_ns_veth1"}
> +
>   	if [ ! -f /var/run/netns/ltp_ns ]; then
>   		ROD ip net add ltp_ns
> -		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
> -		ROD ip li set dev ltp_ns_veth1 netns ltp_ns
> +		ROD ip li add name $RHOST_IFACES type veth peer name $LHOST_IFACES
> +		ROD ip li set dev $RHOST_IFACES netns ltp_ns
>   	fi
>   
> -	LHOST_IFACES=${LHOST_IFACES:-"ltp_ns_veth2"}
> -	RHOST_IFACES=${RHOST_IFACES:-"ltp_ns_veth1"}
> -
>   	export TST_INIT_NETNS="no"
>   	export LTP_NETNS=${LTP_NETNS:-"ip netns exec ltp_ns"}
>   

