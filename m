From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 17:46:47 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170328153347.GJ1045@rei>
References: <20170328100114.29730-1-chrubis@suse.cz>
 <20170328165536.741d14e5@linux-v3j5> <20170328153347.GJ1045@rei>
Message-ID: <20170328154647.GK1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I added "cve-2016-4997: CFLAGS += -m32" and it still tried to look in
> > "../../lib"
> 
> Hmm, that is not easy to fix, since this is target specific variable and
> we simply do not see the -m32 in the CFLAGS in the condition below.
> 
> We would have to set the LDFLAGS per target and I'm not sure if we can
> easily do that.
> 
> > > +ifeq ($(filter -m32,$(CFLAGS)),)
> > >  LDFLAGS				+= -L$(top_builddir)/lib
> > > +else
> > > +LDFLAGS				+= -L$(top_builddir)/lib32
> > > +endif

Try with this condition instead of the above ifeqs:

$(MAKE_TARGETS): LDFLAGS += -L$(top_builddir)/lib$(subst -m,,$(filter -m32,$(CFLAGS)))

It's a bit hairy but seems to work.

-- 
Cyril Hrubis
chrubis@suse.cz
