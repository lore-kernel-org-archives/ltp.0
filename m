From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 May 2017 16:16:11 +0200
Subject: [LTP] [PATCH] tst_test.c: set the test id automatically
Message-ID: <20170522141611.19386-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the argv[0] to set the tst_test->tid automatically since we fail to
update it commonly and we end up with wrong tid due to copy&paste.

Now it's initialized in the test setup based on argv[0]. If argv[0] is a
path we take last element in it.

This patch is based on v1 by Li Wang but I've omitted moving the
parse_opts() up in the setup() since the setup() function expects
that tst_test sturcture is non-NULL and may segfault if that is not
true.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/test01.c                           |  1 -
 lib/newlib_tests/test02.c                           |  1 -
 lib/newlib_tests/test03.c                           |  1 -
 lib/newlib_tests/test04.c                           |  1 -
 lib/newlib_tests/test05.c                           |  1 -
 lib/newlib_tests/test06.c                           |  1 -
 lib/newlib_tests/test07.c                           |  1 -
 lib/newlib_tests/test08.c                           |  1 -
 lib/newlib_tests/test09.c                           |  1 -
 lib/newlib_tests/test10.c                           |  1 -
 lib/newlib_tests/test11.c                           |  1 -
 lib/newlib_tests/test12.c                           |  1 -
 lib/newlib_tests/test13.c                           |  1 -
 lib/newlib_tests/test14.c                           |  1 -
 lib/newlib_tests/tst_device.c                       |  1 -
 lib/newlib_tests/tst_res_hexd.c                     |  1 -
 lib/newlib_tests/tst_safe_fileops.c                 |  1 -
 lib/tst_test.c                                      | 21 +++++++++++++++++++--
 testcases/kernel/mem/mmapstress/mmapstress04.c      |  1 -
 testcases/kernel/mem/mtest06/mmap3.c                |  1 -
 testcases/kernel/security/dirtyc0w/dirtyc0w.c       |  1 -
 testcases/kernel/syscalls/access/access01.c         |  1 -
 testcases/kernel/syscalls/access/access02.c         |  1 -
 testcases/kernel/syscalls/access/access03.c         |  1 -
 testcases/kernel/syscalls/access/access04.c         |  1 -
 testcases/kernel/syscalls/add_key/add_key01.c       |  1 -
 testcases/kernel/syscalls/add_key/add_key02.c       |  1 -
 testcases/kernel/syscalls/alarm/alarm06.c           |  1 -
 .../kernel/syscalls/clock_getres/clock_getres01.c   |  1 -
 .../syscalls/clock_nanosleep/clock_nanosleep01.c    |  1 -
 .../syscalls/clock_nanosleep2/clock_nanosleep2_01.c |  1 -
 .../syscalls/copy_file_range/copy_file_range01.c    |  1 -
 testcases/kernel/syscalls/creat/creat01.c           |  1 -
 testcases/kernel/syscalls/creat/creat03.c           |  1 -
 testcases/kernel/syscalls/creat/creat04.c           |  1 -
 testcases/kernel/syscalls/creat/creat05.c           |  1 -
 testcases/kernel/syscalls/creat/creat06.c           |  1 -
 testcases/kernel/syscalls/creat/creat07.c           |  1 -
 .../syscalls/epoll_create1/epoll_create1_01.c       |  1 -
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c   |  1 -
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c   |  1 -
 testcases/kernel/syscalls/fanotify/fanotify07.c     |  1 -
 testcases/kernel/syscalls/fcntl/fcntl02.c           |  1 -
 testcases/kernel/syscalls/fcntl/fcntl03.c           |  1 -
 testcases/kernel/syscalls/fcntl/fcntl04.c           |  1 -
 testcases/kernel/syscalls/fcntl/fcntl34.c           |  1 -
 testcases/kernel/syscalls/flistxattr/flistxattr01.c |  1 -
 testcases/kernel/syscalls/flistxattr/flistxattr02.c |  1 -
 testcases/kernel/syscalls/flistxattr/flistxattr03.c |  1 -
 testcases/kernel/syscalls/getcwd/getcwd01.c         |  1 -
 testcases/kernel/syscalls/getcwd/getcwd02.c         |  1 -
 testcases/kernel/syscalls/getcwd/getcwd03.c         |  1 -
 testcases/kernel/syscalls/getcwd/getcwd04.c         |  1 -
 .../kernel/syscalls/getpriority/getpriority01.c     |  1 -
 .../kernel/syscalls/getpriority/getpriority02.c     |  1 -
 testcases/kernel/syscalls/getrandom/getrandom01.c   |  1 -
 testcases/kernel/syscalls/getrandom/getrandom02.c   |  1 -
 testcases/kernel/syscalls/getrandom/getrandom03.c   |  1 -
 testcases/kernel/syscalls/getrandom/getrandom04.c   |  1 -
 .../kernel/syscalls/gettimeofday/gettimeofday02.c   |  1 -
 testcases/kernel/syscalls/getxattr/getxattr04.c     |  1 -
 testcases/kernel/syscalls/ioctl/ioctl04.c           |  1 -
 testcases/kernel/syscalls/ioctl/ioctl05.c           |  1 -
 testcases/kernel/syscalls/ioctl/ioctl06.c           |  1 -
 testcases/kernel/syscalls/ipc/msgget/msgget01.c     |  1 -
 testcases/kernel/syscalls/ipc/msgget/msgget02.c     |  1 -
 testcases/kernel/syscalls/ipc/msgget/msgget03.c     |  1 -
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c     |  1 -
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c     |  1 -
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c     |  1 -
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c     |  1 -
 testcases/kernel/syscalls/kcmp/kcmp01.c             |  1 -
 testcases/kernel/syscalls/kcmp/kcmp02.c             |  1 -
 testcases/kernel/syscalls/kcmp/kcmp03.c             |  1 -
 testcases/kernel/syscalls/keyctl/keyctl02.c         |  1 -
 testcases/kernel/syscalls/keyctl/keyctl03.c         |  1 -
 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c   |  1 -
 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c   |  1 -
 testcases/kernel/syscalls/listxattr/listxattr01.c   |  1 -
 testcases/kernel/syscalls/listxattr/listxattr02.c   |  1 -
 testcases/kernel/syscalls/listxattr/listxattr03.c   |  1 -
 testcases/kernel/syscalls/llistxattr/llistxattr01.c |  1 -
 testcases/kernel/syscalls/llistxattr/llistxattr02.c |  1 -
 testcases/kernel/syscalls/llistxattr/llistxattr03.c |  1 -
 testcases/kernel/syscalls/lseek/lseek11.c           |  1 -
 testcases/kernel/syscalls/madvise/madvise01.c       |  1 -
 testcases/kernel/syscalls/madvise/madvise02.c       |  1 -
 testcases/kernel/syscalls/madvise/madvise05.c       |  1 -
 testcases/kernel/syscalls/madvise/madvise06.c       |  1 -
 testcases/kernel/syscalls/madvise/madvise07.c       |  1 -
 testcases/kernel/syscalls/madvise/madvise08.c       |  1 -
 testcases/kernel/syscalls/madvise/madvise09.c       |  1 -
 .../kernel/syscalls/memfd_create/memfd_create01.c   |  1 -
 .../kernel/syscalls/memfd_create/memfd_create02.c   |  1 -
 testcases/kernel/syscalls/move_pages/move_pages12.c |  1 -
 testcases/kernel/syscalls/mq_notify/mq_notify01.c   |  1 -
 testcases/kernel/syscalls/mq_open/mq_open01.c       |  1 -
 .../syscalls/mq_timedreceive/mq_timedreceive01.c    |  1 -
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c   |  1 -
 testcases/kernel/syscalls/nice/nice01.c             |  1 -
 testcases/kernel/syscalls/nice/nice02.c             |  1 -
 testcases/kernel/syscalls/nice/nice03.c             |  1 -
 testcases/kernel/syscalls/nice/nice04.c             |  1 -
 testcases/kernel/syscalls/pause/pause01.c           |  1 -
 testcases/kernel/syscalls/pipe/pipe01.c             |  1 -
 testcases/kernel/syscalls/pipe/pipe02.c             |  1 -
 testcases/kernel/syscalls/pipe/pipe03.c             |  1 -
 testcases/kernel/syscalls/ppoll/ppoll01.c           |  1 -
 testcases/kernel/syscalls/preadv/preadv01.c         |  1 -
 testcases/kernel/syscalls/preadv/preadv02.c         |  1 -
 testcases/kernel/syscalls/pselect/pselect01.c       |  1 -
 testcases/kernel/syscalls/pselect/pselect03.c       |  1 -
 testcases/kernel/syscalls/pwritev/pwritev01.c       |  1 -
 testcases/kernel/syscalls/pwritev/pwritev02.c       |  1 -
 testcases/kernel/syscalls/quotactl/quotactl01.c     |  1 -
 testcases/kernel/syscalls/quotactl/quotactl02.c     |  1 -
 testcases/kernel/syscalls/quotactl/quotactl03.c     |  1 -
 testcases/kernel/syscalls/read/read01.c             |  1 -
 testcases/kernel/syscalls/recvmsg/recvmsg02.c       |  1 -
 testcases/kernel/syscalls/recvmsg/recvmsg03.c       |  1 -
 .../kernel/syscalls/request_key/request_key01.c     |  1 -
 .../kernel/syscalls/request_key/request_key02.c     |  1 -
 testcases/kernel/syscalls/sbrk/sbrk03.c             |  1 -
 .../sched_setscheduler/sched_setscheduler03.c       |  1 -
 testcases/kernel/syscalls/sendto/sendto02.c         |  1 -
 .../kernel/syscalls/setpriority/setpriority01.c     |  1 -
 .../kernel/syscalls/setpriority/setpriority02.c     |  1 -
 testcases/kernel/syscalls/socket/socket01.c         |  1 -
 testcases/kernel/syscalls/socket/socket02.c         |  1 -
 testcases/kernel/syscalls/socketcall/socketcall01.c |  1 -
 testcases/kernel/syscalls/socketpair/socketpair01.c |  1 -
 testcases/kernel/syscalls/socketpair/socketpair02.c |  1 -
 testcases/kernel/syscalls/syscall/syscall01.c       |  1 -
 testcases/kernel/syscalls/times/times03.c           |  1 -
 testcases/kernel/syscalls/umask/umask01.c           |  1 -
 testcases/kernel/syscalls/umount/umount01.c         |  1 -
 testcases/kernel/syscalls/umount/umount02.c         |  1 -
 testcases/kernel/syscalls/umount/umount03.c         |  1 -
 testcases/kernel/syscalls/waitpid/waitpid06.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid07.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid08.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid09.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid10.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid11.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid12.c       |  1 -
 testcases/kernel/syscalls/waitpid/waitpid13.c       |  1 -
 testcases/kernel/syscalls/write/write01.c           |  1 -
 testcases/kernel/syscalls/writev/writev01.c         |  1 -
 testcases/kernel/syscalls/writev/writev07.c         |  1 -
 testcases/network/netstress/netstress.c             |  1 -
 testcases/network/nfs/nfs_stress/nfs05_make_tree.c  |  1 -
 151 files changed, 19 insertions(+), 152 deletions(-)

