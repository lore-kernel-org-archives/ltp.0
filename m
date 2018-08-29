From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Aug 2018 19:24:48 +0200
Subject: [LTP] [PATCH 1/2] Make shell lib tests standalone
In-Reply-To: <20180828111844.20152-1-clanig@suse.com>
References: <20180522193430.20117-2-pvorel@suse.cz>
 <20180828111844.20152-1-clanig@suse.com>
Message-ID: <20180829172448.GA2960@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

this expects have applied my patch
https://patchwork.ozlabs.org/patch/918549/
http://lists.linux.it/pipermail/ltp/2018-May/008191.html
Christian, next time merge it with your changes (these 3 commits should be just
one, with you as author.)

Before I delve into the details, just comment the functionality.

$ ./lib/newlib_tests/test.shell_lib.sh
Running Test: "test.TST_TEST_DATA.getopts"...
TFAIL:Test test.TST_TEST_DATA.getopts was unsuccessful.

Running Test: "test.TST_TEST_DATA_IFS.getopts"...
TFAIL:Test test.TST_TEST_DATA_IFS.getopts was unsuccessful.

Running Test: "test.TST_TEST_DATA_IFS"...
TFAIL:Test test.TST_TEST_DATA_IFS was unsuccessful.

Running Test: "test.TST_TEST_DATA"...
TFAIL:Test test.TST_TEST_DATA was unsuccessful.

Running Test: "test.TST_TEST_DATA.TST_CNT.separate"...
TFAIL:Test test.TST_TEST_DATA.TST_CNT.separate was unsuccessful.

Running Test: "test.TST_TEST_DATA.TST_CNT"...
TFAIL:Test test.TST_TEST_DATA.TST_CNT was unsuccessful.

Running Test: "test.TST_TEST.getopts"...
TFAIL:Test test.TST_TEST.getopts was unsuccessful.

Running Test: "test.TST_TEST"...
TPASS: Test test.TST_TEST was successful.

Running Test: "test.TST_TEST.TST_CNT.separate"...
TFAIL:Test test.TST_TEST.TST_CNT.separate was unsuccessful.

Running Test: "test.TST_TEST.TST_CNT"...
TFAIL:Test test.TST_TEST.TST_CNT was unsuccessful.

---
These tests must be all green before merging them.
I suppose the failures are because only 5 of 10 tests have "# output:" (parsed
by verify_output()).

About the output. See Cyril's comments about my patch for running C tests
http://lists.linux.it/pipermail/ltp/2018-August/009119.html

Inconsistent output: space after 'TPASS:', not after 'TFAIL:'. I wouldn't use ':'.

Output doesn't tell, what's wrong. IMHO there should be diff of expected output
vs. real output. This is done in xfstests.

+ It could be less verbose. Let's use:

$ ./lib/newlib_tests/test.shell_lib.sh
TFAIL test.TST_TEST_DATA.getopts
[ diff output whats wrong ]
TPASS test.TST_TEST

Summary:
passed   1
failed   1

The name itself would IMHO be better 
test_tst_test.sh or test.tst_test.sh (but we don't use often dot in name).
ATM we have old and new legacy API, test.shell_lib.sh doesn't say which it
tests.

> ---
> Please do not merge! See following message for details.
You can use --rfc switch for git format-patch next time.

...
> --- a/lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh
> +++ b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
> @@ -5,7 +5,7 @@

>  TST_TESTFUNC=test
>  TST_CNT=2
> -. tst_test.sh
> +. ./tst_test.sh
This is not good. Much better is to make sure, that testcases/lib/ directory
(where tst_test.sh is) is in PATH variable. The reasons are that you don't
expect current working directory be in the same directory as the test. See:
$ cd lib/newlib_tests
$ ./shell/test.TST_TEST.TST_CNT.separate.sh
bash: ./shell/test.TST_TEST.TST_CNT.separate.sh: No such file or directory

And the tests are supposed to be also examples in docs, where we prefer not
forcing cd into /opt/ltp/testcases/bin.
...

> diff --git a/lib/newlib_tests/test.shell_lib.sh b/lib/newlib_tests/test.shell_lib.sh
> new file mode 100755
> index 000000000..599eec78a
> --- /dev/null
> +++ b/lib/newlib_tests/test.shell_lib.sh
> @@ -0,0 +1,94 @@
> +# !/bin/sh
    ^ Please no space after.

checkbashisms.pl [1] warns you about it:
$ checkbashisms.pl -f test.shell_lib.sh
script test.shell_lib.sh does not appear to have a #! interpreter line;
you may get strange results

> +#
> +# This script iterates over all test cases for the new shell lib and verifies
> +# the output.
> +# Do NOT use newline symbols in the names of files containing test cases!
> +#
Maybe you want to add your copyright here.
You should add license (GPL v2 + any other). I prefer SPDX-License-Identifier as
it's short:
# SPDX-License-Identifier: GPL-2.0-or-later

> +
> +setup() {
> +	color_green="\033[1;32m"
> +	color_red="\033[1;31m"
> +	standard_color="\033[0m"
> +	start_dir="$PWD"
> +	cd "$(dirname "$0")""/../../" || exit 1;
> +	sh_lib_dir=""$PWD"/testcases/lib/"

> +	sh_lib_test_dir=""$PWD"/lib/newlib_tests/shell/"
Wrong quote usage. In this interpretation $PWD isn't quoted.
It should be:
sh_lib_test_dir="$PWD/lib/newlib_tests/shell/"

You probably want to setup it as global variable (out of all functions)
- in this case global isn't that bad. Also I'd prefer simpler name.
Using dirname does not require to be in git root: 

TESTDIR="$(dirname $0)/shell/"

> +	tst_cases=$(ls "$sh_lib_test_dir" | \
> +			sed "s/"$TEST_NAME".sh/"$TEST_NAME"/g")
> +	cd "$sh_lib_dir" || exit 1
> +}
> +
> +check_requirements() {
> +	case "$0" in
> +		-*)
> +			printf "Please execute this script. Sourcing ";
> +			printf "(. <SCRIPT>) is not supported. \n";
> +			return 1;;
> +		*)
> +			true;
> +	esac
> +}
Is this really needed? I think it's obvious.

