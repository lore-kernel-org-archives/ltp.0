From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Fri, 12 Jul 2019 20:05:05 +0800
Subject: [LTP] [PATCH] controllers/cpuset: improve the node number
 calculation for N_NODES
Message-ID: <20190712120505.28953-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BugLink: https://bugs.launchpad.net/bugs/1836188

It was spotted on a Power9 system with Ubuntu Cosmic installed, the
N_NODES obtained from the file contains only "0,8":
    $ cat /sys/devices/system/node/has_normal_memory
    0,8

This will cause the N_NODES calculation in cpuset_funcs.sh to fail with:
    cpuset_funcs.sh: arithmetic expression: expecting EOF: "0,8 + 1"

As it was not designed for counting the number of comma seperated nodes.

Improve this by splitting the file output with newlines, iterate through
them to count the number of nodes. If we ever encounter a sequence
format like "3-6", use shell substitution to get these two numbers and
with their difference plus 1 to get the number of nodes in this range.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../kernel/controllers/cpuset/cpuset_funcs.sh   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 935a41ed0..6861b8dbd 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -28,12 +28,21 @@
 
 NR_CPUS=`tst_ncpus`
 if [ -f "/sys/devices/system/node/has_high_memory" ]; then
-	N_NODES="`cat /sys/devices/system/node/has_high_memory`"
+	N_NODES="`cat /sys/devices/system/node/has_high_memory | tr ',' '\n'`"
 else
-	N_NODES="`cat /sys/devices/system/node/has_normal_memory`"
+	N_NODES="`cat /sys/devices/system/node/has_normal_memory | tr ',' '\n'`"
 fi
-N_NODES=${N_NODES#*-*}
-N_NODES=$(($N_NODES + 1))
+i=0
+while read item; do
+	count=1
+	if [ "${item#*-*}" != "$item" ]; then
+		count=$((${item#*-*} - ${item%*-*} + 1))
+	fi
+	i=$((i + $count))
+done <<EOL
+$N_NODES
+EOL
+N_NODES=$i
 
 CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
-- 
2.17.1