diff --git a/lib/newlib_tests/test01.c b/lib/newlib_tests/test01.c
index 5771a66..32bba12 100644
--- a/lib/newlib_tests/test01.c
+++ b/lib/newlib_tests/test01.c
@@ -30,6 +30,5 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test01",
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/test02.c b/lib/newlib_tests/test02.c
index 0a0eff6..b4ea0b6 100644
--- a/lib/newlib_tests/test02.c
+++ b/lib/newlib_tests/test02.c
@@ -43,7 +43,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "test02",
 	.tcnt = 2,
 	.test = do_test,
 };
diff --git a/lib/newlib_tests/test03.c b/lib/newlib_tests/test03.c
index d5772a8..8ed78aa 100644
--- a/lib/newlib_tests/test03.c
+++ b/lib/newlib_tests/test03.c
@@ -28,6 +28,5 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test03",
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/test04.c b/lib/newlib_tests/test04.c
index a9c6b3e..b233279 100644
--- a/lib/newlib_tests/test04.c
+++ b/lib/newlib_tests/test04.c
@@ -51,7 +51,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "test04",
 	.tcnt = 2,
 	.test = do_test,
 	.setup = setup,
diff --git a/lib/newlib_tests/test05.c b/lib/newlib_tests/test05.c
index 886e04d..640abe4 100644
--- a/lib/newlib_tests/test05.c
+++ b/lib/newlib_tests/test05.c
@@ -47,7 +47,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test05",
 	.test_all = do_test,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/lib/newlib_tests/test06.c b/lib/newlib_tests/test06.c
