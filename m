Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RnuiC-0003FD-Mu
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 16:19:40 +0000
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnuiB-0002xB-Br
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 16:19:40 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Thu, 19 Jan 2012 17:19:19 +0100
Message-Id: <1326989959-24434-1-git-send-email-carmelo.amoroso@st.com>
Subject: [LTP] [PATCH] mount1234: invert the logic in handling failures
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
To: ltp-list@lists.sf.net

From: Francesco Rundo <francesco.rundo@st.com>

mount is expected to fail if the device is a 'tty', so it seems that
the original idea of this testcase were to test mount failures.
If this is true, then the logic to handle the test results has to be inverted
and consider the test case as PASSED if mount fails, while FAILED
if mount erroneuosly succeeded to mount a tty device.

It also fixes a syntax error in substring expansion ( ${parameter:offset} )

The last check "mount04" has been removed as it does not cehck the device type
but only the permission so that it is incosistent with the overall logic.

That said, rename the test case as mount123

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 runtest/syscalls                           |    2 +-
 testcases/kernel/syscalls/mount/test_mount |   43 ++++++---------------------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 4aac38c..96e3690 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -575,7 +575,7 @@ mount02 mount02 -D DEVICE -T DEVICE_FS_TYPE
 mount03 mount03 -D DEVICE -T DEVICE_FS_TYPE
 mount04 mount04 -D DEVICE -T DEVICE_FS_TYPE
 
-mount1234 test_mount
+mount123 test_mount
 
 move_pages01 move_pages.sh 01
 move_pages02 move_pages.sh 02
diff --git a/testcases/kernel/syscalls/mount/test_mount b/testcases/kernel/syscalls/mount/test_mount
index 855d417..dee8f3b 100755
--- a/testcases/kernel/syscalls/mount/test_mount
+++ b/testcases/kernel/syscalls/mount/test_mount
@@ -19,18 +19,13 @@
 ##                                                                            ##
 ################################################################################
 
-export TCID=mount1234
+export TCID=mount123
 export TST_TOTAL=2
 export TST_COUNT=0
 
-# 1. variables cannot be set from external processes, so tst_exit will always
-# pass
-# 2. I have no idea why this script is passing in /dev/tty* to the mount tests.
-tst_resm TBROK "THIS TEST IS BROKEN"
-
 for tttype in `ls /dev/tty*`
 do
-device_no="${tttype}:8"
+device_no="${tttype:8}"
 case "$device_no" in
 [0-9]|[0-9][0-9])
     tst_resm TINFO "Testing mount01 with $tttype"
@@ -38,9 +33,9 @@ case "$device_no" in
     RC=$?
     if  [ $RC -eq 0 ]
     then
-     tst_resm TPASS "mount01 Passed with $tttype"
+     tst_resm TFAIL "got unexpected result: mount01 passed with $tttype"
     else
-     tst_resm TFAIL "mount01 Failed with $tttype"
+     tst_resm TPASS "got expected result: mount01 failed with $tttype"
     fi
 echo;;
 esac
@@ -49,7 +44,7 @@ done
 
 for tttype in `ls /dev/tty*`
 do
-device_no="${tttype}:8"
+device_no="${tttype:8}"
 case "$device_no" in
 [0-9]|[0-9][0-9])
     tst_resm TINFO "Testing mount02 with $tttype"
@@ -57,9 +52,9 @@ case "$device_no" in
     RC=$?
     if  [ $RC -eq 0 ]
     then
-     tst_resm TPASS "mount02 Passed with $tttype"
+     tst_resm TFAIL "got unexpected result: mount02 passed with $tttype"
     else
-     tst_resm TFAIL "mount02 Failed with $tttype"
+     tst_resm TPASS "got expected result: mount02 failed with $tttype"
     fi
 echo;;
 esac
@@ -67,7 +62,7 @@ done
 
 for tttype in `ls /dev/tty*`
 do
-device_no="${tttype}:8"
+device_no="${tttype:8}"
 case "$device_no" in
 [0-9]|[0-9][0-9])
     tst_resm TINFO "Testing mount03 with $tttype"
@@ -75,27 +70,9 @@ case "$device_no" in
     RC=$?
     if  [ $RC -eq 0 ]
     then
-     tst_resm TPASS "mount03 Passed with $tttype"
-    else
-     tst_resm TFAIL "mount03 Failed with $tttype"
-    fi
-echo;;
-esac
-done
-
-for tttype in `ls /dev/tty*`
-do
-device_no="${tttype}:8"
-case "$device_no" in
-[0-9]|[0-9][0-9])
-    tst_resm TINFO "Testing mount04 with $tttype"
-    mount04 -D $tttype
-    RC=$?
-    if  [ $RC -eq 0 ]
-    then
-     tst_resm TPASS "mount04 Passed with $tttype"
+     tst_resm TFAIL "got unexpected result: mount03 passed with $tttype"
     else
-     tst_resm TFAIL "mount04 Failed with $tttype"
+     tst_resm TPASS "got expected result: mount03 failed with $tttype"
     fi
 echo;;
 esac
-- 
1.7.4.4


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
