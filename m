From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Dec 2016 14:57:49 +0300
Subject: [LTP] [PATCH 1/1] network: handle ping6 vs. ping -6
	compatibility
In-Reply-To: <20161221173148.25925-1-pvorel@suse.cz>
References: <20161221173148.25925-1-pvorel@suse.cz>
Message-ID: <ba1b4a08-b1bb-ca51-96d8-280b4fd92b39@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/21/2016 08:31 PM, Petr Vorel wrote:
> ping6 was merged into ping and removed in iputils-s20150815. Distros
> with older iputils version needs to define variable PING6_CMD=ping6
>
> TODO: handle $tping in testcases/kernel/containers/netns/netns_helper.sh
> (doesn't use test_net.sh).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> IMHO would be nice to have ping for IPv6 on one place.
> This will break old distros, which have iputils older than iputils-s20150815.
> Do we care (want default PING6_CMD be ping6)?

Didn't get the idea of the patch, is it a fix for the newer iputils 
packages?

Do you have a symlink to ping in the newer packages?

In OL7.3:

# ll $(which ping6)
lrwxrwxrwx. 1 root root 4 Nov  7 02:00 /usr/bin/ping6 -> ping

# rpm -q iputils
iputils-20160308-8.el7.x86_64

Thanks,
Alexey

> ---
>   testcases/lib/test_net.sh                       | 1 +
>   testcases/network/stress/ns-tools/ns-echoclient | 2 +-
>   testcases/network/tcp_cmds/ping/ping01.sh       | 9 +++++----
>   testcases/network/tcp_cmds/ping/ping02.sh       | 5 +++--
>   4 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 1d350fdd1..94872d186 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -426,6 +426,7 @@ export UPLOAD_BIGFILESIZE=${UPLOAD_BIGFILESIZE:-"2147483647"}
>   export UPLOAD_REGFILESIZE=${UPLOAD_REGFILESIZE:-"1024"}
>   export MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-"20"}
>   export MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-"40000"}
> +export PING6_CMD="${PING6_CMD:-ping -6}"
>   
>   [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
>   
> diff --git a/testcases/network/stress/ns-tools/ns-echoclient b/testcases/network/stress/ns-tools/ns-echoclient
> index 1f3187823..15e62876d 100644
> --- a/testcases/network/stress/ns-tools/ns-echoclient
> +++ b/testcases/network/stress/ns-tools/ns-echoclient
> @@ -120,7 +120,7 @@ case $family in
>       ping_command="ping"
>       ;;
>       6)
> -    ping_command="ping6"
> +    ping_command="$PING6_CMD"
>       ;;
>       *)
>       echo "protocol family should be 4 or 6."
> diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
> index 73f1180f5..7505cdedc 100755
> --- a/testcases/network/tcp_cmds/ping/ping01.sh
> +++ b/testcases/network/tcp_cmds/ping/ping01.sh
> @@ -35,17 +35,18 @@ do_setup()
>   	COUNT=${COUNT:-3}
>   	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
>   
> -	PING_CMD=ping${TST_IPV6}
> +	PING=ping
> +	[ "$TST_IPV6" ] && PING=$PING6_CMD
>   
> -	tst_check_cmds $PING_CMD
> +	tst_check_cmds $(echo $PING | sed 's/\([^ ]\+\).*/\1/')
>   }
>   
>   do_test()
>   {
> -	tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
> +	tst_resm TINFO "$PING with $PACKETSIZES ICMP packets"
>   	local ipaddr=$(tst_ipaddr rhost)
>   	for packetsize in $PACKETSIZES; do
> -		EXPECT_PASS $PING_CMD -c $COUNT -s $packetsize $ipaddr \>/dev/null
> +		EXPECT_PASS $PING -c $COUNT -s $packetsize $ipaddr \>/dev/null
>   	done
>   }
>   
> diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
> index 6a9878e42..47877476c 100755
> --- a/testcases/network/tcp_cmds/ping/ping02.sh
> +++ b/testcases/network/tcp_cmds/ping/ping02.sh
> @@ -24,9 +24,10 @@ do_setup()
>   	COUNT=${COUNT:-3}
>   	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
>   
> -	PING=ping${TST_IPV6}
> +	PING=ping
> +	[ "$TST_IPV6" ] && PING=$PING6_CMD
>   
> -	tst_check_cmds $PING
> +	tst_check_cmds $(echo $PING | sed 's/\([^ ]\+\).*/\1/')
>   }
>   
>   do_test()