index 22381fb..cce1768 100644
--- a/lib/newlib_tests/test06.c
+++ b/lib/newlib_tests/test06.c
@@ -47,7 +47,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test06",
 	.test_all = do_test,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/lib/newlib_tests/test07.c b/lib/newlib_tests/test07.c
index f067135..8c06506 100644
--- a/lib/newlib_tests/test07.c
+++ b/lib/newlib_tests/test07.c
@@ -45,7 +45,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test07",
 	.test_all = do_test,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/lib/newlib_tests/test08.c b/lib/newlib_tests/test08.c
index 77d530e..5463b53 100644
--- a/lib/newlib_tests/test08.c
+++ b/lib/newlib_tests/test08.c
@@ -70,7 +70,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test08",
 	.test_all = do_test,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/lib/newlib_tests/test09.c b/lib/newlib_tests/test09.c
index 0674754..02911bd 100644
--- a/lib/newlib_tests/test09.c
+++ b/lib/newlib_tests/test09.c
@@ -56,6 +56,5 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test09",
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/test10.c b/lib/newlib_tests/test10.c
index 01d4807..d0ad7a2 100644
--- a/lib/newlib_tests/test10.c
+++ b/lib/newlib_tests/test10.c
@@ -27,7 +27,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test10",
 	.test_all = do_test,
 	.timeout = 1,
 };
diff --git a/lib/newlib_tests/test11.c b/lib/newlib_tests/test11.c
index 1354f52..211e7e6 100644
--- a/lib/newlib_tests/test11.c
+++ b/lib/newlib_tests/test11.c
@@ -29,6 +29,5 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test11",
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/test12.c b/lib/newlib_tests/test12.c
index c7901f4..47ca735 100644
--- a/lib/newlib_tests/test12.c
+++ b/lib/newlib_tests/test12.c
@@ -26,7 +26,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test12",
 	.timeout = 2,
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/test13.c b/lib/newlib_tests/test13.c
index 7ad5172..e71af19 100644
--- a/lib/newlib_tests/test13.c
+++ b/lib/newlib_tests/test13.c
@@ -30,7 +30,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test13",
 	.timeout = 1,
 	.forks_child = 1,
 	.test_all = do_test,
diff --git a/lib/newlib_tests/test14.c b/lib/newlib_tests/test14.c
index 4d94978..56d6d2f 100644
--- a/lib/newlib_tests/test14.c
+++ b/lib/newlib_tests/test14.c
@@ -39,7 +39,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "test14",
 	.test_all = do_test,
 	.cleanup = cleanup,
 };
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 9bcdce1..3314901 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -44,7 +44,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "tst_device",
 	.needs_tmpdir = 1,
 	.needs_device = 1,
 	.dev_min_size = 300,
diff --git a/lib/newlib_tests/tst_res_hexd.c b/lib/newlib_tests/tst_res_hexd.c
index 333ea56..bff9edd 100644
--- a/lib/newlib_tests/tst_res_hexd.c
+++ b/lib/newlib_tests/tst_res_hexd.c
@@ -26,6 +26,5 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "tst_res_hexd",
 	.test_all = do_test,
 };
