From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 14 Jun 2021 18:14:13 +0200
Subject: [LTP] [PATCH v2 2/2] controllers/cpuacct: fix rmdir failures on
 early test abort
In-Reply-To: <20210614161413.82389-1-krzysztof.kozlowski@canonical.com>
References: <20210614161413.82389-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210614161413.82389-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The "testpath" variable is assigned at the end of setup(), so if test
exits early, the "rmdir $testpath" is wrong:

    cpuacct 1 TCONF: not enough of memory on this system (less than 3840 MB)
    cpuacct 1 TINFO: removing created directories
    rmdir: missing operand
    Try 'rmdir --help' for more information.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None.
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 66a48dde679b..2e9ff5a5286c 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -127,12 +127,13 @@ cleanup()
 {
 	tst_res TINFO "removing created directories"
 
-	if [ -d "$testpath/subgroup_1" ]; then
-		rmdir $testpath/subgroup_*
+	if [ "$testpath" ]; then
+		if [ -d "$testpath/subgroup_1" ]; then
+			rmdir $testpath/subgroup_*
+		fi
+		rmdir $testpath
 	fi
 
-	rmdir $testpath
-
 	if [ "$mounted" -ne 1 ]; then
 		tst_res TINFO "Umounting cpuacct"
 		umount $mount_point
-- 
2.27.0

