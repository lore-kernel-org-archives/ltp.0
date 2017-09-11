From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Sep 2017 15:59:51 +0300
Subject: [LTP] [PATCH COMMITTED 2/2] netstress: fix timeout option
In-Reply-To: <1505134791-13246-1-git-send-email-alexey.kodanev@oracle.com>
References: <1505134791-13246-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1505134791-13246-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'-T' is used for type (tcp, udp, dccp, sctp).

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh               |    3 ++-
 testcases/network/netstress/netstress.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 6c35cb2..26185bf 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -407,7 +407,7 @@ tst_netload()
 	local s_opts=
 
 	OPTIND=0
-	while getopts :a:H:d:n:N:r:R:b:t:T:fe: opt; do
+	while getopts :a:H:d:n:N:r:R:b:t:T:fe:m: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
 		H) c_opts="${c_opts}-H $OPTARG " ;;
@@ -420,6 +420,7 @@ tst_netload()
 		t) cs_opts="${cs_opts}-t $OPTARG " ;;
 		T) cs_opts="${cs_opts}-T $OPTARG "
 		   type="$OPTARG" ;;
+		m) cs_opts="${cs_opts}-m $OPTARG " ;;
 		f) cs_opts="${cs_opts}-f " ;;
 		e) expect_res="$OPTARG" ;;
 		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 224dc43..4b211aa 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -826,7 +826,7 @@ static struct tst_option options[] = {
 	{"r:", &rarg, "-r x     Number of client requests"},
 	{"n:", &narg, "-n x     Client message size"},
 	{"N:", &Narg, "-N x     Server message size"},
-	{"T:", &Targ, "-T x     Reply timeout in microsec."},
+	{"m:", &Targ, "-m x     Reply timeout in microsec."},
 	{"d:", &rpath, "-d x     x is a path to file where result is saved\n"},
 
 	{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
-- 
1.7.1

