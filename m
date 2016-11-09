From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  9 Nov 2016 17:34:53 +0300
Subject: [LTP] [PATCH] lsmod01: keep the output in variables
In-Reply-To: <20161011161557.GD17083@rei.suse.cz>
References: <20161011161557.GD17083@rei.suse.cz>
Message-ID: <1478702093-15080-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Operations with a file on NFS may increase the reference
counter of the corresponding module.

This test case creates temporary files in $TMPDIR, so if
$TMPDIR is on NFS, it may fail with output similar to:

  21c21
  < sunrpc 207591 28
  ---
  > sunrpc 207591 29

To overcome this problem it was proposed in [1] to keep the output
in variables.

[1] http://lists.linux.it/pipermail/ltp/2016-October/002803.html

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/commands/lsmod/lsmod01.sh |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 5cf2fee..cd19ca4 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -36,21 +36,25 @@ cleanup()
 
 lsmod_test()
 {
-	lsmod >temp 2>&1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "'lsmod' failed."
-		cat temp
+	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
+	if [ -z "$lsmod_output" ]; then
+		tst_resm TFAIL "Failed to parse the output from lsmod"
 		return
 	fi
 
-	awk '!/Module/{print $1, $2, $3}' temp |sort >temp1
-
-	awk '{print $1, $2, $3}' /proc/modules |sort >temp2
+	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
+	if [ -z "$modules_output" ]; then
+		tst_resm TFAIL "Failed to parse /proc/modules"
+		return
+	fi
 
-	diff temp1 temp2 >temp3
-	if [ $? -ne 0 ]; then
+	if [ "$lsmod_output" != "$modules_output" ]; then
 		tst_resm TFAIL "lsmod output different from /proc/modules."
-		cat temp3
+
+		echo "$lsmod_output" > temp1
+		echo "$modules_output" > temp2
+		diff temp1 temp2
+
 		return
 	fi
 
-- 
1.7.1

