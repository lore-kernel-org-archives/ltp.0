Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VR0GS-0005UA-84
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:24 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VR0GO-000207-Lb
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:24 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 17:44:54 +0400
Message-Id: <1380635095-21403-8-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 7/8] cpuset/cpuset_load_balance_test: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

Fixed lack of '#include "config.h"', perform some cleanup
and set nr_cpus, nr_mems based on environment.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_load_balance_test/cpuset_cpu_hog.c      |   16 ++++++++--------
 .../cpuset_load_balance_test.sh                    |    4 ++--
 .../cpuset_sched_domains_check.c                   |    1 +
 .../cpuset_sched_domains_test.sh                   |    4 ++--
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
index 4b4e965..5dd2ced 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
@@ -20,6 +20,7 @@
 /*                                                                            */
 /******************************************************************************/
 
+#include "config.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -33,24 +34,23 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+char *TCID = "cpuset_cpu_hog";
+int TST_TOTAL = 1;
+
+#if HAVE_LINUX_MEMPOLICY_H
+
 #include "../cpuset_lib/common.h"
 #include "../cpuset_lib/bitmask.h"
 #include "../cpuset_lib/cpuset.h"
 
-#if HAVE_LINUX_MEMPOLICY_H
-
 #define MAX_NPROCS	1000
 #define USAGE	("Usage: %s [-p nprocs] [-h]\n"		\
 		 "\t-p nprocs\n"					\
 		 "\t\tThe num of the procs. [Default = 2 * nr_cpus]\n"	\
 		 "\t-h\tHelp.\n")
 
-char *TCID = "cpuset_cpu_hog";
-int TST_TOTAL = 1;
-
-unsigned long count;
-int nprocs;
-volatile int end;
+static int nprocs;
+static volatile int end;
 
 /*
  * report executing result to the parent by fifo
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 003e9cf..55f533a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -33,8 +33,8 @@ export TST_COUNT=1
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
-nr_cpus=4
-nr_mems=3
+nr_cpus=$NR_CPUS
+nr_mems=$N_NODES
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c
index 9fe4f01..15259e7 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_check.c
@@ -20,6 +20,7 @@
 /*                                                                            */
 /******************************************************************************/
 
+#include "config.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index 4547367..3ca70df 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -33,8 +33,8 @@ export TST_COUNT=1
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
-nr_cpus=4
-nr_mems=3
+nr_cpus=$NR_CPUS
+nr_mems=$N_NODES
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
