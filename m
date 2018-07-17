From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 17 Jul 2018 12:01:44 +0100
Subject: [LTP] [PATCH v2] quota_remount_test01: Add explicit check for
	dependencies
Message-ID: <20180717110144.28118-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

quota_remount_test01 doesn't check for dependencies before
execution. Add explicit checks for quotacheck and quotaon and bail out
if they are not present.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
v2:
* Replaced the use of test.sh with shell commands to check for test
  dependencies

 .../kernel/fs/quota_remount/quota_remount_test01.sh    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index 24f41aec1..04b7af922 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -58,6 +58,16 @@ if [ ! -d /proc/sys/fs/quota ]; then
         exit 0
 fi
 
+if ! command -v quotacheck > /dev/null 2>&1; then
+	tst_resm TCONF "'quotacheck' not found"
+	exit 0
+fi
+
+if ! command -v quotaon > /dev/null 2>&1; then
+	tst_resm TCONF "'quotaon' not found"
+	exit 0
+fi
+
 die()
 {
 	echo >&2 $2
-- 
2.17.1

