Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZA6VY-0002BW-EP
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 01:08:12 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZA6VS-0002rl-M8
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 01:08:12 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Wed, 1 Jul 2015 09:07:25 +0800
Message-ID: <1435712845-11717-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuctl: correct wrong TCID
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c         | 3 +--
 testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c         | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c         | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c         | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_latency_check_task.c | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_latency_test.c       | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_test02.c             | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_test03.c             | 2 +-
 testcases/kernel/controllers/cpuctl/cpuctl_test04.c             | 2 +-
 testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh   | 2 +-
 testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh          | 2 +-
 11 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index ae6a374..0dabe23 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -68,8 +68,7 @@
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
 #define NUM_SETS	4	/* How many share values (with same ratio) */
 #define MULTIPLIER   	10	/* Rate at which share value gets multiplied */
-
-char *TCID = "cpu_controller_tests";
+char *TCID = "cpuctl_def_task01";
 int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[FILENAME_MAX] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 5fb3559..c2bb435 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -64,7 +64,7 @@
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
 
-char *TCID = "cpu_controller_test04";
+char *TCID = "cpuctl_def_task02";
 int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index af4695f..0fe1c58 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -65,7 +65,7 @@
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
 
-char *TCID = "cpu_controller_test06";
+char *TCID = "cpuctl_def_task03";
 int TST_TOTAL = 3;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 9a7da9b..f1cf4f8 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -65,7 +65,7 @@
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
 
-char *TCID = "cpu_controller_test06";
+char *TCID = "cpuctl_def_task04";
 int TST_TOTAL = 2;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_latency_check_task.c b/testcases/kernel/controllers/cpuctl/cpuctl_latency_check_task.c
index 47a2be8..fd82362 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_latency_check_task.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_latency_check_task.c
@@ -64,7 +64,7 @@
 #define info	printf("The results FAIL is just intuitive and not exact" \
 		" failure. Please look at cpuctl_testplan.txt in the test directory.\n");
 
-char *TCID = "cpuctl_latency_tests";
+char *TCID = "cpuctl_latency_test01";
 int TST_COUNT = 1;
 int TST_TOTAL = 1;
 pid_t script_pid;
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_latency_test.c b/testcases/kernel/controllers/cpuctl/cpuctl_latency_test.c
index 3b53f4d..79dd96f 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_latency_test.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_latency_test.c
@@ -51,7 +51,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 
-char *TCID = "cpu_controller_latency_tests";
+char *TCID = "cpuctl_latency_test02";
 int TST_TOTAL = 2;
 
 void sighandler(int i)
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index 3669a5d..e4c9672 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -65,7 +65,7 @@
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
 
-char *TCID = "cpu_controller_test04";
+char *TCID = "cpu_controller_test02";
 int TST_TOTAL = 1;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index 20dbf86..925ee94 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -65,7 +65,7 @@
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
 
-char *TCID = "cpu_controller_test06";
+char *TCID = "cpu_controller_test03";
 int TST_TOTAL = 3;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index c332f29..6c260a6 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -65,7 +65,7 @@
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
 
-char *TCID = "cpu_controller_test06";
+char *TCID = "cpu_controller_test04";
 int TST_TOTAL = 2;
 pid_t scriptpid;
 char path[] = "/dev/cpuctl";
diff --git a/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh b/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
index 443ee14..dd5d731 100755
--- a/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
+++ b/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
@@ -48,7 +48,7 @@
 #################################################################################
 
 
-export TCID="cpuctl_test06";
+export TCID="cpuctl_stress_test";
 export TST_TOTAL=4;
 export TST_COUNT=1;	# how to tell here ??
 
diff --git a/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh b/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
index 67834ab..c606f7d 100755
--- a/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
+++ b/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
@@ -44,7 +44,7 @@
 #################################################################################
 
 
-export TCID="cpuctl_test01";
+export TCID="cpuctl_test";
 export TST_TOTAL=1;
 export TST_COUNT=1;
 
-- 
1.9.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
