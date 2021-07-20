From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 20 Jul 2021 16:34:14 +0200
Subject: [LTP] [PATCH] controllers/memcg_stress: fix order of process cleanup
Message-ID: <20210720143414.14599-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The memcg_stress_test was forking test processes and adding them to new
cgroup.  However cleanup - killing forked process and cgroup removal -
was iterating in mixed up order: killing the newest process but trying
to remove the oldest cgroup.

This could work if all processes died already via earlier "kill -USR1"
but at least in case of Ubuntu with v4.15 kernel this failed and left
cgroups not cleaned up:

    + kill -KILL 3147
    /home/azure/ltp-install/testcases/bin/memcg_stress_test.sh: 96: kill: No such process
    + wait 3147
    + rmdir /dev/memcg/0
    /home/azure/ltp-install/testcases/bin/memcg_stress_test.sh: 98: /home/azure/ltp-install/testcases/bin/memcg_stress_test.sh: Cannot fork

    $ ll /dev/memcg
    0    107  116  125  134  143  18  27  36  45  54  63  72  81  90
    1    108  117  126  135  144  19  28  37  46  55  64  73  82  91

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index cd75c704a9a4..c2501e164018 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -78,7 +78,7 @@ run_stress()
 		mkdir /dev/memcg/$i 2> /dev/null
 		memcg_process_stress $mem_size $interval &
 		echo $! > /dev/memcg/$i/tasks
-		pids="$! $pids"
+		pids="$pids $!"
 	done
 
 	for pid in $pids; do
-- 
2.27.0

