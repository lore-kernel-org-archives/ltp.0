Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1Vnn20-0005by-EO
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vnn1z-0001wC-Hm
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:40 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3AGWV7028178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:33 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3AGTDM026430
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:31 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 11:16:12 +0100
Message-Id: <1386065776-1961-2-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 1/5] ssh: unify code style amongst ssh tests
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

You can use ie. diff/vimdiff to easily verify the effect of this change.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/network/tcp_cmds/ssh/ssh01    | 12 ++++++-----
 testcases/network/tcp_cmds/ssh/ssh01_s1 | 37 +++++++++++++++++++--------------
 testcases/network/tcp_cmds/ssh/ssh02    |  1 -
 testcases/network/tcp_cmds/ssh/ssh02_s1 | 11 +++++-----
 testcases/network/tcp_cmds/ssh/ssh03    |  8 +++----
 testcases/network/tcp_cmds/ssh/ssh03_s1 | 11 +++++-----
 6 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
index 0337216..f8fe4d6 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01
+++ b/testcases/network/tcp_cmds/ssh/ssh01
@@ -32,16 +32,17 @@
 
 do_setup()
 {
-
     export RHOST="localhost"
     export TEST_USER="ssh_usr1"
-    export TEST_USER_PASSWD="eal"
+    export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
     export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
-    #erase user if he may exist , so we can have a clean env
+    # erase user if he/she already exists, so we can have a clean env
     TCtmp=/home/$TEST_USER
 
+    rm -Rf $TCtmp
+
     tst_setup
 
     exists expect ssh ssh01_s1 useradd userdel
@@ -60,7 +61,7 @@ do_setup()
     if ! mkdir -p "$TEST_USER_HOMEDIR"; then
         end_testcase "Failed to create $TEST_USER_HOMEDIR"
     fi
-    chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
+    chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
 
     trap do_cleanup EXIT
 
@@ -70,7 +71,8 @@ do_setup()
 # FUNCTION:  do_cleanup
 #-----------------------------------------------------------------------
 
-do_cleanup(){
+do_cleanup()
+{
     userdel $TEST_USER
     tst_cleanup
 }
diff --git a/testcases/network/tcp_cmds/ssh/ssh01_s1 b/testcases/network/tcp_cmds/ssh/ssh01_s1
index 244593b..e64bbf0 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh01_s1
@@ -21,7 +21,6 @@
 #  PURPOSE: Tests to see that ssh rejects an invalid password
 #
 #  SETUP: The program `/usr/bin/expect' MUST be installed.
-#         The PASSWD and RHOST variables MUST be set prior to execution.
 #
 #  HISTORY:
 #    03/03 Jerone Young (jeroney@us.ibm.com)
@@ -31,31 +30,37 @@ set RHOST $env(RHOST)
 set TEST_USER $env(TEST_USER)
 set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
 
+set RUSER $TEST_USER
+set PASSWD $TEST_USER_PASSWD
+
 set timeout 90
 
 #test invalid password
 
-send_user "SSH Test Invalid Password \n"
+send_user "TEST: SSH Test Invalid Password \n"
 
-set RUSER $TEST_USER
+# Set PASSWD to an invalid password
 set PASSWD "invalid_password!"
 
 spawn ssh -l $RUSER $RHOST whoami
 
 while 1 {
-	sleep 2
-	expect {
-
-		"Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
-                "assword:" {exp_send "$PASSWD\r"}
-		"Permission denied" {
-			send_user "SSH would not allow $RUSER to login with invalid password, Test Passed \n"
-			send_user "\nTEST_PASSED\n"
-			break
-		}
-	     "$RUSER" {send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n" ;exit 1}
-	}
-	sleep 1
+    sleep 2
+    expect {
+
+        "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
+        "assword:" {exp_send "$PASSWD\r"}
+        "Permission denied" {
+            send_user "SSH would not allow $RUSER to login with invalid password, Test Passed \n"
+            send_user "\nTEST_PASSED\n"
+            break
+        }
+        "$RUSER" {
+            send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n"
+            exit 1
+        }
+    }
+    sleep 1
 }
 
 exit 0
diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
index 00356e5..919e20d 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02
+++ b/testcases/network/tcp_cmds/ssh/ssh02
@@ -32,7 +32,6 @@
 
 do_setup()
 {
-
     export RHOST="localhost"
     export TEST_USER="ssh_usr2"
     export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
diff --git a/testcases/network/tcp_cmds/ssh/ssh02_s1 b/testcases/network/tcp_cmds/ssh/ssh02_s1
index b991141..724ef97 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh02_s1
@@ -32,6 +32,7 @@ set TEST_USER $env(TEST_USER)
 set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
 
 set RUSER $TEST_USER
+set PASSWD $TEST_USER_PASSWD
 
 set timeout 90
 
@@ -41,10 +42,8 @@ send_user "TEST: Test to see if ssh rejects Invalid User \n"
 
 # Set RUSER to an invalid user
 set RUSER "Invaild_User"
-set PASSWD $TEST_USER_PASSWD
 
-
-spawn ssh -l $RUSER $RHOST
+spawn ssh -l $RUSER $RHOST whoami
 
 while 1 {
     sleep 2
@@ -57,8 +56,10 @@ while 1 {
             send_user "\nTEST_PASSED\n"
             break
         }
-            "#" {send_user "SSH allowed $RUSER to login with invalid pass, Test
-Failed \n" ;exit 1}
+        "$RUSER" {
+            send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n"
+            exit 1
+        }
     }
     sleep 1
 }
diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
index ca9ce0e..fe5919c 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ b/testcases/network/tcp_cmds/ssh/ssh03
@@ -34,7 +34,7 @@ do_setup()
 {
     export RHOST="localhost"
     export TEST_USER="ssh_usr3"
-    export TEST_USER_PASSWD="eal"
+    export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
     export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
@@ -81,9 +81,9 @@ do_cleanup()
 # FUNCTION:  MAIN
 #
 # DESCRIPTION: Create Test User
-#              Call upon script to make sure an invalid user can not have access
-#              Cleanup Test User from system
-#              Exit with exit code of script called upon
+#          Call upon script to make sure a valid user can have access
+#          Cleanup Test User from system
+#          Exit with exit code of script called upon
 #-----------------------------------------------------------------------
 . net_cmdlib.sh
 
diff --git a/testcases/network/tcp_cmds/ssh/ssh03_s1 b/testcases/network/tcp_cmds/ssh/ssh03_s1
index 6d6c61a..9463a7f 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh03_s1
@@ -31,16 +31,14 @@ set TEST_USER $env(TEST_USER)
 set TEST_USER_PASSWD $env(TEST_USER_PASSWD)
 
 set RUSER $TEST_USER
+set PASSWD $TEST_USER_PASSWD
 
 set timeout 90
 
-#test invalid username
+#test valid username
 
 send_user "TEST: SSH allow (non-root) valid User \n"
 
-set RUSER $TEST_USER
-set PASSWD $TEST_USER_PASSWD
-
 
 spawn ssh -l $RUSER $RHOST whoami
 
@@ -54,7 +52,10 @@ while 1 {
             send_user "\nSSH would not allow $RUSER to login, Test FAILED \n"
             exit 1
         }
-        "$RUSER" {send_user "\nSSH allowed $RUSER to login, Test PASSED \n" ;break}
+        "$RUSER" {
+            send_user "SSH allowed $RUSER to login, Test PASSED \n"
+            break
+        }
     }
     sleep 1
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
