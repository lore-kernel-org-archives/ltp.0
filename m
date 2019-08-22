From: Christian Lanig <clanig@suse.com>
Date: Thu, 22 Aug 2019 21:12:45 +0200
Subject: [LTP] [RFC PATCH v2 1/1] Add automated tests for shell lib
In-Reply-To: <cover.1566500817.git.clanig@suse.com>
References: <cover.1566500817.git.clanig@suse.com>
Message-ID: <ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Christian Lanig <clanig@suse.com>
---
 doc/write-tests-for-shell-lib.txt                  |  59 ++++++++++
 lib/newlib_tests/shell/test_sh_newlib.sh           | 102 ++++++++++++++++++
 .../testcases/test.TST_TEST.TST_CNT.separate.sh    |  30 ++++++
 .../shell/testcases/test.TST_TEST.TST_CNT.sh       |  28 +++++
 .../shell/testcases/test.TST_TEST.getopts.sh       |  49 +++++++++
 lib/newlib_tests/shell/testcases/test.TST_TEST.sh  |  33 ++++++
 .../test.TST_TEST_DATA.TST_CNT.separate.sh         |  33 ++++++
 .../shell/testcases/test.TST_TEST_DATA.TST_CNT.sh  |  31 ++++++
 .../shell/testcases/test.TST_TEST_DATA.getopts.sh  |  51 +++++++++
 .../shell/testcases/test.TST_TEST_DATA.sh          |  25 +++++
 .../testcases/test.TST_TEST_DATA_IFS.getopts.sh    |  53 +++++++++
 .../shell/testcases/test.TST_TEST_DATA_IFS.sh      |  28 +++++
 tools/lookup_split_cut.py                          | 120 +++++++++++++++++++++
 13 files changed, 642 insertions(+)
 create mode 100644 doc/write-tests-for-shell-lib.txt
 create mode 100755 lib/newlib_tests/shell/test_sh_newlib.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.getopts.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.getopts.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.getopts.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.sh
 create mode 100755 tools/lookup_split_cut.py

