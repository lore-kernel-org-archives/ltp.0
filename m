From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Nov 2017 15:38:47 +0800
Subject: [LTP] [PATCH 1/2] memcg_lib.sh: fix the shmmax value comparison
Message-ID: <20171122073848.6172-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The value of /proc/sys/kernel/shmmax is 18446744073692774399 which Dash/Bash
fails to compare to the $HUGEPAGESIZE value and report error:

  memcg_lib.sh: line 81: [: 18446744073692774399: integer expression expected

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index d4724c3..6a6af85 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -78,7 +78,7 @@ TST_CLEANUP=cleanup
 shmmax_setup()
 {
 	shmmax=`cat /proc/sys/kernel/shmmax`
-	if [ $shmmax -lt $HUGEPAGESIZE ]; then
+	if [ $(echo "$shmmax < $HUGEPAGESIZE" |bc) -eq 1 ]; then
 		ROD echo "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
 	fi
 }
-- 
2.9.3

