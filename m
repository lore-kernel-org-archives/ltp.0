From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Oct 2016 15:34:39 +0200
Subject: [LTP] [PATCH] cgroup_fj_function.sh: Wait for $pid before cleanup
Message-ID: <20161017133439.GA29155@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There seems to be rare race condition where the ltp subgroup created for
the test cannot be removed:

...
cgroup_fj_function2_cpu 9 TPASS : Set /sys/fs/cgroup/cpu,cpuacct/ltp/ltp_1/notify_on_release to 1
cgroup_fj_function2_cpu 10 TINFO : Removing all ltp subgroups...
rmdir: failed to remove '/sys/fs/cgroup/cpu,cpuacct/ltp/': Device or resource busy

The reason for the failure is likely the cgroup_fj_proc that ends up in
tasks for the ltp/ subgroup after test5(). This patch simply adds a
'wait $pid' after the 'kill -9 $pid' to avoid it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 006798a..633f256 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -207,7 +207,8 @@ test7
 test8
 test9
 
-ROD rmdir "$start_path/ltp_1"
 ROD kill -9 $pid
+wait $pid
+ROD rmdir "$start_path/ltp_1"
 
 tst_exit
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
