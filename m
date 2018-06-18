From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 18 Jun 2018 17:29:17 +0300
Subject: [LTP] [PATCH 3/3] net/icmp: Unify log info messages
In-Reply-To: <20180614131558.18707-3-pvorel@suse.cz>
References: <20180614131558.18707-1-pvorel@suse.cz>
 <20180614131558.18707-3-pvorel@suse.cz>
Message-ID: <ba39e350-a6df-68fe-31a6-31141d689df6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/14/2018 04:15 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v2.
> ---

Hi Petr,

>  testcases/network/stress/icmp/icmp-uni-basic.sh | 5 +----
>  testcases/network/stress/icmp/icmp-uni-vti.sh   | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
> index fc84899dd..79581b46c 100755
> --- a/testcases/network/stress/icmp/icmp-uni-basic.sh
> +++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
> @@ -25,10 +25,7 @@ TST_CLEANUP="tst_ipsec_cleanup"
>  
>  . ipsec_lib.sh
>  
> -# Test description
> -tst_resm TINFO "Sending ICMP messages with the following conditions"
> -tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
> -tst_resm TINFO "- Size of packets are ( $IPSEC_SIZE_ARRAY )"
> +tst_resm TINFO "Sending ICMP messages">  
>  if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
>  	case $IPSEC_PROTO in

Probably better to fix the similar issue here with printing IPsec
protocol/mode type too, i.e. remove the above if block and print the
message in ipsec_lib.sh/tst_ipsec() instead, so it would be the same
as in tst_ipsec_setup_vti() now:

    tst_resm TINFO "Test vti$TST_IPV6 + IPsec[$IPSEC_PROTO/$IPSEC_MODE]"

> diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
> index 7fa211d7f..ea8b5c828 100755
> --- a/testcases/network/stress/icmp/icmp-uni-vti.sh
> +++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
> @@ -26,7 +26,7 @@ do_test()
>  {
>  	PING_MAX="$IPSEC_REQUESTS"
>  
> -	tst_resm TINFO "Sending ICMP messages..."
> +	tst_resm TINFO "Sending ICMP messages"
>  	tst_ping $tst_vti $ip_rmt_tun $IPSEC_SIZE_ARRAY
>  }
>  

The rest looks fine to me.

Thanks,
Alexey
