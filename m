From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Wed, 22 Nov 2017 18:17:03 +0800
Subject: [LTP] [PATCH] runpwtests03:skip read check for the files without
	read permission
Message-ID: <1511345823-11979-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

According to the cpufreq-stats doc,cpufreq/stats/reset is
write-only attribute of cpu freq sysfs file.
So skip the cat checking for the files like this file which
has not read permission.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/power_management/runpwtests03.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index d4ea88b..1119793 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -32,7 +32,7 @@ check_cpufreq_sysfs_files() {
 	for cpu in $(seq 0 "${total_cpus}" )
 	do
 		cpufiles=$(find /sys/devices/system/cpu/cpu"${cpu}"/cpufreq/ \
-			-name "*" -type f)
+			-name "*" -type f -perm /400)
 		for files in ${cpufiles}
 		do
 			cat ${files} >/dev/null 2>&1
-- 
1.7.9.5

