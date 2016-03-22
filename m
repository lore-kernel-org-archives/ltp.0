From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 22 Mar 2016 16:34:52 +0300
Subject: [LTP] [PATCHv3 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <1458209056-18829-4-git-send-email-haliu@redhat.com>
References: <1458209056-18829-1-git-send-email-haliu@redhat.com>
 <1458209056-18829-4-git-send-email-haliu@redhat.com>
Message-ID: <56F149FC.4030604@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 03/17/2016 01:04 PM, Hangbin Liu wrote:
> Also check each msg_size in $ICMP_SIZE_ARRAY to make sure the connectvity.
>
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>   .../stress/icmp/uni-basic/icmp4-uni-basic01        | 160 ++++-----------------
>   1 file changed, 24 insertions(+), 136 deletions(-)
>
> diff --git a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01 b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
> index b78ac8f..7c23cc7 100644
> --- a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
> +++ b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
> @@ -42,17 +42,13 @@
>   #	Oct 19 2005 - Created (Mitsuru Chinen)
>   #
>   #-----------------------------------------------------------------------
> -# Uncomment line below for debug output.
> -#trace_logic=${trace_logic:-"set -x"}
> -$trace_logic
> -
>   # The test case ID, the test case count and the total number of test case
>   TCID=${TCID:-icmp4-uni-basic01}
>   TST_TOTAL=1
>   TST_COUNT=1
> -export TCID
> -export TST_COUNT
> -export TST_TOTAL
> +TST_CLEANUP="do_cleanup"
> +
> +. ipsec_lib.sh
>   
>   # Test description
>   tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions"
> @@ -61,9 +57,6 @@ tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending
>   LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
>   export LTPROOT
>   
> -# Check the environmanet variable
> -. check_envval || exit $TST_TOTAL
> -
>   # Dulation of the test [sec]
>   NS_DURATION=${NS_DURATION:-3600}      # 1 hour
>   

I'd remove defining these variables here... in the test. Weshouldhave 
them already
defined in network.sh or it could be done in test_net.sh in case we're 
not going to
runnetwork.sh.

> @@ -72,6 +65,7 @@ LINK_NUM=${LINK_NUM:-0}
>   
>   # The version of IP
>   IP_VER=${IP_VER:-4}
> +[ $IP_VER -eq 6 ] && TST_IPV6=6
>   

just "ipv=${TST_IPV6:-4}" instead of two lines.

>   # true, if ipsec is used
>   DO_IPSEC=${DO_IPSEC:-false}
> @@ -100,16 +94,8 @@ ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
>   #-----------------------------------------------------------------------
>   do_cleanup()
>   {
> -    # Kill the icmp traffic server
> -    killall_icmp_traffic
> -
>       # Unset SAD/SPD
> -    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
> -    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
> -
> -    # Clean up each interface
> -    initialize_if lhost ${LINK_NUM}
> -    initialize_if rhost ${LINK_NUM}
> +    tst_ipsec flush
> }

TST_CLEANUP=tst_ipsec_cleanup

>   @@ -127,10 +113,9 @@ tst_resm TINFO "- Version of IP is IPv${IP_VER}"
>   tst_resm TINFO "- Size of packets are ( $ICMP_SIZE_ARRAY )"
>   
>   if $DO_IPSEC ; then
> -    message=`check_setkey`
> +    message=`ip xfrm state`
>       if [ $? -ne 0 ]; then
> -	tst_resm TBROK "$message"
> -	exit 1
> +	tst_brkm TBROK "$message"
>       fi
>   
>       case $IPSEC_PROTO in
> @@ -147,16 +132,14 @@ if $DO_IPSEC ; then
>   fi
>   
>   # name of interface of the local/remote host
> -lhost_ifname=`get_ifname lhost $LINK_NUM`
> +lhost_ifname=`tst_iface lhost $LINK_NUM`
>   if [ $? -ne 0 ]; then
> -    tst_resm TBROK "Failed to get the interface name at the local host"
> -    exit $TST_TOTAL
> +    tst_brkm TBROK "Failed to get the interface name at the local host"

These checks seems useless.

>   fi
>   
> -rhost_ifname=`get_ifname rhost $LINK_NUM`
> +rhost_ifname=`tst_iface rhost $LINK_NUM`
>   if [ $? -ne 0 ]; then
> -    tst_resm TBROK "Failed to get the interface name at the remote host"
> -    exit $TST_TOTAL
> +    tst_brkm TBROK "Failed to get the interface name at the remote host"
>   fi

Here as well.

>   
>   # Initialize the system configuration
> @@ -165,125 +148,30 @@ do_cleanup
>   # Call do_cleanup function before exit
>   trap do_cleanup 0
>   
> -# Configurate IP addresses
> -case $IP_VER in
> -    4)
> -    # Network portion of the IPv4 address
> -    network_part=${IPV4_NETWORK:-"10.0.0"}
> -
> -    # Netmask of the IPv4 network
> -    network_mask=24
> -
> -    # Host portion of the IPv4 address
> -    lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
> -    rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
> -
> -    # Set IPv4 addresses to the interfaces
> -    set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to add any IP address at the local host"
> -	exit 1
> -    fi
> -
> -    set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to add any IP address at the remote host"
> -	exit 1
> -    fi
> -
> -    # IPv4 address of the local/remote host
> -    lhost_addr="${network_part}.${lhost_host_part}"
> -    rhost_addr="${network_part}.${rhost_host_part}"
> -    ;;
> -
> -    6)
> -    # Network portion of the IPv6 address
> -    network_part="fd00:1:1:1"
> -
> -    # Netmask of the IPv6 network
> -    network_mask=64
> -
> -    # Host portion of the IPv6 address
> -    lhost_host_part=":2"     # local host
> -    rhost_host_part=":1"     # remote host
> -
> -    # Set IPv6 addresses to the interfaces
> -    add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to add any IP address at the local host"
> -	exit 1
> -    fi
> -
> -    add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to add any IP address at the remote host"
> -	exit 1
> -    fi
> -
> -    # IPv6 address of the local/remote host
> -    lhost_addr="${network_part}:${lhost_host_part}"
> -    rhost_addr="${network_part}:${rhost_host_part}"
> -    ;;
> -
> -    *)
> -    tst_resm TBROK "Unknown IP version"
> -    ;;
> -esac
> +lhost_addr=$(tst_ipaddr)
> +rhost_addr=$(tst_ipaddr rhost)
>   
>   # Configure SAD/SPD
>   if $DO_IPSEC ; then
> -    ipsec_log=`mktemp -p $TMPDIR`
> -
> -    output_ipsec_conf src \
> -	$IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
> -	    |  setkey -c 2>&1 | tee $ipsec_log
> -    if [ $? -ne 0 -o -s $ipsec_log ]; then
> -	tst_resm TBROK "Failed to configure SAD/SPD on the local host."
> -	rm -f $ipsec_log
> -	exit 1
> -    fi
> -
> -    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
> -    if [ $? -ne 0 -o -s $ipsec_log ]; then
> -	tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
> -	rm -f $ipsec_log
> -	exit 1
> -    fi
> -    rm -f $ipsec_log
> +    tst_ipsec src $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
> +    tst_ipsec dst $IPSEC_PROTO $IPSEC_MODE $SPI $rhost_addr $lhost_addr
>   fi
>   
> -# Make sure the connectvity
> -case $IP_VER in
> -    4)
> -    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	tst_resm TBROK "There is no IPv4 connectivity."
> -	exit 1
> -    fi
> -    ;;
> -
> -    6)
> -    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	tst_resm TBROK "There is no IPv6 connectivity."
> -	exit 1
> -    fi
> -    ;;
> -esac
> -
> -
>   #-----------------------------------------------------------------------
>   #
>   # Main
>   #
>   #
>   
> -# Run a client
> -$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-echoclient -S $lhost_addr -f $IP_VER -s \"$ICMP_SIZE_ARRAY\"" &
> -
> -sleep $NS_DURATION
> -killall_icmp_traffic
> -wait
> +# Make sure the connectvity
> +for msg_size in $ICMP_SIZE_ARRAY; do
> +    tst_ping $lhost_ifname $rhost_addr $msg_size
> +    if [ $? -ne 0 ]; then
> +        tst_brkm TBROK "There is no IPv$IP_VER connectivity with msg_size $msg_size"
> +    else
> +        tst_resm TPASS "There has IPv$IP_VER connectivity with msg_size $msg_size"
> +    fi
> +done


Is it really needed to ping with different message sizes? if yes, we 
couldadd this
functionality to tst_ping().

Best regards,
Alexey
