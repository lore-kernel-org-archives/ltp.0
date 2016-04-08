From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 8 Apr 2016 22:42:01 +0800
Subject: [LTP] [PATCHv4 3/3] network/stress/icmp: use ip xfrm for icmp
 uni-basic ipsec testing
In-Reply-To: <1460110369-30134-4-git-send-email-haliu@redhat.com>
References: <1460110369-30134-1-git-send-email-haliu@redhat.com>
 <1460110369-30134-4-git-send-email-haliu@redhat.com>
Message-ID: <20160408144201.GH20571@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

On Fri, Apr 08, 2016 at 06:12:49PM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@gmail.com>
> 
> Add icmp-uni-basic to implements the test case and define each test case in
> "runtests/" and use parameters. Also use ip xfrm instead of setkey for ipsec
> testing.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  runtest/network_stress.icmp                  |  28 +++---
>  testcases/network/stress/icmp/Makefile       |   3 +
>  testcases/network/stress/icmp/icmp-uni-basic | 132 +++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+), 14 deletions(-)
>  create mode 100755 testcases/network/stress/icmp/icmp-uni-basic
> 
> diff --git a/runtest/network_stress.icmp b/runtest/network_stress.icmp
> index 29b52d1..1803b21 100644
> --- a/runtest/network_stress.icmp
> +++ b/runtest/network_stress.icmp
> @@ -2,21 +2,21 @@
>  # Stress test for TCP/IP protocol stack (ICMP)
>  #
>  
> -icmp4-uni-basic01 icmp4-uni-basic01
> -icmp4-uni-basic02 icmp4-uni-basic02
> -icmp4-uni-basic03 icmp4-uni-basic03
> -icmp4-uni-basic04 icmp4-uni-basic04
> -icmp4-uni-basic05 icmp4-uni-basic05
> -icmp4-uni-basic06 icmp4-uni-basic06
> -icmp4-uni-basic07 icmp4-uni-basic07
> +icmp4-uni-basic01 icmp-uni-basic -s "10 100 1000 10000 65503"
                                                           ^^ typo here, should be 65507

> +icmp4-uni-basic02 icmp-uni-basic -p ah -m transport -s "10 100 1000 10000 65483"
> +icmp4-uni-basic03 icmp-uni-basic -p ah -m tunnel -s "10 100 1000 10000 65463"
> +icmp4-uni-basic04 icmp-uni-basic -p esp -m transport -s "10 100 1000 10000 65470"
> +icmp4-uni-basic05 icmp-uni-basic -p esp -m tunnel -s "10 100 1000 10000 65450"
> +icmp4-uni-basic06 icmp-uni-basic -p ipcomp -m transport -s "1000 10000 65000"
> +icmp4-uni-basic07 icmp-uni-basic -p ipcomp -m tunnel -s "1000 10000 65000"
>  
> -icmp6-uni-basic01 icmp6-uni-basic01
> -icmp6-uni-basic02 icmp6-uni-basic02
> -icmp6-uni-basic03 icmp6-uni-basic03
> -icmp6-uni-basic04 icmp6-uni-basic04
> -icmp6-uni-basic05 icmp6-uni-basic05
> -icmp6-uni-basic06 icmp6-uni-basic06
> -icmp6-uni-basic07 icmp6-uni-basic07
> +icmp6-uni-basic01 icmp-uni-basic -6 -s "10 100 1000 10000 65527"
> +icmp6-uni-basic02 icmp-uni-basic -6 -p ah -m transport -s "10 100 1000 10000 65503"
> +icmp6-uni-basic03 icmp-uni-basic -6 -p ah -m tunnel -s "10 100 1000 10000 65527"
> +icmp6-uni-basic04 icmp-uni-basic -6 -p esp -m transport -s "10 100 1000 10000 65494"
> +icmp6-uni-basic05 icmp-uni-basic -6 -p esp -m tunnel -s "10 100 1000 10000 65495"
> +icmp6-uni-basic06 icmp-uni-basic -6 -p ipcomp -m transport -s "1000 10000 65000"
> +icmp6-uni-basic07 icmp-uni-basic -6 -p ipcomp -m tunnel -s "1000 10000 65000"

The max message size for ipv6 is incorrect.

The pure ipv4 icmp max message is 65535 - 20(ipv4 hdr) - 8(icmp hdr) = 65507,
IPv4 ah + transport max message is 65535 - 20 - 24(ah hdr) - 8 = 65483.
The pure ipv6 icmp max message is 65535 - 8 = 65527.

