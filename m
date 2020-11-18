From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Nov 2020 20:04:46 +0300
Subject: [LTP] [PATCH v2 1/3] network/stress/multicast/packet-flood:
 Update to new API
In-Reply-To: <20201117124320.783802-1-lkml@jv-coder.de>
References: <20201117124320.783802-1-lkml@jv-coder.de>
Message-ID: <057bc703-d3b6-5d8a-4831-609e332fdc36@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17.11.2020 15:43, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> 
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
...
> --- /dev/null
> +++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2006 International Business Machines  Corp.
> +# Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
> +# Author: Mitsuru Chinen <mitch@jp.ibm.com>
> +#
> +# Verify that the kernel is not crashed when joining a multicast group with
> +# a single socket, then receiving a large number of UDP packets at the socket
> +
> +TST_NEEDS_ROOT=1
> +. mcast-lib.sh
> +
> +do_setup()
> +{
> +	mcast_setup $MCASTNUM_NORMAL
> +	MCAST_LCMD=ns-mcast_receiver
> +	MCAST_RCMD=ns-udpsender
> +}
> +
> +do_test()
> +{
> +	local mcast_addr="$MCAST_IPV4_ADDR"
> +	[ "$TST_IPV6" ] && mcast_addr="$MCAST_IPV6_ADDR"
> +
> +	# Find the available consecutive ports
> +	local mcast_port=$(find_portbundle udp 1025 1)

Hi Joerg,

The following command should support both udp/udp6:

local mcast_port=$(tst_get_unused_port ipv${TST_IPVER} dgram)

> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "No free udp port available."
> +	fi
> +
> +	# Run a receiver
> +	ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $mcast_addr -p $mcast_port -b
> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "Failed to start multicast receiver"
> +	fi

This check can be replaced with

ROD ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $mcast_addr -p $mcast_port -b


> +
> +	# Run a sender
> +	tst_rhost_run -s -c "ns-udpsender -D $mcast_addr -f $TST_IPVER -p $mcast_port -s 32767 -m -I $(tst_iface rhost) -t $NS_DURATION"
> +

What if we swap sender and receiver, i.e.

local ns_opts="-f $TST_IPVER -p $mcast_port"

tst_rhost_run -s -c "ns-mcast_receiver $ns_opts -I $(tst_iface rhost) -m $mcast_addr -b"
EXPECT_PASS ns-udpsender -D $mcast_addr $ns_opts -s 32767 -m -I $(tst_iface) -t $NS_DURATION

By default, ltp is using network namespace, so it's probably better
to run the background service there.


> +	tst_res TPASS "Test finished successfully."

No need for it if using EXPECT_PASS as above.

> +}
> +
> +tst_run
> diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> new file mode 100755
> index 000000000..4ffde186b
> --- /dev/null
> +++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2006 International Business Machines  Corp.
> +# Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
> +# Author: Mitsuru Chinen <mitch@jp.ibm.com>
> +#
> +# Verify that the kernel is not crashed when joining multiple multicast
> +# groups on separate sockets, then receiving a large number of UDP
> +# packets at each socket
> +
> +TST_NEEDS_ROOT=1
> +. mcast-lib.sh
> +
> +do_setup()
> +{
> +	mcast_setup $MCASTNUM_NORMAL
> +	MCAST_LCMD=ns-mcast_receiver
> +	MCAST_RCMD=ns-udpsender
> +}
> +
> +do_test()
> +{
> +	local mcast_port_range=$(find_portbundle udp 1025 $MCASTNUM_NORMAL)
> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "Failed to find enough consecutive free udp ports."
> +	fi
> +	local mcast_port_top=$(echo $mcast_port_range | cut -f 1 -d '-')
> +
> +	local mcastnum=0
> +	while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
> +		local mcast_port=$((mcast_port_top + mcastnum))
                                       ^
I guess it's fine to use $(tst_get_unused_port ipv${TST_IPVER} dgram) here,
and removing getting the port range.

> +
> +		# Define the multicast address
> +		if [ "$TST_IPV6" ]; then
> +    		local mcastnum_hex=$(printf "%x" $mcastnum)
> +    		local mcast_addr=${MCAST_IPV6_ADDR_PREFIX}:${mcastnum_hex}
> +		else
> +			local x=$((mcastnum / 254))
> +			local y=$((mcastnum % 254 + 1))
> +			local mcast_addr=${MCAST_IPV4_ADDR_PREFIX}.${x}.${y}
> +		fi
> +
> +		# Run a receiver
> +		ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $mcast_addr -p $mcast_port -b
> +		if [ $? -ne 0 ]; then
> +			tst_brk TBROK "Failed to start multicast receiver"
> +		fi
> +
> +		# Run a sender
> +		tst_rhost_run -s -c "ns-udpsender -D $mcast_addr -f $TST_IPVER -p $mcast_port -m -I $(tst_iface rhost) -b -t $NS_DURATION"
> +
> +		: $((mcastnum += 1))

The same, better swap sender/receiver.

> +	done
> +
> +	sleep $NS_DURATION


It would be nice to have a small loop instead of a single 'sleep' and
periodically check that the background senders are really running...

> +
> +	tst_res TPASS "Test finished successfully."
> +}
> +
> +tst_run
