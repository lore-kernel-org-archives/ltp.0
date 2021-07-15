From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 10:30:49 +0200
Subject: [LTP] [PATCH v6 2/5] lib: Add script for running tests
In-Reply-To: <20210715083052.7138-1-pvorel@suse.cz>
References: <20210715083052.7138-1-pvorel@suse.cz>
Message-ID: <20210715083052.7138-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For now run only tests which TPASS or TCONF.

tst_fuzzy_sync01: sporadically fails, thus disabled:

../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops, requesting exit
tst_fuzzy_sync01.c:227: TFAIL: acs:3  act:1  art:1  | =:23   -:46   +:2999931
...
Summary:
passed   21
failed   3

Use sync to workaround mangled output on GitHub Actions where stdout and
stderr are probably block buffered and flushed at different times.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v5->v6:
* fix final error evaluation for C tests in runtest.sh

 lib/newlib_tests/runtest.sh | 182 ++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100755 lib/newlib_tests/runtest.sh

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
new file mode 100755
index 000000000..bd7995f3b
--- /dev/null
+++ b/lib/newlib_tests/runtest.sh
@@ -0,0 +1,182 @@
+#!/bin/sh
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+
+LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
+tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync02
+tst_fuzzy_sync03}"
+
+LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
+
+cd $(dirname $0)
+PATH="$PWD/../../testcases/lib/:$PATH"
+
+. tst_ansi_color.sh
+
+usage()
+{
+	cat << EOF
+Usage: $0 [-b DIR ] [-c|-s]
+-b DIR  build directory (required for out-of-tree build)
+-c      run C API tests only
+-s      run shell API tests only
+-h      print this help
+EOF
+}
+
+tst_flag2mask()
+{
+	case "$1" in
+	TPASS) return 0;;
+	TFAIL) return 1;;
+	TBROK) return 2;;
+	TWARN) return 4;;
+	TINFO) return 16;;
+	TCONF) return 32;;
+	esac
+}
+
+runtest_res()
+{
+	if [ $# -eq 0 ]; then
+		echo >&2
+		return
+	fi
+
+	local res="$1"
+	shift
+
+	tst_color_enabled
+	local color=$?
+
+	printf "runtest " >&2
+	tst_print_colored $res "$res: " >&2
+	echo "$@" >&2
+
+}
+
+runtest_brk()
+{
+	local res="$1"
+	shift
+
+	tst_flag2mask "$res"
+	local mask=$?
+
+	runtest_res
+	runtest_res $res $@
+
+	exit $mask
+}
+
+run_tests()
+{
+	local target="$1"
+	local i res ret=0 tbrok tconf tfail tpass twarn vars
+
+	eval vars="\$LTP_${target}_API_TESTS"
+
+	runtest_res TINFO "=== Run $target tests ==="
+
+	for i in $vars; do
+		runtest_res TINFO "* $i"
+		./$i
+		res=$?
+
+		[ $res -ne 0 -a $res -ne 32 ] && ret=1
+
+		case $res in
+			0) tpass="$tpass $i";;
+			1) tfail="$tfail $i";;
+			2) tbrok="$tbrok $i";;
+			4) twarn="$twarn $i";;
+			32) tconf="$tconf $i";;
+			127) runtest_brk TBROK "Error: file not found (wrong PATH? out-of-tree build without -b?), exit code: $res";;
+			*) runtest_brk TBROK "Error: unknown failure, exit code: $res";;
+		esac
+		runtest_res
+		sync
+	done
+
+	runtest_res TINFO "=== $target TEST RESULTS ==="
+	runtest_res TINFO "$(echo $tpass | wc -w)x TPASS:$tpass"
+	runtest_res TINFO "$(echo $tfail | wc -w)x TFAIL:$tfail"
+	runtest_res TINFO "$(echo $tbrok | wc -w)x TBROK:$tbrok"
+	runtest_res TINFO "$(echo $twarn | wc -w)x TWARN:$twarn"
+	runtest_res TINFO "$(echo $tconf | wc -w)x TCONF:$tconf"
+	runtest_res
+
+	return $ret
+}
+
+run_c_tests()
+{
+	local ret
+
+	if [ "$builddir" ]; then
+		cd $builddir/lib/newlib_tests
+	fi
+
+	run_tests "C"
+	ret=$?
+
+	if [ "$builddir" ]; then
+		cd -
+	fi
+
+	return $ret
+}
+
+run_shell_tests()
+{
+	run_tests "SHELL"
+}
+
+
+print_result()
+{
+	local target="$1"
+	local res="$2"
+
+
+	if [ -z "$res" ]; then
+		runtest_res TCONF "$target tests skipped"
+	elif [ $res -eq 0 ]; then
+		runtest_res TPASS "All $target tests TCONF/TPASS"
+	else
+		runtest_res TFAIL "Some $target test(s) TBROK/TFAIL/TWARN"
+	fi
+}
+
+builddir=
+c_fail=
+run=
+shell_fail=
+
+while getopts b:chs opt; do
+	case $opt in
+		'h') usage; exit 0;;
+		'b') builddir=$OPTARG; PATH="$builddir/testcases/lib:$PATH";;
+		'c') run="c";;
+		's') run="s";;
+		*) usage; runtest_brk TBROK "Error: invalid option";;
+	esac
+done
+
+runtest_res TINFO "PATH='$PATH'"
+
+if [ -z "$run" -o "$run" = "c" ]; then
+	run_c_tests
+	c_fail=$?
+fi
+
+if [ -z "$run" -o "$run" = "s" ]; then
+	run_shell_tests
+	shell_fail=$?
+fi
+
+runtest_res TINFO "=== FINAL TEST RESULTS ==="
+
+print_result "C" "$c_fail"
+print_result "shell" "$shell_fail"
+
+exit $((c_fail|shell_fail))
-- 
2.32.0

