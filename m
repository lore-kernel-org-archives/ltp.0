Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YDDcF-0003I7-1f
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:47:43 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YDDcE-0004Jn-3U
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:47:43 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0JElZBK029048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:36 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t0JElYSO027030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:35 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0JElYj2010145
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Jan 2015 17:49:48 +0300
Message-Id: <1421678989-28577-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
References: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/4] network/stress/ssh: make use of tcp_fastopen
	client/server
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
 testcases/network/stress/ssh/ssh-stress       |   13 ++++++-------
 testcases/network/stress/ssh/ssh-stress03-rmt |    8 ++++----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 72bef25..d1e37bf 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -34,7 +34,7 @@ cleanup()
 {
 	# Stop the ssh daemon
 	test -s sshd.pid && kill $(cat sshd.pid)
-	test "$server_pid" && kill -9 $server_pid > /dev/null 2>&1
+	pkill 'tcp_fastopen$'
 	tst_rmdir
 	TMPDIR=
 }
@@ -44,7 +44,7 @@ setup()
 	trap "tst_brkm TBROK 'test interrupted'" INT
 
 	tst_require_root
-	tst_check_cmds sshd ssh od
+	tst_check_cmds pkill sshd ssh od
 
 	ipver=${TST_IPV6:-"4"}
 
@@ -125,16 +125,15 @@ test02()
 
 test03()
 {
-	tst_resm TINFO "Forwarding TCP traffic in $NS_DURATION sec"
+	tst_resm TINFO "Forwarding TCP traffic with $NS_TIMES requests"
 
 	# Run a TCP traffic server
 	port=$(tst_get_unused_port ipv${ipver} stream)
 
-	ns-tcpserver -b -f $ipver -p $port -o info_file || \
-		tst_brkm TBROK "Failed to run a tcp traffic server"
-	server_pid=$(grep 'PID:' info_file | cut -f 2 -d ' ')
+	tcp_fastopen -R 3 -g $port > tcp_server.log 2>&1 &
+
 	tst_rhost_run -s -c "ssh-stress03-rmt $ipver $(tst_ipaddr) \
-		$rconfig $port $NS_DURATION"
+		$rconfig $port $NS_TIMES"
 
 	tst_resm TPASS "Test is finished successfully"
 }
diff --git a/testcases/network/stress/ssh/ssh-stress03-rmt b/testcases/network/stress/ssh/ssh-stress03-rmt
index 9dcebe7..a5b7af0 100644
--- a/testcases/network/stress/ssh/ssh-stress03-rmt
+++ b/testcases/network/stress/ssh/ssh-stress03-rmt
@@ -27,14 +27,14 @@ TST_TOTAL=1
 
 # Check the arguments
 if [ $# -ne 5 ]; then
-	tst_brkm TBROK "Usage: $0 ipver rhost config port duration"
+	tst_brkm TBROK "Usage: $0 ipver rhost config port requests"
 fi
 
 ip_ver="$1"
 server_ipaddr="$2"
 ssh_config="$3"
 rport="$4"
-duration="$5"
+requests="$5"
 
 ssh -$ip_ver -F $ssh_config $server_ipaddr \
 	"true < /dev/null > /dev/null 2>&1" > /dev/null
@@ -56,8 +56,8 @@ case $ip_ver in
 ;;
 esac
 
-# Start the TCP traffic client
-ns-tcpclient -S $localhost -p $lport -f $ip_ver -t $duration
+# Start the TCP traffic clients
+tcp_fastopen -r $requests -l -H $localhost -g $lport > /dev/null
 ret=$?
 
 # Stop the ssh port forwarding
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