diff --git a/lib/newlib_tests/tst_safe_fileops.c b/lib/newlib_tests/tst_safe_fileops.c
index bdf4e9d..1b8d523 100644
--- a/lib/newlib_tests/tst_safe_fileops.c
+++ b/lib/newlib_tests/tst_safe_fileops.c
@@ -35,6 +35,5 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "tst_safe_fileops",
 	.test_all = do_test,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 14a47d6..0bbcbf7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -616,6 +616,22 @@ static void copy_resources(void)
 		TST_RESOURCE_COPY(NULL, tst_test->resource_files[i], NULL);
 }
 
+static void get_tid(char *argv[])
+{
+	char *p;
+
+	if (!argv[0] || !argv[0][0]) {
+		tst_res(TINFO, "argv[0] is empty!");
+		return "ltp_empty_argv";
+	}
+
+	p = strrchr(argv[0], '/');
+	if (p)
+		return p+1;
+
+	return argv[0];
+}
+
 static struct tst_device tdev;
 struct tst_device *tst_device;
 
@@ -625,7 +641,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TBROK, "No tests to run");
 
 	if (!tst_test->tid)
-		tst_brk(TBROK, "No tid set in test structure");
+		tst_test->tid = get_tid(argv);
 
 	if (!tst_test->test && !tst_test->test_all)
 		tst_brk(TBROK, "No test function speficied");
@@ -873,10 +889,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	lib_pid = getpid();
 	tst_test = self;
-	TCID = tst_test->tid;
 
 	do_setup(argc, argv);
 
+	TCID = tst_test->tid;
+
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
diff --git a/testcases/kernel/mem/mmapstress/mmapstress04.c b/testcases/kernel/mem/mmapstress/mmapstress04.c
index 3c4749f..3925f48 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress04.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress04.c
@@ -120,7 +120,6 @@ done:
 }
 
 static struct tst_test test = {
-	.tid = "mmapstress04",
 	.needs_tmpdir = 1,
 	.test_all = mmapstress04,
 	.setup = setup,
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index d572720..d314ff8 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -205,7 +205,6 @@ static struct tst_option options[] = {
 };
 
 static struct tst_test test = {
-	.tid = "mmap3",
 	.options = options,
 	.needs_tmpdir = 1,
 	.setup = setup,
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index fdf5d24..b8094ba 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -103,7 +103,6 @@ void dirtyc0w_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "dirtyc0w",
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 25e13b7..7a92525 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -357,7 +357,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "access01",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 86e0342..0154b83 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -196,7 +196,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "access02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/access/access03.c b/testcases/kernel/syscalls/access/access03.c
index b9a96a0..bba3068 100644
--- a/testcases/kernel/syscalls/access/access03.c
+++ b/testcases/kernel/syscalls/access/access03.c
@@ -94,7 +94,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "access03",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index 820aab6..dbb6d27 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -121,7 +121,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "access04",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index bb31451..f193f71 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -49,6 +49,5 @@ static void verify_add_key(void)
 }
 
 static struct tst_test test = {
-	.tid = "add_key01",
 	.test_all = verify_add_key,
 };
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index fc99191..866800d 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -69,7 +69,6 @@ static void verify_add_key(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "add_key02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_add_key,
 };
diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index 8634128..b9e0f83 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -76,7 +76,6 @@ static void verify_alarm(void)
 }
 
 static struct tst_test test = {
-	.tid = "alarm06",
 	.setup = setup,
 	.test_all = verify_alarm,
 };
diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 91a30be..989683f 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -80,7 +80,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "clock_getres01",
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcase),
 };
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index f64378c..a4458e8 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -178,7 +178,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "clock_nanosleep01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
index 968a77d..d40ca8e 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
@@ -57,6 +57,5 @@ static void verify_clock_nanosleep2(void)
 }
 
 static struct tst_test test = {
-	.tid = "clock_nanosleep2_01",
 	.test_all = verify_clock_nanosleep2,
 };
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index e6bd921..1a2e039 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -212,7 +212,6 @@ static void copy_file_range_verify(void)
 }
 
 static struct tst_test test = {
-	.tid = "copy_file_range01",
 	.setup = setup,
 	.needs_tmpdir = 1,
 	.test_all = copy_file_range_verify,
diff --git a/testcases/kernel/syscalls/creat/creat01.c b/testcases/kernel/syscalls/creat/creat01.c
index 1ca0968..571c771 100644
--- a/testcases/kernel/syscalls/creat/creat01.c
+++ b/testcases/kernel/syscalls/creat/creat01.c
@@ -85,7 +85,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "creat01",
 	.tcnt = 2,
 	.test = verify_creat,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/creat/creat03.c b/testcases/kernel/syscalls/creat/creat03.c
index bb3cdf3..f095fb6 100644
--- a/testcases/kernel/syscalls/creat/creat03.c
+++ b/testcases/kernel/syscalls/creat/creat03.c
@@ -68,7 +68,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "creat03",
 	.test_all = verify_creat,
 	.needs_tmpdir = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
index 37e430f..c973108 100644
--- a/testcases/kernel/syscalls/creat/creat04.c
+++ b/testcases/kernel/syscalls/creat/creat04.c
@@ -82,7 +82,6 @@ void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "creat04",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_creat,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/creat/creat05.c b/testcases/kernel/syscalls/creat/creat05.c
index 5e1342e..154f1a2 100644
--- a/testcases/kernel/syscalls/creat/creat05.c
+++ b/testcases/kernel/syscalls/creat/creat05.c
@@ -87,7 +87,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "creat05",
 	.test_all = verify_creat,
 	.needs_tmpdir = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index db0850a..ec0baf1 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -162,7 +162,6 @@ static void test6_cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "creat06",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_creat,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index dc40461..e1b2676 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -68,7 +68,6 @@ static const char *const resource_files[] = {
 };
 
 static struct tst_test test = {
-	.tid = "creat07",
 	.test_all = verify_creat,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index bd2d0e8..436a489 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -62,7 +62,6 @@ static void verify_epoll_create1(void)
 }
 
 static struct tst_test test = {
-	.tid = "epoll_create1_01",
 	.min_kver = "2.6.27",
 	.test_all = verify_epoll_create1,
 };
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 5833c38..0fa1ab2 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -150,7 +150,6 @@ static void verify_epoll_ctl(void)
 }
 
 static struct tst_test test = {
-	.tid = "epoll_ctl01",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_epoll_ctl,
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index 360ae47..fcbdcac 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -117,7 +117,6 @@ static void verify_epoll_ctl(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "epoll_ctl02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 2a46ee1..5cb5bbb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -231,7 +231,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "fanotify07",
 	.test_all = test_fanotify,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl02.c b/testcases/kernel/syscalls/fcntl/fcntl02.c
index cffa921..d7a6c19 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl02.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl02.c
@@ -85,7 +85,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "fcntl02",
 	.needs_tmpdir = 1,
 	.test = verify_fcntl,
 	.tcnt = ARRAY_SIZE(min_fds),
diff --git a/testcases/kernel/syscalls/fcntl/fcntl03.c b/testcases/kernel/syscalls/fcntl/fcntl03.c
index cf2f8cf..fe1d112 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl03.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl03.c
@@ -74,7 +74,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "fcntl03",
 	.needs_tmpdir = 1,
 	.test_all = verify_fcntl,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index cddc6c3..c00677c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -80,7 +80,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "fcntl04",
 	.needs_tmpdir = 1,
 	.test_all = verify_fcntl,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 6b84249..c778db0 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -143,7 +143,6 @@ static void test01(void)
 }
 
 static struct tst_test test = {
-	.tid = "fcntl34",
 	.min_kver = "3.15.0",
 	.needs_tmpdir = 1,
 	.test_all = test01,
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr01.c b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
index 5fa4e7f..b287aab 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr01.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
@@ -90,7 +90,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "flistxattr01",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test_all = verify_flistxattr,
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr02.c b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
index 876d53a..9f85ee5 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr02.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
@@ -92,7 +92,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "flistxattr02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_flistxattr,
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr03.c b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
index 0fcf0d8..14b68d4 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr03.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
@@ -83,7 +83,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "flistxattr03",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_flistxattr,
diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index bd56437..fdf3061 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -80,7 +80,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "getcwd01",
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_getcwd
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index 09fa190..384157d 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -80,7 +80,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "getcwd02",
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_getcwd
diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index 4f8f872..2711a2d 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -98,7 +98,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "getcwd03",
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.test_all = verify_getcwd
diff --git a/testcases/kernel/syscalls/getcwd/getcwd04.c b/testcases/kernel/syscalls/getcwd/getcwd04.c
index 7e2ca23..ba8c358 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd04.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd04.c
@@ -107,7 +107,6 @@ static void do_child(void)
 }
 
 static struct tst_test test = {
-	.tid = "getcwd04",
 	.setup = setup,
 	.test_all = verify_getcwd,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index 6edf39d..caf8573 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -63,7 +63,6 @@ static void verify_getpriority(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "getpriority01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_getpriority,
 };
diff --git a/testcases/kernel/syscalls/getpriority/getpriority02.c b/testcases/kernel/syscalls/getpriority/getpriority02.c
index d577b2b..c2d3560 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority02.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority02.c
@@ -71,7 +71,6 @@ static void verify_getpriority(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "getpriority02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_getpriority,
 };
diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index 7c7ed94..4af85e2 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -46,7 +46,6 @@ static void verify_getrandom(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "getrandom01",
 	.tcnt = ARRAY_SIZE(modes),
 	.test = verify_getrandom,
 };
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index ac20d79..4eef751 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -73,7 +73,6 @@ static void verify_getrandom(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "getrandom02",
 	.tcnt = ARRAY_SIZE(modes),
 	.test = verify_getrandom,
 };
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index e754ca3..53a8ed7 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -63,7 +63,6 @@ static void verify_getrandom(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "getrandom03",
 	.tcnt = ARRAY_SIZE(sizes),
 	.test = verify_getrandom,
 };
diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index 0eae031..41bcf0d 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -55,6 +55,5 @@ static void verify_getrandom(void)
 }
 
 static struct tst_test test = {
-	.tid = "getrandom04",
 	.test_all = verify_getrandom,
 };
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 0ff001a..8c221a2 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -103,7 +103,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "gettimeofday02",
 	.setup = setup,
 	.options = options,
 	.test_all = verify_gettimeofday,
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 625337d..1dcb14d 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -118,7 +118,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "getxattr04",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 8f78247..89e89ec 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -93,7 +93,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ioctl04",
 	.needs_tmpdir = 1,
 	.format_device = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl05.c b/testcases/kernel/syscalls/ioctl/ioctl05.c
index d1b44f1..459efdb 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl05.c
@@ -78,7 +78,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ioctl05",
 	.needs_device = 1,
 	.needs_root = 1,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 642283a..6fc6443 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -64,7 +64,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ioctl06",
 	.needs_root = 1,
 	.needs_device = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index 8e058c5..3d1010f 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -71,7 +71,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgget01",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_msgget,
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index 9cf1314..acf4b38 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -109,7 +109,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgget02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 97911f9..f7e5ace 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -88,7 +88,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgget03",
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index d605fca..6036c64 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -70,7 +70,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgsnd01",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_msgsnd,
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index 5632079..2232b0e 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -122,7 +122,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgsnd02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 032c870..d817254 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -114,7 +114,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgsnd05",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index ce7f046..25fce0a 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -88,7 +88,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "msgsnd06",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index 0aa4da6..1143ad6 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -111,7 +111,6 @@ static void verify_kcmp(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "kcmp01",
 	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index ad0b09d..33f132f 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -103,7 +103,6 @@ static void verify_kcmp(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "kcmp02",
 	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index d64ea2c..b6ca40c 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -95,7 +95,6 @@ static void verify_kcmp(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "kcmp03",
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index aa98822..b783bf7 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -114,7 +114,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "keyctl02",
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 83d5dcb..41d062e 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -56,7 +56,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "keyctl03",
 	.test_all = do_test,
 };
 
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index 4a12f0a..301d532 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -105,7 +105,6 @@ next:
 }
 
 static struct tst_test test = {
-	.tid = "lgetxattr01",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test_all = verify_lgetxattr,
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
index e50bd94..ebc28f2 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -95,7 +95,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "lgetxattr02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_lgetxattr,
diff --git a/testcases/kernel/syscalls/listxattr/listxattr01.c b/testcases/kernel/syscalls/listxattr/listxattr01.c
index 7ab3c1f..e2820ca 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr01.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr01.c
@@ -83,7 +83,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "listxattr01",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test_all = verify_listxattr,
diff --git a/testcases/kernel/syscalls/listxattr/listxattr02.c b/testcases/kernel/syscalls/listxattr/listxattr02.c
index fa73532..998689a 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr02.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr02.c
@@ -96,7 +96,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "listxattr02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_listxattr,
diff --git a/testcases/kernel/syscalls/listxattr/listxattr03.c b/testcases/kernel/syscalls/listxattr/listxattr03.c
index 5536084..9dc7ad7 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr03.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr03.c
@@ -78,7 +78,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "listxattr03",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_listxattr,
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index 0176893..f997e0c 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -93,7 +93,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "llistxattr01",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test_all = verify_llistxattr,
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index 06b15d1..468ff98 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -97,7 +97,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "llistxattr02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_llistxattr,
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 6a1cb6b..91bb3f4 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -77,7 +77,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "llistxattr03",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_llistxattr,
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 4c5bb00..47987c1 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -229,7 +229,6 @@ static void test_lseek(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid          = "lseek11",
 	.tcnt         = ARRAY_SIZE(tparams),
 	.test         = test_lseek,
 	.setup        = setup,
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 4ec3ef2..4b18a21 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -120,7 +120,6 @@ static void verify_madvise(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "madvise01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_madvise,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 592536d..b773efd 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -180,7 +180,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "madvise02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = advice_test,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index 4f8718f..23dacbd 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -55,7 +55,6 @@ static void verify_madvise(void)
 }
 
 static struct tst_test test = {
-	.tid = "madvise05",
 	.min_kver = "3.9.0",
 	.test_all = verify_madvise,
 };
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 9b3e1f0..7b178a2 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -179,7 +179,6 @@ static void test_advice_willneed(void)
 }
 
 static struct tst_test test = {
-	.tid = "madvise06",
 	.test_all = test_advice_willneed,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index 80586a1..29ac10e 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -127,7 +127,6 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "madvise07",
 	.test = run,
 	.tcnt = ARRAY_SIZE(maptypes),
 	.min_kver = "2.6.31",
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index ebda3f2..296c2bf 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -225,7 +225,6 @@ static void run(unsigned int test_nr)
 }
 
 static struct tst_test test = {
-	.tid = "madvise08",
 	.test = run,
 	.tcnt = 2,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 38a101f..7ad76f7 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -331,7 +331,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "madvise09",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
index 04a5f4f..54c817b 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -263,7 +263,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "memfd_create01",
 	.test = verify_memfd_create,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create02.c b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
index 1c56156..d65e496 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create02.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
@@ -87,7 +87,6 @@ static void verify_memfd_create_errno(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "memfd_create02",
 	.test = verify_memfd_create_errno,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index f2a035f..e1d956d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -252,7 +252,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "move_pages12",
 	.min_kver = "2.6.32",
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 99ec2ed..2406dee 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -243,7 +243,6 @@ static struct tst_option options[] = {
 };
 
 static struct tst_test test = {
-	.tid = "mq_notify01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.options = options,
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index 9d2b136..3f4bf7e 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -298,7 +298,6 @@ CLEANUP:
 }
 
 static struct tst_test test = {
-	.tid = "mq_open01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 32ab7a1..f6ff4a5 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -312,7 +312,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "mq_timedreceive01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 40f6db2..6e271c5 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -124,7 +124,6 @@ EXIT:
 }
 
 static struct tst_test test = {
-	.tid = "mq_unlink01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index 26aaa99..fede2c7 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -66,7 +66,6 @@ static void verify_nice(void)
 }
 
 static struct tst_test test = {
-	.tid = "nice01",
 	.test_all = verify_nice,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index 4c9ccae..6ae70f8 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -64,6 +64,5 @@ static void verify_nice(void)
 }
 
 static struct tst_test test = {
-	.tid = "nice02",
 	.test_all = verify_nice,
 };
diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 6b90c2d..7c41e28 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -71,7 +71,6 @@ static void verify_nice(void)
 }
 
 static struct tst_test test = {
-	.tid = "nice03",
 	.forks_child = 1,
 	.test_all = verify_nice,
 };
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index 3d63f31..07ad21e 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -56,7 +56,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "nice04",
 	.setup = setup,
 	.test_all = verify_nice,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
index 433161c..1c55855 100644
--- a/testcases/kernel/syscalls/pause/pause01.c
+++ b/testcases/kernel/syscalls/pause/pause01.c
@@ -61,7 +61,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "pause01",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.test_all = do_test,
diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index f0db2fa..8f71460 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -61,6 +61,5 @@ static void verify_pipe(void)
 }
 
 static struct tst_test test = {
-	.tid = "pipe01",
 	.test_all = verify_pipe,
 };
diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index 9d7932c..8defa5e 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -101,7 +101,6 @@ static void verify_pipe(void)
 }
 
 static struct tst_test test = {
-	.tid = "pipe02",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.test_all = verify_pipe,
diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index 2062d19..267cf88 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -59,6 +59,5 @@ static void verify_pipe(void)
 }
 
 static struct tst_test test = {
-	.tid = "pipe03",
 	.test_all = verify_pipe,
 };
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 2cb336b..0dcda7f 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -268,7 +268,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "ppoll01",
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index c2ba09e..87233cd 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -113,7 +113,6 @@ void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "preadv01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 26ebfa3..c171d83 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -130,7 +130,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "preadv02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 4bb1261..9a6a309 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -148,7 +148,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "pselect01",
 	.test = verify_pselect,
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/pselect/pselect03.c b/testcases/kernel/syscalls/pselect/pselect03.c
index a92531e..4a2b849 100644
--- a/testcases/kernel/syscalls/pselect/pselect03.c
+++ b/testcases/kernel/syscalls/pselect/pselect03.c
@@ -57,7 +57,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "pselect03",
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 88a1756..67c9f21 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -109,7 +109,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "pwritev01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index ec9de20..76b722b 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -121,7 +121,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "pwritev02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index a994e95..0173ed4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -207,7 +207,6 @@ static void verify_quota(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "quotactl01",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index ec5c7a0..9e6408a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -172,7 +172,6 @@ static void verify_quota(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "quotactl02",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test = verify_quota,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 8c2cde5..64caac3 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -86,7 +86,6 @@ static void verify_quota(void)
 }
 
 static struct tst_test test = {
-	.tid = "quotactl03",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test_all = verify_quota,
diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index d2ccd0a..855a3a1 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -65,7 +65,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "read01",
 	.test_all = verify_read,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg02.c b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
index 9ed520b..c2c6009 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg02.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
@@ -106,7 +106,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "recvmsg02",
 	.min_kver = "2.6.27",
 	.test_all = verify_recvmsg,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg03.c b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
index bee9c12..31e7585 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg03.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
@@ -155,7 +155,6 @@ static void verify_recvmsg(void)
 }
 
 static struct tst_test test = {
-	.tid = "recvmsg03",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index 583ecdc..d46bafa 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -61,7 +61,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "request_key01",
 	.setup = setup,
 	.test_all = verify_request_key,
 };
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
index 17b1560..9bba241 100644
--- a/testcases/kernel/syscalls/request_key/request_key02.c
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -107,7 +107,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "request_key02",
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_request_key,
diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
index bdc4995..46fb2d1 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
@@ -76,6 +76,5 @@ static void sbrk_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "sbrk03",
 	.test_all = sbrk_test,
 };
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
index 8fcb65e..a513106 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
@@ -171,7 +171,6 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "sched_setscheduler03",
 	.tcnt = ARRAY_SIZE(cases),
 	.test = do_test,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/sendto/sendto02.c b/testcases/kernel/syscalls/sendto/sendto02.c
index b7b59fc..c8c2979 100644
--- a/testcases/kernel/syscalls/sendto/sendto02.c
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -84,7 +84,6 @@ static void verify_sendto(void)
 }
 
 static struct tst_test test = {
-	.tid = "sendto02",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_sendto,
diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index df02bce..d6cc79e 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -138,7 +138,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "setpriority01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/setpriority/setpriority02.c b/testcases/kernel/syscalls/setpriority/setpriority02.c
index cf58e02..0f61fca 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority02.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority02.c
@@ -121,7 +121,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "setpriority02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
index 9592d51..9d2fe4f 100644
--- a/testcases/kernel/syscalls/socket/socket01.c
+++ b/testcases/kernel/syscalls/socket/socket01.c
@@ -98,7 +98,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "socket01",
 	.tcnt = ARRAY_SIZE(tdat),
 	.setup = setup,
 	.test = verify_socket
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index ecc5b01..0584163 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -79,7 +79,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "socket02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_socket,
 	.min_kver = "2.6.27",
diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index 9401964..7fe5cbe 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -61,7 +61,6 @@ void verify_socketcall(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "socketcall01",
 	.test = verify_socketcall,
 	.tcnt = ARRAY_SIZE(TC),
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index f7833a4..6729075 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -102,7 +102,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "socketpair01",
 	.tcnt = ARRAY_SIZE(tdat),
 	.setup = setup,
 	.test = verify_socketpair
diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index 6507e31..f8057ce 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -92,7 +92,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "socketpair02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_socketpair,
 	.min_kver = "2.6.27",
diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 1f5b8a3..728f538 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -88,7 +88,6 @@ static void verify_syscall(unsigned int n)
 }
 
 static struct tst_test test = {
-	.tid = "syscall01",
 	.test = verify_syscall,
 	.tcnt = ARRAY_SIZE(tcases),
 };
diff --git a/testcases/kernel/syscalls/times/times03.c b/testcases/kernel/syscalls/times/times03.c
index 0db8215..78d72d2 100644
--- a/testcases/kernel/syscalls/times/times03.c
+++ b/testcases/kernel/syscalls/times/times03.c
@@ -207,7 +207,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "times03",
 	.setup = setup,
 	.forks_child = 1,
 	.test_all = do_test,
diff --git a/testcases/kernel/syscalls/umask/umask01.c b/testcases/kernel/syscalls/umask/umask01.c
index 8ee03df..ee80624 100644
--- a/testcases/kernel/syscalls/umask/umask01.c
+++ b/testcases/kernel/syscalls/umask/umask01.c
@@ -71,7 +71,6 @@ static void verify_umask(void)
 }
 
 static struct tst_test test = {
-	.tid = "umask01",
 	.test_all = verify_umask,
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 3b5aeb9..80a80c9 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -65,7 +65,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "umount01",
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.format_device = 1,
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 690ba5f..5bcd17d 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -93,7 +93,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "umount02",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index c1bcb05..abff0ce 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -70,7 +70,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "umount03",
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.format_device = 1,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid06.c b/testcases/kernel/syscalls/waitpid/waitpid06.c
index 20c30e1..3b8c5e5 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid06.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid06.c
@@ -55,7 +55,6 @@ static void do_child_1(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid06",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid07.c b/testcases/kernel/syscalls/waitpid/waitpid07.c
index 9166fbe..d9056ea 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid07.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid07.c
@@ -60,7 +60,6 @@ static void do_child_1(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid07",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
index f6efb9d..9e9f12c 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid08.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
@@ -63,7 +63,6 @@ static void do_child_1(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid08",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid09.c b/testcases/kernel/syscalls/waitpid/waitpid09.c
index 43beeff..7811937 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid09.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid09.c
@@ -170,7 +170,6 @@ static void waitpid09_test(unsigned int id)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid09",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.test = waitpid09_test,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index 90b3800..8b324f7 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -112,7 +112,6 @@ static void do_sleep(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid10",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
index 41186fb..72a6a32 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid11.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
@@ -61,7 +61,6 @@ static void do_child_1(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid11",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid12.c b/testcases/kernel/syscalls/waitpid/waitpid12.c
index b2db49d..2339c09 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid12.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid12.c
@@ -71,7 +71,6 @@ static void do_child_1(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid12",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/waitpid/waitpid13.c b/testcases/kernel/syscalls/waitpid/waitpid13.c
index 79a99eb..13d8f2e 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid13.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid13.c
@@ -71,7 +71,6 @@ static void do_child_1(void)
 }
 
 static struct tst_test test = {
-	.tid = "waitpid13",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = waitpid_setup,
diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index b53f907..1a60052 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -58,7 +58,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "write01",
 	.test_all = verify_write,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/writev/writev01.c b/testcases/kernel/syscalls/writev/writev01.c
index b02abba..7753db4 100644
--- a/testcases/kernel/syscalls/writev/writev01.c
+++ b/testcases/kernel/syscalls/writev/writev01.c
@@ -145,7 +145,6 @@ static void test_writev(unsigned int i)
 }
 
 static struct tst_test test = {
-	.tid = "writev01",
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.test = test_writev,
diff --git a/testcases/kernel/syscalls/writev/writev07.c b/testcases/kernel/syscalls/writev/writev07.c
index 20a5590..7322189 100644
--- a/testcases/kernel/syscalls/writev/writev07.c
+++ b/testcases/kernel/syscalls/writev/writev07.c
@@ -144,7 +144,6 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.tid = "writev07",
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.test_all = test_writev,
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 8184716..0796b86 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -752,7 +752,6 @@ static struct tst_option options[] = {
 };
 
 static struct tst_test test = {
-	.tid = "netstress",
 	.test_all = do_test,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 6b2c98f..c4cbd05 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -226,7 +226,6 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "nfs05_make_tree",
 	.options = opts,
 	.test_all = do_test,
 	.setup = setup,
-- 
2.10.2

