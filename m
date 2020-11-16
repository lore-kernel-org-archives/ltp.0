From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 16 Nov 2020 20:31:30 +0100
Subject: [LTP] [PATCH 1/3] network/stress/mutlicast/packet-flood: Update
 to tst_net.sh
In-Reply-To: <20201116124611.16919-2-lkml@jv-coder.de>
References: <20201116124611.16919-1-lkml@jv-coder.de>
 <20201116124611.16919-2-lkml@jv-coder.de>
Message-ID: <20201116193130.GA181383@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>  .../multicast/packet-flood/mcast4-pktfld01    | 114 ++++-------------
>  .../multicast/packet-flood/mcast4-pktfld02    | 116 ++++--------------
>  .../multicast/packet-flood/mcast6-pktfld01    | 112 ++++-------------
>  .../multicast/packet-flood/mcast6-pktfld02    | 114 ++++-------------
Thanks a lot!
Could you please merge files into single one:
mcast{4,6}-pktfld01 => mcast-pktfld01
mcast{4,6}-pktfld02 => mcast-pktfld02

as done previously in other multicast and route tests?

Could you also add ".sh" extension to the files? (it's then obvious it's shell,
not a compiled binary).

NOTE: $TST_IPVER is often used.

Also, please remove all bogus comments like GPL verbose text (replaced by SPDX)
and also bogus comments like:
# Test description

The comment at the top should be small, e.g.:
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) International Business Machines  Corp., 2006
# your copyright
# Author: Mitsuru Chinen <mitch@jp.ibm.com>

# joining a IPv4/IPv6 multicast group on a single socket, then receiving a large
# number of UDP packets at the socket

You also mix tabs and spaces. We usually prefer tabs, but please reformat whole
file.

>  4 files changed, 85 insertions(+), 371 deletions(-)

> diff --git a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01 b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
> index c1ee513d4..20284569d 100644
> --- a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
> +++ b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
> @@ -42,41 +42,20 @@
>  #trace_logic=${trace_logic:-"set -x"}
>  $trace_logic
Please remove this.

> -# The test case ID, the test case count and the total number of test case
> -TCID=mcast4-pktfld01
> -TST_TOTAL=1
> -TST_COUNT=1
> -export TCID
> -export TST_COUNT
> -export TST_TOTAL
> -
> -# Make sure the value of LTPROOT
> -LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
> -export LTPROOT
> -
> -# Check the environmanet variable
> -. check_envval || exit $TST_TOTAL
> -
> -# Dulation of the test [sec]
> -NS_DURATION=${NS_DURATION:-3600}      # 1 hour
> +TST_TESTFUNC=test_body
> +TST_NEEDS_ROOT=1
> +TST_SETUP=do_setup
> +TST_CLEANUP=do_cleanup

>  # The number of the test link where tests run
>  LINK_NUM=${LINK_NUM:-0}
LINK_NUM is not needed

> -# Network portion of the IPv4 address
> -NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
> -
> -# Netmask of the IPv4 network
> -NETWORK_MASK=24
> -
> -# Host portion of the IPv4 address
> -LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
> -RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
> -
>  # Multicast Address
>  MCAST_ADDR=224.10.0.1
MCAST_ADDR is replaced by MCAST_IPV{4,6}_ADDR in tst_net_stress.sh (which is
used by mcast-lib.sh, see below).

> +. tst_net.sh

NOTE:
other multicast tests use
testcases/network/stress/multicast/grp-operation/mcast-lib.sh, which also uses
testcases/network/stress/ns-tools/tst_net_stress.sh. I wrote them some time ago
(today I'd do things differently), they deserve cleanup (so does also my rewrite
of multicast stress tests). Even they're not perfect, it'd be probably better to
use it to avoid redundancy.

>  # Function: do_cleanup
> @@ -89,11 +68,7 @@ do_cleanup()
>  {
>      # Make sure to kill the multicast receiver and sender
>      killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
> -    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
> -
> -    # Clean up each interface
> -    initialize_if lhost ${LINK_NUM}
> -    initialize_if rhost ${LINK_NUM}
> +	tst_rhost_run -c "killall -SIGHUP ns-udpsender >/dev/null 2>&1"
>  }
Also cleanup is handled safer (if I remember correctly using killall -SIGHUP in
original do_cleanup() does not work).


> @@ -107,57 +82,15 @@ do_cleanup()
>  #-----------------------------------------------------------------------
>  do_setup()
>  {
> -    # Initialize the system configuration
> -    do_cleanup
> -
> -    # Call do_cleanup function before exit
> -    trap do_cleanup 0
> +	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
Also {l,r}host_ifname is not needed. You use $(tst_iface rhost) for -I
parameter, see mcast_setup() in mcast-lib.sh.

Kind regards,
Petr
