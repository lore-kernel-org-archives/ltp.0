Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1Ypyau-0000Tm-8x
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 12:38:32 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ypyan-00017b-AH
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 12:38:32 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 6 May 2015 12:36:49 +0000
Message-ID: <1430915809-168531-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2] gzip/gzip01: Some cleanup
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
To: ltp-list@lists.sourceforge.net
Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com

* Delete some useless comments.
* Add 'TCID' and 'TST_TOTAL' global variables.
* Add test.sh.
* init() --> setup()
* Add cleanup().
* Add cleanup_test().
* Use 'tst_check_cmds' and 'tst_tmpdir'.
* Use 'ROD_SILENT'.
* Use 'tst_resm' and 'trs_brkm' instead of 'tst_res' and 'tst_brk'.
* Use 'local' to define the variables as they are in functions.
* Some cleanup.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/commands/gzip/gzip_tests.sh |  315 ++++++++++-----------------------
 1 files changed, 95 insertions(+), 220 deletions(-)

diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index 432f992..f541e47 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -2,6 +2,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2001                 ##
+## Author:       Manoj Iyer, manjo@mail.utexas.edu                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -19,313 +20,187 @@
 ##                                                                            ##
 ################################################################################
 #
-# File :        gzip_tests.sh
-#
 # Description:  Test basic functionality of gzip and gunzip command
-#				- Test #1:  Test that gzip -r will travel directories and
-#						    compress all the files available.
-#
-#				- Test #2:  Test that gunzip -r will travel directories and
-#						    uncompress all the files available.
-#
-# Author:       Manoj Iyer, manjo@mail.utexas.edu
-#
-# History:      Fed 06 2003 - Created - Manoj Iyer.
+#		- Test #1:  Test that gzip -r will travel directories and
+#			    compress all the files available.
 #
-# Function:		init
+#		- Test #2:  Test that gunzip -r will travel directories and
+#			    uncompress all the files available.
 #
-# Description:	- Check if command gunzip and gzip is available.
-#               - Create temprary directory, and temporary files.
-#               - Initialize environment variables.
-#
-# Return		- zero on success
-#               - non zero on failure. return value from commands ($RC)
-init()
+
+TCID=gzip
+TST_TOTAL=2
+. test.sh
+
+setup()
 {
+	tst_check_cmds gzip
 
-	RC=0				# Return code from commands.
-	export TST_TOTAL=1	# total numner of tests in this file.
-	export TCID=gzip    # this is the init function.
-	export TST_COUNT=0	# init identifier,
+	tst_check_cmds gunzip
 
-	if [ -z $TMP ]
-	then
-		LTPTMP=/tmp
-	else
-		LTPTMP=$TMP
-	fi
+	tst_tmpdir
 
+	tst_resm TINFO "INIT: Inititalizing tests"
 
-	tst_resm TINFO "INIT: Inititalizing tests."
-	if ! which gunzip > $LTPTMP/tst_gzip.err 2>&1
-	then
-		tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
-			"Test #1: gzip/gunzip command does not exist. Reason:"
-		return $RC
-	fi
+	ROD_SILENT mkdir -p tst_gzip.tmp
+}
 
