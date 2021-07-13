From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 16:16:48 +0200
Subject: [LTP] [PATCH v4 4/7] lib: Add script for running tests
In-Reply-To: <YO2T4J14roLUT32t@yuki>
References: <20210713101338.6985-1-pvorel@suse.cz>
 <20210713101338.6985-5-pvorel@suse.cz> <YO2T4J14roLUT32t@yuki>
Message-ID: <YO2gUL2/s29SGdNo@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > For now run only tests which TPASS or TCONF.

> > Disabled also problematic tests:

> > * tst_bool_expr: for some reason killed after testing:

> > /__w/ltp/ltp/lib/newlib_tests/tst_bool_expr.c:41: TINFO: Parsing 'A ( B )'
> > A ( B )

> > Summary:
> > passed   24
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0
> > PATH: '/__w/ltp/ltp/../ltp-build/testcases/lib:/__w/ltp/ltp/lib/newlib_tests/../../testcases/lib/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
> > DEBUG: 0
> > /__w/ltp/ltp/lib/tst_test.c:1363: TBROK: Test killed by SIGSEGV!

> I've executed the test under valgrind and found some "conditional jump
> depends on uninitialized value", which is because we do not clear the
> priv pointer for newly added tokens. Does this patch fix it for you?

> diff --git a/lib/tst_bool_expr.c b/lib/tst_bool_expr.c
> index 387c38b91..15825e364 100644
> --- a/lib/tst_bool_expr.c
> +++ b/lib/tst_bool_expr.c
> @@ -55,6 +55,7 @@ static int new_tok(struct tst_expr_tok **last, const char *tok, size_t tok_len)
>         (*last)->tok = tok;
>         (*last)->tok_len = tok_len;
>         (*last)->op = char_to_op(tok[0]);
> +       (*last)->priv = NULL;
>         (*last)++;

Thanks! It looks like it helped (but few jobs haven't finished yet).
https://github.com/pevik/ltp/actions/runs/1026771350
Will you merge this fix yourself please?

>         return 1;

> > * tst_fuzzy_sync01: sporadically fails:
> > ../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops, requesting exit
> > tst_fuzzy_sync01.c:227: TFAIL: acs:3  act:1  art:1  | =:23   -:46   +:2999931
> > ...
> > Summary:
> > passed   21
> > failed   3

> Not sure what we can do here, I guess that timings would be hard to fix
> on VMs that run the tests.

If I remember correctly Richie suggested that FAIL is also OK. He said only
TBROK and TCONF is a problem. I'd prefer to fuzzy sync tests which always pass,
but after this effort I can work on API tests metadata, which would allow also
this.

...
> > +# custom version
> > +tst_res()
> > +{
> > +	if [ $# -eq 0 ]; then
> > +		echo >&2
> > +		return
> > +	fi
> > +
> > +	local res="$1"
> > +	shift
> > +
> > +	tst_color_enabled
> > +	local color=$?
> > +
> > +	printf "runtest " >&2
> > +	tst_print_colored $res "$res: " >&2
> > +	echo "$@" >&2
> > +
> > +}
> > +
> > +# custom version
> > +tst_brk()
> > +{
> > +	local res="$1"
> > +	shift
> > +
> > +	tst_flag2mask "$res"
> > +	local mask=$?
> > +
> > +	tst_res
> > +	tst_res $res $@
> > +
> > +	exit $mask
> > +}

> I'm not sure that we should call these function tst_res and tst_brk it
> only confuses everything since these are different from the ones in the
> test library.
OK, I'll rename it (runtest_res() and runtest_brk()).

> > +run_tests()
> > +{
> > +	local target="$1"
> > +	local i ret tconf tpass vars
> > +
> > +	eval vars="\$LTP_${target}_API_TESTS"
> > +
> > +	tst_res TINFO "=== Run $target tests ==="
> > +
> > +	for i in $vars; do
> > +		tst_res TINFO "* $i"
> > +		./$i
> > +		ret=$?
> > +
> > +		case $ret in
> > +			0) tpass="$tpass $i";;
> > +			1) tst_brk TFAIL "$i failed with TFAIL";;
> > +			2) tst_brk TFAIL "$i failed with TBROK";;
> > +			4) tst_brk TFAIL "$i failed with TWARN";;
> > +			32) tconf="$tconf $i";;
> > +			127) tst_brk TBROK "Error: file not found (wrong PATH? out-of-tree build without -b?), exit code: $ret";;
> > +			*) tst_brk TBROK "Error: unknown failure, exit code: $ret";;

> Why do we exit on failure here?

> We should just increase the fail counters and go ahead with next test.

I quit here because you know how hard is to find error in very long log
file. Also why to waste developer time when some test failed? Similar approach
make has. But sure, I can continue here and print summary at the end.

Thanks for your review!
I merged the first 3 commits.

Kind regards,
Petr