diff --git a/doc/write-tests-for-shell-lib.txt b/doc/write-tests-for-shell-lib.txt
new file mode 100644
index 000000000..7e4e6f566
--- /dev/null
+++ b/doc/write-tests-for-shell-lib.txt
@@ -0,0 +1,59 @@
+How to format tests in order to test the shell library
+======================================================
+
+It is important to test the Linux kernel functionality but also to make sure
+that LTP is running correctly itself. For this reason it is useful to test
+intrinsic functionality of LTP.
+
+1. Running tests for the shell library
+--------------------------------------
+The test cases reside in the folder `lib/newlib_tests/shell`. A script executing
+them one by one is located in the folder `lib/newlib_tests`. You can execute
+this script to test all cases or specify test cases to be run. The script is
+called `test_sh_newlib.sh`.
+
+2. Writing tests for the shell library
+--------------------------------------
+The tests are written like all other test cases using the shell library.
+Additionally, at the end of the file the desired output is added. As an example:
+
+[source,shell]
+-------------------------------------------------------------------------------
+#!/bin/sh
+#
+# This is a basic test for true shell buildin
+#
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+do_test()
+{
+	true
+	ret=$?
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
+#
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
+-------------------------------------------------------------------------------
+
+The most noticeable thing is to add the line `# output:` to show the parser that
+parsing should start in the following line. For the following lines the `# `
+will be stripped before the output is then compared with the actual output that
+gets printed on the terminal when running the test.
diff --git a/lib/newlib_tests/shell/test_sh_newlib.sh b/lib/newlib_tests/shell/test_sh_newlib.sh
new file mode 100755
index 000000000..4aa19555b
--- /dev/null
+++ b/lib/newlib_tests/shell/test_sh_newlib.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# (c) 2019 SUSE LLC
+#
+# Author: Christian Lanig <clanig@suse.com>
+
+PATH="${PATH}:$(dirname $(readlink -f $0))/../../../testcases/lib/"
+if [ -z "$TMPDIR" ]; then
+	export TMPDIR="/tmp"
+fi
+color_blue='\033[1;34m'
+color_green='\033[1;32m'
+color_red='\033[1;31m'
+reset_attr='\033[0m'
+tmp="${TMPDIR}/sh_lib_tst-${$}/"
+mkdir $tmp || cleanup 1
+parent_dir=$(dirname $(readlink -f $0))/
+tooldir=${parent_dir}/../../../tools/
+testdir=${parent_dir}testcases/
+tst_files=$(ls $testdir)
+
+cleanup()
+{
+	[ -d "$tmp" ] && rm -rf "$tmp"
+	exit $1
+}
+
+print_help()
+{
+	cat <<EOF
+
+????????????????????????????????????????????????????????????????????????????????
+? This Shell script iterates over test cases for the new Shell library and     ?
+? verifies the output.                                                         ?
+????????????????????????????????????????????????????????????????????????????????
+
+	Usage:
+		$(basename $0) [TEST_FILE_1] [TEST_FILE_2]
+
+EOF
+	exit 0
+}
+
+parse_params()
+{
+	[ -n "$1" ] && tst_files=
+	while [ -n "$1" ]; do
+		case "$1" in
+			--help) print_help;;
+			-h) print_help;;
+			-*)
+				printf "Unknown positional parameter ${1}.\n"
+				cleanup 1;;
+			*) tst_files="$tst_files $1";;
+		esac
+		shift
+	done
+}
+
+verify_output()
+{
+	if [ ! -e "${testdir}$tst" ]; then
+		printf "$tst not found\n"
+		cleanup 1
+	fi
+
+	${tooldir}lookup_split_cut.py -f ${testdir}$tst -d $tmp \
+			-s '# output:\n' -c '# {0,1}' || cleanup 1
+
+	"${testdir}$tst" > "${tmp}$tst.actual" || cleanup 1
+	cmp -s "${tmp}$tst.actual" "${tmp}${tst}_out/out.1" && return 0
+	return 1
+}
+
+run_tests()
+{
+	pass_cnt=0
+	fail_cnt=0
+	printf "\n"
+	for tst in $tst_files; do
+		if verify_output; then
+			pass_cnt=$(($pass_cnt + 1))
+			printf "${color_green}TPASS$reset_attr ${tst}\n"
+		else
+			fail_cnt=$(($fail_cnt + 1))
+			printf "${color_red}TFAIL$reset_attr ${tst}\n"
+			printf "${color_blue}Diff:${reset_attr}\n"
+			diff -u "${tmp}${tst}.actual" \
+					"${tmp}${tst}_out/out.1"
+			printf "\n"
+		fi
+	done
+	printf "\nSummary:\n"
+	printf "${color_red}Failed:$reset_attr $fail_cnt\n"
+	printf "${color_green}Passed:$reset_attr $pass_cnt\n\n"
+	return $fail_cnt
+}
+
+parse_params "$@"
+run_tests
+cleanup $?
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.separate.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.separate.sh
new file mode 100755
index 000000000..333c4f5fa
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.separate.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Example test with tests in separate functions
+#
+
+TST_TESTFUNC=test
+TST_CNT=2
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
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with no data ('')
+# test 2 TPASS: Test 2 passed with no data ('')
+#
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.sh
new file mode 100755
index 000000000..73abfc8b3
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+#
+# Example test with tests in a single function
+#
+
+TST_TESTFUNC=do_test
+TST_CNT=2
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
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with no data ('')
+# test 2 TPASS: Test 2 passed with no data ('')
+#
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST.getopts.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST.getopts.sh
new file mode 100755
index 000000000..35a700bb2
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST.getopts.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Optional test command line parameters
+#
+
+TST_OPTS="af:"
+TST_USAGE=usage
+TST_PARSE_ARGS=parse_args
+TST_TESTFUNC=do_test
+
+. tst_test.sh
+
+ALTERNATIVE=0
+MODE="foo"
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
+	a) ALTERNATIVE=1;;
+	f) MODE="$2";;
+	esac
+}
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MODE'"
+}
+
+tst_run
+# output:
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data '': a: '0', f: 'foo'
+#
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST.sh
new file mode 100755
index 000000000..930900e1d
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# This is a basic test for true shell buildin
+#
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+do_test()
+{
+	true
+	ret=$?
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
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TINFO: Test 1 passed with no data ('')
+# test 1 TPASS: true returned 0
+#
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.separate.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.separate.sh
new file mode 100755
index 000000000..1faa01a57
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.separate.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Example test with tests in separate functions, using $TST_TEST_DATA and $TST_CNT
+#
+
+TST_TESTFUNC=test
+TST_CNT=2
+TST_TEST_DATA="foo:bar:d dd"
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
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+# test 3 TPASS: Test 1 passed with data 'dd'
+# test 4 TPASS: Test 2 passed with data 'dd'
+#
+# Summary:
+# passed   4
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.sh
new file mode 100755
index 000000000..889fc09c3
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA and $TST_CNT
+#
+
+TST_TESTFUNC=do_test
+TST_CNT=2
+TST_TEST_DATA="foo:bar:d dd"
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
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+# test 3 TPASS: Test 1 passed with data 'dd'
+# test 4 TPASS: Test 2 passed with data 'dd'
+#
+# Summary:
+# passed   4
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.getopts.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.getopts.sh
new file mode 100755
index 000000000..ba880f891
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.getopts.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# Optional test command line parameters
+#
+
+TST_OPTS="af:"
+TST_USAGE=usage
+TST_PARSE_ARGS=parse_args
+TST_TESTFUNC=do_test
+TST_TEST_DATA="foo0:bar:d dd"
+
+. tst_test.sh
+
+ALTERNATIVE=0
+MODE="foo"
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
+	a) ALTERNATIVE=1;;
+	f) MODE="$2";;
+	esac
+}
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MODE'"
+}
+
+tst_run
+# output:
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data 'foo0:bar:d': a: '0', f: 'foo'
+# test 2 TPASS: Test 1 passed with data 'dd': a: '0', f: 'foo'
+#
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.sh
new file mode 100755
index 000000000..083943833
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA
+#
+
+TST_TESTFUNC=do_test
+TST_TEST_DATA="foo:bar:d dd"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+tst_run
+# output:
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 1 passed with data 'dd'
+#
+# Summary:
+# passed   2
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.getopts.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.getopts.sh
new file mode 100755
index 000000000..eb83d2e34
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.getopts.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Optional test command line parameters
+#
+
+TST_OPTS="af:"
+TST_USAGE=usage
+TST_PARSE_ARGS=parse_args
+TST_TESTFUNC=do_test
+TST_TEST_DATA="foo0:bar:d dd"
+TST_TEST_DATA_IFS=":"
+
+. tst_test.sh
+
+ALTERNATIVE=0
+MODE="foo"
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
+	a) ALTERNATIVE=1;;
+	f) MODE="$2";;
+	esac
+}
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MODE'"
+}
+
+tst_run
+# output:
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data 'foo0': a: '0', f: 'foo'
+# test 2 TPASS: Test 1 passed with data 'bar': a: '0', f: 'foo'
+# test 3 TPASS: Test 1 passed with data 'd dd': a: '0', f: 'foo'
+#
+# Summary:
+# passed   3
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.sh b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.sh
new file mode 100755
index 000000000..6c6f904b7
--- /dev/null
+++ b/lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA and
+# $TST_TEST_DATA_IFS
+#
+
+TST_TESTFUNC=do_test
+TST_TEST_DATA="foo:bar:d dd"
+TST_TEST_DATA_IFS=":"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+tst_run
+# output:
+# test 1 TINFO: timeout per run is 0h 5m 0s
+# test 1 TPASS: Test 1 passed with data 'foo'
+# test 2 TPASS: Test 1 passed with data 'bar'
+# test 3 TPASS: Test 1 passed with data 'd dd'
+#
+# Summary:
+# passed   3
+# failed   0
+# skipped  0
+# warnings 0
diff --git a/tools/lookup_split_cut.py b/tools/lookup_split_cut.py
new file mode 100755
index 000000000..2b3388ada
--- /dev/null
+++ b/tools/lookup_split_cut.py
@@ -0,0 +1,120 @@
+#!/usr/bin/env python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# (c) 2019 SUSE LLC
+#
+# Author: Christian Lanig <clanig@suse.com>
+
+import sys
+import os
+import re
+from sys import argv
+from os import makedirs, path
+
+src_file_path = None
+dest = None
+delim = None
+pattern = None
+perim = None
+
+argv.reverse()
+basename = path.split(argv.pop())[1]
+
+def print_help():
+
+	help = """
+	This script can look up a passage in a specified text pattern, split a
+	text file and cut a pattern. The operation chain is:
+
+		lookup > split > cut
+
+	The output files are written to the specified destination directory.
+
+	Usage:
+	"""
+	help += "\n\t\t" + basename + " -f [PATH] -d [PATH] -l " \
+			+ "[PERIMETER] -s [DELIMITER] \n" \
+			+ "\t\t\t\t -c [PATTERN]\n\n"
+	help += """
+	-h, --help
+		print this help
+	-f, --file
+		source file to be processed
+	-d, --destination
+		destination path
+	-l, --lookup
+		look for data in text passage
+	-s, --split
+		split file by delimiter
+	-c, --cut
+		cut pattern from file
+	"""
+
+	print(help)
+	sys.exit(0)
+
+def get_next_arg():
+	if argv:
+		return argv.pop()
+	else:
+		print("Missing parameter. Run with \"--help\" for information.")
+		sys.exit(1)
+
+while argv:
+	arg = argv.pop()
+	if arg in ["-h", "--help"]:
+		print_help()
+	elif arg in ["-f", "--file"]:
+		src_file_path = get_next_arg()
+	elif arg in ["-d", "--destination"]:
+		dest = get_next_arg()
+	elif arg in ["-l", "--lookup"]:
+		perim = get_next_arg()
+	elif arg in ["-s", "--split"]:
+		delim = get_next_arg()
+	elif arg in ["-c", "--cut"]:
+		pattern = get_next_arg()
+	else:
+		print("Illegal argument. Run with \"--help\" for information.")
+		sys.exit(1)
+
+if not src_file_path:
+	print("Input file has to be specified.")
+	sys.exit(1)
+
+if not delim and not pattern and not perim:
+	print("Missing parameters. Run with \"--help\" for information.")
+	sys.exit(1)
+
+src_file = open(src_file_path, "r")
+src = src_file.read()
+src_file.close()
+
+capture = 0
+if perim:
+	try:
+		capture = re.search(perim, src).group(1)
+	except:
+		pass
+
+if delim:
+	src_file_name = path.split(src_file_path)[1]
+	out_dir = dest + "/" + src_file_name + "_out"
+
+	if not path.exists(out_dir):
+		makedirs(out_dir)
+
+	src = re.split(delim, src)
+else:
+	src = [src]
+
+if pattern:
+	for i in range(len(src)):
+		src[i] = re.sub(pattern, "", src[i])
+if delim or pattern:
+	for i in range(len(src)):
+		out_file = open(out_dir + "/out." + str(i), "w")
+		out_file.write(src[i])
+		out_file.close()
+
+sys.exit(capture)
-- 
2.16.4

