From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 18 May 2021 14:45:06 +0800
Subject: [LTP] [PATCH] typo: Add necessary spaces in the outputs
Message-ID: <20210518064506.203781-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add necessary spaces in the outputs.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 lib/tst_cgroup.c                                       |  2 +-
 lib/tst_fs_link_count.c                                |  2 +-
 pan/ltp-pan.c                                          |  2 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c              | 10 +++++-----
 testcases/kernel/io/direct_io/dma_thread_diotest.c     |  4 ++--
 testcases/kernel/sched/tool/trace_sched.c              |  2 +-
 testcases/kernel/syscalls/adjtimex/adjtimex03.c        |  2 +-
 testcases/kernel/syscalls/clone/clone02.c              |  2 +-
 testcases/kernel/syscalls/clone/clone04.c              |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify05.c        |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify14.c        |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify15.c        |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify16.c        |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl22.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl29.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl30.c              |  6 +++---
 testcases/kernel/syscalls/fork/fork08.c                |  4 ++--
 testcases/kernel/syscalls/inotify/inotify02.c          |  2 +-
 testcases/kernel/syscalls/inotify/inotify07.c          |  2 +-
 testcases/kernel/syscalls/ipc/shmat/shmat02.c          |  2 +-
 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c      |  2 +-
 testcases/kernel/syscalls/link/link05.c                |  2 +-
 testcases/kernel/syscalls/link/link06.c                |  2 +-
 testcases/kernel/syscalls/link/link07.c                |  2 +-
 testcases/kernel/syscalls/linkat/linkat02.c            |  2 +-
 testcases/kernel/syscalls/mknod/mknod09.c              |  2 +-
 .../sched_get_priority_max/sched_get_priority_max01.c  |  2 +-
 .../sched_get_priority_min/sched_get_priority_min01.c  |  2 +-
 .../kernel/syscalls/sched_setparam/sched_setparam05.c  |  2 +-
 testcases/kernel/syscalls/setsid/setsid01.c            |  2 +-
 testcases/kernel/syscalls/sigaction/sigaction01.c      |  4 ++--
 testcases/kernel/syscalls/sysinfo/sysinfo02.c          |  2 +-
 .../conformance/interfaces/kill/1-2.c                  |  2 +-
 .../conformance/interfaces/pthread_spin_unlock/1-1.c   |  2 +-
 .../conformance/interfaces/sched_setparam/2-1.c        |  2 +-
 .../conformance/interfaces/sched_setparam/2-2.c        |  2 +-
 testcases/realtime/func/rt-migrate/rt-migrate.c        |  2 +-
 utils/sctp/func_tests/test_1_to_1_accept_close.c       |  4 ++--
 utils/sctp/func_tests/test_basic.c                     |  2 +-
 utils/sctp/func_tests/test_connect.c                   |  2 +-
 utils/sctp/func_tests/test_connectx.c                  |  2 +-
 utils/sctp/func_tests/test_sockopt.c                   |  4 ++--
 42 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1e036d3c3..8b02431b1 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -394,7 +394,7 @@ v1:
 			goto discard;

 		tst_brk(TBROK,
-			"The intersection of two distinct sets of mounted controllers should be null?"
+			"The intersection of two distinct sets of mounted controllers should be null? "
 			"Check '%s' and '%s'", root->mnt_path, mnt_dir);
 	}

diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
index 860510d75..c56c0e7f2 100644
--- a/lib/tst_fs_link_count.c
+++ b/lib/tst_fs_link_count.c
@@ -147,7 +147,7 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir)
 			 * created directory (the '.' and link from parent dir)
 			 */
 			if (s.st_nlink != (i + 2)) {
-				tst_brkm(TBROK, cleanup, "%s link counts have"
+				tst_brkm(TBROK, cleanup, "%s link counts have "
 					 "%d, should be %d", dir,
 					 (int)s.st_nlink, i + 2);
 				return 0;
diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 298072fe0..0bdb51477 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -263,7 +263,7 @@ int main(int argc, char **argv)
 			ret = sscanf(optarg, "%d%c", &run_time, &modifier);
 			if (ret == 0) {
 				fprintf(stderr,
-					"Need proper time input: ####x where"
+					"Need proper time input: ####x where "
 					"x is one of s,m,h,d\n");
 				break;
 			} else if (ret == 1) {
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 4a20f4da6..64c27a0f5 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -283,7 +283,7 @@ void save_buffer(char *buffer, off_t bufferlength, int fd)
 		if (size_by_seek == (off_t) - 1)
 			prterr("save_buffer: lseek eof");
 		else if (bufferlength > size_by_seek) {
-			warn("save_buffer: .fsxgood file too short... will"
+			warn("save_buffer: .fsxgood file too short... will "
 			     "save 0x%llx bytes instead of 0x%llx\n",
 			     (unsigned long long)size_by_seek,
 			     (unsigned long long)bufferlength);
@@ -300,7 +300,7 @@ void save_buffer(char *buffer, off_t bufferlength, int fd)
 		if (byteswritten == -1)
 			prterr("save_buffer write");
 		else
-			warn("save_buffer: short write, 0x%x bytes instead"
+			warn("save_buffer: short write, 0x%x bytes instead "
 			     "of 0x%llx\n",
 			     (unsigned)byteswritten,
 			     (unsigned long long)bufferlength);
@@ -358,10 +358,10 @@ void check_buffers(unsigned offset, unsigned size)
 		if (n) {
 			prt("\t%#7x\n", n);
 			if (bad)
-				prt("operation# (mod 256) for the bad data"
+				prt("operation# (mod 256) for the bad data "
 				    "may be %u\n", ((unsigned)op & 0xff));
 			else
-				prt("operation# (mod 256) for the bad data"
+				prt("operation# (mod 256) for the bad data "
 				    "unknown, check HOLE and EXTEND ops\n");
 		} else
 			prt("????????????????\n");
@@ -1328,7 +1328,7 @@ int main(int argc, char **argv)
 				prterr(fname);
 				warn("main: error on write");
 			} else
-				warn("main: short write, 0x%x bytes instead"
+				warn("main: short write, 0x%x bytes instead "
 				     "of 0x%x\n",
 				     (unsigned)written, maxfilelen);
 			exit(98);
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index aa51bf2fb..c317eba8e 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -289,7 +289,7 @@ static void dma_thread_diotest_verify(void)
 				rc = pthread_create(&worker[j].tid, NULL,
 						    worker_thread, worker + j);
 				if (rc != 0) {
-					tst_brkm(TBROK, cleanup, "Can't create"
+					tst_brkm(TBROK, cleanup, "Can't create "
 						 "worker thread %d: %s",
 						 j, strerror(rc));
 				}
@@ -304,7 +304,7 @@ static void dma_thread_diotest_verify(void)
 				}
 				if ((intptr_t)retval != 0) {
 					tst_brkm(TBROK, cleanup, "there is"
-						 "some errors in worker[%d],"
+						 "some errors in worker[%d], "
 						 "return value: %ld",
 						 j, (intptr_t)retval);
 				}
diff --git a/testcases/kernel/sched/tool/trace_sched.c b/testcases/kernel/sched/tool/trace_sched.c
index 85c4b23ad..8693bee73 100644
--- a/testcases/kernel/sched/tool/trace_sched.c
+++ b/testcases/kernel/sched/tool/trace_sched.c
@@ -345,7 +345,7 @@ int main(int argc,		/* number of input parameters.                        */
 				spcy = SCHED_OTHER;
 			else {
 				fprintf(stderr,
-					"ERROR: Unrecognized scheduler policy,"
+					"ERROR: Unrecognized scheduler policy, "
 					"using default\n");
 				usage(argv[0]);
 			}
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex03.c b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
index 263391c90..228e9c69d 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex03.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
@@ -53,7 +53,7 @@ void verify_adjtimex(void)
 				" with mode 0x%x", ADJ_ADJTIME);
 		} else {
 			tst_brk(TBROK | TERRNO,
-					"adjtimex(): Unexpeceted error,"
+					"adjtimex(): Unexpeceted error, "
 					"expecting EINVAL with mode 0x%x",
 					ADJ_ADJTIME);
 		}
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index d864aaea5..81c3dde65 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)

 		for (i = 0; i < TST_TOTAL; ++i) {
 			if (test_setup() != 0) {
-				tst_resm(TWARN, "test_setup() failed,"
+				tst_resm(TWARN, "test_setup() failed, "
 					 "skipping this test case");
 				continue;
 			}
diff --git a/testcases/kernel/syscalls/clone/clone04.c b/testcases/kernel/syscalls/clone/clone04.c
index 7f862b800..ad42b6aaa 100644
--- a/testcases/kernel/syscalls/clone/clone04.c
+++ b/testcases/kernel/syscalls/clone/clone04.c
@@ -66,7 +66,7 @@ int main(int ac, char **av)
 			if (test_cases[ind].child_stack == NULL) {
 				test_stack = NULL;
 			} else if (*test_cases[ind].child_stack == NULL) {
-				tst_resm(TWARN, "Can not allocate stack for"
+				tst_resm(TWARN, "Can not allocate stack for "
 					 "child, skipping test case");
 				continue;
 			} else {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 1c683c4c0..f72976ca0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -158,7 +158,7 @@ static void test_fanotify(unsigned int n)
 		if (event.mask != FAN_OPEN &&
 		    event.mask != FAN_Q_OVERFLOW) {
 			tst_res(TFAIL,
-				"got event: mask=%llx (expected %llx)"
+				"got event: mask=%llx (expected %llx) "
 				"pid=%u fd=%d",
 				(unsigned long long)event.mask,
 				(unsigned long long)FAN_OPEN,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index d19d5576a..1944bcbb4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -98,7 +98,7 @@ static void do_test(unsigned int number)
 	if (tc->mask == 0) {
 		tst_res(TFAIL,
 			"fanotify_fd=%d fanotify_init(%x, O_RDONLY) "
-			"unexpectedly succeeded when tests with mask 0 are"
+			"unexpectedly succeeded when tests with mask 0 are "
 			"expected to fail when calling fanotify_init()",
 			fanotify_fd,
 			tc->init_flags);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index a7736af90..16b2d7ad2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -161,7 +161,7 @@ static void do_test(unsigned int number)
 			  FAN_DELETE_SELF | FAN_ONDIR,
 			  AT_FDCWD, DIR1) == -1) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark(%d, FAN_MARK_ADD | %s,"
+			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
 			"FAN_DELETE_SELF | FAN_ONDIR, AT_FDCWD, %s) failed",
 			fanotify_fd, mark->name, DIR1);
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 357f4216b..1caf29f23 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -417,7 +417,7 @@ check_match:
 		} else if (fhlen != expected_fid->handle.handle_bytes) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u fd=%d name='%s' "
-				"len=%d info_type=%d info_len=%d fh_len=%d expected(%d)"
+				"len=%d info_type=%d info_len=%d fh_len=%d expected(%d) "
 				"fh_type=%d",
 				(unsigned long long)event->mask,
 				(unsigned)event->pid, event->fd, filename,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl22.c b/testcases/kernel/syscalls/fcntl/fcntl22.c
index 90a603543..2e94a1257 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl22.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl22.c
@@ -66,7 +66,7 @@ int main(int ac, char **av)
 			TEST(fcntl(file, F_SETLK, &fl));

 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "fcntl() returned %ld,"
+				tst_resm(TFAIL, "fcntl() returned %ld, "
 					 "expected -1, errno=%d", TEST_RETURN,
 					 EAGAIN);
 			} else {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
index 653ac2276..03f1707b9 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl29.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
@@ -86,7 +86,7 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	if ((tst_kvercmp(2, 6, 24)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels"
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
 			 "that are 2.6.24 and higher");
 	}

diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index 4a409b868..767d4ac5f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -80,10 +80,10 @@ int main(int ac, char **av)
 		tst_resm(TINFO, "orig_pipe_size: %d new_pipe_size: %d",
 			 orig_pipe_size, new_pipe_size);
 		if (TEST_RETURN >= new_pipe_size) {
-			tst_resm(TPASS, "fcntl test F_GETPIPE_SZ"
+			tst_resm(TPASS, "fcntl test F_GETPIPE_SZ "
 				 "and F_SETPIPE_SZ success");
 		} else {
-			tst_resm(TFAIL, "fcntl test F_GETPIPE_SZ"
+			tst_resm(TFAIL, "fcntl test F_GETPIPE_SZ "
 				 "and F_SETPIPE_SZ fail");
 		}
 		SAFE_CLOSE(cleanup, pipe_fds[0]);
@@ -97,7 +97,7 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	if ((tst_kvercmp(2, 6, 35)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels"
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
 			 "that are 2.6.35 and higher");
 	}

diff --git a/testcases/kernel/syscalls/fork/fork08.c b/testcases/kernel/syscalls/fork/fork08.c
index 09c616728..1123f7473 100644
--- a/testcases/kernel/syscalls/fork/fork08.c
+++ b/testcases/kernel/syscalls/fork/fork08.c
@@ -116,7 +116,7 @@ forkone:
 				tst_resm(TINFO, "second child got char: %c",
 					 ch_r_stat);
 				if (ch_r_stat == 'b') {
-					tst_resm(TPASS, "Test passed in child"
+					tst_resm(TPASS, "Test passed in child "
 						 "number %d", forks);
 					exit(0);
 				} else if (ch_r_stat == EOF) {
@@ -124,7 +124,7 @@ forkone:
 						 "EOF");
 					exit(-1);
 				} else {
-					tst_resm(TFAIL, "test failed in child"
+					tst_resm(TFAIL, "test failed in child "
 						 "no %d", forks);
 					exit(-1);
 				}
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 32855e082..576ef431c 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -150,7 +150,7 @@ void verify_inotify(void)
 					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
 			tst_res(TFAIL,
 				"get unnecessary event: "
-				"wd=%d mask=%08x cookie=%-5u len=%-2u"
+				"wd=%d mask=%08x cookie=%-5u len=%-2u "
 				"name=\"%.*s\"", event->wd, event->mask,
 				event->cookie, event->len, event->len,
 				event->name);
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index a496489ac..294e29dca 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -100,7 +100,7 @@ void verify_inotify(void)
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
 				"get unnecessary event: "
-				"wd=%d mask=%08x cookie=%-5u len=%-2u"
+				"wd=%d mask=%08x cookie=%-5u len=%-2u "
 				"name=\"%.*s\"", event->wd, event->mask,
 				event->cookie, event->len, event->len,
 				event->name);
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index 08bb12267..dd8c44798 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -55,7 +55,7 @@ static void verify_shmat(struct test_case_t *tc)
 	if (errno == tc->exp_err) {
 		tst_res(TPASS | TERRNO, "shmat() failed as expected");
 	} else {
-		tst_res(TFAIL | TERRNO, "shmat() failed unexpectedly,"
+		tst_res(TFAIL | TERRNO, "shmat() failed unexpectedly, "
 			 "expected: %s", tst_strerrno(tc->exp_err));
 	}
 }
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index b9669b214..826205f6a 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -89,7 +89,7 @@ next:
 	if (TST_ERR == ENODATA) {
 		tst_res(TPASS | TTERRNO, "lgetxattr() failed as expected");
 	} else {
-		tst_res(TFAIL | TTERRNO, "lgetxattr() failed unexpectedly,"
+		tst_res(TFAIL | TTERRNO, "lgetxattr() failed unexpectedly, "
 			"expected %s", tst_strerrno(ENODATA));
 	}
 }
diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 3b42217cd..5981ae62f 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 		}
 		if (cnt >= nlinks) {
 			tst_resm(TPASS,
-				 "link(%s, %s[1-%d]) ret %ld for %d files,"
+				 "link(%s, %s[1-%d]) ret %ld for %d files, "
 			         "stat linkcounts match %d",
 				 fname, fname, nlinks, TEST_RETURN,
 				 nlinks, (int)fbuf.st_nlink);
diff --git a/testcases/kernel/syscalls/link/link06.c b/testcases/kernel/syscalls/link/link06.c
index 4dae47be7..17b38ad43 100644
--- a/testcases/kernel/syscalls/link/link06.c
+++ b/testcases/kernel/syscalls/link/link06.c
@@ -65,7 +65,7 @@ int main(int ac, char **av)
 		TEST(link(OLDPATH, NEWPATH));

 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "link() returned %ld,"
+			tst_resm(TFAIL, "link() returned %ld, "
 				 "expected -1, errno=%d", TEST_RETURN,
 				 EACCES);
 		} else {
diff --git a/testcases/kernel/syscalls/link/link07.c b/testcases/kernel/syscalls/link/link07.c
index 0fa1af4e3..09743b59c 100644
--- a/testcases/kernel/syscalls/link/link07.c
+++ b/testcases/kernel/syscalls/link/link07.c
@@ -66,7 +66,7 @@ int main(int ac, char **av)

 		/* Check return code from link(2) */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL | TTERRNO, "link() returned %ld,"
+			tst_resm(TFAIL | TTERRNO, "link() returned %ld, "
 				 "expected -1, errno=%d", TEST_RETURN, EACCES);
 		} else {
 			if (TEST_ERRNO == EACCES) {
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 51785af02..84b4a3ba0 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -121,7 +121,7 @@ static void linkat_verify(const struct test_struct *desc)

 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL,
-			 "linkat(""AT_FDCWD"", %s, ""AT_FDCWD"", %s, %d)"
+			 "linkat(""AT_FDCWD"", %s, ""AT_FDCWD"", %s, %d) "
 			 "succeeded unexpectedly", desc->oldfname,
 			 desc->newfname, desc->flags);
 		return;
diff --git a/testcases/kernel/syscalls/mknod/mknod09.c b/testcases/kernel/syscalls/mknod/mknod09.c
index 433c962a8..57b953790 100644
--- a/testcases/kernel/syscalls/mknod/mknod09.c
+++ b/testcases/kernel/syscalls/mknod/mknod09.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)

 		/* Check return code from mknod(2) */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "mknod() returned %ld,"
+			tst_resm(TFAIL, "mknod() returned %ld, "
 				 "expected -1, errno=%d", TEST_RETURN,
 				 EINVAL);
 		} else {
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index 0ea06bba2..7d36dbbdb 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s Passed",
 					 test_cases[ind].desc);
 			} else {
-				tst_resm(TFAIL | TTERRNO, "%s Failed,"
+				tst_resm(TFAIL | TTERRNO, "%s Failed, "
 					 "sched_get_priority_max() returned %ld",
 					 test_cases[ind].desc, TEST_RETURN);
 			}
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
index b3c270968..0893cb79f 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s Passed",
 					 test_cases[ind].desc);
 			} else {
-				tst_resm(TFAIL | TTERRNO, "%s Failed,"
+				tst_resm(TFAIL | TTERRNO, "%s Failed, "
 					 "sched_get_priority_min() returned %ld",
 					 test_cases[ind].desc, TEST_RETURN);
 			}
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
index 8534846b6..c05b9645f 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)

 			/* Switch to nobody user */
 			if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-				tst_brkm(TBROK, NULL, "\"nobody\" user"
+				tst_brkm(TBROK, NULL, "\"nobody\" user "
 					 "not present");
 			}
 			if (seteuid(ltpuser->pw_uid) == -1) {
diff --git a/testcases/kernel/syscalls/setsid/setsid01.c b/testcases/kernel/syscalls/setsid/setsid01.c
index ed8f0e4ad..08a7e2595 100644
--- a/testcases/kernel/syscalls/setsid/setsid01.c
+++ b/testcases/kernel/syscalls/setsid/setsid01.c
@@ -185,7 +185,7 @@ void do_child_1(void)
 			tst_resm(TPASS, "setsid SUCCESS to set "
 				 "errno to EPERM");
 		} else {
-			tst_resm(TFAIL, "setsid failed, expected %d,"
+			tst_resm(TFAIL, "setsid failed, expected %d, "
 				 "return %d", -1, errno);
 			exno = 3;
 		}
diff --git a/testcases/kernel/syscalls/sigaction/sigaction01.c b/testcases/kernel/syscalls/sigaction/sigaction01.c
index e8e8a49a7..17b744b01 100644
--- a/testcases/kernel/syscalls/sigaction/sigaction01.c
+++ b/testcases/kernel/syscalls/sigaction/sigaction01.c
@@ -142,7 +142,7 @@ void handler(int sig, siginfo_t * sip, void *ucp)
 		 * of the signal list
 		 */
 		if (sigismember(&omask, sig) == 0) {
-			tst_resm(TFAIL, "SA_RESETHAND should cause sig to"
+			tst_resm(TFAIL, "SA_RESETHAND should cause sig to "
 				 "be masked when the handler executes.");
 			return;
 		}
@@ -156,7 +156,7 @@ void handler(int sig, siginfo_t * sip, void *ucp)
 		 * included sig.
 		 */
 		if (!sigismember(&omask, sig)) {
-			tst_resm(TFAIL, "sig should continue to be masked"
+			tst_resm(TFAIL, "sig should continue to be masked "
 				 "because sa_mask originally contained sig.");
 			return;
 		}
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo02.c b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
index 678b8f1d3..7ad0e8bdc 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo02.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 				 TEST_ERRNO);
 		} else {
 			/* Test Failed */
-			tst_brkm(TFAIL, cleanup, "sysinfo() Failed, Expected -1"
+			tst_brkm(TFAIL, cleanup, "sysinfo() Failed, Expected -1 "
 				 "returned %d/n", TEST_ERRNO);
 		}
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
index 2dbe9d185..8b25b05de 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
@@ -66,7 +66,7 @@ int main(void)
 		sigaction(SIGTOTEST, &act, 0);

 		if (0 != sigwait(&set, &sig)) {
-			printf("Sigwait did not return 0."
+			printf("Sigwait did not return 0. "
 				"Possible problem with sigwait function\n");
 			/* FAIL */
 			return 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c
index 44772d9a3..0a9125673 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c
@@ -46,7 +46,7 @@ static void *fn_chld(void *arg)
 	printf("thread: attempt trylock\n");
 	rc = pthread_spin_trylock(&spinlock);
 	if (rc != 0) {
-		printf("Test FAILED: thread failed to get spin lock,"
+		printf("Test FAILED: thread failed to get spin lock, "
 		       "Error code:%d\n", rc);
 		exit(PTS_FAIL);
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
index 889ff1767..8d294f74c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
@@ -97,7 +97,7 @@ int main(void)
 	if (rc) {
 		nb_child = get_ncpu();
 		if (nb_child == -1) {
-			printf("Can not get the number of"
+			printf("Can not get the number of "
 			       "CPUs of your machine.\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
index 1456b9731..892020179 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
@@ -98,7 +98,7 @@ int main(void)
 	if (rc) {
 		nb_child = get_ncpu();
 		if (nb_child == -1) {
-			printf("Can not get the number of"
+			printf("Can not get the number of "
 			       "CPUs of your machine.\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/realtime/func/rt-migrate/rt-migrate.c b/testcases/realtime/func/rt-migrate/rt-migrate.c
index 27872e0c2..c161c7e59 100644
--- a/testcases/realtime/func/rt-migrate/rt-migrate.c
+++ b/testcases/realtime/func/rt-migrate/rt-migrate.c
@@ -462,7 +462,7 @@ int main(int argc, char **argv)
 	memset(&param, 0, sizeof(param));
 	param.sched_priority = nr_tasks + prio_start;
 	if (sched_setscheduler(0, SCHED_FIFO, &param))
-		debug(DBG_WARN, "Warning, can't set priority of"
+		debug(DBG_WARN, "Warning, can't set priority of "
 		      "main thread !\n");
 	intv.tv_sec = INTERVAL / NS_PER_SEC;
 	intv.tv_nsec = INTERVAL % (1 * NS_PER_SEC);
diff --git a/utils/sctp/func_tests/test_1_to_1_accept_close.c b/utils/sctp/func_tests/test_1_to_1_accept_close.c
index 801496246..46511d36d 100644
--- a/utils/sctp/func_tests/test_1_to_1_accept_close.c
+++ b/utils/sctp/func_tests/test_1_to_1_accept_close.c
@@ -134,7 +134,7 @@ main(void)
 	/* accept() TEST1: Bad socket descriptor EBADF, Expected error */
         error = accept(-1, (struct sockaddr *) &acpt_addr, &len);
         if (error != -1 || errno != EBADF)
-		tst_brkm(TBROK, tst_exit, "accept with a bad socket descriptor"
+		tst_brkm(TBROK, tst_exit, "accept with a bad socket descriptor "
                          "error:%d, errno:%d", error, errno);

 	tst_resm(TPASS, "accept() with a bad socket descriptor - EBADF");
@@ -159,7 +159,7 @@ main(void)
         /*accept() TEST3: Invalid address EFAULT, Expected error*/
         error = accept(lstn_sk, (struct sockaddr *) -1, &len);
         if (error != -1 || errno != EFAULT)
-		tst_brkm(TBROK, tst_exit, "accept with invalid address"
+		tst_brkm(TBROK, tst_exit, "accept with invalid address "
                          "error:%d, errno:%d", error, errno);

 	tst_resm(TPASS, "accept() with invalid address - EFAULT");
diff --git a/utils/sctp/func_tests/test_basic.c b/utils/sctp/func_tests/test_basic.c
index 0044a25f6..8e9129ad2 100644
--- a/utils/sctp/func_tests/test_basic.c
+++ b/utils/sctp/func_tests/test_basic.c
@@ -156,7 +156,7 @@ int main(void)
         inmessage.msg_controllen = sizeof(incmsg);
         error = recvmsg(sk2, &inmessage, MSG_WAITALL);
         if (error > 0)
-                tst_brkm(TBROK, tst_exit, "recvmsg on a socket neither"
+                tst_brkm(TBROK, tst_exit, "recvmsg on a socket neither "
 			 "listening nor established error: %d", error);

 	tst_resm(TPASS, "recvmsg on a socket neither listening nor "
diff --git a/utils/sctp/func_tests/test_connect.c b/utils/sctp/func_tests/test_connect.c
index f8fc1c2d5..3cd662c07 100644
--- a/utils/sctp/func_tests/test_connect.c
+++ b/utils/sctp/func_tests/test_connect.c
@@ -119,7 +119,7 @@ main(void)
 	error = connect(clt_sk1, &svr_loop.sa, sizeof(svr_loop));
 	/* Non-blocking connect should return immediately with EINPROGRESS. */
 	if ((error != -1) || (EINPROGRESS != errno))
-		tst_brkm(TBROK, tst_exit, "non-blocking connect error: %d"
+		tst_brkm(TBROK, tst_exit, "non-blocking connect error: %d "
 			 "errno:%d", error, errno);

 	tst_resm(TPASS, "non-blocking connect");
diff --git a/utils/sctp/func_tests/test_connectx.c b/utils/sctp/func_tests/test_connectx.c
index dba612d0e..26890b4f7 100644
--- a/utils/sctp/func_tests/test_connectx.c
+++ b/utils/sctp/func_tests/test_connectx.c
@@ -156,7 +156,7 @@ main(void)
 			      &associd);
 	/* Non-blocking connectx should return immediately with EINPROGRESS. */
 	if ((error != -1) || (EINPROGRESS != errno))
-		tst_brkm(TBROK, tst_exit, "non-blocking connectx error: %d"
+		tst_brkm(TBROK, tst_exit, "non-blocking connectx error: %d "
 			 "errno:%d", error, errno);

 	tst_resm(TPASS, "non-blocking connectx");
diff --git a/utils/sctp/func_tests/test_sockopt.c b/utils/sctp/func_tests/test_sockopt.c
index 80bd74995..baa9ce3b1 100644
--- a/utils/sctp/func_tests/test_sockopt.c
+++ b/utils/sctp/func_tests/test_sockopt.c
@@ -337,7 +337,7 @@ main(void)
 			    MSG_EOR, 0, 0);
 	/* Verify that we received the msg without any ancillary data. */
 	if (inmessage.msg_controllen != 0)
-		tst_brkm(TBROK, tst_exit, "Receive unexpected ancillary"
+		tst_brkm(TBROK, tst_exit, "Receive unexpected ancillary "
 			 "data");

 	/* Enable SCTP_SHUTDOWN_EVENTs on udp_svr_sk. */
@@ -435,7 +435,7 @@ main(void)
 				 "getsockopt(SCTP_STATUS): %s", 
 				 strerror(errno));
 		if (strncmp((char *)&status1, (char *)&status2, optlen))
-	                tst_brkm(TBROK, tst_exit, "sctp_opt_info(SCTP_STAUS)"
+	                tst_brkm(TBROK, tst_exit, "sctp_opt_info(SCTP_STAUS) "
 			       "doesn't match getsockopt(SCTP_STATUS)");

                 tst_resm(TPASS, "sctp_opt_info(SCTP_STATUS)");
--
2.17.1

