From: Michael Moese <mmoese@suse.de>
Date: Fri,  9 Mar 2018 15:16:07 +0100
Subject: [LTP] [PATCH v3 1/3] remove old tst_flush()
Message-ID: <20180309141609.2596-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The old tst_flush() was renamed to tst_old_flush(), and tst_flush()
was removed from tstapicmd.c.
Present calls to tst_flush() were changed to tst_old_flush().

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 doc/man3/tst_res.3                                       | 6 +++---
 include/old/test.h                                       | 6 +++---
 lib/tests/trerrno.c                                      | 2 +-
 lib/tst_res.c                                            | 8 ++++----
 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c | 4 ++--
 testcases/kernel/syscalls/epoll/epoll-ltp.c              | 4 ++--
 testcases/kernel/syscalls/fork/fork07.c                  | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c          | 2 +-
 testcases/kernel/syscalls/modify_ldt/modify_ldt02.c      | 2 +-
 tools/apicmds/ltpapicmd.c                                | 4 ----
 10 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
index e1f50c26b..56f722436 100644
--- a/doc/man3/tst_res.3
+++ b/doc/man3/tst_res.3
@@ -39,7 +39,7 @@ tst_resm_hexd \- Print result message, including specified buffer in hexadecimal
 .sp
 tst_brkm \- Print result message and break remaining test cases
 .sp
-tst_flush \- Print any messages pending because of CONDENSE mode, and flush output stream
+tst_old_flush \- Print any messages pending because of CONDENSE mode, and flush output stream
 .sp
 tst_exit \- Exit test with a meaningful exit value
 .sp
@@ -56,7 +56,7 @@ char *\fItmesg, [arg ...]\fR)
 \fBvoid tst_brkm(int \fIttype\fB, void (*\fIfunc\fB)(), char *\fItmesg,
 [arg ...]\fR)
 .P
-\fBvoid tst_flush()
+\fBvoid tst_old_flush()
 .P
 \fBvoid tst_exit()
 .P
@@ -180,7 +180,7 @@ after all results have been printed.  If \fBtst_brk()\fR is called with a
 first reported result.  \fBtst_brk()\fR takes the \fIfname\fR argument
 whereas \fBtst_brkm()\fR does not.
 .P
-\fBtst_flush()\fR is used to print any results pending because of
+\fBtst_old_flush()\fR is used to print any results pending because of
 \fBCONDENSE\fR or \fBNOPASS\fR modes (described below), and flushes the
 output stream.
 .P
diff --git a/include/old/test.h b/include/old/test.h
index 74d11a123..5eef304ab 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -102,7 +102,7 @@
 #ifdef UCLINUX
 # define FORK_OR_VFORK			tst_vfork
 # define MAP_PRIVATE_EXCEPT_UCLINUX	0
-/* tst_flush() + vfork() */
+/* tst_old_flush() + vfork() */
 pid_t tst_vfork(void);
 #else
 # define FORK_OR_VFORK			tst_fork
