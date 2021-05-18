From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 21:13:14 +0200
Subject: [LTP] [Automated-testing] [PATCH v2 1/1] doc: Add supported
 distros (kernel, libc, toolchain)
In-Reply-To: <YKP+KakyxIuGc/fo@yuki>
References: <20210518173039.4657-1-pvorel@suse.cz>
 <YKP+KakyxIuGc/fo@yuki>
Message-ID: <YKQRyk/6SNiqUryH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +1. Build testing with Travis CI
> > +-------------------------------
> > +
> > +We test master branch in https://travis-ci.org/github/linux-test-project/ltp/builds[travis CI]
> > +to ensure LTP builds on various distributions including old, current and bleeding edge.
> > +We test both gcc and clang toolchains, various arch with cross-compilation.
>                                                   ^
> 						  This should be plural
> 						  so 'archs' I guess
+1

> > +For list of tested distros see
> > +https://github.com/linux-test-project/ltp/blob/master/.travis.yml[.travis.yml].
> > +
> > +
> > +NOTE: Travis does only build testing, passing the CI means only that the
> > +      test compiles fine on variety of different distributions and releases.
> > +      Also it uses the latest distribution image of a particular release.
>            ^
> 	  Travis also uses...
+1

> > +1.1 Oldest tested distributions
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +[align="center",options="header"]
> > +|==============================================================
> > +| Distro                       | kernel | glibc | gcc   | clang
> > +| CentOS 7                     | 3.10   | 2.17  | 4.8.5 | -
> > +| Ubuntu 16.04 LTS xenial      | 4.4    | 2.23  | 5.3.1 | -
> > +| Debian 9 stretch (oldstable) | 4.9.30 | 2.24  | 6.3.0 | 3.8
> > +|==============================================================
> > +
> > +Older distributions are not officially supported, which means that it
> > +may or may not work. It all depends on your luck. It should be possible
> > +to compile latest LTP even on slightly older distributions than we
> > +support with a few manual tweaks, e.g. disabling manually tests for
> > +newly added syscalls manually, etc. Trivial fixes/workarounds may be accepted,
>                           ^
> 			  This 'manually' is redundant and should be removed.
+1

> > +but users are encouraged to move to a newer distro.
> > +
> > +If latest LTP cannot be compiled even with some amount of workarounds,
> > +you may result to older LTP releases, however these are _not_ supported
> > +in any way. Also if you are trying to run LTP on more than 10 years old
> > +distribution you may as well reconsider you life choices.

> So in the end you haven't changed this for the nicer version I've
> proposed?
I decided to keep it. We're saying similar thing in previous paragraph
("but users are encouraged to move to a newer distro") and it's actually the
truth (life choice to maintain ancient version). But feel free to suggest
further improvements over these 2 paragraphs.

Kind regards,
Petr
