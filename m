From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 22 Aug 2017 14:46:16 +0300
Subject: [LTP] [RFC PATCH v8 08/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <20170818164437.13556-9-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-9-pvorel@suse.cz>
Message-ID: <786265f7-ec89-e641-8fda-15f6844fb347@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 08/18/2017 07:44 PM, Petr Vorel wrote:
> * Fix test for netns based testing (route4-change-if requires to have
>   manually set another pair of interfaces).
> * Remove rsh dependency.
> * Create shell library route4-lib.sh (route IPv4 specific) to reduce
>   duplicity in tests. Library uses test_stress_net.sh (and therefore test_net.sh).
> * Stop using TST_COUNT, simplify TCID
> * Cleanup code, fix typos, update doc.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Tests using route_test_change() use background traffic instead of ns-udpsender
> but I fixed it that it uses route. Is it too much overhead? The reason is I'd

How do you use it to make a background traffic if you change route on
every loop iteration?

> like to get rid of all ugly scripts and binaries in
> testcases/network/stress/ns-tools, including ns-udpsender.c.

ns-udpsender can send a single UDP datagram over the new route without
waiting for answer but unfortunately we don't know for sure whether it
actually sent datagram and/or destination received it.

> ---
>  testcases/network/stress/route/00_Descriptions.txt |  23 +-
>  testcases/network/stress/route/route4-change-dst   | 283 ++---------------
>  testcases/network/stress/route/route4-change-gw    | 305 ++----------------
>  testcases/network/stress/route/route4-change-if    | 341 +++------------------
>  testcases/network/stress/route/route4-ifdown       | 284 +++--------------
>  testcases/network/stress/route/route4-lib.sh       | 145 +++++++++
>  testcases/network/stress/route/route4-redirect     | 223 +++-----------
>  testcases/network/stress/route/route4-rmmod        | 307 ++++---------------
>  testcases/network/stress/route/route6-change-dst   |   2 +-
>  9 files changed, 424 insertions(+), 1489 deletions(-)
>  create mode 100644 testcases/network/stress/route/route4-lib.sh
>

...



> -	    return 1
> +	local cmd_type=$1
> +	local cmd_name="$(get_cmd $cmd_type)"
> +	local cnt=0
> +	local cmd cmd2
> +
> +	if [ "$cmd_type" = 'ifconfig_cmd' ]; then
> +		cmd="$cmd_name $(tst_iface) down"
> +		cmd2="$cmd_name $(tst_iface) up"
> +	else
> +		cmd="$cmd_name link set down dev $(tst_iface)"
> +		cmd2="$cmd_name link set up dev $(tst_iface)"

This test-case looks like duplicate of if-updown


>  	fi
>  
> -	# Add the route
> -	case $test_type in
> -	    1)
> -	    route add -net $dst_network netmask 255.255.255.0 gw $rhost_ipv4addr dev $lhost_ifname
> -	    ;;
> -	    2)
> -	    ip route add ${dst_network}/24 via $rhost_ipv4addr dev $lhost_ifname
> -	    ;;
> -	esac
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to add the route to ${dst_network}/24"
> -	    return 1
> -	fi
> +	tst_resm TINFO "IPv4 route is added and deleted by '$cmd_name' command $NS_TIMES times"
>  
> -	# Load the route with UDP datagram
> -	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to run a UDP datagram sender"
> -	    return 1
> -	fi
> -
> -	# Down then up the interface
> -	case $test_type in
> -	    1)
> -	    ifconfig $lhost_ifname down && ifconfig $lhost_ifname up
> -	    ;;
> -	    2)
> -	    ip link set down dev $lhost_ifname && ip link set up dev $lhost_ifname
> -	    ;;
> -	esac
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to down/up the interface"
> -	    return 1
> -	fi
> +	while [ $cnt -lt $NS_TIMES ]; do
> +		make_background_tcp_traffic $(tst_ipaddr_un_host)
> +		check_connectivity_interval $cnt false $(tst_iface) $(tst_ipaddr_un_host rhost)
>  
> -	cnt=`expr $cnt + 1`
> -    done
> +		$cmd
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "failed to down the interface"
> +			return
> +		fi
>  
> -    tst_resm TPASS "Test is finished correctly."
> -    return 0
> -}
> +		$cmd2
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "failed to up the interface"
> +			return
> +		fi
>  
> +		cnt=$(($cnt + 1))
> +	done
>  
> -#-----------------------------------------------------------------------
> -#
> -# Main
> -#
> -# Exit Value:
> -#   The number of the failure
> -#
> -#-----------------------------------------------------------------------
> +	tst_resm TPASS "test is finished correctly"
> +}
>  
> -RC=0
>  do_setup
> -test_body 1 || RC=`expr $RC + 1`      # Case of route command
> -test_body 2 || RC=`expr $RC + 1`      # Case of ip command
> -do_cleanup
> +test_body 'ifconfig_cmd'
> +test_body 'ip_cmd'
>  
> -exit $RC
> +tst_exit
> diff --git a/testcases/network/stress/route/route4-lib.sh b/testcases/network/stress/route/route4-lib.sh
> new file mode 100644
> index 000000000..66a96320c
> --- /dev/null
> +++ b/testcases/network/stress/route/route4-lib.sh
> @@ -0,0 +1,145 @@
> +#!/bin/sh
> +# Copyright (c) International Business Machines  Corp., 2006
> +# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Setup script for route4-* tests.
> +#
> +# More information about network parameters can be found
> +# in the following document: testcases/network/stress/README
> +#
> +# Author: Petr Vorel <pvorel@suse.cz>
> +
> +. test_net_stress.sh
> +
> +tst_check_cmds ip pgrep route
> +
> +CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
> +
> +DST_NETWORK_OCTET_3=23
> +DST_HOST=5
> +
> +route_cleanup()
> +{
> +	netstress_cleanup
> +	restore_ipaddr
> +	restore_ipaddr rhost
> +}
> +
> +route_setup()
> +{
> +	netstress_setup
> +	tst_check_cmds route
> +	route_cleanup
> +}
> +
> +manipulate_route()
> +{
> +	local cmd_name=$1
> +	local task=$2
> +	local network=$3
> +	local prefix=$4
> +	local netmask=$5
> +	local gateway=$6
> +	local ifname=$7
> +
> +	[ "$task" = "add" ] || [ "$task" = "del" ] || tst_brkm TBROK "wrong task: '$task'"
> +
> +	if [ "$cmd_name" = "ip" ]; then
> +		ROD "$cmd_name route $task $network/$prefix via $gateway dev $ifname"
> +	elif [ "$cmd_name" = "route" ]; then
> +		ROD "$cmd_name $task -net $network netmask $netmask gw $gateway dev $ifname"
> +	else
> +		tst_brkm TBROK "wrong command: '$task'"
> +	fi
> +}
> +
> +get_cmd()
> +{
> +	local cmd_type=$1
> +
> +	case $cmd_type in
> +	rt_cmd) echo 'route' ;;
> +	ip_cmd) echo 'ip' ;;
> +	ifconfig_cmd) echo 'ifconfig' ;;
> +	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
> +	esac
> +}
> +
> +# helper function for route4-change-{dst,gw,if} tests
> +route_test_change()
> +{
> +	local test_field="$1"
> +	local cmd_type="$2"
> +	local ip="$3"
> +	local dst_network="$(tst_ipaddr_un_ip $DST_NETWORK_OCTET_3)"
> +	local gateway="$(tst_ipaddr_un_host rhost)"
> +	local lhost_ifname="$(tst_iface)"
> +	local cmd_name="$(get_cmd $cmd_type)"
> +	local cnt=0 link_num=0
> +	local gateway2 lhost_ifname2 pre_dst_network test_field_name
> +
> +	case $test_field in
> +	dst) test_field_name='destination' ;;
> +	gw) test_field_name='gateway' ;;
> +	if) test_field_name='interface' ;;
> +	*) tst_brkm TBROK "Unknown test parameter '$test_field'"
> +	esac
> +
> +	tst_resm TINFO "the $test_field_name of an IPv4 route is changed by '$cmd_name' command $NS_TIMES times"
> +
> +	if [ "$test_field" = 'dst' ]; then
> +		gateway="$ip"
> +		gateway2="$gateway"
> +	else
> +		dst_addr="$ip"
> +	fi
> +
> +	while [ $cnt -lt $NS_TIMES ]; do
> +		lhost_ifname2="$lhost_ifname"
> +		gateway2="$gateway"
> +
> +		pre_dst_network="$dst_network"
> +		if [ "$test_field" = 'dst' ]; then
> +			dst_addr="$(tst_ipaddr_un_ip $(($cnt % 255)) $DST_HOST)"
> +			dst_network="$(tst_ipaddr_un_ip $(($cnt % 255)))"

