From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:54 -0700
Subject: [LTP] [PATCH V3 21/23] rename 'sigset' var to avoid shadowing with
	libc symbol sigset
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-21-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Fixes errors like

epoll_pwait01.c:44:17: error: ‘sigset’ redeclared as different kind of symbol
 static sigset_t sigset;
                 ^~~~~~
In file included from ../../../../include/old/test.h:38:0,
                 from epoll_pwait01.c:36:
/usr/include/signal.h:231:8: note: previous declaration of ‘sigset’ was here
 void (*sigset(int, void (*)(int)))(int);
        ^~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c  |  6 +++---
 .../kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c     |  6 +++---
 .../cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c     | 16 ++++++++--------
 .../cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c    |  8 ++++----
 testcases/kernel/fs/doio/doio.c                          |  6 +++---
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c    |  8 ++++----
 testcases/kernel/syscalls/sigsuspend/sigsuspend01.c      |  6 +++---
 testcases/kernel/syscalls/truncate/truncate03.c          |  8 ++++----
 .../conformance/interfaces/sched_setparam/1-1.c          |  8 ++++----
 9 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
index 880cb76..93bc8b7 100644
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
@@ -40,7 +40,7 @@ void sighandler(UNUSED int signo)
 
 int main(void)
 {
-	sigset_t sigset;
+	sigset_t signalset;
 	struct sigaction sa;
 	pid_t pid;
 	int status;
@@ -54,11 +54,11 @@ int main(void)
 	if (sigaction(SIGUSR1, &sa, NULL) < 0)
 		err(1, "sigaction()");
 
-	if (sigemptyset(&sigset) < 0)
+	if (sigemptyset(&signalset) < 0)
 		err(1, "sigemptyset()");
 
 	/* wait for the signal SIGUSR1 to start testing */
-	sigsuspend(&sigset);
+	sigsuspend(&signalset);
 	if (errno != EINTR)
 		err(1, "sigsuspend()");
 
diff --git a/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c b/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c
index 3f300c7..da1c312 100644
--- a/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c
+++ b/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c
@@ -43,7 +43,7 @@ void sighandler(UNUSED int signo)
 
 int main(void)
 {
-	sigset_t sigset;
+	sigset_t signalset;
 	struct sigaction sa;
 
 	sa.sa_handler = sighandler;
@@ -54,10 +54,10 @@ int main(void)
 	if (sigaction(SIGUSR1, &sa, NULL) < 0)
 		err(1, "sigaction()");
 
-	if (sigemptyset(&sigset) < 0)
+	if (sigemptyset(&signalset) < 0)
 		err(1, "sigemptyset()");
 
-	sigsuspend(&sigset);
+	sigsuspend(&signalset);
 	if (errno != EINTR)
 		err(1, "sigsuspend()");
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
index de81f26..8a6ec26 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
@@ -161,7 +161,7 @@ void checkopt(int argc, char **argv)
 int cpu_hog(void)
 {
 	double f = 2744545.34456455;
-	sigset_t sigset;
+	sigset_t signalset;
 	struct cpuset *cp = NULL;
 	struct bitmask *cpumask = NULL;
 	int cpu;
@@ -180,12 +180,12 @@ int cpu_hog(void)
 		goto err1;
 	}
 
-	if (sigemptyset(&sigset) < 0) {
+	if (sigemptyset(&signalset) < 0) {
 		ret = -1;
 		goto err2;
 	}
 
-	sigsuspend(&sigset);
+	sigsuspend(&signalset);
 
 	if (cpuset_cpusetofpid(cp, 0) < 0) {
 		ret = -1;
@@ -249,7 +249,7 @@ int main(int argc, char **argv)
 	int i = 0;
 	pid_t pid;
 	pid_t *childpids = NULL;
-	sigset_t sigset;
+	sigset_t signalset;
 	int status = 0;
 	int ret = 0;
 
@@ -260,7 +260,7 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	if (sigemptyset(&sigset) < 0) {
+	if (sigemptyset(&signalset) < 0) {
 		warn("sigemptyset failed");
 		report_result("2\n");
 		exit(EXIT_FAILURE);
@@ -275,7 +275,7 @@ int main(int argc, char **argv)
 	memset(childpids, 0, (nprocs) * sizeof(pid_t));
 
 	report_result("0\n");
-	sigsuspend(&sigset);
+	sigsuspend(&signalset);
 	for (; i < nprocs; i++) {
 		pid = fork();
 		if (pid == -1) {
@@ -294,10 +294,10 @@ int main(int argc, char **argv)
 	report_result("0\n");
 
 	while (!end) {
-		if (sigemptyset(&sigset) < 0)
+		if (sigemptyset(&signalset) < 0)
 			ret = -1;
 		else
-			sigsuspend(&sigset);
+			sigsuspend(&signalset);
 
 		if (ret || end) {
 			for (i = 0; i < nprocs; i++) {
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
index 6ca6663..56e039e 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
@@ -71,13 +71,13 @@ int page_cache_hog(void)
 
 int mem_hog(void)
 {
-	sigset_t sigset;
+	sigset_t signalset;
 	int fd;
 	int ret = 0;
 
-	if (sigemptyset(&sigset) < 0)
+	if (sigemptyset(&signalset) < 0)
 		err(1, "sigemptyset()");
-	sigsuspend(&sigset);
+	sigsuspend(&signalset);
 
 	while (!end) {
 		ret = page_cache_hog();
@@ -96,7 +96,7 @@ int mem_hog(void)
 
 		close(fd);
 
-		sigsuspend(&sigset);
+		sigsuspend(&signalset);
 	}
 
 	return ret;
diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index 5f65ef9..be68999 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -4743,7 +4743,7 @@ int aio_wait(int aio_id)
 #ifdef RECALL_SIZEOF
 	long mask[RECALL_SIZEOF];
 #endif
-	sigset_t sigset;
+	sigset_t signalset;
 	struct aio_info *aiop;
 #ifdef CRAY
 	struct iosw *ioswlist[1];
@@ -4762,11 +4762,11 @@ int aio_wait(int aio_id)
 		break;
 
 	case A_SIGNAL:
-		sigemptyset(&sigset);
+		sigemptyset(&signalset);
 		sighold(aiop->sig);
 
 		while (!aiop->signalled || !aiop->done) {
-			sigsuspend(&sigset);
+			sigsuspend(&signalset);
 			sighold(aiop->sig);
 		}
 		break;
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index 4f8448e..ed05da8 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -41,7 +41,7 @@ char *TCID = "epoll_pwait01";
 int TST_TOTAL = 2;
 
 static int epfd, fds[2];
-static sigset_t sigset;
+static sigset_t signalset;
 static struct epoll_event epevs;
 static struct sigaction sa;
 
@@ -64,7 +64,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		do_test(&sigset);
+		do_test(&signalset);
 		do_test(NULL);
 	}
 
@@ -83,10 +83,10 @@ static void setup(void)
 
 	TEST_PAUSE;
 
-	if (sigemptyset(&sigset) == -1)
+	if (sigemptyset(&signalset) == -1)
 		tst_brkm(TFAIL | TERRNO, NULL, "sigemptyset() failed");
 
-	if (sigaddset(&sigset, SIGUSR1) == -1)
+	if (sigaddset(&signalset, SIGUSR1) == -1)
 		tst_brkm(TFAIL | TERRNO, NULL, "sigaddset() failed");
 
 	sa.sa_flags = 0;
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index b84f986..b9542e7 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -83,7 +83,7 @@ char *TCID = "sigsuspend01";
 int TST_TOTAL = 1;
 
 struct sigaction sa_new;	/* struct to hold signal info */
-sigset_t sigset;		/* signal set to hold signal lists */
+sigset_t signalset;		/* signal set to hold signal lists */
 sigset_t sigset1;
 sigset_t sigset2;
 
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 		 * of the process and suspend process execution till
 		 * receipt of a signal 'SIGALRM'.
 		 */
-		TEST(sigsuspend(&sigset));
+		TEST(sigsuspend(&signalset));
 
 		/* Reset the alarm timer */
 		alarm(0);
@@ -160,7 +160,7 @@ void setup(void)
 	 * Initialise the signal sets with the list that
 	 * excludes/includes  all system-defined signals.
 	 */
-	if (sigemptyset(&sigset) == -1) {
+	if (sigemptyset(&signalset) == -1) {
 		tst_brkm(TFAIL, cleanup,
 			 "sigemptyset() failed, errno=%d : %s",
 			 errno, strerror(errno));
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 60881c9..2e97f45 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -119,7 +119,7 @@ void setup(void)
 	struct passwd *ltpuser;
 	char *bad_addr;
 	struct rlimit rlim;
-	sigset_t sigset;
+	sigset_t signalset;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -157,9 +157,9 @@ void setup(void)
 	rlim.rlim_max = MAX_FSIZE;
 	SAFE_SETRLIMIT(cleanup, RLIMIT_FSIZE, &rlim);
 
-	sigemptyset(&sigset);
-	sigaddset(&sigset, SIGXFSZ);
-	TEST(sigprocmask(SIG_BLOCK, &sigset, NULL));
+	sigemptyset(&signalset);
+	sigaddset(&signalset, SIGXFSZ);
+	TEST(sigprocmask(SIG_BLOCK, &signalset, NULL));
 	if (TEST_RETURN != 0)
 		tst_brkm(TBROK | TTERRNO, cleanup, "sigprocmask");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c
index 8674e2f..f7cfc9e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c
@@ -22,18 +22,18 @@
 
 void child_proc()
 {
-	sigset_t sigset;
+	sigset_t signalset;
 	int sig;
 
-	if (sigemptyset(&sigset) != 0) {
+	if (sigemptyset(&signalset) != 0) {
 		perror("An error occurs when calling sigemptyset()");
 		exit(1);
 	}
-	if (sigaddset(&sigset, SIGUSR1) != 0) {
+	if (sigaddset(&signalset, SIGUSR1) != 0) {
 		perror("An error occurs when calling sigaddset()");
 		exit(1);
 	}
-	if (sigwait(&sigset, &sig) != 0) {
+	if (sigwait(&signalset, &sig) != 0) {
 		perror("An error occurs when calling sigwait()");
 		exit(1);
 	}
-- 
2.9.0

