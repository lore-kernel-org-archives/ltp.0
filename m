Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YnkJb-0005bA-Mj
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:59:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YnkJY-0003T0-Cp
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:59:27 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 30 Apr 2015 16:58:05 +0800
Message-ID: <1430384287-16073-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55418B02.3080104@huawei.com>
	<1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] commands/fileutils/mv: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: cuibixuan@huawei.com
Cc: ltp-list@lists.sourceforge.net

* Delete some useless comments.
* Add 'TCID' and 'TST_TOTAL' global variables.
* Add test.sh.
* init() --> setup()
* Add cleanup().
* Use 'tst_check_cmds' and 'tst_tmpdir'.
* Use 'ROD_SILENT'.
* Use 'tst_resm' and 'trs_brkm' instead of 'tst_res' and 'tst_brk'.
* Use 'local' to define the variables as they are in functions.
* tst_mv.tmp --> tst_mv.old
* tst_mv.tmp1 --> tst_mv.new
* Some cleanup.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/commands/fileutils/mv/mv_tests.sh | 263 ++++++++--------------------
 1 file changed, 73 insertions(+), 190 deletions(-)

diff --git a/testcases/commands/fileutils/mv/mv_tests.sh b/testcases/commands/fileutils/mv/mv_tests.sh
index 207e945..6c55d94 100755
--- a/testcases/commands/fileutils/mv/mv_tests.sh
+++ b/testcases/commands/fileutils/mv/mv_tests.sh
@@ -2,6 +2,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2001                 ##
+## Author:       Manoj Iyer, manjo@mail.utexas.edu                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -14,251 +15,133 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 #
-# File :        mv_test.sh
-#
 # Description:  Test basic functionality of mv command
-#				- Test #1:  mv <dir1> <dir2> will move dir1 to dir2 and all its
-#				            contents.
-#
-# Author:       Manoj Iyer, manjo@mail.utexas.edu
-#
-# History:      Feb 03 2003 - Created - Manoj Iyer.
+#		- Test #1:  mv <dir1> <dir2>
+#		  move dir1 to dir2 and all its contents.
 #
-# Function:		init
-#
-# Description:	- Check if command mv is available.
-#               - Create temprary directory, and temporary files.
-#               - Initialize environment variables.
-#
-# Return		- zero on success
-#               - non zero on failure. return value from commands ($RC)
-init()
-{
 
-	RC=0				# Return code from commands.
-	export TST_TOTAL=1	# total numner of tests in this file.
-	export TCID=mv	# this is the init function.
-	export TST_COUNT=0	# init identifier,
+TCID=mv01
+TST_TOTAL=1
+. test.sh
 
-	if [ -z "$LTPTMP" ] && [ -z "$TMPBASE" ]
-	then
-		LTPTMP=/tmp
-	else
-		LTPTMP=$TMPBASE
-	fi
-	if [ -z "$LTPBIN" ] && [ -z "$LTPROOT" ]
-	then
-		LTPBIN=./
-	else
-		LTPBIN=$LTPROOT/testcases/bin
-	fi
+setup()
+{
+	tst_check_cmds mv
 
+	tst_tmpdir
 
-	$LTPBIN/tst_resm TINFO "INIT: Inititalizing tests."
+	tst_resm TINFO "INIT: Inititalizing tests."
 
-	which mv > $LTPTMP/tst_mv.err 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
-			"Test #1: mv command does not exist. Reason:"
-		return $RC
-	fi
+	ROD_SILENT mkdir -p tst_mv.old
+}
 
-	mkdir -p $LTPTMP/tst_mv.tmp > $LTPTMP/tst_mv.err 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
-			"Test #1: failed creating temp directory. Reason:"
-		return $RC
-	fi
-	return $RC
+cleanup()
+{
+	tst_rmdir
 }
 
-# Function:		creat_dirnfiles
-#
-# Description:	- create N directories and fill each with M files
-#
-# Input:		$1 - test number
-#				$2 - number of directories to create
-#				$3 - number of file to create in each directory
-#				$4 - name of the base directory
-#
-# Return		- zero on success
-#               - non zero on failure. return value ($RC) from commands
 creat_dirnfiles()
 {
-    numdirs=$2	# number of directories to create
-    numfiles=$3 # number of file to create in each directory
-    dirname=$4  # name of the base directory
-	dircnt=0    # index into number of dirs created in loop
-	fcnt=0      # index into number of files created in loop
-	RC=0        # return value from commands
-
-	$LTPBIN/tst_resm TINFO "Test #$1: Creating $numdirs directories."
-	$LTPBIN/tst_resm TINFO "Test #$1: filling each dir with $numfiles files".
+	local numdirs=$2
+	local numfiles=$3
+	local dirname=$4
+	local dircnt=0
+	local fcnt=0
+
+	tst_resm TINFO "Test #$1: Creating $numdirs directories."
+	tst_resm TINFO "Test #$1: filling each dir with $numfiles files."
 	while [ $dircnt -lt $numdirs ]
 	do
 		dirname=$dirname/d.$dircnt
-        mkdir -p $dirname  > $LTPTMP/tst_mv.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]
-		then
-			$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
-			"Test #$1: while creating $numdirs dirs.  Reason"
-			return $RC
-		fi
+		ROD_SILENT mkdir -p $dirname
+
 		fcnt=0
-        while [ $fcnt -lt $numfiles ]
-        do
-			touch $dirname/f.$fcnt
-			if [ $RC -ne 0 ]
-			then
-				$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
-				"Test #$1: while creating $numdirs dirs.  Reason"
-				return $RC
-			fi
+		while [ $fcnt -lt $numfiles ]
+		do
+			ROD_SILENT touch $dirname/f.$fcnt
 			fcnt=$(($fcnt+1))
 		done
 		dircnt=$(($dircnt+1))
 	done
-	return $RC
 }
 
