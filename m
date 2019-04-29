From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Apr 2019 15:13:31 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190429102009.GC6952@dell5510>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510>
Message-ID: <20190429131331.GB6265@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > So as usually please go ahead and point out anything that should go in
> > > before the release.
> 
> > Only Peter replied so far, so I suppose that we are ready to freeze git
> > starting next week and start the pre-release testing.
> 
> > Or is there anything that has to be considered to be included before we
> > do that?
> I guess it'd be great to fix sporadic out-of-tree build failures related to
> libs. Jan's patch [1] does not fixed it. I have no idea how to fix it.
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/1059002/

There are two things to fix. One that the patch from Jan attempted is
wrong path in the rule in the testcases.mk and the second one is that
the libraries are not build from the top level Makefile first before
everything else.

For the first problem fixing the path to the library Makefile should fix
the problem, something as (beware untested) this should fix it:

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 131854ec7..6d1b2d4ef 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -49,7 +49,7 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
 MAKE_DEPS += $(LTPLIBS_FILES)
 
 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
-       $(MAKE) -C "$^" -f "$^/Makefile" all
+       $(MAKE) -C "$^" -f "$(subst $(abs_top_buildir),$(abs_to_srcdir),$^)/Makefile" all
 
 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))

I will have a look at the top level Makefile as well to see what has to
be done there.

-- 
Cyril Hrubis
chrubis@suse.cz
