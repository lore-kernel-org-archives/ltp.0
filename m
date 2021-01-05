From: luofenglin (A) <luofenglin1@huawei.com>
Date: Tue, 5 Jan 2021 12:44:09 +0000
Subject: [LTP] [ping] [PATCH 1/3] sched/sched_stress: Modify sched driver
Message-ID: <d8886954e04a4f8a9e6ef210e63bd14c@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ping?

Message: 1
Date: Tue, 1 Dec 2020 19:49:24 +0800
From: Luo Fenglin <luofenglin1@huawei.com>
To: <ltp@lists.linux.it>
Cc: <claire.chenyue@huawei.com>, <qiangqiang.wangqiang@huawei.com>,
	luofenglin <luofenglin1@huawei.com>
Subject: [LTP] [PATCH 1/3] sched/sched_stress: Modify sched driver
	param to run long term testcases
Message-ID:
	<1606823366-121520-1-git-send-email-luofenglin1@huawei.com>
Content-Type: text/plain

From: luofenglin <luofenglin1@huawei.com>

Add sched_driver process slots param to 10, then long term testcases can run.
Additionally, add sched_driver run time 0.05 hour, long term testcases run 1/5 of total time.

Signed-off-by: luofenglin <luofenglin1@huawei.com>
---
 testcases/kernel/sched/sched_stress/sched_driver.c  | 6 +++++-  testcases/kernel/sched/sched_stress/sched_stress.sh | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/sched_stress/sched_driver.c b/testcases/kernel/sched/sched_stress/sched_driver.c
index 61573d788..1bee9d130 100644
--- a/testcases/kernel/sched/sched_stress/sched_driver.c
+++ b/testcases/kernel/sched/sched_stress/sched_driver.c
@@ -202,8 +202,12 @@ int main(int argc, char **argv)

 	/*
 	 * Start the long-term testcases running
+	 * Run time set 1/5 of total
 	 */
-	start_long_term_testcases(long_term_slot_total, argv[2]);
+	char run_long_term_time[20];
+	int runlongtime = runseconds / 5;
+	sprintf(run_long_term_time, "%d", runlongtime);
+	start_long_term_testcases(long_term_slot_total, run_long_term_time);
 	short_term_slot_total = workslots / 2;
 	fflush(stdout);

diff --git a/testcases/kernel/sched/sched_stress/sched_stress.sh b/testcases/kernel/sched/sched_stress/sched_stress.sh
index 797d0601b..0205446a7 100755
--- a/testcases/kernel/sched/sched_stress/sched_stress.sh
+++ b/testcases/kernel/sched/sched_stress/sched_stress.sh
@@ -30,6 +30,7 @@ export KERNEL=./sched_datafile  touch $KERNEL  echo 0.000000 > sch.measure  export RAWDEV=`df / | grep dev | awk {'print $1'}` -sched_driver -s 0.9 -t 0.02 -p 2 > /tmp/tmp$$
+echo "Result file: /tmp/tmp$$"
+sched_driver -s 0.9 -t 0.05 -p 10 -d > /tmp/tmp$$
 tail -n 5 /tmp/tmp$$
 rm -rf /tmp/tmp$$ ./sched_datafile sch.measure
--
2.17.1



------------------------------

Message: 2
Date: Tue, 1 Dec 2020 19:49:25 +0800
From: Luo Fenglin <luofenglin1@huawei.com>
To: <ltp@lists.linux.it>
Cc: <claire.chenyue@huawei.com>, <qiangqiang.wangqiang@huawei.com>,
	luofenglin <luofenglin1@huawei.com>
Subject: [LTP] [PATCH 2/3] sched/sched_stress: Fixed param of sched_tc
Message-ID:
	<1606823366-121520-2-git-send-email-luofenglin1@huawei.com>
