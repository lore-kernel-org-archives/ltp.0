Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkApQ-0005yn-5s
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:11:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkApO-00037d-QS
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:11:24 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8BHLD018887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:11:17 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p6M8BBB1009146
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:11:12 -0400
Message-ID: <4E29309F.2050307@redhat.com>
Date: Fri, 22 Jul 2011 10:11:11 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050502090809010100070207"
Subject: [LTP] [PATCH 6/6 v3] cgroups/cgroup_regression_test: fix test_*.sh
 trap in loop
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050502090809010100070207
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


test_*.sh scripts use trap in tight loop, which may cause bash
to miss signal, see:
https://bugzilla.redhat.com/show_bug.cgi?id=695656

Move trap outside loop to avoid it.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
   testcases/kernel/controllers/cgroup/test_10_1.sh |    3 +--
   testcases/kernel/controllers/cgroup/test_10_2.sh |    3 +--
   testcases/kernel/controllers/cgroup/test_3_1.sh  |    3 +--
   testcases/kernel/controllers/cgroup/test_3_2.sh  |    3 +--
   testcases/kernel/controllers/cgroup/test_6_1.sh  |    3 +--
   testcases/kernel/controllers/cgroup/test_9_1.sh  |    3 +--
   testcases/kernel/controllers/cgroup/test_9_2.sh  |    3 +--
   7 files changed, 7 insertions(+), 14 deletions(-)




--------------050502090809010100070207
Content-Type: text/x-patch;
	name="0006-cgroups-cgroup_regression_test-fix-test_-.sh-trap-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0006-cgroups-cgroup_regression_test-fix-test_-.sh-trap-in.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cgroup/test_10_1.sh b/testcases/kernel/controllers/cgroup/test_10_1.sh
index 6284722..ffa0d5f 100755
--- a/testcases/kernel/controllers/cgroup/test_10_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_10_1.sh
@@ -22,13 +22,12 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	mkdir cgroup/0 > /dev/null 2>&1
 	rmdir cgroup/0 > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_10_2.sh b/testcases/kernel/controllers/cgroup/test_10_2.sh
index 82b91e3..f811bbd 100755
--- a/testcases/kernel/controllers/cgroup/test_10_2.sh
+++ b/testcases/kernel/controllers/cgroup/test_10_2.sh
@@ -22,11 +22,10 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_3_1.sh b/testcases/kernel/controllers/cgroup/test_3_1.sh
index 86627d4..507a2c4 100755
--- a/testcases/kernel/controllers/cgroup/test_3_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_3_1.sh
@@ -22,11 +22,10 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mkdir cgroup/0
 	rmdir cgroup/0
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_3_2.sh b/testcases/kernel/controllers/cgroup/test_3_2.sh
index c942969..9f83d9d 100755
--- a/testcases/kernel/controllers/cgroup/test_3_2.sh
+++ b/testcases/kernel/controllers/cgroup/test_3_2.sh
@@ -22,10 +22,9 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	cat /proc/sched_debug > /dev/null
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_6_1.sh b/testcases/kernel/controllers/cgroup/test_6_1.sh
index ff70677..e91e794 100755
--- a/testcases/kernel/controllers/cgroup/test_6_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_6_1.sh
@@ -22,12 +22,11 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
 	rmdir cgroup/[1-9]* > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_9_1.sh b/testcases/kernel/controllers/cgroup/test_9_1.sh
index 24a1524..c6e8f6f 100755
--- a/testcases/kernel/controllers/cgroup/test_9_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_9_1.sh
@@ -22,13 +22,12 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 #	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	cat cgroup/release_agent > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_9_2.sh b/testcases/kernel/controllers/cgroup/test_9_2.sh
index 654df4d..f8e1c61 100755
--- a/testcases/kernel/controllers/cgroup/test_9_2.sh
+++ b/testcases/kernel/controllers/cgroup/test_9_2.sh
@@ -22,12 +22,11 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 #	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 



--------------050502090809010100070207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
10 Tips for Better Web Security
Learn 10 ways to better secure your business today. Topics covered include:
Web security, SSL, hacker attacks & Denial of Service (DoS), private keys,
security Microsoft Exchange, secure Instant Messaging, and much more.
http://www.accelacomm.com/jaw/sfnl/114/51426210/
--------------050502090809010100070207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050502090809010100070207--

