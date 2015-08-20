Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZSONA-0006Yi-Lm
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 11:51:08 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZSON8-0001sl-HJ
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 11:51:08 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t7KBp0EE019559
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2015 11:51:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t7KBp0Up029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2015 11:51:00 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t7KBoxgW024364
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2015 11:50:59 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 20 Aug 2015 14:54:34 +0300
Message-Id: <1440071674-11218-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/virt/vxlan: add dstport option if ip supports
	it
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

Newer versions of 'iproute' complain about not set VxLAN
'dstport' option:

  vxlan: destination port not specified
  Will use Linux kernel default (non-standard value)
  Use 'dstport 4789' to get the IANA assigned value
  Use 'dstport 0' to get default and quiet this message

This message interferes with the actual test output. If 'iproute'
supports the option, set it when adding new VxLAN devices.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |    9 ++++++++-
 testcases/network/virt/vxlan03.sh  |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index e798b2c..d582284 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -43,6 +43,7 @@ client_requests=500000
 max_requests=3
 net_load="TFO"
 virt_threshold=80
+vxlan_dstport=0
 
 while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 	case "$opt" in
@@ -105,6 +106,7 @@ virt_add()
 	case $virt_type in
 	vlan|vxlan)
 		[ -z "$opt" ] && opt="id 4094"
+		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0 $opt"
 	;;
 	gre|ip6gre)
 		[ -z "$opt" ] && \
@@ -127,9 +129,11 @@ virt_add()
 
 virt_add_rhost()
 {
+	local opt=""
 	case $virt_type in
 	vxlan)
-		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@"
+		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0"
+		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@ $opt"
 	;;
 	gre|ip6gre)
 		tst_rhost_run -s -c "ip -f inet$TST_IPV6 tu add ltp_v0 \
@@ -372,6 +376,9 @@ vxlan)
 		tst_kvercmp 3 12 0 && \
 			tst_brkm TCONF "test must be run with kernels >= 3.12"
 	fi
+
+	# newer versions of 'ip' complain if this option not set
+	ip li add type vxlan help 2>&1 | grep -q dstport && vxlan_dstport=1
 ;;
 esac
 
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 55523da..65a71aa 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -60,7 +60,7 @@ if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
 
-opts=" ,dstport 0 gbp"
+opts=" ,gbp"
 
 for n in $(seq 1 2); do
 	p="$(echo $opts | cut -d',' -f$n)"
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
