Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1Vkpxg-0005u2-Bx
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 06:48:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vkpxe-00067k-ED
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 06:48:00 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rAP6lqot006639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 25 Nov 2013 01:47:52 -0500
From: Monson Shao <jshao@redhat.com>
Date: Mon, 25 Nov 2013 14:47:21 +0800
Message-Id: <1385362041-17578-1-git-send-email-jshao@redhat.com>
Subject: [LTP] [PATCH] netns: remove accumulated errmesg assignment
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

Valuable $errmesg wasn't initialized at beginning, when bash option
"nounset" is set, statement like errmesg="$errmesg XXXXXX" will cause
bash unbound variable error.

Furthermore, $errmesg will be echoed every time it is assigned, so
there is no need for accumulated assignment.

Signed-off-by: Monson Shao <jshao@redhat.com>
---
 testcases/kernel/containers/netns/runnetnstest.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
index fb494a2..f7bf80f 100755
--- a/testcases/kernel/containers/netns/runnetnstest.sh
+++ b/testcases/kernel/containers/netns/runnetnstest.sh
@@ -60,7 +60,7 @@ two_children_ns
 rc=$?
 if [ $rc -ne 0 ]; then
     exit_code=$rc
-    errmesg="$errmesg two_children_ns: return code is $exit_code ; "
+    errmesg="two_children_ns: return code is $exit_code ; "
     echo $errmesg
 else
    echo "two_children_ns: PASS"
@@ -71,7 +71,7 @@ crtchild_delchild
 rc=$?
 if [ $rc -ne 0 ]; then
     exit_code=$rc
-    errmesg="$errmesg crtchild_delchild: return code is $exit_code ; "
+    errmesg="crtchild_delchild: return code is $exit_code ; "
     echo $errmesg
 else
    echo "crtchild_delchild: PASS"
@@ -83,7 +83,7 @@ par_chld_ipv6
 rc=$?
 if [ $rc -ne 0 ]; then
     exit_code=$rc
-    errmesg="$errmesg par_chld_ipv6: return code is $exit_code ; "
+    errmesg="par_chld_ipv6: return code is $exit_code ; "
     echo $errmesg
 else
    echo "par_chld_ipv6: PASS"
@@ -99,7 +99,7 @@ echo
 #rc=$?
 #if [ $rc -ne 0 ]; then
 #    exit_code=$rc
-#    errmesg="$errmesg sysfsview: return code is $exit_code ; "
+#    errmesg="sysfsview: return code is $exit_code ; "
 #    echo $errmesg
 #else
 #   echo "sysfsview: PASS"
@@ -119,7 +119,7 @@ par_chld_ftp
 rc=$?
 if [ $rc -ne 0 ]; then
     exit_code=$rc
-    errmesg="$errmesg par_chld_ftp: FAIL $exit_code ; "
+    errmesg="par_chld_ftp: FAIL $exit_code ; "
     echo $errmesg
 else
    echo "par_chld_ftp: PASS"
-- 
1.8.3.1


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
