From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Sep 2017 15:17:12 +0200
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
 cve-2017-5669
In-Reply-To: <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
 <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
Message-ID: <20170906131712.GF24177@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > shmat() is not available on Android/Binder
> > 
> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > ---
> >  testcases/cve/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
> > index 04abc1f9c..5119c67cf 100644
> > --- a/testcases/cve/Makefile
> > +++ b/testcases/cve/Makefile
> > @@ -28,4 +28,8 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
> >  cve-2017-2671:	CFLAGS += -pthread
> >  cve-2017-2671:	LDLIBS += -lrt
> >  
> > +ifeq ($(ANDROID),1)
> > +FILTER_OUT_MAKE_TARGETS	+= cve-2017-5669
> > +endif
> > +
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> Do you have pointers to how you are build + testing with this? There seem to
> be some duplication of effort that I would like to avoid and make sure there
> is only 1 way in which tests like this are disabled out of build.

There was some initiall android support done by Steven Jackson, just
grep the git log for his name.

Basically what he did is to add a similar system we had for uClinux. You
are supposed to define shell variable ANDROID=1 when building for
android and the build system uses that to skip certain directories/files
from build.

-- 
Cyril Hrubis
chrubis@suse.cz
