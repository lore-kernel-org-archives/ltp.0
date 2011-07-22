Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkAp8-0003GM-Va
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:11:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkAp8-0007uM-94
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:11:06 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8B01T003721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:11:00 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p6M8AxwA004804
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:11:00 -0400
Message-ID: <4E293093.1020505@redhat.com>
Date: Fri, 22 Jul 2011 10:10:59 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020601050306030206090908"
Subject: [LTP] [PATCH 5/6 v3] cgroups/cgroup_regression_test: fix test_10
	cleanup
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
--------------020601050306030206090908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


test_10 can leave cgroups umounted before cleanup,
make sure cgroups are mounted before doing cleanup.
Also keep stderr output from rmdir and umount,
if these fail it's better to have it in logs.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
   .../controllers/cgroup/cgroup_regression_test.sh   |    5 +++--
   1 files changed, 3 insertions(+), 2 deletions(-)




--------------020601050306030206090908
Content-Type: text/x-patch;
	name="0005-cgroups-cgroup_regression_test-fix-test_10-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0005-cgroups-cgroup_regression_test-fix-test_10-cleanup.patc";
	filename*1="h"

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 09563ef..19c30fe 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -502,8 +502,9 @@ test_10()
 	wait $pid1
 	wait $pid2
 
-	rmdir cgroup/0 2> /dev/null
-	umount cgroup/ 2> /dev/null
+	mount -t cgroup none cgroup 2> /dev/null
+	rmdir cgroup/0
+	umount cgroup/
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then



--------------020601050306030206090908
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
--------------020601050306030206090908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020601050306030206090908--

