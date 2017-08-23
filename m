From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2017 15:34:46 +0200
Subject: [LTP] [RFC PATCH v8 08/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <20170822212240.cj4rhya5s2mvlpgh@dell5510>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-9-pvorel@suse.cz>
 <786265f7-ec89-e641-8fda-15f6844fb347@oracle.com>
 <20170822212240.cj4rhya5s2mvlpgh@dell5510>
Message-ID: <20170823133445.xff3g5zx2am5hvos@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > > +	while [ $cnt -lt $NS_TIMES ]; do
> > > +		lhost_ifname2="$lhost_ifname"
> > > +		gateway2="$gateway"
> > > +
> > > +		pre_dst_network="$dst_network"
> > > +		if [ "$test_field" = 'dst' ]; then
> > > +			dst_addr="$(tst_ipaddr_un_ip $(($cnt % 255)) $DST_HOST)"
> > > +			dst_network="$(tst_ipaddr_un_ip $(($cnt % 255)))"

> > tst_ipaddr_un() handles '$cnt' overrun already.
> Thanks, silly error.
No, I'll keep it, without it addresses for cnt > 254 would be always 254 (no real
testing).

Kind regards,
Petr
