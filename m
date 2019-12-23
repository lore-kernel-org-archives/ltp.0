From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Dec 2019 08:41:52 +0100
Subject: [LTP] [PATCH 1/1] linktest.sh: Convert to use getopts + set default
 values
Message-ID: <20191223074152.27397-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Main motivation for getopts is to allow -h (print help) to be working
without too much tweaking. Although other default options (-i n) were
working, there was no way to print help.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/fs                               |  2 +-
 testcases/kernel/fs/linktest/linktest.sh | 50 ++++++++++++------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/runtest/fs b/runtest/fs
index 463185756..464ba8fb9 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -40,7 +40,7 @@ rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwte
 iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:$TMPDIR/doio.f1.$$ 1000b:$TMPDIR/doio.f2.$$
 
 fs_inod01 fs_inod $TMPDIR 10 10 10
-linker01 linktest.sh 1000 1000
+linker01 linktest.sh
 openfile01 openfile -f10 -t10
 inode01 inode01
 inode02 inode02
diff --git a/testcases/kernel/fs/linktest/linktest.sh b/testcases/kernel/fs/linktest/linktest.sh
index 9d8c8b92a..3386a445b 100755
--- a/testcases/kernel/fs/linktest/linktest.sh
+++ b/testcases/kernel/fs/linktest/linktest.sh
@@ -3,36 +3,36 @@
 # Copyright (c) International Business Machines Corp., 2000
 # Copyright (c) Linux Test Project, 2012-2019
 # Regression test for max links per file
-# linktest.sh <number of symlinks> <number of hardlinks>
 # Author: Ngie Cooper <yaneurabeya@gmail.com>
 
 TST_NEEDS_TMPDIR=1
-TST_POS_ARGS=2
 TST_TESTFUNC=do_test
+TST_OPTS="a:s:"
+TST_PARSE_ARGS=parse_args
+TST_USAGE=usage
 
 . tst_test.sh
 
-if [ $# -ne 2 ]; then
-	tst_res TBROK "usage: $0 {softlink count} {hardlink count}"
-	exit 1
-fi
+hard_links=1000
+soft_links=1000
 
-validate_parameter()
+usage()
 {
-	if ! tst_is_int "$2"; then
-		tst_brk TBROK "$1 must be integer"
-	fi
-
-	if [ "$2" -lt 0 ]; then
-		tst_brk TBROK "$1 must be >= 0"
-	fi
+	echo "Usage: linktest.sh {-a n} {-s n}"
+	echo "-a n    Hard link count"
+	echo "-s n    Soft link count"
 }
 
-validate_parameter "softlink count" $1
-validate_parameter "hardlink count" $2
+parse_args()
+{
+	tst_is_int "$2" || tst_brk TBROK "-$1 must be integer ($2)"
+	[ "$2" -ge 0 ] || tst_brk TBROK "-$1 must be >= 0 ($2)"
 
-soft_links=$1
-hard_links=$2
+	case $1 in
+	a) hard_links=$2;;
+	s) soft_links=$2;;
+	esac
+}
 
 do_link()
 {
@@ -45,20 +45,20 @@ do_link()
 	local i=0
 	local rtype="TFAIL"
 
+	tst_res TINFO "test $prefix_msg link, limit: $limit"
+
 	cd "${prefix}link.$$"
 	while [ $i -lt $limit ]; do
-		if ! ln ${ln_opts} "$PWD/${prefix}file" ${prefix}file${i}; then
+		if ! ln $ln_opts "$PWD/${prefix}file" ${prefix}file${i}; then
 			lerrors=$((lerrors + 1))
 		fi
 		i=$((i + 1))
 	done
 	cd ..
 
-	if [ $lerrors -eq 0 ]; then
-		rtype=TPASS
-	fi
+	[ $lerrors -eq 0 ] && rtype="TPASS"
 
-	tst_res $rtype "$prefix_msg link errors: $lerrors"
+	tst_res $rtype "errors: $lerrors"
 }
 
 do_test()
@@ -66,8 +66,8 @@ do_test()
 	mkdir hlink.$$ slink.$$
 	touch hlink.$$/hfile slink.$$/sfile
 
-	do_link s "-s" $soft_links "symbolic"
-	do_link h   "" $hard_links "hard"
+	do_link "s" "-s" $soft_links "symbolic"
+	do_link "h"   "" $hard_links "hard"
 
 	rm -rf hlink.$$ slink.$$
 }
-- 
2.24.0