What I mean is each IPsec mode/protocol have different max message size.
Should we calculate each size and test them or just use a commom size like
65000? How do you think.

BTW, this patch set's signoff info is incorrect. I will send a new version.
But it would be good if you could help review this patch set and give advice
first so I can fix them in next version.

Thanks
Hangbin

>  
>  icmp4-multi-diffip01 icmp4-multi-diffip01
>  icmp4-multi-diffip02 icmp4-multi-diffip02
> diff --git a/testcases/network/stress/icmp/Makefile b/testcases/network/stress/icmp/Makefile
> index 0dad1d1..9310aa1 100644
> --- a/testcases/network/stress/icmp/Makefile
> +++ b/testcases/network/stress/icmp/Makefile
> @@ -23,4 +23,7 @@
>  top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS		:= icmp*
> +
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/network/stress/icmp/icmp-uni-basic b/testcases/network/stress/icmp/icmp-uni-basic
> new file mode 100755
> index 0000000..de586d6
> --- /dev/null
> +++ b/testcases/network/stress/icmp/icmp-uni-basic
> @@ -0,0 +1,132 @@
> +#!/bin/sh
> +# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
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
> +#
> +# File:
> +#   icmp-uni-basic.sh
> +#
> +# Description:
> +#   Verify that the kernel is not crashed with receiving and sending various
> +#   size of ICMP message
> +#
> +#   *) This script may be read by the other test case
> +#
> +# Setup:
> +#   See ltp-yyyymmdd/testcases/network/stress/README
> +#
> +#-----------------------------------------------------------------------
> +# The test case ID, the test case count and the total number of test case
> +TCID=${TCID:-icmp-uni-basic}
> +TST_TOTAL=1
> +TST_COUNT=1
> +TST_CLEANUP="tst_ipsec_cleanup"
> +
> +. ipsec_lib.sh
> +
> +while getopts "hl:m:p:s:S:6" opt; do
> +	case "$opt" in
> +	h)
> +		echo "Usage:"
> +		echo "h        help"
> +		echo "l n      n is the number of test link when tests run"
> +		echo "m x      x is ipsec mode, could be transport / tunnel"
> +		echo "p x      x is ipsec protcol, could be ah / esp / ipcomp"
> +		echo "s x      x is icmp messge size array"
> +		echo "S n      n is IPsec SPI value"
> +		echo "6        run over IPv6"
> +		exit 0
> +	;;
> +	l) LINK_NUM=$OPTARG ;;
> +	m) IPSEC_MODE=$OPTARG ;;
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
> +ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
> +[ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ] && DO_IPSEC=true || DO_IPSEC=false
> +
> +#-----------------------------------------------------------------------
> +#
> +# Setup
> +#
> +
> +# Unset the maximum number of processes
> +ulimit -u unlimited
> +
> +# Test description
> +tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions"
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
> +lhost_ifname=`tst_iface lhost $LINK_NUM`
> +rhost_ifname=`tst_iface rhost $LINK_NUM`
> +
> +# Initialize the system configuration
> +tst_ipsec_cleanup
> +
> +# Call cleanup function before exit
> +trap tst_ipsec_cleanup 0
> +
> +lhost_addr=$(tst_ipaddr)
> +rhost_addr=$(tst_ipaddr rhost)
> +
> +# Configure SAD/SPD
> +if $DO_IPSEC ; then
> +	tst_ipsec lhost $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
> +	tst_ipsec rhost $IPSEC_PROTO $IPSEC_MODE $SPI $rhost_addr $lhost_addr
> +fi
> +
> +#-----------------------------------------------------------------------
> +#
> +# Main
> +#
> +#
> +
> +# Make sure the connectvity
> +tst_ping $lhost_ifname $rhost_addr $ICMP_SIZE_ARRAY
> +if [ $? -ne 0 ]; then
> +	tst_brkm TBROK "IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE connectivity"
> +else
> +	tst_resm TPASS "IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE connectivity"
> +fi
> +
> +#-----------------------------------------------------------------------
> +#
> +# Clean up
> +#
> +
> +tst_resm TPASS "Test is finished successfully."
> +exit 0
> -- 
> 2.5.0
> 

-- 

Thanks & Best Regards
Hangbin Liu <haliu@redhat.com>
Leo on #kernel-qe, #kernel, #eng-china
