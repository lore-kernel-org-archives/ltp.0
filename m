From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Apr 2020 20:37:14 +0200
Subject: [LTP] [RFC PATCH v3 2/2] net/route: Add netlink based route
 change gw/dest tests
In-Reply-To: <06e299d0-0663-a868-f8cc-1f9002d9d43f@oracle.com>
References: <20200403165432.19358-1-pvorel@suse.cz>
 <20200403165432.19358-3-pvorel@suse.cz>
 <06e299d0-0663-a868-f8cc-1f9002d9d43f@oracle.com>
Message-ID: <20200409183714.GA915479@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your review!

> > diff --git a/testcases/network/stress/route/route-change-gw.sh b/testcases/network/stress/route/route-change-gw.sh
...
> >  setup()
> >  {
> >  	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
> > -
> > -	rt="$(tst_ipaddr_un -p 0 0)"
> > -	lhost="$(tst_ipaddr_un 1 1)"
> > -	rhost="$(tst_ipaddr_un 0 1)"
> > -	tst_add_ipaddr -s -q -a $lhost
> > -	tst_add_ipaddr -s -q -a $rhost rhost
> > +	setup_gw
> >  }

> TST_SETUP=setup_gw

OK, I hesitated, whether
tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"
should be part of setup_gw() or not in the end I accidentally left it on both
places. OK, I'll keep it in setup_gw() and remove from
route-change-netlink-gw.sh + use TST_SETUP=setup_gw here (in
route-change-gw.sh).

> > diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
...
> > +test_netlink()
> > +{
> > +	local ip_flag
> > +	[ "$TST_IPV6" ] && ip_flag="-6"
> > +
> > +	local port=$(tst_rhost_run -s -c "tst_get_unused_port ipv${TST_IPVER} dgram")
> > +

> What will be listen on this remote port?
Nothing. We've talked about it in the past. I struggled to setup remote workers
(problems to detect that the setup is up before testing starts), but I can
rethink it again. What do you suggest: one daemon which would run several
threads (each of them bind to specific IP) or several single thread instances?
IMHO not binding to specific IP does not garant traffic is taking path we want.

> > +	EXPECT_PASS route-change-netlink -c $NS_TIMES -d $(tst_iface) $ip_flag -p $port $ROUTE_CHANGE_NETLINK_PARAMS

> EXPECT_PASS doesn't handle TCONF when libmnl-devel is missing.

Thanks, I'll fix it.

tst_test.c:865: CONF: libmnl library and headers are required
route-change-netlink-gw 1 TFAIL: route-change-netlink -c 10 -d ltp_ns_veth2 -p 40645 -g 10.23.1.7^10.23.1.6^10.23.1.5^10.23.1.4^10.23.1.3^ -l 10.23.1.1 -r 10.23.0.1 failed unexpectedly

I propose to handle this in EXPECT_PASS() (send a separate RFC patch for it).

Kind regards,
Petr
