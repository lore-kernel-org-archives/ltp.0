From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  9 Dec 2019 10:38:08 +0100
Subject: [LTP] [PATCH] linktest: Convert to new library
Message-ID: <20191209093808.32320-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/fs/linktest/linktest.sh | 100 +++++++++++------------
 1 file changed, 46 insertions(+), 54 deletions(-)

diff --git a/testcases/kernel/fs/linktest/linktest.sh b/testcases/kernel/fs/linktest/linktest.sh
index bc78f1e4a..6efbe0c94 100755
--- a/testcases/kernel/fs/linktest/linktest.sh
+++ b/testcases/kernel/fs/linktest/linktest.sh
@@ -1,79 +1,71 @@
 #!/bin/sh
-
+# SPDX-License-Identifier: GPL-2.0-or-later
 #   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-
-#
-#  FILE(s)     : linktest.sh README
-#  DESCRIPTION : Regression test for max links per file
-#  USE         : linktest.sh <number of symlinks> <number of hardlinks>
-#  AUTHOR      : Ngie Cooper (yaneurabeya@gmail.com)
-#  HISTORY     :
-#	A rewrite of testcases/kernel/fs/linktest.pl
-
-export TCID=linker01
-export TST_TOTAL=2
-export TST_COUNT=1
-. test.sh
+# Regression test for max links per file
+# linktest.sh <number of symlinks> <number of hardlinks>
+# AUTHOR: Ngie Cooper (yaneurabeya@gmail.com)
+
+TST_NEEDS_TMPDIR=1
+TST_POS_ARGS=2
+TST_TESTFUNC=do_test
+
+. tst_test.sh
 
 if [ $# -ne 2 ]; then
-	tst_resm TBROK "usage: $0 {softlink count} {hardlink count}"
+	tst_res TBROK "usage: $0 {softlink count} {hardlink count}"
 	exit 1
 fi
 
-tst_tmpdir
+validate_parameter() {
+	if ! tst_is_int "$2"; then
+		tst_brk TBROK "$1 must be integer"
+	fi
 
-mkdir hlink.$$ slink.$$ && touch hlink.$$/hfile slink.$$/sfile
+	if [ "$2" -lt 0 ]; then
+		tst_brk TBROK "$1 must be >= 0"
+	fi
+}
 
-do_link() {
-	pfix=$1
-	ln_opts=$2
-	limit=$3
-	prefix_msg=$4
+validate_parameter "softlink count" $1
+validate_parameter "hardlink count" $2
 
-	lerrors=0
+soft_links=$1
+hard_links=$2
 
-	i=0
+do_link() {
+	local prefix=$1
+	local ln_opts=$2
+	local limit=$3
+	local prefix_msg=$4
+
+	local lerrors=0
+	local i=0
+	local rtype=TFAIL
 
-	cd "${pfix}link.$$"
+	cd "${prefix}link.$$"
 	while [ $i -lt $limit ]; do
-		if ! ln ${ln_opts} "$PWD/${pfix}file" ${pfix}file${i}; then
+		if ! ln ${ln_opts} "$PWD/${prefix}file" ${prefix}file${i}; then
 			: $(( lerrors += 1 ))
 		fi
-		: $(( i+= 1 ))
+		: $(( i += 1 ))
 	done
 	cd ..
 
 	if [ $lerrors -eq 0 ]; then
-		RTYPE=TPASS
-	else
-		RTYPE=TFAIL
+		rtype=TPASS
 	fi
 
-	tst_resm $RTYPE "$prefix_msg Link Errors: $lerrors"
-
-	: $(( TST_COUNT += 1 ))
-
+	tst_res $rtype "$prefix_msg Link Errors: $lerrors"
 }
 
-do_link s "-s" ${1} "Symbolic"
-do_link h   "" ${2} "Hard"
+do_test() {
+	mkdir hlink.$$ slink.$$
+	touch hlink.$$/hfile slink.$$/sfile
+
+	do_link s "-s" $soft_links "Symbolic"
+	do_link h   "" $hard_links "Hard"
 
-rm -Rf hlink.$$ slink.$$
+	rm -Rf hlink.$$ slink.$$
+}
 
-tst_rmdir
-tst_exit
+tst_run
-- 
2.20.1

