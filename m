From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 20 Sep 2019 16:21:58 +0200
Subject: [LTP] [RFC PATCH v2 1/1] Add automated tests for shell lib
In-Reply-To: <ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com>
References: <cover.1566500817.git.clanig@suse.com>
 <ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com>
Message-ID: <1568989318.3024.25.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

This tests are nice! Lets keep going with it.

On Thu, 2019-08-22 at 21:12 +0200, Christian Lanig wrote:
<snip>
> diff --git a/lib/newlib_tests/shell/test_sh_newlib.sh
> b/lib/newlib_tests/shell/test_sh_newlib.sh
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
> +tmp="${TMPDIR}/sh_lib_tst-${$}/"
> +mkdir $tmp || cleanup 1
> +parent_dir=$(dirname $(readlink -f $0))/
> +tooldir=${parent_dir}/../../../tools/
> +testdir=${parent_dir}testcases/
> +tst_files=$(ls $testdir)
> +
> +cleanup()

You use cleanup as a default handler for error handing.
For instance, if a test doesn't have a `# output:` section we silently
quit with exitcode 1. I would like to be informed more about such
errors. Maybe we could just printout $tst if `$! != 0`.

> +{
> +	[ -d "$tmp" ] && rm -rf "$tmp"
> +	exit $1
> +}
> +
> +print_help()
> +{
> +	cat <<EOF
> +
> +????????????????????????????????????????????????????????????????????
> ????????????
> +? This Shell script iterates over test cases for the new Shell
> library and     ?
> +? verifies the
> output.                                                         ?
> +????????????????????????????????????????????????????????????????????
> ????????????
> +
> +	Usage:
> +		$(basename $0) [TEST_FILE_1] [TEST_FILE_2]
> +
> +EOF
> +	exit 0
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
> +				printf "Unknown positional parameter
> ${1}.\n"
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
> +		printf "$tst not found\n"
> +		cleanup 1
> +	fi
> +
> +	${tooldir}lookup_split_cut.py -f ${testdir}$tst -d $tmp \
> +			-s '# output:\n' -c '# {0,1}' || cleanup 1

just an idea, in perl ( I'm not sure if we have perl already as
dependency). My feeling is, that lookup_split_cut.py is to much for
that task.

cat $testdir$tst | perl -e '$o = 0; while (<STDIN>) {print substr($_,
2) if $o;  $o = 1 if /^# output:/; }' > $tmp${tst}expected_output

> +
> +	"${testdir}$tst" > "${tmp}$tst.actual" || cleanup 1

We should keep going on failed test. We need this to test timeout
functionally or error handling...

> +	cmp -s "${tmp}$tst.actual" "${tmp}${tst}_out/out.1" &&
> return 0
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
> +			pass_cnt=$(($pass_cnt + 1))
> +			printf "${color_green}TPASS$reset_attr
> ${tst}\n"
> +		else
> +			fail_cnt=$(($fail_cnt + 1))
> +			printf "${color_red}TFAIL$reset_attr
> ${tst}\n"
> +			printf "${color_blue}Diff:${reset_attr}\n"
> +			diff -u "${tmp}${tst}.actual" \
> +					"${tmp}${tst}_out/out.1"
> +			printf "\n"
> +		fi
> +	done
> +	printf "\nSummary:\n"
> +	printf "${color_red}Failed:$reset_attr $fail_cnt\n"
> +	printf "${color_green}Passed:$reset_attr $pass_cnt\n\n"
> +	return $fail_cnt
> +}
> +
> +parse_params "$@"
> +run_tests
> +cleanup $?
> 
<snip>

Thanks
Clemens
