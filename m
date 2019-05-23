From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 May 2019 15:46:36 +0300
Subject: [LTP] [RFC PATCH v2 1/6] net/route: Remove route{4, 6}-change-if
In-Reply-To: <20190510183132.31039-2-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
 <20190510183132.31039-2-pvorel@suse.cz>
Message-ID: <25af53c5-dcfc-93b0-b9cb-4d179d485548@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 5/10/19 9:31 PM, Petr Vorel wrote:
> These testsuites requires 3 NIC setup, which is not supported by network
> namespace setup (single host configuration) and IMHO not common for two
> host configuration either.

I guess, the third interface can be easily created during the setup, on the
lhost... this is what's required, right?

For example, by adding macvlan to the test interface:

  ip link add ltp_mv0 link $(tst_iface) type macvlan mode bridge


Then, for the test route we can set either ltp_mv0 or $(tst_iface) interface.

> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net_stress.route                      |   2 -
>  .../network/stress/route/00_Descriptions.txt  |  16 -
>  .../network/stress/route/route4-change-if     | 324 ------------------
>  .../network/stress/route/route6-change-if     | 323 -----------------
>  4 files changed, 665 deletions(-)
>  delete mode 100644 testcases/network/stress/route/route4-change-if
>  delete mode 100644 testcases/network/stress/route/route6-change-if
> 
> diff --git a/runtest/net_stress.route b/runtest/net_stress.route
> index 266ef0383..c065c5cd1 100644
> --- a/runtest/net_stress.route
> +++ b/runtest/net_stress.route
> @@ -4,12 +4,10 @@
>  
>  route4-change-dst route4-change-dst
>  route4-change-gw route4-change-gw
> -route4-change-if route4-change-if
>  route4-redirect route4-redirect
>  route4-rmmod route4-rmmod
>  
>  route6-change-dst route6-change-dst
>  route6-change-gw route6-change-gw
> -route6-change-if route6-change-if
>  route6-redirect route6-redirect
>  route6-rmmod route6-rmmod
> diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
> index 2a871fdae..91aa01120 100644
> --- a/testcases/network/stress/route/00_Descriptions.txt
> +++ b/testcases/network/stress/route/00_Descriptions.txt
> @@ -14,14 +14,6 @@ route4-change-gw02
>  	Verify the kernel is not crashed when the gateway of an IPv4 route is
>  	changed frequently by ip command
>  
> -route4-change-if01
> -	Verify the kernel is not crashed when the interface of an IPv4 route is
> -	changed frequently by route command
> -
> -route4-change-if02
> -	Verify the kernel is not crashed when the interface of an IPv4 route is
> -	changed frequently by ip command
> -
>  route4-redirect01
>  	Verify the kernel is not crashed when the IPv4 route is modified by
>  	ICMP Redirects frequently
> @@ -51,14 +43,6 @@ route6-change-gw02
>  	Verify the kernel is not crashed when the gateway of an IPv6 route is
>  	changed frequently by ip command
>  
> -route6-change-if01
> -	Verify the kernel is not crashed when the interface of an IPv6 route is
> -	changed frequently by route command
> -
> -route6-change-if02
> -	Verify the kernel is not crashed when the interface of an IPv6 route is
> -	changed frequently by ip command
> -
>  route6-redirect01
>  	Verify the kernel is not crashed when the IPv6 route is modified by
>  	ICMP Redirects frequently
> diff --git a/testcases/network/stress/route/route4-change-if b/testcases/network/stress/route/route4-change-if
> deleted file mode 100644
> index 8753203d0..000000000
> --- a/testcases/network/stress/route/route4-change-if
> +++ /dev/null
> @@ -1,324 +0,0 @@
> -#!/bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) International Business Machines  Corp., 2006                 ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -##                                                                            ##
> -################################################################################
> -#
> -# File:
> -#   route4-change-if
> -#
> -# Description:
> -#   Verify the kernel is not crashed when the interface of an IPv4 route is
> -#   changed frequently
> -#    test01 - by route command
> -#    test02 - by ip command
> -#
> -# Setup:
> -#   See testcases/network/stress/README
> -#
> -# Author:
> -#   Mitsuru Chinen <mitch@jp.ibm.com>
> -#
> -# History:
> -#	Mar 17 2006 - Created (Mitsuru Chinen)
> -#
> -#-----------------------------------------------------------------------
> -# Uncomment line below for debug output.
> -#trace_logic=${trace_logic:-"set -x"}
> -$trace_logic
> -
> -# Make sure the value of LTPROOT
> -LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
> -export LTPROOT
> -
> -# Total number of the test case
> -TST_TOTAL=2
> -export TST_TOTAL
> -
> -# Default of the test case ID and the test case count
> -TCID=route4-change-if
> -TST_COUNT=0
> -export TCID
> -export TST_COUNT
> -
> -# Check the environmanet variable
> -. check_envval || exit $TST_TOTAL
> -
> -# The number of times where route is changed
> -NS_TIMES=${NS_TIMES:-10000}
> -
> -# The first 2 ocnted of the Network portion of the gateway address
> -IPV4_NETWORK_PRE=${IPV4_NETWORK_PRE:-"10.0"}
> -
> -# Netmask of for the gateway
> -IPV4_NETMASK_NUM=24
> -
> -# Host portion of the IPv4 address
> -LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# src
> -RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# gateway
> -
> -# The destination network
> -DST_NETWORK="10.10.0"	# destination network would be 10.10.0.0/24
> -DST_HOST="5"
> -DST_PORT="7"
> -
> -
> -#-----------------------------------------------------------------------
> -#
> -# NAME:
> -#   do_setup
> -#
> -# DESCRIPTION:
> -#   Make a IPv4 connectivity
> -#
> -# SET VALUES:
> -#   rhost_ipv4addr	- IPv4 Address of the remote host
> -#   lhost_ifname	- Interface name of the local host
> -#   rhost_ifname	- Interface name of the remote host
> -#
> -#-----------------------------------------------------------------------
> -do_setup()
> -{
> -    TCID=route4-change-if
> -    TST_COUNT=0
> -
> -    # Get the number of the test links
> -    link_total=`echo $LHOST_HWADDRS | wc -w`
> -    rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
> -    if [ $link_total -ne $rhost_link_total ]; then
> -	tst_resm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
> -	exit $TST_TOTAL
> -    fi
> -    if [ $link_total -lt 2 ]; then
> -	tst_resm TBROK "This test case requires plural Test Links"
> -	exit $TST_TOTAL
> -    fi
> -
> -    lhost_ifname_array=""
> -    rhost_ifname_array=""
> -    link_num=0
> -    while [ $link_num -lt $link_total ]; do
> -	# Get the Interface names of the local host
> -	lhost_ifname=`get_ifname lhost ${link_num}`
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to get the interface name at the local host"
> -	    exit $TST_TOTAL
> -	fi
> -	lhost_ifname_array="$lhost_ifname_array $lhost_ifname"
> -
> -	# Get the Interface names of the remote host
> -	rhost_ifname=`get_ifname rhost ${link_num}`
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to get the interface name at the remote host"
> -	    exit $TST_TOTAL
> -	fi
> -	rhost_ifname_array="$rhost_ifname_array $rhost_ifname"
> -
> -	# Initialize the interfaces of the remote host
> -	initialize_if rhost ${link_num}
> -
> -	# Set IPv4 address to the interface of the remote host
> -	set_ipv4addr rhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${RHOST_IPV4_HOST}
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to assign IP address to the interface $rhost_ifname at the remote host"
> -	    exit $TST_TOTAL
> -	fi
> -
> -	link_num=`expr $link_num + 1`
> -    done
> -}
> -
> -
> -
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
> -do_cleanup()
> -{
> -    # Make sure to kill the udp datagram sender
> -    killall -SIGHUP ns-udpsender >/dev/null 2>&1
> -
> -    # Initialize the interfaces
> -    link_num=0
> -    while [ $link_num -lt $link_total ]; do
> -	initialize_if lhost ${link_num}
> -	initialize_if rhost ${link_num}
> -	link_num=`expr $link_num + 1`
> -    done
> -}
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
> -#   $1: define the test type
> -#       1 - route command case
> -#       2 - ip command case
> -#
> -#-----------------------------------------------------------------------
> -test_body()
> -{
> -    test_type=$1
> -
> -    TCID=route4-change-if0${test_type}
> -    TST_COUNT=$test_type
> -
> -    case $test_type in
> -	1)
> -	test_command="route"
> -	;;
> -	2)
> -	test_command="ip"
> -	;;
> -	*)
> -	tst_resm TBROK "unspecified case"
> -	return 1
> -	;;
> -    esac
> -
> -    tst_resm TINFO "Verify the kernel is not crashed when the interface of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
> -
> -    link_num=0
> -    while [ $link_num -lt $link_total ]; do
> -	# Initialize the interface of the local host
> -	initialize_if lhost ${link_num}
> -
> -	# Assign IPv4 address to the interface of the local host
> -	set_ipv4addr lhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${LHOST_IPV4_HOST}
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to assign an IPv4 address at the local host"
> -	    return 1
> -	fi
> -
> -	# Check the connectivity to the gateway
> -	field=`expr $link_num + 1`
> -	lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
> -	check_icmpv4_connectivity $lhost_ifname "${IPV4_NETWORK_PRE}.${link_num}.${LHOST_IPV4_HOST}"
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Test Link $link_num is somthing wrong."
> -	    return 1
> -	fi
> -	link_num=`expr $link_num + 1`
> -    done
> -
> -    # Set the variables regarding the destination host
> -    dst_addr=${DST_NETWORK}.${DST_HOST}
> -    dst_network=${DST_NETWORK}.0
> -
> -    # Set the first route
> -    link_num=0
> -    field=`expr $link_num + 1`
> -    lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
> -    gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
> -    case $test_type in
> -	1)
> -	route add -net $dst_network netmask 255.255.255.0 gw $gateway dev $lhost_ifname
> -	;;
> -	2)
> -	ip route add ${dst_network}/24 via $gateway dev $lhost_ifname
> -	;;
> -    esac
> -
> -    # Load the route with UDP traffic
> -    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
> -    if [ $? -ne 0 ]; then
> -	tst_resm TFAIL "Failed to run a UDP datagram sender"
> -	return 1
> -    fi
> -
> -    # Loop for changing the route
> -    cnt=0
> -    while [ $cnt -lt $NS_TIMES ]; do
> -	link_num=`expr $link_num + 1`
> -	if [ $link_num -ge $link_total ]; then
> -	    link_num=0
> -	fi
> -
> -	pre_lhost_ifname=$lhost_ifname
> -	pre_gateway=$gateway
> -
> -	field=`expr $link_num + 1`
> -	lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
> -	gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
> -
> -	case $test_type in
> -	    1)
> -	    route add -net $dst_network netmask 255.255.255.0 gw $gateway dev $lhost_ifname
> -	    route del -net $dst_network netmask 255.255.255.0 gw $pre_gateway dev $pre_lhost_ifname
> -	    ;;
> -	    2)
> -	    ip route change ${dst_network}/24 via $gateway dev $lhost_ifname
> -	    ;;
> -	esac
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to change the gateway to $gateway"
> -	    return 1
> -	fi
> -
> -	# Rerun if udp datagram sender is dead
> -	ps auxw | fgrep -v grep | grep ns-udpsender > /dev/null
> -	if [ $? -ne 0 ]; then
> -	    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
> -	    if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "Failed to run a UDP datagram sender"
> -		return 1
> -	    fi
> -	fi
> -
> -	cnt=`expr $cnt + 1`
> -    done
> -
> -    # Kill the udp datagram sender
> -    killall -SIGHUP ns-udpsender
> -
> -    tst_resm TPASS "Test is finished correctly."
> -    return 0
> -}
> -
> -
> -#-----------------------------------------------------------------------
> -#
> -# Main
> -#
> -# Exit Value:
> -#   The number of the failure
> -#
> -#-----------------------------------------------------------------------
> -
> -RC=0
> -do_setup
> -test_body 1 || RC=`expr $RC + 1`      # Case of route command
> -test_body 2 || RC=`expr $RC + 1`      # Case of ip command
> -do_cleanup
> -
> -exit $RC
> diff --git a/testcases/network/stress/route/route6-change-if b/testcases/network/stress/route/route6-change-if
> deleted file mode 100644
> index 051ba8bcc..000000000
> --- a/testcases/network/stress/route/route6-change-if
> +++ /dev/null
> @@ -1,323 +0,0 @@
> -#!/bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) International Business Machines  Corp., 2006                 ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -##                                                                            ##
> -################################################################################
> -#
> -# File:
> -#   route6-change-if
> -#
> -# Description:
> -#   Verify the kernel is not crashed when the interface of an IPv6 route is
> -#   changed frequently
> -#    test01 - by route command
> -#    test02 - by ip command
> -#
> -# Setup:
> -#   See testcases/network/stress/README
> -#
> -# Author:
> -#   Mitsuru Chinen <mitch@jp.ibm.com>
> -#
> -# History:
> -#	Mar 17 2006 - Created (Mitsuru Chinen)
> -#
> -#-----------------------------------------------------------------------
> -# Uncomment line below for debug output.
> -#trace_logic=${trace_logic:-"set -x"}
> -$trace_logic
> -
> -# Make sure the value of LTPROOT
> -LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
> -export LTPROOT
> -
> -# Total number of the test case
> -TST_TOTAL=2
> -export TST_TOTAL
> -
> -# Default of the test case ID and the test case count
> -TCID=route6-change-if
> -TST_COUNT=0
> -export TCID
> -export TST_COUNT
> -
> -# Check the environmanet variable
> -. check_envval || exit $TST_TOTAL
> -
> -# The number of times where route is changed
> -NS_TIMES=${NS_TIMES:-10000}
> -
> -# The first 2 ocnted of the Network portion of the gateway address
> -IPV6_NETWORK_PRE="fec0:1:1"
> -
> -# Netmask of for the gateway
> -IPV6_NETMASK_NUM=64
> -
> -# Host portion of the IPv6 address
> -LHOST_IPV6_HOST=":2"	# src
> -RHOST_IPV6_HOST=":1"	# gateway
> -
> -# The destination network
> -DST_NETWORK="fd00:100:1:1"      # dest network would be fd00:100:1:1:::/64
> -DST_HOST=":5"
> -DST_PORT="7"
> -
> -
> -#-----------------------------------------------------------------------
> -#
> -# NAME:
> -#   do_setup
> -#
> -# DESCRIPTION:
> -#   Make a IPv6 connectivity
> -#
> -# SET VALUES:
> -#   rhost_ipv6addr	- IPv6 Address of the remote host
> -#   lhost_ifname	- Interface name of the local host
> -#   rhost_ifname	- Interface name of the remote host
> -#
> -#-----------------------------------------------------------------------
> -do_setup()
> -{
> -    TCID=route6-change-if
> -    TST_COUNT=0
> -
> -    # Get the number of the test links
> -    link_total=`echo $LHOST_HWADDRS | wc -w`
> -    rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
> -    if [ $link_total -ne $rhost_link_total ]; then
> -	tst_resm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
> -	exit $TST_TOTAL
> -    fi
> -    if [ $link_total -lt 2 ]; then
> -	tst_resm TBROK "This test case requires plural Test Links"
> -	exit $TST_TOTAL
> -    fi
> -
> -    lhost_ifname_array=""
> -    rhost_ifname_array=""
> -    link_num=0
> -    while [ $link_num -lt $link_total ]; do
> -	# Get the Interface names of the local host
> -	lhost_ifname=`get_ifname lhost ${link_num}`
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to get the interface name at the local host"
> -	    exit $TST_TOTAL
> -	fi
> -	lhost_ifname_array="$lhost_ifname_array $lhost_ifname"
> -
> -	# Get the Interface names of the remote host
> -	rhost_ifname=`get_ifname rhost ${link_num}`
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to get the interface name at the remote host"
> -	    exit $TST_TOTAL
> -	fi
> -	rhost_ifname_array="$rhost_ifname_array $rhost_ifname"
> -
> -	# Initialize the interfaces of the remote host
> -	initialize_if rhost ${link_num}
> -
> -	# Set IPv6 address to the interface of the remote host
> -	add_ipv6addr rhost ${link_num} "${IPV6_NETWORK_PRE}:${link_num}" ${RHOST_IPV6_HOST}
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to assign IP address to the interface $rhost_ifname at the remote host"
> -	    exit $TST_TOTAL
> -	fi
> -
> -	link_num=`expr $link_num + 1`
> -    done
> -}
> -
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
> -do_cleanup()
> -{
> -    # Make sure to kill the udp datagram sender
> -    killall -SIGHUP ns-udpsender >/dev/null 2>&1
> -
> -    # Initialize the interfaces
> -    link_num=0
> -    while [ $link_num -lt $link_total ]; do
> -	initialize_if lhost ${link_num}
> -	initialize_if rhost ${link_num}
> -	link_num=`expr $link_num + 1`
> -    done
> -}
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
> -#   $1: define the test type
> -#       1 - route command case
> -#       2 - ip command case
> -#
> -#-----------------------------------------------------------------------
> -test_body()
> -{
> -    test_type=$1
> -
> -    TCID=route6-change-if0${test_type}
> -    TST_COUNT=$test_type
> -
> -    case $test_type in
> -	1)
> -	test_command="route"
> -	;;
> -	2)
> -	test_command="ip"
> -	;;
> -	*)
> -	tst_resm TBROK "unspecified case"
> -	return 1
> -	;;
> -    esac
> -
> -    tst_resm TINFO "Verify the kernel is not crashed when the interface of an IPv6 route is changed frequently by $test_command command in $NS_TIMES times"
> -
> -    link_num=0
> -    while [ $link_num -lt $link_total ]; do
> -	# Initialize the interface of the local host
> -	initialize_if lhost ${link_num}
> -
> -	# Assign IPv6 address to the interface of the local host
> -	add_ipv6addr lhost ${link_num} "${IPV6_NETWORK_PRE}:${link_num}" ${LHOST_IPV6_HOST}
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Failed to assign an IPv6 address at the local host"
> -	    return 1
> -	fi
> -
> -	# Check the connectivity to the gateway
> -	field=`expr $link_num + 1`
> -	lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
> -	check_icmpv6_connectivity $lhost_ifname "${IPV6_NETWORK_PRE}:${link_num}:${LHOST_IPV6_HOST}"
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TBROK "Test Link $link_num is somthing wrong."
> -	    return 1
> -	fi
> -	link_num=`expr $link_num + 1`
> -    done
> -
> -    # Set the variables regarding the destination host
> -    dst_addr=${DST_NETWORK}:${DST_HOST}
> -    dst_network=${DST_NETWORK}::
> -
> -    # Set the first route
> -    link_num=0
> -    field=`expr $link_num + 1`
> -    lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
> -    gateway="${IPV6_NETWORK_PRE}:${link_num}:${RHOST_IPV6_HOST}"
> -    case $test_type in
> -	1)
> -	route -A inet6 add ${dst_network}/64 gw $gateway dev $lhost_ifname
> -	;;
> -	2)
> -	ip -f inet6 route add ${dst_network}/64 via $gateway dev $lhost_ifname
> -	;;
> -    esac
> -
> -    # Load the route with UDP traffic
> -    ns-udpsender -f 6 -D $dst_addr -p $DST_PORT -b -s 1452
> -    if [ $? -ne 0 ]; then
> -	tst_resm TFAIL "Failed to run a UDP datagram sender"
> -	return 1
> -    fi
> -
> -    # Loop for changing the route
> -    cnt=0
> -    while [ $cnt -lt $NS_TIMES ]; do
> -	link_num=`expr $link_num + 1`
> -	if [ $link_num -ge $link_total ]; then
> -	    link_num=0
> -	fi
> -
> -	pre_lhost_ifname=$lhost_ifname
> -	pre_gateway=$gateway
> -
> -	field=`expr $link_num + 1`
> -	lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
> -	gateway="${IPV6_NETWORK_PRE}:${link_num}:${RHOST_IPV6_HOST}"
> -
> -	case $test_type in
> -	    1)
> -	    route -A inet6 add ${dst_network}/64 gw $gateway dev $lhost_ifname
> -	    route -A inet6 del ${dst_network}/64 gw $pre_gateway dev $pre_lhost_ifname
> -	    ;;
> -	    2)
> -	    ip -f inet6 route add ${dst_network}/64 via $gateway dev $lhost_ifname
> -	    ip -f inet6 route del ${dst_network}/64 via $pre_gateway dev $pre_lhost_ifname
> -	    ;;
> -	esac
> -	if [ $? -ne 0 ]; then
> -	    tst_resm TFAIL "Failed to change the gateway to $gateway"
> -	    return 1
> -	fi
> -
> -	# Rerun if udp datagram sender is dead
> -	ps auxw | fgrep -v grep | grep ns-udpsender > /dev/null
> -	if [ $? -ne 0 ]; then
> -	    ns-udpsender -f 6 -D $dst_addr -p $DST_PORT -b -s 1452
> -	    if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "Failed to run a UDP datagram sender"
> -		return 1
> -	    fi
> -	fi
> -
> -	cnt=`expr $cnt + 1`
> -    done
> -
> -    # Kill the udp datagram sender
> -    killall -SIGHUP ns-udpsender
> -
> -    tst_resm TPASS "Test is finished correctly."
> -    return 0
> -}
> -
> -
> -#-----------------------------------------------------------------------
> -#
> -# Main
> -#
> -# Exit Value:
> -#   The number of the failure
> -#
> -#-----------------------------------------------------------------------
> -
> -RC=0
> -do_setup
> -test_body 1 || RC=`expr $RC + 1`      # Case of route command
> -test_body 2 || RC=`expr $RC + 1`      # Case of ip command
> -do_cleanup
> -
> -exit $RC
> 

