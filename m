Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzO-0004bB-C5
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:54 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzN-0004W5-Ai
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:54 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4lsL030712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:47 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4k5K001180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:47 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4kXk001169
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:46 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:00 +0300
Message-Id: <1423829229-28963-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/11] network/stress/interface/docs: cleanup
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
 .../network/stress/interface/00_Descriptions.txt   |  129 +++-----------------
 1 files changed, 16 insertions(+), 113 deletions(-)

diff --git a/testcases/network/stress/interface/00_Descriptions.txt b/testcases/network/stress/interface/00_Descriptions.txt
index abf1765..2c67aca 100644
--- a/testcases/network/stress/interface/00_Descriptions.txt
+++ b/testcases/network/stress/interface/00_Descriptions.txt
@@ -1,120 +1,23 @@
-if4-updown01
-	Verify the IPv4 connectivity is not broken when ifconfig command ups,
-	then downs an interface many times
+if-updown
+	Verify the IPv4/IPv6 connectivity is not broken when ip/ifconfig
+	command ups, then downs an interface many times
 
-if4-updown02
-	Verify the IPv4 connectivity is not broken when ip command ups, then
-	downs an interface many times
+if4-addr-change
+	Verify the IPv4 connectivity is not broken when ip/ifconfig
+	command changes address many times
 
-
-if4-addr-change01
-	Verify the IPv4 connectivity is not broken when the ifconfig command
-	changes the IPv4 address many times
-
-
-if4-alias-adddel01
-	Verify the IPv4 connectivity is not broken when 'ifconfig add' adds,
-	then deletes an IPv4 alias many times
-
-if4-alias-adddel02
-	Verify the IPv4 connectivity is not broken when 'ifconfig ethn:n' adds,
+if-addr-adddel
+	Verify the IPv4/IPv6 connectivity is not broken when ip/ifconfig adds,
 	then deletes an IPv4 alias many times
 
-if4-alias-adddel03
-	Verify the IPv4 connectivity is not broken when ip command adds, then
-	deletes an IPv4 alias many times
-
-
-if4-alias-addlarge01
-	Verify the IPv4 connectivity is not broken when 'ifconifg add' creates
-	many IPv4-aliases.
-
-if4-alias-addlarge02
-	Verify the IPv4 connectivity is not broken when 'ifconfig ethn:n'
-	creates many IPv4-aliases'
-
-if4-alias-addlarge03
-	Verify the IPv4 connectivity is not broken when ip command creates
-	many IPv4-aliases
-
-
-if4-route-adddel01
-	Verify the IPv4 connectivity is not broken when the route command adds,
-	then and deletes an IPv4 route many times
-
-if4-route-adddel02
-	Verify the IPv4 connectivity is not broken when the ip command adds,
-	then and deletes an IPv4 route many times
-
-
-if4-route-addlarge01
-	Verify the IPv4 connectivity is not broken when the route command
-	adds many IPv4 routes
-
-if4-route-addlarge02
-	Verify the IPv4 connectivity is not broken when the ip command adds
-	many IPv4 routes
-
-
-if4-mtu-change01
-	Verify the IPv4 connectivity is not broken when ifconfig command
-	changes MTU many times every 5 seconds
-
-if4-mtu-change02
-	Verify the IPv4 connectivity is not broken when ip command changes
-	MTU many times every 5 seconds
-
-
-
-if6-updown01
-	Verify the IPv6 connectivity is not broken when the ifconfig command
-	ups, then downs an interface many times
-
-if6-updown02
-	Verify the IPv6 connectivity is not broken when the ip command ups,
-	then downs an interface many times
-
-
-if6-addr-adddel01
-	Verify the IPv6 connectivty is not broken when the ifconfig command
-	adds, then deletes an IPv6 address many times
-
-if6-addr-adddel02
-	Verify the IPv6 connectivty is not broken when the ip command adds,
-	then deletes an IPv6 address many times
-
+if-addr-addlarge
+	Verify the IPv4/IPv6 connectivity is not broken when ip/ifconifg
+	creates many addresses.
 
-if6-addr-addlarge01
-	Verify the IPv6 connectivity is not broken when the ifconfig command
-	adds many IPv6 addresses
+if-route-adddel
+	Verify the IPv4/IPv6 connectivity is not broken when the ip/route adds,
+	then and deletes an IPv4/IPv6 route many times
 
-if6-addr-addlarge02
-	Verify the IPv6 connectivity is not broken when the ip command adds
-	many IPv6 addresses
-
-
-if6-route-adddel01
-	Verify the IPv6 connectivity is not broken when the route command adds,
-	then deletes an IPv6 route many times
-
-if6-route-adddel02
-	Verify the IPv6 connectivity is not broken when the ip command adds,
-	then deletes an IPv6 route many times
-
-
-f6-route-addlarge01
-	Verify the IPv6 connectivity is not broken when the route command adds
-	many IPv6 routes
-
-if6-route-addlarge02
-	Verify the IPv6 connectivity is not broken when the ip command adds
-	many IPv6 routes
-
-
-if6-mtu-change01
-	Verify the IPv6 connectivity is not broken when the ifconfig command
+if-mtu-change
+	Verify the IPv4/IPv6 connectivity is not broken when ip/ifconfig
 	changes MTU many times every 5 seconds
-
-if6-mtu-change02
-	Verify the IPv6 connectivity is not broken when the ip command changes
-	MTU many times every 5 seconds
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
