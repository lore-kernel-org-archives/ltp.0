From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Mon, 21 May 2018 13:38:57 +0800
Subject: [LTP] [PATCH ltp] Add .cache.mk and *.dwo into clean target and
 .gitignore
In-Reply-To: <20180518153409.jf7thwzi74rfqnpb@dell5510>
References: <20180518202208.5752-1-yixin.zhang@intel.com>
 <20180518153409.jf7thwzi74rfqnpb@dell5510>
Message-ID: <20180521053857.uxaim3tr27gy4aim@yixin-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I find that when I build  LTP on certain self-build kernel, there will be .dwo
file and .cache.mk file created. That's why I create this patch.

Yixin

On 2018-05-18 at 17:34:10 +0200, Petr Vorel wrote:
> Hi Yixin,
> 
> 
> > These files are generated during build, so and them into clean target
> > and .gitignore
> 
> > Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> > ---
> >  .gitignore             | 2 ++
> >  include/mk/env_post.mk | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> > diff --git a/.gitignore b/.gitignore
> > index a7e65633f..b838efd59 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -8,6 +8,8 @@ core
> >  .gdb_history
> >  .gdbinit
> >  lib*.a
> > +.cache.mk
> > +*.dwo
> 
> We're not using DWARF object files (yet), but it doesn't harm to be prepared.
> 
> >  /aclocal.m4
> >  autom4te.cache
> > diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> > index 4c57fffe4..59ebebb03 100644
> > --- a/include/mk/env_post.mk
> > +++ b/include/mk/env_post.mk
> > @@ -54,7 +54,7 @@ MAKE_TARGETS			?= $(notdir $(patsubst %.c,%,$(wildcard $(abs_srcdir)/*.c)))
> 
> >  MAKE_TARGETS			:= $(filter-out $(FILTER_OUT_MAKE_TARGETS),$(MAKE_TARGETS))
> 
> > -CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc
> > +CLEAN_TARGETS			+= $(MAKE_TARGETS) *.o *.pyc .cache.mk .*.dwo
> 
> >  # Majority of the files end up in testcases/bin...
> >  INSTALL_DIR			?= testcases/bin
> 
> Kind regards,
> Petr
