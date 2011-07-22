Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkAok-0005oH-G3
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkAoj-0004cV-Pa
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:42 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8AZvf003647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:36 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p6M8AY8I008229
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:35 -0400
Message-ID: <4E29307A.7080708@redhat.com>
Date: Fri, 22 Jul 2011 10:10:34 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000503010806030900040506"
Subject: [LTP] [PATCH 3/6 v3] cgroups/cgroup_regression_test: fix test_6
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
--------------000503010806030900040506
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


test may leave groups behind, fix rmdir to match test_6_1.sh

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
   .../controllers/cgroup/cgroup_regression_test.sh   |    2 +-
   1 files changed, 1 insertions(+), 1 deletions(-)




--------------000503010806030900040506
Content-Type: text/x-patch;
	name="0003-cgroups-cgroup_regression_test-fix-test_6-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-cgroups-cgroup_regression_test-fix-test_6-cleanup.patch"

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index db903d5..1fd3c08 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -328,7 +328,7 @@ test_6()
 
 	# clean up
 	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
-	rmdir cgroup/[1-9] > /dev/null 2>&1
+	rmdir cgroup/[1-9]* > /dev/null 2>&1
 	umount cgroup/
 }
 



--------------000503010806030900040506
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
--------------000503010806030900040506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000503010806030900040506--

