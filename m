Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1R5Ybt-0007Ix-13
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:49:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R5Ybs-0006AZ-Cg
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:49:48 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8J7ngCf004181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:42 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p8J7ne0J013734
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:41 -0400
Message-ID: <4E76F414.3050200@redhat.com>
Date: Mon, 19 Sep 2011 09:49:40 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070602010201060708020509"
Subject: [LTP] [PATCH 1/3] cgroup/memcg_regression_test: clear dmesg before
	test
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
--------------070602010201060708020509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


dmesg can rotate and number of found bugs can actually go down,
so clear the buffer before test to avoid this.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../memcg/regression/memcg_regression_test.sh      |   13 +++++++++----
  1 files changed, 9 insertions(+), 4 deletions(-)



--------------070602010201060708020509
Content-Type: text/x-patch;
	name="0001-cgroup-memcg_regression_test-clear-dmesg-before-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-cgroup-memcg_regression_test-clear-dmesg-before-test.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index b564ece..855b0fe 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -47,10 +47,13 @@ if [ $? -eq 0 ]; then
 	exit 0
 fi
 
-nr_bug=`dmesg | grep -c "kernel BUG"`
-nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
-nr_warning=`dmesg | grep -c "^WARNING"`
-nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+#buffer can rotate and number of found bugs can actually go down
+#so clear the buffer to avoid this
+dmesg -c > /dev/null
+nr_bug=0
+nr_null=0
+nr_warning=0
+nr_lockdep=0
 
 # check_kernel_bug - check if some kind of kernel bug happened
 check_kernel_bug()
@@ -85,6 +88,8 @@ check_kernel_bug()
 	nr_warning=$new_warning
 	nr_lockdep=$new_lockdep
 
+	echo "check_kernel_bug found something!"
+	dmesg
 	failed=1
 	return 0
 }


--------------070602010201060708020509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
Learn about the latest advances in developing for the 
BlackBerry&reg; mobile platform with sessions, labs & more.
See new tools and technologies. Register for BlackBerry&reg; DevCon today!
http://p.sf.net/sfu/rim-devcon-copy1 
--------------070602010201060708020509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070602010201060708020509--

