From: Luo Fenglin <luofenglin1@huawei.com>
Date: Fri, 16 Oct 2020 17:51:15 +0800
Subject: [LTP] [PATCH v2] sched/sched_stress:Fixed param of sched_tc
In-Reply-To: <1602841876-91490-1-git-send-email-luofenglin1@huawei.com>
References: <1602841876-91490-1-git-send-email-luofenglin1@huawei.com>
Message-ID: <1602841876-91490-2-git-send-email-luofenglin1@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: luofenglin <luofenglin1@huawei.com>

Rt flag of sched_tc must like "-pfixed" or "-pvariable"

Signed-off-by: luofenglin <luofenglin1@huawei.com>
---
 .../kernel/sched/sched_stress/sched_driver.c  | 51 ++++++++++---------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/sched/sched_stress/sched_driver.c b/testcases/kernel/sched/sched_stress/sched_driver.c
index 1bee9d130..475369b46 100644
--- a/testcases/kernel/sched/sched_stress/sched_driver.c
+++ b/testcases/kernel/sched/sched_stress/sched_driver.c
@@ -621,25 +621,28 @@ char *execution_time;		/* runtime hours to pass to each testcase */
 		printf("long-term slots available:  %d\n",
 		       long_term_slot_total);
 
+	char timeparam[30];
+	sprintf(timeparam, "-t%s", execution_time);
+
 	for (i = 0; i < (long_term_slot_total / 4); i++) {
 #if defined(_IA64) && !defined(__64BIT__)
-		start_testcase("./sched_tc0.32", "sched_tc0 -t", execution_time,
-			       " -p1", NULL, NULL);
-		start_testcase("./sched_tc2.32", "sched_tc2", execution_time,
-			       "1", NULL, NULL);
-		start_testcase("./sched_tc0.32", "sched_tc0 -t", execution_time,
-			       " -p0", NULL, NULL);
-		start_testcase("./sched_tc2.32", "sched_tc2", execution_time,
-			       "0", NULL, NULL);
+		start_testcase("./sched_tc0.32", "sched_tc0", timeparam,
+			       "-pfixed", "-d", NULL);
+		start_testcase("./sched_tc2.32", "sched_tc2", timeparam,
+			       "-pfixed", "-d", NULL);
+		start_testcase("./sched_tc0.32", "sched_tc0", timeparam,
+			       "-pvariable", "-d", NULL);
+		start_testcase("./sched_tc2.32", "sched_tc2", timeparam,
+			       "-pvariable", "-d", NULL);
 #else
-		start_testcase("./sched_tc0", "sched_tc0 -t", execution_time,
-			       " -p1", NULL, NULL);
-		start_testcase("./sched_tc2", "sched_tc2", execution_time, "1",
-			       NULL, NULL);
-		start_testcase("./sched_tc0", "sched_tc0 -t", execution_time,
-			       " -p0", NULL, NULL);
-		start_testcase("./sched_tc2", "sched_tc2", execution_time, "0",
-			       NULL, NULL);
+		start_testcase("./sched_tc0", "sched_tc0", timeparam,
+			       "-pfixed", "-d", NULL);
+		start_testcase("./sched_tc2", "sched_tc2", timeparam, "-pfixed",
+			       "-d", NULL);
+		start_testcase("./sched_tc0", "sched_tc0", timeparam,
+			       "-pvariable", "-d", NULL);
+		start_testcase("./sched_tc2", "sched_tc2", timeparam, "-pvariable",
+			       "-d", NULL);
 #endif
 	}
 }
@@ -674,22 +677,22 @@ void start_short_term_testcases(int short_term_slot_total,
 
 	for (i = 0; i < (short_term_slots / 4); i++) {
 #if defined(_IA64) && !defined(__64BIT__)
-		start_testcase("./sched_tc1.32", "sched_tc1", "1", NULL, NULL,
+		start_testcase("./sched_tc1.32", "sched_tc1", "-pfixed", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc3.32", "sched_tc3", "1", NULL, NULL,
+		start_testcase("./sched_tc3.32", "sched_tc3", "-pfixed", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc1.32", "sched_tc1", "0", NULL, NULL,
+		start_testcase("./sched_tc1.32", "sched_tc1", "-pvariable", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc3.32", "sched_tc3", "0", NULL, NULL,
+		start_testcase("./sched_tc3.32", "sched_tc3", "-pvariable", "-d", NULL,
 			       NULL);
 #else
-		start_testcase("./sched_tc1", "sched_tc1", "1", NULL, NULL,
+		start_testcase("./sched_tc1", "sched_tc1", "-pfixed", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc3", "sched_tc3", "1", NULL, NULL,
+		start_testcase("./sched_tc3", "sched_tc3", "-pfixed", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc1", "sched_tc1", "0", NULL, NULL,
+		start_testcase("./sched_tc1", "sched_tc1", "-pvariable", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc3", "sched_tc3", "0", NULL, NULL,
+		start_testcase("./sched_tc3", "sched_tc3", "-pvariable", "-d", NULL,
 			       NULL);
 #endif
 #if 0
-- 
2.17.1