Content-Type: text/plain

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
 	for (i = 0; i < (long_term_slot_total / 4); i++) {  #if defined(_IA64) && !defined(__64BIT__)
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

 	for (i = 0; i < (short_term_slots / 4); i++) {  #if defined(_IA64) && !defined(__64BIT__)
-		start_testcase("./sched_tc1.32", "sched_tc1", "1", NULL, NULL,
+		start_testcase("./sched_tc1.32", "sched_tc1", "-pfixed", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc3.32", "sched_tc3", "1", NULL, NULL,
+		start_testcase("./sched_tc3.32", "sched_tc3", "-pfixed", "-d", NULL,
 			       NULL);
-		start_testcase("./sched_tc1.32", "sched_tc1", "0", NULL, NULL,
+		start_testcase("./sched_tc1.32", "sched_tc1", "-pvariable", "-d", 
+NULL,
 			       NULL);
-		start_testcase("./sched_tc3.32", "sched_tc3", "0", NULL, NULL,
+		start_testcase("./sched_tc3.32", "sched_tc3", "-pvariable", "-d", 
+NULL,
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



------------------------------

Message: 3
Date: Tue, 1 Dec 2020 19:49:26 +0800
From: Luo Fenglin <luofenglin1@huawei.com>
To: <ltp@lists.linux.it>
Cc: <claire.chenyue@huawei.com>, <qiangqiang.wangqiang@huawei.com>,
	luofenglin <luofenglin1@huawei.com>
Subject: [LTP] [PATCH 3/3] sched/sched_stress: Bugfix for setting real
	time priority
Message-ID:
	<1606823366-121520-3-git-send-email-luofenglin1@huawei.com>
Content-Type: text/plain

From: luofenglin <luofenglin1@huawei.com>

When real time flag is set, setpriority function is used for user-time policy setting, here use sched_setscheduler to set real time policy RR instead

Signed-off-by: luofenglin <luofenglin1@huawei.com>
---
 testcases/kernel/sched/sched_stress/sched.h     |  2 ++
 testcases/kernel/sched/sched_stress/sched_tc0.c | 10 ++++++----  testcases/kernel/sched/sched_stress/sched_tc1.c | 10 ++++++----  testcases/kernel/sched/sched_stress/sched_tc2.c | 10 ++++++----  testcases/kernel/sched/sched_stress/sched_tc3.c | 10 ++++++----  testcases/kernel/sched/sched_stress/sched_tc4.c |  9 +++++----  testcases/kernel/sched/sched_stress/sched_tc5.c |  9 +++++----  testcases/kernel/sched/sched_stress/sched_tc6.c |  8 +++++---
 8 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/sched/sched_stress/sched.h b/testcases/kernel/sched/sched_stress/sched.h
index 8ed941eba..bcdecacc5 100644
--- a/testcases/kernel/sched/sched_stress/sched.h
+++ b/testcases/kernel/sched/sched_stress/sched.h
@@ -46,8 +46,10 @@
 #include <time.h>
 #include <errno.h>
 #include <stdio.h>
+#include <sched.h>

 #define DEFAULT_PRIORITY 70
+#define SET_RT_SCHEDULER(paraA, paraB, paraC) sched_setscheduler(paraA, 
+paraB, paraC)

 #if 0
 int  openlog (char *);
diff --git a/testcases/kernel/sched/sched_stress/sched_tc0.c b/testcases/kernel/sched/sched_stress/sched_tc0.c
index 9acbc2f58..290ad1e63 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc0.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc0.c
@@ -90,7 +90,9 @@ int verbose = 0;
 int debug = 0;
 long execution_time = DEFAULT_EXECUTION_TIME;  char *priority = DEFAULT_PRIORITY_TYPE;
-
+struct sched_param param = {
+		.sched_priority = DEFAULT_PRIORITY
+};
 /*---------------------------------------------------------------------+
 |                                 main                                 |
 | ==================================================================== | @@ -127,10 +129,10 @@ int main(int argc, char **argv)
 	if (!strcmp(priority, "fixed")) {
 #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	}

diff --git a/testcases/kernel/sched/sched_stress/sched_tc1.c b/testcases/kernel/sched/sched_stress/sched_tc1.c
index c771ef421..17d32cd9d 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc1.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc1.c
@@ -72,7 +72,9 @@
 void process_file(char *);
 void parse_args(int, char **);
 void signal_handler();
-
+struct sched_param param = {
+	.sched_priority = DEFAULT_PRIORITY
+};
 /*
  * Global variables:
  *
@@ -128,10 +130,10 @@ int main(int argc, char **argv)
 	if (!strcmp(priority, "fixed")) {
 #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	}

diff --git a/testcases/kernel/sched/sched_stress/sched_tc2.c b/testcases/kernel/sched/sched_stress/sched_tc2.c
index 1e2e3e629..ef90cfd2d 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc2.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc2.c
@@ -47,7 +47,9 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include   "sched.h"
-
+struct sched_param param = {
+	.sched_priority = DEFAULT_PRIORITY
+};
 /*
  * Defines:
  *
@@ -129,10 +131,10 @@ int main(int argc, char **argv)
 	if (!strcmp(priority, "fixed")) {
 #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	}

diff --git a/testcases/kernel/sched/sched_stress/sched_tc3.c b/testcases/kernel/sched/sched_stress/sched_tc3.c
index 8064e9eda..913662172 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc3.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc3.c
@@ -95,7 +95,9 @@ int verbose = 0;
 int debug = 0;
 int signaled = 0;
 char *priority = DEFAULT_PRIORITY_TYPE;
-
+struct sched_param param = {
+	.sched_priority = DEFAULT_PRIORITY
+};
 /*---------------------------------------------------------------------+
 |                                 main                                 |
 | ==================================================================== | @@ -131,10 +133,10 @@ int main(int argc, char **argv)
 	if (!strcmp(priority, "fixed")) {
 #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	}

diff --git a/testcases/kernel/sched/sched_stress/sched_tc4.c b/testcases/kernel/sched/sched_stress/sched_tc4.c
index 5bffb6478..81a8e170c 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc4.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc4.c
@@ -99,7 +99,7 @@ int debug = 0;
 int priority = DEFAULT_PRIORITY;
 char *logfile = DEFAULT_LOGFILE;
 char *priority_type = DEFAULT_PRIORITY_TYPE;
-
+struct sched_param param;
 /*---------------------------------------------------------------------+
 |                                 main                                 |
 | ==================================================================== | @@ -133,10 +133,11 @@ int main(int argc, char **argv)
 	if (!strcmp(priority_type, "fixed")) {  #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		param.sched_priority = priority;
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	} else {
 		if (nice((priority - 50) - (nice(0) + 20)) < 0 && errno != 0) diff --git a/testcases/kernel/sched/sched_stress/sched_tc5.c b/testcases/kernel/sched/sched_stress/sched_tc5.c
index db5ce963c..c315f9ade 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc5.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc5.c
@@ -95,7 +95,7 @@ int debug = 0;
 int priority = DEFAULT_PRIORITY;
 char *logfile = DEFAULT_LOGFILE;
 char *priority_type = DEFAULT_PRIORITY_TYPE;
-
+struct sched_param param;
 /*---------------------------------------------------------------------+
 |                                 main                                 |
 | ==================================================================== | @@ -130,10 +130,11 @@ int main(int argc, char **argv)
 	if (!strcmp(priority_type, "fixed")) {  #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		param.sched_priority = priority;
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	} else {
 		if (nice((priority - 50) - (nice(0) + 20)) < 0 && errno != 0) diff --git a/testcases/kernel/sched/sched_stress/sched_tc6.c b/testcases/kernel/sched/sched_stress/sched_tc6.c
index e70e8f250..20987f571 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc6.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc6.c
@@ -117,6 +117,7 @@ char *logfile = DEFAULT_LOGFILE;  char *priority_type = DEFAULT_PRIORITY_TYPE;  struct flock flock_struct;  struct flock *flock_ptr = &flock_struct;
+struct sched_param param;

 int open_file(char *, int);

@@ -163,10 +164,11 @@ int main(int argc, char **argv)
 	if (!strcmp(priority_type, "fixed")) {  #ifndef __linux__
 		if (setpri(0, DEFAULT_PRIORITY) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #else
-		if (setpriority(PRIO_PROCESS, 0, 0) < 0)
-			sys_error("setpri failed", __FILE__, __LINE__);
+		param.sched_priority = priority;
+		if (SET_RT_SCHEDULER(0, SCHED_RR, &param) < 0)
+			sys_error("set rt pri failed", __FILE__, __LINE__);
 #endif
 	} else {
 		if (nice((priority - 50) - (nice(0) + 20)) < 0 && errno != 0)
--
2.17.1



------------------------------

Subject: Digest Footer

_______________________________________________
ltp mailing list
ltp@lists.linux.it
https://lists.linux.it/listinfo/ltp


------------------------------

End of ltp Digest, Vol 64, Issue 4
**********************************
