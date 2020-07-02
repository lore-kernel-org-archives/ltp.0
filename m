From: Harish <harish@linux.ibm.com>
Date: Thu,  2 Jul 2020 16:03:58 +0530
Subject: [LTP] [PATCH v2] numa01.sh: Fix parsing numastat for given node
Message-ID: <20200702103358.38892-1-harish@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In few systems, the node numbering is not necessarily ordered.
E.g.

Per-node process memory usage (in MBs) for PID 2069 (systemd-udevd)
                           Node 0          Node 8           Total
                  --------------- --------------- ---------------
...
...
----------------  --------------- --------------- ---------------
Total                       17.50            0.00           17.50

Patch fixes parsing numastat for given node by finding its awk
index so that proper value is utilized in the test.

Fixes: 702
Signed-off-by: Harish <harish@linux.ibm.com>
---
Changes from v1:
* Rebased on top of http://lists.linux.it/pipermail/ltp/2020-July/017893.html
* Added Fixes tag

---
 testcases/kernel/numa/numa01.sh | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index a217db033..0521794e9 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -25,6 +25,17 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
 
 . tst_test.sh
 
+# Awk the field matching the node value for numastat
+# $1 - Pid number
+# $2 - Node number
+get_node_index()
+{
+       local pid=$1
+       local nid="Node $2"
+       echo $(numastat -p $pid | sed '3q;d' | awk -F '[[:space:]][[:space:]]+' \
+               -v node="$nid" '{ for (i = 1; i <= NF; ++i) if($i==node) print i; exit }')
+}
+
 # Convert the value of given numa node from the `numastat -p` output,
 # multiply by size.
 # $1 - Pid number
@@ -33,9 +44,9 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
 get_mem_cur()
 {
 	local pid=$1
-	local node=$(($2 + 2))
+	local index=$(echo "$(get_node_index $pid $2)")
 	local size=$3
-	local numstat=$(numastat -p $pid |awk '/^Total/ {print $'$node'}')
+	local numstat=$(numastat -p $pid |awk '/^Total/ {print $'$index'}')
 
 	if [ -z "$numstat" ]; then
 		echo 0
@@ -350,7 +361,8 @@ test9()
 		pid=$!
 		TST_RETRY_FUNC "check_for_support_numa $pid" 0
 
-		Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print $'$((node+2))'}'))
+		local index=$(echo "$(get_node_index $pid $node)")
+		Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print $'$index'}'))
 		Mem_huge=$((${Mem_huge%.*} * 1024))
 
 		if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
-- 
2.25.4

