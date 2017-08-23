From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2017 15:57:48 +0200
Subject: [LTP] [RFC PATCH v8 08/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <20170822212240.cj4rhya5s2mvlpgh@dell5510>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-9-pvorel@suse.cz>
 <786265f7-ec89-e641-8fda-15f6844fb347@oracle.com>
 <20170822212240.cj4rhya5s2mvlpgh@dell5510>
Message-ID: <20170823135748.6cgyhrlrcmoouc2z@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,


> > > +	if [ "$cmd_type" = 'ifconfig_cmd' ]; then
> > > +		cmd="$cmd_name $(tst_iface) down"
> > > +		cmd2="$cmd_name $(tst_iface) up"
> > > +	else
> > > +		cmd="$cmd_name link set down dev $(tst_iface)"
> > > +		cmd2="$cmd_name link set up dev $(tst_iface)"

> > This test-case looks like duplicate of if-updown
> OK, I'll delete testcases/network/stress/route/route4-ifdown and
> testcases/network/stress/route/route6-ifdown. testcases/network/stress/interface/if-updown
> looks cleaner anyway.
Again, I didn't implement adding route before putting the interface down. This delete
route, so the use case is different from if-updown. I fix it and keep the test.

> Anything else to delete? The more time I spend with route tests the more I doubt about
> it's real value.

Kind regards,
Petr
