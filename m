Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YGRQJ-0003zH-Hc
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 12:08:43 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YGRQI-0003vi-FN
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 12:08:43 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0SC8bBg005043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:37 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t0SC8aF4010716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:37 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0SC8aaF017175
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jan 2015 12:08:36 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 28 Jan 2015 15:10:53 +0300
Message-Id: <1422447054-9775-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/4] testscripts/network.sh: add default FTP
	directories
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
 testscripts/network.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index b9e1847..b0c03d9 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -50,9 +50,9 @@ export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 
 export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-""}
-export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-""}
-export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-""}
-export FTP_UPLOAD_URLDIR=${FTP_UPLOAD_URLDIR:-""}
+export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-"/var/ftp"}
+export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-"/var/ftp/pub"}
+export FTP_UPLOAD_URLDIR=${FTP_UPLOAD_URLDIR:-"pub"}
 
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
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
