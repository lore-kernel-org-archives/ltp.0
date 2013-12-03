Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1Vnn22-0005M6-LU
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vnn21-00017i-LW
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:42 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3AGZFA022590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:35 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3AGTDO026430
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:34 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 11:16:14 +0100
Message-Id: <1386065776-1961-4-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 3/5] ssh: properly create/remove user home dir,
	if possible
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

(this change is identical across ssh01, ssh02, ssh03)

The main motivation is that "mkdir /home/userdir" is not sufficient
to ensure that a user can access that directory. mkdir does not account
for security labels (ie. SELinux), umask of the calling shell and
possibly other variables.
This change fixes the following error, which can be triggered in some
RHEL configurations using SELinux MLS policy:

  Could not chdir to home directory /home/ssh_usr3: Permission denied
  bash: /home/ssh_usr3/.bashrc: Permission denied

and even though ssh01 and ssh02 tests PASS successfully, they would not
reveal a possible TFAIL (user is able to login) due to the chdir/bash
fails shown above - both tests would falsely PASS in a scenario where
ssh login was successful, matching ssh-unrelated "Permission denied".
This is not yet fixed.

The mkdir of home dir was actually happening in tst_setup, a quick fix
(workaround) - instead of this slightly more invasive rewrite - could
therefore be as simple as doing `rm -Rf' directly on /home/$TEST_USER
and not setting TCtmp, letting useradd -m create the homedir.

The do_cleanup trap has been moved up to perform userdel in case
something in do_setup fails.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/network/tcp_cmds/ssh/ssh01 | 36 ++++++++++++++++++------------------
 testcases/network/tcp_cmds/ssh/ssh02 | 36 ++++++++++++++++++------------------
 testcases/network/tcp_cmds/ssh/ssh03 | 36 ++++++++++++++++++------------------
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
index f8fe4d6..6abbf0d 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01
+++ b/testcases/network/tcp_cmds/ssh/ssh01
@@ -38,33 +38,32 @@ do_setup()
     export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
-    # erase user if he/she already exists, so we can have a clean env
-    TCtmp=/home/$TEST_USER
-
-    rm -Rf $TCtmp
-
-    tst_setup
-
     exists expect ssh ssh01_s1 useradd userdel
 
-    userdel $TEST_USER
+    trap do_cleanup EXIT
+
+    # erase user if he/she already exists, so we can have a clean env
+    userdel -r $TEST_USER
+    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
     sleep 1
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
+    tst_setup
+
+    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER \
+    -d "$TEST_USER_HOMEDIR"; then
         end_testcase "Could not add test user $TEST_USER to system $RHOST."
     fi
 
     # create users home diretory (SLES 8 does not do this, even when specified
     # in adduser)
-    USER_UID=$(id -u $TEST_USER)
-    USER_GID=$(id -g $TEST_USER)
-    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-        end_testcase "Failed to create $TEST_USER_HOMEDIR"
+    if [ ! -d "$TEST_USER_HOMEDIR" ]; then
+        USER_UID=$(id -u $TEST_USER)
+        USER_GID=$(id -g $TEST_USER)
+        if ! mkdir -p "$TEST_USER_HOMEDIR"; then
+            end_testcase "Failed to create $TEST_USER_HOMEDIR"
+        fi
+        chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
     fi
-    chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-
-    trap do_cleanup EXIT
-
 }
 
 #-----------------------------------------------------------------------
@@ -73,7 +72,8 @@ do_setup()
 
 do_cleanup()
 {
-    userdel $TEST_USER
+    userdel -r $TEST_USER
+    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
     tst_cleanup
 }
 
diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
index 919e20d..d63e3ea 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02
+++ b/testcases/network/tcp_cmds/ssh/ssh02
@@ -38,33 +38,32 @@ do_setup()
     export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
-    # erase user if he/she already exists, so we can have a clean env
-    TCtmp=/home/$TEST_USER
-
-    rm -Rf $TCtmp
-
-    tst_setup
-
     exists expect ssh ssh02_s1 useradd userdel
 
-    userdel $TEST_USER
+    trap do_cleanup EXIT
+
+    # erase user if he/she already exists, so we can have a clean env
+    userdel -r $TEST_USER
+    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
     sleep 1
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
+    tst_setup
+
+    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER \
+    -d "$TEST_USER_HOMEDIR"; then
         end_testcase "Could not add test user $TEST_USER to system $RHOST."
     fi
 
     # create users home diretory (SLES 8 does not do this, even when specified
     # in adduser)
-    USER_UID=$(id -u $TEST_USER)
-    USER_GID=$(id -g $TEST_USER)
-    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-        end_testcase "Failed to create $TEST_USER_HOMEDIR"
+    if [ ! -d "$TEST_USER_HOMEDIR" ]; then
+        USER_UID=$(id -u $TEST_USER)
+        USER_GID=$(id -g $TEST_USER)
+        if ! mkdir -p "$TEST_USER_HOMEDIR"; then
+            end_testcase "Failed to create $TEST_USER_HOMEDIR"
+        fi
+        chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
     fi
-    chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-
-    trap do_cleanup EXIT
-
 }
 
 #-----------------------------------------------------------------------
@@ -73,7 +72,8 @@ do_setup()
 
 do_cleanup()
 {
-    userdel $TEST_USER
+    userdel -r $TEST_USER
+    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
     tst_cleanup
 }
 
diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
index fe5919c..ee89465 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ b/testcases/network/tcp_cmds/ssh/ssh03
@@ -38,33 +38,32 @@ do_setup()
     export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
-    # erase user if he/she already exists, so we can have a clean env
-    TCtmp=/home/$TEST_USER
-
-    rm -Rf $TCtmp
-
-    tst_setup
-
     exists expect ssh ssh03_s1 useradd userdel
 
-    userdel $TEST_USER
+    trap do_cleanup EXIT
+
+    # erase user if he/she already exists, so we can have a clean env
+    userdel -r $TEST_USER
+    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
     sleep 1
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER; then
+    tst_setup
+
+    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER \
+    -d "$TEST_USER_HOMEDIR"; then
         end_testcase "Could not add test user $TEST_USER to system $RHOST."
     fi
 
     # create users home diretory (SLES 8 does not do this, even when specified
     # in adduser)
-    USER_UID=$(id -u $TEST_USER)
-    USER_GID=$(id -g $TEST_USER)
-    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
-        end_testcase "Failed to create $TEST_USER_HOMEDIR"
+    if [ ! -d "$TEST_USER_HOMEDIR" ]; then
+        USER_UID=$(id -u $TEST_USER)
+        USER_GID=$(id -g $TEST_USER)
+        if ! mkdir -p "$TEST_USER_HOMEDIR"; then
+            end_testcase "Failed to create $TEST_USER_HOMEDIR"
+        fi
+        chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
     fi
-    chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-
-    trap do_cleanup EXIT
-
 }
 
 #-----------------------------------------------------------------------
@@ -73,7 +72,8 @@ do_setup()
 
 do_cleanup()
 {
-    userdel $TEST_USER
+    userdel -r $TEST_USER
+    [ -d "$TEST_USER_HOMEDIR" ] && rm -rf "$TEST_USER_HOMEDIR"
     tst_cleanup
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
