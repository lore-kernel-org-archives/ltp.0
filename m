From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Sep 2015 12:47:18 +0300
Subject: [LTP] [PATCH 3/4] lib/test_net.sh: allow any additional options to
	tst_netload
In-Reply-To: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
References: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1442396839-29900-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index b42337a..bd6f0d6 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -251,17 +251,22 @@ tst_restore_ipaddr()
 	return $ret
 }
 
-# tst_netload ADDR [FILE] [TYPE]
+# tst_netload ADDR [FILE] [TYPE] [OPTS]
 # Run network load test
 # ADDR: IP address
 # FILE: file with result time
 # TYPE: PING or TFO (TCP traffic)
+# OPTS: additional options
 tst_netload()
 {
 	local ip_addr="$1"
 	local rfile=${2:-"netload.res"}
 	local type=${3:-"TFO"}
+	local addopts=${@:4}
 	local ret=0
+	clients_num=${clients_num:-"2"}
+	client_requests=${client_requests:-"500000"}
+	max_requests=${max_requests:-"3"}
 
 	case "$type" in
 	PING)
@@ -280,7 +285,8 @@ tst_netload()
 		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
 
 		tst_resm TINFO "run tcp_fastopen with '$ip_addr', port '$port'"
-		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests -g $port"
+		tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests \
+			-g $port $addopts"
 
 		# check that tcp_fastopen on rhost in 'Listening' state
 		local sec_waited=
@@ -294,8 +300,8 @@ tst_netload()
 		done
 
 		# run local tcp client
-		tcp_fastopen -a $clients_num -r $client_requests -l \
-			-H $ip_addr -g $port -d $rfile > /dev/null || ret=1
+		tcp_fastopen -a $clients_num -r $client_requests -l -H $ip_addr\
+			 -g $port -d $rfile $addopts > /dev/null || ret=1
 
 		if [ $ret -eq 0 -a ! -f $rfile ]; then
 			tst_brkm TBROK "can't read $rfile"
-- 
1.7.1

