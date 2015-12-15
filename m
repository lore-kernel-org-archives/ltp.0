From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 15 Dec 2015 11:16:57 +0800
Subject: [LTP] [PATCH] cgroup_fj/cgroup_fj_function2.sh: fix subsystem of ns
Message-ID: <1450149417-4573-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Pid could not be echoed from subgroup if subsystem is (or include) ns

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
index 5b8f7d8..d7be53d 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
@@ -163,7 +163,11 @@ case7()
 
 	sleep 1
 
-	do_echo 1 1 $pid $mount_point/tasks
+	if [ $subsystem == "ns" ]; then
+		echo "\"pid could not be echoed from subgroup if subsystem is (or include) ns\""
+	else
+		do_echo 1 1 $pid $mount_point/tasks
+	fi
 }
 
 case8()
-- 
1.8.3.1



