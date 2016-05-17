From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 May 2016 14:46:33 +0300
Subject: [LTP] [PATCH 1/4] network/stress/icmp: add icmp-multi-diffip.sh
 to implement diffip stress test
In-Reply-To: <1462780623-26778-1-git-send-email-haliu@redhat.com>
References: <1462780623-26778-1-git-send-email-haliu@redhat.com>
Message-ID: <573B0499.9020308@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 05/09/2016 10:57 AM, Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>   runtest/network_stress.icmp                        |  29 ++---
>   testcases/network/stress/icmp/icmp-multi-diffip.sh | 138 +++++++++++++++++++++
>   2 files changed, 153 insertions(+), 14 deletions(-)
>   create mode 100755 testcases/network/stress/icmp/icmp-multi-diffip.sh
>
> diff --git a/runtest/network_stress.icmp b/runtest/network_stress.icmp
> index 2b989b1..87feb74 100644
> --- a/runtest/network_stress.icmp
> +++ b/runtest/network_stress.icmp
> @@ -36,21 +36,22 @@ icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65
>   icmp6-uni-basic06 icmp-uni-basic.sh -6 -p ipcomp -m transport -s "10 100 1000 10000 65000"
>   icmp6-uni-basic07 icmp-uni-basic.sh -6 -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
>   
> -icmp4-multi-diffip01 icmp4-multi-diffip01
> -icmp4-multi-diffip02 icmp4-multi-diffip02
> -icmp4-multi-diffip03 icmp4-multi-diffip03
> -icmp4-multi-diffip04 icmp4-multi-diffip04
> -icmp4-multi-diffip05 icmp4-multi-diffip05
> -icmp4-multi-diffip06 icmp4-multi-diffip06
> -icmp4-multi-diffip07 icmp4-multi-diffip07
> +# networkstress.sh set IP_TOTAL=10000 by default, which is too much for these tests

if it is too much, I would rather check it in the script and set to the 
appropriate maximum.

