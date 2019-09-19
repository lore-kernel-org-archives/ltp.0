From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Sep 2019 18:41:51 +0200
Subject: [LTP] [RFC PATCH v2 1/1] Add automated tests for shell lib
In-Reply-To: <ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com>
References: <20181003113215.GB21139@dell5510>
 <cover.1566500817.git.clanig@suse.com>
 <ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com>
Message-ID: <20190919164151.GB20853@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

thank you for working on it.

TL;DR: looks good to me, I have some code style objections,
(use echo instead of printf, use $foo instead of ${foo} when possible)
+ some minor suggestions below.

> +++ b/doc/write-tests-for-shell-lib.txt
> @@ -0,0 +1,59 @@
> +How to format tests in order to test the shell library
> +======================================================
> +
> +It is important to test the Linux kernel functionality but also to make sure
> +that LTP is running correctly itself. For this reason it is useful to test
> +intrinsic functionality of LTP.
> +
> +1. Running tests for the shell library
> +--------------------------------------
> +The test cases reside in the folder `lib/newlib_tests/shell`. A script executing
> +them one by one is located in the folder `lib/newlib_tests`. You can execute
> +this script to test all cases or specify test cases to be run. The script is
> +called `test_sh_newlib.sh`.
> +
> +2. Writing tests for the shell library
> +--------------------------------------
> +The tests are written like all other test cases using the shell library.
> +Additionally, at the end of the file the desired output is added. As an example:
Nice. I wonder if it should be in doc/test-writing-guidelines.txt. But this
section is already too big, so it's probably good that it's separate.
Then we need to add page this to wiki (simple).

BTW I plan to introduce make check, which will run this and other checks as well.

> +
> +[source,shell]
> +-------------------------------------------------------------------------------
> +#!/bin/sh
> +#
> +# This is a basic test for true shell buildin
typo: builtin
> +#
nit: I'd remove this empty lines just with '#'
> +
> +TST_TESTFUNC=do_test
> +. tst_test.sh
> +
> +do_test()
> +{
> +	true
> +	ret=$?
> +
> +	tst_res TINFO "Test $1 passed with no data ('$2')"
> +
> +	if [ $ret -eq 0 ]; then
> +		tst_res TPASS "true returned 0"
> +	else
> +		tst_res TFAIL "true returned $ret"
> +	fi
> +}
> +
> +tst_run
> +# output:
> +# test 1 TINFO: Test 1 passed with no data ('')
> +# test 1 TPASS: true returned 0
> +#
> +# Summary:
> +# passed   1
> +# failed   0
> +# skipped  0
> +# warnings 0
> +-------------------------------------------------------------------------------
> +
> +The most noticeable thing is to add the line `# output:` to show the parser that
> +parsing should start in the following line. For the following lines the `# `
> +will be stripped before the output is then compared with the actual output that
> +gets printed on the terminal when running the test.
> diff --git a/lib/newlib_tests/shell/test_sh_newlib.sh b/lib/newlib_tests/shell/test_sh_newlib.sh
> new file mode 100755
> index 000000000..4aa19555b
> --- /dev/null
> +++ b/lib/newlib_tests/shell/test_sh_newlib.sh
> @@ -0,0 +1,102 @@
> +#!/bin/sh
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# (c) 2019 SUSE LLC
> +#
> +# Author: Christian Lanig <clanig@suse.com>
> +
> +PATH="${PATH}:$(dirname $(readlink -f $0))/../../../testcases/lib/"
> +if [ -z "$TMPDIR" ]; then
> +	export TMPDIR="/tmp"
> +fi
> +color_blue='\033[1;34m'
> +color_green='\033[1;32m'
> +color_red='\033[1;31m'
> +reset_attr='\033[0m'
I'd prefer not reimplementing tst_ansi_color.sh.
IMHO it'd be better either use part of it (or tst_ansi_color.sh)
or not use colors at all.

> +tmp="${TMPDIR}/sh_lib_tst-${$}/"
nit: it can be $$ (instead of ${$})
> +mkdir $tmp || cleanup 1
> +parent_dir=$(dirname $(readlink -f $0))/
> +tooldir=${parent_dir}/../../../tools/
> +testdir=${parent_dir}testcases/
> +tst_files=$(ls $testdir)
> +
> +cleanup()
> +{
> +	[ -d "$tmp" ] && rm -rf "$tmp"
nit: 1 could be a default parameter.
> +	exit $1
> +}
> +
> +print_help()
> +{
> +	cat <<EOF
> +
> +????????????????????????????????????????????????????????????????????????????????
> +? This Shell script iterates over test cases for the new Shell library and     ?
> +? verifies the output.                                                         ?
> +????????????????????????????????????????????????????????????????????????????????
nit: I'd prefer to use ASCII (-) than unicode (?).

> +
> +	Usage:
> +		$(basename $0) [TEST_FILE_1] [TEST_FILE_2]
> +
nit: another space not needed.
> +EOF
> +	exit 0
> +}
> +
> +parse_params()
> +{
> +	[ -n "$1" ] && tst_files=
> +	while [ -n "$1" ]; do
We usually prefer to use getopts, which does not allow long opts.
It's ok for this small usage, but for more complicated output it's better not
reimplementing it.
> +		case "$1" in
> +			--help) print_help;;
> +			-h) print_help;;
> +			-*)
> +				printf "Unknown positional parameter ${1}.\n"
maybe use simple this simpler form:
				echo "Unknown positional parameter $1"

