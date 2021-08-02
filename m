From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Aug 2021 19:35:29 +0200
Subject: [LTP] [PATCH v7 0/7] Run tests in CI
Message-ID: <20210802173536.19525-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v6->v7:
* new commit: test/test_zero_hugepage.sh: Skip test on read-only file system
* new commit: ci: Install iproute2
* Added test_zero_hugepage.sh (required to have look on source directory,
because we use scripts for running C API (required for out-of-tree
builds).

Tested:
https://github.com/pevik/ltp/actions/runs/1091097653

Kind regards,
Petr

Diff to v6:

diff --git ci/debian.sh ci/debian.sh
index a609da887..e929452ff 100755
--- ci/debian.sh
+++ ci/debian.sh
@@ -22,6 +22,7 @@ $apt \
 	clang \
 	gcc \
 	git \
+	iproute2 \
 	libacl1 \
 	libacl1-dev \
 	libaio-dev \
diff --git ci/fedora.sh ci/fedora.sh
index 959f3af20..dc1293aa5 100755
--- ci/fedora.sh
+++ ci/fedora.sh
@@ -13,6 +13,7 @@ $yum \
 	gcc \
 	git \
 	findutils \
+	iproute \
 	numactl-devel \
 	libtirpc \
 	libtirpc-devel \
diff --git ci/tumbleweed.sh ci/tumbleweed.sh
index ab622e05c..f1e7252f2 100755
--- ci/tumbleweed.sh
+++ ci/tumbleweed.sh
@@ -13,6 +13,7 @@ $zyp \
 	gcc \
 	git \
 	gzip \
+	iproute2 \
 	make \
 	kernel-default-devel \
 	keyutils-devel \
diff --git lib/newlib_tests/runtest.sh lib/newlib_tests/runtest.sh
index bd7995f3b..70fbffb6c 100755
--- lib/newlib_tests/runtest.sh
+++ lib/newlib_tests/runtest.sh
@@ -3,7 +3,7 @@
 
 LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync02
-tst_fuzzy_sync03}"
+tst_fuzzy_sync03 test_zero_hugepage.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
 
@@ -71,7 +71,8 @@ runtest_brk()
 run_tests()
 {
 	local target="$1"
-	local i res ret=0 tbrok tconf tfail tpass twarn vars
+	local srcdir="$2"
+	local dir i res ret=0 tbrok tconf tfail tpass twarn vars
 
 	eval vars="\$LTP_${target}_API_TESTS"
 
@@ -79,7 +80,15 @@ run_tests()
 
 	for i in $vars; do
 		runtest_res TINFO "* $i"
-		./$i
+		if [ -f "$i" ]; then
+			dir="."
+		elif [ "$srcdir" -a -f "$srcdir/$i" ]; then
+			dir="$srcdir"
+		else
+			runtest_brk TBROK "Error: $i file not found (PWD: $PWD)"
+		fi
+
+		$dir/$i 1>&2
 		res=$?
 
 		[ $res -ne 0 -a $res -ne 32 ] && ret=1
@@ -94,7 +103,6 @@ run_tests()
 			*) runtest_brk TBROK "Error: unknown failure, exit code: $res";;
 		esac
 		runtest_res
-		sync
 	done
 
 	runtest_res TINFO "=== $target TEST RESULTS ==="
@@ -110,17 +118,17 @@ run_tests()
 
 run_c_tests()
 {
-	local ret
+	local ret srcdir="$PWD"
 
 	if [ "$builddir" ]; then
 		cd $builddir/lib/newlib_tests
 	fi
 
-	run_tests "C"
+	run_tests "C" "$srcdir"
 	ret=$?
 
 	if [ "$builddir" ]; then
-		cd -
+		cd "$srcdir"
 	fi
 
 	return $ret
diff --git lib/newlib_tests/test_zero_hugepage.sh lib/newlib_tests/test_zero_hugepage.sh
index 10113006b..8a462478e 100755
--- lib/newlib_tests/test_zero_hugepage.sh
+++ lib/newlib_tests/test_zero_hugepage.sh
@@ -1,12 +1,16 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
 echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
 
 orig_value=`cat /proc/sys/vm/nr_hugepages`
 
-echo "128" > /proc/sys/vm/nr_hugepages
+if ! echo "128" > /proc/sys/vm/nr_hugepages; then
+	echo "TCONF: failed to open /proc/sys/vm/nr_hugepages"
+	exit 32
+fi
 
 ./test_zero_hugepage
 

Petr Vorel (7):
  lib: Print Summary: into stderr
  test/test_zero_hugepage.sh: Skip test on read-only file system
  lib: Add script for running tests
  make: Add make test{, -c, -shell} targets
  build.sh: Add support for make test{,-c,-shell}
  CI: Run also make test-c, test-shell
  ci: Install iproute2

 .github/workflows/ci.yml               |  10 ++
 Makefile                               |  23 +++
 build.sh                               |  24 +++-
 ci/debian.sh                           |   1 +
 ci/fedora.sh                           |   1 +
 ci/tumbleweed.sh                       |   1 +
 lib/newlib_tests/runtest.sh            | 190 +++++++++++++++++++++++++
 lib/newlib_tests/test_zero_hugepage.sh |   6 +-
 lib/tst_test.c                         |  12 +-
 9 files changed, 260 insertions(+), 8 deletions(-)
 create mode 100755 lib/newlib_tests/runtest.sh

-- 
2.32.0