> +icmp4-multi-diffip01 icmp-multi-diffip.sh -n 100
> +icmp4-multi-diffip02 icmp-multi-diffip.sh -n 100 -p ah -m transport
> +icmp4-multi-diffip03 icmp-multi-diffip.sh -n 100 -p ah -m tunnel
> +icmp4-multi-diffip04 icmp-multi-diffip.sh -n 100 -p esp -m transport
> +icmp4-multi-diffip05 icmp-multi-diffip.sh -n 100 -p esp -m tunnel
> +icmp4-multi-diffip06 icmp-multi-diffip.sh -n 100 -p ipcomp -m transport
> +icmp4-multi-diffip07 icmp-multi-diffip.sh -n 100 -p ipcomp -m tunnel
>   
> -icmp6-multi-diffip01 icmp6-multi-diffip01
> -icmp6-multi-diffip02 icmp6-multi-diffip02
> -icmp6-multi-diffip03 icmp6-multi-diffip03
> -icmp6-multi-diffip04 icmp6-multi-diffip04
> -icmp6-multi-diffip05 icmp6-multi-diffip05
> -icmp6-multi-diffip06 icmp6-multi-diffip06
> -icmp6-multi-diffip07 icmp6-multi-diffip07
> +icmp6-multi-diffip01 icmp-multi-diffip.sh -6 -n 100
> +icmp6-multi-diffip02 icmp-multi-diffip.sh -6 -n 100 -p ah -m transport
> +icmp6-multi-diffip03 icmp-multi-diffip.sh -6 -n 100 -p ah -m tunnel
> +icmp6-multi-diffip04 icmp-multi-diffip.sh -6 -n 100 -p esp -m transport
> +icmp6-multi-diffip05 icmp-multi-diffip.sh -6 -n 100 -p esp -m tunnel
> +icmp6-multi-diffip06 icmp-multi-diffip.sh -6 -n 100 -p ipcomp -m transport
> +icmp6-multi-diffip07 icmp-multi-diffip.sh -6 -n 100 -p ipcomp -m tunnel
>   
>   icmp4-multi-diffnic01 icmp4-multi-diffnic01
>   icmp4-multi-diffnic02 icmp4-multi-diffnic02
> diff --git a/testcases/network/stress/icmp/icmp-multi-diffip.sh b/testcases/network/stress/icmp/icmp-multi-diffip.sh
> new file mode 100755
> index 0000000..f6f5f4b
> --- /dev/null
> +++ b/testcases/network/stress/icmp/icmp-multi-diffip.sh
> @@ -0,0 +1,138 @@
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
> +TCID=${TCID:-icmp-multi-diffip}
> +TST_TOTAL=1
> +TST_COUNT=1
> +TST_CLEANUP="do_cleanup"
> +
> +. ipsec_lib.sh
> +
> +while getopts "hl:m:n:N:p:s:S:6" opt; do
> +	case "$opt" in
> +	h)
> +		echo "Usage:"
> +		echo "h        help"
> +		echo "l n      n is the number of test link when tests run"
> +		echo "m x      x is ipsec mode, could be transport / tunnel"
> +		echo "n n      n is number of total ip addresses for testing"
> +		echo "N n      n is seconds of the network stress duration time"
> +		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
> +		echo "s x      x is icmp messge size array"
> +		echo "S n      n is IPsec SPI value"
> +		echo "6        run over IPv6"
> +		exit 0
> +	;;
> +	l) LINK_NUM=$OPTARG ;;
> +	m) IPSEC_MODE=$OPTARG ;;
> +	n) IP_TOTAL=$OPTARG ;;
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
> +IP_TOTAL=${IP_TOTAL:-100}
> +DO_IPSEC=${DO_IPSEC:-false}
> +NS_DURATION=${NS_DURATION:-"3600"}
> +# Use large enough pkt size(65000) to fix each encapsulation
> +ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65000"}
> +[ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ] && DO_IPSEC=true || DO_IPSEC=false
> +
> +do_cleanup()
> +{
> +	pkill -9 ping$TST_IPV6 &> /dev/null
> +	tst_ipsec_cleanup
> +	# Clean up each interface
> +	tst_restore_ipaddr lhost ${LINK_NUM}
> +	tst_restore_ipaddr rhost ${LINK_NUM}
> +}
> +
> +# Test description
> +tst_resm TINFO "Sending ICMP messages with the following conditions"
> +tst_resm TINFO "- Target number of the connection is $IP_TOTAL"
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
> +lhost_iface=$(tst_iface lhost $LINK_NUM)
> +rhost_iface=$(tst_iface rhost $LINK_NUM)
> +
> +[ "$TST_IPV6" ] && netmask=64 || netmask=30
> +for cnt in $(seq $IP_TOTAL); do
> +	x=`expr $cnt \/ 64 % 255`
> +	y=`expr $cnt % 64 \* 4 + 1`
> +	if [ $x -ge 255 ]; then
> +		tst_resm TCONF "This script cannot add more than $cnt addresses"
> +		break
> +	fi
> +	if [ "$TST_IPV6" ]; then
> +		lhost_addr=${IPV6_NET32_UNUSED}:$x:$y:${LHOST_IPV6_HOST}
> +		rhost_addr=${IPV6_NET32_UNUSED}:$x:$y:${RHOST_IPV6_HOST}
> +	else
> +		lhost_addr=${IPV4_NET16_UNUSED}.$x.$y
> +		rhost_addr=${IPV4_NET16_UNUSED}.$x.$(($y + 1))
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
> +	tst_ping $lhost_iface $rhost_addr
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask $IPSEC_PROTO $IPSEC_MODE connectivity"

proto/mode were printed in the beginning of the test so it seems 
redundant to print it again and again during the test.

> +	else
> +		tst_resm TPASS "IPv${TST_IPV6:-4} $lhost_addr/$netmask -- $rhost_addr/$netmask $IPSEC_PROTO $IPSEC_MODE connectivity"
> +	fi

TST_TOTAL doesn't match TPASS/TFAIL assertions.

> +	rhost_addr_array[$cnt]=$rhost_addr

Please don't use arrays, it's a bash extension.

> +done
> +
> +# Do Stress testing, ping flood
> +tst_resm TINFO "start ping flood stress testing"
> +for rhost_addr in ${rhost_addr_array[@]}; do
> +	for size in ${ICMP_SIZE_ARRAY}; do
> +		ping$TST_IPV6 -f -q -I $lhost_iface $rhost_addr -s $size &> /dev/null &
> +	done
> +done
> +
> +sleep ${NS_DURATION}
> +
> +tst_resm TPASS "$TCID IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE stress test"

Is the test always passing here with no checks?

Why we need to print $TCID?

> +tst_exit

Thanks,
Alexey

