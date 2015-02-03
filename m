Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeDT-0002rb-3k
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:35 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeDQ-00075b-2S
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:12:35 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13ECP6D014935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:26 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13ECPgj022399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:25 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	t13ECO6o013176
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:12:24 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:14:40 +0300
Message-Id: <1422972883-12173-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/6] network/stress/http: check downloaded file size
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
 testcases/network/stress/http/http-stress       |    5 ++-
 testcases/network/stress/http/http-stress01-rmt |   15 +++++++++++--
 testcases/network/stress/http/http-stress02-rmt |   25 +++++++++++++++-------
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/testcases/network/stress/http/http-stress b/testcases/network/stress/http/http-stress
index 1dd2f4b..db18237 100644
--- a/testcases/network/stress/http/http-stress
+++ b/testcases/network/stress/http/http-stress
@@ -58,7 +58,8 @@ test01()
 {
 	tst_resm TINFO "http client download test file"
 
-	tst_rhost_run -s -c "http-stress01-rmt $(tst_ipaddr) http_file"
+	tst_rhost_run -s -c "http-stress01-rmt $(tst_ipaddr) \
+		http_file $DOWNLOAD_BIGFILESIZE"
 
 	tst_resm TPASS "Test is finished successfully"
 }
@@ -68,7 +69,7 @@ test02()
 	tst_resm TINFO "clients request data asynchronously $NS_DURATION sec"
 
 	tst_rhost_run -s -c "http-stress02-rmt $(tst_ipaddr) http_file \
-		$NS_DURATION $CONNECTION_TOTAL"
+		$DOWNLOAD_BIGFILESIZE $NS_DURATION $CONNECTION_TOTAL"
 
 	tst_resm TPASS "Test is finished successfully"
 }
diff --git a/testcases/network/stress/http/http-stress01-rmt b/testcases/network/stress/http/http-stress01-rmt
index 2567889..9799007 100644
--- a/testcases/network/stress/http/http-stress01-rmt
+++ b/testcases/network/stress/http/http-stress01-rmt
@@ -24,20 +24,29 @@ TST_TOTAL=1
 
 . test_net.sh
 
-tst_check_cmds curl
+tst_check_cmds awk curl
 
 # Check the arguments
-[ $# -ne 2 ] && tst_brkm TBROK "Usage: $0 server_ipaddr filename"
+[ $# -ne 3 ] && tst_brkm TBROK "Usage: $0 server_ipaddr filename filesize"
 
 server_ipaddr="$1"
 filename="$2"
+filesize="$3"
 
 echo $server_ipaddr | grep -F ':' > /dev/null
 if [ $? -eq 0 ]; then
 	server_ipaddr='['$server_ipaddr']'
 fi
 
-curl -g "http://$server_ipaddr/$filename" -o /dev/null || \
+out=$(curl --noproxy '*' -sS -g "http://$server_ipaddr/$filename" -o /dev/null \
+	-w "time=%{time_total} size=%{size_download} speed=%{speed_download}")
+
+tst_resm TINFO "stat: $out"
+recv_filesize=$(echo "$out" | awk '{print $2}')
+
+if [ $recv_filesize != "size=$filesize" ]; then
+	tst_resm TINFO "expected file size '$filesize'"
 	tst_brkm TBROK "Failed to get http://${server_ipaddr}/${filename}"
+fi
 
 tst_exit
diff --git a/testcases/network/stress/http/http-stress02-rmt b/testcases/network/stress/http/http-stress02-rmt
index b59a75e..db21be4 100644
--- a/testcases/network/stress/http/http-stress02-rmt
+++ b/testcases/network/stress/http/http-stress02-rmt
@@ -24,16 +24,17 @@ TST_TOTAL=1
 
 . test_net.sh
 
-tst_check_cmds curl
+tst_check_cmds awk curl
 
-if [ $# -ne 4 ]; then
-	tst_brkm TBROK "Usage: $0 server_addr filename duration connections"
+if [ $# -ne 5 ]; then
+	tst_brkm TBROK "Usage: $0 server_addr fname fsize duration connections"
 fi
 
 server_ipaddr="$1"
 filename="$2"
-duration="$3"
-connections="$4"
+filesize="$3"
+duration="$4"
+connections="$5"
 
 echo $server_ipaddr | grep -F ':' > /dev/null
 if [ $? -eq 0 ]; then
@@ -55,13 +56,21 @@ while true ; do
 		continue;
 	fi
 
-	# Login to the server
-	curl -s -g "http://$server_ipaddr/$filename" > /dev/null 2>&1 &
+	curl --noproxy '*' -s -g "http://$server_ipaddr/$filename" \
+		-o /dev/null &
 done
 
 killall -qw -s SIGPIPE curl
 
-curl -g "http://$server_ipaddr/$filename" -o /dev/null || \
+out=$(curl --noproxy '*' -sS -g "http://$server_ipaddr/$filename" -o /dev/null \
+	-w "time=%{time_total} size=%{size_download} speed=%{speed_download}")
+
+tst_resm TINFO "stat: $out"
+recv_filesize=$(echo "$out" | awk '{print $2}')
+
+if [ $recv_filesize != "size=$filesize" ]; then
+	tst_resm TINFO "expected file size '$filesize'"
 	tst_brkm TBROK "Failed to get http://$server_ipaddr/$filename"
+fi
 
 tst_exit
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