Now some syntax details.
Good example of shell script is the library itself (testcases/lib/tst_test.sh)

> +verify_output() {

New line before { }
verify_output()
{

> +	local output_found=1
> +	local wanted_output=
> +	local parsed_line=
> +	while read line;
> +	do
while read line; do
Keep 'do', 'then', 'else' on the same line

> +		if [ -z "$wanted_output" ] && [ "$line" = "# output:" ]
> +		then
if [ -z "$wanted_output" ] && [ "$line" = "# output:" ]; then

> +			output_found=0
> +		elif [ $output_found -eq 0 ] || [ -n "$wanted_output" ]
> +		then
elif [ $output_found -eq 0 ] || [ -n "$wanted_output" ], then

> +			if printf "$line" | grep "# " > /dev/null;
> +			then
> +				if [ $output_found -eq 0 ]
> +				then
> +					parsed_line=$(printf "$line" | \
> +							sed "s/^.\{2\}//")
> +					output_found=1
> +				else
> +					parsed_line="\n"$(printf "$line" | \
> +							sed "s/^.\{2\}//")
> +				fi
> +			elif printf "$line" | grep "#" > /dev/null;
> +			then
> +				parsed_line="\n"$(printf "$line" | \
> +						sed "s/^.\{1\}//")
> +			else true;
What is this for? You don't compare $?, which would be set by true.
And it's ugly.

> +			fi
> +			wanted_output=""$wanted_output""$parsed_line""
> +		else true;
> +		fi
> +
> +	done < ""$sh_lib_test_dir""$1".sh"

The easiest way is to store the output in separate file. Your way parsing the
output is interesting, but maybe too complicated for updating the pattern.
Even if you use this way, I'd prefer to get the output with sed/awk. Maybe there
are better ways, but this would work:

$ sed -ne '/^# output:/,$ p;' lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh | sed '1d'
# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
# test 3 TPASS: Test 1 passed with data 'dd'
# test 4 TPASS: Test 2 passed with data 'dd'

As I wrote, IMHO echo expected and actual output into the file and then run
'diff -u' on it would show, what's wrong.

> +	wanted_output=$(printf "$wanted_output")
You probably don't want this (adding to wanted_output variable what is already
there :) ).

> +	local actual_output=$(""$sh_lib_test_dir""$1".sh")
Again, wrong quotes usage.
> +	actual_output=$(printf "$actual_output")
Same here.

Maybe use less verbose variable name (detail).

> +	if [ "$wanted_output" = "$actual_output" ]
> +	then
> +		return 0
> +	else
> +		return 1
> +	fi
You can use
[ "$wanted_output" = "$actual_output" ] && return 0
return 1
> +}

> +run_tests() {
> +	for tst_case in $tst_cases
> +	do
> +		printf "Running Test: \""$tst_case"\"...\n"
> +		if verify_output "$tst_case";
> +		then
> +			printf ""$color_green"TPASS: "$standard_color""
Again, wrong quotes usage.

> +			printf "Test "$tst_case" was successful.\n\n"
> +		else
> +			printf ""$color_red"TFAIL:"$standard_color""
> +			printf "Test "$tst_case" was unsuccessful.\n\n"
> +		fi
Again use '; do/then/else'.

> +	done
> +}
> +
> +check_requirements
> +setup
> +run_tests

> +exit 0
That's wrong. I'd like exit code was 0 for everything pass or 1 for failure.


Kind regards,
Petr

[1] https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl
