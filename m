From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 16 Feb 2016 13:08:03 +0300
Subject: [LTP] [PATCH] df01: use the POSIX output format
Message-ID: <1455617283-3636-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the test block device has a long name, then 'df' will output
its statistics in multiple strings. For example:

/dev/mapper/vg-averylongnameyes
                         99150      1550     92480   2% /tmp/mntpoint

Therefore, grepping for the device name will not give desired results.

We could format the output before grepping, but 'df' already provides
option '-P' to ease parsing, so let's use it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/commands/df/df01.sh |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index f03c9ce..4505aec 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -75,26 +75,28 @@ EOF
 
 df_test()
 {
-	df_verify $1
+	cmd="$1 -P"
+
+	df_verify $cmd
 	if [ $? -ne 0 ]; then
 		return
 	fi
 
-	df_check $1
+	df_check $cmd
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "'$1' failed, not expected."
+		tst_resm TFAIL "'$cmd' failed, not expected."
 		return
 	fi
 
 	ROD_SILENT dd if=/dev/zero of=mntpoint/testimg bs=1024 count=1024
 
-	df_verify $1
+	df_verify $cmd
 
-	df_check $1
+	df_check $cmd
 	if [ $? -eq 0 ]; then
-		tst_resm TPASS "'$1' passed."
+		tst_resm TPASS "'$cmd' passed."
 	else
-		tst_resm TFAIL "'$1' failed."
+		tst_resm TFAIL "'$cmd' failed."
 	fi
 
 	ROD_SILENT rm -rf mntpoint/testimg
@@ -121,7 +123,7 @@ df_verify()
 
 df_check()
 {
-	if [ "$(echo $@)" = "df -i" ]; then
+	if [ "$(echo $@)" = "df -i -P" ]; then
 		local total=$(stat -f mntpoint --printf=%c)
 		local free=$(stat -f mntpoint --printf=%d)
 		local used=$((total-free))
@@ -209,16 +211,18 @@ test11()
 
 test12()
 {
-	df_verify "df -x ${DF_FS_TYPE}"
+	cmd="df -x ${DF_FS_TYPE} -P"
+
+	df_verify $cmd
 	if [ $? -ne 0 ]; then
 		return
 	fi
 
 	grep ${TST_DEVICE} output | grep -q mntpoint
 	if [ $? -ne 0 ]; then
-		tst_resm TPASS "'df -x ${FS_TYPE}' passed."
+		tst_resm TPASS "'$cmd' passed."
 	else
-		tst_resm TFAIL "'df -x ${FS_TYPE}' failed."
+		tst_resm TFAIL "'$cmd' failed."
 	fi
 }
 
-- 
1.7.1

