From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Jun 2019 14:47:14 +0200
Subject: [LTP] [RFC PATCH v2 0/6] net/route: Rewrite route{4,
 6}-change-{dst, gw} into C
In-Reply-To: <925eb48b-cb17-a06e-175d-315716852c76@oracle.com>
References: <20190510183132.31039-1-pvorel@suse.cz>
 <187fa31b-3295-6f1f-e330-1373b2fb4c66@oracle.com>
 <20190603072605.GB14710@dell5510>
 <925eb48b-cb17-a06e-175d-315716852c76@oracle.com>
Message-ID: <20190614124714.GA4022@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > thanks for your comments. I suppose you don't see much point of rewriting tests
> > into C (and depending on libmnl). The original idea was to change it fast enough
> > with C to really stress it. OK, let's leave it :).


> Sorry for the delay, it would be good to have a shell variant with the ping (so we
> can verify the route) and also keep the libmnl test-case to stress the creation/deletion.

Thanks for your opinion. It's actually good idea to have both instead of trying
to kill two birds with one stone in C (speed and validation) :).
I'll send ping and neighbor discovery variant and fixed C variant.

Kind regards,
Petr

> >>> do_test()
> >>> {
> >>> 	local iface=$(tst_iface)
> >>> 	local addr new_rt

> >>> 	new_rt="$(tst_ipaddr_un $1)/$mask"
> >>> 	addr="$(tst_ipaddr_un $1 1)"

> >>> 	tst_res TINFO "testing route '$new_rt'"

> >>> 	tst_rhost_run -s -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
> >>> 	ROD ip route add $new_rt dev $iface
> >>> 	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface
> >>>> 	EXPECT_PASS ns-udpsender -f $TST_IPVER -D $addr -p $1 -o -s $udp_size

> >>> 	ROD ip neigh del $addr lladdr $(tst_hwaddr rhost) dev $iface
> >>> 	ROD ip route del $new_rt dev $iface
> >>> 	tst_rhost_run -c "ip addr del $addr/$mask dev $(tst_iface rhost)"

> >> With ns-udpsender, I think it can be without setting ip addresses:
> > Route over gateway requires (on IPv6) gateway on rhost, which is requires to
> > create this IP address first.

> >>  	ROD ip route add $new_rt dev $iface
> >>  	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface
> >>  	EXPECT_PASS ns-udpsender -f $TST_IPVER -D $addr -p $1 -o -s $udp_size> 
> >> 	ROD ip neigh del $addr lladdr $(tst_hwaddr rhost) dev $iface
> >>  	ROD ip route del $new_rt dev $iface

> >> But with ping and neighbor discovery:
> >>  	tst_rhost_run -s -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
> >>  	ROD ip route add $new_rt dev $iface
> >>  	EXPECT_PASS ping$TST_IPVER ...
> >>  	ROD ip route del $new_rt dev $iface
> >>  	tst_rhost_run -c "ip addr del $addr/$mask dev $(tst_iface rhost)"
> > I prefer using ping and neighbor discovery. I suppose these are both equivalent
> > (if not it'd be good to run them both).

> > Kind regards,
> > Petr


