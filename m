From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Apr 2019 11:04:07 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190429204527.GA30772@dell5510>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510> <20190429131331.GB6265@rei>
 <20190429204527.GA30772@dell5510>
Message-ID: <20190430090406.GA30997@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> > index 131854ec7..6d1b2d4ef 100644
> > --- a/include/mk/testcases.mk
> > +++ b/include/mk/testcases.mk
> > @@ -49,7 +49,7 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
> >  MAKE_DEPS += $(LTPLIBS_FILES)
> 
> >  $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
> > -       $(MAKE) -C "$^" -f "$^/Makefile" all
> > +       $(MAKE) -C "$^" -f "$(subst $(abs_top_buildir),$(abs_to_srcdir),$^)/Makefile" all
> 
> >  LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
> 
> > I will have a look at the top level Makefile as well to see what has to
> > be done there.
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> This one looks ok. Also testing with machine with 32 cores, ok as well (but it's
> hard to trigger this bug even current master).

Sigh, apparenlty this has patch has two obvious typos, both
abs_top_builddir and abs_top_srcdir are spelled incorrectly, no wonder
it does not work, sorry for that.

And the only reason why this works for in-tree build is because with
typos we do no replace anything and the path to the Makefile is correct
for in-tree build.

-- 
Cyril Hrubis
chrubis@suse.cz
