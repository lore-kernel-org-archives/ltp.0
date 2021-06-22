From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Jun 2021 11:50:38 +0200
Subject: [LTP] [RFC PATCH v2 1/1] make: Add make test{, -c, -c-run,
 -shell-run} targets
In-Reply-To: <YNGmfnR6/FpzHe99@yuki>
References: <20210618191252.12403-1-pvorel@suse.cz>
 <YNGmfnR6/FpzHe99@yuki>
Message-ID: <YNGybhjq161LwfaN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > For testing C and shell API.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,

> > another attempt for make test target.

> > In a long term, I'd like to wrap the execution with some script, as I
> > suppose there will be some metadata in test, allowing to run tests which
> > don't TPASS or TBROK (we have quite a lot of them). Then the summary
> > would be even more useful.

> > FIXME: broken in lib/, it runs all test twice.

> > changes v1->v2:
> > Not sure if it's a good approach to process each test separately,
> > there is no loop as Cyril suggested in [1], thus there is no summary
> > what happen.

> > I previously had in similar loop in include/mk/generic_leaf_target.inc:

> > test-c-run: $(TEST_TARGETS)
> > 	@set -e; echo; echo "===== Test C API ====="; \
> > 	for i in $(TEST_TARGETS); do \
> > 	    echo; echo "* $$i"; \
> > 	    echo "PATH $(top_srcdir)/testcases/lib:$$PATH"; \
> > 	    PATH="$(top_srcdir)/testcases/lib:$$PATH" ./$$i || [ $$? -eq 32 ]; \
> > 	done; echo; \
> > 	echo "All C API tests passed or TCONF"

> > test-shell-run:
> > 	@set -e; echo; echo "===== Test shell API ====="; \
> > 	for i in $(TEST_SHELL_TARGETS); do \
> > 	    echo; echo "* $$i"; \
> > 	    PATH="$(abs_top_srcdir)/testcases/lib:$(abs_top_builddir)/testcases/lib:$$PATH" $(abs_srcdir)/$$i || [ $$? -eq 32 ]; \
> > 	done; echo; \
> > 	echo "All shell API tests passed or TCONF"

> > but that was problematic in lib (which uses generic_leaf_target.inc).

> Why not just add runtest.sh into newlib_tests/ that would do all the
> work, then we can forget about all the trickery and just run the scritp
> on 'make test-c'. Well we would have to call make in newlib_tests first
> to make sure it was compiled, but that should be it.

> And the same for testcases/lib/.

> I do not think that adding a target per a testcase is sane.

Thanks for your input, makes sense. Actually, adding a script which would run it
was my approach in 2 years old patch [1].

I'll add runtest.sh which will run all tests which by default TPASS/TCONF now,
but possible to specify just some tests (speedup the development).

After we merge it I'll continue in Christian's effort to add metadata of
expected output [2], which allows us to run all tests (including these which
fail).

I suggest to add 3 targets: make test test-c test-shell (test will run both
test-c test-shell).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20190924182841.4528-1-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/patch/ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com/
