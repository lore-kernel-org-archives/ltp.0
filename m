From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 May 2018 21:34:30 +0200
Subject: [LTP] [RFC PATCH v3 2/2] lib: Add tests
In-Reply-To: <20180522193430.20117-1-pvorel@suse.cz>
References: <20180522193430.20117-1-pvorel@suse.cz>
Message-ID: <20180522193430.20117-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not-signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This is not intended to be merged. It's just a helper which you can use
for testing the previous patch.

(Side note: if we ever want to test tst_test.sh, it'd be possible to
dump it into file and compare with saved output. It'd require to remove
lines with 'stime=')
---
 lib/newlib_tests/Makefile                          |  1 +
 lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh | 22 ++++++++++++
 lib/newlib_tests/test.TST_TEST.TST_CNT.sh          | 20 +++++++++++
 lib/newlib_tests/test.TST_TEST.getopts.sh          | 40 +++++++++++++++++++++
 lib/newlib_tests/test.TST_TEST.sh                  | 25 +++++++++++++
 .../test.TST_TEST_DATA.TST_CNT.separate.sh         | 26 ++++++++++++++
 lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh     | 24 +++++++++++++
 lib/newlib_tests/test.TST_TEST_DATA.getopts.sh     | 41 +++++++++++++++++++++
 lib/newlib_tests/test.TST_TEST_DATA.sh             | 18 ++++++++++
 lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh | 42 ++++++++++++++++++++++
 lib/newlib_tests/test.TST_TEST_DATA_IFS.sh         | 21 +++++++++++
 runtest/test                                       | 13 +++++++
 12 files changed, 293 insertions(+)
 create mode 100755 lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST.TST_CNT.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST.getopts.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST_DATA.getopts.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST_DATA.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh
 create mode 100755 lib/newlib_tests/test.TST_TEST_DATA_IFS.sh
 create mode 100644 runtest/test

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index afa09373e..cc20920be 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -15,5 +15,6 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
 endif
 
+INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh b/lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh
new file mode 100755
index 000000000..e26e2cb14
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh
@@ -0,0 +1,22 @@
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
+# test 1 TPASS: Test 1 passed with no data ('')
+# test 2 TPASS: Test 2 passed with no data ('')
diff --git a/lib/newlib_tests/test.TST_TEST.TST_CNT.sh b/lib/newlib_tests/test.TST_TEST.TST_CNT.sh
new file mode 100755
index 000000000..d84457fea
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST.TST_CNT.sh
@@ -0,0 +1,20 @@
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
+# test 1 TPASS: Test 1 passed with no data ('')
+# test 2 TPASS: Test 2 passed with no data ('')
diff --git a/lib/newlib_tests/test.TST_TEST.getopts.sh b/lib/newlib_tests/test.TST_TEST.getopts.sh
new file mode 100755
index 000000000..0ba848a0a
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST.getopts.sh
@@ -0,0 +1,40 @@
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
diff --git a/lib/newlib_tests/test.TST_TEST.sh b/lib/newlib_tests/test.TST_TEST.sh
new file mode 100755
index 000000000..6ecae710d
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST.sh
@@ -0,0 +1,25 @@
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
+# test 1 TINFO: Test 1 passed with no data ('')
+# test 1 TPASS: true returned 0
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh b/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh
new file mode 100755
index 000000000..9a81ad27c
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh
@@ -0,0 +1,26 @@
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
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+# test 3 TPASS: Test 1 passed with data 'dd'
+# test 4 TPASS: Test 2 passed with data 'dd'
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh b/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh
new file mode 100755
index 000000000..798ad9621
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh
@@ -0,0 +1,24 @@
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
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+# test 3 TPASS: Test 1 passed with data 'dd'
+# test 4 TPASS: Test 2 passed with data 'dd'
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.getopts.sh b/lib/newlib_tests/test.TST_TEST_DATA.getopts.sh
new file mode 100755
index 000000000..1cd150618
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST_DATA.getopts.sh
@@ -0,0 +1,41 @@
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
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.sh b/lib/newlib_tests/test.TST_TEST_DATA.sh
new file mode 100755
index 000000000..4cb51c669
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST_DATA.sh
@@ -0,0 +1,18 @@
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
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
diff --git a/lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh b/lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh
new file mode 100755
index 000000000..59dbd9598
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh
@@ -0,0 +1,42 @@
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
diff --git a/lib/newlib_tests/test.TST_TEST_DATA_IFS.sh b/lib/newlib_tests/test.TST_TEST_DATA_IFS.sh
new file mode 100755
index 000000000..52a2e6d47
--- /dev/null
+++ b/lib/newlib_tests/test.TST_TEST_DATA_IFS.sh
@@ -0,0 +1,21 @@
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
+# test 1 TPASS: Test 1 passed with data 'foo'
+# test 2 TPASS: Test 2 passed with data 'bar'
+# test 3 TPASS: Test 3 passed with data 'd dd'
diff --git a/runtest/test b/runtest/test
new file mode 100644
index 000000000..469e3b787
--- /dev/null
+++ b/runtest/test
@@ -0,0 +1,13 @@
+TST_TEST_DATA_IFS test.TST_TEST_DATA_IFS.sh
+TST_TEST_DATA test.TST_TEST_DATA.sh
+TST_TEST_DATA.TST_CNT.separate test.TST_TEST_DATA.TST_CNT.separate.sh
+TST_TEST_DATA.TST_CNT test.TST_TEST_DATA.TST_CNT.sh
+TST_TEST test.TST_TEST.sh
+TST_TEST.TST_CNT.separate test.TST_TEST.TST_CNT.separate.sh
+TST_TEST.TST_CNT test.TST_TEST.TST_CNT.sh
+TST_TEST.getopts test.TST_TEST.getopts.sh
+TST_TEST.getopts_a_f test.TST_TEST.getopts.sh -a -f foo1
+TST_TEST_DATA.getopts test.TST_TEST_DATA.getopts.sh
+TST_TEST_DATA.getopts_a_f test.TST_TEST_DATA.getopts.sh -a -f foo2
+TST_TEST_DATA_IFS.getopts test.TST_TEST_DATA_IFS.getopts.sh
+TST_TEST_DATA_IFS.getopts_a_f test.TST_TEST_DATA_IFS.getopts.sh -a -f foo3
-- 
2.16.3

