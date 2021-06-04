From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 11:15:38 +0200
Subject: [LTP] [RFC PATCH 0/2] Libclang based analyzer
In-Reply-To: <875yyuj91v.fsf@suse.de>
References: <20210603154825.30165-1-rpalethorpe@suse.com>
 <YLnGIJWPf2XsAdTt@pevik> <875yyuj91v.fsf@suse.de>
Message-ID: <YLnvOpNr3HlTLWWP@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> > FYI yesterday I sent patch to add make check{,-c,shell}, but for running C/shell API tests:
> > https://patchwork.ozlabs.org/project/ltp/list/?series=247103

> So I guess we have a name collision here. Something to consider is that
> GNU Make defines 'checks' as running self tests. So perhaps you are
> correct to use that word.

> I could rename the static analyses to 'analyze' or 'lint'. OTOH it might
> be better if running the self tests is called 'make
> run-{c,shell}-api-tests', because only a few people need to do
> that. Whereas it is intended that all contributors run the static
> analyses checks.

run-{c,shell}-api-tests is IMHO too long, but I was thinking about
check-{,c,shell}-api. But maybe you're right, let's wait for others opinions.

> Although, if someone runs 'make check' in the lib directory, then it
> makes sense to run the C API tests as well as do the analyses. Or not?

Yes, I'd be for having make check, which would run all check targets,
which can be also run separately:
make check-clang
make check-c
make check-shell

(or whatever we name these clang and C/shell API tests targets)

> > Taking 2 latests commits + adding clang-devel / libclang-dev packages makes CI
> > running.

> > https://github.com/pevik/ltp/commit/b2427f39ddb15c97761208a605637e0da6fe66ca

> Thanks, I guess this shows that libclang is well supported.
Yes, it looks to be even in old clang 3.5.


> > The only missing piece is include/mk/clang-checks.mk (this patchset not even
> > compile now).

> >> Richard Palethorpe (2):
> >>   Add 'make checks' and clang-checks to build system
> > make check ... clang-check (to avoid confusion).

> >>   Start libclang based analyzer and TEST() check

> >>  configure.ac                       |   2 +
> >>  include/mk/config.mk.in            |   5 +
> >>  include/mk/env_post.mk             |   8 ++
> >>  include/mk/generic_leaf_target.inc |   5 +-
> >>  include/mk/lib.mk                  |   3 +
> >>  include/mk/rules.mk                |   9 ++
> >>  include/mk/testcases.mk            |   1 +
> >>  tools/clang-checks/.gitignore      |   1 +
> >>  tools/clang-checks/Makefile        |  13 ++
> >>  tools/clang-checks/main.c          | 218 +++++++++++++++++++++++++++++
> > I'd name it tools/clang-check/ (and include/mk/clang-check.mk), but that's just
> > personal opinion.

> Yeah, we do not want a mixture of check and checks. I should probably
> just make it 'check' as it saves typing one letter.

+1

Kind regards,
Petr
