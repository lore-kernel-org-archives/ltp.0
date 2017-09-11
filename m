From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 11 Sep 2017 15:52:00 +0200
Subject: [LTP] [RFC PATCH v9 5/7] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <46938f85-d63c-42ae-35c8-97bdc7096fee@oracle.com>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-6-pvorel@suse.cz>
 <46938f85-d63c-42ae-35c8-97bdc7096fee@oracle.com>
Message-ID: <20170911135200.s7yg4tyea3byqjvl@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +++ b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
...
> > +do_multicast_test_join_leave()
> > +{
> > +	local cnt define_src_addr filter params ret src_addr x y
> > +
> > +	[ "$1" = true ] && define_src_addr=true
> > +
> > +	# Send IGMP General Query from the remote host
> > +	tst_rhost_run -s -c "ns-igmp_querier -I $(tst_iface rhost) -i 1000000000 -r 1 -b"
> > +
> > +	# Run a multicast join tool
> > +	cnt=0
> > +	while [ $cnt -lt $NS_TIMES ]; do
This is actually wrong variable ($MCASTNUM_NORMAL should be used or better variable passed by script which call this function). I'll plan to fix it in next version.
With new version I also plan to switch it to be for both IPv4 and IPv6.

> > +		if [ "$define_src_addr" ]; then
> > +			x=$(($cnt / 254))
> > +			y=$(($cnt % 254 + 1))
> > +			if [ $x -gt 254 ]; then
> > +				tst_resm TINFO "the number of the connection is less than $cnt"
> > +				break
> > +			fi
> > +			src_addr=$(tst_ipaddr_un $x $y)
> > +
> > +			[ $((cnt % 5)) -ne 2 ] && filter="include" || filter="exclude"
> > +			params="-F $filter -s $src_addr"


> Why not params="-F $filter -s $(tst_ipaddr_un -c$cnt)"?
The original test runs:
ns-mcast_join -f 4 -I  -l 65024 -a 224.10.10.1 -F include -s 10.10.0.1 &
ns-mcast_join -f 4 -I  -l 65024 -a 224.10.10.1 -F include -s 10.10.0.2 &
...
ns-mcast_join -f 4 -I  -l 65024 -a 224.10.10.1 -F include -s 10.10.254.253 &
ns-mcast_join -f 4 -I  -l 65024 -a 224.10.10.1 -F include -s 10.10.254.254 &

=> it breaks loop if $NS_TIMES (or whatever variable is used) > 254*254 (=64516).

With -c switch $(tst_ipaddr_un -c$cnt)" we get half of IP's for the limit (as we're using
just lhost IP's)
for cnt -lt $((254*255))

ns-mcast_join -f 4 -I ltp_ns_veth2 -l 3 -a 224.10.10.1 -F include -s 10.23.251.2
ns-mcast_join -f 4 -I ltp_ns_veth2 -l 3 -a 224.10.10.1 -F include -s 10.23.251.4
...
ns-mcast_join -f 4 -I ltp_ns_veth2 -l 3 -a 224.10.10.1 -F include -s 10.23.254.252
ns-mcast_join -f 4 -I ltp_ns_veth2 -l 3 -a 224.10.10.1 -F include -s 10.23.254.254

I suppose I can remove this limit.


Kind regards,
Petr
