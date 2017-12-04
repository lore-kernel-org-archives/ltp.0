From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Dec 2017 21:49:49 +0100
Subject: [LTP] [RFC PATCH v3 1/5] travis: Add build script and use it in
 travis
In-Reply-To: <20171204171510.GE21055@rei>
References: <20171204122553.15338-1-pvorel@suse.cz>
 <20171204122553.15338-2-pvorel@suse.cz>
 <20171204171510.GE21055@rei>
Message-ID: <20171204204949.GA7318@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for your time!

> I find this output to be a bit too verbose, frankly I do not remeber
> checking it content of the config.log ever.
It is verbose. The reason I added it is, that we can check that travis is doing what we
want (e.g. header / library is really installed / not installed).
I didn't realize, that include/config.h would be enough and it's much smaller.
But I suppose you don't want any output in case of successful configure run, do you?

> > +    make $make_opts
> > +    make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
>    ^
>    Here you use spaces instead of tabs.
Thanks. Copy & paste issue.

> > +}
> > +
> > +build_in_tree()
> > +{
> > +	echo "=== autotools ==="
> > +	make autotools
> > +
> > +	echo "=== configure ==="
> > +	if ! ./configure $CONFIGURE_OPTS_IN_TREE $@; then
> > +		echo "== ERROR: configure failed, config.log =="
> > +		cat config.log
> > +		exit 1
> > +	fi
> > +
> > +	echo "== config.log =="
> > +	cat config.log

> Here as well.

> > +# vim: set ft=sh ts=4 sts=4 sw=4 noet:

> I prefer not to clobber source code with this kind of editor hints.
OK.


Kind regards,
Petr
