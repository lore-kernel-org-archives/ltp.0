From: Li Wang <liwang@redhat.com>
Date: Mon, 3 Aug 2020 15:59:06 +0800
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
References: <20200731121508.12805-2-chrubis@suse.cz>
 <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2dXq2S9Ep3Q8BYGh8XneA=xWa=mKqQPfE5Fn8739iMC_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 3, 2020 at 3:48 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
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
>
> LTPLDLIBS should probably be mentioned in doc/build-system-guide.txt
>
>
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
> > +     $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> > +else
> > +     @$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> > +     @echo CC $@
> > +endif
>
> What if we wouldn't print "DIR" (for non-clean targets) and printed
> relative paths instead?
>

+1
This looks better, I'd give my vote to this.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200803/bfdd6dc6/attachment-0001.htm>
