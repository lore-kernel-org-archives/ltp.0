Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YYWKl-0008Sv-CL
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 09:01:43 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YYWKj-0004yw-Sx
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 09:01:43 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t2J91Zug012642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Mar 2015 09:01:35 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t2J91YGA031450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Mar 2015 09:01:35 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t2J91Yt9003477
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Mar 2015 09:01:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 19 Mar 2015 12:03:56 +0300
Message-Id: <1426755836-24324-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/vxlan: fill mulicast address with random
	numbers
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

VxLAN test networks with the same multicast group might overlap with
each other because the test has static VxLAN IP addresses and VNI.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/vxlan/vxlan_lib.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
index e8970a9..c374b43 100644
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -142,8 +142,17 @@ vxlan_setup_subnet_uni()
 
 vxlan_setup_subnet_multi()
 {
+	tst_check_cmds "od"
+	local b1=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
+	local b2=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
+	local b3=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
+
 	local opt=
-	[ "$TST_IPV6" ] && opt="group ff05::111" || opt="group 239.1.1.1"
+	if [ "$TST_IPV6" ]; then
+		opt="group ff05::$(printf '%x:%x%x' $b1 $b2 $b3)"
+	else
+		opt="group 239.$b1.$b2.$b3"
+	fi
 
 	tst_resm TINFO "setup VxLANv$ipver with multicast address: '$opt'"
 
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
