From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Nov 2019 13:42:43 +0100
Subject: [LTP] [Automated-testing] [PATCH 1/2] Wrapper for Syzkaller
 reproducers
In-Reply-To: <87zhgjc4ie.fsf@rpws.prws.suse.cz>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-2-rpalethorpe@suse.com>
 <CAEemH2f=_oGD8Zo=EDE6D096EEP=jCjzEUPOszJ7W7j8vbV7XA@mail.gmail.com>
 <87zhgjc4ie.fsf@rpws.prws.suse.cz>
Message-ID: <20191126124243.GA10841@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> >> +AC_ARG_WITH([syzkaller-repros],
> >> +  [AC_HELP_STRING([--with-syzkaller-repros],
> >> +    [compile and install Syzkaller reproducers (default=no)])],
> >> +  [with_syzkaller_repros=$withval]


> > To strictly, the [action-if-not-given] should be added too?

> Were the other 'with' options updated recently to have that? I just
> copied this from the other options.
Yep, you'll just add
[with_syzkaller_repros=no]
(looking at the default off, probably safer for the start)

> >> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> >> index 3319b3163..0150cfb4f 100644
> >> --- a/testcases/kernel/Makefile
> >> +++ b/testcases/kernel/Makefile
> >> @@ -53,6 +53,7 @@ SUBDIRS                       += connectors \
> >>                            sched \
> >>                            security \
> >>                            sound \
> >> +                          syzkaller-repros \
> >>                            tracing \
> >>                            uevents \

> >> +# Some useful compiler flags for the LTP will cause problems with the
> >> +# syzkaller repros so the repros have seperate flags
> >> +SYZKALLER_CFLAGS ?= -pthread
> >> +SYZKALLER_REPROS = $(subst
> >> $(abs_top_srcdir),$(abs_top_builddir),$(SYZKALLER_REPROS_SRCS:.c=))
> >> +$(SYZKALLER_REPROS): %: %.c
> >> +       -@if grep -q "__NR_mmap2" $^; then \
> >> +               M32="-m32"; \


> > I got compiling errors on s390x:
> >   gcc: error: unrecognized command line option ?-m32?; did you mean
> > ?-m31??

> I have only tried these on x86_64 so far and I think that is all we can
> support to begin with.

Maybe filter it out in testcases/kernel/Makefile with something like this:
ifneq (,$(filter $(HOST_CPU),x86 x86_64))
FILTER_OUT_DIRS += syzkaller-repros
endif

> > My other concern is syzkaller (I guess maybe) have some package
> > dependencies, and that will break the compiler phase on the embedded
> > system.

> This is true, the reproducers do have dependencies and it seems to vary
> (randomly view some of the C files). However this is one of the reasons
> why they are only installed if --with-syzkaller-repros is set.
Maybe later we manage to generate autotools config based on pkg-config.

Kind regards,
Petr
