Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WcC4u-0001hp-TU
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 11:08:00 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WcC4r-00044o-Ie
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 11:08:00 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3LB7o31030124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 11:07:51 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3LB7oUL018387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 11:07:50 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3LB7oVD018380
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 11:07:50 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 21 Apr 2014 15:07:41 +0400
Message-Id: <1398078461-23926-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1398078461-23926-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1398078461-23926-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/2] open_posix_testsuite: increased timeout to 5 min
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
Cc: vasily.isaenko@oracle.com

To make some tests complete in time on some non-x86 systems (especially
pthread_create-1_6).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/open_posix_testsuite/bin/run-tests.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/bin/run-tests.sh b/testcases/open_posix_testsuite/bin/run-tests.sh
index bd8ca14..6737f83 100755
--- a/testcases/open_posix_testsuite/bin/run-tests.sh
+++ b/testcases/open_posix_testsuite/bin/run-tests.sh
@@ -113,7 +113,7 @@ if [ ! -f "$T0_VAL" ]; then
 fi
 if TIMEOUT_RET=$(cat "$T0_VAL"); then
 
-	TIMEOUT_VAL=${TIMEOUT_VAL:=240}
+	TIMEOUT_VAL=${TIMEOUT_VAL:=300}
 	if [ -f test_defs ] ; then
 		. ./test_defs || exit $?
 	fi
-- 
1.7.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
