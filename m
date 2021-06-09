From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Jun 2021 16:05:42 +0200
Subject: [LTP] [Automated-testing] [PATCH 3/4] lib: Introduce concept of
 max_test_runtime
In-Reply-To: <YMDC/mjGTXxoq9uH@yuki>
References: <20210609114659.2445-1-chrubis@suse.cz>
 <20210609114659.2445-4-chrubis@suse.cz> <YMDBFfCZwYDYwWDg@pevik>
 <YMDC/mjGTXxoq9uH@yuki>
Message-ID: <YMDKttIQJfdszYgt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > >   - the scaled value is then divided, if needed, so that we end up a
> > >     correct maximal runtime for an instance of a test, i.e. we have
> > >     max runtime for an instance fork_testrun() that is inside of
> > >     .test_variants and .all_filesystems loops
> > Now "Max runtime per iteration" can vary, right? I.e. on .all_filesystems
> > runtime for each filesystems depends on number of filesystems? E.g. writev03.c
> > with setup .timeout = 600 on 2 filesystems is 5 min (300s), but with all 9
> > filesystems is about 1 min. We should document that author should expect max
> > number of filesystems. What happen with these values in the (long) future, when
> > LTP support new filesystem (or drop some)? This was a reason for me to define in
> > the test value for "Max runtime per iteration", not whole run.

> That's one of the downsides of this approach.

> The reason why I choose this approach is that you can set upper cap for
> the whole test run and not only for a single filesystem/variant.

> Also this way the test timeout corresponds to the maximal test runtime.

> Another option would be to redefine the timeout to be timeout per a
> fork_testrun() instance, which would make the approach slightly easier
> in some places, however that would mean either changing default test
> timeout to much smaller value and annotating all long running tests.
IMHO slightly better approach to me.

> Hmm, I guess that annotating all long running tests and changing default
> timeout may be a good idea regardless this approach.
+1

> > >   - this also allows us to controll the test max runtime by setting a
> > >     test timeout

> > > * The maximal runtime, per whole test, can be passed down to the test

> > >   - If LTP_MAX_TEST_RUNTIME is set in test environment it's used as a
> > >     base for max_runtime instead of the scaled down timeout, it's still
> > >     divided into pieces so that we have correct runtime cap for an
> > >     fork_testrun() instance
> > LTP_MAX_TEST_RUNTIME should go to doc/user-guide.txt. I suppose you waiting for
> > a feedback before writing docs.

> Yes I do not consider this to be finished patchset and I do expect that
> it would need some changes.
Sure.

> > >   - We also make sure that test timeout is adjusted, if needed, to
> > >     accomodate for the new test runtime cap, i.e. if upscaled runtime is
> > >     greater than timeout, the test timeout is adjusted

> > > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > > ---
> > >  include/tst_fuzzy_sync.h                      |  4 +-
> > >  include/tst_test.h                            |  7 +-
> > >  lib/newlib_tests/.gitignore                   |  3 +-
> > >  .../{test18.c => test_runtime01.c}            |  7 +-
> > >  lib/newlib_tests/test_runtime02.c             | 31 +++++++++
> > >  lib/tst_test.c                                | 64 ++++++++++++++++++-
> > >  testcases/kernel/crypto/af_alg02.c            |  2 +-
> > >  testcases/kernel/crypto/pcrypt_aead01.c       |  2 +-
> > >  testcases/kernel/mem/mtest01/mtest01.c        |  6 +-
> > >  testcases/kernel/mem/mtest06/mmap1.c          | 13 ++--
> > >  .../kernel/syscalls/move_pages/move_pages12.c |  4 +-
> > >  11 files changed, 117 insertions(+), 26 deletions(-)
> > >  rename lib/newlib_tests/{test18.c => test_runtime01.c} (59%)
> > +1 for test description instead of plain number.

> > ...
> > > +++ b/lib/newlib_tests/test_runtime01.c
> > ...
> > >  static void run(void)
> > >  {
> > > -	do {
> > > +	while (tst_remaining_runtime())
> > >  		sleep(1);
> > > -	} while (tst_timeout_remaining() >= 4);

> > > -	tst_res(TPASS, "Timeout remaining: %d", tst_timeout_remaining());
> > > +	tst_res(TPASS, "Timeout remaining: %d", tst_remaining_runtime());

> > There is a warning:
> > tst_test.c:1369: TINFO: Timeout per run is 0h 00m 05s
> > tst_test.c:1265: TWARN: Timeout too short for runtime offset 5!
> > tst_test.c:1309: TINFO: runtime > timeout, adjusting test timeout to 6
> > tst_test.c:1318: TINFO: Max runtime per iteration 1s
> > test_runtime01.c:15: TPASS: Timeout remaining: 0

> This is expected.

> > Maybe test should use value without warning (i.e. 7).
> > Or is the warning intended to be the test output?

> > .timeout = 6 fails:

> > tst_test.c:1369: TINFO: Timeout per run is 0h 00m 06s
> > tst_test.c:1304: TBROK: Test runtime too small!

> This is one of the corner cases that probably needs to be handled
> differently.
+1

...
> > Also test_runtime02.c fails, is that intended?
> > tst_test.c:1374: TINFO: Timeout per run is 0h 00m 05s
> > tst_test.c:1265 timeout_to_runtime(): results->timeout: 5
> > tst_test.c:1266 timeout_to_runtime(): RUNTIME_TIMEOUT_OFFSET: 5
> > tst_test.c:1268: TWARN: Timeout too short for runtime offset 5!
> > tst_test.c:1314: TINFO: runtime > timeout, adjusting test timeout to 6
> > tst_test.c:1321: TBROK: Test runtime too small!

> Yes, this is also supposed to fail, it's written in the test comment as
> well...
I'm sorry to overlook this. Hope I'll finish test-c-run soon, so that we can
continue with expected test output for API tests.

Kind regards,
Petr
