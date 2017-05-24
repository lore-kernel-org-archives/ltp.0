From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 May 2017 11:40:29 +0300
Subject: [LTP] [PATCH 3/4] net/virt_lib.sh: don't use ROD_SILENT with shell
	function
In-Reply-To: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
References: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1495615230-29045-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 6036b42..05eaf0d 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -157,7 +157,8 @@ virt_multiple_add_test()
 	tst_resm TINFO "add $virt_count $virt_type, then delete"
 
 	for i in $(seq $start_id $max); do
-		ROD_SILENT "virt_add ltp_v$i id $i $opt"
+		virt_add ltp_v$i id $i $opt || \
+			tst_brkm TFAIL "failed to create 'ltp_v0 $opt'"
 		ROD_SILENT "ip link set ltp_v$i up"
 	done
 
@@ -177,7 +178,8 @@ virt_add_delete_test()
 	tst_resm TINFO "add/del $virt_type $virt_count times"
 
 	for i in $(seq 0 $max); do
-		ROD_SILENT "virt_add ltp_v0 $opt"
+		virt_add ltp_v0 $opt || \
+			tst_brkm TFAIL "failed to create 'ltp_v0 $opt'"
 		ROD_SILENT "ip link set ltp_v0 up"
 		ROD_SILENT "ip link delete ltp_v0"
 	done
@@ -190,7 +192,8 @@ virt_setup()
 	local opt_r="$2"
 
 	tst_resm TINFO "setup local ${virt_type} with '$opt'"
-	ROD_SILENT "virt_add ltp_v0 $opt"
+	virt_add ltp_v0 $opt || \
+		tst_brkm TBROK "failed to create 'ltp_v0 $opt'"
 
 	tst_resm TINFO "setup rhost ${virt_type} with '$opt_r'"
 	virt_add_rhost "$opt_r"
-- 
1.7.1

