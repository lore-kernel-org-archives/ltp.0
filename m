Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1Vnn24-00012c-MG
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vnn23-00017x-OG
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:44 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3AGcfV002469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:38 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3AGTDQ026430
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:37 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 11:16:16 +0100
Message-Id: <1386065776-1961-6-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 5/5] ssh: don't use crypt-based pre-encrypted passwords
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

This change makes the ssh tests use passwd --stdin instead of
the -p argument to useradd, enabling the test to use the system-default
encryption algorithm defined in login.defs (ENCRYPT_METHOD), ensuring
greater compatibility.

Furthermore, the original hashes were wrong, at least for ssh01 and 02,
  'now_this_is_a_good_ltp_test_password' + salt '42' = 42lB8bQmUez4U
  'eal' + salt '42' = 42VmxaOByKwlA

The incorrect usage of now_this_is_a_good_ltp_test_password as PASSWD
with 42VmxaOByKwlA as ENCRYPTED_PASSWD in ssh0[12] dates back to 2004,
meaning those tests couldn't have failed (by a successful login) since
then (at least).

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/network/tcp_cmds/ssh/ssh01 | 6 +++---
 testcases/network/tcp_cmds/ssh/ssh02 | 6 +++---
 testcases/network/tcp_cmds/ssh/ssh03 | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
index 6abbf0d..a0c66f5 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01
+++ b/testcases/network/tcp_cmds/ssh/ssh01
@@ -35,7 +35,6 @@ do_setup()
     export RHOST="localhost"
     export TEST_USER="ssh_usr1"
     export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-    export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
     exists expect ssh ssh01_s1 useradd userdel
@@ -49,11 +48,12 @@ do_setup()
 
     tst_setup
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER \
-    -d "$TEST_USER_HOMEDIR"; then
+    if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
         end_testcase "Could not add test user $TEST_USER to system $RHOST."
     fi
 
+    echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
+
     # create users home diretory (SLES 8 does not do this, even when specified
     # in adduser)
     if [ ! -d "$TEST_USER_HOMEDIR" ]; then
diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
index d63e3ea..2d82acb 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02
+++ b/testcases/network/tcp_cmds/ssh/ssh02
@@ -35,7 +35,6 @@ do_setup()
     export RHOST="localhost"
     export TEST_USER="ssh_usr2"
     export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-    export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
     exists expect ssh ssh02_s1 useradd userdel
@@ -49,11 +48,12 @@ do_setup()
 
     tst_setup
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER \
-    -d "$TEST_USER_HOMEDIR"; then
+    if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
         end_testcase "Could not add test user $TEST_USER to system $RHOST."
     fi
 
+    echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
+
     # create users home diretory (SLES 8 does not do this, even when specified
     # in adduser)
     if [ ! -d "$TEST_USER_HOMEDIR" ]; then
diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
index ee89465..49b6527 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ b/testcases/network/tcp_cmds/ssh/ssh03
@@ -35,7 +35,6 @@ do_setup()
     export RHOST="localhost"
     export TEST_USER="ssh_usr3"
     export TEST_USER_PASSWD="now_this_is_a_good_ltp_test_password"
-    export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     export TEST_USER_HOMEDIR="/home/$TEST_USER"
 
     exists expect ssh ssh03_s1 useradd userdel
@@ -49,11 +48,12 @@ do_setup()
 
     tst_setup
 
-    if ! useradd -m -p $TEST_USER_ENCRYPTED_PASSWD $TEST_USER \
-    -d "$TEST_USER_HOMEDIR"; then
+    if ! useradd -m -d "$TEST_USER_HOMEDIR" $TEST_USER; then
         end_testcase "Could not add test user $TEST_USER to system $RHOST."
     fi
 
+    echo "$TEST_USER_PASSWD" | passwd --stdin $TEST_USER
+
     # create users home diretory (SLES 8 does not do this, even when specified
     # in adduser)
     if [ ! -d "$TEST_USER_HOMEDIR" ]; then
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
