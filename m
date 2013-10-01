Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VR0GP-0001eJ-VY
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VR0GL-0001mX-PN
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:21 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 17:44:52 +0400
Message-Id: <1380635095-21403-6-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 5/8] cpuset/cpuset_memory_test: fixes
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

cpuset_memory_test.c:
 * lack of "config.h"
 * incorrect use of HAVE_LINUX_MEMPOLICY macro
 * modification to make use of sigwaitinfo
 * some cleanup

cpuset_memory_testset.sh:
 * number of cpu and memory nodes are set based on environment
 * we send second SIGUSR1 signal to make the child free its resources
 * setting nr_hugepages to a value of 2 is not sufficient. Because there
   is no guarantee that these hugepages will be allocated on the specified
   node
 * cleanup and several typos are fixed

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset/cpuset_memory_test/cpuset_memory_test.c |  159 ++++++++++----------
 .../cpuset_memory_test/cpuset_memory_testset.sh    |   18 ++-
 2 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
index ddf5935..e4206cf 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
@@ -20,6 +20,7 @@
 /*                                                                            */
 /******************************************************************************/
 
+#include "config.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -36,27 +37,26 @@
 #include <syscall.h>
 #include <pthread.h>
 
-#include "../cpuset_lib/cpuset.h"
-
 char *TCID = "cpuset_memory_test";
 int TST_TOTAL = 1;
 
-#if HAVE_LINUX_MEMPOLICY_TEST
+#if HAVE_LINUX_MEMPOLICY_H
+
+#include "../cpuset_lib/cpuset.h"
 
-int fd;
-int flag_exit;
+static int fd;
 
-int opt_mmap_anon;
-int opt_mmap_file;
-int opt_mmap_lock1;
-int opt_mmap_lock2;
-int opt_shm;
-int opt_hugepage;
-int opt_check;			/* check node when munmap memory (only for mmap_anon()) */
-int opt_thread;
+static int opt_mmap_anon;
+static int opt_mmap_file;
+static int opt_mmap_lock1;
+static int opt_mmap_lock2;
+static int opt_shm;
+static int opt_hugepage;
+static int opt_check; /* check node when munmap memory (only for mmap_anon()) */
+static int opt_thread;
 
-int key_id;			/* used with opt_shm */
-unsigned long memsize;
+static int key_id;			/* used with opt_shm */
+static unsigned long memsize;
 
 #define FILE_HUGEPAGE	"/hugetlb/hugepagefile"
 
@@ -136,7 +136,7 @@ void process_options(int argc, char *argv[])
 	}
 
 	if (!memsize)
-		memsize = getpagesize();
+		memsize = sysconf(_SC_PAGESIZE);
 }
 
 /*
@@ -145,7 +145,7 @@ void process_options(int argc, char *argv[])
 void touch_memory_and_echo_node(char *p, int size)
 {
 	int i;
-	int pagesize = getpagesize();
+	int pagesize = sysconf(_SC_PAGESIZE);
 
 	for (i = 0; i < size; i += pagesize)
 		p[i] = 0xef;
@@ -281,90 +281,54 @@ void shm(int flag_allocated)
 	}
 }
 
-/*
- * sigint_handler: handle SIGINT by set the exit flag.
- */
-void sigint_handler(int __attribute__ ((unused)) signo)
-{
-	flag_exit = 1;
-}
-
-/*
- * sigusr_handler: handler SIGUSR
- *
- * When we receive SIGUSR, we allocate some memory according
- * to the user input when the process started.
- *
- * When we recive SIGUSR again, we will free all the allocated
- * memory.
- */
-void sigusr_handler(int __attribute__ ((unused)) signo)
-{
-	static int flag_allocated = 0;
-
-	if (opt_mmap_anon)
-		mmap_anon(flag_allocated);
-
-	if (opt_mmap_file)
-		mmap_file(flag_allocated);
-
-	if (opt_mmap_lock1)
-		mmap_lock1(flag_allocated);
-
-	if (opt_mmap_lock2)
-		mmap_lock2(flag_allocated);
-
-	if (opt_shm)
-		shm(flag_allocated);
-
-	flag_allocated = !flag_allocated;
-}
-
-void sigusr2(int __attribute__ ((unused)) signo)
-{
-	static int flag_allocated = 0;
-	mmap_anon(flag_allocated);
-	flag_allocated = !flag_allocated;
-}
-
 void *thread2_routine(void __attribute__ ((unused)) * arg)
 {
 	sigset_t set;
-	struct sigaction sigusr2_action;
+	sigset_t waitset;
+	int flag_allocated;
 
 	sigemptyset(&set);
 	sigaddset(&set, SIGUSR1);
 	sigaddset(&set, SIGINT);
 	pthread_sigmask(SIG_BLOCK, &set, NULL);
 
-	memset(&sigusr2_action, 0, sizeof(sigusr2_action));
-	sigusr2_action.sa_handler = &sigusr2;
-	sigaction(SIGUSR2, &sigusr2_action, NULL);
+	sigemptyset(&waitset);
+	sigaddset(&waitset, SIGUSR2);
+	pthread_sigmask(SIG_BLOCK, &waitset, NULL);
+
+	flag_allocated = 0;
+
+	for (;;) {
+		if (sigwaitinfo(&waitset, NULL) < 0)
+			err(1, "sigwaitinfo() in thread2 failed");
 
-	while (!flag_exit)
-		sleep(1);
+		mmap_anon(flag_allocated);
+		flag_allocated = !flag_allocated;
+	}
 
 	return NULL;
 }
 
