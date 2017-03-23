From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Mar 2017 19:12:37 +0300
Subject: [LTP] [PATCH v2 5/5] test_net.sh: search SCTP listening sockets
	with netstat
In-Reply-To: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
References: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1490285557-18122-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

More details here, SCTP support in ss:
https://bugzilla.redhat.com/show_bug.cgi?id=1063934

and netstat usage of '-a' option instead of '-l':
https://bugzilla.redhat.com/show_bug.cgi?id=1063913

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: new patch in v2

 testcases/lib/test_net.sh |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index c8863e7..49e7129 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -307,7 +307,7 @@ tst_netload()
 	local rfile="tst_netload.res"
 	local expect_res="pass"
 	local ret=0
-
+	local type=
 	# common options for client and server
 	local cs_opts=
 
@@ -331,7 +331,8 @@ tst_netload()
 		R) s_replies="$OPTARG" ;;
 		b) cs_opts="${cs_opts}-b $OPTARG " ;;
 		t) cs_opts="${cs_opts}-t $OPTARG " ;;
-		T) cs_opts="${cs_opts}-T $OPTARG " ;;
+		T) cs_opts="${cs_opts}-T $OPTARG "
+		   type="$OPTARG" ;;
 		f) cs_opts="${cs_opts}-f " ;;
 		e) expect_res="$OPTARG" ;;
 		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
@@ -355,8 +356,16 @@ tst_netload()
 
 	tst_resm TINFO "check that server port in 'LISTEN' state"
 	local sec_waited=
+
+	local sock_cmd=
+	if [ "$type" = "sctp" ]; then
+		sock_cmd="netstat -naS | grep $port | grep -q LISTEN"
+	else
+		sock_cmd="ss -ldutn | grep -q $port"
+	fi
+
 	for sec_waited in $(seq 1 600); do
-		tst_rhost_run -c "ss -ldutn | grep -q $port" && break
+		tst_rhost_run -c "$sock_cmd" && break
 		if [ $sec_waited -eq 600 ]; then
 			tst_rhost_run -c "ss -dutnp | grep $port"
 			tst_brkm TFAIL "server not in LISTEN state"
-- 
1.7.1

