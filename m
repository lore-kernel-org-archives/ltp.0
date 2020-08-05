From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Aug 2020 11:27:03 +0200
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
References: <20200731121508.12805-2-chrubis@suse.cz>
 <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
Message-ID: <20200805092703.GB5522@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This commit adds explicit build rules, the main motivation are recent
> > build failures caused by library orderings. To fix that this commit
> > introduces LTPLDLIBS special variable that is passed to linker before
> > the LDLIBS which avoids the need for tricks as
> > "LDLIBS := -lltpfoo $(LDLIBS)" in the Makefiles.
> > 
> > This commit also silences the output by default a bit, the verbose
> > output could be enabled by VERBOSE=1 env variable, which is probably
> > what most of the build systems will do if this gets commited. I guess
> > that we can as well silence a bit the "make entering/leaving directory"
> > if this the right way to go.
> 
> alias for V=0 / V=1 would be nice

Done in a follow up patch.

> LTPLDLIBS should probably be mentioned in doc/build-system-guide.txt

I've added a line to the variables listing in there before pushing.

> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  include/mk/env_post.mk |  2 ++
> >  include/mk/rules.mk    | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 include/mk/rules.mk
> > 
> > diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> > index f4169ad66..bdf8c696d 100644
> > --- a/include/mk/env_post.mk
> > +++ b/include/mk/env_post.mk
> > @@ -107,4 +107,6 @@ $(error You must define $$(prefix) before executing
> > install)
> >  endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
> >  endif
> >  
> > +include $(top_srcdir)/include/mk/rules.mk
> > +
> >  endif
> > diff --git a/include/mk/rules.mk b/include/mk/rules.mk
> > new file mode 100644
> > index 000000000..e9b9c35ef
> > --- /dev/null
> > +++ b/include/mk/rules.mk
> > @@ -0,0 +1,29 @@
> > +%.o: %.c
> > +ifdef VERBOSE
> > +	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> > +else
> > +	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> > +	@echo CC $@
> > +endif
> 
> What if we wouldn't print "DIR" (for non-clean targets) and printed relative paths instead?

Great idea, I've added these changes to the first patch in the series
before I pushed it.

-- 
Cyril Hrubis
chrubis@suse.cz
