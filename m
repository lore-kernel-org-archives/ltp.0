Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzS-0002cg-TN
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:58 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzS-0004m6-3A
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:58 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4qg3030777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:52 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC4pNx013097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:52 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4p9J009677
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:51 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:04 +0300
Message-Id: <1423829229-28963-6-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 6/11] testscripts/network.sh: add IPV4_NET16_UNUSED,
	IPV6_NET32_UNUSED
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
 testscripts/network.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 01733e9..426e732 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -49,6 +49,10 @@ export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 # Reverse host portion of the IPv6 address of the remote host
 export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 
+# Define the networks that aren't reachable through the test links
+IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
+IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
+
 export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-"/var/www/html"}
 export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-"/var/ftp"}
 export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-"/var/ftp/pub"}
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
