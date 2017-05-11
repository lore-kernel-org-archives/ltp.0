From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 11 May 2017 14:20:54 +0800
Subject: [LTP] [PATCH 1/3] commands/keyctl01: Fix potential infinite loop
Message-ID: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

End the loop when max key quota is less than or equal to current
key usage, in case some errors happen and result in endless loop.

We expect the test to trigger key quota excess which breaks the
loop but it may not happen, so add a TWARN message for this.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/commands/keyctl/keyctl01.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 076a130..5a97499 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -62,15 +62,17 @@ cleanup()
 
 do_test()
 {
+	local quota_excd=0
 	local maxkeysz=$((ORIG_KEYSZ + 100))
 
-	while true
+	while [ $maxkeysz -gt $ORIG_KEYSZ ]
 	do
 		echo $maxkeysz >$PATH_KEYQUOTA
 
 		keyctl request2 user debug:fred negate @t >temp 2>&1
 		grep -q -E "quota exceeded" temp
 		if [ $? -eq 0 ]; then
+			quota_excd=1
 			break
 		fi
 
@@ -83,6 +85,10 @@ do_test()
 		((maxkeysz -= 4))
 	done
 
+	if [ $quota_excd -eq 0 ]; then
+		tst_res TWARN "Failed to trigger the quota excess"
+	fi
+
 	tst_res TPASS "Bug not reproduced"
 }
 
-- 
1.8.4.2



