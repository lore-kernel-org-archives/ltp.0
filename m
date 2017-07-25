From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Jul 2017 18:19:27 +0200
Subject: [LTP] [RFC PATCH v7 06/11] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <0dcefc85-5c3e-f8e4-12f0-4b3f61a63bde@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-7-pvorel@suse.cz>
 <0dcefc85-5c3e-f8e4-12f0-4b3f61a63bde@oracle.com>
Message-ID: <20170725161927.h2ufen4cji3iluux@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thank you for your review.

> > +	if [ "$increase_max" ]; then
> > +		# Increase the maximum number of open file descriptors
> > +		[ `ulimit -n` -lt $igmp_max_memberships ] && ROD ulimit -n $igmp_max_memberships
> > +	fi
> > +
> > +	tst_add_ipaddr_stress
> > +	tst_add_ipaddr_stress rhost

 This is very strange, the test adds a new pair of addresses and then
> runs ping in setup. After that they not used...

> By the way, we already have IP addresses defined by IPV4_HOST variables,
> better use them if needed.
I thought that it'd be more secure to use "unused network" also for multicast. OK, I'll
use regular IP addresses.
BTW would you use "unused network"? with tests in testcases/network/stress/ than route and
interface?

> > +	check_connectivity $iface $RHOST_IPV4_UNUSED

> No need for this test.
OK (copied from your interface tests).


...
> > +mcast_cleanup()
> > +{
> > +	local iface=$(tst_iface)
...

> > +do_multicast_test_multiple_join()
> > +{
> > +	local igmp_max_memberships="$1"
> > +	local iface=$(tst_iface)
> > +	local riface=$(tst_iface rhost)

> I would rather use those functions inline.
OK.

> > +	local param_multi_socket ret tmpfile
> > +
> > +	[ "${2:-}" = true ] && param_multi_socket="-m"
> > +
> > +	# Run a multicast join tool
> > +	tmpfile=ns-mcast_join.$$
> > +
> > +	EXPECT_PASS ns-mcast_join $param_multi_socket -f 4 -I $iface -n $igmp_max_memberships -p $MCAST_IPV4_ADDR_PREFIX > $tmpfile

> EXPECT_PASS ... \> $tmpfile
Eh, silly mistake.

> > +
> > +	tst_resm TINFO "joined $(grep groups $tmpfile)"
> > +
> > +	# Send IGMP General Query from the remote host
> > +	EXPECT_RHOST_PASS ns-igmp_querier -I $riface -o -r 1

> We need to use the address defined with the prefix
> $MCAST_IPV4_ADDR_PREFIX above otherwise we won't get a reply, i.e. "-m
> $MCAST_IPV4_ADDR"
Right, thanks. It was broken in original code. Trying to read ns-mcast_join.c and
ns-igmp_querier.c, but still not sure I fully understand tham. Hope the other flags are
correct (e.g. not missing MCAST_IPV4_ADDR_PREFIX resp. MCAST_IPV4_ADDR).

> > +}
> > +
> > +do_multicast_test_join_leave()
> > +{
> > +	local iface=$(tst_iface)
> > +	local riface=$(tst_iface rhost)
> > +	local define_source_address filter num ret source_addr x y
> > +
> > +	[ "$1" = true ] && define_source_address=true
> > +
> > +	# Send IGMP General Query from the remote host
> > +	tst_rhost_run -s -c "ns-igmp_querier -I $riface -i 1000000000 -r 1 -b"
> > +
> > +	# Run a multicast join tool
> > +	num=0
> > +	while [ $num -lt $MCASTNUM_NORMAL ]; do
> > +		if [ "$define_source_address" ]; then
> > +			x=$(($num / 254))
> > +			y=$(($num % 254 + 1))
> > +			if [ $x -gt 254 ]; then
> > +				tst_resm TINFO "the number of the connection is less than $num"
> > +				break
> > +			fi
> > +			source_addr="${IPV4_NET16_UNUSED}.${x}.${y}"
> > +
> > +			[ $(($num % 5)) -ne 2 ] && filter="include" || filter="exclude"
> > +			params="-F $filter -s $source_addr"
> > +		fi
> > +
> > +		ROD ns-mcast_join -f 4 -I $iface -l $NS_TIMES -a $MCAST_IPV4_ADDR $params &


> just ns-mcast_join ... &
OK



Kind regards,
Petr
