Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeDU-0008Ii-Ad
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:36 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeDR-0006sF-D9
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:36 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13ECRkk014957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:27 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13ECQQb022441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:26 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13ECQvI002263
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:26 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:14:41 +0300
Message-Id: <1422972883-12173-4-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 4/6] lib/network.sh: add default http server directory
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
 testscripts/network.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index b9e1847..a1812eb 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -49,7 +49,7 @@ export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 # Reverse host portion of the IPv6 address of the remote host
 export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 
-export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-""}
+export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-"/var/www/html"}
 export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-""}
 export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-""}
 export FTP_UPLOAD_URLDIR=${FTP_UPLOAD_URLDIR:-""}
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
