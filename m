From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Sep 2021 14:28:49 +0200
Subject: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
In-Reply-To: <61ea98da-6746-2ad3-c2de-38e148cc9d4c@bell-sw.com>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <0acf816462d49d8a6004c87e36b05d1b@suse.de>
 <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com>
 <YTsnD0Uw4argiGOJ@pevik>
 <61ea98da-6746-2ad3-c2de-38e148cc9d4c@bell-sw.com>
Message-ID: <YT9EAQfa02ytbDPr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi Petr,
> On 10.09.2021 12:36, Petr Vorel wrote:
> >> On 09.09.2021 18:53, pvorel wrote:
> >>> Hi Su, Alexey,

> >>> On 2021-08-30 11:26, suy.fnst@fujitsu.com wrote:
> >>>> Hi,
> >>>> ? I found that it's indeed related to ipv6 DAD as you said.
> >>>> Calling
> >>>> `ip netns exec ltp_ns sysctl -n net.ipv6.conf.ltp_ns_veth1.accept_dad=0`
> >>>> or tst_wait_ipv6_dad() at end of the setup both solves the problem.
> >>>> However there is one super strange part that the tentative address is
> >>>> the local link adress of the ltp_ns_veth1:

> >>>> 5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> >>>> state UP group default qlen 1000
> >>>> ??? link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-netnsid 0
> >>>> ??? inet 10.0.0.1/24 scope global ltp_ns_veth1
> >>>> ?????? valid_lft forever preferred_lft forever
> >>>> ??? inet6 fd00:1:1:1::1/64 scope global nodad
> >>>> ?????? valid_lft forever preferred_lft forever
> >>>> ??? inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative
> >>>> <-------------------
> >>>> ?????? valid_lft forever preferred_lft forever

> >>>> However, there is no place using the address in mpls02 test.>> It makes me wonder how could it be possible to trigger the issue..

> >> Looks like the problem here in the neighbor discovery of fd00:1:1:1::2
> >> using link-local address, and vice verse for the other side. mpls is
> >> using the following route with the address:

> >> fd00:23::2  encap mpls  60 via fd00:1:1:1::2 dev ltp_ns_veth1 metric 1024 pref medium
> >> so the address there should be in a reachable state...

> > Thanks for info! I wonder if it's a bug in mpls or elsewhere. WDYT?

> https://github.com/iputils/iputils/issues/300
Ah, thanks for pointing this.

> So we should be careful with the flood option in ping, especially
> if it is the first test to run after initial test interfaces setup.
> For example, for mpls02, it is "icmp tcp udp".
Flooding is done with -f or -i 0. IMHO we don't do that in tst_ping(),
what am I missing? The bug is about flooding (-i 0) with zero packet size (-s 0,
but maybe our use -s 10 would trigger the bug as well).

Kind regards,
Petr


> >> Adding it manually in setup might fix the test as well:

> >> ROD ip neigh replace $(tst_ipaddr rhost) lladdr $(tst_hwaddr rhost) dev $(tst_iface) nud reachable
> >> tst_rhost_run -s -c "ip neigh replace $(tst_ipaddr) lladdr $(tst_hwaddr) dev $(tst_iface rhost) nud reachable"

> >>> I wonder if test still needs be fixed to work on all setups.


> >> I think we could set accept_dad to 0 in generic setup of the
> >> test interfaces, in tst_net.sh/tst_init_iface().
> > Unless it's a bug we'd hide by setting it, I'd be for this general solution.

> > It'd be nice to get it fixed before release.

> OK

