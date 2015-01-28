Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YGRQK-0005LC-Ve
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 12:08:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YGRQK-0003vo-4g
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 12:08:44 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0SC8cY5005060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:39 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0SC8bLw015092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:38 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0SC8bV7021093
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:37 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 28 Jan 2015 15:10:54 +0300
Message-Id: <1422447054-9775-4-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 4/4] runtest/network-stress.appl: fix ftp test names
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.appl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/network_stress.appl b/runtest/network_stress.appl
index 308751c..c06af71 100644
--- a/runtest/network_stress.appl
+++ b/runtest/network_stress.appl
@@ -11,8 +11,8 @@ dns6-stress dns-stress -6
 http4-stress http-stress
 http6-stress http-stress -6
 
-ftp4-download-stress ftp4-download-stress
-ftp6-download-stress ftp6-download-stress
+ftp4-download-stress ftp-download-stress
+ftp6-download-stress ftp-download-stress -6
 
-ftp4-upload-stress ftp4-upload-stress
-ftp6-upload-stress ftp6-upload-stress
+ftp4-upload-stress ftp-upload-stress
+ftp6-upload-stress ftp-upload-stress -6
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