tst_ipaddr_un() handles '$cnt' overrun already.

> +			netstress_cleanup

cleanup in the test on every loop iteration?

> +		elif [ "$test_field" = 'gw' ]; then
> +			gateway2="$(tst_ipaddr_un_host rhost $(($RHOST_COUNTER_START + $cnt)))"
> +			local cnt2=$(($cnt + 1))
> +			[ $cnt2 -eq $RHOST_COUNTER_COUNT ] && cnt2=$RHOST_COUNTER_START
> +			gateway="$(tst_ipaddr_un_host rhost $(($RHOST_COUNTER_START + $cnt2)))"

Why do you need RHOST_COUNTER_COUNT and RHOST_COUNTER_START variables?

> +		elif [ "$test_field" = 'if' ]; then
> +			[ $link_num -ge $LINK_TOTAL ] && link_num=0
> +			lhost_ifname="$(tst_iface lhost $link_num)"
> +			gateway="$(tst_ipaddr_un_ip $link_num 1)"
> +			link_num=$(($link_num + 1))
> +		fi


It's better to change 'if' structure to 'case' one


> +
> +		if [ $cnt -gt 0 ]; then
> +			manipulate_route $cmd_name 'del' $pre_dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway2 $lhost_ifname2
> +		fi
> +
> +		manipulate_route $cmd_name 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
> +		make_background_tcp_traffic $(tst_ipaddr_un_host)