+/*
+ * When we receive SIGUSR1, we allocate some memory according
+ * to the user intput when the process started.
+ * When we receive SIGUSR1 again, we will free all the allocated
+ * memory.
+ * Similiar for --thread option but SIGUSR2 signal is used
+ * to control thread2 behaviour.
+ */
 int main(int argc, char *argv[])
 {
-	struct sigaction sigint_action;
-	struct sigaction sigusr_action;
+	sigset_t waitset;
+	int signo;
+	int flag_allocated;
+
 	pthread_t thread2;
 
 	fd = open("/dev/zero", O_RDWR);
 	if (fd < 0)
 		err(1, "open /dev/zero failed");
 
-	memset(&sigint_action, 0, sizeof(sigint_action));
-	sigint_action.sa_handler = &sigint_handler;
-	sigaction(SIGINT, &sigint_action, NULL);
-
-	memset(&sigusr_action, 0, sizeof(sigusr_action));
-	sigusr_action.sa_handler = &sigusr_handler;
-	sigaction(SIGUSR1, &sigusr_action, NULL);
-
 	process_options(argc, argv);
 
 	if (opt_thread) {
@@ -377,8 +341,41 @@ int main(int argc, char *argv[])
 		pthread_sigmask(SIG_BLOCK, &set, NULL);
 	}
 
-	while (!flag_exit)
-		sleep(1);
+
+	sigemptyset(&waitset);
+	sigaddset(&waitset, SIGINT);
+	sigaddset(&waitset, SIGUSR1);
+
+	pthread_sigmask(SIG_BLOCK, &waitset, NULL);
+
+	flag_allocated = 0;
+
+	for (;;) {
+		signo = sigwaitinfo(&waitset, NULL);
+		if (signo < 0)
+			err(1, "sigwaitinfo() failed");
+
+		if (signo == SIGUSR1) {
+			if (opt_mmap_anon)
+				mmap_anon(flag_allocated);
+
+			if (opt_mmap_file)
+				mmap_file(flag_allocated);
+
+			if (opt_mmap_lock1)
+				mmap_lock1(flag_allocated);
+
+			if (opt_mmap_lock2)
+				mmap_lock2(flag_allocated);
+
+			if (opt_shm)
+				shm(flag_allocated);
+
+			flag_allocated = !flag_allocated;
+		} else {
+			break;
+		}
+	}
 
 	if (opt_thread) {
 		void *retv;
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index 85f1863..2a9f7e3 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -33,8 +33,8 @@ export TST_COUNT=1
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
-nr_cpus=4
-nr_mems=3
+nr_cpus=$NR_CPUS
+nr_mems=$N_NODES
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"
@@ -55,6 +55,8 @@ simple_getresult()
 	echo $1 > "$2/tasks"
 	/bin/kill -s SIGUSR1 $1
 	sleep 1
+	/bin/kill -s SIGUSR1 $1
+	sleep 1
 	/bin/kill -s SIGINT $1
 	wait $1
 	read node < "$MEMORY_RESULT"
@@ -150,7 +152,7 @@ test5()
 #        1 - support hugetlbfs
 check_hugetlbfs()
 {
-	local fssupport="grep -w hugetlbfs /proc/filesystems 2>/dev/null | cut -f2"
+	local fssupport=$(grep -w hugetlbfs /proc/filesystems 2>/dev/null | cut -f2)
 
 	if [ "$fssupport" = "hugetlbfs" ]; then
 		return 1
@@ -178,7 +180,7 @@ test6()
 	mount -t hugetlbfs none /hugetlb
 
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	echo 2 > /proc/sys/vm/nr_hugepages
+	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
 	./cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
@@ -187,7 +189,7 @@ test6()
 	rmdir /hugetlb
 
 	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
-	if [ $! -ne 0 ]; then
+	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
 		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
 		return 1
 	fi
@@ -217,7 +219,7 @@ test7()
 	mount -t hugetlbfs none /hugetlb
 
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	echo 2 > /proc/sys/vm/nr_hugepages
+	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
 	./cpuset_memory_test --shm --hugepage -s $HUGEPAGESIZE --key=7 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
@@ -226,7 +228,7 @@ test7()
 	rmdir /hugetlb
 
 	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
-	if [ $! -ne 0 ]; then
+	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
 		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
 		return 1
 	fi
@@ -821,7 +823,7 @@ do
 			if [ $? -ne 0 ]; then
 				exit_status=1
 			else
-				tst_resm TPASS "Cpuset memory alloaction test succeeded."
+				tst_resm TPASS "Cpuset memory allocation test succeeded."
 			fi
 		fi
 	fi
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
