From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Sep 2018 17:44:40 +0300
Subject: [LTP] [RFC PATCH 3/5] runtest/sched: removed sched_{set,
	get}attr test cases
In-Reply-To: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1536849882-28897-4-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All these test cases do not fall into the category of
"Scheduler Stress Tests", so their better location is in runtest/syscalls,
where they are already defined.

Both runtest/sched and runtest/syscalls are part of the default
scenario, these test cases will be executed in a default run anyway.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/sched | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/runtest/sched b/runtest/sched
index 774d11f..bfc4f27 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -9,10 +9,6 @@ trace_sched01		trace_sched -c 1
 hackbench01 hackbench 50 process 1000
 hackbench02 hackbench 20 thread 1000
 
-sched_setattr01 sched_setattr01
-sched_getattr01 sched_getattr01
-sched_getattr02 sched_getattr02
-
 sched_cli_serv run_sched_cliserv.sh
 # Run this stress test for 2 minutes
 sched_stress sched_stress.sh
-- 
1.8.3.1

