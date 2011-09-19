Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1R5Yc5-0000Gh-Tf
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:50:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R5Yc4-0006BL-Ty
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:50:01 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8J7ntaC021485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:55 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p8J7nsKM013783
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:54 -0400
Message-ID: <4E76F421.1060703@redhat.com>
Date: Mon, 19 Sep 2011 09:49:53 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000300000805020209010002"
Subject: [LTP] [PATCH 3/3] cgroup/memcg_regression_test: treat failed mount
	as error
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
--------------000300000805020209010002
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


If test fails to mount memory subsytem, it should exit
with non-zero code.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../memcg/regression/memcg_regression_test.sh      |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)



--------------000300000805020209010002
Content-Type: text/x-patch;
	name="0003-cgroup-memcg_regression_test-treat-failed-mount-as-e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-cgroup-memcg_regression_test-treat-failed-mount-as-e.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index 55bec93..5ecfa28 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -219,7 +219,7 @@ test_4()
 }
 
 # main
-
+failed=0
 mkdir memcg/
 
 for cur in $(seq 1 $TST_TOTAL); do
@@ -228,6 +228,7 @@ for cur in $(seq 1 $TST_TOTAL); do
 	mount -t cgroup -o memory xxx memcg/
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount memory subsytem"
+		failed=1
 		continue
 	fi
 


--------------000300000805020209010002
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
--------------000300000805020209010002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000300000805020209010002--

