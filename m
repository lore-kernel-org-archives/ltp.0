From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 6 May 2020 17:18:23 +0300
Subject: [LTP] [PATCH v6 3/3] route: Increase default loop values
In-Reply-To: <20200429192340.14252-4-pvorel@suse.cz>
References: <20200429192340.14252-1-pvorel@suse.cz>
 <20200429192340.14252-4-pvorel@suse.cz>
Message-ID: <c408ffc1-9ba6-ac01-0de9-1726ee72d4a4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29.04.2020 22:23, Petr Vorel wrote:
> by introducing $ROUTE_CHANGE_IP for shell based tests (only these
> rewritten into new shell API) and $ROUTE_CHANGE_NETLINK with C Netlink
> API based tests.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh                               |  2 ++
>  testcases/network/stress/route/route-change-dst.sh     |  4 ++--
>  testcases/network/stress/route/route-change-gw.sh      | 10 ++++++++--
>  testcases/network/stress/route/route-change-if.sh      | 10 ++++++++--
>  .../network/stress/route/route-change-netlink-dst.sh   |  2 +-
>  .../network/stress/route/route-change-netlink-gw.sh    |  2 ++
>  .../network/stress/route/route-change-netlink-if.sh    |  1 +
>  testcases/network/stress/route/route-lib.sh            |  8 ++------
>  8 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 1ec03c738..011b62267 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -913,6 +913,8 @@ export UPLOAD_BIGFILESIZE="${UPLOAD_BIGFILESIZE:-2147483647}"
>  export UPLOAD_REGFILESIZE="${UPLOAD_REGFILESIZE:-1024}"
>  export MCASTNUM_NORMAL="${MCASTNUM_NORMAL:-20}"
>  export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-4000}"
> +export ROUTE_CHANGE_IP="${ROUTE_CHANGE_IP:-100}"
> +export ROUTE_CHANGE_NETLINK="${ROUTE_CHANGE_NETLINK:-10000}"

Hi Petr,

The changes are fine.

Perhaps for further improvements, ROUTE_CHANGE_NETLINK is limited by
"NUM_LOOPS_MAX 65535", it looks unnecessary. Can we limit the setup
only and iterate (adding and deleting) from the beginning or use -i
option with -c?

