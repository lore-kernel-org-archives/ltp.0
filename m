From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 24 Jul 2017 18:57:50 +0300
Subject: [LTP] [RFC PATCH v7 03/11] network/stress: Simplify
 make_background_tcp_traffic usage
In-Reply-To: <20170721040407.868-4-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-4-pvorel@suse.cz>
Message-ID: <cc06aeac-fe9c-dc3d-232b-619b5143e44b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/21/2017 07:03 AM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/stress/interface/if-addr-adddel    | 6 +-----
>  testcases/network/stress/interface/if-addr-addlarge  | 6 +-----
>  testcases/network/stress/interface/if-mtu-change     | 7 ++-----
>  testcases/network/stress/interface/if-route-adddel   | 7 ++-----
>  testcases/network/stress/interface/if-route-addlarge | 6 +-----
>  testcases/network/stress/ns-tools/test_net_stress.sh | 2 ++
>  6 files changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
> index 42c2d5afa..3b1ab50bb 100644
> --- a/testcases/network/stress/interface/if-addr-adddel
> +++ b/testcases/network/stress/interface/if-addr-adddel
> @@ -53,10 +53,9 @@ test_body()
>  		return
>  	fi
>  
> -	make_background_tcp_traffic
> -
>  	local cnt=1
>  	while [ $cnt -le $NS_TIMES ]; do
> +		make_background_tcp_traffic
>  
>  		case $cmd_type in
>  		if_cmd)
> @@ -85,9 +84,6 @@ test_body()
>  
>  		cnt=$(($cnt + 1))
>  
> -		# Check the background TCP traffic
> -		pgrep -x netstress > /dev/null || make_background_tcp_traffic


Does 'make_background_tcp_traffic()' function check that background
traffic is not running already?


Thanks,
Alexey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170724/84692954/attachment.html>
