From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 10 Jun 2021 12:09:26 +0200
Subject: [LTP] [PATCH 1/2] controllers/cpuacct: skip cpuacct_100_100 on
 small memory systems
Message-ID: <20210610100927.32015-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running cpuacct_100_100 on a system with less than ~4 GB of RAM fails:

    cpuacct 1 TINFO: timeout per run is 0h 5m 0s
    cpuacct 1 TINFO: cpuacct: /sys/fs/cgroup/cpu,cpuacct
    cpuacct 1 TINFO: Creating 100 subgroups each with 100 processes
    testcases/bin/cpuacct.sh: 0: Cannot fork

In dmesg:

    LTP: starting cpuacct_100_100 (cpuacct.sh 100 100)
    cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-1.scope

It seems system might not handle or not allow that amount of processes,
so simply skip the test.  The threshold of ~4 GB was found during
experimenting, so it is not accurate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 323aa7513bf4..2646018d295e 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -44,6 +44,20 @@ setup()
 		tst_brk TCONF "cpuacct not supported on this system"
 	fi
 
+	if [ $max -ge 100 ] && [ $nbprocess -ge 100 ]; then
+		local memtotal=`awk '/MemTotal/ {print $2}' /proc/meminfo`
+		if [ $? -eq 0 ]; then
+			# cpuacct.sh 100 100 will fail if memory is less
+			# than 4 GB with:
+			#   testcases/bin/cpuacct.sh: 0: Cannot fork
+			# Choose some limit of total memory, determined
+			# with experiments: 3*1024+768 MB = 3932160 kB
+			if [ $memtotal -lt 3932160 ]; then
+				tst_brk TCONF "not enough of memory on this system (less than 3840 MB)"
+			fi
+		fi
+	fi
+
 	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
 	tst_res TINFO "cpuacct: $mount_point"
 	if [ "$mount_point" = "" ]; then
-- 
2.27.0

