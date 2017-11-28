From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 16:08:26 +0300
Subject: [LTP] [PATCH 4/6] tst_netload: support -S and -A netstress options
In-Reply-To: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
References: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1511874508-12360-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 83639e2..1e001f7 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -402,6 +402,8 @@ tst_netload()
 	local expect_res="pass"
 	local ret=0
 	local type="tcp"
+	local hostopt=
+	local setup_srchost=0
 	# common options for client and server
 	local cs_opts=
 
@@ -414,15 +416,19 @@ tst_netload()
 	local s_opts=
 
 	OPTIND=0
-	while getopts :a:H:d:n:N:r:R:b:t:T:fFe:m: opt; do
+	while getopts :a:H:d:n:N:r:R:S:b:t:T:fFe:m:A: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
-		H) c_opts="${c_opts}-H $OPTARG " ;;
+		H) c_opts="${c_opts}-H $OPTARG "
+		   hostopt="$OPTARG" ;;
 		d) rfile="$OPTARG" ;;
 		n) c_opts="${c_opts}-n $OPTARG " ;;
 		N) c_opts="${c_opts}-N $OPTARG " ;;
 		r) c_requests="$OPTARG" ;;
+		A) c_opts="${c_opts}-A $OPTARG " ;;
 		R) s_replies="$OPTARG" ;;
+		S) c_opts="${c_opts}-S $OPTARG "
+		   setup_srchost=1 ;;
 		b) cs_opts="${cs_opts}-b $OPTARG " ;;
 		t) cs_opts="${cs_opts}-t $OPTARG " ;;
 		T) cs_opts="${cs_opts}-T $OPTARG "
@@ -436,6 +442,8 @@ tst_netload()
 	done
 	OPTIND=0
 
+	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "
+
 	local expect_ret=0
 	[ "$expect_res" != "pass" ] && expect_ret=1
 
-- 
1.7.1

