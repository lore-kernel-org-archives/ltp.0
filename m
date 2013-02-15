Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U6HP8-0002iD-Sx
	for ltp-list@lists.sourceforge.net; Fri, 15 Feb 2013 09:16:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U6HOz-00043Y-Bn
	for ltp-list@lists.sourceforge.net; Fri, 15 Feb 2013 09:16:26 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1F9GBCx021867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Feb 2013 04:16:11 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Feb 2013 10:16:05 +0100
Message-Id: <02591071dc6cc1bdbb630e4c0d8e349042247fd7.1360919410.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] rename syscall() macro to ltp_syscall()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch renames syscall() macro defined in linux_syscall_numbers.h
to reduce confusion with syscall(2). It also updates all places
where it was previously in use.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/containers/libclone/libclone.c    |    2 +-
 testcases/kernel/containers/mqns/mqns_01.c         |   11 +++----
 testcases/kernel/containers/mqns/mqns_02.c         |    6 ++--
 testcases/kernel/containers/mqns/mqns_03.c         |    5 +--
 testcases/kernel/containers/mqns/mqns_04.c         |    5 +--
 .../kernel/containers/netns/check_netns_enabled.c  |    2 +-
 testcases/kernel/containers/pidns/pidns30.c        |   12 ++++----
 testcases/kernel/containers/pidns/pidns31.c        |   12 ++++----
 .../controllers/cpuset/cpuset_lib/libcpuset.c      |    7 +++--
 .../cpuset_syscall_test/cpuset_syscall_test.c      |    7 +++--
 testcases/kernel/include/linux_syscall_numbers.h   |    2 +-
 testcases/kernel/include/regen.sh                  |    2 +-
 testcases/kernel/lib/numa_helper.c                 |    2 +-
 .../performance_counters/performance_counter01.c   |    4 +-
 .../performance_counters/performance_counter02.c   |    2 +-
 testcases/kernel/syscalls/accept4/accept4_01.c     |    4 +-
 testcases/kernel/syscalls/add_key/add_key01.c      |    2 +-
 testcases/kernel/syscalls/add_key/add_key02.c      |   11 ++++---
 testcases/kernel/syscalls/bdflush/bdflush01.c      |    2 +-
 .../kernel/syscalls/cacheflush/cacheflush01.c      |    6 ++--
 testcases/kernel/syscalls/capget/capget01.c        |    2 +-
 testcases/kernel/syscalls/capget/capget02.c        |    2 +-
 testcases/kernel/syscalls/capset/capset01.c        |    6 +---
 testcases/kernel/syscalls/capset/capset02.c        |    6 +---
 .../kernel/syscalls/clock_getres/clock_getres01.c  |    6 +++-
 .../clock_nanosleep2/clock_nanosleep2_01.c         |    2 +-
 testcases/kernel/syscalls/dup3/dup3_01.c           |    4 +-
 .../syscalls/epoll_create1/epoll_create1_01.c      |    4 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c      |    2 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_01.c   |    4 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_02.c   |    4 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_03.c   |    2 +-
 .../kernel/syscalls/exit_group/exit_group01.c      |    2 +-
 testcases/kernel/syscalls/faccessat/faccessat01.c  |    2 +-
 testcases/kernel/syscalls/fallocate/fallocate01.c  |    4 +-
 testcases/kernel/syscalls/fallocate/fallocate02.c  |    4 +-
 testcases/kernel/syscalls/fallocate/fallocate03.c  |    4 +-
 testcases/kernel/syscalls/fchmodat/fchmodat01.c    |    2 +-
 testcases/kernel/syscalls/fchownat/fchownat01.c    |    2 +-
 testcases/kernel/syscalls/fstatat/fstatat01.c      |    6 ++--
 testcases/kernel/syscalls/futimesat/futimesat01.c  |    2 +-
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   29 ++++++++++---------
 .../syscalls/get_robust_list/get_robust_list01.c   |   11 +++----
 testcases/kernel/syscalls/getegid/compat_16.h      |    2 +-
 testcases/kernel/syscalls/geteuid/compat_16.h      |    2 +-
 testcases/kernel/syscalls/getgid/compat_16.h       |    4 +-
 testcases/kernel/syscalls/getuid/compat_16.h       |    4 +-
 .../syscalls/inotify_init/inotify_init1_01.c       |    4 +-
 .../syscalls/inotify_init/inotify_init1_02.c       |    4 +-
 testcases/kernel/syscalls/keyctl/keyctl01.c        |    7 +++--
 testcases/kernel/syscalls/linkat/linkat01.c        |    2 +-
 testcases/kernel/syscalls/mbind/mbind01.c          |   14 +++++-----
 .../syscalls/migrate_pages/migrate_pages01.c       |   20 +++++++-------
 .../syscalls/migrate_pages/migrate_pages02.c       |    7 +++--
 testcases/kernel/syscalls/mkdirat/mkdirat01.c      |    2 +-
 testcases/kernel/syscalls/mknodat/mknodat01.c      |    2 +-
 testcases/kernel/syscalls/mq_open/mq_open01.c      |    2 +-
 testcases/kernel/syscalls/newuname/newuname01.c    |    2 +-
 testcases/kernel/syscalls/openat/openat01.c        |    2 +-
 testcases/kernel/syscalls/pipe2/pipe2_01.c         |    4 +-
 testcases/kernel/syscalls/pipe2/pipe2_02.c         |    4 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c          |    3 +-
 testcases/kernel/syscalls/quotactl/quotactl01.c    |    5 +--
 testcases/kernel/syscalls/readahead/readahead01.c  |   10 +++---
 testcases/kernel/syscalls/readahead/readahead02.c  |    5 ++-
 .../kernel/syscalls/readlinkat/readlinkat01.c      |    2 +-
 testcases/kernel/syscalls/renameat/renameat01.c    |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    2 +-
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   10 +++---
 .../syscalls/rt_sigprocmask/rt_sigprocmask02.c     |    2 +-
 .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c   |    4 +-
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   11 ++++---
 .../syscalls/set_thread_area/set_thread_area01.c   |    2 +-
 .../syscalls/set_tid_address/set_tid_address01.c   |    2 +-
 testcases/kernel/syscalls/setgid/compat_16.h       |    2 +-
 testcases/kernel/syscalls/setgroups/compat_16.h    |    2 +-
 testcases/kernel/syscalls/sgetmask/sgetmask01.c    |    8 +++--
 testcases/kernel/syscalls/signalfd/signalfd01.c    |    2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_01.c |    5 ++-
 testcases/kernel/syscalls/signalfd4/signalfd4_02.c |    5 ++-
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    |    2 +-
 testcases/kernel/syscalls/splice/splice01.c        |    3 +-
 testcases/kernel/syscalls/splice/splice02.c        |    3 +-
 testcases/kernel/syscalls/ssetmask/ssetmask01.c    |    6 ++--
 testcases/kernel/syscalls/swapoff/swapoff01.c      |    4 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c      |    9 +++---
 testcases/kernel/syscalls/swapon/swapon01.c        |    4 +-
 testcases/kernel/syscalls/swapon/swapon02.c        |   10 ++++---
 testcases/kernel/syscalls/swapon/swapon03.c        |   11 ++++---
 testcases/kernel/syscalls/symlinkat/symlinkat01.c  |    2 +-
 .../syscalls/sync_file_range/sync_file_range01.c   |   11 ++++---
 testcases/kernel/syscalls/tee/tee01.c              |    5 ++-
 .../syscalls/timer_getoverrun/timer_getoverrun01.c |    7 +++--
 .../syscalls/timer_gettime/timer_gettime01.c       |    8 +++---
 testcases/kernel/syscalls/timerfd/timerfd01.c      |    6 ++--
 testcases/kernel/syscalls/timerfd/timerfd02.c      |    5 ++-
 testcases/kernel/syscalls/timerfd/timerfd03.c      |    5 ++-
 testcases/kernel/syscalls/tkill/tkill01.c          |    4 +-
 testcases/kernel/syscalls/tkill/tkill02.c          |    2 +-
 testcases/kernel/syscalls/unlinkat/unlinkat01.c    |    2 +-
 testcases/kernel/syscalls/utimensat/utimensat01.c  |    2 +-
 testcases/kernel/syscalls/vmsplice/vmsplice01.c    |    5 ++-
 .../kernel/timers/clock_gettime/clock_gettime02.c  |    2 +-
 .../kernel/timers/clock_gettime/clock_gettime03.c  |    2 +-
 .../kernel/timers/clock_settime/clock_settime02.c  |    4 +-
 .../kernel/timers/clock_settime/clock_settime03.c  |    6 ++--
 .../kernel/timers/timer_create/timer_create02.c    |    5 ++-
 .../kernel/timers/timer_create/timer_create03.c    |    2 +-
 .../kernel/timers/timer_create/timer_create04.c    |    2 +-
 .../kernel/timers/timer_delete/timer_delete02.c    |    6 ++--
 .../kernel/timers/timer_delete/timer_delete03.c    |    2 +-
 .../kernel/timers/timer_settime/timer_settime02.c  |    6 ++--
 .../kernel/timers/timer_settime/timer_settime03.c  |    4 +-
 115 files changed, 285 insertions(+), 266 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-rename-syscall-macro-to-ltp_syscall.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-rename-syscall-macro-to-ltp_syscall.patch"

diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index 902f464..ebaac43 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -56,7 +56,7 @@ int do_unshare_tests(unsigned long clone_flags,
 	}
 	if (pid == 0) {
 		close(retpipe[0]);
-		ret = syscall(SYS_unshare, clone_flags);
+		ret = ltp_syscall(SYS_unshare, clone_flags);
 		if (ret == -1) {
 			if (write(retpipe[1], "0", 2) < 0) {
 				perror("unshare:write(retpipe[1], ..)");
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 5bdabf1..a8d2748 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -56,7 +56,7 @@ int check_mqueue(void *vtest)
 		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
 		exit(1);
 	}
-	mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
+	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 	if (mqd == -1) {
 		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
 			perror("write(p2[1], ...) failed");
@@ -94,9 +94,8 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
 	}
 
-	mqd =
-	    syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL, 0777,
-		    NULL);
+	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
+		0777, NULL);
 	if (mqd == -1) {
 		perror("mq_open");
 		tst_resm(TFAIL, "mq_open failed");
@@ -109,7 +108,7 @@ int main(int argc, char *argv[])
 	if (r < 0) {
 		tst_resm(TFAIL, "failed clone/unshare");
 		mq_close(mqd);
-		syscall(__NR_mq_unlink, NOSLASH_MQ1);
+		ltp_syscall(__NR_mq_unlink, NOSLASH_MQ1);
 		tst_exit();
 	}
 
@@ -133,7 +132,7 @@ int main(int argc, char *argv[])
 	if (mq_close(mqd) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
 	}
-	syscall(__NR_mq_unlink, NOSLASH_MQ1);
+	ltp_syscall(__NR_mq_unlink, NOSLASH_MQ1);
 
 	tst_exit();
 }
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 65cff40..8fab439 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -61,7 +61,7 @@ int check_mqueue(void *vtest)
 	} else {
 
 		mqd =
-		    syscall(__NR_mq_open, NOSLASH_MQ1,
+		    ltp_syscall(__NR_mq_open, NOSLASH_MQ1,
 			    O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
 		if (mqd == -1) {
 			if (write(p2[1], "mqfail", strlen("mqfail") + 1) < 0) {
@@ -84,7 +84,7 @@ int check_mqueue(void *vtest)
 					if (mq_close(mqd) < 0) {
 						perror("mq_close(mqd) failed");
 						exit(1);
-					} else if (syscall(__NR_mq_unlink,
+					} else if (ltp_syscall(__NR_mq_unlink,
 							   NOSLASH_MQ1) < 0) {
 						perror("mq_unlink(" NOSLASH_MQ1
 						       ") failed");
@@ -150,7 +150,7 @@ int main(int argc, char *argv[])
 		tst_resm(TFAIL, "child process could not create mqueue");
 		umount(DEV_MQUEUE);
 	} else {
-		mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
+		mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 		if (mqd == -1) {
 			tst_resm(TPASS,
 				 "Parent process can't see the mqueue");
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 6650db4..f9b3cd4 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -68,9 +68,8 @@ int check_mqueue(void *vtest)
 		exit(1);
 	}
 
-	mqd =
-	    syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL, 0755,
-		    NULL);
+	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
+		0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
 		exit(1);
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 3ecf3e5..80d25a6 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -61,9 +61,8 @@ int check_mqueue(void *vtest)
 
 	read(p1[0], buf, 3);	/* go */
 
-	mqd =
-	    syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL, 0755,
-		    NULL);
+	mqd = ltp_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
+		0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
 		tst_exit();
diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c b/testcases/kernel/containers/netns/check_netns_enabled.c
index b60de19..ab8ee2f 100644
--- a/testcases/kernel/containers/netns/check_netns_enabled.c
+++ b/testcases/kernel/containers/netns/check_netns_enabled.c
@@ -45,7 +45,7 @@ int main(void)
 		tst_resm(TBROK | TERRNO,
 			 "CLONE_NEWNET (%d) or CLONE_NEWNS (%d) not supported",
 			 CLONE_NEWNET, CLONE_NEWNS);
-	else if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) == -1)
+	else if (ltp_syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) == -1)
 		tst_resm(TFAIL | TERRNO, "unshare syscall smoke test failed");
 	else
 		tst_resm(TPASS, "unshare syscall smoke test passed");
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 75c736b..b29e6b7 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -93,7 +93,7 @@ static void remove_pipe(int *fd)
 static void remove_mqueue(mqd_t mqd)
 {
 	mq_close(mqd);
-	syscall(__NR_mq_unlink, mqname);
+	ltp_syscall(__NR_mq_unlink, mqname);
 }
 
 static void cleanup(void)
@@ -113,7 +113,7 @@ static void cleanup(void)
 static void cleanup_child(void)
 {
 	if (mqd != -1) {
-		syscall(__NR_mq_notify, mqd, NULL);
+		ltp_syscall(__NR_mq_notify, mqd, NULL);
 	}
 	cleanup();
 }
@@ -186,7 +186,7 @@ int child_fn(void *arg)
 	while (read(father_to_child[0], buf, 1) != 1)
 		sleep(1);
 
-	mqd = syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
+	mqd = ltp_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
 	if (mqd == -1) {
 		perror("mq_open failed");
 		return 1;
@@ -197,7 +197,7 @@ int child_fn(void *arg)
 	notif.sigev_notify = SIGEV_SIGNAL;
 	notif.sigev_signo = SIGUSR1;
 	notif.sigev_value.sival_int = mqd;
-	if (syscall(__NR_mq_notify, mqd, &notif) == -1) {
+	if (ltp_syscall(__NR_mq_notify, mqd, &notif) == -1) {
 		perror("mq_notify failed");
 		return 1;
 	} else
@@ -244,7 +244,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
 	}
 
-	syscall(__NR_mq_unlink, mqname);
+	ltp_syscall(__NR_mq_unlink, mqname);
 
 	/* container creation on PID namespace */
 	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
@@ -252,7 +252,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
 
 	mqd =
-	    syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
+	    ltp_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
 		    NULL);
 	if (mqd == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "mq_open failed");
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index 1498d16..e87ef19 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -95,7 +95,7 @@ static void remove_pipe(int *fd)
 static void remove_mqueue(mqd_t mqd)
 {
 	mq_close(mqd);
-	syscall(__NR_mq_unlink, mqname);
+	ltp_syscall(__NR_mq_unlink, mqname);
 }
 
 /*
@@ -118,7 +118,7 @@ static void cleanup_resources(int step, mqd_t mqd)
 		break;
 
 	case F_STEP_2:
-		syscall(__NR_mq_notify, mqd, NULL);
+		ltp_syscall(__NR_mq_notify, mqd, NULL);
 		/* fall through */
 	case F_STEP_1:
 		remove_mqueue(mqd);
@@ -177,7 +177,7 @@ int child_fn(void *arg)
 	}
 	tst_resm(TINFO, "cinit: my father is ready to receive a message");
 
-	mqd = syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
+	mqd = ltp_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
 	if (mqd == (mqd_t) - 1) {
 		tst_resm(TBROK, "cinit: mq_open() failed (%s)",
 			 strerror(errno));
@@ -261,9 +261,9 @@ int main(int argc, char *argv[])
 		cleanup_mqueue(TBROK, NO_STEP, 0);
 	}
 
-	syscall(__NR_mq_unlink, mqname);
+	ltp_syscall(__NR_mq_unlink, mqname);
 	mqd =
-	    syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
+	    ltp_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
 		    NULL);
 	if (mqd == (mqd_t) - 1) {
 		tst_resm(TBROK, "parent: mq_open() failed (%s)",
@@ -286,7 +286,7 @@ int main(int argc, char *argv[])
 	info.mqd = mqd;
 	info.pid = cpid;
 	notif.sigev_value.sival_ptr = &info;
-	if (syscall(__NR_mq_notify, mqd, &notif) == (mqd_t) - 1) {
+	if (ltp_syscall(__NR_mq_notify, mqd, &notif) == (mqd_t) -1) {
 		tst_resm(TBROK, "parent: mq_notify() failed (%s)",
 			 strerror(errno));
 		cleanup_mqueue(TBROK, F_STEP_1, mqd);
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index b9cf67c..d2d3c12 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -3090,21 +3090,22 @@ done:
 
 static int sched_setaffinity(pid_t pid, unsigned len, unsigned long *mask)
 {
-	return syscall(__NR_sched_setaffinity, pid, len, mask);
+	return ltp_syscall(__NR_sched_setaffinity, pid, len, mask);
 }
 
 #if HAVE_DECL_MPOL_F_ADDR && HAVE_DECL_MPOL_F_NODE
 static int get_mempolicy(int *policy, unsigned long *nmask,
 			 unsigned long maxnode, void *addr, int flags)
 {
-	return syscall(__NR_get_mempolicy, policy, nmask, maxnode, addr, flags);
+	return ltp_syscall(__NR_get_mempolicy, policy, nmask, maxnode,
+		addr, flags);
 }
 #endif
 
 #if HAVE_DECL_MPOL_BIND || HAVE_DECL_MPOL_DEFAULT
 static int set_mempolicy(int mode, unsigned long *nmask, unsigned long maxnode)
 {
-	return syscall(__NR_set_mempolicy, mode, nmask, maxnode);
+	return ltp_syscall(__NR_set_mempolicy, mode, nmask, maxnode);
 }
 #endif
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 5469e9f..5c30763 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -62,7 +62,8 @@ int ret;
 static int get_mempolicy(int *policy, unsigned long *nmask,
 			 unsigned long maxnode, void *addr, int flags)
 {
-	return syscall(__NR_get_mempolicy, policy, nmask, maxnode, addr, flags);
+	return ltp_syscall(__NR_get_mempolicy, policy, nmask, maxnode, addr,
+		flags);
 }
 #endif
 
@@ -70,14 +71,14 @@ static int get_mempolicy(int *policy, unsigned long *nmask,
 static int mbind(void *start, unsigned long len, int policy,
 		 unsigned long *nodemask, unsigned long maxnode, unsigned flags)
 {
-	return syscall(__NR_mbind, start, len, policy, nodemask, maxnode,
+	return ltp_syscall(__NR_mbind, start, len, policy, nodemask, maxnode,
 		       flags);
 }
 
 static int set_mempolicy(int policy, unsigned long *nodemask,
 			 unsigned long maxnode)
 {
-	return syscall(__NR_set_mempolicy, policy, nodemask, maxnode);
+	return ltp_syscall(__NR_set_mempolicy, policy, nodemask, maxnode);
 }
 #endif
 
diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 68ec70c..545b420 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -17,7 +17,7 @@
 #include <sys/syscall.h>
 #include "cleanup.c"
 
-#define syscall(NR, ...) ({ \
+#define ltp_syscall(NR, ...) ({ \
 	int __ret; \
 	if (NR == 0) { \
 		errno = ENOSYS; \
diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index 110f083..86cdc09 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -25,7 +25,7 @@ cat << EOF > "${output_pid}"
 #include <sys/syscall.h>
 #include "cleanup.c"
 
-#define syscall(NR, ...) ({ \\
+#define ltp_syscall(NR, ...) ({ \\
 	int __ret; \\
 	if (NR == 0) { \\
 		errno = ENOSYS; \\
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 50d9e9a..4ab8e3c 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -83,7 +83,7 @@ static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 	 * utility function in older versions:
 	 * http://www.spinics.net/lists/linux-numa/msg00849.html
 	 */
-	if (syscall(__NR_get_mempolicy, NULL, nodemask->n,
+	if (ltp_syscall(__NR_get_mempolicy, NULL, nodemask->n,
 		    max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
 		return -2;
 #else
diff --git a/testcases/kernel/performance_counters/performance_counter01.c b/testcases/kernel/performance_counters/performance_counter01.c
index 15ba337..4f56060 100644
--- a/testcases/kernel/performance_counters/performance_counter01.c
+++ b/testcases/kernel/performance_counters/performance_counter01.c
@@ -68,13 +68,13 @@ int main(void)
 	unsigned long long count1, count2;
 	int fd1, fd2, ret;
 
-	fd1 = syscall(__NR_perf_event_open,
+	fd1 = ltp_syscall(__NR_perf_event_open,
 		      PERF_COUNT_INSTRUCTIONS, 0, 0, 0, -1);
 	if (fd1 < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "Failed to create PERF_COUNT_INSTRUCTIONS fd");
 	}
-	fd2 = syscall(__NR_perf_event_open,
+	fd2 = ltp_syscall(__NR_perf_event_open,
 		      PERF_COUNT_CACHE_MISSES, 0, 0, 0, -1);
 	if (fd2 < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/performance_counters/performance_counter02.c b/testcases/kernel/performance_counters/performance_counter02.c
index 9f07732..5402b81 100644
--- a/testcases/kernel/performance_counters/performance_counter02.c
+++ b/testcases/kernel/performance_counters/performance_counter02.c
@@ -120,7 +120,7 @@ enum hw_event_types {
 int sys_perf_counter_open(struct perf_counter_hw_event *hw_event,
 			  pid_t pid, int cpu, int group_fd, unsigned long flags)
 {
-	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd,
+	return ltp_syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd,
 		       flags);
 }
 
diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index 9449621..526be6e 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -163,9 +163,9 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t * addrlen, int flags)
 	args[2] = (long)addrlen;
 	args[3] = flags;
 
-	return syscall(__NR_socketcall, SYS_ACCEPT4, args);
+	return ltp_syscall(__NR_socketcall, SYS_ACCEPT4, args);
 #else
-	return syscall(__NR_accept4, fd, sockaddr, addrlen, flags);
+	return ltp_syscall(__NR_accept4, fd, sockaddr, addrlen, flags);
 #endif
 }
 #endif
diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index 3920129..c31255f 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 	setup();
 
 	/* Call add_key. */
-	TEST(syscall
+	TEST(ltp_syscall
 	     (__NR_add_key, "keyring", "wjkey", NULL, 0,
 	      KEY_SPEC_THREAD_KEYRING));
 	if (TEST_RETURN == -1)
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index dc8fec1..591fa0c 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -136,11 +136,12 @@ int main(int ac, char **av)
 			for (i = 0; i < test_count; i++) {
 
 				/* Call add_key. */
-				TEST(syscall(__NR_add_key, test_cases[i].type,
-					     test_cases[i].desc,
-					     test_cases[i].payload,
-					     test_cases[i].plen,
-					     KEY_SPEC_USER_KEYRING));
+				TEST(ltp_syscall(__NR_add_key,
+					test_cases[i].type,
+					test_cases[i].desc,
+					test_cases[i].payload,
+					test_cases[i].plen,
+					KEY_SPEC_USER_KEYRING));
 
 				if (TEST_RETURN != -1) {
 					tst_resm(TINFO,
diff --git a/testcases/kernel/syscalls/bdflush/bdflush01.c b/testcases/kernel/syscalls/bdflush/bdflush01.c
index e424558..a0441a3 100644
--- a/testcases/kernel/syscalls/bdflush/bdflush01.c
+++ b/testcases/kernel/syscalls/bdflush/bdflush01.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 	data = 0;
 	Tst_count = 1;
 	for (testno = 0; testno < TST_TOTAL; ++testno) {
-		TEST(syscall(__NR_bdflush, 3, data));
+		TEST(ltp_syscall(__NR_bdflush, 3, data));
 		if (TEST_RETURN == -1)
 			tst_brkm(TFAIL | TTERRNO, cleanup, "bdflush failed");
 		else
diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index 1ec2f5d..c197b74 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -143,21 +143,21 @@ int main(int ac, char **av)
 	}
 
 	/* Invokes cacheflush() with proper parameters */
-	TEST(syscall(__NR_cacheflush, addr, getpagesize(), ICACHE));
+	TEST(ltp_syscall(__NR_cacheflush, addr, getpagesize(), ICACHE));
 	if (TEST_RETURN == 0) {
 		tst_resm(TPASS, "passed with no errno");
 	} else {
 		tst_resm(TFAIL, "failed with unexpected errno");
 	}
 
-	TEST(syscall(__NR_cacheflush, addr, getpagesize(), DCACHE));
+	TEST(ltp_syscall(__NR_cacheflush, addr, getpagesize(), DCACHE));
 	if (TEST_RETURN == 0) {
 		tst_resm(TPASS, "passed with no errno");
 	} else {
 		tst_resm(TFAIL, "failed with unexpected errno");
 	}
 
-	TEST(syscall(__NR_cacheflush, addr, getpagesize(), BCACHE));
+	TEST(ltp_syscall(__NR_cacheflush, addr, getpagesize(), BCACHE));
 	if (TEST_RETURN == 0) {
 		tst_resm(TPASS, "passed with no errno");
 	} else {
diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index af934ff..0b66c1c 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -100,7 +100,7 @@ int main(int ac, char **av)
 
 		Tst_count = 0;
 
-		TEST(syscall(__NR_capget, &header, &data));
+		TEST(ltp_syscall(__NR_capget, &header, &data));
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TPASS, "capget() returned %ld", TEST_RETURN);
diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index d41ed42..6fc955e 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			test_setup(i);
-			TEST(syscall(__NR_capget, test_cases[i].headerp,
+			TEST(ltp_syscall(__NR_capget, test_cases[i].headerp,
 				     test_cases[i].datap));
 
 			if (TEST_RETURN == -1 &&
diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index e9e3df1..09b37d2 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 		Tst_count = 0;
 
-		TEST(syscall(__NR_capset, &header, &data));
+		TEST(ltp_syscall(__NR_capset, &header, &data));
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TPASS, "capset() returned %ld", TEST_RETURN);
@@ -139,10 +139,8 @@ void setup()
 
 	header.version = _LINUX_CAPABILITY_VERSION;
 	header.pid = 0;
-	if (syscall(__NR_capget, &header, &data) == -1) {
+	if (ltp_syscall(__NR_capget, &header, &data) == -1)
 		tst_brkm(TBROK | TERRNO, NULL, "capget() failed");
-	}
-
 }
 
 void cleanup()
diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index e0c5246..b51594e 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -155,7 +155,7 @@ int main(int ac, char **av)
 		for (; i < TST_TOTAL; i++) {
 
 			test_setup(i, av[0]);
-			TEST(syscall(__NR_capset, test_cases[i].headerp,
+			TEST(ltp_syscall(__NR_capset, test_cases[i].headerp,
 				     test_cases[i].datap));
 
 			if (TEST_RETURN == -1 &&
@@ -188,10 +188,8 @@ void setup()
 	 * header.version must be _LINUX_CAPABILITY_VERSION
 	 */
 	header.version = _LINUX_CAPABILITY_VERSION;
-	if (syscall(__NR_capget, &header, &data) == -1) {
+	if (ltp_syscall(__NR_capget, &header, &data) == -1)
 		tst_brkm(TBROK | TERRNO, NULL, "capget failed");
-	}
-
 }
 
 void cleanup()
diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 38512c7..63c25a1 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -215,9 +215,11 @@ static int do_test(struct test_case *tc)
 	 */
 	errno = 0;
 	if (tc->ttype == NULL_POINTER)
-		TEST(sys_ret = syscall(__NR_clock_getres, tc->clk_id, NULL));
+		TEST(sys_ret = ltp_syscall(__NR_clock_getres, tc->clk_id,
+			NULL));
 	else
-		TEST(sys_ret = syscall(__NR_clock_getres, tc->clk_id, &res));
+		TEST(sys_ret = ltp_syscall(__NR_clock_getres, tc->clk_id,
+			&res));
 	sys_errno = errno;
 
 	/*
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
index 18be1aa..d1c3527 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
@@ -113,7 +113,7 @@ const clockid_t CLOCK_TO_USE = CLOCK_MONOTONIC;
 static int clock_nanosleep2(clockid_t clock_id, int flags,
 			    const struct timespec *req, struct timespec *rem)
 {
-	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
+	return ltp_syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index 657e6f7..8113f85 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -130,7 +130,7 @@ int main(int argc, char *argv[])
 			 "This test can only run on kernels that are 2.6.27 and higher");
 	setup();
 
-	fd = syscall(__NR_dup3, 1, 4, 0);
+	fd = ltp_syscall(__NR_dup3, 1, 4, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(0) failed");
 	}
@@ -143,7 +143,7 @@ int main(int argc, char *argv[])
 	}
 	close(fd);
 
-	fd = syscall(__NR_dup3, 1, 4, O_CLOEXEC);
+	fd = ltp_syscall(__NR_dup3, 1, 4, O_CLOEXEC);
 	if (fd == -1) {
 		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(O_CLOEXEC) failed");
 	}
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index 0282aee..9780321 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -139,7 +139,7 @@ int main(int argc, char *argv[])
 
 	setup();
 
-	fd = syscall(__NR_epoll_create1, 0);
+	fd = ltp_syscall(__NR_epoll_create1, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "epoll_create1(0) failed");
 	}
@@ -152,7 +152,7 @@ int main(int argc, char *argv[])
 			 "epoll_create1(0) set close-on-exec flag");
 	}
 	close(fd);
-	fd = syscall(__NR_epoll_create1, EPOLL_CLOEXEC);
+	fd = ltp_syscall(__NR_epoll_create1, EPOLL_CLOEXEC);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "epoll_create1(EPOLL_CLOEXEC) failed");
 	}
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index b75843a..31c992d 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -74,7 +74,7 @@ int TST_TOTAL = 15;
 static int myeventfd(unsigned int initval, int flags)
 {
 	/* eventfd2 uses FLAGS but eventfd doesn't take FLAGS. */
-	return syscall(__NR_eventfd, initval);
+	return ltp_syscall(__NR_eventfd, initval);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
index 5b0dd5a..e417597 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
@@ -138,7 +138,7 @@ int main(int argc, char *argv[])
 	}
 	setup();
 
-	fd = syscall(__NR_eventfd2, 1, 0);
+	fd = ltp_syscall(__NR_eventfd2, 1, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "eventfd2(0) failed");
 	}
@@ -151,7 +151,7 @@ int main(int argc, char *argv[])
 	}
 	close(fd);
 
-	fd = syscall(__NR_eventfd2, 1, EFD_CLOEXEC);
+	fd = ltp_syscall(__NR_eventfd2, 1, EFD_CLOEXEC);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "eventfd2(EFD_CLOEXEC) failed");
 	}
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index 66e80f5..eb120a9 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -136,7 +136,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	Tst_count = 0;
-	fd = syscall(__NR_eventfd2, 1, 0);
+	fd = ltp_syscall(__NR_eventfd2, 1, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "eventfd2(0) failed");
 	}
@@ -149,7 +149,7 @@ int main(int argc, char *argv[])
 	}
 	close(fd);
 
-	fd = syscall(__NR_eventfd2, 1, EFD_NONBLOCK);
+	fd = ltp_syscall(__NR_eventfd2, 1, EFD_NONBLOCK);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "eventfd2(EFD_NONBLOCK) failed");
 	}
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index 375907e..59c6686 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -54,7 +54,7 @@ void cleanup()
 
 static int eventfd2(int count, int flags)
 {
-	return syscall(__NR_eventfd2, count, flags);
+	return ltp_syscall(__NR_eventfd2, count, flags);
 }
 
 static void xsem_wait(int fd)
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 5802603..4db694c 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 		tst_brkm(TFAIL | TERRNO, cleanup, "fork failed");
 	} else if (cpid == 0) {
 		sleep(5);
-		TEST(syscall(__NR_exit_group, 4));
+		TEST(ltp_syscall(__NR_exit_group, 4));
 	} else {
 		w = wait(&status);
 		if (w == -1)
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 76b1c79..45be493 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -78,7 +78,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
 
 int myfaccessat(int dirfd, const char *filename, int mode)
 {
-	return syscall(__NR_faccessat, dirfd, filename, mode);
+	return ltp_syscall(__NR_faccessat, dirfd, filename, mode);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index d3cef1d..6270e37 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -244,13 +244,13 @@ int main(int ac, char **av)
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 #if __WORDSIZE == 32
-	return (long)syscall(__NR_fallocate, fd, mode,
+	return (long)ltp_syscall(__NR_fallocate, fd, mode,
 			     __LONG_LONG_PAIR((off_t) (offset >> 32),
 					      (off_t) offset),
 			     __LONG_LONG_PAIR((off_t) (len >> 32),
 					      (off_t) len));
 #else
-	return syscall(__NR_fallocate, fd, mode, offset, len);
+	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
 #endif
 }
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index c4578f8..b26ef70 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -235,13 +235,13 @@ void populate_file()
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 #if __WORDSIZE == 32
-	return (long)syscall(__NR_fallocate, fd, mode,
+	return (long)ltp_syscall(__NR_fallocate, fd, mode,
 			     __LONG_LONG_PAIR((off_t) (offset >> 32),
 					      (off_t) offset),
 			     __LONG_LONG_PAIR((off_t) (len >> 32),
 					      (off_t) len));
 #else
-	return syscall(__NR_fallocate, fd, mode, offset, len);
+	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
 #endif
 }
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index 2d81a36..ac044e0 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -230,13 +230,13 @@ void populate_file()
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 #if __WORDSIZE == 32
-	return (long)syscall(__NR_fallocate, fd, mode,
+	return (long)ltp_syscall(__NR_fallocate, fd, mode,
 			     __LONG_LONG_PAIR((off_t) (offset >> 32),
 					      (off_t) offset),
 			     __LONG_LONG_PAIR((off_t) (len >> 32),
 					      (off_t) len));
 #else
-	return syscall(__NR_fallocate, fd, mode, offset, len);
+	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
 #endif
 }
 
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index ba66e8c..2100eb8 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -78,7 +78,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
 
 int myfchmodat(int dirfd, const char *filename, mode_t mode)
 {
-	return syscall(__NR_fchmodat, dirfd, filename, mode);
+	return ltp_syscall(__NR_fchmodat, dirfd, filename, mode);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index e7fbf12..7b3e8f2 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -83,7 +83,7 @@ gid_t gid;
 int myfchownat(int dirfd, const char *filename, uid_t owner, gid_t group,
 	       int flags)
 {
-	return syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
+	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 54adf6f..7fea942 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -93,18 +93,18 @@ struct stat statbuf;
 int myfstatat(int dirfd, const char *filename, struct stat64 *statbuf,
 	      int flags)
 {
-	return syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
+	return ltp_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
 }
 #elif (defined __NR_newfstatat) && (__NR_newfstatat != 0)
 int myfstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
 {
-	return syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
+	return ltp_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
 }
 #else
 /* stub - will never run */
 int myfstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
 {
-	return syscall(0, dirfd, filename, statbuf, flags);
+	return ltp_syscall(0, dirfd, filename, statbuf, flags);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 5a96f66..2aa8dfb 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -80,7 +80,7 @@ struct timeval times[2];
 
 int myfutimesat(int dirfd, const char *filename, struct timeval *times)
 {
-	return syscall(__NR_futimesat, dirfd, filename, times);
+	return ltp_syscall(__NR_futimesat, dirfd, filename, times);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index e51639d..f9b6232 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -251,14 +251,15 @@ static int do_test(struct test_case *tc)
 		flags = 0;
 		p = NULL;
 		if (tc->from_node == NONE)
-			TEST(syscall(__NR_set_mempolicy, tc->policy, NULL, 0));
+			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
+				NULL, 0));
 		else
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-			TEST(syscall(__NR_set_mempolicy, tc->policy,
-				     nodemask, maxnode));
+			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
+				nodemask, maxnode));
 #else
-			TEST(syscall(__NR_set_mempolicy, tc->policy,
-				     nodemask->maskp, nodemask->size));
+			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
+				nodemask->maskp, nodemask->size));
 #endif
 		if (TEST_RETURN < 0) {
 			tst_resm(TBROK | TERRNO, "set_mempolicy");
@@ -273,15 +274,15 @@ static int do_test(struct test_case *tc)
 		if (p == MAP_FAILED)
 			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
 		if (tc->from_node == NONE)
-			TEST(syscall(__NR_mbind, p, len, tc->policy,
-				     NULL, 0, 0));
+			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
+				NULL, 0, 0));
 		else
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-			TEST(syscall(__NR_mbind, p, len, tc->policy,
-				     nodemask, maxnode, 0));
+			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
+				nodemask, maxnode, 0));
 #else
-			TEST(syscall(__NR_mbind, p, len, tc->policy,
-				     nodemask->maskp, nodemask->size, 0));
+			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
+				nodemask->maskp, nodemask->size, 0));
 #endif
 		if (TEST_RETURN < 0) {
 			tst_resm(TBROK | TERRNO, "mbind");
@@ -301,10 +302,10 @@ static int do_test(struct test_case *tc)
 	errno = 0;
 	cmp_ok = 1;
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	TEST(ret = syscall(__NR_get_mempolicy, &policy, getnodemask,
+	TEST(ret = ltp_syscall(__NR_get_mempolicy, &policy, getnodemask,
 			   maxnode, p, flags));
 #else
-	TEST(ret = syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
+	TEST(ret = ltp_syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
 			   getnodemask->size, p, flags));
 #endif
 	err = TEST_ERRNO;
@@ -339,7 +340,7 @@ static void cleanup(void)
 static void setup(void)
 {
 	/* check syscall availability */
-	syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
+	ltp_syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
 
 	TEST_PAUSE;
 	tst_tmpdir();
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index 4300588..d3ab244 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -78,7 +78,6 @@ int main(int argc, char **argv)
 	char *msg;
 	struct robust_list_head head;
 	size_t len_ptr;		/* size of structure struct robust_list_head */
-	int retval;
 
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -98,7 +97,7 @@ int main(int argc, char **argv)
 		 * argument.
 		 */
 
-		TEST(retval = syscall(__NR_get_robust_list, 0,
+		TEST(ltp_syscall(__NR_get_robust_list, 0,
 				      (struct robust_list_head *)&head,
 				      (size_t *) NULL));
 
@@ -114,7 +113,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL,
 				 "get_robust_list succeeded unexpectedly");
 
-		TEST(retval = syscall(__NR_get_robust_list, 0,
+		TEST(ltp_syscall(__NR_get_robust_list, 0,
 				      (struct robust_list_head **)NULL,
 				      &len_ptr));
 
@@ -135,7 +134,7 @@ int main(int argc, char **argv)
 		 * find the task specified by the pid argument.
 		 */
 
-		TEST(retval = syscall(__NR_get_robust_list, UINT16_MAX,
+		TEST(ltp_syscall(__NR_get_robust_list, UINT16_MAX,
 				      (struct robust_list_head *)&head,
 				      &len_ptr));
 
@@ -151,7 +150,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL,
 				 "get_robust_list succeeded unexpectedly");
 
-		TEST(retval = syscall(__NR_get_robust_list, 0,
+		TEST(ltp_syscall(__NR_get_robust_list, 0,
 				      (struct robust_list_head **)&head,
 				      &len_ptr));
 
@@ -164,7 +163,7 @@ int main(int argc, char **argv)
 		if (setuid(1) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "setuid(1) failed");
 
-		TEST(retval = syscall(__NR_get_robust_list, 1,
+		TEST(ltp_syscall(__NR_get_robust_list, 1,
 				      (struct robust_list_head *)&head,
 				      &len_ptr));
 
diff --git a/testcases/kernel/syscalls/getegid/compat_16.h b/testcases/kernel/syscalls/getegid/compat_16.h
index 054ed19..a28289b 100644
--- a/testcases/kernel/syscalls/getegid/compat_16.h
+++ b/testcases/kernel/syscalls/getegid/compat_16.h
@@ -32,7 +32,7 @@
 GID_T
 GETEGID(void)
 {
-	return syscall(__NR_getegid);
+	return ltp_syscall(__NR_getegid);
 }
 
 #else
diff --git a/testcases/kernel/syscalls/geteuid/compat_16.h b/testcases/kernel/syscalls/geteuid/compat_16.h
index 733ada5..9436cd5 100644
--- a/testcases/kernel/syscalls/geteuid/compat_16.h
+++ b/testcases/kernel/syscalls/geteuid/compat_16.h
@@ -32,7 +32,7 @@
 UID_T
 GETEUID(void)
 {
-	return syscall(__NR_geteuid);
+	return ltp_syscall(__NR_geteuid);
 }
 
 #else
diff --git a/testcases/kernel/syscalls/getgid/compat_16.h b/testcases/kernel/syscalls/getgid/compat_16.h
index 9561a3d..249e270 100644
--- a/testcases/kernel/syscalls/getgid/compat_16.h
+++ b/testcases/kernel/syscalls/getgid/compat_16.h
@@ -32,13 +32,13 @@
 GID_T
 GETGID(void)
 {
-	return syscall(__NR_getgid);
+	return ltp_syscall(__NR_getgid);
 }
 
 GID_T
 GETEGID(void)
 {
-	return syscall(__NR_getegid);
+	return ltp_syscall(__NR_getegid);
 }
 
 #else
diff --git a/testcases/kernel/syscalls/getuid/compat_16.h b/testcases/kernel/syscalls/getuid/compat_16.h
index 4b0c88a..db6f332 100644
--- a/testcases/kernel/syscalls/getuid/compat_16.h
+++ b/testcases/kernel/syscalls/getuid/compat_16.h
@@ -32,13 +32,13 @@
 UID_T
 GETUID(void)
 {
-	return syscall(__NR_getuid);
+	return ltp_syscall(__NR_getuid);
 }
 
 UID_T
 GETEUID(void)
 {
-	return syscall(__NR_geteuid);
+	return ltp_syscall(__NR_geteuid);
 }
 
 #else
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
index cf94652..08b4c12 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
@@ -148,7 +148,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			fd = syscall(__NR_inotify_init1, 0);
+			fd = ltp_syscall(__NR_inotify_init1, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "inotify_init1(0) failed");
@@ -164,7 +164,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = syscall(__NR_inotify_init1, IN_CLOEXEC);
+			fd = ltp_syscall(__NR_inotify_init1, IN_CLOEXEC);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "inotify_init1(IN_CLOEXEC) failed");
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
index a574650..0b80685 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
@@ -143,7 +143,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			fd = syscall(__NR_inotify_init1, 0);
+			fd = ltp_syscall(__NR_inotify_init1, 0);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "inotify_init1(0) failed");
@@ -160,7 +160,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = syscall(__NR_inotify_init1, IN_NONBLOCK);
+			fd = ltp_syscall(__NR_inotify_init1, IN_NONBLOCK);
 			if (fd == -1) {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "inotify_init1(IN_NONBLOCK) failed");
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 9d329b5..2b7043e 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 		for (testno = 1; testno < TST_TOTAL; ++testno) {
 
 			/* Call keyctl() and ask for a keyring's ID. */
-			ret = syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+			ret = ltp_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
 				      KEY_SPEC_USER_SESSION_KEYRING);
 			if (ret != -1) {
 				tst_resm(TPASS,
@@ -147,13 +147,14 @@ int main(int ac, char **av)
 			}
 
 			for (ne_key = INT32_MAX; ne_key > INT32_MIN; ne_key--) {
-				ret = syscall(__NR_keyctl, KEYCTL_READ, ne_key);
+				ret = ltp_syscall(__NR_keyctl, KEYCTL_READ,
+					ne_key);
 				if (ret == -1 && errno == ENOKEY)
 					break;
 			}
 
 			/* Call keyctl. */
-			ret = syscall(__NR_keyctl, KEYCTL_REVOKE, ne_key);
+			ret = ltp_syscall(__NR_keyctl, KEYCTL_REVOKE, ne_key);
 			if (ret != -1) {
 				tst_resm(TFAIL | TERRNO,
 					 "KEYCTL_REVOKE succeeded unexpectedly");
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index a1f435f..15e584f 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -203,7 +203,7 @@ int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
 static int mylinkat(int olddirfd, const char *oldfilename, int newdirfd,
 		    const char *newfilename, int flags)
 {
-	return syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
+	return ltp_syscall(__NR_linkat, olddirfd, oldfilename, newdirfd,
 		       newfilename, flags);
 }
 
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 7668bdf..84937cb 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -243,17 +243,17 @@ static int do_test(struct test_case *tc)
 
 	errno = 0;
 	if (tc->from_node == NONE)
-		TEST(ret = syscall(__NR_mbind, p, len, tc->policy,
+		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
 				   NULL, 0, tc->flags));
 	else if (tc->ttype == INVALID_POINTER)
-		TEST(ret = syscall(__NR_mbind, p, len, tc->policy,
+		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
 				   invalid_nodemask, maxnode, tc->flags));
 	else
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-		TEST(ret = syscall(__NR_mbind, p, len, tc->policy,
+		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
 				   nodemask, maxnode, tc->flags));
 #else
-		TEST(ret = syscall(__NR_mbind, p, len, tc->policy,
+		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
 				   nodemask->maskp, nodemask->size, tc->flags));
 #endif
 
@@ -263,10 +263,10 @@ static int do_test(struct test_case *tc)
 
 	/* Check policy of the allocated memory */
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	TEST(syscall(__NR_get_mempolicy, &policy, getnodemask,
+	TEST(ltp_syscall(__NR_get_mempolicy, &policy, getnodemask,
 		     maxnode, p, MPOL_F_ADDR));
 #else
-	TEST(syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
+	TEST(ltp_syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
 		     getnodemask->size, p, MPOL_F_ADDR));
 #endif
 	if (TEST_RETURN < 0) {
@@ -300,7 +300,7 @@ TEST_END:
 static void setup(void)
 {
 	/* check syscall availability */
-	syscall(__NR_mbind, NULL, 0, 0, NULL, 0, 0);
+	ltp_syscall(__NR_mbind, NULL, 0, 0, NULL, 0, 0);
 
 	TEST_PAUSE;
 	tst_tmpdir();
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index fb68b38..3896001 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -68,7 +68,7 @@ static void cleanup(void);
 static void test_sane_nodes(void)
 {
 	tst_resm(TINFO, "test_empty_mask");
-	TEST(syscall(__NR_migrate_pages, 0, sane_max_node,
+	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(0);
 }
@@ -81,7 +81,7 @@ static void test_invalid_pid(void)
 	pid_t invalid_pid = -1;
 
 	tst_resm(TINFO, "test_invalid_pid -1");
-	TEST(syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
+	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(-1);
 	check_errno(ESRCH);
@@ -94,7 +94,7 @@ static void test_invalid_pid(void)
 		tst_brkm(TBROK, cleanup, "Could not read %s", pid_max);
 	fclose(fp);
 	invalid_pid = atol(buff) + 1;
-	TEST(syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
+	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(-1);
 	check_errno(ESRCH);
@@ -103,7 +103,7 @@ static void test_invalid_pid(void)
 static void test_invalid_masksize(void)
 {
 	tst_resm(TINFO, "test_invalid_masksize");
-	TEST(syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
+	TEST(ltp_syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
 		     sane_new_nodes));
 	check_ret(-1);
 	check_errno(EINVAL);
@@ -114,7 +114,7 @@ static void test_invalid_mem(void)
 	unsigned long *p;
 
 	tst_resm(TINFO, "test_invalid_mem -1");
-	TEST(syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
+	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
 	check_ret(-1);
 	check_errno(EFAULT);
 
@@ -123,14 +123,14 @@ static void test_invalid_mem(void)
 		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (p == MAP_FAILED)
 		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
-	TEST(syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
+	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
 	check_ret(-1);
 	check_errno(EFAULT);
 
 	if (munmap(p, getpagesize()) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
 	tst_resm(TINFO, "test_invalid_mem unmmaped");
-	TEST(syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
+	TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
 	check_ret(-1);
 	check_errno(EFAULT);
 }
@@ -159,7 +159,7 @@ static void test_invalid_nodes(void)
 		memset(new_nodes, 0, sane_nodemask_size);
 		set_bit(new_nodes, invalid_node, 1);
 
-		TEST(syscall(__NR_migrate_pages, 0, sane_max_node,
+		TEST(ltp_syscall(__NR_migrate_pages, 0, sane_max_node,
 			     old_nodes, new_nodes));
 		check_ret(-1);
 		check_errno(EINVAL);
@@ -196,7 +196,7 @@ static void test_invalid_perm(void)
 		if (setuid(ltpuser->pw_uid) == -1)
 			tst_brkm(TBROK | TERRNO, NULL,
 				 "setuid(%u) failed", ltpuser->pw_uid);
-		TEST(syscall(__NR_migrate_pages, parent_pid,
+		TEST(ltp_syscall(__NR_migrate_pages, parent_pid,
 			     sane_max_node, sane_old_nodes, sane_new_nodes));
 		ret |= check_ret(-1);
 		ret |= check_errno(EPERM);
@@ -237,7 +237,7 @@ static void setup(void)
 	int node, ret;
 
 	tst_require_root(NULL);
-	TEST(syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
+	TEST(ltp_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
 
 	if (numa_available() == -1)
 		tst_brkm(TCONF, NULL, "NUMA not available");
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 12affab..1eadc49 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -120,7 +120,8 @@ static int migrate_to_node(pid_t pid, int node)
 		set_bit(old_nodes, nodes[i], 1);
 	set_bit(new_nodes, node, 1);
 
-	TEST(syscall(__NR_migrate_pages, pid, max_node, old_nodes, new_nodes));
+	TEST(ltp_syscall(__NR_migrate_pages, pid, max_node, old_nodes,
+		new_nodes));
 	if (TEST_RETURN != 0) {
 		if (TEST_RETURN < 0)
 			tst_resm(TFAIL | TERRNO, "migrate_pages failed "
@@ -140,7 +141,7 @@ static int addr_on_node(void *addr)
 	int node;
 	int ret;
 
-	ret = syscall(__NR_get_mempolicy, &node, NULL, (unsigned long)0,
+	ret = ltp_syscall(__NR_get_mempolicy, &node, NULL, (unsigned long)0,
 		      (unsigned long)addr, MPOL_F_NODE | MPOL_F_ADDR);
 	if (ret == -1) {
 		tst_resm(TBROK | TERRNO, "error getting memory policy "
@@ -343,7 +344,7 @@ static void setup(void)
 	void *p;
 
 	tst_require_root(NULL);
-	TEST(syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
+	TEST(ltp_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
 
 	if (numa_available() == -1)
 		tst_brkm(TCONF, NULL, "NUMA not available");
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat01.c b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
index 2a11094..508c960 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat01.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
@@ -77,7 +77,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
 
 int mymkdirat(int dirfd, const char *dirname, int mode)
 {
-	return syscall(__NR_mkdirat, dirfd, dirname, mode);
+	return ltp_syscall(__NR_mkdirat, dirfd, dirname, mode);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index dca8913..6cce851 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -79,7 +79,7 @@ dev_t dev;
 
 int mymknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
 {
-	return syscall(__NR_mknodat, dirfd, filename, mode, dev);
+	return ltp_syscall(__NR_mknodat, dirfd, filename, mode, dev);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index 640c7bf..d7bd4ba 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -345,7 +345,7 @@ static int do_test(struct test_case *tc)
 	fd2 = sys_ret;
 
 	if (p_attr) {
-		TEST(rc = syscall(__NR_mq_getsetattr, fd2, NULL, &old));
+		TEST(rc = ltp_syscall(__NR_mq_getsetattr, fd2, NULL, &old));
 		if (TEST_RETURN < 0) {
 			tst_resm(TFAIL,
 				 "mq_getsetattr failed - errno = %d : %s",
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index db24f46..cc5c61a 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -125,7 +125,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(syscall(__NR_uname, &name));	//call newuname()
+			TEST(ltp_syscall(__NR_uname, &name));
 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL, "%s failed - errno = %d : %s",
 					 TCID, TEST_ERRNO,
diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index 9c909df..2280b96 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -77,7 +77,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
 
 int myopenat(int dirfd, const char *filename, int flags, int mode)
 {
-	return syscall(__NR_openat, dirfd, filename, flags, mode);
+	return ltp_syscall(__NR_openat, dirfd, filename, flags, mode);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
index 026ef3c..5601c73 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
@@ -157,7 +157,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if (syscall(__NR_pipe2, fd, 0) != 0) {
+			if (ltp_syscall(__NR_pipe2, fd, 0) != 0) {
 				tst_resm(TFAIL, "pipe2(0) failed");
 				cleanup();
 				tst_exit();
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 			close(fd[0]);
 			close(fd[1]);
 
-			if (syscall(__NR_pipe2, fd, O_CLOEXEC) != 0) {
+			if (ltp_syscall(__NR_pipe2, fd, O_CLOEXEC) != 0) {
 				tst_resm(TFAIL, "pipe2(O_CLOEXEC) failed");
 				cleanup();
 				tst_exit();
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
index 26f5d9c..f172480 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_02.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
@@ -148,7 +148,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if (syscall(__NR_pipe2, fds, 0) == -1) {
+			if (ltp_syscall(__NR_pipe2, fds, 0) == -1) {
 				tst_resm(TFAIL, "pipe2(0) failed");
 				cleanup();
 				tst_exit();
@@ -170,7 +170,7 @@ int main(int argc, char *argv[])
 				close(fds[i]);
 			}
 
-			if (syscall(__NR_pipe2, fds, O_NONBLOCK) == -1) {
+			if (ltp_syscall(__NR_pipe2, fds, O_NONBLOCK) == -1) {
 				tst_resm(TFAIL, "pipe2(O_NONBLOCK) failed");
 				cleanup();
 				tst_exit();
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 7642f0a..0bf50d7 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -312,7 +312,8 @@ static int do_test(struct test_case *tc)
 	 * Execute system call
 	 */
 	errno = 0;
-	sys_ret = syscall(__NR_ppoll, p_fds, nfds, p_ts, p_sigmask, SIGSETSIZE);
+	sys_ret = ltp_syscall(__NR_ppoll, p_fds, nfds, p_ts, p_sigmask,
+		SIGSETSIZE);
 	sys_errno = errno;
 	if (sys_ret <= 0 || tc->ret < 0)
 		goto TEST_END;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 78260b7..f90ec9b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -73,7 +73,7 @@ int testno;
 int TST_TOTAL = 1;		/* total number of tests in this file.  */
 
 #define QUOTACTL(cmd, addr) \
-	syscall(__NR_quotactl, QCMD(cmd, USRQUOTA), block_dev, id, \
+	ltp_syscall(__NR_quotactl, QCMD(cmd, USRQUOTA), block_dev, id, \
 					(caddr_t) addr)
 #ifndef BROKEN_QUOTACTL
 
@@ -221,7 +221,6 @@ int main(int ac, char **av)
 	};
 
 	int newtid = -1;
-	int result;
 	int ret;
 	int i;
 	int lc;
@@ -252,7 +251,7 @@ int main(int ac, char **av)
 
 			}
 
-			TEST(result = syscall(__NR_set_tid_address, &newtid));
+			TEST(ltp_syscall(__NR_set_tid_address, &newtid));
 
 			if (TEST_RETURN == getpid()) {
 				cleanup();
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index 84ea9cb..71ecdb2 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -85,7 +85,7 @@ static void test_bad_fd(void)
 	int fd;
 
 	tst_resm(TINFO, "test_bad_fd -1");
-	TEST(syscall(__NR_readahead, -1, 0, getpagesize()));
+	TEST(ltp_syscall(__NR_readahead, -1, 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EBADF);
 
@@ -97,7 +97,7 @@ static void test_bad_fd(void)
 	fd = open(tempname, O_WRONLY);
 	if (fd == -1)
 		tst_resm(TBROK | TERRNO, "Failed to open testfile");
-	TEST(syscall(__NR_readahead, fd, 0, getpagesize()));
+	TEST(ltp_syscall(__NR_readahead, fd, 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EBADF);
 	close(fd);
@@ -111,7 +111,7 @@ static void test_invalid_fd(void)
 	tst_resm(TINFO, "test_invalid_fd pipe");
 	if (pipe(fd) < 0)
 		tst_resm(TBROK | TERRNO, "Failed to create pipe");
-	TEST(syscall(__NR_readahead, fd[0], 0, getpagesize()));
+	TEST(ltp_syscall(__NR_readahead, fd[0], 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EINVAL);
 	close(fd[0]);
@@ -121,7 +121,7 @@ static void test_invalid_fd(void)
 	fd[0] = socket(AF_INET, SOCK_STREAM, 0);
 	if (fd[0] < 0)
 		tst_resm(TBROK | TERRNO, "Failed to create socket");
-	TEST(syscall(__NR_readahead, fd[0], 0, getpagesize()));
+	TEST(ltp_syscall(__NR_readahead, fd[0], 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EINVAL);
 	close(fd[0]);
@@ -152,7 +152,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* check if readahead syscall is supported */
-	syscall(__NR_readahead, 0, 0, 0);
+	ltp_syscall(__NR_readahead, 0, 0, 0);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index d05bffd..5ce2a33 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -211,7 +211,8 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
 
 	if (do_readahead) {
-		TEST(syscall(__NR_readahead, fd, (off64_t) 0, (size_t) fsize));
+		TEST(ltp_syscall(__NR_readahead, fd, (off64_t) 0,
+			(size_t) fsize));
 		check_ret(0);
 		*cached = get_cached_size();
 
@@ -352,7 +353,7 @@ static void setup(void)
 	has_file(meminfo_fname, 1);
 
 	/* check if readahead is supported */
-	syscall(__NR_readahead, 0, 0, 0);
+	ltp_syscall(__NR_readahead, 0, 0, 0);
 
 	pagesize = getpagesize();
 	create_testfile();
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index 517e074..e1aeca5 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -91,7 +91,7 @@ char buffer[BUFF_SIZE];
 
 int myreadlinkat(int dirfd, const char *filename, char *buffer, size_t bufsize)
 {
-	return syscall(__NR_readlinkat, dirfd, filename, buffer, bufsize);
+	return ltp_syscall(__NR_readlinkat, dirfd, filename, buffer, bufsize);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index 9468adf..fc89b0a 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -87,7 +87,7 @@ int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
 int myrenameat(int olddirfd, const char *oldfilename, int newdirfd,
 	       const char *newfilename)
 {
-	return syscall(__NR_renameat, olddirfd, oldfilename, newdirfd,
+	return ltp_syscall(__NR_renameat, olddirfd, oldfilename, newdirfd,
 		       newfilename);
 }
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index ce498af..b0830cd 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -144,7 +144,7 @@ int set_handler(int sig, int sig_to_mask, int mask_flags)
 	sigemptyset(&sa.sa_mask);
 	sigaddset(&sa.sa_mask, sig);
 
-	return syscall(__NR_rt_sigaction, sig, &sa, &oldaction, SIGSETSIZE);
+	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction, SIGSETSIZE);
 
 }
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index f22d86b..75b490d 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -174,7 +174,7 @@ int main(int ac, char **av)
 					 * An invalid act or oact value was specified                   *
 					 */
 
-					TEST(syscall
+					TEST(ltp_syscall
 					     (__NR_rt_sigaction, signal,
 					      INVAL_STRUCT, NULL, SIGSETSIZE));
 					if ((TEST_RETURN == -1)
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 456bd29..345c389 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -150,7 +150,7 @@ int set_handler(int sig, int sig_to_mask, int mask_flags)
 	 * sigsetsize was not equivalent to the size of a sigset_t type *
 	 */
 
-	TEST(syscall
+	TEST(ltp_syscall
 	     (__NR_rt_sigaction, sig, &sa, &oldaction, INVAL_SIGSETSIZE));
 	if (TEST_RETURN == 0) {
 		return 0;
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index d9e432d..3b2dfbb 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -170,14 +170,14 @@ int main(int ac, char **av)
 			}
 
 			/* call rt_sigaction() */
-			TEST(syscall(__NR_rt_sigaction, TEST_SIG, &act, &oact,
-				     SIGSETSIZE));
+			TEST(ltp_syscall(__NR_rt_sigaction, TEST_SIG, &act,
+				&oact, SIGSETSIZE));
 			if (TEST_RETURN < 0) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigaction call failed");
 			}
 			/* call rt_sigprocmask() to block signal#TEST_SIG */
-			TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set,
+			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set,
 				     &oset, SIGSETSIZE));
 			if (TEST_RETURN == -1) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
@@ -195,7 +195,7 @@ int main(int ac, char **av)
 					 "the process's signal mask");
 			} else {
 				/* call rt_sigpending() */
-				TEST(syscall(__NR_rt_sigpending, &oset,
+				TEST(ltp_syscall(__NR_rt_sigpending, &oset,
 					     SIGSETSIZE));
 				if (TEST_RETURN == -1) {
 					tst_brkm(TFAIL | TTERRNO, cleanup,
@@ -209,7 +209,7 @@ int main(int ac, char **av)
 				}
 				/* call rt_sigprocmask() to unblock
 				 * signal#TEST_SIG */
-				TEST(syscall(__NR_rt_sigprocmask,
+				TEST(ltp_syscall(__NR_rt_sigprocmask,
 					     SIG_UNBLOCK, &set, &oset,
 					     SIGSETSIZE));
 				if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index 625b314..ec350b1 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 	}
 
 	for (i = 0; i < test_count; i++) {
-		TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK,
+		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_BLOCK,
 			     &s, test_cases[i].ss, test_cases[i].sssize));
 		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL | TTERRNO,
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
index bce45b6..f063077 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -88,8 +88,8 @@ int main(int ac, char **av)
 		else if (TEST_RETURN == 0) {
 			uinfo.si_errno = 0;
 			uinfo.si_code = SI_QUEUE;
-			TEST(syscall(__NR_rt_sigqueueinfo, getpid(), SIGCHLD,
-				     &uinfo));
+			TEST(ltp_syscall(__NR_rt_sigqueueinfo, getpid(),
+				SIGCHLD, &uinfo));
 			if (TEST_RETURN != 0)
 				err(1, "rt_sigqueueinfo");
 			exit(0);
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 7cd9453..5436b34 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -147,13 +147,13 @@ int main(int ac, char **av)
 		act.sa_handler = sig_handler;
 #endif
 
-		TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
+		TEST(ltp_syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
 			     SIGSETSIZE));
 		if (TEST_RETURN == -1) {
 			tst_brkm(TFAIL | TTERRNO, cleanup,
 				 "rt_sigaction failed");
 		}
-		TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
+		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
 			     &set1, SIGSETSIZE));
 		if (TEST_RETURN == -1) {
 			tst_brkm(TFAIL | TTERRNO, cleanup,
@@ -162,11 +162,12 @@ int main(int ac, char **av)
 
 		TEST(alarm(5));
 		int result;
-		TEST(result = syscall(__NR_rt_sigsuspend, &set, SIGSETSIZE));
+		TEST(result = ltp_syscall(__NR_rt_sigsuspend, &set,
+			SIGSETSIZE));
 		TEST(alarm(0));
 		if (result == -1 && TEST_ERRNO != EINTR) {
-			TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set2,
-				     SIGSETSIZE));
+			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
+				&set2, SIGSETSIZE));
 			if (TEST_RETURN == -1) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigprocmask failed");
diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
index 3410f39..8f5fb4c 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
@@ -87,7 +87,7 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		for (i = 0; i < sizeof(tests) / sizeof(struct test); i++) {
-			TEST(syscall(tests[i].syscall, tests[i].u_info));
+			TEST(ltp_syscall(tests[i].syscall, tests[i].u_info));
 
 			if (TEST_RETURN != tests[i].exp_ret) {
 				tst_resm(TFAIL, "%s returned %li expected %i",
diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index 6303a56..f37f9f2 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(syscall(__NR_set_tid_address, &newtid));	//call set_tid_address()
+			TEST(ltp_syscall(__NR_set_tid_address, &newtid));
 			if (TEST_RETURN == getpid()) {
 				tst_resm(TPASS,
 					 "set_tid_address call succeeded:  as expected %ld",
diff --git a/testcases/kernel/syscalls/setgid/compat_16.h b/testcases/kernel/syscalls/setgid/compat_16.h
index 3d237de..9d1d15c 100644
--- a/testcases/kernel/syscalls/setgid/compat_16.h
+++ b/testcases/kernel/syscalls/setgid/compat_16.h
@@ -32,7 +32,7 @@
 int
 SETGID(GID_T gid)
 {
-	return syscall(__NR_setgid, gid);
+	return ltp_syscall(__NR_setgid, gid);
 }
 
 GID_T
diff --git a/testcases/kernel/syscalls/setgroups/compat_16.h b/testcases/kernel/syscalls/setgroups/compat_16.h
index 1b2a1a5..0de4e78 100644
--- a/testcases/kernel/syscalls/setgroups/compat_16.h
+++ b/testcases/kernel/syscalls/setgroups/compat_16.h
@@ -34,7 +34,7 @@ extern void cleanup(void);
 long
 SETGROUPS(size_t gidsetsize, GID_T *list)
 {
-	return syscall(__NR_setgroups, gidsetsize, list);
+	return ltp_syscall(__NR_setgroups, gidsetsize, list);
 }
 
 int
diff --git a/testcases/kernel/syscalls/sgetmask/sgetmask01.c b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
index af9e42a..5653844 100644
--- a/testcases/kernel/syscalls/sgetmask/sgetmask01.c
+++ b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
@@ -135,9 +135,11 @@ int main(int ac, char **av)
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (sig = -3; sig <= SIGRTMAX + 1; sig++) {
-				TEST(syscall(__NR_ssetmask, sig));
-				tst_resm(TINFO, "Setting signal : %d -- return of setmask : %ld", sig, TEST_RETURN);	//call sgetmask()
-				TEST(syscall(__NR_sgetmask));	//call sgetmask()
+				TEST(ltp_syscall(__NR_ssetmask, sig));
+				tst_resm(TINFO, "Setting signal : %d -- "
+					"return of setmask : %ld",
+					sig, TEST_RETURN);
+				TEST(ltp_syscall(__NR_sgetmask));
 				if (TEST_RETURN != sig) {
 					tst_resm(TINFO,
 						 "Oops,setting sig %d, got %ld",
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index c3ac390..f8a8d9a 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -89,7 +89,7 @@ int main(int argc, char **argv)
 int signalfd(int fd, const sigset_t * mask, int flags)
 {
 	/* Taken from GLIBC. */
-	return (syscall(__NR_signalfd, fd, mask, SIGSETSIZE));
+	return ltp_syscall(__NR_signalfd, fd, mask, SIGSETSIZE);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index 1f13b76..b198310 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -157,7 +157,8 @@ int main(int argc, char *argv[])
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			sigemptyset(&ss);
 			sigaddset(&ss, SIGUSR1);
-			fd = syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE, 0);
+			fd = ltp_syscall(__NR_signalfd4, -1, &ss,
+				SIGSETSIZE, 0);
 			if (fd == -1) {
 				tst_resm(TFAIL, "signalfd4(0) failed");
 				cleanup();
@@ -176,7 +177,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
+			fd = ltp_syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
 				     SFD_CLOEXEC);
 			if (fd == -1) {
 				tst_resm(TFAIL,
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
index 6d0fdfa..89c9a09 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
@@ -149,7 +149,8 @@ int main(int argc, char *argv[])
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			sigemptyset(&ss);
 			sigaddset(&ss, SIGUSR1);
-			fd = syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE, 0);
+			fd = ltp_syscall(__NR_signalfd4, -1, &ss,
+				SIGSETSIZE, 0);
 			if (fd == -1) {
 				tst_resm(TFAIL, "signalfd4(0) failed");
 				cleanup();
@@ -168,7 +169,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
+			fd = ltp_syscall(__NR_signalfd4, -1, &ss, SIGSETSIZE,
 				     SFD_NONBLOCK);
 			if (fd == -1) {
 				tst_resm(TFAIL,
diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 16ed4c5..d592289 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -133,7 +133,7 @@ static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
 {
 
 	/* The last argument is (number_of_signals)/(bits_per_byte), which are 64 and 8, resp. */
-	return syscall(__NR_rt_sigtimedwait, set, info, timeout, 8);
+	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout, 8);
 }
 #endif
 
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index bae9ef5..586e08b 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -67,7 +67,8 @@ static inline long splice(int fd_in, loff_t * off_in,
 			  int fd_out, loff_t * off_out,
 			  size_t len, unsigned int flags)
 {
-	return syscall(__NR_splice, fd_in, off_in, fd_out, off_out, len, flags);
+	return ltp_syscall(__NR_splice, fd_in, off_in, fd_out, off_out,
+		len, flags);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index f9158b5..d240ed7 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -53,7 +53,8 @@ static inline long ltp_splice(int fd_in, loff_t * off_in,
 			      int fd_out, loff_t * off_out,
 			      size_t len, unsigned int flags)
 {
-	return syscall(__NR_splice, fd_in, off_in, fd_out, off_out, len, flags);
+	return ltp_syscall(__NR_splice, fd_in, off_in, fd_out, off_out,
+		len, flags);
 }
 
 /* Extern Global Functions */
diff --git a/testcases/kernel/syscalls/ssetmask/ssetmask01.c b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
index d2e5894..f3818c8 100644
--- a/testcases/kernel/syscalls/ssetmask/ssetmask01.c
+++ b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
@@ -122,14 +122,14 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			syscall(__NR_ssetmask, SIGALRM);
-			TEST(syscall(__NR_sgetmask));	//call ssetmask()
+			ltp_syscall(__NR_ssetmask, SIGALRM);
+			TEST(ltp_syscall(__NR_sgetmask));
 			if (TEST_RETURN != SIGALRM) {
 				tst_resm(TFAIL | TTERRNO, "sgetmask() failed");
 				cleanup();
 				tst_exit();
 			}
-			TEST(syscall(__NR_ssetmask, SIGUSR1));	//call ssetmask()
+			TEST(ltp_syscall(__NR_ssetmask, SIGUSR1));
 			if (TEST_RETURN != SIGALRM) {
 				tst_resm(TFAIL | TTERRNO, "ssetmask() failed");
 				cleanup();
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 6c955f4..d178d8d 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -104,13 +104,13 @@ int main(int ac, char **av)
 
 		Tst_count = 0;
 
-		if (syscall(__NR_swapon, "./swapfile01", 0) != 0) {
+		if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
 			tst_resm(TWARN, "Failed to turn on the swap file"
 				 ", skipping test iteration");
 			continue;
 		}
 
-		TEST(syscall(__NR_swapoff, "./swapfile01"));
+		TEST(ltp_syscall(__NR_swapoff, "./swapfile01"));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 5b98b63..6d993d2 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -141,7 +141,8 @@ int main(int ac, char **av)
 					 " Skipping test", i);
 				continue;
 			} else {
-				TEST(syscall(__NR_swapoff, testcase[i].path));
+				TEST(ltp_syscall(__NR_swapoff,
+					testcase[i].path));
 			}
 
 			if (testcase[i].cleanfunc &&
@@ -167,7 +168,7 @@ int main(int ac, char **av)
 					 testcase[i].exp_errval, TEST_ERRNO);
 
 				if ((TEST_RETURN == 0) && (i == 2)) {
-					if (syscall
+					if (ltp_syscall
 					    (__NR_swapon, "./swapfile01",
 					     0) != 0) {
 						tst_brkm(TBROK, cleanup,
@@ -275,7 +276,7 @@ void setup()
 		tst_brkm(TBROK, cleanup, "Failed to make swapfile");
 	}
 
-	if (syscall(__NR_swapon, "./swapfile01", 0) != 0) {
+	if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
 		tst_brkm(TBROK, cleanup, "Failed to turn on the swap file."
 			 " skipping  the test iteration");
 	}
@@ -297,7 +298,7 @@ void cleanup()
 	TEST_CLEANUP;
 
 	if (need_swapfile_cleanup
-	    && (syscall(__NR_swapoff, "./swapfile01") != 0)) {
+	    && (ltp_syscall(__NR_swapoff, "./swapfile01") != 0)) {
 		tst_resm(TWARN,
 			 " Failed to turn off swap file. System reboot"
 			 " after execution of LTP test suite is"
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index ae5a863..8270bb7 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -103,7 +103,7 @@ int main(int ac, char **av)
 
 		Tst_count = 0;
 
-		TEST(syscall(__NR_swapon, "./swapfile01", 0));
+		TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "swapon(2) passed and turned on"
 				 " swapfile");
 			/*we need to turn this swap file off for -i option */
-			if (syscall(__NR_swapoff, "./swapfile01") != 0) {
+			if (ltp_syscall(__NR_swapoff, "./swapfile01") != 0) {
 				tst_brkm(TBROK, cleanup, "Failed to turn off"
 					 " swapfile. system"
 					 " reboot after"
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index e4db80f..5d1e85d 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -161,7 +161,8 @@ int main(int ac, char **av)
 				continue;
 			} else {
 				/* run the test */
-				TEST(syscall(__NR_swapon, testcase[i].path, 0));
+				TEST(ltp_syscall(__NR_swapon,
+					testcase[i].path, 0));
 			}
 			/* do the clean if the test have one */
 			if (testcase[i].cleanfunc
@@ -189,7 +190,7 @@ int main(int ac, char **av)
 					 testcase[i].exp_errval, TEST_ERRNO);
 				/*If swapfile is turned on, turn it off */
 				if (TEST_RETURN == 0) {
-					if (syscall
+					if (ltp_syscall
 					    (__NR_swapoff,
 					     testcase[i].path) != 0) {
 						tst_resm(TWARN,
@@ -325,7 +326,8 @@ int setup03()
 	}
 
 	/* turn on the swap file */
-	if ((res = syscall(__NR_swapon, "alreadyused", 0)) != 0) {
+	res = ltp_syscall(__NR_swapon, "alreadyused", 0);
+	if (res != 0) {
 		tst_resm(TWARN, "Failed swapon for file alreadyused"
 			 " returned %d", res);
 		return -1;
@@ -340,7 +342,7 @@ int setup03()
 int cleanup03()
 {
 	/* give swapoff to the test swap file */
-	if (syscall(__NR_swapoff, "alreadyused") != 0) {
+	if (ltp_syscall(__NR_swapoff, "alreadyused") != 0) {
 		tst_resm(TWARN, "Failed to turn off swap files. system"
 			 " reboot after execution of LTP test"
 			 " suite is recommended");
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 9264468..1fd9631 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -134,7 +134,7 @@ int main(int ac, char **av)
 		}
 
 		/* Call swapon sys call for the first time */
-		TEST(syscall(__NR_swapon, swap_testfiles[0].filename, 0));
+		TEST(ltp_syscall(__NR_swapon, swap_testfiles[0].filename, 0));
 
 		/* Check return code */
 		if ((TEST_RETURN == -1) && (TEST_ERRNO == expected_errno)) {
@@ -151,7 +151,7 @@ int main(int ac, char **av)
 
 			/* Call swapon sys call once again for 32
 			 * now we can't receive an error */
-			TEST(syscall
+			TEST(ltp_syscall
 			     (__NR_swapon, swap_testfiles[1].filename, 0));
 
 			/* Check return code (now we're expecting success) */
@@ -161,7 +161,7 @@ int main(int ac, char **av)
 			} else {
 				/* Call swapon sys call once again for 33
 				 * now we have to receive an error */
-				TEST(syscall
+				TEST(ltp_syscall
 				     (__NR_swapon, swap_testfiles[2].filename,
 				      0));
 
@@ -285,7 +285,8 @@ int setup_swap()
 			}
 
 			/* turn on the swap file */
-			if ((res = syscall(__NR_swapon, filename, 0)) != 0) {
+			res = ltp_syscall(__NR_swapon, filename, 0);
+			if (res != 0) {
 				if (errno == EPERM) {
 					printf("Successfully created %d "
 					       "swapfiles\n", j);
@@ -413,7 +414,7 @@ int check_and_swapoff(char *filename)
 		if (system(cmd_buffer) == 0) {
 
 			/* now we need to swapoff the file */
-			if (syscall(__NR_swapoff, filename) != 0) {
+			if (ltp_syscall(__NR_swapoff, filename) != 0) {
 
 				tst_resm(TWARN, "Failed to turn off swap "
 					 "file. system reboot after "
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 226f322..c052fb9 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -146,7 +146,7 @@ int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);	/* Total number of test
 static int mysymlinkat(const char *oldfilename,
 		       int newdirfd, const char *newfilename)
 {
-	return syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
+	return ltp_syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index de2ea3e..e317442 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -211,17 +211,18 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
 #if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
 #if (__WORDSIZE == 32)
 #if __BYTE_ORDER == __BIG_ENDIAN
-	return syscall(__NR_sync_file_range2, fd, flags, (int)(offset >> 32),
-		       (int)offset, (int)(nbytes >> 32), (int)nbytes);
+	return ltp_syscall(__NR_sync_file_range2, fd, flags,
+		(int)(offset >> 32), (int)offset, (int)(nbytes >> 32),
+		(int)nbytes);
 #elif __BYTE_ORDER == __LITTLE_ENDIAN
-	return syscall(__NR_sync_file_range2, fd, flags, (int)offset,
+	return ltp_syscall(__NR_sync_file_range2, fd, flags, (int)offset,
 		       (int)(offset >> 32), nbytes, (int)(nbytes >> 32));
 #endif
 #else
-	return syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
+	return ltp_syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
 #endif
 #else
-	return syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
+	return ltp_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
 #endif
 
 }
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 858f177..0e8f399 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -68,12 +68,13 @@ static inline long splice(int fd_in, loff_t * off_in,
 			  int fd_out, loff_t * off_out,
 			  size_t len, unsigned int flags)
 {
-	return syscall(__NR_splice, fd_in, off_in, fd_out, off_out, len, flags);
+	return ltp_syscall(__NR_splice, fd_in, off_in, fd_out, off_out,
+		len, flags);
 }
 
 static inline int tee(int fdin, int fdout, size_t len, unsigned int flags)
 {
-	return syscall(__NR_tee, fdin, fdout, len, flags);
+	return ltp_syscall(__NR_tee, fdin, fdout, len, flags);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index 5bfa31e..76ec56d 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -143,12 +143,13 @@ int main(int ac, char **av)
 			ev.sigev_signo = SIGALRM;
 			ev.sigev_notify = SIGEV_SIGNAL;
 
-			TEST(syscall
+			TEST(ltp_syscall
 			     (__NR_timer_create, CLOCK_REALTIME, &ev,
 			      &created_timer_id));
 
 			ENTER(1);
-			TEST(syscall(__NR_timer_getoverrun, created_timer_id));
+			TEST(ltp_syscall(__NR_timer_getoverrun,
+				created_timer_id));
 			if (TEST_RETURN == 0) {
 				tst_resm(TPASS, "Block %d: test %d PASSED",
 					 block, Tst_count);
@@ -162,7 +163,7 @@ int main(int ac, char **av)
 			}
 
 			ENTER(0);
-			TEST(syscall(__NR_timer_getoverrun, -1));
+			TEST(ltp_syscall(__NR_timer_getoverrun, -1));
 			if (TEST_RETURN < 0 && TEST_ERRNO == EINVAL) {
 				tst_resm(TPASS, "Block %d: test %d PASSED",
 					 block, Tst_count);
diff --git a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
index bbabc57..ab2249d 100644
--- a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
+++ b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
@@ -141,9 +141,9 @@ int main(int ac, char **av)
 			ev.sigev_value = (sigval_t) 0;
 			ev.sigev_signo = SIGALRM;
 			ev.sigev_notify = SIGEV_SIGNAL;
-			TEST(syscall(__NR_timer_create, CLOCK_REALTIME, &ev,
+			TEST(ltp_syscall(__NR_timer_create, CLOCK_REALTIME, &ev,
 				     &created_timer_id));
-			TEST(syscall(__NR_timer_gettime, created_timer_id,
+			TEST(ltp_syscall(__NR_timer_gettime, created_timer_id,
 				     &spec));
 			if (TEST_RETURN == 0) {
 				tst_resm(TPASS, "Block %d: test %d PASSED",
@@ -161,7 +161,7 @@ ERRORS
 	      An invalid timer_id value was specified.
 */
 			ENTER(0);
-			TEST(syscall(__NR_timer_gettime, -1, &spec));
+			TEST(ltp_syscall(__NR_timer_gettime, -1, &spec));
 			if (TEST_RETURN < 0 && TEST_ERRNO == EINVAL) {
 				tst_resm(TPASS,
 					 "Block %d: test %d PASSED",
@@ -179,7 +179,7 @@ ERRORS
 */
 
 			ENTER(0);
-			TEST(syscall(__NR_timer_gettime, created_timer_id,
+			TEST(ltp_syscall(__NR_timer_gettime, created_timer_id,
 				     NULL));
 			if (TEST_RETURN < 0 && TEST_ERRNO == EFAULT) {
 				tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 3eea98f..db3b80c 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -89,20 +89,20 @@ void set_timespec(struct timespec *tmr, unsigned long long ustime)
 int timerfd_create(int clockid, int flags)
 {
 
-	return syscall(__NR_timerfd_create, clockid, flags);
+	return ltp_syscall(__NR_timerfd_create, clockid, flags);
 }
 
 int timerfd_settime(int ufc, int flags, const struct itimerspec *utmr,
 		    struct itimerspec *otmr)
 {
 
-	return syscall(__NR_timerfd_settime, ufc, flags, utmr, otmr);
+	return ltp_syscall(__NR_timerfd_settime, ufc, flags, utmr, otmr);
 }
 
 int timerfd_gettime(int ufc, struct itimerspec *otmr)
 {
 
-	return syscall(__NR_timerfd_gettime, ufc, otmr);
+	return ltp_syscall(__NR_timerfd_gettime, ufc, otmr);
 }
 
 long waittmr(int tfd, int timeo)
diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index 7ee1c6c..40bd4a9 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -153,7 +153,8 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			fd = syscall(__NR_timerfd_create, CLOCK_REALTIME, 0);
+			fd = ltp_syscall(__NR_timerfd_create,
+				CLOCK_REALTIME, 0);
 			if (fd == -1) {
 				tst_resm(TFAIL, "timerfd_create(0) failed");
 				cleanup();
@@ -172,7 +173,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = syscall(__NR_timerfd_create, CLOCK_REALTIME,
+			fd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME,
 				     TFD_CLOEXEC);
 			if (fd == -1) {
 				tst_resm(TFAIL,
diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
index f24da66..89686d1 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd03.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
@@ -149,7 +149,8 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		Tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			fd = syscall(__NR_timerfd_create, CLOCK_REALTIME, 0);
+			fd = ltp_syscall(__NR_timerfd_create,
+				CLOCK_REALTIME, 0);
 			if (fd == -1) {
 				tst_resm(TFAIL, "timerfd_create(0) failed");
 				cleanup();
@@ -168,7 +169,7 @@ int main(int argc, char *argv[])
 			}
 			close(fd);
 
-			fd = syscall(__NR_timerfd_create, CLOCK_REALTIME,
+			fd = ltp_syscall(__NR_timerfd_create, CLOCK_REALTIME,
 				     TFD_NONBLOCK);
 			if (fd == -1) {
 				tst_resm(TFAIL,
diff --git a/testcases/kernel/syscalls/tkill/tkill01.c b/testcases/kernel/syscalls/tkill/tkill01.c
index a3d8e3d..438d3c3 100644
--- a/testcases/kernel/syscalls/tkill/tkill01.c
+++ b/testcases/kernel/syscalls/tkill/tkill01.c
@@ -97,11 +97,11 @@ int main(int ac, char **av)
 			if (signal(SIGUSR1, &sig_action) == SIG_ERR)
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "signal(SIGUSR1, ..) failed");
-			TEST(tid = syscall(__NR_gettid));
+			TEST(tid = ltp_syscall(__NR_gettid));
 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL | TTERRNO, "tkill failed");
 			}
-			TEST(syscall(__NR_tkill, tid, SIGUSR1));
+			TEST(ltp_syscall(__NR_tkill, tid, SIGUSR1));
 			if (TEST_RETURN == 0) {
 				tst_resm(TPASS, "tkill call succeeded");
 			} else {
diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index 7d04a44..8f4bd5b 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 
 	for (i = 0; i < TST_TOTAL; i++) {
 
-		TEST(syscall(__NR_tkill, test_cases[i].tid, SIGUSR1));
+		TEST(ltp_syscall(__NR_tkill, test_cases[i].tid, SIGUSR1));
 
 		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO == test_cases[i].exp_errno) {
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index ffa3ec4..3bbc14f 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -84,7 +84,7 @@ int flags[TEST_CASES] = { 0, 0, 0, 0, 9999, 0, AT_REMOVEDIR };
 
 int myunlinkat(int dirfd, const char *filename, int flags)
 {
-	return syscall(__NR_unlinkat, dirfd, filename, flags);
+	return ltp_syscall(__NR_unlinkat, dirfd, filename, flags);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index a0c94a8..f7b38eb 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -72,7 +72,7 @@ static inline int
 utimensat_sc(int dirfd, const char *pathname,
 	     const struct timespec times[2], int flags)
 {
-	return syscall(__NR_utimensat, dirfd, pathname, times, flags);
+	return ltp_syscall(__NR_utimensat, dirfd, pathname, times, flags);
 }
 
 static void usageError(char *progName)
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 3ac12cf..1154492 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -69,13 +69,14 @@ static long mysplice(int fd_in, loff_t * off_in,
 		     int fd_out, loff_t * off_out,
 		     size_t len, unsigned int flags)
 {
-	return syscall(__NR_splice, fd_in, off_in, fd_out, off_out, len, flags);
+	return ltp_syscall(__NR_splice, fd_in, off_in, fd_out, off_out,
+		len, flags);
 }
 
 static long myvmsplice(int fd, struct iovec *v, unsigned long nregs,
 		       unsigned int flags)
 {
-	return syscall(__NR_vmsplice, fd, v, nregs, flags);
+	return ltp_syscall(__NR_vmsplice, fd, v, nregs, flags);
 }
 
 static void setup_every_copy()
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime02.c b/testcases/kernel/timers/clock_gettime/clock_gettime02.c
index 685ce25..94baef3 100644
--- a/testcases/kernel/timers/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/timers/clock_gettime/clock_gettime02.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 		Tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(syscall(__NR_clock_gettime, clocks[i], &spec));
+			TEST(ltp_syscall(__NR_clock_gettime, clocks[i], &spec));
 			tst_resm((TEST_RETURN < 0 ? TFAIL | TTERRNO : TPASS),
 				 "%s",
 				 (TEST_RETURN == 0 ? "passed" : "failed"));
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime03.c b/testcases/kernel/timers/clock_gettime/clock_gettime03.c
index 6c0134f..a976702 100644
--- a/testcases/kernel/timers/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/timers/clock_gettime/clock_gettime03.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
 				temp = (struct timespec *)NULL;
 			}
 
-			TEST(syscall(__NR_clock_gettime, clocks[i], temp));
+			TEST(ltp_syscall(__NR_clock_gettime, clocks[i], temp));
 
 			/* check return code */
 			if (TEST_RETURN == -1 && TEST_ERRNO == testcase[i]) {
diff --git a/testcases/kernel/timers/clock_settime/clock_settime02.c b/testcases/kernel/timers/clock_settime/clock_settime02.c
index 6c2e07c..ade05d1 100644
--- a/testcases/kernel/timers/clock_settime/clock_settime02.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime02.c
@@ -97,7 +97,7 @@ int main(int ac, char **av)
 		spec.tv_sec = 1;
 		spec.tv_nsec = 0;
 
-		TEST(syscall(__NR_clock_settime, CLOCK_REALTIME, &spec));
+		TEST(ltp_syscall(__NR_clock_settime, CLOCK_REALTIME, &spec));
 		tst_resm((TEST_RETURN < 0 ? TFAIL | TTERRNO : TPASS),
 			 "clock_settime %s",
 			 (TEST_RETURN == 0 ? "passed" : "failed"));
@@ -118,7 +118,7 @@ void setup(void)
 		tst_brkm(TBROK, NULL, "Test must be run as root");
 	}
 	/* Save the current time specifications */
-	if (syscall(__NR_clock_gettime, CLOCK_REALTIME, &saved) < 0)
+	if (ltp_syscall(__NR_clock_gettime, CLOCK_REALTIME, &saved) < 0)
 		tst_brkm(TBROK, NULL, "Could not save the current time");
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
index b48e2d4..6ae0389 100644
--- a/testcases/kernel/timers/clock_settime/clock_settime03.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 			if (setup_test(i) < 0)
 				continue;
 
-			TEST(syscall(__NR_clock_settime, clocks[i], temp));
+			TEST(ltp_syscall(__NR_clock_settime, clocks[i], temp));
 
 			/* Change the UID back to root */
 			if (i == TST_TOTAL - 1) {
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 					 TEST_RETURN);
 				/* Restore the clock to its previous state. */
 				if (TEST_RETURN == 0) {
-					if (syscall(__NR_clock_settime,
+					if (ltp_syscall(__NR_clock_settime,
 						    CLOCK_REALTIME,
 						    &saved) < 0) {
 						tst_resm(TWARN | TERRNO,
@@ -183,7 +183,7 @@ static void setup(void)
 
 	tst_require_root(NULL);
 
-	if (syscall(__NR_clock_gettime, CLOCK_REALTIME, &saved) < 0)
+	if (ltp_syscall(__NR_clock_gettime, CLOCK_REALTIME, &saved) < 0)
 		tst_brkm(TBROK, NULL, "Clock gettime failed");
 
 	TEST_EXP_ENOS(exp_enos);
diff --git a/testcases/kernel/timers/timer_create/timer_create02.c b/testcases/kernel/timers/timer_create/timer_create02.c
index c576c3a..57424fe 100644
--- a/testcases/kernel/timers/timer_create/timer_create02.c
+++ b/testcases/kernel/timers/timer_create/timer_create02.c
@@ -121,8 +121,9 @@ int main(int ac, char **av)
 				if (strstr(get_clock_str(clock_list[j]), mrstr))
 					continue;
 
-				TEST(syscall(__NR_timer_create, clock_list[j],
-					     evp_ptr, &created_timer_id));
+				TEST(ltp_syscall(__NR_timer_create,
+					clock_list[j], evp_ptr,
+					&created_timer_id));
 
 				tst_resm((TEST_RETURN == 0 ?
 					  TPASS :
diff --git a/testcases/kernel/timers/timer_create/timer_create03.c b/testcases/kernel/timers/timer_create/timer_create03.c
index fa53cff..b4de179 100644
--- a/testcases/kernel/timers/timer_create/timer_create03.c
+++ b/testcases/kernel/timers/timer_create/timer_create03.c
@@ -117,7 +117,7 @@ int main(int ac, char **av)
 		for (i = 0; i < TST_TOTAL; i++) {
 
 			setup_test(i);
-			TEST(syscall(__NR_timer_create, CLOCK_MONOTONIC,
+			TEST(ltp_syscall(__NR_timer_create, CLOCK_MONOTONIC,
 				     evp_ptr, &created_timer_id));
 
 			tst_resm((TEST_RETURN == 0 ? TPASS : TFAIL | TTERRNO),
diff --git a/testcases/kernel/timers/timer_create/timer_create04.c b/testcases/kernel/timers/timer_create/timer_create04.c
index 9d7ee17..e6a5f6e 100644
--- a/testcases/kernel/timers/timer_create/timer_create04.c
+++ b/testcases/kernel/timers/timer_create/timer_create04.c
@@ -166,7 +166,7 @@ int main(int ac, char **av)
 					temp_ev = (struct sigevent *)-1;
 			}
 
-			TEST(syscall(__NR_timer_create, clocks[i], temp_ev,
+			TEST(ltp_syscall(__NR_timer_create, clocks[i], temp_ev,
 				     temp_id));
 
 			/* check return code */
diff --git a/testcases/kernel/timers/timer_delete/timer_delete02.c b/testcases/kernel/timers/timer_delete/timer_delete02.c
index 9a303ef..876c339 100644
--- a/testcases/kernel/timers/timer_delete/timer_delete02.c
+++ b/testcases/kernel/timers/timer_delete/timer_delete02.c
@@ -95,14 +95,14 @@ int main(int ac, char **av)
 		Tst_count = 0;
 
 		/* Create a Posix timer */
-		if (syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer_id)
-		    < 0) {
+		if (ltp_syscall(__NR_timer_create, CLOCK_REALTIME, NULL,
+			&timer_id) < 0) {
 			Tst_count = TST_TOTAL;
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "timer_delete can't be tested because "
 				 "timer_create failed");
 		}
-		TEST(syscall(__NR_timer_delete, timer_id));
+		TEST(ltp_syscall(__NR_timer_delete, timer_id));
 		tst_resm((TEST_RETURN == 0 ? TPASS : TFAIL | TTERRNO),
 			 "%s", (TEST_RETURN == 0 ? "passed" : "failed"));
 	}
diff --git a/testcases/kernel/timers/timer_delete/timer_delete03.c b/testcases/kernel/timers/timer_delete/timer_delete03.c
index 2080fad..6441ef2 100644
--- a/testcases/kernel/timers/timer_delete/timer_delete03.c
+++ b/testcases/kernel/timers/timer_delete/timer_delete03.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			TEST(syscall(__NR_timer_delete, INVALID_ID));
+			TEST(ltp_syscall(__NR_timer_delete, INVALID_ID));
 
 			/* check return code */
 			if (TEST_RETURN == -1 && TEST_ERRNO == testcase[i]) {
diff --git a/testcases/kernel/timers/timer_settime/timer_settime02.c b/testcases/kernel/timers/timer_settime/timer_settime02.c
index 05705a7..01767eb 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime02.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime02.c
@@ -102,8 +102,8 @@ int main(int ac, char **av)
 
 			/* Set up individual test */
 			if (setup_test(i) == 0) {
-				TEST(syscall(__NR_timer_settime, timer, flag,
-					     &new_set, old_temp));
+				TEST(ltp_syscall(__NR_timer_settime, timer,
+					flag, &new_set, old_temp));
 				tst_resm((TEST_RETURN == 0 ?
 					  TPASS :
 					  TFAIL | TTERRNO),
@@ -184,7 +184,7 @@ void setup(void)
 
 	TEST_PAUSE;
 
-	if (syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer) < 0)
+	if (ltp_syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer) < 0)
 		tst_brkm(TBROK, NULL, "timer_create failed");
 }
 
diff --git a/testcases/kernel/timers/timer_settime/timer_settime03.c b/testcases/kernel/timers/timer_settime/timer_settime03.c
index 93836a6..dbabd86 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime03.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime03.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 
 			/* Set up individual tests */
 			setup_test(i);
-			TEST(syscall(__NR_timer_settime, tim, 0, new_temp,
+			TEST(ltp_syscall(__NR_timer_settime, tim, 0, new_temp,
 				     old_temp));
 
 			/* check return code */
@@ -182,7 +182,7 @@ void setup(void)
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	if (syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer) < 0) {
+	if (ltp_syscall(__NR_timer_create, CLOCK_REALTIME, NULL, &timer) < 0) {
 		tst_brkm(TBROK, NULL, "Timer create failed. Cannot"
 			 " setup test");
 	}

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