> +				cleanup 1;;
> +			*) tst_files="$tst_files $1";;
> +		esac
> +		shift
> +	done
> +}
> +
> +verify_output()
> +{
> +	if [ ! -e "${testdir}$tst" ]; then
This can safely be "$testdir$tst"
> +		printf "$tst not found\n"
Again, use echo
> +		cleanup 1
> +	fi
> +
> +	${tooldir}lookup_split_cut.py -f ${testdir}$tst -d $tmp \
> +			-s '# output:\n' -c '# {0,1}' || cleanup 1
> +
> +	"${testdir}$tst" > "${tmp}$tst.actual" || cleanup 1
Again, ${} is not necessary.
> +	cmp -s "${tmp}$tst.actual" "${tmp}${tst}_out/out.1" && return 0
+ check for cmp.
> +	return 1
> +}
> +
> +run_tests()
> +{
> +	pass_cnt=0
> +	fail_cnt=0
> +	printf "\n"
again, echo is better here.
> +	for tst in $tst_files; do
> +		if verify_output; then
> +			pass_cnt=$(($pass_cnt + 1))
> +			printf "${color_green}TPASS$reset_attr ${tst}\n"
> +		else
> +			fail_cnt=$(($fail_cnt + 1))
> +			printf "${color_red}TFAIL$reset_attr ${tst}\n"
> +			printf "${color_blue}Diff:${reset_attr}\n"
> +			diff -u "${tmp}${tst}.actual" \
We might want to check for diff being available before we use.
> +					"${tmp}${tst}_out/out.1"
> +			printf "\n"
> +		fi
> +	done
> +	printf "\nSummary:\n"
> +	printf "${color_red}Failed:$reset_attr $fail_cnt\n"
> +	printf "${color_green}Passed:$reset_attr $pass_cnt\n\n"
> +	return $fail_cnt
> +}
... (more tests)

> diff --git a/tools/lookup_split_cut.py b/tools/lookup_split_cut.py
> new file mode 100755
> index 000000000..2b3388ada
> --- /dev/null
> +++ b/tools/lookup_split_cut.py
> @@ -0,0 +1,120 @@
> +#!/usr/bin/env python
I guess this should be python3.
I'd be a bit careful to bring python as another dependency,
(there was some awk solution for this, proposed by Cyril),
but as python is everywhere, it shouldn't be a problem.
(We definitely don't want python on SUT, these tests will be eventually
rewritten into C or shell.)

> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# (c) 2019 SUSE LLC
> +#
> +# Author: Christian Lanig <clanig@suse.com>
> +
> +import sys
> +import os
> +import re
> +from sys import argv
> +from os import makedirs, path
> +
> +src_file_path = None
> +dest = None
> +delim = None
> +pattern = None
> +perim = None
> +
> +argv.reverse()
> +basename = path.split(argv.pop())[1]
> +
> +def print_help():
> +
> +	help = """
> +	This script can look up a passage in a specified text pattern, split a
> +	text file and cut a pattern. The operation chain is:
> +
> +		lookup > split > cut
> +
> +	The output files are written to the specified destination directory.
> +
> +	Usage:
> +	"""
> +	help += "\n\t\t" + basename + " -f [PATH] -d [PATH] -l " \
> +			+ "[PERIMETER] -s [DELIMITER] \n" \
> +			+ "\t\t\t\t -c [PATTERN]\n\n"
nit: you can use format() to use variables in multiline strings.

> +	help += """
> +	-h, --help
> +		print this help
> +	-f, --file
> +		source file to be processed
> +	-d, --destination
> +		destination path
> +	-l, --lookup
> +		look for data in text passage
> +	-s, --split
> +		split file by delimiter
> +	-c, --cut
> +		cut pattern from file
> +	"""
> +
> +	print(help)
> +	sys.exit(0)
> +
> +def get_next_arg():
> +	if argv:
> +		return argv.pop()
> +	else:
> +		print("Missing parameter. Run with \"--help\" for information.")
> +		sys.exit(1)
> +
> +while argv:
> +	arg = argv.pop()
> +	if arg in ["-h", "--help"]:
> +		print_help()
> +	elif arg in ["-f", "--file"]:
> +		src_file_path = get_next_arg()
> +	elif arg in ["-d", "--destination"]:
> +		dest = get_next_arg()
> +	elif arg in ["-l", "--lookup"]:
> +		perim = get_next_arg()
> +	elif arg in ["-s", "--split"]:
> +		delim = get_next_arg()
> +	elif arg in ["-c", "--cut"]:
> +		pattern = get_next_arg()
> +	else:
> +		print("Illegal argument. Run with \"--help\" for information.")
I'd print help here.
> +		sys.exit(1)
> +
> +if not src_file_path:
> +	print("Input file has to be specified.")
> +	sys.exit(1)
> +
> +if not delim and not pattern and not perim:
> +	print("Missing parameters. Run with \"--help\" for information.")
> +	sys.exit(1)
> +
> +src_file = open(src_file_path, "r")
> +src = src_file.read()
> +src_file.close()
> +
> +capture = 0
> +if perim:
> +	try:
> +		capture = re.search(perim, src).group(1)
> +	except:
> +		pass
> +
> +if delim:
> +	src_file_name = path.split(src_file_path)[1]
> +	out_dir = dest + "/" + src_file_name + "_out"
> +
> +	if not path.exists(out_dir):
> +		makedirs(out_dir)
> +
> +	src = re.split(delim, src)
> +else:
> +	src = [src]
> +
> +if pattern:
> +	for i in range(len(src)):
> +		src[i] = re.sub(pattern, "", src[i])
> +if delim or pattern:
> +	for i in range(len(src)):
> +		out_file = open(out_dir + "/out." + str(i), "w")
> +		out_file.write(src[i])
> +		out_file.close()
> +
> +sys.exit(capture)

Kind regards,
Petr
