From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 Feb 2020 09:53:03 +0100
Subject: [LTP] [PATCH V3 08/10] syscalls/move_mount: New tests
In-Reply-To: <20200226082318.eq5ozhgg2myscpqt@vireshk-i7>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <e12560056ebc632918426194172a6cba48953d4e.1582612624.git.viresh.kumar@linaro.org>
 <20200225135709.GC62318@gacrux.arch.suse.de>
 <20200226022758.ls35mblsetg4nk6f@vireshk-i7>
 <20200226074729.GA15207@dell5510>
 <20200226082318.eq5ozhgg2myscpqt@vireshk-i7>
Message-ID: <20200226085303.GA30488@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> On 26-02-20, 08:47, Petr Vorel wrote:
> > Your idea is correct, but IMHO it's not good to skip all the tests, which is
> > done due
> > tst_test.c:1051: BROK: Test 0 haven't reported results!
> > if you use tst_res(TBROK ...).

> I don't think that is the case. tst_res(TBROK, ...) shouldn't (and
> isn't for me) result in skipping of tests.
Correct, tst_res() itself doesn't exit the test. But the fact it uses TBROK
without reporting any result previously leads to tst_brk from the library:

tst_test.c:1036: BROK: Test haven't reported results!

tst_brk(TBROK, "Test %i haven't reported results!", i);

That's why I consider tst_res(TBROK problematic.

This is a separate discussion, see the patch I sent today
https://patchwork.ozlabs.org/patch/1244781/

Kind regards,
Petr

> > tst_brk(TBROK) is used for setup, where you create some resource, which is then
> > reused by all test runs, but this preparation fails.

> Right, but in my case I can't put all setup stuff in setup() callback
> and some of the setup bits stay in run() callback as well.
Sure. But as a result of it I'd personally use tst_res(TFAIL).
But maybe I'm wrong and others will correct me.

Kind regards,
Petr
