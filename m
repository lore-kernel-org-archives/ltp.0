Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5Zd-0002PE-Q1
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5Zc-0006uA-Tu
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:45 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696icYK020204
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t696icFN018618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:38 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696icaU005002
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:38 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:28 +0300
Message-Id: <1436424468-11756-4-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 03/23] network/virt_lib.sh: add virt_add() and
	virt_add_rhost()
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

Adding different types of virtual interfaces is almost similar
with ip command, although vxlan has a little bit differ syntax.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index d6ae77c..e8eedca 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -97,6 +97,31 @@ cleanup_vifaces()
 TST_CLEANUP="cleanup_vifaces"
 trap "tst_brkm TBROK 'test interrupted'" INT
 
+virt_add()
+{
+	case $virt_type in
+	vxlan)
+		ip li add ltp_v0 type $virt_type $@
+	;;
+	*)
+		ip li add link $(tst_iface) ltp_v0 type $virt_type $@
+	;;
+	esac
+}
+
+virt_add_rhost()
+{
+	case $virt_type in
+	vxlan)
+		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@"
+	;;
+	*)
+		tst_rhost_run -s -c "ip li add link $(tst_iface rhost) ltp_v0 \
+				     type $virt_type $@"
+	;;
+	esac
+}
+
 virt_setup()
 {
 	local opt="$1"
@@ -104,14 +129,14 @@ virt_setup()
 
 	tst_resm TINFO "setup local ${virt_type} with '$opt'"
 
-	ROD_SILENT "ip li add ltp_v0 type $virt_type $opt"
+	ROD_SILENT "virt_add $opt"
 	ROD_SILENT "ip li set ltp_v0 address $mac_virt_local"
 	ROD_SILENT "ip addr add ${ip_virt_local}/24 dev ltp_v0"
 	ROD_SILENT "ip li set up ltp_v0"
 
 	tst_resm TINFO "setup rhost ${virt_type} with '$opt_r'"
 
-	tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $opt_r"
+	virt_add_rhost "$opt_r"
 	tst_rhost_run -s -c "ip li set ltp_v0 address $mac_virt_remote"
 	tst_rhost_run -s -c "ip addr add ${ip_virt_remote}/24 dev ltp_v0"
 	tst_rhost_run -s -c "ip li set up ltp_v0"
@@ -204,8 +229,7 @@ ipver=${TST_IPV6:-'4'}
 
 tst_check_cmds "ip"
 
-ip link add ltp_v0 type $virt_type > /dev/null 2>&1
-if [ $? -ne 0 ]; then
+virt_add || \
 	tst_brkm TCONF "iproute2 or kernel doesn't support $virt_type"
-fi
+
 ROD_SILENT "ip link delete ltp_v0"
-- 
1.7.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
