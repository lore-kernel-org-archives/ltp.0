From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Aug 2019 21:55:02 +0200
Subject: [LTP] [PATCH v3 4/5] network/route: Rewrite route-change-gw
 into new API
In-Reply-To: <89188a02-2213-bea7-5273-d0077de5878e@oracle.com>
References: <20190725111027.18716-1-pvorel@suse.cz>
 <20190725111027.18716-5-pvorel@suse.cz>
 <89188a02-2213-bea7-5273-d0077de5878e@oracle.com>
Message-ID: <20190806195502.GA11768@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,
> On 7/25/19 2:10 PM, Petr Vorel wrote:
> > * Drop route command (use just ip command), support both IPv4 and IPv6
> > * Use unused network range to avoid clash with real network
> > * Add verification with ping (previous version sent UDP datagram with
> > ns-udpsender, but didn't verify receiving it on rhost and didn't setup
> > rhost ip at all)

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/net_stress.route                      |   4 +-
> >  .../network/stress/route/00_Descriptions.txt  |  18 +-
> >  .../network/stress/route/route-change-gw      |  38 +++
> >  .../network/stress/route/route4-change-gw     | 292 ------------------
> >  .../network/stress/route/route6-change-gw     | 292 ------------------
> >  5 files changed, 43 insertions(+), 601 deletions(-)
> >  create mode 100755 testcases/network/stress/route/route-change-gw
> >  delete mode 100644 testcases/network/stress/route/route4-change-gw
> >  delete mode 100644 testcases/network/stress/route/route6-change-gw

> > ...
> > +
> > +# Change route gateway
> > +# lhost: 10.23.x.2, gw (on rhost): 10.23.x.1, rhost: 10.23.0.1
> > +
> > +TST_TESTFUNC="test_gw"
> > +. route-lib.sh
> > +
> > +setup()
> > +{
> > +	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
> > +
> > +	rt="$(tst_ipaddr_un -m 0 0)"
> > +	lhost="$(tst_ipaddr_un 1 1)"
> > +	rhost="$(tst_ipaddr_un 0 1)"
> > +	tst_add_ipaddr -s -a $lhost
> > +	tst_add_ipaddr -s -a $rhost rhost
> > +}
> > +
> > +test_gw()
> > +{
> > +	local gw="$(tst_ipaddr_un 1 $(($1 + 1)))"

> We should keep $(($1 + 1)) within the valid range except already added IP address
> ($lhost), i.e. for IPv4 the range is 2..254 for host id:

>     local gw="$(tst_ipaddr_un 1 $(($1 % 253 + 2)))"

> Either we could limit the value here or in the tst_ipaddr_un(). Looks like
> route-change-if needs a similar fix for net id?
Good point (sorry to keep octet/hextet overflow related errors).
Although it'd be simpler to fix it in the code, I'd prefer to have this support
in tst_ipaddr_un(). Diff below adds -l MIN_HOST_ID (I'll post it as a part of v3),
do we want to lower also max host id?


> > +	local iface="$(tst_iface)"
> > +
> > +	tst_res TINFO "testing route over gateway '$gw'"
> > +
> > +	tst_add_ipaddr -s -a $gw rhost
> > +	ROD ip route replace $rt dev $iface via $gw

> May be it would be cleaner to use "add" instead of "replace" since we remove it
> and it shouldn't exist before a test start.

> > +	EXPECT_PASS ping$TST_IPV6 -c1 -I $lhost $rhost

> It is better to redirect stdout to null:

> EXPECT_PASS ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null

> The same for *-if and *-dst.

Agree with all you pointed out.

> The rest in the patch-set looks good to me.


Kind regards,
Petr

commit 3a3ed9bc93c18d899a81b0f592eec4d4402984b1
Author: Petr Vorel <pvorel@suse.cz>
Date:   2019-08-06 16:58:28 +0200

    net/tst_ipaddr_un: Add -l MIN_HOST_ID support
    
    Signed-off-by: Petr Vorel <pvorel@suse.cz>

diff --git testcases/lib/tst_net.sh testcases/lib/tst_net.sh
index 714298797..50d64efca 100644
--- testcases/lib/tst_net.sh
+++ testcases/lib/tst_net.sh
@@ -361,11 +361,13 @@ tst_ipaddr()
 
 # Get IP address of unused network, specified either by type and counter
 # or by net and host.
-# tst_ipaddr_un [-cCOUNTER] [-m] [TYPE]
-# tst_ipaddr_un [-m] NET_ID [HOST_ID]
+# tst_ipaddr_un [-c COUNTER] [-l MIN_HOST_ID] [-m] [TYPE]
+# tst_ipaddr_un [-l MIN_HOST_ID] [-m] NET_ID [HOST_ID]
 #
 # OPTIONS
 # -c COUNTER: integer value for counting HOST_ID and NET_ID (default: 1)
+# -l MIN_HOST_ID: min HOST_ID allowed minimal HOST_ID (useful for loop which
+# overflow max HOST_ID)
 # -m: print also mask
 # TYPE: { lhost | rhost } (default: 'lhost')
 # NET_ID: integer or hex value of net (IPv4: 3rd octet, IPv6: 3rd hextet)
@@ -373,30 +375,39 @@ tst_ipaddr()
 # hextet, default: 0)
 tst_ipaddr_un()
 {
-	local counter host_id lower mask max_host_id max_net_id net_id tmp type
+	local counter host_id mask max_host_id max_net_id min_host_id net_id tmp type
 	local OPTIND
 
-	while getopts "c:m" opt; do
+	[ "$TST_IPV6" ] && max_net_id=65535 || max_net_id=255
+	max_host_id=$((max_net_id - 1))
+
+	while getopts "c:l:m" opt; do
 		case $opt in
 			c) counter="$OPTARG";;
-			l) lower="$OPTARG";;
+			l)
+				min_host_id="$OPTARG"
+				if ! tst_is_int "$min_host_id"; then
+					tst_brk TBROK "tst_ipaddr_un: -l must be integer ($min_host_id)"
+				fi
+				if [ $min_host_id -ge $max_host_id ]; then
+					tst_brk TBROK "tst_ipaddr_un: -l must be >= $max_host_id ($min_host_id)"
+				fi
+				;;
 			m) [ "$TST_IPV6" ] && mask="/64" || mask="/24";;
 		esac
 	done
 	shift $(($OPTIND - 1))
 
-	[ "$TST_IPV6" ] && max_net_id=65535 || max_net_id=255
-
 	# counter
 	if [ $# -eq 0 -o "$1" = "lhost" -o "$1" = "rhost" ]; then
 		[ -z "$counter" ] && counter=1
 		[ $counter -lt 1 ] && counter=1
 		type="${1:-lhost}"
-		max_host_id=$((max_net_id - 1))
 		tmp=$((counter * 2))
 		[ "$type" = "rhost" ] && tmp=$((tmp - 1))
 
 		host_id=$((tmp % max_host_id))
+
 		net_id=$((tmp / max_host_id))
 
 		if [ $host_id -eq 0 ]; then
@@ -415,7 +426,11 @@ tst_ipaddr_un()
 	fi
 
 	net_id=$((net_id % max_net_id))
+	if [ "$min_host_id" ]; then
+		host_id=$(( host_id % (max_host_id - min_host_id + 1) + min_host_id ))
+	else
 		host_id=$((host_id % max_net_id))
+	fi
 
 	if [ -z "$TST_IPV6" ]; then
 		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}${mask}"
