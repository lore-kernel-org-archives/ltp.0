From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Dec 2016 16:34:09 +0300
Subject: [LTP] [PATCH] test_net.sh: don't set nohup in netns and show
	netstress msgs
Message-ID: <1482154449-4532-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index f5321d7..f73296d 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -64,16 +64,14 @@ tst_rhost_run()
 
 	while getopts :bsc:u: opt; do
 		case "$opt" in
-		b)
-			pre_cmd="nohup"
-			post_cmd=" > /dev/null 2>&1 &"
-			out="1> /dev/null"
+		b) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
+		   post_cmd=" > /dev/null 2>&1 &"
+		   out="1> /dev/null"
 		;;
 		s) safe=1 ;;
 		c) cmd=$OPTARG ;;
 		u) user=$OPTARG ;;
-		*)
-			tst_brkm TBROK "tst_rhost_run: unknown option: $OPTARG"
+		*) tst_brkm TBROK "tst_rhost_run: unknown option: $OPTARG"
 		;;
 		esac
 	done
@@ -308,8 +306,7 @@ tst_netload()
 		echo $res | sed -nE 's/.*time ([0-9]+)ms.*/\1/p' > $rfile
 	;;
 	TFO)
-		local port=
-		port=$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')
+		local port=$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')
 		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
 
 		tst_resm TINFO "run netstress with '$ip_addr', port '$port'"
@@ -329,7 +326,7 @@ tst_netload()
 
 		# run local tcp client
 		netstress -a $clients_num -r $client_requests -l -H $ip_addr\
-			 -g $port -d $rfile $addopts > /dev/null || ret=1
+			 -g $port -d $rfile $addopts || ret=1
 
 		if [ $ret -eq 0 -a ! -f $rfile ]; then
 			tst_brkm TBROK "can't read $rfile"
-- 
1.7.1

