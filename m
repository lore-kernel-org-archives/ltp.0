From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 11 May 2017 14:20:56 +0800
Subject: [LTP] [PATCH 3/3] commands/keyctl01: Enable this test for RHEL6
In-Reply-To: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1494483656-15971-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This bug also happened on RHEL6 and was introduced in 2.6.32-254.el6,
so add RHEL6's kernel as target as well.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/commands/keyctl/keyctl01.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 8ea2b25..40183b0 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -37,8 +37,9 @@ TST_NEEDS_CMDS="keyctl"
 
 setup()
 {
-	if tst_kvcmp -le 2.6.33; then
-		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
+	if tst_kvcmp -le '2.6.33 RHEL6:2.6.32-254'; then
+		tst_brk TCONF \
+			"Kernel newer than 2.6.33 or 2.6.32-254.el6 is needed"
 	fi
 
 	PATH_KEYSTAT="/proc/key-users"
-- 
1.8.4.2