>  
>  # Warning: make sure to set valid interface names and IP addresses below.
>  # Set names for test interfaces, e.g. "eth0 eth1"
> diff --git a/testcases/network/stress/route/route-change-dst.sh b/testcases/network/stress/route/route-change-dst.sh
> index dcd2898a8..2d88b5f73 100755
> --- a/testcases/network/stress/route/route-change-dst.sh
> +++ b/testcases/network/stress/route/route-change-dst.sh
> @@ -12,11 +12,11 @@ TST_SETUP="setup"
>  TST_CLEANUP="route_cleanup"
>  TST_TESTFUNC="test_dst"
>  . route-lib.sh
> -TST_CNT=$NS_TIMES
> +TST_CNT=$ROUTE_CHANGE_IP
>  
>  setup()
>  {
> -	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
> +	tst_res TINFO "change IPv$TST_IPVER route destination $ROUTE_CHANGE_IP times"
>  }
>  
>  test_dst()
> diff --git a/testcases/network/stress/route/route-change-gw.sh b/testcases/network/stress/route/route-change-gw.sh
> index cfbc331ac..6c650befd 100755
> --- a/testcases/network/stress/route/route-change-gw.sh
> +++ b/testcases/network/stress/route/route-change-gw.sh
> @@ -8,11 +8,17 @@
>  # Change route gateway
>  # lhost: 10.23.1.1, gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
>  
> -TST_SETUP="setup_gw"
> +TST_SETUP="setup"
>  TST_CLEANUP="route_cleanup"
>  TST_TESTFUNC="test_gw"
>  . route-lib.sh
> -TST_CNT=$NS_TIMES
> +TST_CNT=$ROUTE_CHANGE_IP
> +
> +setup()
> +{
> +	tst_res TINFO "change IPv$TST_IPVER route gateway $ROUTE_CHANGE_IP times"
> +	setup_gw
> +}
>  
>  test_gw()
>  {
> diff --git a/testcases/network/stress/route/route-change-if.sh b/testcases/network/stress/route/route-change-if.sh
> index a32f5f3d9..7e9c15fe4 100755
> --- a/testcases/network/stress/route/route-change-if.sh
> +++ b/testcases/network/stress/route/route-change-if.sh
> @@ -8,11 +8,17 @@
>  # Change route interface
>  # lhost: 10.23.x.2, gw (on rhost): 10.23.x.1, rhost: 10.23.0.1, switching ifaces on lhost
>  
> -TST_SETUP="setup_if"
> +TST_SETUP="setup"
>  TST_CLEANUP="cleanup_if"
>  TST_TESTFUNC="test_if"
>  . route-lib.sh
> -TST_CNT=$NS_TIMES
> +TST_CNT=$ROUTE_CHANGE_IP
> +
> +setup()
> +{
> +	tst_res TINFO "change IPv$TST_IPVER route interface $ROUTE_CHANGE_IP times"
> +	setup_if
> +}
>  
>  test_if()
>  {
> diff --git a/testcases/network/stress/route/route-change-netlink-dst.sh b/testcases/network/stress/route/route-change-netlink-dst.sh
> index de558949d..0740d0963 100755
> --- a/testcases/network/stress/route/route-change-netlink-dst.sh
> +++ b/testcases/network/stress/route/route-change-netlink-dst.sh
> @@ -13,7 +13,7 @@ TST_TESTFUNC="test_netlink"
>  
>  setup()
>  {
> -	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
> +	tst_res TINFO "change IPv$TST_IPVER route destination $ROUTE_CHANGE_NETLINK times"
>  
>  	local cnt=0
>  	local gw rhost rhost_all rt
> diff --git a/testcases/network/stress/route/route-change-netlink-gw.sh b/testcases/network/stress/route/route-change-netlink-gw.sh
> index 46e544ef0..3119a1b31 100755
> --- a/testcases/network/stress/route/route-change-netlink-gw.sh
> +++ b/testcases/network/stress/route/route-change-netlink-gw.sh
> @@ -15,6 +15,8 @@ setup()
>  {
>  	local cnt=0
>  
> +	tst_res TINFO "change IPv$TST_IPVER route gateway $ROUTE_CHANGE_NETLINK times"
> +
>  	check_max_ip
>  	setup_gw
>  
> diff --git a/testcases/network/stress/route/route-change-netlink-if.sh b/testcases/network/stress/route/route-change-netlink-if.sh
> index ad4e3712c..d1e64a40e 100755
> --- a/testcases/network/stress/route/route-change-netlink-if.sh
> +++ b/testcases/network/stress/route/route-change-netlink-if.sh
> @@ -16,6 +16,7 @@ setup()
>  	local gw gw_all iface iface_all
>  	local cnt=0
>  
> +	tst_res TINFO "change IPv$TST_IPVER route interface $ROUTE_CHANGE_NETLINK times"
>  	setup_if
>  
>  	while [ $cnt -lt $(tst_get_ifaces_cnt) ]; do
> diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
> index 51803056a..a5bb96c12 100644
> --- a/testcases/network/stress/route/route-lib.sh
> +++ b/testcases/network/stress/route/route-lib.sh
> @@ -45,7 +45,7 @@ check_max_ip()
>  
>  	tst_is_int "$ROUTE_MAX_IP" || tst_brk TBROK "\$ROUTE_MAX_IP not int ($ROUTE_MAX_IP)"
>  	[ $ROUTE_MAX_IP -gt $max_ip_limit ] && ROUTE_MAX_IP=$max_ip_limit
> -	[ $ROUTE_MAX_IP -gt $NS_TIMES ] && ROUTE_MAX_IP=$NS_TIMES
> +	[ $ROUTE_MAX_IP -gt $ROUTE_CHANGE_NETLINK ] && ROUTE_MAX_IP=$ROUTE_CHANGE_NETLINK
>  }
>  
>  cleanup_if()
> @@ -63,8 +63,6 @@ route_cleanup()
>  
>  setup_gw()
>  {
> -	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
> -
>  	rt="$(tst_ipaddr_un -p 0 0)"
>  	lhost="$(tst_ipaddr_un 1 1)"
>  	rhost="$(tst_ipaddr_un 0 1)"
> @@ -74,8 +72,6 @@ setup_gw()
>  
>  setup_if()
>  {
> -	tst_res TINFO "change IPv$TST_IPVER route interface $NS_TIMES times"
> -
>  	rt="$(tst_ipaddr_un -p 0)"
>  	rhost="$(tst_ipaddr_un 0 1)"
>  	tst_add_ipaddr -s -q -a $rhost rhost
> @@ -99,7 +95,7 @@ test_netlink()
>  	local cmd ip_flag
>  	[ "$TST_IPV6" ] && ip_flag="-6"
>  
> -	cmd="route-change-netlink -c $NS_TIMES $ip_flag -p $ROUTE_RHOST_PORT $ROUTE_CHANGE_NETLINK_PARAMS"
> +	cmd="route-change-netlink -c $ROUTE_CHANGE_NETLINK $ip_flag -p $ROUTE_RHOST_PORT $ROUTE_CHANGE_NETLINK_PARAMS"
>  	tst_res TINFO "running $cmd"
>  	$cmd || ret=$?
>  	if [ "$ret" -ne 0 ]; then
> 

