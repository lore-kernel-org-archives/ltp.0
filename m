From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Aug 2017 23:22:40 +0200
Subject: [LTP] [RFC PATCH v8 08/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <786265f7-ec89-e641-8fda-15f6844fb347@oracle.com>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-9-pvorel@suse.cz>
 <786265f7-ec89-e641-8fda-15f6844fb347@oracle.com>
Message-ID: <20170822212240.cj4rhya5s2mvlpgh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Tests using route_test_change() use background traffic instead of ns-udpsender
> > but I fixed it that it uses route. Is it too much overhead? The reason is I'd

> How do you use it to make a background traffic if you change route on
> every loop iteration?

> > like to get rid of all ugly scripts and binaries in
> > testcases/network/stress/ns-tools, including ns-udpsender.c.

> ns-udpsender can send a single UDP datagram over the new route without
> waiting for answer but unfortunately we don't know for sure whether it
> actually sent datagram and/or destination received it.
What would you suggest? I chose netstress as it's kind of client & server application. Do
we want to write something from scratch?
I don't like also the infinite loop in send_udp_datagram (I've caused one crash in local
network in previous tests by sending too many packets).



> > +	if [ "$cmd_type" = 'ifconfig_cmd' ]; then
> > +		cmd="$cmd_name $(tst_iface) down"
> > +		cmd2="$cmd_name $(tst_iface) up"
> > +	else
> > +		cmd="$cmd_name link set down dev $(tst_iface)"
> > +		cmd2="$cmd_name link set up dev $(tst_iface)"

> This test-case looks like duplicate of if-updown
OK, I'll delete testcases/network/stress/route/route4-ifdown and
testcases/network/stress/route/route6-ifdown. testcases/network/stress/interface/if-updown
looks cleaner anyway.
Anything else to delete? The more time I spend with route tests the more I doubt about
it's real value.

...
> > +# helper function for route4-change-{dst,gw,if} tests
> > +route_test_change()
> > +{
...
> > +	while [ $cnt -lt $NS_TIMES ]; do
> > +		lhost_ifname2="$lhost_ifname"
> > +		gateway2="$gateway"
> > +
> > +		pre_dst_network="$dst_network"
> > +		if [ "$test_field" = 'dst' ]; then
> > +			dst_addr="$(tst_ipaddr_un_ip $(($cnt % 255)) $DST_HOST)"
> > +			dst_network="$(tst_ipaddr_un_ip $(($cnt % 255)))"

> tst_ipaddr_un() handles '$cnt' overrun already.
Thanks, silly error.

> > +			netstress_cleanup

> cleanup in the test on every loop iteration?
That's used to kill netstress before calling make_background_tcp_traffic.

> > +		elif [ "$test_field" = 'gw' ]; then
> > +			gateway2="$(tst_ipaddr_un_host rhost $(($RHOST_COUNTER_START + $cnt)))"
> > +			local cnt2=$(($cnt + 1))
> > +			[ $cnt2 -eq $RHOST_COUNTER_COUNT ] && cnt2=$RHOST_COUNTER_START
> > +			gateway="$(tst_ipaddr_un_host rhost $(($RHOST_COUNTER_START + $cnt2)))"

> Why do you need RHOST_COUNTER_COUNT and RHOST_COUNTER_START variables?
I create 10 unused addresses on rhost in route4-change-gw and then I'm using them in the
test. I use it also for RHOST_DST_ADDR (creating unique rhost address in route4-change-gw
used as destination address for check_connectivity_interval).

> > +		elif [ "$test_field" = 'if' ]; then
> > +			[ $link_num -ge $LINK_TOTAL ] && link_num=0
> > +			lhost_ifname="$(tst_iface lhost $link_num)"
> > +			gateway="$(tst_ipaddr_un_ip $link_num 1)"
> > +			link_num=$(($link_num + 1))
> > +		fi


> It's better to change 'if' structure to 'case' one
OK.


> > +
> > +		if [ $cnt -gt 0 ]; then
> > +			manipulate_route $cmd_name 'del' $pre_dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway2 $lhost_ifname2
> > +		fi
> > +
> > +		manipulate_route $cmd_name 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
> > +		make_background_tcp_traffic $(tst_ipaddr_un_host)

> For generating traffic you're always using a single destination address,
> why it can't be $(tst_ipaddr)?
I thought it should be also on unused network, but as it's a simple check (not a new
route) I can change it to $(tst_ipaddr).

> > +		check_connectivity_interval $cnt false $lhost_ifname $dst_addr || return

> Could you please clarify the traffic flow here? if I understand it
> correctly ICMP goes over the new route/gw to an IP addresses on remote
> host which was added in setup, correct?
Yes.

> I think ns-udpsender is the more appropriate choice for a one way traffic...
OK. But we both don't like it's limitations (no guarantee of delivery and infinite loop)

> > --- a/testcases/network/stress/route/route4-rmmod
> > +++ b/testcases/network/stress/route/route4-rmmod

> ...

> >  test_body()
> >  {
> > -    test_type=$1
> > +	local cmd_type=$1
> > +	local cmd_name="$(get_cmd $cmd_type)"
> > +	local dst_addr=${DST_NETWORK}.${DST_HOST}
> > +	local dst_network=${DST_NETWORK}.0
Left unused variables, I remove them.

> > +	local cnt=0

> > -    TCID=route4-rmmod0${test_type}
> > -    TST_COUNT=$test_type
> > +	tst_resm TINFO "IPv4 route is added by '$cmd_name' command and then deleted by removing network driver $NS_TIMES times"

> This is not what the test does after the changes.
Yes, no route added, sorry. I removed it because it was already set by
tst_add_ipaddr_stress:
10.23.0.0/24 dev ltp_ns_veth2  proto kernel  scope link  src 10.23.0.2

> With this implementation it should be moved to 'interface' group.
I'll put it back to match the description and really test creating route, so I can keep it
here.


Kind regards,
Petr
