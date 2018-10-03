From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Oct 2018 11:51:07 +0200
Subject: [LTP] [RFC PATCH 1/1] Add automated tests for shell lib
In-Reply-To: <c859d712cb33f6bb151313d6664d786920e49500.1535725022.git.clanig@suse.com>
References: <20180829172448.GA2960@dell5510>
 <cover.1535725022.git.clanig@suse.com>
 <c859d712cb33f6bb151313d6664d786920e49500.1535725022.git.clanig@suse.com>
Message-ID: <20181003095107.GD23398@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/newlib_tests/shell/test.TST_TEST.getopts.sh b/lib/newlib_tests/shell/test.TST_TEST.getopts.sh
> new file mode 100755
> index 000000000..65810b5e8
> --- /dev/null
> +++ b/lib/newlib_tests/shell/test.TST_TEST.getopts.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +#
> +# Optional test command line parameters
> +#
> +
> +TST_OPTS="af:"
> +TST_USAGE=usage
> +TST_PARSE_ARGS=parse_args
> +TST_TESTFUNC=do_test
> +
> +. tst_test.sh
> +
> +ALTERNATIVE=0
> +MODE="foo"
> +
> +usage()
> +{
> +	cat << EOF
> +usage: $0 [-a] [-f <foo|bar>]
> +
> +OPTIONS
> +-a     Enable support for alternative foo
> +-f     Specify foo or bar mode
> +EOF
> +}
> +
> +parse_args()
> +{
> +	case $1 in
> +	a) ALTERNATIVE=1;;
> +	f) MODE="$2";;
> +	esac
> +}
> +
> +do_test()
> +{
> +	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MODE'"
> +}
> +
> +tst_run
> +# output:
> +# test 1 TPASS: Test 1 passed with data '': a: '0', f: 'foo'
> +# 
> +# Summary:
> +# passed   1
> +# failed   0
> +# skipped  0
> +# warnings 0

We do need a way how to pass parameters to the tests so that we can test
this functionality properly (and also the default options that are
implemented in the test library).

Obvious way how to do this is to allow to have several output: blocks at
the end of the test with a different parameters, something as:

# output:
# test 1 TPASS: Test 1 passed with data '': a: '0', f: 'foo'
# 
# Summary:
# passed   1
# failed   0
# skipped  0
# warnings 0

# output:
# params: -a
# test 1 TPASS: Test 1 passed with data '': a: '1', f: 'foo'
# 
# Summary:
# passed   1
# failed   0
# skipped  0
# warnings 0

...

> diff --git a/lib/newlib_tests/test_sh_newlib.sh b/lib/newlib_tests/test_sh_newlib.sh
> new file mode 100755
> index 000000000..bf335dd6e
> --- /dev/null
> +++ b/lib/newlib_tests/test_sh_newlib.sh
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# ?? 2018 SUSE LLC.
> +# 
> +# Author: Christian Lanig <clanig@suse.com>
> +
> +setup()
> +{
> +	path_sav=$PATH

There is no need to save and restore the PATH, the script will be
executed in subshell and the changes to variables are never propagated
to the parent shell.

The only way how variables can be changed in the currently running shell
is to source the script, in that case the current shell will execute the
commands.

> +	PATH=""$PATH":$(dirname $0)/../../testcases/lib/"
> +
> +	color_blue='\033[1;34m'
> +	color_green='\033[1;32m'
> +	color_red='\033[1;31m'
> +	standard_color='\033[0m'
          ^
	  This is more of 'reset text attributes' as it not only changes
	  the color to default but also turns off bold, underscore,
	  blink, etc. So it would be better named something as
	  reset_attrs='\033[0m'

> +	tmp_dir="/tmp/sh_lib_tst-$$/"
> +	mkdir $tmp_dir || cleanup 1
> +	sh_lib_tst_dir="$(dirname $0)/shell/"
> +	tst_files="$(ls $sh_lib_tst_dir)"
> +	return 0
> +}
> +
> +cleanup()
> +{
> +	[ -d "$tmp_dir" ] && rm -rf "$tmp_dir"
> +	PATH="$PATH_sav"
> +	exit $1
> +}
> +
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
> +}
> +
> +verify_output()
> +{
> +	[ -e "$sh_lib_tst_dir$tst" ] || { printf "$tst not found\n" && \
> +			cleanup 1 ;}
> +	# read all lines after line: `# output:`, and strip `# ` from beginning
> +	sed -n -e '/^# output:/,$ p;' "$sh_lib_tst_dir$tst" | sed '1d; s/^# //'\
> +			> "$tmp_dir$tst.wanted" || cleanup 1

Usually doing more complex text manipulation is easier with awk

In this case you can use gsub() function that will replace substring and
print all lines that were replaced (i.e. print all comments without the
hash and space):

awk 'gsub("^# ", "", $0)' script.sh

Then you can even get one of the output: blocks with:

awk -vb=1 'gsub("^# ", "", $0) {if (/output:/) {p++}; if (p==b && !/output:/) {print $0}};' script.sh
       ^
       This gives you content of comments starting at first # output:
       line up to the next # output: or end of line, which is exactly
       what we need if we want to support passing parameters to
       testcases. Then we can simply count how many # output: lines are
       in a file and then run this command in a loop extracting one
       example output after another.

> +	actual_output=$($sh_lib_tst_dir$tst)
> +	# remove control signs, add newline at EOF and store in temporary file
> +	actual_output=$(printf "$actual_output\n" > $tmp_dir$tst".actual") ||
> +			cleanup 1
> +
> +	cmp $tmp_dir$tst".actual" $tmp_dir$tst".wanted" > /dev/null && return 0
> +	return 1
> +}
> +
> +run_tests()
> +{
> +	pass_cnt=0
> +	fail_cnt=0
> +	printf "\n"
> +	for tst in $tst_files; do
> +		if verify_output; then
> +			pass_cnt=$(expr $pass_cnt + 1)

You can use arithmetic expansion here, i.e. pass_cnt=$((pass_cnt+1))

> +			printf ""$color_green"TPASS$standard_color $tst"
> +			printf "\n"
> +		else
> +			fail_cnt=$(expr $fail_cnt + 1)

And here as well.

> +			printf ""$color_red"TFAIL$standard_color $tst\n"
> +			printf ""$color_blue"Diff:$standard_color\n"
> +			diff -u "$tmp_dir$tst.actual" "$tmp_dir$tst.wanted"
> +			printf "\n"
> +		fi
> +	done
> +	printf "\nSummary:\n"
> +	printf ""$color_red"Failed:$standard_color $fail_cnt\n"
> +	printf ""$color_green"Passed:$standard_color $pass_cnt\n\n"
> +	return $fail_cnt
> +}
> +
> +setup
> +parse_params "$@"
> +run_tests
> +res=$?
> +cleanup $res
> -- 
> 2.16.4
> 

-- 
Cyril Hrubis
chrubis@suse.cz
