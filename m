From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jul 2021 15:23:44 +0200
Subject: [LTP] [PATCH v4 4/7] lib: Add script for running tests
In-Reply-To: <20210713101338.6985-5-pvorel@suse.cz>
References: <20210713101338.6985-1-pvorel@suse.cz>
 <20210713101338.6985-5-pvorel@suse.cz>
Message-ID: <YO2T4J14roLUT32t@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> For now run only tests which TPASS or TCONF.
> 
> Disabled also problematic tests:
> 
> * tst_bool_expr: for some reason killed after testing:
> 
> /__w/ltp/ltp/lib/newlib_tests/tst_bool_expr.c:41: TINFO: Parsing 'A ( B )'
> A ( B )
> 
> Summary:
> passed   24
> failed   0
> broken   0
> skipped  0
> warnings 0
> PATH: '/__w/ltp/ltp/../ltp-build/testcases/lib:/__w/ltp/ltp/lib/newlib_tests/../../testcases/lib/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
> DEBUG: 0
> /__w/ltp/ltp/lib/tst_test.c:1363: TBROK: Test killed by SIGSEGV!

I've executed the test under valgrind and found some "conditional jump
depends on uninitialized value", which is because we do not clear the
priv pointer for newly added tokens. Does this patch fix it for you?

diff --git a/lib/tst_bool_expr.c b/lib/tst_bool_expr.c
index 387c38b91..15825e364 100644
--- a/lib/tst_bool_expr.c
+++ b/lib/tst_bool_expr.c
@@ -55,6 +55,7 @@ static int new_tok(struct tst_expr_tok **last, const char *tok, size_t tok_len)
        (*last)->tok = tok;
        (*last)->tok_len = tok_len;
        (*last)->op = char_to_op(tok[0]);
+       (*last)->priv = NULL;
        (*last)++;

        return 1;

> * tst_fuzzy_sync01: sporadically fails:
> ../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops, requesting exit
> tst_fuzzy_sync01.c:227: TFAIL: acs:3  act:1  art:1  | =:23   -:46   +:2999931
> ...
> Summary:
> passed   21
> failed   3

Not sure what we can do here, I guess that timings would be hard to fix
on VMs that run the tests.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Partly rewritten since v3.
> 
>  lib/newlib_tests/runtest.sh | 148 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100755 lib/newlib_tests/runtest.sh
> 
> diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
> new file mode 100755
> index 000000000..80bba00e9
> --- /dev/null
> +++ b/lib/newlib_tests/runtest.sh
> @@ -0,0 +1,148 @@
> +#!/bin/sh
> +# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
> +
> +LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
> +test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync02 tst_fuzzy_sync03}"
> +
> +LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
> +
> +cd $(dirname $0)
> +PATH="$PWD/../../testcases/lib/:$PATH"
> +
> +. tst_ansi_color.sh
> +
> +usage()
> +{
> +	cat << EOF
> +Usage: $0 [-b DIR ] [-c|-s]
> +-b DIR  build directory (required for out-of-tree build)
> +-c      run C API tests only
> +-s      run shell API tests only
> +-h      print this help
> +EOF
> +}
> +
> +# custom version
> +tst_flag2mask()
> +{
> +	case "$1" in
> +	TPASS) return 0;;
> +	TFAIL) return 1;;
> +	TBROK) return 2;;
> +	TWARN) return 4;;
> +	TINFO) return 16;;
> +	TCONF) return 32;;
> +	esac
> +}
> +
> +# custom version
> +tst_res()
> +{
> +	if [ $# -eq 0 ]; then
> +		echo >&2
> +		return
> +	fi
> +
> +	local res="$1"
> +	shift
> +
> +	tst_color_enabled
> +	local color=$?
> +
> +	printf "runtest " >&2
> +	tst_print_colored $res "$res: " >&2
> +	echo "$@" >&2
> +
> +}
> +
> +# custom version
> +tst_brk()
> +{
> +	local res="$1"
> +	shift
> +
> +	tst_flag2mask "$res"
> +	local mask=$?
> +
> +	tst_res
> +	tst_res $res $@
> +
> +	exit $mask
> +}

I'm not sure that we should call these function tst_res and tst_brk it
only confuses everything since these are different from the ones in the
test library.

> +run_tests()
> +{
> +	local target="$1"
> +	local i ret tconf tpass vars
> +
> +	eval vars="\$LTP_${target}_API_TESTS"
> +
> +	tst_res TINFO "=== Run $target tests ==="
> +
> +	for i in $vars; do
> +		tst_res TINFO "* $i"
> +		./$i
> +		ret=$?
> +
> +		case $ret in
> +			0) tpass="$tpass $i";;
> +			1) tst_brk TFAIL "$i failed with TFAIL";;
> +			2) tst_brk TFAIL "$i failed with TBROK";;
> +			4) tst_brk TFAIL "$i failed with TWARN";;
> +			32) tconf="$tconf $i";;
> +			127) tst_brk TBROK "Error: file not found (wrong PATH? out-of-tree build without -b?), exit code: $ret";;
> +			*) tst_brk TBROK "Error: unknown failure, exit code: $ret";;

Why do we exit on failure here?

We should just increase the fail counters and go ahead with next test.

> +		esac
> +		tst_res
> +	done
> +
> +	[ -z "$tpass" ] && tpass=" none"
> +	[ -z "$tconf" ] && tconf=" none"
> +
> +	tst_res TINFO "=== $target TEST RESULTS ==="
> +	tst_res TINFO "Tests exited with TPASS:$tpass"
> +	tst_res TINFO "Tests exited with TCONF:$tconf"
> +	tst_res
> +}
> +
> +run_c_tests()
> +{
> +	if [ "$builddir" ]; then
> +		cd $builddir/lib/newlib_tests
> +	fi
> +
> +	run_tests "C"
> +
> +	if [ "$builddir" ]; then
> +		cd -
> +	fi
> +}
> +
> +run_shell_tests()
> +{
> +	run_tests "SHELL"
> +}
> +
> +builddir=
> +run=
> +while getopts b:chs opt; do
> +	case $opt in
> +		'h') usage; exit 0;;
> +		'b') builddir=$OPTARG; PATH="$builddir/testcases/lib:$PATH";;
> +		'c') run="c";;
> +		's') run="s";;
> +		*) usage; tst_brk TBROK "Error: invalid option";;
> +	esac
> +done
> +
> +tst_res TINFO "PATH='$PATH'"
> +
> +if [ -z "$run" -o "$run" = "c" ]; then
> +	run_c_tests
> +fi
> +
> +if [ -z "$run" -o "$run" = "s" ]; then
> +	run_shell_tests
> +fi
> +
> +tst_res TPASS "No test failed"
> -- 
> 2.32.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
