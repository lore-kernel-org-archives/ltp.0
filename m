Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkAot-0003G5-Ec
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkAos-0004dR-MA
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:51 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8AjaO028629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:45 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p6M8Aic0016035
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:44 -0400
Message-ID: <4E293084.1090509@redhat.com>
Date: Fri, 22 Jul 2011 10:10:44 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000809050202010602090508"
Subject: [LTP] [PATCH 4/6 v3] cgroups/cgroup_regression_test: fix test_7_2
 failed mount message
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
--------------000809050202010602090508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


test_7_2 mounts whole cgroup not $subsys

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
   .../controllers/cgroup/cgroup_regression_test.sh   |    2 +-
   1 files changed, 1 insertions(+), 1 deletions(-)




--------------000809050202010602090508
Content-Type: text/x-patch;
	name="0004-cgroups-cgroup_regression_test-fix-test_7_2-failed-m.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0004-cgroups-cgroup_regression_test-fix-test_7_2-failed-m.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 1fd3c08..09563ef 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -365,7 +365,7 @@ test_7_2()
 {
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount $subsys"
+		tst_resm TFAIL "failed to mount cgroup"
 		failed=1
 		return
 	fi



--------------000809050202010602090508
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
--------------000809050202010602090508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000809050202010602090508--

