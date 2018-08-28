From: Christian Lanig <clanig@suse.com>
Date: Tue, 28 Aug 2018 13:18:43 +0200
Subject: [LTP] [PATCH 1/2] Make shell lib tests standalone
In-Reply-To: <20180522193430.20117-2-pvorel@suse.cz>
References: <20180522193430.20117-2-pvorel@suse.cz>
Message-ID: <20180828111844.20152-1-clanig@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
Please do not merge! See following message for details.

 lib/newlib_tests/Makefile                          |  1 -
 .../{ => shell}/test.TST_TEST.TST_CNT.separate.sh  |  2 +-
 .../{ => shell}/test.TST_TEST.TST_CNT.sh           |  2 +-
 .../{ => shell}/test.TST_TEST.getopts.sh           |  2 +-
 lib/newlib_tests/{ => shell}/test.TST_TEST.sh      |  2 +-
 .../test.TST_TEST_DATA.TST_CNT.separate.sh         |  2 +-
 .../{ => shell}/test.TST_TEST_DATA.TST_CNT.sh      |  2 +-
 .../{ => shell}/test.TST_TEST_DATA.getopts.sh      |  2 +-
 lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.sh |  2 +-
 .../{ => shell}/test.TST_TEST_DATA_IFS.getopts.sh  |  2 +-
 .../{ => shell}/test.TST_TEST_DATA_IFS.sh          |  2 +-
 lib/newlib_tests/test.shell_lib.sh                 | 94 ++++++++++++++++++++++
 runtest/test                                       | 13 ---
 testcases/lib/tst_test.sh                          |  2 +-
 14 files changed, 105 insertions(+), 25 deletions(-)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST.TST_CNT.separate.sh (95%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST.TST_CNT.sh (95%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST.getopts.sh (96%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST.sh (95%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.TST_CNT.separate.sh (96%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.TST_CNT.sh (96%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.getopts.sh (96%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.sh (95%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA_IFS.getopts.sh (97%)
 rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA_IFS.sh (96%)
 create mode 100755 lib/newlib_tests/test.shell_lib.sh
 delete mode 100644 runtest/test

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index ad087b440..2fc50160a 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -16,6 +16,5 @@ ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
 endif
 
-INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
similarity index 95%
rename from lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh
rename to lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
index e26e2cb14..75ab680f1 100755
--- a/lib/newlib_tests/test.TST_TEST.TST_CNT.separate.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
@@ -5,7 +5,7 @@
 
 TST_TESTFUNC=test
 TST_CNT=2
-. tst_test.sh
+. ./tst_test.sh
 
 test1()
 {
diff --git a/lib/newlib_tests/test.TST_TEST.TST_CNT.sh b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh
similarity index 95%
rename from lib/newlib_tests/test.TST_TEST.TST_CNT.sh
rename to lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh
index d84457fea..31b15204f 100755
--- a/lib/newlib_tests/test.TST_TEST.TST_CNT.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh
@@ -5,7 +5,7 @@
 
 TST_TESTFUNC=do_test
 TST_CNT=2
-. tst_test.sh
+. ./tst_test.sh
 
 do_test()
 {
diff --git a/lib/newlib_tests/test.TST_TEST.getopts.sh b/lib/newlib_tests/shell/test.TST_TEST.getopts.sh
similarity index 96%
rename from lib/newlib_tests/test.TST_TEST.getopts.sh
rename to lib/newlib_tests/shell/test.TST_TEST.getopts.sh
index 0ba848a0a..090133756 100755
--- a/lib/newlib_tests/test.TST_TEST.getopts.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST.getopts.sh
@@ -8,7 +8,7 @@ TST_USAGE=usage
 TST_PARSE_ARGS=parse_args
 TST_TESTFUNC=do_test
 
-. tst_test.sh
+. ./tst_test.sh
 
 ALTERNATIVE=0
 MODE="foo"
diff --git a/lib/newlib_tests/test.TST_TEST.sh b/lib/newlib_tests/shell/test.TST_TEST.sh
similarity index 95%
rename from lib/newlib_tests/test.TST_TEST.sh
rename to lib/newlib_tests/shell/test.TST_TEST.sh
index 6ecae710d..42f14151b 100755
--- a/lib/newlib_tests/test.TST_TEST.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST.sh
@@ -4,7 +4,7 @@
 #
 
 TST_TESTFUNC=do_test
-. tst_test.sh
+. ./tst_test.sh
 
 do_test()
 {
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh
similarity index 96%
rename from lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh
rename to lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh
index 9a81ad27c..6d4a90141 100755
--- a/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.separate.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh
@@ -6,7 +6,7 @@
 TST_TESTFUNC=test
 TST_CNT=2
 TST_TEST_DATA="foo:bar:d dd"
-. tst_test.sh
+. ./tst_test.sh
 
 test1()
 {
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
similarity index 96%
rename from lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh
rename to lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
index 798ad9621..8dd25acae 100755
--- a/lib/newlib_tests/test.TST_TEST_DATA.TST_CNT.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
@@ -6,7 +6,7 @@
 TST_TESTFUNC=do_test
 TST_CNT=2
 TST_TEST_DATA="foo:bar:d dd"
-. tst_test.sh
+. ./tst_test.sh
 
 do_test()
 {
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.getopts.sh b/lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh
similarity index 96%
rename from lib/newlib_tests/test.TST_TEST_DATA.getopts.sh
rename to lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh
index 1cd150618..66e534ae5 100755
--- a/lib/newlib_tests/test.TST_TEST_DATA.getopts.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh
@@ -9,7 +9,7 @@ TST_PARSE_ARGS=parse_args
 TST_TESTFUNC=do_test
 TST_TEST_DATA="foo0:bar:d dd"
 
-. tst_test.sh
+. ./tst_test.sh
 
 ALTERNATIVE=0
 MODE="foo"
diff --git a/lib/newlib_tests/test.TST_TEST_DATA.sh b/lib/newlib_tests/shell/test.TST_TEST_DATA.sh
similarity index 95%
rename from lib/newlib_tests/test.TST_TEST_DATA.sh
rename to lib/newlib_tests/shell/test.TST_TEST_DATA.sh
index 4cb51c669..568cec01e 100755
--- a/lib/newlib_tests/test.TST_TEST_DATA.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA.sh
@@ -5,7 +5,7 @@
 
 TST_TESTFUNC=do_test
 TST_TEST_DATA="foo:bar:d dd"
-. tst_test.sh
+. ./tst_test.sh
 
 do_test()
 {
diff --git a/lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh b/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
similarity index 97%
rename from lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh
rename to lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
index 59dbd9598..41e3f99de 100755
--- a/lib/newlib_tests/test.TST_TEST_DATA_IFS.getopts.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
@@ -10,7 +10,7 @@ TST_TESTFUNC=do_test
 TST_TEST_DATA="foo0:bar:d dd"
 TST_TEST_DATA_IFS=":"
 
-. tst_test.sh
+. ./tst_test.sh
 
 ALTERNATIVE=0
 MODE="foo"
diff --git a/lib/newlib_tests/test.TST_TEST_DATA_IFS.sh b/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh
similarity index 96%
rename from lib/newlib_tests/test.TST_TEST_DATA_IFS.sh
rename to lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh
index 52a2e6d47..4e73f5030 100755
--- a/lib/newlib_tests/test.TST_TEST_DATA_IFS.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh
@@ -7,7 +7,7 @@
 TST_TESTFUNC=do_test
 TST_TEST_DATA="foo:bar:d dd"
 TST_TEST_DATA_IFS=":"
-. tst_test.sh
+. ./tst_test.sh
 
 do_test()
 {
diff --git a/lib/newlib_tests/test.shell_lib.sh b/lib/newlib_tests/test.shell_lib.sh
new file mode 100755
index 000000000..599eec78a
--- /dev/null
+++ b/lib/newlib_tests/test.shell_lib.sh
@@ -0,0 +1,94 @@
+# !/bin/sh
+#
+# This script iterates over all test cases for the new shell lib and verifies
+# the output.
+# Do NOT use newline symbols in the names of files containing test cases!
+#
+
+setup() {
+	color_green="\033[1;32m"
+	color_red="\033[1;31m"
+	standard_color="\033[0m"
+	start_dir="$PWD"
+	cd "$(dirname "$0")""/../../" || exit 1;
+	sh_lib_dir=""$PWD"/testcases/lib/"
+	sh_lib_test_dir=""$PWD"/lib/newlib_tests/shell/"
+	tst_cases=$(ls "$sh_lib_test_dir" | \
+			sed "s/"$TEST_NAME".sh/"$TEST_NAME"/g")
+	cd "$sh_lib_dir" || exit 1
+}
+
+check_requirements() {
+	case "$0" in
+		-*)
+			printf "Please execute this script. Sourcing ";
+			printf "(. <SCRIPT>) is not supported. \n";
+			return 1;;
+		*)
+			true;
+	esac
+}
+
+verify_output() {
+	local output_found=1
+	local wanted_output=
+	local parsed_line=
+	while read line;
+	do
+		if [ -z "$wanted_output" ] && [ "$line" = "# output:" ]
+		then
+			output_found=0
+		elif [ $output_found -eq 0 ] || [ -n "$wanted_output" ]
+		then
+			if printf "$line" | grep "# " > /dev/null;
+			then
+				if [ $output_found -eq 0 ]
+				then
+					parsed_line=$(printf "$line" | \
+							sed "s/^.\{2\}//")
+					output_found=1
+				else
+					parsed_line="\n"$(printf "$line" | \
+							sed "s/^.\{2\}//")
+				fi
+			elif printf "$line" | grep "#" > /dev/null;
+			then
+				parsed_line="\n"$(printf "$line" | \
+						sed "s/^.\{1\}//")
+			else true;
+			fi
+			wanted_output=""$wanted_output""$parsed_line""
+		else true;
+		fi
+
+	done < ""$sh_lib_test_dir""$1".sh"
+	wanted_output=$(printf "$wanted_output")
+	local actual_output=$(""$sh_lib_test_dir""$1".sh")
+	actual_output=$(printf "$actual_output")
+	if [ "$wanted_output" = "$actual_output" ]
+	then
+		return 0
+	else
+		return 1
+	fi
+}
+
+run_tests() {
+	for tst_case in $tst_cases
+	do
+		printf "Running Test: \""$tst_case"\"...\n"
+		if verify_output "$tst_case";
+		then
+			printf ""$color_green"TPASS: "$standard_color""
+			printf "Test "$tst_case" was successful.\n\n"
+		else
+			printf ""$color_red"TFAIL:"$standard_color""
+			printf "Test "$tst_case" was unsuccessful.\n\n"
+		fi
+	done
+}
+
+check_requirements
+setup
+run_tests
+exit 0
diff --git a/runtest/test b/runtest/test
deleted file mode 100644
index 469e3b787..000000000
--- a/runtest/test
+++ /dev/null
@@ -1,13 +0,0 @@
-TST_TEST_DATA_IFS test.TST_TEST_DATA_IFS.sh
-TST_TEST_DATA test.TST_TEST_DATA.sh
-TST_TEST_DATA.TST_CNT.separate test.TST_TEST_DATA.TST_CNT.separate.sh
-TST_TEST_DATA.TST_CNT test.TST_TEST_DATA.TST_CNT.sh
-TST_TEST test.TST_TEST.sh
-TST_TEST.TST_CNT.separate test.TST_TEST.TST_CNT.separate.sh
-TST_TEST.TST_CNT test.TST_TEST.TST_CNT.sh
-TST_TEST.getopts test.TST_TEST.getopts.sh
-TST_TEST.getopts_a_f test.TST_TEST.getopts.sh -a -f foo1
-TST_TEST_DATA.getopts test.TST_TEST_DATA.getopts.sh
-TST_TEST_DATA.getopts_a_f test.TST_TEST_DATA.getopts.sh -a -f foo2
-TST_TEST_DATA_IFS.getopts test.TST_TEST_DATA_IFS.getopts.sh
-TST_TEST_DATA_IFS.getopts_a_f test.TST_TEST_DATA_IFS.getopts.sh -a -f foo3
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e553b496d..769ed66c2 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -33,7 +33,7 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
-. tst_ansi_color.sh
+. ./tst_ansi_color.sh
 
 # default trap function
 trap "tst_brk TBROK 'test interrupted'" INT
-- 
2.16.4

