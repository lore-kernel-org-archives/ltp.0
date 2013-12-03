Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1Vnn23-0007SM-PS
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vnn23-0001pX-2s
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:43 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3AGacM015833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:36 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3AGTDP026430
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:35 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 11:16:15 +0100
Message-Id: <1386065776-1961-5-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 4/5] ssh: try to prevent invalid PASS when remote cmd
	fails
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

This change does not guarantee elimination of false PASS results,
but it makes them somewhat less likely to occur by matching sshd-like
Permission denied line. The regexp doesn't use ^ or $ or any kind of
more precise matching due to numerous problems with `expect' handling
the more complicated regexp strings across versions.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/network/tcp_cmds/ssh/ssh01_s1 | 6 +++---
 testcases/network/tcp_cmds/ssh/ssh02_s1 | 6 +++---
 testcases/network/tcp_cmds/ssh/ssh03_s1 | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/network/tcp_cmds/ssh/ssh01_s1 b/testcases/network/tcp_cmds/ssh/ssh01_s1
index e64bbf0..c1cc127 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh01_s1
@@ -50,10 +50,10 @@ while 1 {
 
         "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
         "assword:" {exp_send "$PASSWD\r"}
-        "Permission denied" {
+        -re "Permission denied (.*)\." {
             send_user "SSH would not allow $RUSER to login with invalid password, Test Passed \n"
             send_user "\nTEST_PASSED\n"
-            break
+            exit 0
         }
         "$RUSER" {
             send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n"
@@ -63,4 +63,4 @@ while 1 {
     sleep 1
 }
 
-exit 0
+exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh02_s1 b/testcases/network/tcp_cmds/ssh/ssh02_s1
index 724ef97..d49e1e9 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh02_s1
@@ -51,10 +51,10 @@ while 1 {
 
         "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
         "assword:" {exp_send "$PASSWD\r"}
-        "Permission denied" {
+        -re "Permission denied (.*)\." {
             send_user "SSH would not allow $RUSER to login with invalid password, Test Passed \n"
             send_user "\nTEST_PASSED\n"
-            break
+            exit 0
         }
         "$RUSER" {
             send_user "SSH allowed $RUSER to login with invalid pass, Test Failed \n"
@@ -64,4 +64,4 @@ while 1 {
     sleep 1
 }
 
-exit 0
+exit 1
diff --git a/testcases/network/tcp_cmds/ssh/ssh03_s1 b/testcases/network/tcp_cmds/ssh/ssh03_s1
index 9463a7f..bf6aada 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03_s1
+++ b/testcases/network/tcp_cmds/ssh/ssh03_s1
@@ -48,16 +48,16 @@ while 1 {
 
         "Are you sure you want to continue connecting (yes/no)?" { exp_send "yes\r"}
         "assword:" {exp_send "$PASSWD\r"}
-        "Permission denied" {
+        -re "Permission denied (.*)\." {
             send_user "\nSSH would not allow $RUSER to login, Test FAILED \n"
             exit 1
         }
         "$RUSER" {
             send_user "SSH allowed $RUSER to login, Test PASSED \n"
-            break
+            exit 0
         }
     }
     sleep 1
 }
 
-exit 0
+exit 1
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
