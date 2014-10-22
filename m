Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XguGb-0005DE-JG
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 11:39:49 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XguGZ-0007mf-NH
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 11:39:49 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9MBdfAw006598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:42 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s9MBdeGj012129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:41 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MBdeDF009233
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:40 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 22 Oct 2014 15:41:32 +0400
Message-Id: <1413978094-10616-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
References: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3 2/3] network/test_net: add tst_ipaddr
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

Some tests require IP addresses, either IPv4 or IPv6.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: replace TST_EXEC_SUFFIX with TST_IPV6

 testcases/lib/test_net.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 24460f3..b6d4e7d 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -152,3 +152,25 @@ tst_read_opts()
 	done
 	OPTIND=0
 }
+
+# Get IP address
+# tst_ipaddr [TYPE]
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+tst_ipaddr()
+{
+	local type=${1:-"lhost"}
+	local ipv=${TST_IPV6:-"4"}
+	local tst_host=
+
+	if [ "$type" = "lhost" ]; then
+		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
+	else
+		eval "tst_host=\$RHOST_IPV${ipv}_HOST"
+	fi
+
+	if [ "$TST_IPV6" ]; then
+		echo "${IPV6_NETWORK}:${tst_host}"
+	else
+		echo "${IPV4_NETWORK}.${tst_host}"
+	fi
+}
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
