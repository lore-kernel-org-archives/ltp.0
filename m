From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Oct 2017 19:11:58 +0300
Subject: [LTP] [PATCH 3/4] tst_netload: support new -F option for netstress
	client
In-Reply-To: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
References: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1508947919-3553-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 030dd9e..78f8629 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -414,7 +414,7 @@ tst_netload()
 	local s_opts=
 
 	OPTIND=0
-	while getopts :a:H:d:n:N:r:R:b:t:T:fe:m: opt; do
+	while getopts :a:H:d:n:N:r:R:b:t:T:fFe:m: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
 		H) c_opts="${c_opts}-H $OPTARG " ;;
@@ -429,6 +429,7 @@ tst_netload()
 		   type="$OPTARG" ;;
 		m) cs_opts="${cs_opts}-m $OPTARG " ;;
 		f) cs_opts="${cs_opts}-f " ;;
+		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
 		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
-- 
1.7.1

