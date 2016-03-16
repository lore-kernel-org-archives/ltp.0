From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Mar 2016 11:27:25 +0300
Subject: [LTP] [PATCHv2 2/3] network/stress: add ipsec lib
In-Reply-To: <1458035439-9143-3-git-send-email-haliu@redhat.com>
References: <1458035439-9143-1-git-send-email-haliu@redhat.com>
 <1458035439-9143-3-git-send-email-haliu@redhat.com>
Message-ID: <56E918ED.7040709@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 03/15/2016 12:50 PM, Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>   testcases/network/stress/ipsec/Makefile     |  29 +++++++
>   testcases/network/stress/ipsec/ipsec_lib.sh | 126 ++++++++++++++++++++++++++++
>   2 files changed, 155 insertions(+)
>   create mode 100644 testcases/network/stress/ipsec/Makefile
>   create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh
>
> diff --git a/testcases/network/stress/ipsec/Makefile b/testcases/network/stress/ipsec/Makefile
> new file mode 100644
> index 0000000..0d7f1b6
> --- /dev/null
> +++ b/testcases/network/stress/ipsec/Makefile
> @@ -0,0 +1,29 @@
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

Could be just "...program; If not, see <http://www.gnu.org/licenses/>."

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
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> new file mode 100644
> index 0000000..94b7a43
> --- /dev/null
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -0,0 +1,126 @@
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
> +. test_net.sh
> +
> +# c2x: convert charactor to hex
> +c2x()
> +{
> +	for str in $@; do
> +		for (( i=0; i<${#str}; i++ )); do
> +			printf '%x' "'${str:$i:1}"

Again, C-style 'for' not supported by dash. Please change according to
the previous comments.

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
> +	if [ "$1" = "flush" ]; then
> +		ROD ip xfrm state flush
> +		ROD ip xfrm policy flush
> +		tst_rhost_run -s -c "ip xfrm state flush && ip xfrm policy flush"
> +		return 0
> +	fi
> +	if [ $# -ne 6 ]; then
> +		tst_resm TINFO "tst_ipsec parameter mismatch"
> +		return 1
> +	fi
> +
> +	target=$1
> +	protocol=$2
> +	mode=$3
> +	first_spi=$4
> +	src_ipaddr=$5
> +	dst_ipaddr=$6
> +
> +	# Encryption algorithm
> +	EALGO="des3_ede"
> +	EALGO_KEY="0x$(c2x _I_want_to_have_chicken_)"
> +
> +	# Authentication algorithm
> +	AALGO="sha1"
> +	AALGO_KEY="0x$(c2x beef_fish_pork_salad)"
> +
> +	# Compression algorithm
> +	CALGO="deflate"
> +	# Algorithm options for each protocol
> +	case $protocol in
> +		ah)

Please don't use indent for 'ah)' and in all other cases.

Thanks,
Alexey

