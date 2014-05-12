Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WjpSL-0006kr-C0
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 12:35:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WjpSK-0005KS-IQ
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 12:35:45 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4CCZcbl014015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:39 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4CCZc5E002022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:38 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4CCZblx002013
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:37 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 12 May 2014 16:35:26 +0400
Message-Id: <1399898127-15934-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399898127-15934-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399898127-15934-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V4 3/4] testscripts/isofs: make it quiet
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

All pass/fail checks are performed based on the exit value.
So we may freely redirect all unused output to /dev/null.

And exportfs always returns 0, so there is no point to execute it at all.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testscripts/isofs.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
index 1335327..e4f3093 100755
--- a/testscripts/isofs.sh
+++ b/testscripts/isofs.sh
@@ -98,7 +98,7 @@ for mkisofs_opt in \
 	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
 do
 	rm -f isofs.iso
-	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
+	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
 	if [ $? -eq 0 ]; then
 		tst_resm TPASS \
 			"mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
@@ -128,9 +128,10 @@ do
 			continue
 		fi
 
-		ls -lR $MNT_POINT
-		exportfs -i -o no_root_squash,rw *:$MNT_POINT
-		exportfs -u :$MNT_POINT
+		ls -lR $MNT_POINT > /dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "ls -lR $MNT_POINT"
+		fi
 
 		umount $MNT_POINT
 		if [ $? -ne 0 ]; then
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
