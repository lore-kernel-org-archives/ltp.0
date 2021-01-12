From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 12:31:34 +0100
Subject: [LTP] [PATCH v3 1/3] network/stress/multicast/packet-flood:
 Update to new API
In-Reply-To: <d575ea47-142c-2ff3-1a55-58fc8f55801b@jv-coder.de>
References: <20201125053459.3314021-1-lkml@jv-coder.de>
 <20201221221838.GC4453@pevik>
 <d575ea47-142c-2ff3-1a55-58fc8f55801b@jv-coder.de>
Message-ID: <X/2IlsUpmW6+kK/N@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> > Minor comments, please update them if v4 needed.
> > Otherwise it can be fixed during merge.
> > Thanks for your work.
> I don't think I'll submit a v4, if you want to fix this during merge, it is
> ok to me.
Don't worry with v4, I'll fix all these tiny style issues.

I'll also implement restoring sysctl value in route-redirect.sh.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr

> > > +++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
> > > @@ -0,0 +1,55 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +# Copyright (c) 2006 International Business Machines  Corp.
> > > +# Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
> > > +# Author: Mitsuru Chinen <mitch@jp.ibm.com>
> > > +#
> > > +# Verify that the kernel is not crashed when joining multiple multicast
> > > +# groups on separate sockets, then receiving a large number of UDP
> > > +# packets at each socket
> > > +
> > > +TST_NEEDS_ROOT=1
> > > +. mcast-lib.sh
> > > +
> > > +do_setup()
> > > +{
> > > +	mcast_setup $n_NORMAL

> > This should be (error during global replace):

> > 	mcast_setup $MCASTNUM_NORMAL
> Yes sorry...
np

> > > +	MCAST_LCMD=ns-mcast_receiver
> > > +	MCAST_RCMD=ns-udpsender
> > > +}
> > > +
> > > +do_test()
> > > +{
> > > +	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv${TST_IPVER} multicast groups on separate sockets, then receiving a large number of UDP packets at each socket in $NS_DURATION seconds"
> > I'd prefer these drop boilerplate "Verify that the kernel is not crashed when"
> > + the same in the description at the top of the file.
> Do you want this completely removed? I added this, because you asked me to
> in v2?
I added into my version:
	tst_res TINFO "joining $MCASTNUM_NORMAL IPv${TST_IPVER} multicast groups on separate sockets, then receiving a large number of UDP packets at each socket in $NS_DURATION seconds"

i.e. remove boilerplate "Verify that the kernel is not crashed when".

> > > +
> > > +	local n=0
> > > +	while [ $n -lt $MCASTNUM_NORMAL ]; do
> > > +		# Define the multicast address
> > > +		if [ "$TST_IPV6" ]; then
> > > +    		local n_hex=$(printf "%x" $n)
> > > +    		local addr=${MCAST_IPV6_ADDR_PREFIX}:${n_hex}
> > nit: wrong indent
> Strange ;)
It easily happens when you modify existing test (I had the same in my last
patchset). Anyway, no problem.

> > > +		else
> > > +			local x=$((n / 254))
> > > +			local y=$((n % 254 + 1))
> > > +			local addr=${MCAST_IPV4_ADDR_PREFIX}.${x}.${y}
> > > +		fi
> > > +
> > > +		local port=$(tst_get_unused_port ipv${TST_IPVER} dgram)
> > > +		[ $? -ne 0 ] && tst_brk TBROK "No free udp port available."
> > nit: no dot please.

> > > +		tst_res TINFO Port: $port
> > This should be quoted.
> Could also be removed. I guess this was for testing...
+1

Kind regards,
Petr
