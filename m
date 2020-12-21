From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Dec 2020 23:18:38 +0100
Subject: [LTP] [PATCH v3 1/3] network/stress/multicast/packet-flood:
 Update to new API
In-Reply-To: <20201125053459.3314021-1-lkml@jv-coder.de>
References: <20201125053459.3314021-1-lkml@jv-coder.de>
Message-ID: <20201221221838.GC4453@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,


Minor comments, please update them if v4 needed.
Otherwise it can be fixed during merge.
Thanks for your work.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> @@ -0,0 +1,55 @@
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
> +	mcast_setup $n_NORMAL


This should be (error during global replace):

	mcast_setup $MCASTNUM_NORMAL

> +	MCAST_LCMD=ns-mcast_receiver
> +	MCAST_RCMD=ns-udpsender
> +}
> +
> +do_test()
> +{
> +	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv${TST_IPVER} multicast groups on separate sockets, then receiving a large number of UDP packets at each socket in $NS_DURATION seconds"
I'd prefer these drop boilerplate "Verify that the kernel is not crashed when"
+ the same in the description at the top of the file.

> +
> +	local n=0
> +	while [ $n -lt $MCASTNUM_NORMAL ]; do
> +		# Define the multicast address
> +		if [ "$TST_IPV6" ]; then
> +    		local n_hex=$(printf "%x" $n)
> +    		local addr=${MCAST_IPV6_ADDR_PREFIX}:${n_hex}
nit: wrong indent

> +		else
> +			local x=$((n / 254))
> +			local y=$((n % 254 + 1))
> +			local addr=${MCAST_IPV4_ADDR_PREFIX}.${x}.${y}
> +		fi
> +
> +		local port=$(tst_get_unused_port ipv${TST_IPVER} dgram)
> +		[ $? -ne 0 ] && tst_brk TBROK "No free udp port available."
nit: no dot please.

> +		tst_res TINFO Port: $port
This should be quoted.

> +
> +		# Run a receiver
> +		ROD ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $addr -p $port -b
> +	
> +		# Run a sender
> +		tst_rhost_run -s -c "ns-udpsender -D $addr -f $TST_IPVER -p $port -m -I $(tst_iface rhost) -b -t $NS_DURATION"
> +
> +		: $((n += 1))
sure this works, but I'd prefer:
n=$((n += 1))
> +	done

The rest LGTM.