-	mkdir -p $LTPTMP/tst_gzip.tmp > $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
-			"Test #1: failed creating temp directory. Reason:"
-		return $RC
-	fi
-	return $RC
+cleanup()
+{
+        tst_rmdir
+}
+
+cleanup_test()
+{
+	ROD_SILENT rm -rf tst_gzip.tmp/*
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
-	tst_resm TINFO "Test #$1: Creating $numdirs directories."
-	tst_resm TINFO "Test #$1: filling each dir with $numfiles files".
+	local numdirs=$2
+	local numfiles=$3
+	local dirname=$4
+	local dircnt=0
+	local fcnt=0
+
+	tst_resm TINFO "Test #$1: Creating $numdirs directories"
+	tst_resm TINFO "Test #$1: filling each dir with $numfiles files"
 	while [ $dircnt -lt $numdirs ]
 	do
 		dirname=$dirname/d.$dircnt
-        mkdir -p $dirname  > $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
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
-				tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
-				"Test #$1: while creating $numdirs dirs.  Reason"
-				return $RC
-			fi
+		while [ $fcnt -lt $numfiles ]
+        	do
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
-#               $4 - file extension (.gz for zipped file)
-#
-# Return		- zero on success
-#               - non zero on failure. return value ($RC) from commands
 creat_expout()
 {
-	numdir=$1	# number of directories to create
-	numfile=$2  # number of file to create in each directory
-	dirname=$3  # name of the base directory
-	ext=$4		# file extension (.gz for compressed files)
-    dircnt=0    # index into dir created in loop
-    fcnt=0      # index into files created in loop
-	RC=0        # return code from commands
-
-	echo "$dirname:"  1>$LTPTMP/tst_gzip.exp
-	echo "d.$dircnt"  1>>$LTPTMP/tst_gzip.exp
+	local numdir=$1
+	local numfile=$2
+	local dirname=$3
+	local ext=$4
+	local dircnt=0
+	local fcnt=0
+
+	echo "$dirname:"  1> tst_gzip.exp
+	echo "d.$dircnt"  1>> tst_gzip.exp
 	while [ $dircnt -lt $numdirs ]
 	do
 		dirname=$dirname/d.$dircnt
 		dircnt=$(($dircnt+1))
-		echo "$dirname:"  1>>$LTPTMP/tst_gzip.exp
+		echo "$dirname:"  1>> tst_gzip.exp
 		if [ $dircnt -lt $numdirs ]
 		then
-			echo "d.$dircnt"  1>>$LTPTMP/tst_gzip.exp
+			echo "d.$dircnt"  1>> tst_gzip.exp
 		fi
 		fcnt=0
-        while [ $fcnt -lt $numfiles ]
-        do
-			echo "f.$fcnt$ext " 1>>$LTPTMP/tst_gzip.exp
+		while [ $fcnt -lt $numfiles ]
+		do
+			echo "f.$fcnt$ext " 1>> tst_gzip.exp
 			fcnt=$(($fcnt+1))
 		done
-		printf "\n\n" 1>>$LTPTMP/tst_gzip.exp
+		printf "\n\n" 1>> tst_gzip.exp
 	done
 }
 
-# Function:		test01
-#
-# Description	- Test basic functionality of gzip and gunzip command
-#               - Test #1:  Test that gzip -r will travel directories and
-#                 compress all the files available.
-#               - create N directories and fill each with M files.
-#               - gzip -r dir1 > dir1.gz
-#               - guzip -r dir1.gz
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
-	export TCID=gzip01	# Name of the test case.
-	export TST_COUNT=1	# Test number.
 	numdirs=10
 	numfiles=10
 	dircnt=0
-    fcnt=0
+	fcnt=0
 
-	tst_resm TINFO \
-		"Test #1: gzip -r will recursively compress contents of directory"
+	tst_resm TINFO "Test #1: gzip -r will recursively compress contents" \
+			"of directory"
 
-	creat_dirnfiles 1 $numdirs $numfiles $LTPTMP/tst_gzip.tmp || RC=$?
-    if [ $RC -ne 0 ]
-	then
-		return $RC
-	fi
+	creat_dirnfiles 1 $numdirs $numfiles tst_gzip.tmp
 
-	gzip -r $LTPTMP/tst_gzip.tmp > $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
+	gzip -r tst_gzip.tmp > tst_gzip.err 2>&1
+	if [ $? -ne 0 ]
 	then
-		tst_res TFAIL $LTPTMP/tst_gzip.err "Test #1: gzip -r failed. Reason:"
-		return $RC
+		cat tst_gzip.err
+		tst_brkm TFAIL "Test #1: gzip -r failed"
 	fi
 
 	tst_resm TINFO "Test #1: creating output file"
-	ls -R $LTPTMP/tst_gzip.tmp > $LTPTMP/tst_gzip.out 2>&1
+	ls -R tst_gzip.tmp > tst_gzip.out 2>&1
 
 	tst_resm TINFO "Test #1: creating expected output file"
-	creat_expout $numdirs $numfiles $LTPTMP/tst_gzip.tmp .gz
+	creat_expout $numdirs $numfiles tst_gzip.tmp .gz
 
-	tst_resm TINFO "Test #1: comparing expected out and actual output file"
-	diff -w -B $LTPTMP/tst_gzip.out $LTPTMP/tst_gzip.exp \
-		> $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
+	tst_resm TINFO "Test #1: comparing expected out and actual" \
+			"output file"
+	diff -w -B tst_gzip.out tst_gzip.exp > tst_gzip.err 2>&1
+	if [ $? -ne 0 ]
 	then
-		tst_res TFAIL $LTPTMP/tst_gzip.err "Test #1: gzip failed. Reason:"
+		cat tst_gzip.err
+		tst_resm TFAIL "Test #1: gzip failed"
 	else
 		tst_resm TINFO "Test #1: expected same as actual"
 		tst_resm TPASS "Test #1: gzip -r success"
 	fi
-	return $RC
 }
 
-
-# Function:		test02
-#
-# Description	- Test basic functionality of gzip and gunzip command
-#               - Test #2:  Test that gunzip -r will travel directories and
-#                 uncompress all the files available.
-#               - create N directories and fill each with M files.
-#               - gzip -r dir
-#               - guzip -r dir
-#               - list contents of dir and save it to file - actual output
-#               - create expected output
-#               - compare expected output with actual output.
-#
-# Return		- zero on success
-#               - non zero on failure. return value from commands ($RC)
-
 test02()
 {
-	RC=0					# Return value from commands.
-	export TCID=gunzip01	# Name of the test case.
-	export TST_COUNT=1		# Test number.
 	numdirs=10
 	numfiles=10
 	dircnt=0
-    fcnt=0
+	fcnt=0
 
-	tst_resm TINFO \
-		"Test #2: gunzip -r will recursively uncompress contents of directory"
+	tst_resm TINFO "Test #2: gunzip -r will recursively uncompress" \
+			"contents of directory"
 
-	creat_dirnfiles 2 $numdirs $numfiles $LTPTMP/tst_gzip.tmp || RC=$?
-    if [ $RC -ne 0 ]
-	then
-		return $RC
-	fi
+	creat_dirnfiles 2 $numdirs $numfiles tst_gzip.tmp
 
-	gzip -r $LTPTMP/tst_gzip.tmp > $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
+	gzip -r tst_gzip.tmp > tst_gzip.err 2>&1
+	if [ $? -ne 0 ]
 	then
-		tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
-		"Test #2: compressing directory $LTPTMP/tst_gzip.tmp failed.  Reason"
-		return $RC
+		cat tst_gzip.err
+		tst_brkm TBROK "Test #2: compressing directory tst_gzip.tmp" \
+				"failed"
 	fi
 
-	gunzip -r $LTPTMP/tst_gzip.tmp > $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
+	gunzip -r tst_gzip.tmp > tst_gzip.err 2>&1
+    	if [ $? -ne 0 ]
 	then
-		tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
-		"Test #2: uncompressing directory $LTPTMP/tst_gzip.tmp failed.  Reason"
+		cat tst_gzip.err
+		tst_brkm TBROK "Test #2: uncompressing directory" \
+				" tst_gzip.tmp failed"
 		return $RC
 	fi
 
 	tst_resm TINFO "Test #2: creating output file"
-	ls -R $LTPTMP/tst_gzip.tmp > $LTPTMP/tst_gzip.out 2>&1
+	ls -R tst_gzip.tmp > tst_gzip.out 2>&1
 
 	tst_resm TINFO "Test #2: creating expected output file"
-	creat_expout $numdirs $numfiles $LTPTMP/tst_gzip.tmp
+	creat_expout $numdirs $numfiles tst_gzip.tmp
 
 	tst_resm TINFO "Test #2: comparing expected out and actual output file"
-	diff -w -B $LTPTMP/tst_gzip.out $LTPTMP/tst_gzip.exp \
-		> $LTPTMP/tst_gzip.err 2>&1 || RC=$?
-	if [ $RC -ne 0 ]
+	diff -w -B tst_gzip.out tst_gzip.exp > tst_gzip.err 2>&1
+	if [ $? -ne 0 ]
 	then
-		tst_res TFAIL $LTPTMP/tst_gzip.err "Test #2: gunzip failed. Reason:"
+		cat tst_gzip.err
+		tst_resm TFAIL "Test #2: gunzip failed"
 	else
 		tst_resm TINFO "Test #2: expected same as actual"
 		tst_resm TPASS "Test #2: gunzip -r success"
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
-rm -fr $LTPTMP/tst_gzip.*
-
-init || return $RC	# Exit if initializing testcases fails.
-
-test02 || RC=$?
-if [ $RC -ne 0 ]
-then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
+test01
+cleanup_test
 
-rm -fr $LTPTMP/tst_gzip.*
+test02
 
-exit $TFAILCNT
+tst_exit
-- 
1.6.0.2


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
