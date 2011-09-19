Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1R5Ybz-0007K8-Ey
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:49:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R5Yby-0001xs-QX
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:49:55 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8J7nnbm024468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:49 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p8J7nlDA013766
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:48 -0400
Message-ID: <4E76F41B.2080601@redhat.com>
Date: Mon, 19 Sep 2011 09:49:47 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010100090000010409010508"
Subject: [LTP] [PATCH 2/3] cgroup/memcg_regression_test: fix test4 cleanup
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
--------------010100090000010409010508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


If test_4.sh gets killed, it won't clean cgroup it created,
so clean it here.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../memcg/regression/memcg_regression_test.sh      |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)



--------------010100090000010409010508
Content-Type: text/x-patch;
	name="0002-cgroup-memcg_regression_test-fix-test4-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-cgroup-memcg_regression_test-fix-test4-cleanup.patch"

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index 855b0fe..55bec93 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -211,6 +211,10 @@ test_4()
 	# test_4.sh might be killed by oom, so do clean up here
 	killall -9 memcg_test_4 2> /dev/null
 	killall -9 memcg_test_4.sh 2> /dev/null
+
+	# if test_4.sh gets killed, it won't clean cgroup it created
+	rmdir memcg/0 2> /dev/null
+
 	swapon -a
 }
 


--------------010100090000010409010508
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
--------------010100090000010409010508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010100090000010409010508--

