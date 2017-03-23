From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Mar 2017 19:12:34 +0300
Subject: [LTP] [PATCH v2 2/5] net: apply new usage of netstress tool with
	'-T' option
In-Reply-To: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
References: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1490285557-18122-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: new patch in v2

 testcases/lib/test_net.sh                  |    4 ++--
 testcases/network/busy_poll/busy_poll03.sh |    2 +-
 testcases/network/stress/udp/udp_ipsec.sh  |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index e4336d3..ca22083 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -320,7 +320,7 @@ tst_netload()
 	local s_opts=
 
 	OPTIND=0
-	while getopts :a:H:d:n:N:r:R:b:t:Ufe: opt; do
+	while getopts :a:H:d:n:N:r:R:b:t:T:fe: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
 		H) c_opts="${c_opts}-H $OPTARG " ;;
@@ -331,7 +331,7 @@ tst_netload()
 		R) s_replies="$OPTARG" ;;
 		b) cs_opts="${cs_opts}-b $OPTARG " ;;
 		t) cs_opts="${cs_opts}-t $OPTARG " ;;
-		U) cs_opts="${cs_opts}-U " ;;
+		T) cs_opts="${cs_opts}-T $OPTARG " ;;
 		f) cs_opts="${cs_opts}-f " ;;
 
 		e) expect_res="$OPTARG" ;;
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 4ab93dc..628b1b4 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -49,7 +49,7 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 for x in 50 0; do
 	tst_resm TINFO "set low latency busy poll to $x per socket"
 	set_busy_poll $x
-	tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x -U
+	tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x -T udp
 done
 
 poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 8e047a4..e4b0f52 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -38,7 +38,7 @@ do_test()
 	IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-100 1000 65000}"
 
 	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -U -n $p -N $p \
+		tst_netload -H $(tst_ipaddr rhost) -T udp -n $p -N $p \
 			-r $client_requests
 	done
 }
-- 
1.7.1

