From: Bird, Tim <Tim.Bird@sony.com>
Date: Mon, 21 Sep 2020 18:04:30 +0000
Subject: [LTP] LTP release
In-Reply-To: <20200918145752.GA16897@yuki.lan>
References: <20200908073138.GB2475@yuki.lan> <20200910084554.GA21741@dell5510>
 <20200914111543.GE5524@yuki.lan>
 <CY4PR13MB117529F882F68FED2C60AD09FD230@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200918145752.GA16897@yuki.lan>
Message-ID: <CY4PR13MB117574DFAE3DBBFF4BF24CF7FD3A0@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Just to finish answering questions...

> -----Original Message-----
> From: Cyril Hrubis <chrubis@suse.cz>
> 
> > Do you have a preferred name for the runtest file?  My proposal, just off the top
> > of my head, is: "ltp-selftest-quick", but I'm open to other suggestions.
> 
> Maybe we should call it smoketest, but I'm okay selftest as well.

I'm fine with "smoketest".

...
> >
> > This takes about 5 seconds on one of my test machines.
> 
> So I will add a network test to the set and push that before a patch
> that removes quickhit.
> 
> It would be nice to have the outliners, but that is a bit more
> complicated change, so I would like to add these after a release, is
> that okay?

Yes.  I think that's actually better.  I think a simple change now
is good.  I'd like to think some more about whether it would be good to
add things that misbehave to smoketest, or if they should be put into
a separate selftest group.  My inclination is that a smoketest should really
just be a super-quick check that should work unless something fundamental
is broken, while selftest should try as many things as possible, including weird
stuff and corner cases, to actually test specific features of runtest handling.

I'm satisfied with the current smoketest content.

> 
> > P.S. Maybe, if you're moving away from runltp and ltp-pan, it's a little late to be
> > adding some selftests to make sure they work correctly.  But Fuego is using them.
> > I don't know what other frameworks use when they invoke LTP to perform
> > tests.
> 
> I do expect that we will have ltp-pan included for compatibility reasons
> at least for a year or two once the replacement would be in place
> anyways, so having a smoketest wouldn't harm at all.
Sounds good.

