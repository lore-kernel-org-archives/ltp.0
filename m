From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 May 2018 15:53:27 +0200
Subject: [LTP] [RFC PATCH v3 1/2] tst_test.sh: Add TST_TEST_DATA and
 TST_TEST_DATA_IFS
In-Reply-To: <20180524134143.GA20945@rei>
References: <20180522193430.20117-1-pvorel@suse.cz>
 <20180524134143.GA20945@rei>
Message-ID: <20180524135327.q5bs2uydjrygaeoq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your comments

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Changes v2->v3:
> > * Don't pass $TST_TEST_DATA as whole argument for $TST_CNT (Cyril)
> > * Create tst_run_tests() for cleanup (Cyril).
> > * Create tst_run_test() - more cleanup

> > Maybe we should try to "hide" somehow these API functions (underscore at
> > the front?).

> Actually this is a good idea, we can follow the python underscore
> notation that uses it for private variables and functions. Hence the
> counters will become _tst_i, etc.

> But please do that in a separate patch.
I meant to add underscore before new functions i.e. _tst_run_tests() and _tst_run_test().
Variables: do you mean to change local variables in tst_run()?
That would be really for separate patch.

> > ---
> >  doc/test-writing-guidelines.txt | 74 +++++++++++++++++++++++++++++++++++++----
> >  testcases/lib/tst_test.sh       | 61 +++++++++++++++++++++------------
> >  2 files changed, 106 insertions(+), 29 deletions(-)

...
> > +TST_TESTFUNC=do_test
> > +TST_CNT=2
> > +TST_TEST_DATA="foo:bar:d dd"
> > +. tst_test.sh
> > +
> > +do_test()
> > +{
> > +	case $1 in
> > +	1) tst_res TPASS "Test $1 passed with data '$2'";;
> > +	2) tst_res TPASS "Test $1 passed with data '$2'";;
> > +	esac
> > +}
> > +
> > +tst_run
> > +# output:
> > +# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
> > +# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
> > +
> > +-------------------------------------------------------------------------------
> > +When '$TST_TEST_DATA' is used with '$TST_CNT', it's passed as whole string in
> > +'$2' ($1 is for the test number), '$TST_TEST_DATA_IFS' is ignored. Similar
> > +would be when using these variables with separate functions.

> Now that we support both TST_CNT and TST_TEST_DATA_IFS can we change
> this example to include the TST_TEST_DATA_IFS=":" as well?
I wanted to demonstrate that TST_TEST_DATA_IFS has a default value ' ').
But ok, I'll change it to define TST_TEST_DATA_IFS as well.

...
> > +	for tst_i in $(seq ${TST_CNT:-1}); do
> > +		if type test1 > /dev/null 2>&1; then

> I know that this is not your fault but this should be probably:

> if type ${TST_TESTFUNC}1 > /dev/null 2>&1; ...
Thanks, I'll fix it, in a separate commit.

> > +tst_run_test()
> > +{
> > +	local res=$(tst_resstr)

> Can we please prefix the res here with tst_ as well since we are
> touching the code?
Sure. To be honest I wasn't sure whether there is some reason for $res being named without
prefix or not.


Kind regards,
Petr
