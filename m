From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Mar 2018 00:55:08 +0100
Subject: [LTP] [RFC PATCH v2 2/3] test_net.sh: Check for ip command
In-Reply-To: <20180215204714.14597-2-pvorel@suse.cz>
References: <20180215204714.14597-1-pvorel@suse.cz>
 <20180215204714.14597-2-pvorel@suse.cz>
Message-ID: <20180305235508.ik3fztkzllof6ntx@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> + remove this check from tests which uses test_net.sh.

> Check for ip is only added to init_ltp_netspace() (entry point for
> test_net.sh) and tst_restore_ipaddr() (the only used int tests).

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> Changed as we discuss it in december.
> http://lists.linux.it/pipermail/ltp/2017-December/006637.html
> ---
>  testcases/lib/test_net.sh                            | 6 ++++++
>  testcases/network/dctcp/dctcp01.sh                   | 2 +-
>  testcases/network/iproute/ip_tests.sh                | 2 +-
>  testcases/network/stress/ns-tools/test_net_stress.sh | 2 +-
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh      | 2 +-
>  testcases/network/xinetd/xinetd_tests.sh             | 2 +-
>  6 files changed, 11 insertions(+), 5 deletions(-)

> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 1e001f7c1..fa06e0991 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -23,6 +23,9 @@

>  init_ltp_netspace()
>  {
> +	tst_check_cmds ip
> +	tst_require_root
> +
>  	local pid=

>  	if [ ! -f /var/run/netns/ltp_ns ]; then
> @@ -352,6 +355,9 @@ tst_add_ipaddr()
>  # LINK: link number starting from 0. Default value is '0'.
>  tst_restore_ipaddr()
>  {
> +	tst_check_cmds ip
> +	tst_require_root
> +
>  	local type="${1:-lhost}"
>  	local link_num="${2:-0}"

> diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
> index d8d4eb9df..a92e41b2e 100755
> --- a/testcases/network/dctcp/dctcp01.sh
> +++ b/testcases/network/dctcp/dctcp01.sh
> @@ -49,7 +49,7 @@ setup()
>  	fi

>  	tst_require_root
> -	tst_check_cmds ip sysctl tc
> +	tst_check_cmds sysctl tc

>  	tst_resm TINFO "emulate congestion with packet loss 0.03% and ECN"
>  	tc qdisc add dev $(tst_iface) root netem loss 0.03% ecn > /dev/null 2>&1
> diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> index cb42e7a65..a9401412b 100755
> --- a/testcases/network/iproute/ip_tests.sh
> +++ b/testcases/network/iproute/ip_tests.sh
> @@ -33,7 +33,7 @@ init()
>  	tst_resm TINFO "inititalizing tests"
>  	tst_require_root
>  	tst_tmpdir
> -	tst_check_cmds cat awk ip diff
> +	tst_check_cmds cat awk diff

>  	iface=ltp_dummy
>  	lsmod | grep -q dummy || rm_dummy=1
> diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
> index 77f5797df..3cf9e5f05 100644
> --- a/testcases/network/stress/ns-tools/test_net_stress.sh
> +++ b/testcases/network/stress/ns-tools/test_net_stress.sh
> @@ -43,7 +43,7 @@ MCAST_IPV6_ADDR="${MCAST_IPV6_ADDR_PREFIX}:1"
>  netstress_setup()
>  {
>  	tst_require_root
> -	tst_check_cmds ip pgrep pkill
> +	tst_check_cmds pgrep pkill
>  	trap "tst_brkm TBROK 'test interrupted'" INT
>  }

> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index 99bab1621..c35443d04 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -24,7 +24,7 @@ TST_TOTAL=2
>  do_setup()
>  {
>  	tst_require_root
> -	tst_check_cmds ip arp grep ping$TST_IPV6
> +	tst_check_cmds arp grep ping$TST_IPV6
>  }

>  do_test()
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index fb4344837..8aa998875 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -29,7 +29,7 @@ setup()

>  	tst_tmpdir

> -	tst_check_cmds xinetd diff ip telnet
> +	tst_check_cmds xinetd diff telnet

>  	check_addr="127.0.0.1"
>  	ip a | grep -q inet6 && check_addr="$check_addr ::1"

Pushed.


Kind regards,
Petr