-
-# Function:		creat_expout
-#
-# Description:	- create expected output
-#
-# Input:		$1 - number of directories to create
-#				$2 - number of file to create in each directory
-#				$3 - name of the base directory
-#
-# Return		- zero on success
-#               - non zero on failure. return value ($RC) from commands
 creat_expout()
 {
-	numdir=$1	# number of directories to create
-	numfile=$2  # number of file to create in each directory
-	dirname=$3  # name of the base directory
-    dircnt=0    # index into dir created in loop
-    fcnt=0      # index into files created in loop
-	RC=0        # return code from commands
-
-	echo "$dirname:"  1>>$LTPTMP/tst_mv.exp
-	echo "d.$dircnt"  1>>$LTPTMP/tst_mv.exp
+	local numdir=$1
+	local numfile=$2
+	local dirname=$3
+	local dircnt=0
+	local fcnt=0
+
+	echo "$dirname:"  1>>tst_mv.exp
+	echo "d.$dircnt"  1>>tst_mv.exp
 	while [ $dircnt -lt $numdirs ]
 	do
 		dirname=$dirname/d.$dircnt
 		dircnt=$(($dircnt+1))
-		echo "$dirname:"  1>>$LTPTMP/tst_mv.exp
-		if [ $dircnt -lt $numdirs ]
-		then
-			echo "d.$dircnt" 1>>$LTPTMP/tst_mv.exp
+		echo "$dirname:"  1>>tst_mv.exp
+		if [ $dircnt -lt $numdirs ]; then
+			echo "d.$dircnt" 1>>tst_mv.exp
 		fi
+
 		fcnt=0
-        while [ $fcnt -lt $numfiles ]
-        do
-			echo "f.$fcnt " 1>>$LTPTMP/tst_mv.exp
+		while [ $fcnt -lt $numfiles ]
+		do
+			echo "f.$fcnt " 1>>tst_mv.exp
 			fcnt=$(($fcnt+1))
 		done
-		printf "\n\n" 1>>$LTPTMP/tst_mv.exp
-
+		printf "\n\n" 1>>tst_mv.exp
 	done
 }
 
