From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 7 Apr 2017 13:32:42 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170407091945.GA536@rei.lan>
References: <20170406124641.30179-1-chrubis@suse.cz>
 <20170407105832.6f9d811a@linux-v3j5> <20170407091945.GA536@rei.lan>
Message-ID: <20170407133242.6dd04be2@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Fri, 7 Apr 2017 11:19:45 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> Hi!
> > > +ifeq ($(filter -m32,$(CFLAGS)),)
> > > +$(MAKE_TARGETS): LDFLAGS += -L$(top_builddir)/lib$(subst -m,,$(filter -m32,$(CFLAGS)))
> > > +else
> > > +LDFLAGS			 += -L$(top_builddir)/lib
> > > +endif  
> > 
> > I think this breaks the build if you do 'make CFLAGS+=-m32' or './configure
> > CFLAGS=-m32' to build everything in compatability mode. Am I doing it wrong or
> > is this an issue?  
> 
> If -m32 is in CFLAGS the $(filter -m32,$(CFLAGS)) is nonempty and we
> will add -L$(top_builddir)/lib regardless. We will build the lib32 as
> well but never use it.
> 
> And you have to pass LDLAGS=-m32 to the configure script as well, since
> the implicit rule to build an executable from list of object files is:
> 
> $(CC) $(LDFLAGS) n.o $(LOADLIBES) $(LDLIBS)
> 
> Hence if you pass -m32 only to CFLAGS the compiler will fail to link the
> ltp-pan binary.
> 
> Passing -m32 in CFLAGS only works for testcases though, since they are
> compiled and linked in one try and hence use both LDFLAGS and CFLAGS.
> 

OK, makes sense.

Build still fails however, because of missing 32-bit libraries, but that is
just because the headers are present for the 64-bit lib and a lot of tests
will try to build so long as the headers are there. I guess it would be better
to also check that we can link as well, which some tests appear to do. I think
it is quite a reasonable workaround to just install the libs though assuming
that they will all usually be available if any 32-bit libs are.

Thank you,
Richard.
