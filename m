Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkAoO-0003DV-7r
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkAoN-0007pm-IW
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:20 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8ADHf018697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:13 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p6M8ACKd008669
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:13 -0400
Message-ID: <4E293064.5020706@redhat.com>
Date: Fri, 22 Jul 2011 10:10:12 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030403070206090602070401"
Subject: [LTP] [PATCH 1/6 v3] cgroups/cgroup_regression_test: clear dmesg
 before test
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
--------------030403070206090602070401
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


dmesg can rotate and number of found bugs can actually go down,
clear the buffer before test to avoid this

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
   .../controllers/cgroup/cgroup_regression_test.sh   |    3 +++
   1 files changed, 3 insertions(+), 0 deletions(-)




--------------030403070206090602070401
Content-Type: text/x-patch;
	name="0001-cgroups-cgroup_regression_test-clear-dmesg-before-te.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-cgroups-cgroup_regression_test-clear-dmesg-before-te.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 878f91a..5615053 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -40,6 +40,7 @@ elif [ "x$(id -ru)" != x0 ]; then
 	exit 0
 fi
 
+dmesg -c > /dev/null
 nr_bug=`dmesg | grep -c "kernel BUG"`
 nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 nr_warning=`dmesg | grep -c "^WARNING"`
@@ -78,6 +79,8 @@ check_kernel_bug()
 	nr_warning=$new_warning
 	nr_lockdep=$new_lockdep
 
+	echo "check_kernel_bug found something!"
+	dmesg
 	failed=1
 	return 0
 }



--------------030403070206090602070401
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
--------------030403070206090602070401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030403070206090602070401--