For generating traffic you're always using a single destination address,
why it can't be $(tst_ipaddr)?

> +		check_connectivity_interval $cnt false $lhost_ifname $dst_addr || return

Could you please clarify the traffic flow here? if I understand it
correctly ICMP goes over the new route/gw to an IP addresses on remote
host which was added in setup, correct?

I think ns-udpsender is the more appropriate choice for a one way traffic...


> +
> +		cnt=$(($cnt + 1))
> +	done
> +
> +	manipulate_route $cmd_name 'del' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
> +
> +	tst_resm TPASS "test is finished correctly"
> +}
> diff --git a/testcases/network/stress/route/route4-redirect b/testcases/network/stress/route/route4-redirect
> index 9eb8a4624..578a2c01a 100644
> --- a/testcases/network/stress/route/route4-redirect
> +++ b/testcases/network/stress/route/route4-redirect
> @@ -1,212 +1,73 @@
>  #!/bin/sh

...

>  
> -# The destination network
> -DST_NETWORK="10.10.0"   # destination network would be 10.10.0.0/24
> -DST_HOST="5"
> -DST_PORT="7"
> +SYSFS_ACCEPT_REDIRECTS=
> +SYSFS_SECURE_REDIRECTS=
>  
> -
> -#-----------------------------------------------------------------------
> -#
> -# NAME:
> -#   do_cleanup
> -#
> -# DESCRIPTION:
> -#   Recover the tested interfaces
> -#
> -#-----------------------------------------------------------------------
>  do_cleanup()
>  {
> -    # Kill the redirector utility
> -    $LTP_RSH $RHOST killall -SIGHUP ns-icmp_redirector >/dev/null 2>&1
> +	kill_daemon ns-udpsender
> +	restore_ipaddr
> +	restore_ipaddr rhost
>  
> -    # Initialize the interfaces
> -    initialize_if lhost ${LINK_NUM}
> -    initialize_if rhost ${LINK_NUM}
> +	kill_daemon ns-icmp_redirector remote
> +	[ -n "$SYSFS_ACCEPT_REDIRECTS" ] && sysctl -qw net.ipv4.conf.$(tst_iface).accept_redirects=$SYSFS_ACCEPT_REDIRECTS
> +	[ -n "$SYSFS_SECURE_REDIRECTS" ] && sysctl -qw net.ipv4.conf.$(tst_iface).secure_redirects=$SYSFS_SECURE_REDIRECTS
>  }
>  
> -
> -#-----------------------------------------------------------------------
> -#
> -# NAME:
> -#   do_setup
> -#
> -# DESCRIPTION:
> -#   Set the initial route and start icmp redirect on the remote host
> -#
> -# SET VALUES:
> -#   rhost_ipv4addr      - IPv4 Address of the remote host
> -#   lhost_ifname        - Interface name of the local host
> -#   rhost_ifname        - Interface name of the remote host
> -#
> -#-----------------------------------------------------------------------
>  do_setup()
>  {
> -    # Make sure to clean up
> -    do_cleanup
> -
> -    # Get the Interface name of local host
> -    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to get the interface name at the local host"
> -	exit $TST_TOTAL
> -    fi
> -
> -    # Get the Interface name of remote host
> -    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to get the interface name at the remote host"
> -	exit $TST_TOTAL
> -    fi
> -
> -    # Remove the link-local address of the remote host
> -    sleep 3
> -    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
> +	netstress_setup
>  
> -    # Assign IPv4 address to the interface of the local host
> -    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
> -	return 1
> -    fi
> +	SYSFS_ACCEPT_REDIRECTS=$(sysctl -b net.ipv4.conf.$(tst_iface).accept_redirects)
> +	SYSFS_SECURE_REDIRECTS=$(sysctl -b net.ipv4.conf.$(tst_iface).secure_redirects)
>  
> -    # Add route to the initial gateway
> -    route add -net ${DST_NETWORK}.0 netmask 255.255.255.0 gw ${IPV4_NETWORK}.${RHOST_IPV4_HOST} dev $lhost_ifname
> +	tst_add_ipaddr_stress
>  
> -    # Make sure the sysctl value is set for accepting the redirect
> -    sysctl -w net.ipv4.conf.${lhost_ifname}.accept_redirects=1 >/dev/null
> -    sysctl -w net.ipv4.conf.${lhost_ifname}.secure_redirects=0 >/dev/null
> -
> -    # Run the redirector utility at the remote host
> -    ret=`$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmp_redirector -I $rhost_ifname -b ; "'echo $?'`
> -    if [ $ret -ne 0 ]; then
> -	tst_resm TBROK "Failed to run icmp redirector at the remote host"
> -	exit $TST_TOTAL
> -    fi
> +	# Run the redirector utility at the remote host
> +	tst_rhost_run -s -c "ns-icmp_redirector -I $(tst_iface rhost) -b"
>  }
>  
> -
> -
> -#-----------------------------------------------------------------------
> -#
> -# FUNCTION:
> -#   test_body
> -#
> -# DESCRIPTION:
> -#   main code of the test
> -#
> -# Arguments:
> -#   None
> -#
> -#-----------------------------------------------------------------------
>  test_body()
>  {
> -    # Loop for changing the route
> -    cnt=0
> -    while [ $cnt -lt $NS_TIMES ]; do
> -	ns-udpsender -f 4 -D ${DST_NETWORK}.${DST_HOST} -p $DST_PORT -o -s 8
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to run udp packet sender"
> -	    return 1
> -	fi
> -	cnt=`expr $cnt + 1`
> -    done
> -
> -    tst_resm TPASS "Test is finished correctly."
> -    return 0
> +	local cnt=0
> +	tst_resm TINFO "changing IPv4 route by sending UDP packets with ns-udpsender $NS_TIMES times"
> +	while [ $cnt -lt $NS_TIMES ]; do
> +		ROD ns-udpsender -f 4 -D $(tst_ipaddr_un_host rhost 2) -p 7 -o -s 8

...
> -exit $RC
> +tst_exit
> diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
> index 36c8c970d..9c1eade81 100644
> --- a/testcases/network/stress/route/route4-rmmod
> +++ b/testcases/network/stress/route/route4-rmmod

...

>  test_body()
>  {
> -    test_type=$1
> +	local cmd_type=$1
> +	local cmd_name="$(get_cmd $cmd_type)"
> +	local dst_addr=${DST_NETWORK}.${DST_HOST}
> +	local dst_network=${DST_NETWORK}.0
> +	local cnt=0
>  
> -    TCID=route4-rmmod0${test_type}
> -    TST_COUNT=$test_type
> +	tst_resm TINFO "IPv4 route is added by '$cmd_name' command and then deleted by removing network driver $NS_TIMES times"

This is not what the test does after the changes.

>  
> -    case $test_type in
> -	1)
> -	tst_resm TINFO "Verify the kernel is not crashed when IPv4 route is add by route command then it is deleted by removing network driver in $NS_TIMES times"
> -	;;
> -	2)
> -	tst_resm TINFO "Verify the kernel is not crashed when IPv4 route is add by ip command then it is deleted by removing network driver in $NS_TIMES times"
> -	;;
> -	*)
> -	tst_resm TBROK "unspecified case"
> -	return 1
> -	;;
> -    esac
> +	while [ $cnt -lt $NS_TIMES ]; do
> +		make_background_tcp_traffic $(tst_ipaddr_un_ip)
> -    # Start the loop
> -    cnt=0
> -    while [ $cnt -lt $NS_TIMES ]; do
> -	# Check the connectivity to the gateway
> -	check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
> -	    return 1
> -	fi
> +		check_connectivity_interval $cnt false $(tst_iface) $(tst_ipaddr_un_host rhost) || return
>  
> -	# Add the route
> -	case $test_type in
> -	    1)
> -	    route add -net $dst_network netmask 255.255.255.0 gw $rhost_ipv4addr dev $lhost_ifname
> -	    ;;
> -	    2)
> -	    ip route add ${dst_network}/24 via $rhost_ipv4addr dev $lhost_ifname
> -	    ;;
> -	esac
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to add the route to ${dst_network}/24"
> -	    return 1
> -	fi
> +		# Remove and reload the network driver
> +		modprobe -r $MODULE
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "failed to remove the network driver '$MODULE'"
> +			return
> +		fi
>  
> -	# Load the route with UDP datagram
> -	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to run a UDP datagram sender"
> -	    return 1
> -	fi
> -
> -	# Remove and reload the network driver
> -	rmmod $lhost_module && modprobe $lhost_module
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to unload/reload the network driver"
> -	    return 1
> -	fi
> +		modprobe $MODULE
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "failed to load the network driver '$MODULE'"
> +			return
> +		fi
>  
> -	# Make sure to assing the IPv4 address
> -	set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST} >/dev/null 2>&1
> +		tst_sleep 100ms
>  
> -	cnt=`expr $cnt + 1`
> -    done
> +		# If we use netns we need to reset it as unloading kernel module breaks it
> +		reset_ltp_netspace
>  
> -    tst_resm TPASS "Test is finished correctly."
> -    return 0
> -}
> +		tst_add_ipaddr_stress
>  
> +		cnt=$(($cnt + 1))
> +	done


With this implementation it should be moved to 'interface' group.


Best regards,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170822/e7f2ef3a/attachment-0001.html>
