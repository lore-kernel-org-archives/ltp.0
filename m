From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed,  1 Sep 2021 16:51:26 +0200
Subject: [LTP] [PATCH v4 2/3] controllers/cpuacct: skip cpuacct_100_100 on
 small memory systems
In-Reply-To: <20210901145127.92315-1-krzysztof.kozlowski@canonical.com>
References: <20210901145127.92315-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210901145127.92315-2-krzysztof.kozlowski@canonical.com>
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

The reason is cgroups pid limit set by systemd user.slice.  For example
on 2 GB RAM machine it is set as:
    /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207

Add a check for both free memory and maximum number of pids (when using
systemd) to skip the test.  Systems not using systemd might still fail.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v3:
1. Use tst_get_free_pids helper.

Changes since v2:
1. Correct realuid->real_uid typo.
2. Correct handling dash shell tests for return value.
3. Correct handling numbers - infinite.

Changes since v1:
1. Add checking for pids.
2. Accurately check the memory constraints.
---
 .../kernel/controllers/cpuacct/cpuacct.sh     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 323aa7513bf4..39f880a53996 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -38,12 +38,61 @@ OPTIONS
 EOF
 }
 
+check_free_memory()
+{
+	local memneeded
+	local memfree=`awk '/MemAvailable/ {print $2}' /proc/meminfo`
+
+	if [ $? -ne 0 ]; then
+		local memcached
+
+		memfree=`awk '/MemFree/ {print $2}' /proc/meminfo`
+		test $? -eq 0 || return 0
+
+		memcached=`awk '/MemCached/ {print $2}' /proc/meminfo`
+		test $? -eq 0 || return 0
+
+		memfree=$((memfree + memcached))
+	fi
+
+	# On x86_64, each 100 of processes were using ~16 MB of memory,
+	# so try to estimate the needed free memory based on this.
+	memneeded=$((max * nbprocess * 16384 / 100))
+
+	if [ $memfree -lt $memneeded ]; then
+		tst_brk TCONF "not enough of free memory on this system (approximate need $memneeded kB, free $memfree kB)"
+	fi
+	tst_res TINFO "memory requirements fulfilled (approximate need $memneeded kB, free $memfree kB)"
+
+	return 0
+}
+
+check_limits()
+{
+	local tasksneeded=$((max * nbprocess + 100))
+	local tasksmax=$(tst_get_free_pids)
+	test $? -eq 0 || return 0
+
+	if [ $tasksmax -le $tasksneeded ]; then
+		tst_brk TCONF "limit of tasks is too low (approximate need $tasksneeded, limit $tasksmax)"
+	fi
+	tst_res TINFO "task limit fulfilled (approximate need $tasksneeded, limit $tasksmax)"
+
+	return 0
+}
+
 setup()
 {
 	if ! grep -q -w cpuacct /proc/cgroups; then
 		tst_brk TCONF "cpuacct not supported on this system"
 	fi
 
+	check_limits
+	# Don't bother with memory limit checks on smaller tests
+	if [ $max -ge 100 ] && [ $nbprocess -ge 100 ]; then
+		check_free_memory
+	fi
+
 	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
 	tst_res TINFO "cpuacct: $mount_point"
 	if [ "$mount_point" = "" ]; then
-- 
2.30.2

