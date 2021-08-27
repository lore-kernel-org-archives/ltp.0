From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Aug 2021 14:32:54 +0200
Subject: [LTP] [RFC PATCH 1/1] scripts: Remove legacy script tests
Message-ID: <20210827123254.16883-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tests were testing real/absolute path for testing make 3.80 compatibility,
also detecting if something tries to removing root directory.

Tests were added 11 years ago, not used now.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

IMHO useless now.

Kind regards,
Petr

 scripts/abspath.sh            |  30 ---------
 scripts/lib/file_functions.sh |  71 --------------------
 scripts/realpath.sh           |  30 ---------
 scripts/safe_rm.sh            |  76 ---------------------
 scripts/tests/test_abspath.sh | 121 ----------------------------------
 scripts/tests/test_safe_rm.sh |  52 ---------------
 6 files changed, 380 deletions(-)
 delete mode 100755 scripts/abspath.sh
 delete mode 100644 scripts/lib/file_functions.sh
 delete mode 100755 scripts/realpath.sh
 delete mode 100755 scripts/safe_rm.sh
 delete mode 100755 scripts/tests/test_abspath.sh
 delete mode 100755 scripts/tests/test_safe_rm.sh

diff --git a/scripts/abspath.sh b/scripts/abspath.sh
deleted file mode 100755
index f0862480a..000000000
--- a/scripts/abspath.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-#
-#    make 3.81 $(abspath .. ) emulation layer
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-#
-
-. "${0%/*}/lib/file_functions.sh"
-
-while [ $# -gt 0 ] ; do
-	echo -n $(_abspath "$1")
-	[ $# -gt 1 ] && echo -n " "
-	shift
-done
diff --git a/scripts/lib/file_functions.sh b/scripts/lib/file_functions.sh
deleted file mode 100644
index 32c433171..000000000
--- a/scripts/lib/file_functions.sh
+++ /dev/null
@@ -1,71 +0,0 @@
-#!/bin/sh
-#
-# File functions utilized as part of abspath.sh, realpath.sh, etc.
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-#
-# POSIX compliant bourne shell functions for performing make 3.81
-# compliancy in 3.80 with a minimal set of external commands
-# [awk(1) // readlink(1) only required].
-#
-
-# 0. Strip all heading and leading space.
-# Paths:
-# 1. Empty string - print out $PWD.
-# 2. Not empty string...
-#    i. Prefix all relative paths with $PWD.
-#    ii. Replace /+ with /.
-#    iii. Replace a/b/../c with a/c
-#    iv. Replace /./ with /
-#    v. Replace trailing /. with /
-#    vi. Replace heading ./ with /
-#    vii. Replace /. with "".
-
-# testcases/kernel/controllers/libcontrollers/../../../..
-_abspath() {
-	echo "$@" | awk -v PWD=$(pwd) '{
-	sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, ""); # 1.
-	if ($0 == "") {
-		print PWD
-	} else {
-		if (!($0 ~ /^\//)) { # i.
-			$0 = PWD "/" $0
-		}
-		while (gsub(/\/\//, "/")) { }; # ii.
-		while (sub(/\/[^\/]+\/\.\.\/?/, "/")) { }; # iii.
-		while (sub(/\/\.\//, "/")) { }; # iv.
-		sub(/(\/\.)?\/$/, "");
-		sub(/^\.\//, "/");
-		sub(/\/\.$/, "");
-		if ($0 == "") {
-			print "/"
-		} else {
-			if ($0 == ".") {
-				print PWD
-			} else {
-				print
-			}
-		}
-	}
-}'
-}
-
-_realpath() {
-	readlink -f "$@"
-}
diff --git a/scripts/realpath.sh b/scripts/realpath.sh
deleted file mode 100755
index d05088eb3..000000000
--- a/scripts/realpath.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-#
-#    make 3.81 $(realpath .. ) emulation layer
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-#
-
-. "${0%/*}/lib/file_functions.sh"
-
-while [ $# -gt 0 ] ; do
-	echo -n $(_realpath "$1")
-	[ $# -gt 1 ] && echo -n " "
-	shift
-done
diff --git a/scripts/safe_rm.sh b/scripts/safe_rm.sh
deleted file mode 100755
index 68e961405..000000000
--- a/scripts/safe_rm.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/bin/sh
-#
-# A safe wrapper around rm(1) to avoid cleaning out folks' rootfs's or build
-# machines by accident.
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Feel free to use this in your standard builds, or just leave it be (it has
-# been added to the build tests that should be run before each release to avoid
-# build regressions).
-#
-# Ngie Cooper, February 2010
-#
-
-. "${0%/*}/lib/file_functions.sh"
-
-opts=
-opts_parse_done=0
-
-set -e
-
-while [ $# -gt 0 ] ; do
-
-	if [ $opts_parse_done -eq 0 ] ; then
-
-		case "$1" in
-		-*)
-			[ "x$1" = "x--" ] && opts_parse_done=1
-			# None of the options to rm(1) are keyed.
-			opts="$opts $1"
-			;;
-		*)
-			opts_parse_done=1
-			;;
-		esac
-
-	fi
-
-	if [ $opts_parse_done -eq 1 ] ; then
-
-		abspath_file=$(_abspath "$1")
-
-		if [ "x$abspath_file" = "x/" ] ; then
-
-			cat <<EOF >&2
-${0##*/}: ERROR : not removing \`$1' to avoid removing root directory\!
-EOF
-			false
-
-		else
-
-			if [ "x${SIMULATE_RM:-1}" != x1 ] ; then
-				rm ${opts:--f} "$abspath_file"
-			fi
-
-		fi
-
-	fi
-
-	shift
-
-done
diff --git a/scripts/tests/test_abspath.sh b/scripts/tests/test_abspath.sh
deleted file mode 100755
index 8861cc5a5..000000000
--- a/scripts/tests/test_abspath.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#!/bin/sh
-#
-# Test the _abspath function, utilized as part of abspath.sh
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-#
-
-SCRIPTS_DIR="$(readlink -f ${0%/*}/..)"
-TEST_PATH=$("$SCRIPTS_DIR/realpath.sh" "$SCRIPTS_DIR/lib")
-
-pushd "$TEST_PATH" >/dev/null
-
-set --	\
-	:$PWD								\
-	.:$PWD								\
-	foo/bar:$PWD/foo/bar						\
-	/foo/bar:/foo/bar						\
-	/foo/../bar:/bar				 		\
-	/foo/bar/../baz:/foo/baz				 	\
-	/foo/bar/../baz/:/foo/baz				 	\
-	/foo/../bar/:/bar 						\
-	/foo/../bar/..:/ 						\
-	/foo/../bar/../:/ 						\
-	/foo/bar/../baz:/foo/baz				 	\
-	/foo/./bar:/foo/bar				 		\
-	/./foo/./bar:/foo/bar						\
-	/foo//bar:/foo/bar						\
-	//foo/bar:/foo/bar						\
-	//////foo/bar:/foo/bar						\
-	/foo/////bar:/foo/bar						\
-	/a/b/c/.././:/a/b						\
-	/.foo:/.foo							\
-	./.foo:$PWD/.foo						\
-	/.foo/.bar:/.foo/.bar						\
-	./.foo/.bar:$PWD/.foo/.bar					\
-	/scratch/ltp/testcases/realtime/../..:/scratch/ltp		\
-	..:$(dirname "$TEST_PATH")					\
-	../..:$(dirname "$(dirname "$TEST_PATH")")			\
-	testcases/kernel/controllers/libcontrollers/../../../..:$PWD
-
-export TCID=test_abspath
-export TST_TOTAL=$#
-export TST_COUNT=1
-
-. "$SCRIPTS_DIR/lib/file_functions.sh"
-
-for i in "$@"; do
-
-	test_string=${i%:*}
-	expected_string=${i#*:}
-
-	result=$(_abspath "$test_string")
-
-	if [ "$result" = "$expected_string" ] ; then
-		result_s="matches expected string _abspath(${test_string}) => $result == $expected_string)"
-		result_v=TPASS
-	else
-		result_s="doesn't match expected string _abspath(${test_string}) => $result != $expected_string)"
-		result_v=TFAIL
-		FAILED=1
-	fi
-
-	tst_resm $result_v "Test string $result_s"
-
-	: $(( TST_COUNT += 1 ))
-
-done
-
-popd >/dev/null
-
-expected_string="$PWD"
-test_string='""'
-result=$("$SCRIPTS_DIR/abspath.sh" "")
-
-if [ "$result" = "$expected_string" ] ; then
-	result_s="matches expected string abspath.sh ${test_string} => $result == $expected_string)"
-	result_v=TPASS
-else
-	result_s="doesn't match expected string abspath.sh ${test_string} => $result != $expected_string)"
-	result_v=TFAIL
-	FAILED=1
-fi
-
-tst_resm $result_v "Test string $result_s"
-
-: $(( TST_COUNT += 1 ))
-
-expected_string="$PWD $PWD"
-test_string="\"\" ."
-result=$("$SCRIPTS_DIR/abspath.sh" "" .)
-
-if [ "$result" = "$expected_string" ] ; then
-	result_s="matches expected string abspath.sh ${test_string} => $result == $expected_string)"
-	result_v=TPASS
-else
-	result_s="doesn't match expected string abspath.sh ${test_string} => $result != $expected_string)"
-	result_v=TFAIL
-	FAILED=1
-fi
-
-tst_resm $result_v "Test string $result_s"
-
-: $(( TST_COUNT += 1 ))
-
-exit ${FAILED:=0}
diff --git a/scripts/tests/test_safe_rm.sh b/scripts/tests/test_safe_rm.sh
deleted file mode 100755
index 92bf534e6..000000000
--- a/scripts/tests/test_safe_rm.sh
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/sh
-#
-# Test for safe_rm.sh
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, February 2010
-#
-
-export SIMULATE_RM=1
-
-export TCID=test_safe_rm
-export TST_TOTAL=6
-export TST_COUNT=1
-
-set -e
-
-ec=0
-
-for i in /foo foo/bar /foo/bar/; do
-	if "${0%/*}/../safe_rm.sh" $i ; then
-		tst_resm TPASS "$i passed as expected"
-	else
-		tst_resm TFAIL "$i didn't pass as expected"
-		ec=$(( $ec | 1 ))
-	fi
-done
-
-for i in / /// /.; do
-	if "${0%/*}/../safe_rm.sh" $i; then
-		tst_resm TFAIL "$i didn't fail as expected"
-		ec=$(( $ec | 1 ))
-	else
-		tst_resm TPASS "$i failed as expected"
-	fi
-done
-
-exit $ec
-- 
2.32.0

