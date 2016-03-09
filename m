From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 09 Mar 2016 15:42:06 +0300
Subject: [LTP] [PATCH 2/3] network/stress: add ipsec lib
In-Reply-To: <1457334883-11086-3-git-send-email-haliu@redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-3-git-send-email-haliu@redhat.com>
Message-ID: <56E01A1E.4070401@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 03/07/2016 10:14 AM, Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>   testcases/network/stress/ipsec/Makefile     |  31 +++++++
>   testcases/network/stress/ipsec/ipsec_lib.sh | 134 ++++++++++++++++++++++++++++
>   2 files changed, 165 insertions(+)
>   create mode 100644 testcases/network/stress/ipsec/Makefile
>   create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh
>
> diff --git a/testcases/network/stress/ipsec/Makefile b/testcases/network/stress/ipsec/Makefile
> new file mode 100644
> index 0000000..b3a1657
> --- /dev/null
> +++ b/testcases/network/stress/ipsec/Makefile
> @@ -0,0 +1,31 @@
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
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +# Author: Hangbin Liu <haliu@redhat.com>
> +#
> +#######################################################################
> +
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS		:= *.sh
> +
> +MAKE_TARGETS		:=

It can be removed.

> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> new file mode 100644
> index 0000000..feeecf9
> --- /dev/null
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -0,0 +1,134 @@
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
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +# Author: Hangbin Liu <haliu@redhat.com>
> +#
> +#######################################################################
> +
> +#Uncomment line below for debug output.
> +#trace_logic=${trace_logic:-"set -x"}
> +$trace_logic
> +

Not used anymore, can be removed.

> +# Make sure the value of LTPROOT
> +LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
> +export LTPROOT

It's not needed, test.sh (which included by test_net.sh) has all checksfor
LTPROOT

> +. test_net.sh
> +
> +# c2x: convert charactor to hex
> +c2x()
> +{
> +	for str in $@; do
> +		for (( i=0; i<${#str}; i++ )); do

Not portable "for (());", could be changed to "for i in $(seq 0 
${#str}); do.

> +			c=${str:$i:1}
> +			printf '%x' "'$c"

c var is redundant, we can substitute "$c" with "${str:$i:1}"

> +		done
> +	done
> +}
> +
> +# tst_ipsec flush: flush the ipsec state and policy
> +# tst_ipsec target protocol mode first_spi src_addr dst_addr: config ipsec
> +#
> +# target: target of the configuration file ( src / dst )
> +# protocol: ah / esp / ipcomp
> +# mode: transport / tunnel
> +# first_spi: the first spi value
> +# src_addr: source IP address
> +# dst_addr: destination IP address
> +tst_ipsec()
> +{
> +	if [ x$1 = x"flush" ]; then

if [ "$1" = "flush"]; then

> +		ip xfrm state flush && ip xfrm policy flush
> +		tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
> +		return 0


I would run each ip commands with ROD "ip ..." and tst_rhost_run with -s 
option.
In that way, if command fails, test will exit with TBROK.

Thanks,
Alexey
