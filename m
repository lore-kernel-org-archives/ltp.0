From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 May 2016 14:18:48 +0300
Subject: [LTP] [PATCH 3/4] network/stress/icmp: add
 icmp-multi-diffnic.sh to implement diffnic stress test
In-Reply-To: <1462780623-26778-3-git-send-email-haliu@redhat.com>
References: <1462780623-26778-1-git-send-email-haliu@redhat.com>
 <1462780623-26778-3-git-send-email-haliu@redhat.com>
Message-ID: <573AFE18.2080009@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 05/09/2016 10:57 AM, Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>   runtest/network_stress.icmp                        |  28 ++--
>   .../network/stress/icmp/icmp-multi-diffnic.sh      | 153 +++++++++++++++++++++
>   2 files changed, 167 insertions(+), 14 deletions(-)
>   create mode 100755 testcases/network/stress/icmp/icmp-multi-diffnic.sh
>
> diff --git a/runtest/network_stress.icmp b/runtest/network_stress.icmp
> index 87feb74..58d1dd8 100644
> --- a/runtest/network_stress.icmp
> +++ b/runtest/network_stress.icmp
> @@ -53,18 +53,18 @@ icmp6-multi-diffip05 icmp-multi-diffip.sh -6 -n 100 -p esp -m tunnel
>   icmp6-multi-diffip06 icmp-multi-diffip.sh -6 -n 100 -p ipcomp -m transport
>   icmp6-multi-diffip07 icmp-multi-diffip.sh -6 -n 100 -p ipcomp -m tunnel
>   
> -icmp4-multi-diffnic01 icmp4-multi-diffnic01
> -icmp4-multi-diffnic02 icmp4-multi-diffnic02
> -icmp4-multi-diffnic03 icmp4-multi-diffnic03
> -icmp4-multi-diffnic04 icmp4-multi-diffnic04
> -icmp4-multi-diffnic05 icmp4-multi-diffnic05
> -icmp4-multi-diffnic06 icmp4-multi-diffnic06
> -icmp4-multi-diffnic07 icmp4-multi-diffnic07
> +icmp4-multi-diffnic01 icmp-multi-diffnic.sh
> +icmp4-multi-diffnic02 icmp-multi-diffnic.sh -p ah -m transport
> +icmp4-multi-diffnic03 icmp-multi-diffnic.sh -p ah -m tunnel
> +icmp4-multi-diffnic04 icmp-multi-diffnic.sh -p esp -m transport
> +icmp4-multi-diffnic05 icmp-multi-diffnic.sh -p esp -m tunnel
> +icmp4-multi-diffnic06 icmp-multi-diffnic.sh -p ipcomp -m transport
> +icmp4-multi-diffnic07 icmp-multi-diffnic.sh -p ipcomp -m tunnel
>   
> -icmp6-multi-diffnic01 icmp6-multi-diffnic01
> -icmp6-multi-diffnic02 icmp6-multi-diffnic02
> -icmp6-multi-diffnic03 icmp6-multi-diffnic03
> -icmp6-multi-diffnic04 icmp6-multi-diffnic04
> -icmp6-multi-diffnic05 icmp6-multi-diffnic05
> -icmp6-multi-diffnic06 icmp6-multi-diffnic06
> -icmp6-multi-diffnic07 icmp6-multi-diffnic07
> +icmp6-multi-diffnic01 icmp-multi-diffnic.sh -6
> +icmp6-multi-diffnic02 icmp-multi-diffnic.sh -6 -p ah -m transport
> +icmp6-multi-diffnic03 icmp-multi-diffnic.sh -6 -p ah -m tunnel
> +icmp6-multi-diffnic04 icmp-multi-diffnic.sh -6 -p esp -m transport
> +icmp6-multi-diffnic05 icmp-multi-diffnic.sh -6 -p esp -m tunnel
> +icmp6-multi-diffnic06 icmp-multi-diffnic.sh -6 -p ipcomp -m transport
> +icmp6-multi-diffnic07 icmp-multi-diffnic.sh -6 -p ipcomp -m tunnel
> diff --git a/testcases/network/stress/icmp/icmp-multi-diffnic.sh b/testcases/network/stress/icmp/icmp-multi-diffnic.sh
> new file mode 100755
> index 0000000..c149ca4
> --- /dev/null
> +++ b/testcases/network/stress/icmp/icmp-multi-diffnic.sh
> @@ -0,0 +1,153 @@
> +#!/bin/sh
> +# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
> +# Copyright (c) International Business Machines  Corp., 2005
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
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +#
> +# Author: Hangbin Liu <haliu@redhat.com>
> +#
> +################################################################################
> +TCID=${TCID:-icmp-multi-diffnic}
> +TST_TOTAL=1
> +TST_COUNT=1
> +TST_CLEANUP="do_cleanup"
> +
> +. ipsec_lib.sh
> +
> +while getopts "hl:m:n:N:p:s:S:6" opt; do
there is no option 'n'
> +	case "$opt" in
> +	h)
> +		echo "Usage:"
> +		echo "h        help"
> +		echo "l n      n is the number of test link when tests run"
> +		echo "m x      x is ipsec mode, could be transport / tunnel"
> +		echo "N n      n is seconds of the network stress duration time"
> +		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
> +		echo "s x      x is icmp messge size array"
> +		echo "S n      n is IPsec SPI value"
> +		echo "6        run over IPv6"
> +		exit 0
> +	;;
> +	l) LINK_NUM=$OPTARG ;;
> +	m) IPSEC_MODE=$OPTARG ;;
> +	N) NS_DURATION=$OPTARG ;;
> +	p) IPSEC_PROTO=$OPTARG ;;
> +	s) ICMP_SIZE_ARRAY=$OPTARG ;;
> +	S) SPI=$OPTARG ;;
> +	6) # skip, test_net library already processed it
> +	;;
> +	*) tst_brkm TBROK "unknown option: $opt" ;;
> +	esac
> +done
> +
> +SPI=${SPI:-1000}
> +LINK_NUM=${LINK_NUM:-0}
> +DO_IPSEC=${DO_IPSEC:-false}
> +NS_DURATION=${NS_DURATION:-"3600"}
> +# Use large enough pkt size(65000) to fix each encapsulation
> +ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65000"}
> +[ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ] && DO_IPSEC=true || DO_IPSEC=false
> +
> +link_total=`echo $LHOST_HWADDRS | wc -w`
> +rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
> +if [ $link_total -ne $rhost_link_total ]; then
> +	tst_brkm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
> +elif [ $link_total -lt 2 ]; then
> +	tst_brkm TBROK "This test case requires plural NICs."
> +fi
> +

