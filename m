Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1ZUFUO-0001tX-4M
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 14:46:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUFUL-0002gR-S4
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 14:46:15 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id C26A78C1B0
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Aug 2015 14:46:07 +0000 (UTC)
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.89.68])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t7PEk6F4010185
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2015 10:46:07 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Tue, 25 Aug 2015 16:46:02 +0200
Message-Id: <1440513962-10908-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] containers/netns: added one more test case for
	netns_sysfs.sh
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

* renamed "dummy0" to "dummy_test0" to not collide with existing
  interfaces
* added test case which checks that only "localhost" and "dummy"
  interfaces are seen in /sys/class/net/ after mounting sysfs
  in a new namespace

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/netns/netns_sysfs.sh | 39 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index c10fa36..a58495e 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -23,13 +23,14 @@
 #==============================================================================
 
 TCID="netns_sysfs"
-TST_TOTAL=2
+TST_TOTAL=3
+DUMMYDEV="dummy_test0"
 . test.sh
 
 cleanup()
 {
 	tst_rmdir
-	ip link del dummy0 2>/dev/null
+	ip link del $DUMMYDEV 2>/dev/null
 	kill -9 $NS_HANDLE 2>/dev/null
 }
 
@@ -43,23 +44,45 @@ TST_CLEANUP=cleanup
 ls /sys/class/net >sysfs_before
 
 
-ns_exec $NS_HANDLE ip link add dummy0 type dummy || \
+ns_exec $NS_HANDLE ip link add $DUMMYDEV type dummy || \
 	tst_brkm TBROK "failed to add a new dummy device"
 ns_exec $NS_HANDLE mount -t sysfs none /sys 2>/dev/null
 
-ns_exec $NS_HANDLE test -d /sys/class/net/dummy0
+
+# TEST CASE #1
+ns_exec $NS_HANDLE test -d "/sys/class/net/$DUMMYDEV"
 if [ $? -eq 0 ]; then
-	tst_resm TPASS "sysfs in new namespace has dummy0 interface"
+	tst_resm TPASS "sysfs in new namespace has $DUMMYDEV interface"
+else
+	tst_resm TFAIL "sysfs in new namespace does not have $DUMMYDEV interface"
+fi
+
+
+# TEST CASE #2
+res=0
+classnet=$(ns_exec $NS_HANDLE ls /sys/class/net/)
+for d in $classnet; do
+	if [ "$d" != "lo" ]; then
+		if [ "$d" != $DUMMYDEV ]; then
+			tst_resm TINFO "sysfs in new namespace should not contain: $d"
+			res=1
+		fi
+	fi
+done
+if [ $res -eq 0 ]; then
+	tst_resm TPASS "sysfs in new namespace has only lo and $DUMMYDEV interfaces"
 else
-	tst_resm TFAIL "sysfs in new namespace does not have dummy0 interface"
+	tst_resm TFAIL "sysfs in new namespace has more than lo and $DUMMYDEV interfaces"
 fi
 
+
+# TEST CASE #3
 ls /sys/class/net >sysfs_after
 diff sysfs_before sysfs_after
 if [ $? -eq 0 ]; then
-	tst_resm TPASS "sysfs not affected by a separate namespace"
+	tst_resm TPASS "main sysfs not affected by a separate namespace"
 else
-	tst_resm TFAIL "sysfs affected by a separate namespace"
+	tst_resm TFAIL "main sysfs affected by a separate namespace"
 fi
 
 tst_exit
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
