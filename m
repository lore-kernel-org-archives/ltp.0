From: Christian Lanig <clanig@suse.com>
Date: Fri, 31 Aug 2018 17:24:09 +0200
Subject: [LTP] [RFC PATCH 1/1] Add automated tests for shell lib
In-Reply-To: <cover.1535725022.git.clanig@suse.com>
References: <cover.1535725022.git.clanig@suse.com>
Message-ID: <c859d712cb33f6bb151313d6664d786920e49500.1535725022.git.clanig@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Signed-off-by: Christian Lanig <clanig@suse.com>
---
 doc/write-tests-for-shell-lib.txt                  |  61 ++++++++++++
 .../shell/test.TST_TEST.TST_CNT.separate.sh        |  29 ++++++
 lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh    |  27 ++++++
 lib/newlib_tests/shell/test.TST_TEST.getopts.sh    |  48 ++++++++++
 lib/newlib_tests/shell/test.TST_TEST.sh            |  32 +++++++
 .../shell/test.TST_TEST_DATA.TST_CNT.separate.sh   |  32 +++++++
 .../shell/test.TST_TEST_DATA.TST_CNT.sh            |  30 ++++++
 .../shell/test.TST_TEST_DATA.getopts.sh            |  50 ++++++++++
 lib/newlib_tests/shell/test.TST_TEST_DATA.sh       |  24 +++++
 .../shell/test.TST_TEST_DATA_IFS.getopts.sh        |  52 ++++++++++
 lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh   |  27 ++++++
 lib/newlib_tests/test_sh_newlib.sh                 | 105 +++++++++++++++++=
++++
 12 files changed, 517 insertions(+)
 create mode 100644 doc/write-tests-for-shell-lib.txt
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.getopts.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separ=
ate.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh
 create mode 100755 lib/newlib_tests/test_sh_newlib.sh

diff --git a/doc/write-tests-for-shell-lib.txt b/doc/write-tests-for-shell-=
lib.txt
new file mode 100644
index 000000000..6f3ff4854
--- /dev/null
+++ b/doc/write-tests-for-shell-lib.txt
@@ -0,0 +1,61 @@
+How to format tests in order to test the shell library
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+It is of big importance not only to test the Linux kernel functionality bu=
t also
+to make sure LTP is running correctly itself. For this reason it is useful=
 to
+test intrinsic functionality of LTP - to reasonable extend.
+
+1. Running tests for the shell library
+--------------------------------------
+The test cases reside in the folder `lib/newlib_tests/shell`. A script exe=
cuting
+them one by one is in the folder `lib/newlib_tests`. You can execute this =
script
+to test all cases or specify test cases to be run. The script is called
+`test_sh_newlib.sh`.
+
+2. Writing tests for the shell library
+--------------------------------------
+The tests are written like all other test cases using the shell library.
+Additionally, at the end of the file the desired output is added. As an ex=
ample:
+
+[source,shell]
+--------------------------------------------------------------------------=
-----
+#!/bin/sh
+#
+# This is a basic test for true shell buildin
+#
+
+TST_TESTFUNC=3Ddo_test
+. tst_test.sh
+
+do_test()
+{
+	true
+	ret=3D$?
+
+	tst_res TINFO "Test $1 passed with no data ('$2')"
+
+	if [ $ret -eq 0 ]; then
+		tst_res TPASS "true returned 0"
+	else
+		tst_res TFAIL "true returned $ret"
+	fi
+}
+
+tst_run
+# output:
+# test 1 TINFO: Test 1 passed with no data ('')
+# test 1 TPASS: true returned 0
+#=20
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
+--------------------------------------------------------------------------=
-----
+
+The most noticeable thing is to add the line `# output:` to show the parse=
r that
+parsing should start in the following line. For the following lines the `#=
 `
+will be stripped before the output is then compared with the actual output=
 that