Should we check that the number of interfaces more then 1, otherwise 
exit with TCONF?
.. not TBROK

Hmm, what is the difference between running those tests

LHOST_IFACE=eth1 ... ./icmp_uni_basic.sh &
LHOST_IFACE=eth2 ... ./icmp_uni_basic.sh &
...

and running multinic script?

Thanks,
Alexey

> +do_cleanup()
> +{
> +	pkill -9 ping$TST_IPV6 &> /dev/null
> +	tst_ipsec_cleanup
> +	# Clean up each interface
> +	link_num=0
> +	while [ $link_num -lt $link_total ]; do
> +		tst_init_iface lhost ${link_num}
> +		tst_init_iface rhost ${link_num}
> +		link_num=`expr $link_num + 1`
> +	done
> +	tst_restore_ipaddr lhost
> +	tst_restore_ipaddr rhost
> +}
> +
> +# Test description
> +tst_resm TINFO "Sending ICMP messages with the following conditions"
> +tst_resm TINFO "- Target number of interfaces is $link_total"
> +tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
> +tst_resm TINFO "- Size of packets are ( $ICMP_SIZE_ARRAY )"
> +
> +if $DO_IPSEC; then
> +	case $IPSEC_PROTO in
> +	ah)	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]" ;;
> +	esp)	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]" ;;
> +	ipcomp)	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]" ;;
> +	esac
> +fi
> +
> +# name of interface of the local/remote host
> +lhost_iface=`tst_iface lhost $LINK_NUM`
> +rhost_iface=`tst_iface rhost $LINK_NUM`
> +
> +# Loop for NIC configuration
> +[ "$TST_IPV6" ] && netmask=64 || netmask=24
> +for link_num in `seq 0 $((link_total - 1))`; do
> +	# name of interface of the local/remote host
> +	lhost_iface=`tst_iface lhost $link_num`
> +	rhost_iface=`tst_iface rhost $link_num`
> +
> +	if [ "$TST_IPV6" ]; then
> +		lhost_addr=${IPV6_NET32_UNUSED}:${link_num}:${LHOST_IPV6_HOST}
> +		rhost_addr=${IPV6_NET32_UNUSED}:${link_num}:${RHOST_IPV6_HOST}
> +	else
> +		lhost_addr=${IPV4_NET16_UNUSED}.${link_num}.${LHOST_IPV4_HOST}
> +		rhost_addr=${IPV4_NET16_UNUSED}.${link_num}.${RHOST_IPV4_HOST}
> +	fi
> +	ROD ip addr add $lhost_addr/$netmask dev $lhost_iface
> +	tst_rhost_run -s -c "ip addr add $rhost_addr/$netmask dev $rhost_iface"
> +
> +	# Configure SAD/SPD
> +	if $DO_IPSEC ; then
> +		tst_ipsec lhost $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
> +		tst_ipsec rhost $IPSEC_PROTO $IPSEC_MODE $SPI $rhost_addr $lhost_addr
> +	fi
> +
> +	# Make sure the connectvity
> +	if [ "$IPSEC_PROTO" == ipcomp ]; then
> +		tst_ping $lhost_iface $rhost_addr 2000
> +	else
> +		tst_ping $lhost_iface $rhost_addr
> +	fi
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask $IPSEC_PROTO $IPSEC_MODE connectivity"
> +	else
> +		tst_resm TPASS "IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask $IPSEC_PROTO $IPSEC_MODE connectivity"
> +	fi
> +
> +	lhost_iface_array[$link_num]=$lhost_iface
> +	rhost_addr_array[$link_num]=$rhost_addr
> +done
> +
> +# Do Stress testing, ping flood
> +tst_resm TINFO "start ping flood stress testing"
> +for link_num in `seq 0 $((link_total - 1))`; do
> +	for size in ${ICMP_SIZE_ARRAY}; do
> +		ping$TST_IPV6 -f -q -I ${lhost_iface_array[$link_num]} \
> +			${rhost_addr_array[$link_num]} -s $size &> /dev/null &
> +	done
> +done
> +
> +sleep ${NS_DURATION}
> +
> +tst_exit

