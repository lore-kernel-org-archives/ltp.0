From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 26 Jun 2019 16:17:35 +0800
Subject: [LTP] [PATCH] runpwtests03: fix for module name retrieval
Message-ID: <20190626081735.31327-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The -l flag for modprobe has been deprecated in newer packages.
This will induce some noise during the execution:
    modprobe: invalid option -- 'l'

And making the "Loading and Unloading of governor kernel modules" test
not doing module load / unload operations.

Fix this by using the find command to retrieve module names instead.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/power_management/runpwtests03.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index 11197937f..81d44f9b1 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -118,8 +118,8 @@ pwkm_load_unload() {
 	RC=0
 	loaded_governor=`cat \
 		/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
-	for module in `modprobe -l | grep cpufreq_ | \
-		cut -f8 -d"/" | cut -f1 -d"."`
+	for module in `find /lib/modules/$(uname -r) -name "*cpufreq_*.ko" \
+		-printf "%f\n" | cut -f1 -d"."`
 	do
 		#echo -n "Loading $module ... "
 		if [ $module != "cpufreq_$loaded_governor" ]; then
@@ -131,8 +131,8 @@ pwkm_load_unload() {
 			fi
 		fi
 	done
-	for module in `modprobe -l | grep cpufreq_ | \
-		cut -f8 -d"/" | cut -f1 -d"."`
+	for module in `find /lib/modules/$(uname -r) -name "*cpufreq_*.ko" \
+		-printf "%f\n" | cut -f1 -d"."`
 		do
 		#echo -n "Unloading $module ... "
 		if [ $module != "cpufreq_$loaded_governor" ]; then
-- 
2.17.1

