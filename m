Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3w-0002ka-SJ
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:24 +0000
Received: from mail-la0-f48.google.com ([209.85.215.48])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3v-00077A-Vw
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:24 +0000
Received: by mail-la0-f48.google.com with SMTP id hi8so2357684lab.35
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:58 +0200
Message-Id: <1375729379-16469-6-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
References: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 5/6] realtime: only build tests if needed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

stand alone run scripts can not build from the installed directory.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/realtime/run.sh                 |   16 ++++++++++------
 testcases/realtime/scripts/run_c_files.sh |    7 +++++--
 testscripts/test_realtime.sh              |   16 ++++++++++------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/testcases/realtime/run.sh b/testcases/realtime/run.sh
index 77e8d68..a66e4e5 100755
--- a/testcases/realtime/run.sh
+++ b/testcases/realtime/run.sh
@@ -185,12 +185,16 @@ if [ $# -lt 1 ]; then
 fi
 pushd $TESTS_DIR >/dev/null
 
-#Only build the library, most of the tests depend upon.
-#The Individual tests will be built, just before they run.
-pushd lib
-make
-check_error make
-popd
+# if INSTALL_DIR != top_srcdir assume the individual tests are built and installed.
+# So no need to build lib
+if [[ -d lib ]]; then
+    #Only build the library, most of the tests depend upon.
+    #The Individual tests will be built, just before they run.
+    pushd lib
+    make
+    check_error make
+    popd
+fi
 
 ISLOOP=0
 index=0
diff --git a/testcases/realtime/scripts/run_c_files.sh b/testcases/realtime/scripts/run_c_files.sh
index 3ab52ec..6e73f38 100755
--- a/testcases/realtime/scripts/run_c_files.sh
+++ b/testcases/realtime/scripts/run_c_files.sh
@@ -20,8 +20,11 @@ profile_path=$PROFILES_DIR/$profile
 # Does profile exist?
 [ ! -f "$profile_path" ] && { echo >&2 "$0: Could not find profile ($profile_path)" ; exit 1 ; }
 
-# Compile the test cases to support stand alone runs.
-make
+# if INSTALL_DIR != top_srcdir assume the individual tests are built and installed.
+if [[ -f Makefile ]]; then
+    # Compile the test cases to support stand alone runs.
+    make
+fi
 
 
 # Run the test case
diff --git a/testscripts/test_realtime.sh b/testscripts/test_realtime.sh
index 22c3692..ad5075f 100755
--- a/testscripts/test_realtime.sh
+++ b/testscripts/test_realtime.sh
@@ -176,12 +176,16 @@ if [ ! -e "logs" ]; then
         chmod -R 775 logs
 fi
 
-#Only build the library, most of the tests depend upon.
-#The Individual tests will be built, just before they run.
-pushd lib
-make
-check_error make
-popd
+# if INSTALL_DIR != top_srcdir assume the individual tests are built and installed.
+# So no need to build lib
+if [[ -d lib ]]; then
+    #Only build the library, most of the tests depend upon.
+    #The Individual tests will be built, just before they run.
+    pushd lib
+    make
+    check_error make
+    popd
+fi
 
 ISLOOP=0
 index=0
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
