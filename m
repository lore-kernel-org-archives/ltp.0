From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon, 13 Sep 2021 19:37:45 +0300
Subject: [LTP] [PATCH v1 3/3] realtime:profiles: support hrtimer-prio
In-Reply-To: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
References: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210913163745.28108-3-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/profiles/default | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/realtime/profiles/default b/testcases/realtime/profiles/default
index b0bb6b890..440096fbe 100644
--- a/testcases/realtime/profiles/default
+++ b/testcases/realtime/profiles/default
@@ -46,11 +46,15 @@ func/matrix_mult		matrix_mult -c 0.75
 # Default maxduration=0.5 s
 func/thread_clock		tc-2 -c 0.5
 
+# Pass if maximum timer latency is less than criterium (us).
+# Default latency=10 us
+func/hrtimer-prio       hrtimer-prio
+
 # The below tests have no pass/fail criterium.
 func/gtod_latency		gtod_latency
 func/sched_jitter		sched_jitter
-func/periodic_cpu_load		periodic_cpu_load
-func/periodic_cpu_load		periodic_cpu_load_single
+func/periodic_cpu_load	periodic_cpu_load
+func/periodic_cpu_load	periodic_cpu_load_single
 func/prio-wake			prio-wake
 func/sched_football		sched_football
 func/pi-tests			testpi-0
@@ -60,4 +64,4 @@ func/pi-tests			testpi-4
 func/pi-tests			testpi-5
 func/pi-tests			testpi-6
 func/pi-tests			sbrk_mutex
-func/rt-migrate                 rt-migrate
+func/rt-migrate         rt-migrate
-- 
2.32.0

