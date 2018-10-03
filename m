From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 3 Oct 2018 13:32:15 +0200
Subject: [LTP] [RFC PATCH 1/1] Add automated tests for shell lib
In-Reply-To: <c859d712cb33f6bb151313d6664d786920e49500.1535725022.git.clanig@suse.com>
References: <20180829172448.GA2960@dell5510>
 <cover.1535725022.git.clanig@suse.com>
 <c859d712cb33f6bb151313d6664d786920e49500.1535725022.git.clanig@suse.com>
Message-ID: <20181003113215.GB21139@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

some more comments (beside these mentioned by Cyril).
Mostly just shell code style comments.

> +test2()
> +{
> +	tst_res TPASS "Test $1 passed with no data ('$2')"
> +}
> +
> +tst_run
> +# output:
> +# test 1 TPASS: Test 1 passed with no data ('')
> +# test 2 TPASS: Test 2 passed with no data ('')
> +# 
Note, I'd prefer not have trailing whitespace after '#' (actually anywhere).
Not only it's unnecessary it's also problematic for 'git am' applying patches.
In my case all the tests failed because of it.
Also some people setup their editors / IDE to delete trailing whitespace.
(Not pointing all whitespace here.)

> +# Summary:
> +# passed   2
> +# failed   0
> +# skipped  0
> +# warnings 0

> diff --git a/lib/newlib_tests/test_sh_newlib.sh b/lib/newlib_tests/test_sh_newlib.sh
...
> +setup()
> +{
> +	path_sav=$PATH
> +	PATH=""$PATH":$(dirname $0)/../../testcases/lib/"
> +	color_blue='\033[1;34m'
> +	color_green='\033[1;32m'
> +	color_red='\033[1;31m'
> +	standard_color='\033[0m'

Maybe this variables can be outside of setup (no benefit to have them in setup.

> +	tmp_dir="/tmp/sh_lib_tst-$$/"

Although /tmp is everywhere, maybe using $TMPDIR would be good. See tst_test.sh
code:
		if [ -z "$TMPDIR" ]; then
			export TMPDIR="/tmp"
		fi

		TST_TMPDIR=$(mktemp -d "$TMPDIR/LTP_$TST_ID.XXXXXXXXXX")

		chmod 777 "$TST_TMPDIR"

> +	mkdir $tmp_dir || cleanup 1
> +	sh_lib_tst_dir="$(dirname $0)/shell/"
Maybe just tstdir ?
> +	tst_files="$(ls $sh_lib_tst_dir)"

> +print_help()
> +{
> +	printf "#############################################################\n"
> +	printf "# This script iterates over test cases for the new shell    #\n"
> +	printf "# library and verifies the output.                          #\n"
> +	printf "#############################################################\n"
> +	printf "\n"
> +	printf "Usage:\n"
> +	printf "\t$(basename $0)\n"
> +	printf "\t$(basename $0) [test file 1] [test file 2] ...\n\n"
> +	exit 0;

Maybe just:
    cat <<EOF
Unit tests for new shell API
Usage: $(basename $0) [ TEST1 ] [ TEST2 ] 
EOF

> +}
> +
> +parse_params()
> +{
> +	[ -n "$1" ] && tst_files=
> +	while [ -n "$1" ]; do
> +		case "$1" in
> +			--help) print_help;;
> +			-h) print_help;;
> +			-*)
> +				printf "Unknown positional parameter "$1".\n"
> +				cleanup 1;;
> +			*) tst_files="$tst_files $1";;
> +		esac
> +		shift
> +	done
> +	return 0
Why return, when you don't use it elsewhere?

...
> +verify_output()
> +{
> +	[ -e "$sh_lib_tst_dir$tst" ] || { printf "$tst not found\n" && \
> +			cleanup 1 ;}
This might be more readable (nitpicking):
if [ -n "$sh_lib_tst_dir$tst" ]; then
	echo "$tst not found"
	cleanup 1
fi

> +	# read all lines after line: `# output:`, and strip `# ` from beginning
> +	sed -n -e '/^# output:/,$ p;' "$sh_lib_tst_dir$tst" | sed '1d; s/^# //'\
> +			> "$tmp_dir$tst.wanted" || cleanup 1
> +
> +	actual_output=$($sh_lib_tst_dir$tst)

> +	# remove control signs, add newline at EOF and store in temporary file
> +	actual_output=$(printf "$actual_output\n" > $tmp_dir$tst".actual") ||
> +			cleanup 1
Suppose this part will be rewritten. But why do you assign empty string?
echo "$actual_output" > $tmp_dir$tst".actual || cleanup 1

...
> +
> +	cmp $tmp_dir$tst".actual" $tmp_dir$tst".wanted" > /dev/null && return 0
> +	return 1
This is enough (cmp returns it for you):
cmp -s "$tmp_dir$tst.actual" "$tmp_dir$tst.wanted"
> +}

...
> +run_tests()
> +{
> +	pass_cnt=0
> +	fail_cnt=0
> +	printf "\n"
> +	for tst in $tst_files; do
> +		if verify_output; then
> +			pass_cnt=$(expr $pass_cnt + 1)
> +			printf ""$color_green"TPASS$standard_color $tst"
                   ^
"" is empty string, why?
> +			printf "\n"
You can also use {} to separate variable name:
echo "${color_green}TPASS$standard_color $tst"
echo adds new line for you (for simple usage it's portable).
It's safer to quote whole string (with variables).

> +		else
> +			fail_cnt=$(expr $fail_cnt + 1)
> +			printf ""$color_red"TFAIL$standard_color $tst\n"
> +			printf ""$color_blue"Diff:$standard_color\n"
> +			diff -u "$tmp_dir$tst.actual" "$tmp_dir$tst.wanted"
> +			printf "\n"
> +		fi
> +	done
> +	printf "\nSummary:\n"
> +	printf ""$color_red"Failed:$standard_color $fail_cnt\n"
> +	printf ""$color_green"Passed:$standard_color $pass_cnt\n\n"

And how about adding helper functions print_red, print_green, print_blue?
Maybe not worth for this little script.

print_red()
{
	printf "$red$1$reset"
}
print_red "TFAIL
echo "$tst"

> +	return $fail_cnt
> +}
> +
> +setup
> +parse_params "$@"

> +run_tests
> +res=$?
> +cleanup $res
No need to have $res:
run_tests
cleanup $?


Kind regards,
Petr