@@ -176,10 +176,10 @@ void tst_brkm_(const char *file, const int lineno, int ttype,
 
 void tst_require_root(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
-void tst_flush(void);
+void tst_old_flush(void);
 
 /*
- * tst_flush() + fork
+ * tst_old_flush() + fork
  * NOTE: tst_fork() will reset T_exitval to 0 for child process.
  */
 pid_t tst_fork(void);
diff --git a/lib/tests/trerrno.c b/lib/tests/trerrno.c
index 49d50e9df..a160874de 100644
--- a/lib/tests/trerrno.c
+++ b/lib/tests/trerrno.c
@@ -57,7 +57,7 @@ int main(void)
 	TEST_ERRNO = EPERM;
 	TEST_RETURN = EINVAL;
 	tst_resm(TINFO | TRERRNO, "test");
-	tst_flush();
+	tst_old_flush();
 
 	/* restore stdout */
 	TEST(dup2(stdout_fd, fileno(stdout)));
diff --git a/lib/tst_res.c b/lib/tst_res.c
index b56f37db0..5ea3531a4 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -245,7 +245,7 @@ static void tst_condense(int tnum, int ttype, const char *tmesg)
 	Buffered = TRUE;
 }
 
-void tst_flush(void)
+void tst_old_flush(void)
 {
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
@@ -399,7 +399,7 @@ void tst_exit(void)
 
 	pthread_mutex_lock(&tmutex);
 
-	tst_flush();
+	tst_old_flush();
 
 	T_exitval &= ~TINFO;
 
@@ -415,7 +415,7 @@ pid_t tst_fork(void)
 
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
-	tst_flush();
+	tst_old_flush();
 
 	child = fork();
 	if (child == 0)
@@ -460,7 +460,7 @@ pid_t tst_vfork(void)
 {
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
-	tst_flush();
+	tst_old_flush();
 	return vfork();
 }
 
diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index ad291a1eb..71a03d12c 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -219,10 +219,10 @@ static void cleanup(void)
 
 	/*
 	 * Kernels 3.7 can crash while unmounting cgroups with xattr,
-	 * call tst_flush() to make sure all buffered data written
+	 * call tst_old_flush() to make sure all buffered data written
 	 * before it happens
 	 */
-	tst_flush();
+	tst_old_flush();
 
 	int i;
 	for (i = 0; i < odir_num; ++i) {
diff --git a/testcases/kernel/syscalls/epoll/epoll-ltp.c b/testcases/kernel/syscalls/epoll/epoll-ltp.c
index cb82fd865..12504ab95 100644
--- a/testcases/kernel/syscalls/epoll/epoll-ltp.c
+++ b/testcases/kernel/syscalls/epoll/epoll-ltp.c
@@ -142,7 +142,7 @@ do {					\
 	pid_t kid_pid;			\
 	int kid_status;			\
 					\
-	tst_flush();			\
+	tst_old_flush();			\
 	kid_pid = FORK_OR_VFORK();	\
 	if (kid_pid == 0) {
 
@@ -176,7 +176,7 @@ do {					\
 	pid_t kid_pid;								\
 	int kid_status;								\
 										\
-	tst_flush();								\
+	tst_old_flush();								\
 	kid_pid = FORK_OR_VFORK();						\
 	if (kid_pid == 0) { /* Run the function */				\
 		return fn(epoll_fd);						\
diff --git a/testcases/kernel/syscalls/fork/fork07.c b/testcases/kernel/syscalls/fork/fork07.c
index 4344fdf4c..e596867c3 100644
--- a/testcases/kernel/syscalls/fork/fork07.c
+++ b/testcases/kernel/syscalls/fork/fork07.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 
 		/* fork off the children */
 		tst_resm(TINFO, "Forking %d children", Nforks);
-		tst_flush();
+		tst_old_flush();
 		for (forks = 0; forks < Nforks; forks++) {
 			pid1 = fork();
 			if (pid1 == 0) {
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index ddf6b86d1..1b4697755 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -228,7 +228,7 @@ void stat_setup(void)
 		 */
 		set_shared = set_shmat();
 
-	tst_flush();
+	tst_old_flush();
 	for (stat_i = 0; stat_i < N_ATTACH; stat_i++) {
 		pid = FORK_OR_VFORK();
 		if (pid == -1)
diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
index b82d14ea3..c953ac420 100644
--- a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 			tst_brkm(TINFO, cleanup, "Creation of segment failed");
 		}
 
-		tst_flush();
+		tst_old_flush();
 		if ((pid = FORK_OR_VFORK()) == 0) {
 			val = read_segment(0);
 			exit(1);
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 9ad68b589..4b66c4226 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -34,8 +34,6 @@
  *                          break remaining test cases
  *              tst_res   - Print result message, including file contents
  *              tst_resm  - Print result message
- *              tst_flush - Print any messages pending because of CONDENSE mode,
- *                          and flush output stream
  *              tst_exit  - Exit test with a meaningful exit value
  *
  *              These are the minimum set of functions or commands required to
@@ -332,8 +330,6 @@ int main(int argc, char *argv[])
 		apicmd_resm(argc, argv);
 	} else if (strcmp(cmd_name, "tst_exit") == 0) {
 		tst_exit();
-	} else if (strcmp(cmd_name, "tst_flush") == 0) {
-		tst_flush();
 	} else if (strcmp(cmd_name, "tst_ncpus") == 0) {
 		printf("%li\n", tst_ncpus());
 	} else if (strcmp(cmd_name, "tst_ncpus_conf") == 0) {
-- 
2.13.6

