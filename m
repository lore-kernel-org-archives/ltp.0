From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Apr 2017 14:31:18 +0200
Subject: [LTP] [RFC PATCH v2 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <7cdee769-8b90-a7d4-bb82-09cadce47f46@oracle.com>
References: <20170403071428.11754-1-pvorel@suse.cz>
 <20170403071428.11754-3-pvorel@suse.cz>
 <7cdee769-8b90-a7d4-bb82-09cadce47f46@oracle.com>
Message-ID: <20170403123118.4p2xuzwzq34s46rv@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thank you for your review. I'll fix most of them in v3, with these exception:
> > +	int isNet = !(flags & FLAG_GET_HOST);

> We could use FLAG_GET_NETWORK here instead.
No, we can't as isNet is for FLAG_GET_NETWORK and FLAG_GET_NETWORK_UNUSED. So I dare
to use negation here :-).

> > +		tmp2 = 256 * a[2 * i] + a[2 * i + 1];
> > +		if (isUnused)
> > +			tmp2 = tmp2 < 0xff0d ? 0xff0d : 0xaa10;

> Hmm, what are '0xff0d' and '0xaa10' prefixes? The first one seems to be a
> multicast group address...
These are really random values, an easy way to get valid but unused value. Do you want
different approach?

> I don't quite understand how unused network is calculated in this patch,
> is it
> just changing the first prefix with these values?
Yep.

> What would be if we set fd00:1/64 and 192.168.1.1/24 addresses?
$ ./testcases/lib/tst_net_vars fd00::1/64 fd00::2/64
export IPV6_NETWORK='fd00:'
export IPV6_NET_REV='0.0.0.0.0.0.0.0.0.0.0.0.0.0.d.f'
export LHOST_IPV6_HOST='1'
export LHOST_IPV6_REV='1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0'
export RHOST_IPV6_HOST='2'
export RHOST_IPV6_REV='2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0'
export IPV6_NET32_UNUSED='ff0d'

$ ./testcases/lib/tst_net_vars 192.168.1.1/24 192.168.1.2/24
export IPV4_NETWORK='192.168.1'
export IPV4_NET_REV='1.168.192'
export LHOST_IPV4_HOST='1'
export RHOST_IPV4_HOST='2'
export IPV4_NET16_UNUSED='10.168.1'


> > +
> > +	if (lprefix != rprefix) {
> > +		fprintf(stderr, "Prefixes must be the same\n");

> And why this limitation is needed?
I did it just to simplify the implementation.  IMHO both IPv4 and IPv6 require two nodes
on the same physical network have the same prefix so I didn't consider this as a real
limitation.

But of course, there could be different prefixes, the smaller would be used as IPV6_NETWORK variable is
used for both hosts. Do you want me to change it this way?


Kind regards,
Petr
