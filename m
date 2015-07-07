Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZCOxX-0004d7-Ea
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 09:14:35 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZCOxU-0003aW-DJ
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 09:14:35 +0000
Message-ID: <559B983A.3090003@huawei.com>
Date: Tue, 7 Jul 2015 17:13:30 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<5593E172.1050800@huawei.com> <5593F4E2.1040804@oracle.com>
	<55952961.30906@huawei.com> <5595490E.1010509@oracle.com>
	<55974D10.5050808@huawei.com> <559A9148.8060200@oracle.com>
In-Reply-To: <559A9148.8060200@oracle.com>
Subject: [LTP] [PATCH v2] commands/logrotate:run the case once again will
 failed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Including the rules in /etc/logrotate.d/ will cause the case failed
when run it at the second time.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/commands/logrotate/logrotate_tests.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 2a793cc..e845670 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -163,8 +163,6 @@ test01()
 	compress

 	# RPM packages drop log rotation information into this directory
-	include /etc/logrotate.d
-
 	/var/log/tst_logfile {
 		rotate 5
 		weekly
@@ -201,8 +199,6 @@ test01()
 		# check if  /etc/logrotate.d is included/
 		# check if 5 rotations are forced.
         # check if compression is done.
-		grep "including /etc/logrotate.d" $LTPTMP/tst_logrotate.out \
-			> $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
 		grep "reading config file $LTPTMP/tst_logrotate.conf" \
 			$LTPTMP/tst_logrotate.out   > $LTPTMP/tst_logrotate.err 2>&1 || RC=$?
 		grep "forced from command line (5 rotations)" \
-- 
1.6.0.2

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
