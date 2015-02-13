Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzT-0006As-Cn
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:59 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzP-0002oN-2o
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:59 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4m4x032581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:49 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t1DC4ma4008788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:48 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	t1DC4lKk008769
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:48 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:01 +0300
Message-Id: <1423829229-28963-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/11] runtest/network_stress.interface: fix test names
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
 runtest/network_stress.interface |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/runtest/network_stress.interface b/runtest/network_stress.interface
index 43d5850..97e9ce3 100644
--- a/runtest/network_stress.interface
+++ b/runtest/network_stress.interface
@@ -2,17 +2,18 @@
 # Stress test for interface
 #
 
-if4-updown  if4-updown
 if4-addr-change if4-addr-change
-if4-alias-adddel  if4-alias-adddel
-if4-alias-addlarge  if4-alias-addlarge
-if4-route-adddel  if4-route-adddel
-if4-route-addlarge  if4-route-addlarge
-if4-mtu-change	if4-mtu-change
 
-if6-updown  if6-updown
-if6-addr-adddel	if6-addr-adddel
-if6-addr-addlarge if6-addr-addlarge
-if6-route-adddel  if6-route-adddel
-if6-route-addlarge if6-route-addlarge
-if6-mtu-change	if6-mtu-change
+if4-updown if-updown
+if4-addr-adddel if-addr-adddel
+if4-addr-addlarge if-addr-addlarge
+if4-route-adddel if-route-adddel
+if4-route-addlarge if-route-addlarge
+if4-mtu-change if-mtu-change
+
+if6-updown if-updown -6
+if6-addr-adddel if-addr-adddel -6
+if6-addr-addlarge if-addr-addlarge -6
+if6-route-adddel if-route-adddel -6
+if6-route-addlarge if-route-addlarge -6
+if6-mtu-change if-mtu-change -6
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
