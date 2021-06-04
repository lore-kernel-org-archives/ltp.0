From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 18:56:00 +0200
Subject: [LTP] [RFC PATCH 1/3] make: Add make check{,-c,-shell} targets
In-Reply-To: <YLo9YXWrWweICm81@yuki>
References: <20210603183827.24339-1-pvorel@suse.cz>
 <20210603183827.24339-2-pvorel@suse.cz> <YLo9YXWrWweICm81@yuki>
Message-ID: <YLpbIO3JlTucspgH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > +++ b/include/mk/generic_trunk_target.inc
> > @@ -48,7 +48,7 @@

> >  include $(top_srcdir)/include/mk/functions.mk

> > -RECURSIVE_TARGETS		?= all install
> > +RECURSIVE_TARGETS		?= all check check-c check-shell install

> If you add a target to RECURSIVE_TARGETS such target automatically
> traverses directories, that what the target is for. See the rule at the
> end of the generic_trunk_target.inc. Which means that you redefine
> targets if you define the same targets to loop and run the tests above.
Ah, thanks!

> I guess that you want add another target that depends on check targets
> to actually run the tests?

> Maybe:

> check-c: check-c-run

> check-c-run: $(TEST_TARGETS)
> 	for i in $(TEST_TARGETS); do
> 		...
> 	done

> in order to run the tests.

> In this case the check* targets would be used for directory traversal
> and the check-c-run would be used to run the tests.

Sounds reasonable.

> >  $(eval $(get_make_dirs))

> > @@ -71,7 +71,7 @@ trunk-install: $(INSTALL_FILES)
> >  # Avoid creating duplicate .PHONY references to all, clean, and install. IIRC,
> >  # I've seen some indeterministic behavior when one does this in the past with
> >  # GNU Make...
> > -.PHONY: $(filter-out $(RECURSIVE_TARGETS),all clean install)
> > +.PHONY: $(filter-out $(RECURSIVE_TARGETS),all check clean install)

> The check is already in RECURSIVE_TARGETS
Thanks!

I'll send v2 on Monday, which also use test* as target name instead of check*
as we agreed on Richie's Libclang based analyzer patchset [1].

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2021-June/023008.html
