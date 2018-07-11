From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 11 Jul 2018 13:29:23 +0100
Subject: [LTP] [PATCH 2/4] quota_remount_test01: Add explicit check for
	dependencies
In-Reply-To: <20180711122925.24278-1-punit.agrawal@arm.com>
References: <20180711122925.24278-1-punit.agrawal@arm.com>
Message-ID: <20180711122925.24278-3-punit.agrawal@arm.com>
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
 testcases/kernel/fs/quota_remount/quota_remount_test01.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index 24f41aec1..8fa9ffc9f 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -41,6 +41,8 @@ export TCID=quota_remount_test01
 export TST_TOTAL=1
 export TST_COUNT=0
 
+. test.sh
+
 if [ -z $TMPDIR ]
 then
 	TMPDIR=/tmp
@@ -58,6 +60,8 @@ if [ ! -d /proc/sys/fs/quota ]; then
         exit 0
 fi
 
+tst_check_cmds quotacheck quotaon
+
 die()
 {
 	echo >&2 $2
-- 
2.17.1

