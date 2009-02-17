Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIY1S-0003ba-5V
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:08:34 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIY1M-0000j6-Jx
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:08:34 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 635FC100C624A
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 03:07:48 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MIY0i-00040S-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 03:07:48 +0200
Date: Tue, 17 Feb 2009 23:58:46 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwivro7cfnueu@debian>
Subject: [LTP] [PATCH] Fixes of the tcore test
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090217225846.DhRVhOG9_4rWhEGsyOmpo6793_FRXCaFMIrmyKkSF0w@z>

Hello,

these are little fixes of the tcore.sh script

 - use $BIN_DIR for auxiliary files, and $TEST_DIR as temporary
   directory
 - don't run "cd -" if previous "cd something" failed
 - fixup the value of core_pattern, to replace possibly customized
   patterns using absolute paths or not using the name "core" for
   corefiles
 - don't hide error messages from expect

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/misc/tcore_patch_test_suites/tcore.sh |   39 ++++++++++++++++-------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/testcases/misc/tcore_patch_test_suites/tcore.sh b/testcases/misc/tcore_patch_test_suites/tcore.sh
index d210fa5..f087fa7 100755
--- a/testcases/misc/tcore_patch_test_suites/tcore.sh
+++ b/testcases/misc/tcore_patch_test_suites/tcore.sh
@@ -19,7 +19,8 @@
 # Test suite for the t-core kernel patch 
 export TCID=tcore01
 PTHREAD_DIR="/lib/i686"
-TEST_DIR="."
+BIN_DIR=$LTPROOT/testcases/bin/
+TEST_DIR=$(mktemp -dt)
 OSTYPE="redhat"
 # Do some preparation to generate the correct core dump
 # files
@@ -42,6 +43,14 @@ os_check()
 	fi
 }
 
+cleanup()
+{
+		rm -rf $TEST_DIR
+		[ -f /proc/sys/kernel/core_dumps_threads ] && ! [ -z "$OLD_PATTERN" ] && 
+		echo "$OLD_PATTERN" > /proc/sys/kernel/core_dumps_threads
+		exit $1
+}
+
 prepare_dump()
 {
 	ulimit -c 20000000 >/dev/null 2>&1
@@ -52,18 +61,23 @@ prepare_dump()
 			echo "1">/proc/sys/kernel/core_dumps_threads
 		fi
 	fi
+	if [ -f /proc/sys/kernel/core_pattern ]; then
+			OLD_PATTERN=$(cat /proc/sys/kernel/core_pattern)
+			echo 'core.%p' > /proc/sys/kernel/core_pattern
+	fi
 	#Recover the lipthread.so.0 lib to generate the correct
 	#core dump file
 	os_check
 	if [ $OSTYPE = "redhat" ];then
-		cd $PTHREAD_DIR
-		if [ -f libpthread.so.0.orig ];then
-			test=`ls -l libpthread.so.0.orig|awk '{print $11}'`
-			if [ $test = "libpthread-0.9.so"  ];then
-				mv libpthread.so.0.orig libpthread.so.0
+		cd $PTHREAD_DIR && {
+			if [ -f libpthread.so.0.orig ];then
+				test=`ls -l libpthread.so.0.orig|awk '{print $11}'`
+					if [ $test = "libpthread-0.9.so"  ];then
+						mv libpthread.so.0.orig libpthread.so.0
+					fi
 			fi
-		fi
-		cd -
+			cd -
+		}
 	fi
 }
 #Prepare for the gdb dump 
@@ -71,7 +85,7 @@ prepare_gdb()
 {
 	os_check
 	if [ $OSTYPE = "redhat" ];then
-		cd $PTHREAD_DIR
+		cd $PTHREAD_DIR && {
 		if [ -f libpthread.so.0 ];then
 			test=`ls -l libpthread.so.0|awk '{print $11}'`
 			if [ $test = "libpthread-0.9.so"  ];then
@@ -80,6 +94,7 @@ prepare_gdb()
 		fi
 		ln -s /lib/libpthread.so.0 libpthread.so.0 >/dev/null 2>&1
 		cd -
+    }
 	fi
 }
 #Test whether the system can generate the needed core files
@@ -91,7 +106,7 @@ Test_gen_core()
 	if [ -f core.* ];then
 		rm -f core.*
 	fi
-	pid=`$TEST_DIR/tcore |grep "consumer pid"|awk '{print $2}'|cut -d = -f 2`
+	pid=`$BIN_DIR/tcore |grep "consumer pid"|awk '{print $2}'|cut -d = -f 2`
 	echo -e "Test whether we can generate the needed core file"
 	if [ -f core.* ];then
 		echo -e "PASS"
@@ -110,7 +125,7 @@ Test_core_file()
 	prepare_gdb
 	mv -f $TEST_DIR/core.* $TEST_DIR/corefile >/dev/null 2>&1
 	echo -e "Test whether the core support bt,fpu and threads commands "
-	expect ./tcore.exp >/dev/null 2>&1
+	expect $BIN_DIR/tcore.exp
 	return=$?
 	pass=`expr $pass + $return`
 	fail=`expr 3 - $return + $fail`
@@ -123,7 +138,7 @@ Test_core_file
 echo "Linux Tcore test results" > results
 echo "Total pass fail" >>  results
 echo "  5	$pass	$fail" >> results
-exit $fail 
+cleanup $fail 
 
 	
 	
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
