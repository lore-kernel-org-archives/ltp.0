Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vbl3Y-0005bT-Up
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 05:44:32 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vbl3Y-0006Zs-6g
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 05:44:32 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9V5iPnr006030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 05:44:26 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9V5iP2h021571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 05:44:25 GMT
Received: from abhmt105.oracle.com (abhmt105.oracle.com [141.146.116.57])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9V5iOMv008169
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 05:44:25 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu, 31 Oct 2013 13:44:12 +0800
Message-Id: <1383198252-1033-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] dhcpd_tests.sh: fix dhcpd.conf file paths
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

dhcpd_tests.sh only checks for /etc/dhcpd.conf, while in some distros the
path is /etc/dhcp/dhcpd.conf.
---
 testcases/network/dhcpd/dhcpd_tests.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/testcases/network/dhcpd/dhcpd_tests.sh b/testcases/network/dhcpd/dhcpd_tests.sh
index 64c64e8..c00e549 100755
--- a/testcases/network/dhcpd/dhcpd_tests.sh
+++ b/testcases/network/dhcpd/dhcpd_tests.sh
@@ -42,7 +42,7 @@
 # Function:		init
 #
 # Description:	- Check if command dhcpd is available.
-#				- Check if /etc/dhcpd.conf is available.
+#               - Check if dhcpd.conf file is available.
 #               - Create temporary config file, for dhcpd.
 #               - alias ethX to ethX:1 with IP 10.1.1.12
 #
@@ -141,11 +141,18 @@ init()
 		return $RC
 	fi
 
-	if [ -f /etc/dhcpd.conf ]
+	if [ -f /etc/dhcpd.conf ]; then
+		DHCPD_CONF="/etc/dhcpd.conf"
+	elif [ -f /etc/dhcp/dhcpd.conf ]; then
+		DHCPD_CONF="/etc/dhcp/dhcpd.conf"
+	else
+		DHCPD_CONF=""
+	fi
+	if [ -n $DHCPD_CONF ]
 	then
 		RC1=0
-		mv /etc/dhcpd.conf $LTPTMP/dhcpd.conf > $LTPTMP/tst_dhcpd.err 2>&1 || RC=$?
-		mv $LTPTMP/tst_dhcpd.conf /etc/dhcpd.conf > $LTPTMP/tst_dhcpd.err 2>&1 \
+		mv $DHCPD_CONF $LTPTMP/dhcpd.conf > $LTPTMP/tst_dhcpd.err 2>&1 || RC=$?
+		mv $LTPTMP/tst_dhcpd.conf $DHCPD_CONF > $LTPTMP/tst_dhcpd.err 2>&1 \
 			|| RC1=$?
 		if [ $RC -ne 0 -o $RC1 -ne 0 ]
 		then
@@ -155,7 +162,7 @@ init()
 		fi
 	else
 		tst_brkm TBROK NULL \
-			"INIT: No /etc/dhcpd.conf file found."
+			"INIT: No dhcpd.conf file found."
 		return $(($RC+1))
 	fi
 
@@ -204,7 +211,7 @@ cleanup()
 
 	if [ -f $LTPTMP/dhcpd.conf ]
 	then
-		mv $LTPTMP/dhcpd.conf /etc/dhcpd.conf > $LTPTMP/tst_dhcpd.err 2>&1
+		mv $LTPTMP/dhcpd.conf $DHCPD_CONF > $LTPTMP/tst_dhcpd.err 2>&1
 	fi
 
 	/sbin/ifconfig | grep "${ETH_INTERFACE}:1" > $LTPTMP/tst_dhcpd.err 2>&1 || RC=$?
@@ -225,7 +232,7 @@ cleanup()
 #
 # Description	- Test basic functionality of dhcpd.
 #               - Test #1: dhcpd will serve IP addresses based on rules in
-#                 /etc/dhcpd.conf file.
+#                 dhcpd.conf file.
 #				- create dhcpd.conf file, server to listen to ethX/.../10.1.1.0
 #               - start dhcpd server
 #               - create expected output
@@ -241,7 +248,7 @@ test01()
 	TST_COUNT=1		# Test number.
 
 	tst_resm TINFO \
-	 "Test #1: dhcpd will serve IPaddr, rules in /etc/dhcpd.conf file."
+	 "Test #1: dhcpd will serve IPaddr, rules in dhcpd.conf file."
 
 	hwaddr=`ifconfig ${ETH_INTERFACE} | grep HWaddr | awk '{print $5}'` || RC=$?
 	if [ $RC -ne 0 ]
-- 
1.8.4


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
