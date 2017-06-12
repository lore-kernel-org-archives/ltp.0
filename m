From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 12 Jun 2017 15:39:12 +0300
Subject: [LTP] [RFC PATCH v6 09/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <20170603120022.13415-10-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-10-pvorel@suse.cz>
Message-ID: <bf219efe-a926-aa08-c24c-376fc4676556@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/03/2017 03:00 PM, Petr Vorel wrote:
> * Fix test for netns based testing.
> * Remove rsh dependency.
> * Create shell library route4-lib.sh (route IPv4 specific) to reduce
>   duplicity in tests. Library uses test_stress_net.sh (and therefore test_net.sh).
> * Stop using TST_COUNT, simplify TCID
> * Cleanup code, fix typos, update doc.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/stress/ns-tools/initialize_if    |   3 -
>  testcases/network/stress/route/00_Descriptions.txt |  23 +-
>  testcases/network/stress/route/route4-change-dst   | 287 ++---------------
>  testcases/network/stress/route/route4-change-gw    | 308 +++---------------
>  testcases/network/stress/route/route4-change-if    | 348 +++------------------
>  testcases/network/stress/route/route4-ifdown       | 298 ++++--------------
>  testcases/network/stress/route/route4-lib.sh       | 252 +++++++++++++++
>  testcases/network/stress/route/route4-redirect     | 232 +++-----------
>  testcases/network/stress/route/route4-rmmod        | 329 +++++--------------
>  testcases/network/stress/route/route6-change-dst   |   2 +-
>  10 files changed, 585 insertions(+), 1497 deletions(-)
>  create mode 100644 testcases/network/stress/route/route4-lib.sh
>
> diff --git a/testcases/network/stress/ns-tools/initialize_if b/testcases/network/stress/ns-tools/initialize_if
> index d64203e4c..23bf68bc0 100644
> --- a/testcases/network/stress/ns-tools/initialize_if
> +++ b/testcases/network/stress/ns-tools/initialize_if
> @@ -69,9 +69,6 @@ fi
>  # Define the interface name
>  ifname=`get_ifname $host_type $link_num` || exit 1
>  
> -# Initialize the specified interface
> -command="ifconfig $ifname down mtu 1500 ; ip route flush dev $ifname ; ip addr flush dev $ifname ; ifconfig $ifname up"
> -
>  if [ $host_type = lhost ]; then
>      ( ifconfig $ifname down && \
>      ip link set mtu 1500 dev $ifname && \

There are no changes in route IPv6 tests, why do we need this for route
IPv4?


[...]
>  do_setup()
>  {
> -    TCID=route4-change-dst
> -    TST_COUNT=0
> -
> -    # Initialize the interfaces of the remote host
> -    initialize_if rhost ${LINK_NUM}
> -
> -    # Set IPv4 address to the interfaces
> -    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
> -    if [ $? -ne 0 ]; then
> -	tst_resm TBROK "Failed to add an IPv4 address the remote host"
> -	exit $TST_TOTAL
> -    fi
> -
> -    # IPv4 address of the remote host (gateway)
> -    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
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
> -}
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
> -    # Initialize the interfaces
> -    initialize_if lhost ${LINK_NUM}
> -    initialize_if rhost ${LINK_NUM}
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
> -    TCID=route4-change-dst0${test_type}
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
> +	# Initialize the interfaces of the remote host
> +	tst_init_iface rhost $LINK_NUM

It should really be tst_restore_addr() functions, they invoke
tst_init_iface,
add IP addresses from configuration.

[...]
>  
> -#
> -#-----------------------------------------------------------------------
> +for cmd_name in rt_cmd ip_cmd; do
> +	do_test_common "dst" $cmd_name $LINK_NUM 1 $lhost_ifname $rhost_ipv4addr
> +done

do_test_common dst rt_cmd $LINK_NUM 1 $lhost_ifname $rhost_ipv4addr
do_test_common dst ip_cmd $LINK_NUM 1 $lhost_ifname $rhost_ipv4addr


I think "do_test_common" is too generic name for the library function,
mat be "route_test/route_cleanup"?

One more thing, do the tests use multiple NICs at the same time?
If not,we could simplify them and assume it is default one, i.e. 0.

[...]
>  
> -RC=0
> -do_setup
> -test_body 1 || RC=`expr $RC + 1`      # Case of route command
> -test_body 2 || RC=`expr $RC + 1`      # Case of ip command
> -do_cleanup
> +do_cleanup_common

There is 'TST_CLEANUP' library variable for this. It'll be called on
tst_exit or TBROK.

[...]
>  
> diff --git a/testcases/network/stress/route/route4-lib.sh b/testcases/network/stress/route/route4-lib.sh
> new file mode 100644
> index 000000000..e1823b8f1
> --- /dev/null
> +++ b/testcases/network/stress/route/route4-lib.sh
> @@ -0,0 +1,252 @@
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
> +export TCID="`basename $0`"
> +
> +. test_stress_net.sh
> +
> +# The first 2 ocnted of the Network portion of the gateway address
> +# FIXME: calculate it from IPV4_NETWORK variable as test expects IPV4_NETWORK
> +# to be 10.0.0 and prefix 24.
> +IPV4_NETWORK_PRE=${IPV4_NETWORK_PRE:-"10.0"}
> +
> +# The destination network
> +# FIXME: generate DST_NETWORK_PREFIX randomly based on IPV4_NETWORK variable as
> +# test expects IPV4_NETWORK to be 10.0.0 and prefix 24.
> +DST_NETWORK_PREFIX="10.10" # 10.10.n.0/24
> +DST_NETWORK="${DST_NETWORK_PREFIX}.0" # 10.10.0.0/24
> +DST_HOST=5
> +DST_PORT=7
> +
> +do_cleanup_common()
> +{
> +    init_if_lhost_rhost $LINK_NUM

cleanup should restore default configuration on a testinterface,
otherwise the other test would run on an empty one.

> +}
> +
> +prepare_connectivity()
> +{
> +	local lhost_ifname=$1
> +	local link_num=$2
> +	local network_part="$3"
> +	local host_part="$4"
> +	local rhost_addr="$5"
> +	local type="lhost"
> +
> +	tst_init_iface $type $link_num
> +	set_ipv4addr_check $type $link_num $network_part $host_part
> +	check_connectivity $lhost_ifname $rhost_addr
> +}
> +
> +get_lhost_ifname_loop()
> +{
> +	local field=$(($1 + 1))
> +	echo $lhost_ifname_array | cut -d ' ' -f $field
> +}
> +
> +run_cmd()
> +{
> +	local cmd="$@"
> +	local ret
> +
> +	sh -c "$cmd"
> +	ret=$?
> +	[ $ret -ne 0 ] && tst_resm TWARN "'$cmd' failed: $ret"

Can we use EXPECT_PASS instead of run_cmd or ROD if it is inside setup?

> +	return $ret
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
> +	local lhost_ifname=$7
> +	# not required params
> +	local gateway2=$8
> +	local lhost_ifname2=$9
> +
> +	local ret t
> +
> +	[ "$task" = "add" ] || [ "$task" = "del" ] || [ "$task" = "change" ] || \
> +		tst_brkm TBROK "wrong task: '$task'"
> +
> +	if [ "$cmd_name" = "ip" ]; then
> +		run_cmd "$cmd_name route $task $network/$prefix via $gateway dev $lhost_ifname"
> +		ret=$?
> +	else
> +		t="$task"
> +		# route doesn't have change command
> +		[ "$task" = "change" ] && t="add"
> +		run_cmd "$cmd_name $t -net $network netmask $netmask gw $gateway dev $lhost_ifname"
> +		ret=$?
> +
> +		if [ "$task" = "change" ]; then
> +			run_cmd "$cmd_name del -net $network netmask $netmask gw $gateway2 dev $lhost_ifname2"
> +			ret=$?
> +		fi
> +	fi
> +

It would be better to use tst_res()/rod/expect_pass/fail here rather
than each time check the status after the command + set test result.

[...]
> +
> +do_test_common()
> +{
> +	local test_field=$1
> +	local cmd_type=$2
> +	local link_num=$3
> +	local link_total=$4
> +	local lhost_ifname=$5
> +	local rhost_addr="$6"
> +	# not required params
> +	local rhost_part_first=$7
> +	local rhost_part_last=$8
> +
> +	local run_in_background=true
> +	local cnt=0
> +	local dst_addr dst_network dst_network_postfix ipv4_network_loop gateway2 lhost_ifname2 rhost_part task test_field_name
> +	local cmd_name="`get_cmd $cmd_type`"
> +	local gateway="$rhost_addr"
> +
> +	case $test_field in
> +	dst) test_field_name='destination' ;;
> +	gw) test_field_name='gateway' ;;
> +	if) test_field_name='interface' ;;
> +	*) tst_brkm TBROK "Unknown test parameter '$test_field'"
> +	esac
> +
> +	tst_resm TINFO "verify the kernel is not crashed when the $test_field_name of an IPv4 route is changed frequently by '$cmd_name' command $NS_TIMES times"
> +
> +	if [ "$test_field" = "if" ]; then
> +		link_num=0
> +		tst_resm TINFO "preparing connectivity $link_total times"
> +		while [ $link_num -lt $link_total ]; do
> +			lhost_ifname="$(get_lhost_ifname_loop $link_num)"
> +			ipv4_network_loop="${rhost_addr}.${link_num}"
> +			prepare_connectivity $lhost_ifname $link_num $ipv4_network_loop $LHOST_IPV4_HOST "$ipv4_network_loop.${LHOST_IPV4_HOST}"
> +		done

Hmm, may be I missed something but I didn't notice that the tests
use all the links, only $LINK_NUM, so I guessit is not necessary
tocomplicate setup with setting all the available links.

Thanks,
Alexey

