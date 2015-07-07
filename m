Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZCTqb-00079p-AD
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 14:27:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZCTqa-0004OK-AV
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 14:27:45 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t67ERc1j011728
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 14:27:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t67ERbKk013099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 14:27:38 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t67ERbfc025697
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 14:27:37 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  7 Jul 2015 17:30:43 +0300
Message-Id: <1436279443-32379-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1436279443-32379-1-git-send-email-alexey.kodanev@oracle.com>
References: <1436279443-32379-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [Committed 2/2] network/vxlan_lib.sh: move netload() to
	test_net.sh
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
 testcases/lib/test_net.sh            |   49 ++++++++++++++++++++++++++++++++-
 testcases/network/vxlan/vxlan_lib.sh |   51 ++-------------------------------
 2 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 6201316..9df49d2 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -250,3 +250,50 @@ tst_restore_ipaddr()
 
 	return $ret
 }
+
+# tst_netload ADDR [FILE] [TYPE]
+# Run network load test
+# ADDR: IP address
+# FILE: file with result time
+# TYPE: PING or TFO (TCP traffic)
+tst_netload()
+{
+	local ip_addr="$1"
+	local rfile=${2:-"netload.res"}
+	local type=${3:-"TFO"}
+	local ret=0
+
+	case "$type" in
+	PING)
+		local ipv6=
+		echo "$ip_addr" | grep ":" > /dev/null
+		[ $? -eq 0 ] && ipv6=6
+		tst_resm TINFO "run ping${ipv6} test with rhost '$ip_addr'..."
+		local res=
+		res=$(ping${ipv6} -f -c $client_requests $ip_addr -w 600 2>&1)
+		[ $? -ne 0 ] && return 1
+		echo $res | sed -nE 's/.*time ([0-9]+)ms.*/\1/p' > $rfile
+	;;
+	TFO)
+		local port=
+		port=$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')
+		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
+
+		tst_resm TINFO "run tcp_fastopen with '$ip_addr', port '$port'"
+		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
+
+		# run local tcp client
+		tcp_fastopen -a $clients_num -r $client_requests -l \
+			-H $ip_addr -g $port -d $rfile > /dev/null || ret=1
+
+		if [ $ret -eq 0 -a ! -f $rfile ]; then
+			tst_brkm TBROK "can't read $rfile"
+		fi
+
+		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	;;
+	*) tst_brkm TBROK "invalid net_load type '$type'" ;;
+	esac
+
+	return $ret
+}
diff --git a/testcases/network/vxlan/vxlan_lib.sh b/testcases/network/vxlan/vxlan_lib.sh
index d3091ac..f9cd49f 100644
--- a/testcases/network/vxlan/vxlan_lib.sh
+++ b/testcases/network/vxlan/vxlan_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -160,54 +160,11 @@ vxlan_setup_subnet_multi()
 	tst_rhost_run -s -c "ip li set up ltp_vxl0"
 }
 
-netload_test()
-{
-	local ip_addr="$1"
-	local rfile="$2"
-	local ret=0
-
-	case "$net_load" in
-	PING)
-		local ipv6=
-		echo "$ip_addr" | grep ":" > /dev/null
-		[ $? -eq 0 ] && ipv6=6
-		tst_resm TINFO "run ping${ipv6} test with rhost '$ip_addr'..."
-		local res=
-		res=$(ping${ipv6} -f -c $client_requests $ip_addr -w 600 2>&1)
-		[ $? -ne 0 ] && return 1
-		echo $res | sed -nE 's/.*time ([0-9]+)ms.*/\1/p' > $rfile
-	;;
-	TFO)
-		local port=
-		port=$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')
-		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
-
-		tst_resm TINFO "run tcp_fastopen with '$ip_addr', port '$port'"
-		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
-
-		sleep 5
-
-		# run local tcp client
-		tcp_fastopen -a $clients_num -r $client_requests -l \
-			-H $ip_addr -g $port -d $rfile > /dev/null || ret=1
-
-		if [ $ret -eq 0 -a ! -f $rfile ]; then
-			tst_brkm TBROK "can't read $rfile"
-		fi
-
-		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
-	;;
-	*) tst_brkm TBROK "invalid net_load type '$net_load'" ;;
-	esac
-
-	return $ret
-}
-
 vxlan_compare_netperf()
 {
 	local ret=0
-	netload_test $ip_vxlan_remote res_ipv4 || ret=1
-	netload_test ${ip6_vxlan_remote}%ltp_vxl0 res_ipv6 || ret=1
+	tst_netload $ip_vxlan_remote res_ipv4 $net_load || ret=1
+	tst_netload ${ip6_vxlan_remote}%ltp_vxl0 res_ipv6 $net_load || ret=1
 
 	ROD_SILENT "ip link delete ltp_vxl0"
 	tst_rhost_run -s -c "ip link delete ltp_vxl0"
@@ -215,7 +172,7 @@ vxlan_compare_netperf()
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
 
-	netload_test $ip_remote res_ipv4 || return 1
+	tst_netload $ip_remote res_ipv4 $net_load || return 1
 
 	local lt="$(cat res_ipv4)"
 	tst_resm TINFO "time lan($lt) vxlan IPv4($vt) and IPv6($vt6) ms"
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