-# Function:		test01
-#
-# Description	- Test #1: Test that mv <dir1> <dir2> will move
-#                 dir1 to dir2 and all its contents.
-#               - create N directories and fill each with M files.
-#               - mv dir1 to dir2
-#               - list contents of dir2 and save it to file - actual output
-#               - create expected output
-#               - compare expected output with actual output.
-#
-# Return		- zero on success
-#               - non zero on failure. return value from commands ($RC)
-
 test01()
 {
-	RC=0				# Return value from commands.
-	export TCID=mv01	# Name of the test case.
-	export TST_COUNT=1	# Test number.
 	numdirs=10
 	numfiles=10
 	dircnt=0
-    fcnt=0
+	fcnt=0
 
-	$LTPBIN/tst_resm TINFO \
-		"Test #1: mv <dir1> <dir2> will move dir1 to dir2 and all its contents"
-
-	creat_dirnfiles 1 $numdirs $numfiles $LTPTMP/tst_mv.tmp || RC=$?
-    if [ $RC -ne 0 ]
-	then
-		return $RC
-	fi
+	tst_resm TINFO "Test #1: mv <dir1> <dir2> will move dir1 to dir2 and" \
+		       "all its contents"
 
+	creat_dirnfiles 1 $numdirs $numfiles tst_mv.old
 
-	mv $LTPTMP/tst_mv.tmp $LTPTMP/tst_mv.tmp1 > $LTPTMP/tst_mv.err 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
-	then
-		$LTPBIN/tst_res TFAIL $LTPTMP/tst_mv.err \
-		"Test #1: mv failed, mv command  returned $RC. Reason:"
-		return $RC
+	mv tst_mv.old tst_mv.new > tst_mv.err 2>&1
+	if [ $? -ne 0 ]; then
+		cat tst_mv.err
+		tst_brkm TFAIL "Test #1: 'mv tst_mv.old tst_mv.new' failed"
 	fi
 
-	$LTPBIN/tst_resm TINFO "Test #1: creating output file"
-	ls -R $LTPTMP/tst_mv.tmp1 > $LTPTMP/tst_mv.out 2>&1
+	tst_resm TINFO "Test #1: creating output file"
+	ls -R tst_mv.new > tst_mv.out 2>&1
 
-	$LTPBIN/tst_resm TINFO "Test #1: creating expected output file"
-	creat_expout $numdirs $numfiles $LTPTMP/tst_mv.tmp1
+	tst_resm TINFO "Test #1: creating expected output file"
+	creat_expout $numdirs $numfiles tst_mv.new
 
-	$LTPBIN/tst_resm TINFO \
-	    "Test #1: comparing expected out and actual output file"
-	diff -w -B -q $LTPTMP/tst_mv.out $LTPTMP/tst_mv.exp > $LTPTMP/tst_mv.err 2>&1 \
-		|| RC=$?
-	if [ $RC -ne 0 ]
-	then
-		$LTPBIN/tst_res TFAIL $LTPTMP/tst_mv.err \
-			"Test #1: mv failed. Reason:"
+	tst_resm TINFO "Test #1: comparing expected out and actual output file"
+	diff -w -B -q tst_mv.out tst_mv.exp > tst_mv.err 2>&1
+	if [ $? -ne 0 ]; then
+		cat tst_mv.err
+		tst_resm TFAIL "Test #1: mv failed."
 	else
-		$LTPBIN/tst_resm TINFO "Test #1: expected same as actual"
-		if [ -f $LTPTMP/tst_mv.tmp ]
-		then
-			$LTPBIN/tst_resm TFAIL ""Test #1: mv did not delete old directory"
-			return $(($RC+1))
+		tst_resm TINFO "Test #1: expected same as actual"
+		if [ -f tst_mv.old ]; then
+			tst_resm TFAIL "Test #1: mv did not delete old" \
+				       "directory"
 		else
-			$LTPBIN/tst_resm TPASS "Test #1: mv success"
+			tst_resm TPASS "Test #1: mv success"
 		fi
 	fi
-	return $RC
 }
 
+setup
+TST_CLEANUP=cleanup
 
-# Function:		main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:			- zero on success
-# 				- non-zero on failure.
-
-
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
-RC=0				# Return code from tests.
-
-init || return $RC	# Exit if initializing testcases fails.
-
-test01 || RC=$?
-if [ $RC -ne 0 ]
-then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-
-rm -fr $LTPTMP/tst_mv.*
+test01
 
-exit $TFAILCNT
+tst_exit
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
