From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Jun 2021 12:10:38 +0200
Subject: [LTP] [RFC PATCH v2 1/1] make: Add make test{, -c, -c-run,
 -shell-run} targets
In-Reply-To: <YNGybhjq161LwfaN@pevik>
References: <20210618191252.12403-1-pvorel@suse.cz> <YNGmfnR6/FpzHe99@yuki>
 <YNGybhjq161LwfaN@pevik>
Message-ID: <YNG3HmqqBGNfWLOI@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

...
> > Why not just add runtest.sh into newlib_tests/ that would do all the
> > work, then we can forget about all the trickery and just run the scritp
> > on 'make test-c'. Well we would have to call make in newlib_tests first
> > to make sure it was compiled, but that should be it.

> > And the same for testcases/lib/.

> > I do not think that adding a target per a testcase is sane.

> Thanks for your input, makes sense. Actually, adding a script which would run it
> was my approach in 2 years old patch [1].

> I'll add runtest.sh which will run all tests which by default TPASS/TCONF now,
> but possible to specify just some tests (speedup the development).

Also make install works also on lib/newlib_tests. Thus I'll install also runtest.sh
and try to setup PATH a way it works on both running from git and running from
make install. It might be worth to have lib tests runnable on SUT.

Kind regards,
Petr

> After we merge it I'll continue in Christian's effort to add metadata of
> expected output [2], which allows us to run all tests (including these which
> fail).

> I suggest to add 3 targets: make test test-c test-shell (test will run both
> test-c test-shell).

> Kind regards,
> Petr

> [1] https://patchwork.ozlabs.org/project/ltp/patch/20190924182841.4528-1-pvorel@suse.cz/
> [2] https://patchwork.ozlabs.org/project/ltp/patch/ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com/
