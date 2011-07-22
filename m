Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkAoX-0003EI-My
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkAoW-0007qd-Tt
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:29 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8ANV3018713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:23 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p6M8AMmJ008931
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:22 -0400
Message-ID: <4E29306D.2000307@redhat.com>
Date: Fri, 22 Jul 2011 10:10:21 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030908020508050600090700"
Subject: [LTP] [PATCH 2/6 v3] cgroups/cgroup_regression_test: fix test_5
	mount typo
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
--------------030908020508050600090700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


test_5 should mount 2 subsystems, but mount command has typo,
it says "$subsys" instead of "$subsys2"

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
   .../controllers/cgroup/cgroup_regression_test.sh   |    2 +-
   1 files changed, 1 insertions(+), 1 deletions(-)




--------------030908020508050600090700
Content-Type: text/x-patch;
	name="0002-cgroups-cgroup_regression_test-fix-test_5-mount-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-cgroups-cgroup_regression_test-fix-test_5-mount-typo.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 5615053..db903d5 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -257,7 +257,7 @@ test_5()
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
-	mount -t cgroup -o $subsys1,$subsys xxx cgroup/
+	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
 		failed=1



--------------030908020508050600090700
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
--------------030908020508050600090700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030908020508050600090700--

