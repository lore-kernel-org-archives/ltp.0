From: Qais Yousef <qais.yousef@arm.com>
Date: Tue, 14 Jul 2020 16:25:10 +0100
Subject: [LTP] [PATCH] cpuset_hotplug_test.sh: Fix a race condition
Message-ID: <20200714152510.13470-1-qais.yousef@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cpuset performs hotplug updates asynchronously in the kernel. This would
lead to a race window where userspace could read a stale value before
the asynchronous update is performed (via a delayed work).

An attempt to fix the issue in the kernel failed.

https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/T/#u

There was a patch to make the update synchronous, but it hit a wall and
was dropped

https://lore.kernel.org/lkml/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/

The sleep is not ideal, but the maintainer has pushed back for a fix in
the kernel so far.

Fixes #693.
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 .../cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index e973de7b9..1337e0cd6 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -86,6 +86,11 @@ root_cpu_hotplug_test()
 		return 1
 	fi
 
+	# cpuset hotplug is asynchronous operation, we could end up reading a
+	# stale value here. sleep is aweful, but we can't do better.
+	# See https://github.com/linux-test-project/ltp/issues/693
+	sleep 1
+
 	root_cpus="`cat $CPUSET/cpuset.cpus`"
 
 	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
@@ -155,6 +160,11 @@ general_cpu_hotplug_test()
 		return 1
 	fi
 
+	# cpuset hotplug is asynchronous operation, we could end up reading a
+	# stale value here. sleep is aweful, but we can't do better.
+	# See https://github.com/linux-test-project/ltp/issues/693
+	sleep 1
+
 	cpus="`cat $path/cpuset.cpus`"
 
 	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
-- 
2.17.1

