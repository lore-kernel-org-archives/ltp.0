From: Yuan Sun <sunyuan3@huawei.com>
Date: Thu, 15 Oct 2015 09:21:28 +0800
Subject: [LTP] [PATCH 1/2] Optimise grep action in power_management.
Message-ID: <1444872089-30094-1-git-send-email-sunyuan3@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

root@p1:~# time (grep siblings /proc/cpuinfo > /dev/null)
real	0m0.003s
user	0m0.001s
sys	0m0.002s
root@p1:~# time (cat /proc/cpuinfo | grep siblings > /dev/null)
real	0m0.004s
user	0m0.002s
sys	0m0.003s

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/power_management/pm_include.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
index 366c914..807a5a8 100755
--- a/testcases/kernel/power_management/pm_include.sh
+++ b/testcases/kernel/power_management/pm_include.sh
@@ -87,8 +87,8 @@ get_supporting_govr() {
 }
 
 is_hyper_threaded() {
-	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
+	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
+	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq | cut -f2 -d':'`
 	[ $siblings -gt $cpu_cores ]; echo $?
 }
 
@@ -131,8 +131,8 @@ is_multi_socket() {
 }
 
 is_multi_core() {
-	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
+	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
+	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq | cut -f2 -d':'`
 	if [ $siblings -eq $cpu_cores ]; then
 		[ $cpu_cores -gt 1 ]; echo $?
 	else
@@ -142,8 +142,8 @@ is_multi_core() {
 }
 
 is_dual_core() {
-	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq \
+	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
+        cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq \
 			| cut -f2 -d':'`
         if [ $siblings -eq $cpu_cores ]; then
                 [ $cpu_cores -eq 2 ]; echo $?
-- 
1.9.1

