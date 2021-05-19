From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 May 2021 13:24:29 +0200
Subject: [LTP] [Automated-testing] [PATCH v2 1/1] doc: Add supported
 distros (kernel, libc, toolchain)
In-Reply-To: <YKTR12JzOJiFOaPv@yuki>
References: <20210518173039.4657-1-pvorel@suse.cz> <YKP+KakyxIuGc/fo@yuki>
 <YKQRyk/6SNiqUryH@pevik> <YKTR12JzOJiFOaPv@yuki>
Message-ID: <YKT1bTfLGsiedaya@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > > +but users are encouraged to move to a newer distro.
> > > > +
> > > > +If latest LTP cannot be compiled even with some amount of workarounds,
> > > > +you may result to older LTP releases, however these are _not_ supported
> > > > +in any way. Also if you are trying to run LTP on more than 10 years old
> > > > +distribution you may as well reconsider you life choices.

> > > So in the end you haven't changed this for the nicer version I've
> > > proposed?
> > I decided to keep it. We're saying similar thing in previous paragraph
> > ("but users are encouraged to move to a newer distro") and it's actually the
> > truth (life choice to maintain ancient version). But feel free to suggest
> > further improvements over these 2 paragraphs.

> Nah, looks good enough, Acked with the typos and grammar fixes.

OK, thanks, merged!

And put into wiki:
https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions

Kind regards,
Petr
