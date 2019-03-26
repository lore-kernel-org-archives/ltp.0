From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Mar 2019 12:02:57 +0100
Subject: [LTP] [PATCH 1/1] sigpending: Use 3 variants via
	test_multiplex()
In-Reply-To: <20190326105811.GA32418@rei.lan>
References: <20190325151438.3712-1-pvorel@suse.cz> <20190326101022.GA28312@rei>
 <20190326104719.GA16888@dell5510> <20190326105811.GA32418@rei.lan>
Message-ID: <20190326110257.GA21673@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > >  static struct tst_test test = {
> > > > -	.test_all = run
> > > > +	.test_all = run,
> > > > +	.test_variants = 3,
> > > >  };

> > > I would rather see .setup = singpending_info, here so that we don't spam
> > > the output that much, otherwise it looks good.

> > No problem, but with the following diff is the output the same. Am I missing
> > something?

> Ah, my bad, we are using test_all instead of test function, so indeed
> the output is the same. I blame it on ENOCOFFEE error my brain reported
> in the morning.
OK, pushed the original variant. At least you have good error checking :).

Kind regards,
Petr
