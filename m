From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Oct 2020 16:31:30 +0200
Subject: [LTP] [Automated-testing] [PATCH 1/3] lib/tst_kconfig: Rewrite
 the parser internals
In-Reply-To: <20201021141157.GC10861@yuki.lan>
References: <20201020100910.10828-1-chrubis@suse.cz>
 <20201020100910.10828-2-chrubis@suse.cz> <878sbzx66b.fsf@suse.de>
 <20201021100605.GA10861@yuki.lan> <874kmnwy6g.fsf@suse.de>
 <20201021141157.GC10861@yuki.lan>
Message-ID: <20201021143130.GA21944@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > >> lines first to remove whitespace issues and expose the parser to all
> > >> possible variable name symbols and values instead of just the ones which
> > >> appear in our current tests.

> > > I guess that it's techincally possible to have a whitespaces there, but
> > > will not happen unless you hand-edit the config file before compilation,
> > > which I doubt will ever happen.


> > It can also happen if someone has their own script to modify the
> > config. At any rate, if you are confident that it will never happen then
> > there should be no problem failing hard if it does.

> It would be probably easier to eat the whitespace around the = if
> present. But still I would ignore anything that isn't correct variable
> assignment, since such config would fail kernel compilation anyways.
+1

+ I use ./scripts/config --enable | --disable ... to avoid problems with
incorrect config.

> > >> > +
> > >> > +		if (kconfig_parse_line(line, vars, vars_len))
> > >> > +			vars_found++;

> > >> > +		if (vars_found == vars_len)
> > >> > +			goto exit;
> > >> >  	}

> > >> Generally, this approach seems like to result in spurious TCONFs. We
> > >> need to properly parse the file and fail if some line can't be
> > >> interpreted.

> > > Well we do expect well formatted .config file from a start, if you hand
> > > edit it and put whitespaces into unexpected places more things may
> > > fail.

> > Kernel build system seems to have no problem with it. More generally
> > though we should fail hard if there is something unexpected, not produce
> > TCONF which people don't check.

> Even if we do I do not think that we should care about anything but
> syntactically correct input, since if you modify the file after kernel
> compilation you have lost anyways.
+1

Kind regards,
Petr