+gets printed on the terminal when running the test. Also make sure that th=
ere
+are no trailing lines at the end of the document. But make sure to add one
+trailing space after the `#` when the line will be actually empty.
diff --git a/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh b/lib=
/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
new file mode 100755
index 000000000..5e8d4bfb5
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Example test with tests in separate functions
+#
+
+TST_TESTFUNC=3Dtest
+TST_CNT=3D2
+. tst_test.sh
+
+test1()
+{
+	tst_res TPASS "Test $1 passed with no data ('$2')"
+}
+
+test2()
+{
+	tst_res TPASS "Test $1 passed with no data ('$2')"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with no data ('')
+# test 2 TPASS: Test 2 passed with no data ('')
+#=20
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh b/lib/newlib_t=
ests/shell/test.TST_TEST.TST_CNT.sh
new file mode 100755
index 000000000..62fa652cf
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Example test with tests in a single function
+#
+
+TST_TESTFUNC=3Ddo_test
+TST_CNT=3D2
+. tst_test.sh
+
+do_test()
+{
+	case $1 in
+	1) tst_res TPASS "Test $1 passed with no data ('$2')";;
+	2) tst_res TPASS "Test $1 passed with no data ('$2')";;
+	esac
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with no data ('')
+# test 2 TPASS: Test 2 passed with no data ('')
+#=20
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST.getopts.sh b/lib/newlib_t=
ests/shell/test.TST_TEST.getopts.sh
new file mode 100755
index 000000000..65810b5e8
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST.getopts.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Optional test command line parameters
+#
+
+TST_OPTS=3D"af:"
+TST_USAGE=3Dusage
+TST_PARSE_ARGS=3Dparse_args
+TST_TESTFUNC=3Ddo_test
+
+. tst_test.sh
+
+ALTERNATIVE=3D0
+MODE=3D"foo"
+
+usage()
+{
+	cat << EOF
+usage: $0 [-a] [-f <foo|bar>]
+
+OPTIONS
+-a     Enable support for alternative foo
+-f     Specify foo or bar mode
+EOF
+}
+
+parse_args()
+{
+	case $1 in
+	a) ALTERNATIVE=3D1;;
+	f) MODE=3D"$2";;
+	esac
+}
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MOD=
E'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data '': a: '0', f: 'foo'
+#=20
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST.sh b/lib/newlib_tests/she=
ll/test.TST_TEST.sh
new file mode 100755
index 000000000..fa6aaa57f
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# This is a basic test for true shell buildin
+#
+
+TST_TESTFUNC=3Ddo_test
+. tst_test.sh
+
+do_test()
+{
+	true
+	ret=3D$?
+
+	tst_res TINFO "Test $1 passed with no data ('$2')"
+
+	if [ $ret -eq 0 ]; then
+		tst_res TPASS "true returned 0"
+	else
+		tst_res TFAIL "true returned $ret"
+	fi
+}
+
+tst_run
+# output:
+# test 1 TINFO: Test 1 passed with no data ('')
+# test 1 TPASS: true returned 0
+#=20
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh =
b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh
new file mode 100755
index 000000000..0ae773519
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Example test with tests in separate functions, using $TST_TEST_DATA and =
$TST_CNT
+#
+
+TST_TESTFUNC=3Dtest
+TST_CNT=3D2
+TST_TEST_DATA=3D"foo:bar:d dd"
+. tst_test.sh
+
+test1()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+test2()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+# test 3 TPASS: Test 1 passed with data 'dd'
+# test 4 TPASS: Test 2 passed with data 'dd'
+#=20
+# Summary:
+# passed   4
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh b/lib/new=
lib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
new file mode 100755
index 000000000..71e6acac7
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA and $=
TST_CNT
+#
+
+TST_TESTFUNC=3Ddo_test
+TST_CNT=3D2
+TST_TEST_DATA=3D"foo:bar:d dd"
+. tst_test.sh
+
+do_test()
+{
+	case $1 in
+	1) tst_res TPASS "Test $1 passed with data '$2'";;
+	2) tst_res TPASS "Test $1 passed with data '$2'";;
+	esac
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+# test 3 TPASS: Test 1 passed with data 'dd'
+# test 4 TPASS: Test 2 passed with data 'dd'
+#=20
+# Summary:
+# passed   4
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh b/lib/new=
lib_tests/shell/test.TST_TEST_DATA.getopts.sh
new file mode 100755
index 000000000..e1f18ba3a
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Optional test command line parameters
+#
+
+TST_OPTS=3D"af:"
+TST_USAGE=3Dusage
+TST_PARSE_ARGS=3Dparse_args
+TST_TESTFUNC=3Ddo_test
+TST_TEST_DATA=3D"foo0:bar:d dd"
+
+. tst_test.sh
+
+ALTERNATIVE=3D0
+MODE=3D"foo"
+
+usage()
+{
+	cat << EOF
+usage: $0 [-a] [-f <foo|bar>]
+
+OPTIONS
+-a     Enable support for alternative foo
+-f     Specify foo or bar mode
+EOF
+}
+
+parse_args()
+{
+	case $1 in
+	a) ALTERNATIVE=3D1;;
+	f) MODE=3D"$2";;
+	esac
+}
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MOD=
E'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo0:bar:d': a: '0', f: 'foo'
+# test 2 TPASS: Test 1 passed with data 'dd': a: '0', f: 'foo'
+#=20
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST_DATA.sh b/lib/newlib_test=
s/shell/test.TST_TEST_DATA.sh
new file mode 100755
index 000000000..d3ced1954
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA
+#
+
+TST_TESTFUNC=3Ddo_test
+TST_TEST_DATA=3D"foo:bar:d dd"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 1 passed with data 'dd'
+#=20
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh b/lib=
/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
new file mode 100755
index 000000000..6075904a5
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# Optional test command line parameters
+#
+
+TST_OPTS=3D"af:"
+TST_USAGE=3Dusage
+TST_PARSE_ARGS=3Dparse_args
+TST_TESTFUNC=3Ddo_test
+TST_TEST_DATA=3D"foo0:bar:d dd"
+TST_TEST_DATA_IFS=3D":"
+
+. tst_test.sh
+
+ALTERNATIVE=3D0
+MODE=3D"foo"
+
+usage()
+{
+	cat << EOF
+usage: $0 [-a] [-f <foo|bar>]
+
+OPTIONS
+-a     Enable support for alternative foo
+-f     Specify foo or bar mode
+EOF
+}
+
+parse_args()
+{
+	case $1 in
+	a) ALTERNATIVE=3D1;;
+	f) MODE=3D"$2";;
+	esac
+}
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MOD=
E'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo0': a: '0', f: 'foo'
+# test 2 TPASS: Test 1 passed with data 'bar': a: '0', f: 'foo'
+# test 3 TPASS: Test 1 passed with data 'd dd': a: '0', f: 'foo'
+#=20
+# Summary:
+# passed   3
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh b/lib/newlib_=
tests/shell/test.TST_TEST_DATA_IFS.sh
new file mode 100755
index 000000000..9a1bb9cf7
--- /dev/null
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA and
+# $TST_TEST_DATA_IFS
+#
+
+TST_TESTFUNC=3Ddo_test
+TST_TEST_DATA=3D"foo:bar:d dd"
+TST_TEST_DATA_IFS=3D":"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo'
+# test 2 TPASS: Test 1 passed with data 'bar'
+# test 3 TPASS: Test 1 passed with data 'd dd'
+#=20
+# Summary:
+# passed   3
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/test_sh_newlib.sh b/lib/newlib_tests/test_sh_=
newlib.sh
new file mode 100755
index 000000000..bf335dd6e
--- /dev/null
+++ b/lib/newlib_tests/test_sh_newlib.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# =C2=A9 2018 SUSE LLC.
+#=20
+# Author: Christian Lanig <clanig@suse.com>
+
+setup()
+{
+	path_sav=3D$PATH
+	PATH=3D""$PATH":$(dirname $0)/../../testcases/lib/"
+	color_blue=3D'\033[1;34m'
+	color_green=3D'\033[1;32m'
+	color_red=3D'\033[1;31m'
+	standard_color=3D'\033[0m'
+	tmp_dir=3D"/tmp/sh_lib_tst-$$/"
+	mkdir $tmp_dir || cleanup 1
+	sh_lib_tst_dir=3D"$(dirname $0)/shell/"
+	tst_files=3D"$(ls $sh_lib_tst_dir)"
+	return 0
+}
+
+cleanup()
+{
+	[ -d "$tmp_dir" ] && rm -rf "$tmp_dir"
+	PATH=3D"$PATH_sav"
+	exit $1
+}
+
+print_help()
+{
+	printf "#############################################################\n"
+	printf "# This script iterates over test cases for the new shell    #\n"
+	printf "# library and verifies the output.                          #\n"
+	printf "#############################################################\n"
+	printf "\n"
+	printf "Usage:\n"
+	printf "\t$(basename $0)\n"
+	printf "\t$(basename $0) [test file 1] [test file 2] ...\n\n"
+	exit 0;
+}
+
+parse_params()
+{
+	[ -n "$1" ] && tst_files=3D
+	while [ -n "$1" ]; do
+		case "$1" in
+			--help) print_help;;
+			-h) print_help;;
+			-*)
+				printf "Unknown positional parameter "$1".\n"
+				cleanup 1;;
+			*) tst_files=3D"$tst_files $1";;
+		esac
+		shift
+	done
+	return 0
+}
+
+verify_output()
+{
+	[ -e "$sh_lib_tst_dir$tst" ] || { printf "$tst not found\n" && \
+			cleanup 1 ;}
+	# read all lines after line: `# output:`, and strip `# ` from beginning
+	sed -n -e '/^# output:/,$ p;' "$sh_lib_tst_dir$tst" | sed '1d; s/^# //'\
+			> "$tmp_dir$tst.wanted" || cleanup 1
+
+	actual_output=3D$($sh_lib_tst_dir$tst)
+	# remove control signs, add newline at EOF and store in temporary file
+	actual_output=3D$(printf "$actual_output\n" > $tmp_dir$tst".actual") ||
+			cleanup 1
+
+	cmp $tmp_dir$tst".actual" $tmp_dir$tst".wanted" > /dev/null && return 0
+	return 1
+}
+
+run_tests()
+{
+	pass_cnt=3D0
+	fail_cnt=3D0
+	printf "\n"
+	for tst in $tst_files; do
+		if verify_output; then
+			pass_cnt=3D$(expr $pass_cnt + 1)
+			printf ""$color_green"TPASS$standard_color $tst"
+			printf "\n"
+		else
+			fail_cnt=3D$(expr $fail_cnt + 1)
+			printf ""$color_red"TFAIL$standard_color $tst\n"
+			printf ""$color_blue"Diff:$standard_color\n"
+			diff -u "$tmp_dir$tst.actual" "$tmp_dir$tst.wanted"
+			printf "\n"
+		fi
+	done
+	printf "\nSummary:\n"
+	printf ""$color_red"Failed:$standard_color $fail_cnt\n"
+	printf ""$color_green"Passed:$standard_color $pass_cnt\n\n"
+	return $fail_cnt
+}
+
+setup
+parse_params "$@"
+run_tests
+res=3D$?
+cleanup $res
--=20
2.16.4

