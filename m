Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N3uhy-0002ZT-W8
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 16:52:15 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3uhs-0007eP-DP
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 16:52:14 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id CB82E12D10967
	for <ltp-list@lists.sourceforge.net>;
	Fri, 30 Oct 2009 17:52:01 +0100 (CET)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1N3uhh-0001yr-00
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 17:51:57 +0100
Date: Wed, 21 Oct 2009 21:37:32 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u2mj0sedcfnueu@debian>
Subject: [LTP] [PATCH] Other compiler warning fixes
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091021193732.c-4KXAfqIUOFE_bKwaAzma4IRr3xX0coNa4St6EMwXM@z>

Hello,

this is another chunk of compiler warning fixes in LTP tests, related to printf format strings. They have multiple causes:

 - most of them are caused by %d used for the TEST_RETURN variable (as in a previous patch)

 - off_t are cast to (int64_t) and PRId64 output specifier is used for them

 - other types are cast to (intmax_t) or (uintmax_t) and use the %jd or %ju (C99) output specifier. I've used this solution because it's generally correct, easy to use solution that is portable and (IMHO) more readable than using PRId64/PRIu64 and a cast (which you generally can't avoid). This way, there's only a cast.

 - in ioperm test, address should be declared as unsigned long (according to ioperm(2))

 - other little fixes (foo vs. *foo, %S vs. %s, %0 vs. %o)

Regards
    Jiri Palecek

---
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl02.c          |    6 +-
 testcases/kernel/syscalls/fcntl/fcntl03.c          |    6 +-
 testcases/kernel/syscalls/fcntl/fcntl04.c          |    6 +-
 testcases/kernel/syscalls/fcntl/fcntl05.c          |    6 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c          |    7 +-
 testcases/kernel/syscalls/fcntl/fcntl14.c          |   13 ++--
 testcases/kernel/syscalls/fcntl/fcntl17.c          |    8 ++-
 testcases/kernel/syscalls/fcntl/fcntl19.c          |    7 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c          |    7 +-
 testcases/kernel/syscalls/fcntl/fcntl21.c          |    7 +-
 testcases/kernel/syscalls/fcntl/fcntl22.c          |    4 +-
 testcases/kernel/syscalls/fork/fork09.c            |    2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate01.c  |    2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate04.c  |    6 +-
 .../kernel/syscalls/gettimeofday/gettimeofday02.c  |    9 ++-
 testcases/kernel/syscalls/inotify/inotify02.c      |    6 +-
 testcases/kernel/syscalls/ioperm/ioperm01.c        |    6 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl02.c    |   10 ++--
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c    |    6 +-
 testcases/kernel/syscalls/ipc/semctl/semctl07.c    |    2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c    |    4 +-
 testcases/kernel/syscalls/keyctl/keyctl01.c        |    4 +-
 testcases/kernel/syscalls/llseek/llseek01.c        |    7 +-
 testcases/kernel/syscalls/lseek/lseek01.c          |    4 +-
 testcases/kernel/syscalls/lseek/lseek07.c          |    5 +-
 testcases/kernel/syscalls/mkdir/mkdir08.c          |    2 +-
 testcases/kernel/syscalls/mknod/mknod01.c          |    2 +-
 testcases/kernel/syscalls/mknod/mknod06.c          |    2 +-
 testcases/kernel/syscalls/mknod/mknod07.c          |    2 +-
 testcases/kernel/syscalls/mknod/mknod09.c          |    2 +-
 testcases/kernel/syscalls/mlockall/mlockall01.c    |    7 +-
 testcases/kernel/syscalls/mlockall/mlockall02.c    |    2 +-
 testcases/kernel/syscalls/mlockall/mlockall03.c    |    2 +-
 .../syscalls/move_pages/move_pages_support.c       |    2 +-
 testcases/kernel/syscalls/msync/msync03.c          |    2 +-
 testcases/kernel/syscalls/msync/msync04.c          |    2 +-
 testcases/kernel/syscalls/msync/msync05.c          |    2 +-
 testcases/kernel/syscalls/munlock/munlock01.c      |   12 ++--
 testcases/kernel/syscalls/munlock/munlock02.c      |    7 +-
 .../kernel/syscalls/munlockall/munlockall01.c      |    8 +-
 testcases/kernel/syscalls/munmap/munmap03.c        |    2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep01.c  |    5 +-
 testcases/kernel/syscalls/nanosleep/nanosleep02.c  |    5 +-
 testcases/kernel/syscalls/nanosleep/nanosleep03.c  |    2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep04.c  |    2 +-
 testcases/kernel/syscalls/newuname/newuname01.c    |    2 +-
 testcases/kernel/syscalls/nice/nice04.c            |    8 +-
 testcases/kernel/syscalls/nice/nice05.c            |    2 +-
 testcases/kernel/syscalls/pathconf/pathconf01.c    |    2 +-
 testcases/kernel/syscalls/pipe/pipe03.c            |    8 +-
 testcases/kernel/syscalls/prctl/prctl01.c          |    6 +-
 testcases/kernel/syscalls/prctl/prctl02.c          |    6 +-
 testcases/kernel/syscalls/pread/pread01.c          |    7 +-
 testcases/kernel/syscalls/pread/pread02.c          |    2 +-
 testcases/kernel/syscalls/pread/pread03.c          |    4 +-
 testcases/kernel/syscalls/pselect/pselect01.c      |    7 +-
 testcases/kernel/syscalls/ptrace/ptrace03.c        |    6 +-
 testcases/kernel/syscalls/pwrite/pwrite01.c        |   21 +++---
 testcases/kernel/syscalls/pwrite/pwrite02.c        |    2 +-
 testcases/kernel/syscalls/pwrite/pwrite03.c        |    2 +-
 testcases/kernel/syscalls/read/read01.c            |    2 +-
 testcases/kernel/syscalls/read/read04.c            |    2 +-
 testcases/kernel/syscalls/readlink/readlink01.c    |    2 +-
 testcases/kernel/syscalls/readlink/readlink02.c    |    2 +-
 testcases/kernel/syscalls/readlink/readlink03.c    |    2 +-
 testcases/kernel/syscalls/readlink/readlink04.c    |    2 +-
 .../syscalls/remap_file_pages/remap_file_pages01.c |    7 +-
 testcases/kernel/syscalls/rename/rename02.c        |    2 +-
 testcases/kernel/syscalls/rmdir/rmdir04.c          |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    2 +-
 .../sched_get_priority_max01.c                     |    8 +--
 .../sched_get_priority_max02.c                     |    6 +-
 .../sched_get_priority_min01.c                     |    8 +--
 .../sched_get_priority_min02.c                     |    6 +-
 .../syscalls/sched_getparam/sched_getparam01.c     |    4 +-
 .../syscalls/sched_getparam/sched_getparam02.c     |    2 +-
 .../sched_rr_get_interval01.c                      |    7 +-
 .../sched_rr_get_interval02.c                      |    4 +-
 .../sched_rr_get_interval03.c                      |    6 +-
 .../syscalls/sched_setparam/sched_setparam01.c     |    7 +-
 .../syscalls/sched_setparam/sched_setparam02.c     |    7 +-
 .../syscalls/sched_setparam/sched_setparam03.c     |    4 +-
 .../syscalls/sched_setparam/sched_setparam05.c     |    6 +-
 testcases/kernel/syscalls/sendfile/sendfile02.c    |   13 ++--
 testcases/kernel/syscalls/sendfile/sendfile06.c    |   11 ++--
 testcases/kernel/syscalls/sendmsg/sendmsg01.c      |    2 +-
 .../syscalls/set_robust_list/set_robust_list01.c   |   10 ++--
 .../syscalls/set_tid_address/set_tid_address01.c   |    2 +-
 .../syscalls/setdomainname/setdomainname01.c       |    2 +-
 testcases/kernel/syscalls/setfsgid/setfsgid01.c    |    2 +-
 testcases/kernel/syscalls/setfsgid/setfsgid02.c    |    4 +-
 testcases/kernel/syscalls/setfsgid/setfsgid03.c    |    4 +-
 testcases/kernel/syscalls/setfsuid/setfsuid01.c    |    2 +-
 testcases/kernel/syscalls/setfsuid/setfsuid02.c    |    4 +-
 testcases/kernel/syscalls/setfsuid/setfsuid03.c    |    4 +-
 testcases/kernel/syscalls/setgid/setgid01.c        |    2 +-
 testcases/kernel/syscalls/setgroups/setgroups01.c  |    2 +-
 testcases/kernel/syscalls/setgroups/setgroups03.c  |    2 +-
 testcases/kernel/syscalls/setgroups/setgroups04.c  |    4 +-
 .../kernel/syscalls/sethostname/sethostname01.c    |    2 +-
 testcases/kernel/syscalls/setpgid/setpgid01.c      |    2 +-
 testcases/kernel/syscalls/setpgrp/setpgrp01.c      |    2 +-
 testcases/kernel/syscalls/setregid/setregid01.c    |   10 ++--
 testcases/kernel/syscalls/setregid/setregid02.c    |    2 +-
 testcases/kernel/syscalls/setregid/setregid04.c    |    4 +-
 testcases/kernel/syscalls/setreuid/setreuid01.c    |   10 ++--
 testcases/kernel/syscalls/setreuid/setreuid02.c    |    4 +-
 .../kernel/syscalls/setsockopt/setsockopt01.c      |    2 +-
 testcases/kernel/syscalls/setuid/setuid01.c        |    2 +-
 testcases/kernel/syscalls/setuid/setuid02.c        |    2 +-
 testcases/kernel/syscalls/sgetmask/sgetmask01.c    |    6 +-
 .../kernel/syscalls/sigaltstack/sigaltstack02.c    |    2 +-
 testcases/kernel/syscalls/signal/signal04.c        |    4 +-
 .../kernel/syscalls/sigpending/sigpending02.c      |    2 +-
 .../kernel/syscalls/sigsuspend/sigsuspend01.c      |    6 +-
 .../kernel/syscalls/socketcall/socketcall01.c      |    9 +--
 .../kernel/syscalls/socketcall/socketcall03.c      |    8 +-
 .../kernel/syscalls/socketcall/socketcall04.c      |    8 +-
 testcases/kernel/syscalls/sockioctl/sockioctl01.c  |    2 +-
 testcases/kernel/syscalls/splice/splice01.c        |    2 +-
 testcases/kernel/syscalls/stat/stat03.c            |    2 +-
 testcases/kernel/syscalls/stat/stat05.c            |    2 +-
 testcases/kernel/syscalls/stat/stat06.c            |    2 +-
 testcases/kernel/syscalls/statfs/statfs01.c        |    2 +-
 testcases/kernel/syscalls/statfs/statfs03.c        |    2 +-
 testcases/kernel/syscalls/statvfs/statvfs01.c      |   15 ++--
 testcases/kernel/syscalls/stime/stime02.c          |    2 +-
 testcases/kernel/syscalls/symlink/symlink01.c      |   29 ++++----
 testcases/kernel/syscalls/sync/sync01.c            |    2 +-
 testcases/kernel/syscalls/tee/tee01.c              |    2 +-
 testcases/kernel/syscalls/time/time01.c            |    2 +-
 testcases/kernel/syscalls/time/time02.c            |    9 ++-
 testcases/kernel/syscalls/times/times03.c          |    7 +-
 testcases/kernel/syscalls/truncate/truncate01.c    |    5 +-
 testcases/kernel/syscalls/truncate/truncate03.c    |    2 +-
 testcases/kernel/syscalls/truncate/truncate04.c    |    4 +-
 testcases/kernel/syscalls/ulimit/ulimit01.c        |   18 ++---
 testcases/kernel/syscalls/umask/umask01.c          |    2 +-
 testcases/kernel/syscalls/umask/umask03.c          |    2 +-
 testcases/kernel/syscalls/uname/uname01.c          |    2 +-
 testcases/kernel/syscalls/unlink/unlink05.c        |    2 +-
 testcases/kernel/syscalls/unlink/unlink06.c        |    4 +-
 testcases/kernel/syscalls/unlink/unlink07.c        |    2 +-
 testcases/kernel/syscalls/unlink/unlink08.c        |    4 +-
 testcases/kernel/syscalls/utime/utime06.c          |    2 +-
 testcases/kernel/syscalls/vmsplice/vmsplice01.c    |    2 +-
 testcases/kernel/syscalls/wait4/wait401.c          |    4 +-
 testcases/kernel/syscalls/write/write01.c          |    2 +-
 testcases/kernel/syscalls/writev/writev06.c        |    6 +-
 .../kernel/timers/clock_settime/clock_settime03.c  |    2 +-
 testcases/network/lib6/asapi_04.c                  |   12 ++--
 testcases/network/lib6/asapi_05.c                  |    3 +-
 testcases/network/lib6/getaddrinfo_01.c            |   68 ++++++++++----------
 testcases/network/lib6/in6_02.c                    |   18 +++---
 157 files changed, 408 insertions(+), 412 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 50ecdf4..baff476 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -352,8 +352,8 @@ func_stat()
 	 * that memory so the attaches equal N_ATTACH + stat_time (1).
 	 */
 	if (!fail && buf.shm_nattch != N_ATTACH + stat_time) {
-		tst_resm(TFAIL, "# of attaches is incorrect - %d",
-			 buf.shm_nattch);
+		tst_resm(TFAIL, "# of attaches is incorrect - %lu",
+			 (unsigned long)buf.shm_nattch);
 		fail = 1;
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl02.c b/testcases/kernel/syscalls/fcntl/fcntl02.c
index 83566cc..2ca1138 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl02.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl02.c
@@ -181,9 +181,9 @@ int main(int ac, char **av)
 					 fname, TEST_RETURN);
 			}
 			if (close(TEST_RETURN) == -1) {
-				tst_resm(TWARN,
-					 "close(%s) Failed, errno=%d : %s",
-					 fname, errno, strerror(errno));
+				tst_resm(TWARN | TERRNO,
+					 "close(%s) Failed",
+					 fname);
 			}
 		}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl03.c b/testcases/kernel/syscalls/fcntl/fcntl03.c
index dd99bf4..d99fe52 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl03.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl03.c
@@ -166,9 +166,9 @@ int main(int ac, char **av)
 		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL,
-				 "fcntl(%s, F_GETFD, 0) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO,
+				 "fcntl(%s, F_GETFD, 0) Failed",
+				 fname);
 		} else {
 
 	    /***************************************************************
diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index 65c8ed8..6db443c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -166,9 +166,9 @@ int main(int ac, char **av)
 		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL,
-				 "fcntl(%s, F_GETFL, 0) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO,
+				 "fcntl(%s, F_GETFL, 0) Failed",
+				 fname);
 		} else {
 
 	    /***************************************************************
diff --git a/testcases/kernel/syscalls/fcntl/fcntl05.c b/testcases/kernel/syscalls/fcntl/fcntl05.c
index d7773f0..7e6dfa8 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl05.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl05.c
@@ -168,9 +168,9 @@ int main(int ac, char **av)
 		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL,
-				 "fcntl(%s, F_GETLK, &flocks) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO,
+				 "fcntl(%s, F_GETLK, &flocks) Failed",
+				 fname);
 		} else {
 
 	    /***************************************************************
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index d9d1c27..503fac7 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -43,6 +43,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -194,13 +195,13 @@ compare_lock(struct flock *fl, short type, short whence, int start, int len,
 
 	if (fl->l_start != start) {
 		tst_resm(TFAIL, "region starts in wrong place, should be "
-			 "%d is %d", start, fl->l_start);
+			 "%d is %"PRId64, start, (int64_t)fl->l_start);
 		fail = 1;
 	}
 
 	if (fl->l_len != len) {
-		tst_resm(TFAIL, "region length is wrong, should be %d is %d",
-			 len, fl->l_len);
+		tst_resm(TFAIL, "region length is wrong, should be %d is %"PRId64,
+			 len, (int64_t)fl->l_len);
 		fail = 1;
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 7bdf9df..a076e35 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -46,6 +46,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <sys/wait.h>
+#include <inttypes.h>
 #include <usctest.h>
 #include <test.h>
 
@@ -667,17 +668,17 @@ void dochild()
 
 			if (flock.l_start != thiscase->c_start) {
 				tst_resm(TFAIL,
-					 "Test case %d, GETLK: start = %d, "
-					 "should have remained %d", test + 1,
-					 flock.l_start, thiscase->c_start);
+					 "Test case %d, GETLK: start = %"PRId64", "
+					 "should have remained %"PRId64, test + 1,
+					 (int64_t)flock.l_start, (int64_t)thiscase->c_start);
 				fail = 1;
 			}
 
 			if (flock.l_len != thiscase->c_len) {
 				tst_resm(TFAIL,
-					 "Test case %d, GETLK: len = %d, "
-					 "should have remained %d", test + 1,
-					 flock.l_len, thiscase->c_len);
+					 "Test case %d, GETLK: len = %"PRId64", "
+					 "should have remained %"PRId64, test + 1,
+					 (int64_t)flock.l_len, (int64_t)thiscase->c_len);
 				fail = 1;
 			}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl17.c b/testcases/kernel/syscalls/fcntl/fcntl17.c
index 06a32ce..c170cac 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl17.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -51,6 +51,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <inttypes.h>
+
 #include "test.h"
 #include "usctest.h"
 
@@ -301,13 +303,13 @@ int do_test(struct flock *lock, pid_t pid)
 
 	if (fl.l_start != lock->l_start) {
 		tst_resm(TFAIL, "region starts in wrong place, "
-			 "should be %d is %d", lock->l_start, fl.l_start);
+			 "should be %"PRId64" is %"PRId64, (int64_t)lock->l_start, (int64_t)fl.l_start);
 		return 1;
 	}
 
 	if (fl.l_len != lock->l_len) {
-		tst_resm(TFAIL, "region length is wrong, should be %d is %d",
-			 lock->l_len, fl.l_len);
+		tst_resm(TFAIL, "region length is wrong, should be %"PRId64" is %"PRId64,
+			 (int64_t)lock->l_len, (int64_t)fl.l_len);
 		return 1;
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index d89d990..d37a81d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -46,6 +46,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -201,13 +202,13 @@ compare_lock(struct flock *fl, short type, short whence, int start, int len,
 
 	if (fl->l_start != start) {
 		tst_resm(TFAIL, "region starts in wrong place, should be"
-			 "%d is %d", start, fl->l_start);
+			 "%d is %"PRId64, start, (int64_t)fl->l_start);
 		fail = 1;
 	}
 
 	if (fl->l_len != len) {
-		tst_resm(TFAIL, "region length is wrong, should be %d is %d",
-			 len, fl->l_len);
+		tst_resm(TFAIL, "region length is wrong, should be %d is %"PRId64,
+			 len, (int64_t)fl->l_len);
 		fail = 1;
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index 60730bb..feb2a49 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -43,6 +43,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -196,13 +197,13 @@ compare_lock(struct flock *fl, short type, short whence, int start, int len,
 
 	if (fl->l_start != start) {
 		tst_resm(TFAIL, "region starts in wrong place, should be"
-			 "%d is %d", start, fl->l_start);
+			 "%d is %"PRId64, start, (int64_t)fl->l_start);
 		fail = 1;
 	}
 
 	if (fl->l_len != len) {
-		tst_resm(TFAIL, "region length is wrong, should be %d is %d",
-			 len, fl->l_len);
+		tst_resm(TFAIL, "region length is wrong, should be %d is %"PRId64,
+			 len, (int64_t)fl->l_len);
 		fail = 1;
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index f31e37b..f538068 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -43,6 +43,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <inttypes.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -197,13 +198,13 @@ compare_lock(struct flock *fl, short type, short whence, int start, int len,
 
 	if (fl->l_start != start) {
 		tst_resm(TFAIL, "region starts in wrong place, should be"
-			 "%d is %d", start, fl->l_start);
+			 "%d is %"PRId64, start, (int64_t)fl->l_start);
 		fail = 1;
 	}
 
 	if (fl->l_len != len) {
-		tst_resm(TFAIL, "region length is wrong, should be %d is %d",
-			 len, fl->l_len);
+		tst_resm(TFAIL, "region length is wrong, should be %d is %"PRId64,
+			 len, (int64_t)fl->l_len);
 		fail = 1;
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl22.c b/testcases/kernel/syscalls/fcntl/fcntl22.c
index 1f1958a..1e6df2d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl22.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl22.c
@@ -199,8 +199,8 @@ void setup()
 
 	/* lock file */
 	if (fcntl(file, F_SETLK, &fl) < 0) {
-		tst_resm(TFAIL, "fcntl on file %s failed, errno =%d",
-			 file, errno);
+		tst_resm(TFAIL|TERRNO, "fcntl on file %d failed",
+			 file);
 	}
 
 }
diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index 828ca8c..1923002 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -100,7 +100,7 @@ int main(int ac, char **av)
 
 		mypid = getpid();
 
-		tst_resm(TINFO, "OPEN_MAX is %d", OPEN_MAX);
+		tst_resm(TINFO, "OPEN_MAX is %ld", OPEN_MAX);
 
 		/* establish first free file */
 		sprintf(filname, "fork09.%d", mypid);
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index 1f911a6..1be0202 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -147,7 +147,7 @@ int main(int ac, char **av)
 			 */
 			if (file_length != TRUNC_LEN) {
 				tst_resm(TFAIL, "%s: Incorrect file size %"PRId64", "
-					 "Expected %d", TESTFILE, file_length,
+					 "Expected %d", TESTFILE, (int64_t)file_length,
 					 TRUNC_LEN);
 			} else {
 				tst_resm(TPASS, "Functionality of ftruncate() "
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index 4785dd5..324a654 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -188,7 +188,7 @@ void doparent()
 	if (sb.st_size != recstart + (RECLEN / 2)) {
 		tst_resm(TFAIL, "unexpected ftruncate failure case 4");
 		tst_resm(TFAIL, "expected size of %d, got size of %"PRId64,
-			 recstart + (RECLEN / 2), sb.st_size);
+			 recstart + (RECLEN / 2), (int64_t)sb.st_size);
 		local_flag = FAILED;
 		cleanup();
 	}
@@ -212,7 +212,7 @@ void doparent()
 	if (sb.st_size != RECLEN) {
 		tst_resm(TFAIL, "unexpected ftruncate failure case 5");
 		tst_resm(TFAIL, "expected size of %d, got size of %"PRId64,
-			 RECLEN, sb.st_size);
+			 RECLEN, (int64_t)sb.st_size);
 		local_flag = FAILED;
 		cleanup();
 	}
@@ -231,7 +231,7 @@ void doparent()
 	if (sb.st_size != (2 * len)) {
 		tst_resm(TFAIL, "unexpected ftruncate failure case 6");
 		tst_resm(TFAIL, "expected size of %d, got size of %"PRId64,
-			 (2 * len), sb.st_size);
+			 (2 * len), (int64_t)sb.st_size);
 		local_flag = FAILED;
 		cleanup();
 	}
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 82b2d2b..a2533eb 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -40,6 +40,7 @@
  *
  */
 
+#include <stdint.h>
 #include <stdio.h>
 #include <sys/time.h>
 #include <signal.h>
@@ -108,10 +109,10 @@ int main(int ac, char **av)
 
 		if (tv2.tv_sec < tv1.tv_sec ||
 		    (tv2.tv_sec == tv1.tv_sec && tv2.tv_usec < tv1.tv_usec)) {
-			tst_resm(TFAIL,
-				 "Time is going backwards: old %d.%d vs new %d.%d!",
-				 tv1.tv_sec, tv1.tv_usec, tv2.tv_sec,
-				 tv2.tv_usec);
+			tst_resm(TFAIL,
+				 "Time is going backwards: old %jd.%jd vs new %jd.%jd!",
+				 (intmax_t)tv1.tv_sec, (intmax_t)tv1.tv_usec, (intmax_t)tv2.tv_sec,
+				 (intmax_t)tv2.tv_usec);
 			cleanup();
 			return 1;
 		}
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index a22204c..5e252f7 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -179,9 +179,9 @@ int main(int ac, char **av)
 		Tst_count++;
 
 		if (getcwd(fname1, BUF_SIZE) == NULL) {
-			tst_brkm(TBROK, cleanup,
-				 "getcwd(%x, %d) Failed, errno=%d : %s", fname1,
-				 BUF_SIZE, errno, strerror(errno));
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "getcwd(%p, %d) Failed", fname1,
+				 BUF_SIZE);
 		}
 
 		snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index 8d1b44c..81de993 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -74,7 +74,7 @@ char *TCID = "ioperm01";	/* Test program identifier.    */
 #include "test.h"
 #include "usctest.h"
 
-int io_addr;			/*kernel version dependant io start address */
+unsigned long io_addr;			/*kernel version dependant io start address */
 #define NUM_BYTES 3		/* number of bytes from start address */
 #define TURN_ON 1
 #define TURN_OFF 0
@@ -116,11 +116,11 @@ int main(int ac, char **av)
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "ioperm() failed for port address "
-				 "%ld,  errno=%d : %s", io_addr,
+				 "%lu,  errno=%d : %s", io_addr,
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
 			tst_resm(TPASS, "ioperm() passed for port "
-				 "address %ld, returned %d",
+				 "address %lu, returned %lu",
 				 io_addr, TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index c83862a..60f5be1 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -97,7 +97,7 @@ char *argv[];
 	 */
 
 	if (arg.buf->sem_nsems != nsems) {
-		tst_resm(TFAIL, "error: unexpected number of sems %d",
+		tst_resm(TFAIL, "error: unexpected number of sems %lu",
 			 arg.buf->sem_nsems);
 		tst_exit();
 	}
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 5f5d2b6..af02918 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -145,10 +145,10 @@ int main(int ac, char **av) {
 				if(TEST_ERRNO == ENOKEY)	//Check for correct error no.	
 								//if no  matching key was found or an invalid key was specified. 
                            	{
-					tst_resm(TPASS,"KEYCTL_REVOKE got expected errno:%ld",TEST_ERRNO);
+					tst_resm(TPASS|TTERRNO,"KEYCTL_REVOKE got expected errno");
                         		cleanup();
 				}else{
-					tst_resm(TFAIL,"KEYCTL_REVOKE got unexpected errno:%ld", TEST_ERRNO);
+					tst_resm(TFAIL|TTERRNO,"KEYCTL_REVOKE got unexpected errno");
                         		cleanup();
 					tst_exit();
 				}
diff --git a/testcases/kernel/syscalls/llseek/llseek01.c b/testcases/kernel/syscalls/llseek/llseek01.c
index cc6b68c..ef8363a 100644
--- a/testcases/kernel/syscalls/llseek/llseek01.c
+++ b/testcases/kernel/syscalls/llseek/llseek01.c
@@ -80,6 +80,7 @@
 #include <sys/resource.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <inttypes.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -141,9 +142,9 @@ int main(int ac, char **av)
 			 * is equal to the specified offset value.
 			 */
 			if (TEST_RETURN != (loff_t) (80 * BUFSIZ)) {
-				tst_resm(TFAIL, "llseek() returned incorrect "
-					 "value %d, expected %d",
-					 offset, BUFSIZ);
+				tst_resm(TFAIL, "llseek() returned incorrect "
+					 "value %"PRId64", expected %d",
+					 (int64_t)offset, BUFSIZ);
 				continue;
 			}
 
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index b9880ec..7265236 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL,
-					 "lseek(%s, %ld, 0) Failed, errno=%d : %s",
+					 "lseek(%s, %d, 0) Failed, errno=%d : %s",
 					 Fname, offset, TEST_ERRNO,
 					 strerror(TEST_ERRNO));
 			} else {
@@ -188,7 +188,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "lseek(%s, %ld, %d) returned %d",
+						 "lseek(%s, %d, %d) returned %ld",
 						 Fname, offset, Whence[ind],
 						 TEST_RETURN);
 				} else
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index b43eb5f..998b031 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -75,6 +75,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <signal.h>
+#include <inttypes.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -141,8 +142,8 @@ int main(int ac, char **av)
 			 */
 			if (TEST_RETURN != offset) {
 				tst_resm(TFAIL, "lseek() returned "
-					 "incorrect value %d, expected "
-					 "%d", TEST_RETURN, offset);
+					 "incorrect value %ld, expected "
+					 "%"PRId64, TEST_RETURN, (int64_t)offset);
 				continue;
 			}
 			/*
diff --git a/testcases/kernel/syscalls/mkdir/mkdir08.c b/testcases/kernel/syscalls/mkdir/mkdir08.c
index e4eb6cd..b6536bc 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir08.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir08.c
@@ -174,7 +174,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "mkdir(%s) returned %d", fname,
+				tst_resm(TPASS, "mkdir(%s) returned %ld", fname,
 					 TEST_RETURN);
 			}
 			if (rmdir(fname) == -1) {
diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
index 30a5149..33017d1 100644
--- a/testcases/kernel/syscalls/mknod/mknod01.c
+++ b/testcases/kernel/syscalls/mknod/mknod01.c
@@ -200,7 +200,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "mknod(%s, %#o, 0) returned %d",
+						 "mknod(%s, %#o, 0) returned %ld",
 						 Path, tcases[i], TEST_RETURN);
 				}
 			}
diff --git a/testcases/kernel/syscalls/mknod/mknod06.c b/testcases/kernel/syscalls/mknod/mknod06.c
index e267fd5..c6165da 100644
--- a/testcases/kernel/syscalls/mknod/mknod06.c
+++ b/testcases/kernel/syscalls/mknod/mknod06.c
@@ -181,7 +181,7 @@ int main(int ac, char **av)
 
 			/* Check return code from mknod(2) */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "mknod() returned %d, expected "
+				tst_resm(TFAIL, "mknod() returned %ld, expected "
 					 "-1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 724b6ac..29298b7 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -158,7 +158,7 @@ int main(int ac, char **av)
 
 			/* Check return code from mknod(2) */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "mknod() returned %d, expected "
+				tst_resm(TFAIL, "mknod() returned %ld, expected "
 					 "-1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/mknod/mknod09.c b/testcases/kernel/syscalls/mknod/mknod09.c
index aefde5b..1b58dc0 100644
--- a/testcases/kernel/syscalls/mknod/mknod09.c
+++ b/testcases/kernel/syscalls/mknod/mknod09.c
@@ -117,7 +117,7 @@ int main(int ac, char **av)
 
 		/* Check return code from mknod(2) */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "mknod() returned %d,"
+			tst_resm(TFAIL, "mknod() returned %ld,"
 				 "expected -1, errno=%d", TEST_RETURN,
 				 exp_enos[0]);
 		} else {
diff --git a/testcases/kernel/syscalls/mlockall/mlockall01.c b/testcases/kernel/syscalls/mlockall/mlockall01.c
index f797bd6..98fda9d 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall01.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall01.c
@@ -122,10 +122,9 @@ int main(int ac, char **av)
 
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
-				tst_resm(TFAIL, "mlockall(%s) Failed with "
-					 "return=%d, errno=%d : %s",
-					 TC[i].fdesc, TEST_RETURN, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "mlockall(%s) Failed with "
+					 "return=%ld",
+					 TC[i].fdesc, TEST_RETURN);
 			} else {
 				tst_resm(TPASS, "mlockall test passed for %s",
 					 TC[i].fdesc);
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index cc7184d..e0d48f0 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -156,7 +156,7 @@ int main(int ac, char **av)
 				else
 					tst_brkm(TFAIL, cleanup,
 						 "mlock() Failed, expected "
-						 "return value=-1, got %d",
+						 "return value=-1, got %ld",
 						 TEST_RETURN);
 			}
 			cleanup_test(i);
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 4490ea4..69e717f 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -176,7 +176,7 @@ int main(int ac, char **av)
 			} else {
 				tst_brkm(TFAIL, cleanup,
 					 "mlockall() Failed, expected "
-					 "return value=-1, got %d",
+					 "return value=-1, got %ld",
 					 TEST_RETURN);
 			}
 			cleanup_test(i);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 05492d3..259049c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -189,7 +189,7 @@ verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
 	for (i = 0; i < num; i++) {
 		if (status[i] != nodes[i]) {
 			tst_resm(TFAIL, "page %d on node %d, "
-				 "expected on node %p", i, status[i], nodes[i]);
+				 "expected on node %d", i, status[i], nodes[i]);
 			return;
 		}
 
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index 1583c4f..c9916e0 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 		/* Check for the return value of msync() */
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "msync() returns unexpected "
-				 "value %d, expected:-1", TEST_RETURN);
+				 "value %ld, expected:-1", TEST_RETURN);
 			continue;
 		}
 
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 957c6e1..d624370 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 		/* Check for the return value of msync() */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "msync() returns unexpected value %d, "
+			tst_resm(TFAIL, "msync() returns unexpected value %ld, "
 				 "expected:-1", TEST_RETURN);
 			continue;
 		}
diff --git a/testcases/kernel/syscalls/msync/msync05.c b/testcases/kernel/syscalls/msync/msync05.c
index 1321ab8..f6a2056 100644
--- a/testcases/kernel/syscalls/msync/msync05.c
+++ b/testcases/kernel/syscalls/msync/msync05.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 
 		/* Check for the return value of msync() */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "msync() returns unexpected value %d, "
+			tst_resm(TFAIL, "msync() returns unexpected value %ld, "
 				 "expected:-1", TEST_RETURN);
 			continue;
 		}
diff --git a/testcases/kernel/syscalls/munlock/munlock01.c b/testcases/kernel/syscalls/munlock/munlock01.c
index 20cb013..b4b8ed5 100644
--- a/testcases/kernel/syscalls/munlock/munlock01.c
+++ b/testcases/kernel/syscalls/munlock/munlock01.c
@@ -122,11 +122,10 @@ int main(int ac, char **av)
 			/* check return code */
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
-				tst_resm(TFAIL, "mlock(%p, %d) Failed with "
-					 "return=%d, errno=%d : %s",
+				tst_resm(TFAIL|TTERRNO, "mlock(%p, %d) Failed with "
+					 "return=%ld",
 					 TC[i].addr, TC[i].len,
-					 TEST_RETURN, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+					 TEST_RETURN);
 			} else {
 				tst_resm(TPASS, "test %d passed length = %d",
 					 i, TC[i].len);
@@ -150,9 +149,8 @@ void setup1(int i)
 	/* check return code */
 	if (TEST_RETURN == -1) {
 		TEST_ERROR_LOG(TEST_ERRNO);
-		tst_brkm(TFAIL, cleanup, "mlock(%p, %d) Failed with return=%d,"
-			 "errno=%d : %s", TC[i].addr, TC[i].len, TEST_RETURN,
-			 TEST_ERRNO, strerror(TEST_ERRNO));
+		tst_brkm(TFAIL|TTERRNO, cleanup, "mlock(%p, %d) Failed with return=%ld",
+			 TC[i].addr, TC[i].len, TEST_RETURN);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/munlock/munlock02.c b/testcases/kernel/syscalls/munlock/munlock02.c
index 040ae05..b9c122c 100644
--- a/testcases/kernel/syscalls/munlock/munlock02.c
+++ b/testcases/kernel/syscalls/munlock/munlock02.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 			} else {
 				tst_brkm(TFAIL, cleanup,
 					 "munlock() Failed, expected "
-					 "return value=-1, got %d",
+					 "return value=-1, got %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -177,9 +177,8 @@ void setup()
 
 	/* check return code */
 	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL, cleanup, "mlock(%p, %d) Failed with return=%d,"
-			 "errno=%d : %s", address, TC[0].len, TEST_RETURN,
-			 TEST_ERRNO, strerror(TEST_ERRNO));
+		tst_brkm(TFAIL|TTERRNO, cleanup, "mlock(%p, %d) Failed with return=%ld",
+			 address, TC[0].len, TEST_RETURN);
 	}
 	TC[0].addr = address;
 	/*
diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index ef7d481..36bb558 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -99,12 +99,12 @@ int main(int ac, char **av)
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "munlockall() Failed with"
-				 " return=%d, errno=%d : %s",
-				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "munlockall() Failed with"
+				 " return=%ld",
+				 TEST_RETURN);
 		} else {
 			tst_resm(TPASS, "munlockall() passed with"
-				 " return=%d ", TEST_RETURN);
+				 " return=%ld ", TEST_RETURN);
 
 		}
 	}
diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
index 5eb5ad1..fcdfbed 100644
--- a/testcases/kernel/syscalls/munmap/munmap03.c
+++ b/testcases/kernel/syscalls/munmap/munmap03.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 
 		/* Check for the return value of munmap() */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "munmap() returned %d, expected -1",
+			tst_resm(TFAIL, "munmap() returned %ld, expected -1",
 				 TEST_RETURN);
 			continue;
 		}
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index 783fc43..60c1c54 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -69,6 +69,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/wait.h>
+#include <stdint.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -158,8 +159,8 @@ int main(int ac, char **av)
 				if (got_ms < want_ms) {
 					retval = 1;
 					tst_resm(TFAIL, "Child execution not "
-						 "suspended for %d seconds.  (Wanted %ld ms, got %ld ms)",
-						 timereq.tv_sec, want_ms,
+						 "suspended for %jd seconds.  (Wanted %ld ms, got %ld ms)",
+						 (intmax_t)timereq.tv_sec, want_ms,
 						 got_ms);
 				} else {
 					tst_resm(TPASS, "nanosleep "
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep02.c b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
index 8b7dbe9..5ff6a8a 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep02.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
@@ -74,6 +74,7 @@
 #include <time.h>
 #include <wait.h>
 #include <sys/time.h>
+#include <stdint.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -266,8 +267,8 @@ void do_child()
 				 "due to the limitation of the way it calculates the");
 			tst_resm(TWARN, "system call execution time.");
 			tst_resm(TFAIL, "Child execution not "
-				 "suspended for %d seconds %lu nanoseconds",
-				 timereq.tv_sec, timereq.tv_nsec);
+				 "suspended for %jd seconds %lu nanoseconds",
+				 (intmax_t)timereq.tv_sec, timereq.tv_nsec);
 			exit(1);
 		}
 	} else {
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep03.c b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
index 50e5ffd..12ea809 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep03.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
@@ -185,7 +185,7 @@ void do_child()
 			exit(1);
 		}
 	} else {
-		tst_resm(TFAIL, "nanosleep() returns %d, "
+		tst_resm(TFAIL, "nanosleep() returns %ld, "
 			 "expected -1, errno:%d", TEST_RETURN, EINTR);
 		exit(1);
 	}
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep04.c b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
index 9b9fdd4..4fb3de2 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep04.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
@@ -135,7 +135,7 @@ int main(int ac, char **av)
 					exit(1);
 				}
 			} else {
-				tst_resm(TFAIL, "nanosleep() returns %d, "
+				tst_resm(TFAIL, "nanosleep() returns %ld, "
 					 "expected -1, errno:%d",
 					 TEST_RETURN, EINVAL);
 				exit(1);
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index d0a6c12..fbc6260 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -133,7 +133,7 @@ int main(int ac, char **av) {
                            cleanup();
 	  	           tst_exit();
                      }else {
-	   		tst_resm(TPASS, "newuname call succeed: return value = %d ",TEST_RETURN);
+	   		tst_resm(TPASS, "newuname call succeed: return value = %ld ",TEST_RETURN);
 			TEST(strcmp(name.sysname,"Linux")); //Linux ?
 			if(TEST_RETURN == 0){
 				tst_resm(TINFO,"This system is %s",name.sysname);
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index 2dca867..d2a4887 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -129,12 +129,12 @@ int main(int ac, char **av)
 			/* check return code from nice(2) */
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
-				tst_resm(TPASS, "nice(2) returned %d for %s",
+				tst_resm(TPASS, "nice(2) returned %ld for %s",
 					 TEST_RETURN, test_desc);
 			} else {
-				tst_resm(TFAIL,
-					 "nice() returned %d for %s, errno:%d",
-					 TEST_RETURN, test_desc, errno);
+				tst_resm(TFAIL|TTERRNO,
+					 "nice() returned %ld for %s",
+					 TEST_RETURN, test_desc);
 			}
 		}		/* End of TEST CASE LOOPING. */
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
index 340205f..72ec4c9 100644
--- a/testcases/kernel/syscalls/nice/nice05.c
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "nice(%d) returned %d", val,
+				tst_resm(TPASS, "nice(%d) returned %ld", val,
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
index 7825e16..21a580e 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf01.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
@@ -209,7 +209,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "pathconf(%s, %s) returned %d",
+						 "pathconf(%s, %s) returned %ld",
 						 path, args[i].define_tag,
 						 TEST_RETURN);
 				}
diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index c36bc41..6a42519 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -98,9 +98,9 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "expected failure writing to "
 				 "read end of pipe");
 		else
-			tst_resm(TFAIL, "success when writing to read "
-				 "end of pipe ret=%d, errno=%d",
-				 TEST_RETURN, TEST_ERRNO);
+			tst_resm(TFAIL|TTERRNO, "success when writing to read "
+				 "end of pipe ret=%ld",
+				 TEST_RETURN);
 
 		TEST(safe_read(fildes[1], rbuf, 1));
 		if (TEST_RETURN == -1 && TEST_ERRNO == EBADF)
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 				 "write end of pipe");
 		else
 			tst_resm(TFAIL, "success when reading from "
-				 "write end of pipe ret=%d, "
+				 "write end of pipe ret=%ld, "
 				 "errno=%d", TEST_RETURN, TEST_ERRNO);
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/prctl/prctl01.c b/testcases/kernel/syscalls/prctl/prctl01.c
index 355ed99..9892bb9 100644
--- a/testcases/kernel/syscalls/prctl/prctl01.c
+++ b/testcases/kernel/syscalls/prctl/prctl01.c
@@ -133,10 +133,8 @@ int main(int ac, char **av)
 				if (TEST_RETURN == 0) {
 					exit(0);
 				} else {
-					tst_resm(TWARN, "prctl() returned %d"
-						 " errno = %d : %s",
-						 TEST_RETURN, TEST_ERRNO,
-						 strerror(TEST_ERRNO));
+					tst_resm(TWARN|TTERRNO, "prctl() returned %ld",
+						 TEST_RETURN);
 					exit(1);
 				}
 
diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index 82bff24..cda5dad 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -147,10 +147,8 @@ int main(int ac, char **av)
 							    exp_errno)) {
 					exit(TEST_ERRNO);
 				} else {
-					tst_resm(TWARN, "prctl() returned %d"
-						 " errno = %d : %s",
-						 TEST_RETURN, TEST_ERRNO,
-						 strerror(TEST_ERRNO));
+					tst_resm(TWARN|TTERRNO, "prctl() returned %ld",
+						 TEST_RETURN);
 					exit(TEST_ERRNO);
 				}
 
diff --git a/testcases/kernel/syscalls/pread/pread01.c b/testcases/kernel/syscalls/pread/pread01.c
index ea95ac3..58055d1 100644
--- a/testcases/kernel/syscalls/pread/pread01.c
+++ b/testcases/kernel/syscalls/pread/pread01.c
@@ -73,6 +73,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <inttypes.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -306,9 +307,9 @@ void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
 	off_t offloc;		/* offset ret. from lseek() */
 
 	if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
-		tst_resm(TWARN, "return = %d, expected %d", offloc, checkoff);
-		tst_brkm(TBROK, cleanup, "lseek() on %s failed, error=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
+		tst_resm(TWARN, "return = %"PRId64", expected %"PRId64, (int64_t)offloc, (int64_t)checkoff);
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek() on %s failed",
+			 TEMPFILE);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index e8643c7..44f74c2 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -161,7 +161,7 @@ int main(int ac, char **av)
 			/* Check for the return code of pread() */
 			if (TEST_RETURN != -1) {
 				tst_brkm(TFAIL, cleanup, "pread() returned "
-					 "%d, expected -1, errno:%d",
+					 "%ld, expected -1, errno:%d",
 					 TEST_RETURN, Test_cases[i].exp_errno);
 			}
 
diff --git a/testcases/kernel/syscalls/pread/pread03.c b/testcases/kernel/syscalls/pread/pread03.c
index b5e25c2..962f2b0 100644
--- a/testcases/kernel/syscalls/pread/pread03.c
+++ b/testcases/kernel/syscalls/pread/pread03.c
@@ -131,8 +131,8 @@ int main(int ac, char **av)
 		/* Check for the return code of pread() */
 		if (TEST_RETURN != -1) {
 			tst_brkm(TFAIL, cleanup, "pread() returned "
-				 "%d, expected -1, errno:%d\n",
-				 TEST_RETURN, exp_enos);
+				 "%ld, expected -1, errno:%d\n",
+				 TEST_RETURN, EISDIR);
 		}
 
 		TEST_ERROR_LOG(TEST_ERRNO);
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 1d2b3c1..250ed03 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -44,6 +44,7 @@
 #include <time.h>
 #include <unistd.h>
 #include <errno.h>
+#include <stdint.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -100,8 +101,8 @@ int main()
 		tv.tv_nsec = 0;
 
 		tst_resm(TINFO,
-			 "Testing basic pselect sanity,Sleeping for %d secs",
-			 tv.tv_sec);
+			 "Testing basic pselect sanity,Sleeping for %jd secs",
+			 (intmax_t)tv.tv_sec);
 		start = time(&t);
 		retval =
 		    pselect(0, &readfds, NULL, NULL, (struct timespec *)&tv,
@@ -126,7 +127,7 @@ int main()
 		tv.tv_nsec = total_nsec;
 
 		tst_resm(TINFO,
-			 "Testing basic pselect sanity,Sleeping for %d nano secs",
+			 "Testing basic pselect sanity,Sleeping for %ld nano secs",
 			 tv.tv_nsec);
 		gettimeofday(&tv_start, NULL);
 		retval =
diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index 52a3a4c..e54a339 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -176,10 +176,8 @@ int main(int ac, char **av)
 							    exp_errno)) {
 					exit(TEST_ERRNO);
 				} else {
-					tst_resm(TWARN, "ptrace() returned %d;"
-						 " errno: %d, %s", TEST_RETURN,
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
+					tst_resm(TWARN|TTERRNO, "ptrace() returned %ld",
+						 TEST_RETURN);
 					exit(TEST_ERRNO);
 				}
 
diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
index f85686e..490969f 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite01.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
@@ -75,6 +75,7 @@
 #include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
+#include <inttypes.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -271,10 +272,10 @@ void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
 	off_t offloc;		/* offset ret. from lseek() */
 
 	if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
-		tst_resm(TWARN, "lseek returned %d, expected %d", offloc,
-			 checkoff);
-		tst_brkm(TBROK, cleanup, "lseek() on %s Failed, error=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
+		tst_resm(TWARN, "lseek returned %"PRId64", expected %"PRId64, (int64_t)offloc,
+			 (int64_t)checkoff);
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek() on %s Failed",
+			 TEMPFILE);
 	}
 }
 
@@ -302,17 +303,17 @@ void check_file_contents()
 		/* Seek to specified offset position from beginning */
 		offloc = lseek(fildes, count * K1, SEEK_SET);
 		if (offloc != (count * K1)) {
-			tst_brkm(TBROK, cleanup,
-				 "lseek() failed: offloc=%d, errno=%d",
-				 offloc, errno);
+			tst_brkm(TBROK|TERRNO, cleanup,
+				 "lseek() failed: offloc=%"PRId64,
+				 (int64_t)offloc);
 		}
 
 		/* Read the data from file into a buffer */
 		nread = read(fildes, read_buf, K1);
 		if (nread != K1) {
-			tst_brkm(TBROK, cleanup,
-				 "read() failed: nread=%d, errno=%d",
-				 nread, errno);
+			tst_brkm(TBROK|TERRNO, cleanup,
+				 "read() failed: nread=%d",
+				 nread);
 		}
 
 		/* Compare the read data with the data written using pwrite */
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index 20a6fbe..c0eb61f 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -162,7 +162,7 @@ int main(int ac, char **av)
 
 			/* Check for the return code of pwrite() */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "pwrite() returned %d, "
+				tst_resm(TFAIL, "pwrite() returned %ld, "
 					 "expected -1, errno:%d",
 					 TEST_RETURN, Test_cases[i].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel/syscalls/pwrite/pwrite03.c
index 985fd96..0f9ab7c 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite03.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite03.c
@@ -132,7 +132,7 @@ int main(int ac, char **av)
 
 		/* Check for the return code of pwrite() */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "pwrite() returned %d, "
+			tst_resm(TFAIL, "pwrite() returned %ld, "
 				 "expected -1, errno:%d",
 				 TEST_RETURN, exp_enos[0]);
 		}
diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index 04e514d..b6b02d7 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -197,7 +197,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "read(pfds) returned %d",
+				tst_resm(TPASS, "read(pfds) returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index 4ebc5ad..a87d92e 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 		if (STD_FUNCTIONAL_TEST) {
 			if (TEST_RETURN != TST_SIZE) {
-				tst_resm(TFAIL, "Bad read count - got %d - "
+				tst_resm(TFAIL, "Bad read count - got %ld - "
 					 "expected %d", TEST_RETURN, TST_SIZE);
 				continue;
 			}
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index d4f964f..cdbaa2f 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -148,7 +148,7 @@ int main(int ac, char **av)
 						 "correct", SYMFILE);
 				}
 			} else {
-				tst_resm(TFAIL, "readlink() return value %d "
+				tst_resm(TFAIL, "readlink() return value %ld "
 					 "does't match, Expected %d",
 					 TEST_RETURN, exp_val);
 			}
diff --git a/testcases/kernel/syscalls/readlink/readlink02.c b/testcases/kernel/syscalls/readlink/readlink02.c
index d1ab5e1..3f73f00 100644
--- a/testcases/kernel/syscalls/readlink/readlink02.c
+++ b/testcases/kernel/syscalls/readlink/readlink02.c
@@ -174,7 +174,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "readlink(%s, buf, 255) returned %d",
+					 "readlink(%s, buf, 255) returned %ld",
 					 symlnk, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index e07f24e..0535b25 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -187,7 +187,7 @@ int main(int ac, char **av)
 
 			/* Check return code of readlink(2) */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "readlink() returned %d, "
+				tst_resm(TFAIL, "readlink() returned %ld, "
 					 "expected -1, errno:%d", TEST_RETURN,
 					 Test_cases[i].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
index 8f14d94..5775655 100644
--- a/testcases/kernel/syscalls/readlink/readlink04.c
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
 						 "correct", SYMFILE);
 				}
 			} else {
-				tst_resm(TFAIL, "readlink() return value %d "
+				tst_resm(TFAIL, "readlink() return value %ld "
 					 "doesn't match, Expected %d",
 					 TEST_RETURN, exp_val);
 			}
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index 720230a..06e7b89 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -188,10 +188,9 @@ static void test_nonlinear(int fd)
 
 		if (remap_file_pages(page, page_sz * 2, 0,
 				     (window_pages - i - 2), 0) == -1) {
-			tst_resm(TFAIL,
-				 "remap_file_pages error for page=%d, page_sz=%d, window_pages=%d (errno=%d : %s)",
-				 page, (page_sz * 2), (window_pages - i - 2),
-				 errno, strerror(errno));
+			tst_resm(TFAIL|TERRNO,
+				 "remap_file_pages error for page=%p, page_sz=%d, window_pages=%d",
+				 page, (page_sz * 2), (window_pages - i - 2));
 			cleanup(data);
 		}
 	}
diff --git a/testcases/kernel/syscalls/rename/rename02.c b/testcases/kernel/syscalls/rename/rename02.c
index 0b5a513..e2f0725 100644
--- a/testcases/kernel/syscalls/rename/rename02.c
+++ b/testcases/kernel/syscalls/rename/rename02.c
@@ -173,7 +173,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "rename(%s, %s) returned %d",
+				tst_resm(TPASS, "rename(%s, %s) returned %ld",
 					 fname, mname, TEST_RETURN);
 			}
 			if (unlink(mname) == -1) {
diff --git a/testcases/kernel/syscalls/rmdir/rmdir04.c b/testcases/kernel/syscalls/rmdir/rmdir04.c
index 15a0c87..ae75818 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir04.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir04.c
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "rmdir(%s) returned %d", fname,
+				tst_resm(TPASS, "rmdir(%s) returned %ld", fname,
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 27af970..ffc5fa2 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -186,7 +186,7 @@ int main(int ac, char **av) {
 	                        	 TEST(set_handler(signal, 0, test_flags[flag]));
 						 if (TEST_RETURN == 0) {
         					tst_resm(TINFO,"signal: %d ", signal);
-        					tst_resm(TPASS, "rt_sigaction call succeeded: result = %d ",TEST_RETURN );
+        					tst_resm(TPASS, "rt_sigaction call succeeded: result = %ld ",TEST_RETURN );
         					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
 						kill(getpid(),signal);
 			                         } else {
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index c6f57ab..aa98de6 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -177,7 +177,7 @@ int main(int ac, char **av) {
         						tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
                  	   				tst_resm(TPASS, "%s failure with sig: %d as expected errno  = %s : %s", TCID, signal,test_cases[0].errdesc, strerror(TEST_ERRNO));
 			                         } else {
-        					tst_resm(TFAIL, "rt_sigaction call succeeded: result = %d got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO, test_cases[0].exp_errno);
+        					tst_resm(TFAIL, "rt_sigaction call succeeded: result = %ld got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO, test_cases[0].exp_errno);
         					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
 						}
                 			}
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index aa85117..9d3aa98 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -183,7 +183,7 @@ int main(int ac, char **av) {
         						tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
                  	   				tst_resm(TPASS, "%s failure with sig: %d as expected errno  = %s : %s", TCID, signal,test_cases[0].errdesc, strerror(TEST_ERRNO));
 			                         } else {
-        					tst_resm(TFAIL, "rt_sigaction call succeeded: result = %d got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO, test_cases[0].exp_errno);
+        					tst_resm(TFAIL, "rt_sigaction call succeeded: result = %ld got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO, test_cases[0].exp_errno);
         					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
 						}
                 			}
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index 2db0ca5..beaafd8 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -118,11 +118,9 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s Passed",
 					 test_cases[ind].desc);
 			} else {
-				tst_resm(TFAIL, "%s Failed,"
-					 "sched_get_priority_max() returned %d"
-					 " errno = %d : %s",
-					 test_cases[ind].desc, TEST_RETURN,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "%s Failed,"
+					 "sched_get_priority_max() returned %ld",
+					 test_cases[ind].desc, TEST_RETURN);
 			}
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
index bc7e898..4123276 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
@@ -108,9 +108,9 @@ int main(int ac, char **av)
 		if ((TEST_RETURN == -1) && (TEST_ERRNO == EINVAL)) {
 			tst_resm(TPASS, "Test Passed, Got EINVAL");
 		} else {
-			tst_resm(TFAIL, "Test Failed, sched_get_priority_max()"
-				 " returned %d, errno = %d : %s",
-				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "Test Failed, sched_get_priority_max()"
+				 " returned %ld",
+				 TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
 
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
index cf48ae5..518096e 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
@@ -118,11 +118,9 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s Passed",
 					 test_cases[ind].desc);
 			} else {
-				tst_resm(TFAIL, "%s Failed,"
-					 "sched_get_priority_min() returned %d"
-					 " errno = %d : %s",
-					 test_cases[ind].desc, TEST_RETURN,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "%s Failed,"
+					 "sched_get_priority_min() returned %ld",
+					 test_cases[ind].desc, TEST_RETURN);
 			}
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
index b7b3145..cfd67d4 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
@@ -108,9 +108,9 @@ int main(int ac, char **av)
 		if ((TEST_RETURN == -1) && (TEST_ERRNO == EINVAL)) {
 			tst_resm(TPASS, "Test Passed, Got EINVAL");
 		} else {
-			tst_resm(TFAIL, "Test Failed, sched_get_priority_min()"
-				 " returned %d, errno = %d : %s",
-				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "Test Failed, sched_get_priority_min()"
+				 " returned %ld",
+				 TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
 
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index 9784f05..632aaaa 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -112,11 +112,11 @@ int main(int ac, char **av)
 		 * get 0 for priority value
 		 */
 		if ((TEST_RETURN == 0) && (param.sched_priority == 0)) {
-			tst_resm(TPASS, "sched_getparam() returned %d",
+			tst_resm(TPASS, "sched_getparam() returned %ld",
 				 TEST_RETURN);
 		} else {
 			tst_resm(TFAIL, "Test Failed, sched_getparam()"
-				 "returned %d, errno = %d : %s; returned "
+				 "returned %ld, errno = %d : %s; returned "
 				 "process priority value is %d", TEST_RETURN,
 				 TEST_ERRNO, strerror(TEST_ERRNO),
 				 param.sched_priority);
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
index 911b766..0faaa2d 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 				exit(0);
 			} else {
 				tst_resm(TWARN, "sched_getparam()"
-					 "returned %d, errno = %d : %s;"
+					 "returned %ld, errno = %d : %s;"
 					 " returned process priority value"
 					 " is %d", TEST_RETURN, TEST_ERRNO,
 					 strerror(TEST_ERRNO),
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 5395150..9e0da39 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -107,12 +107,11 @@ int main(int ac, char **av)
 		TEST(sched_rr_get_interval(0, &tp));
 
 		if (TEST_RETURN == 0) {
-			tst_resm(TPASS, "sched_rr_get_interval() returned %d",
+			tst_resm(TPASS, "sched_rr_get_interval() returned %ld",
 				 TEST_RETURN);
 		} else {
-			tst_resm(TFAIL, "Test Failed, sched_rr_get_interval()"
-				 "returned %d, errno = %d : %s", TEST_RETURN,
-				 TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "Test Failed, sched_rr_get_interval()"
+				 "returned %ld", TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 61e50c1..af8f36b 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -113,8 +113,8 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "Test passed");
 		} else {
 			tst_resm(TFAIL, "Test Failed, sched_rr_get_interval()"
-				 "returned %d, errno = %d : %s, tp.tv_sec = %d,"
-				 " tp.tv_nsec = %d", TEST_RETURN, TEST_ERRNO,
+				 "returned %ld, errno = %d : %s, tp.tv_sec = %d,"
+				 " tp.tv_nsec = %ld", TEST_RETURN, TEST_ERRNO,
 				 strerror(TEST_ERRNO), (int)tp.tv_sec,
 				 tp.tv_nsec);
 		}
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 0a12d1c..dc73874 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -134,10 +134,8 @@ int main(int ac, char **av)
 			    (TEST_ERRNO == test_cases[i].exp_errno)) {
 				tst_resm(TPASS, "Test Passed");
 			} else {
-				tst_resm(TFAIL, "Test Failed,"
-					 " sched_rr_get_interval() returned %d,"
-					 " errno = %d : %s", TEST_RETURN,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "Test Failed,"
+					 " sched_rr_get_interval() returned %ld", TEST_RETURN);
 			}
 			TEST_ERROR_LOG(TEST_ERRNO);
 		}
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
index 2f504b7..c708609 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
@@ -104,12 +104,11 @@ int main(int ac, char **av)
 		TEST(sched_setparam(0, &param));
 
 		if (TEST_RETURN == 0) {
-			tst_resm(TPASS, "sched_setparam() returned %d",
+			tst_resm(TPASS, "sched_setparam() returned %ld",
 				 TEST_RETURN);
 		} else {
-			tst_resm(TFAIL, "Test Failed, sched_setparam()"
-				 "returned %d, errno = %d : %s", TEST_RETURN,
-				 TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "Test Failed, sched_setparam()"
+				 "returned %ld", TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
 
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
index 7be63d0..4361dfe 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
@@ -138,10 +138,9 @@ int main(int ac, char **av)
 			if ((TEST_RETURN == 0) && (verify_priority(i))) {
 				tst_resm(TPASS, "%s Passed", testcases[i].desc);
 			} else {
-				tst_resm(TFAIL, "%s Failed. sched_setparam()"
-					 " returned %d, errno: %d; %s",
-					 testcases[i].desc, TEST_RETURN,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "%s Failed. sched_setparam()"
+					 " returned %ld",
+					 testcases[i].desc, TEST_RETURN);
 			}
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index a11d034..39aa3d1 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -127,9 +127,7 @@ int main(int ac, char **av)
 			TEST(sched_setparam(getppid(), &param));
 
 			if (TEST_RETURN == -1) {
-				tst_resm(TWARN, "sched_setparam() returned %d,"
-					 " errno = %d : %s", TEST_RETURN,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
+				tst_resm(TWARN|TTERRNO, "sched_setparam() returned %ld", TEST_RETURN);
 				exit(0);
 			}
 			exit(1);
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
index 7ba2df8..78428a9 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
@@ -145,9 +145,9 @@ int main(int ac, char **av)
 				exit(0);
 			}
 
-			tst_resm(TWARN, "Test failed, sched_setparam()"
-				 " returned : %d, Error number: %d, %s",
-				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TWARN|TTERRNO, "Test failed, sched_setparam()"
+				 " returned : %ld",
+				 TEST_RETURN);
 			TEST_ERROR_LOG(TEST_ERRNO);
 			exit(1);
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index cc9cf2c..f1690c5 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -55,6 +55,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <unistd.h>
+#include <inttypes.h>
 
 #include "usctest.h"
 #include "test.h"
@@ -132,19 +133,19 @@ void do_sendfile(OFF_T offset, int i)
 		if (TEST_RETURN != testcases[i].exp_retval) {
 			tst_resm(TFAIL, "sendfile(2) failed to return "
 				 "expected value, expected: %d, "
-				 "got: %d", testcases[i].exp_retval,
+				 "got: %ld", testcases[i].exp_retval,
 				 TEST_RETURN);
 			kill(child_pid, SIGKILL);
 		} else if (offset != testcases[i].exp_updated_offset) {
 			tst_resm(TFAIL, "sendfile(2) failed to update "
 				 "OFFSET parameter to expected value, "
-				 "expected: %d, got: %d",
-				 testcases[i].exp_updated_offset, offset);
+				 "expected: %d, got: %"PRId64,
+				 testcases[i].exp_updated_offset, (int64_t)offset);
 		} else if (before_pos != after_pos) {
 			tst_resm(TFAIL, "sendfile(2) updated the file position "
-				 " of in_fd unexpectedly, expected file position: %d, "
-				 " actual file position %d",
-				 before_pos, after_pos);
+				 " of in_fd unexpectedly, expected file position: %"PRId64", "
+				 " actual file position %"PRId64,
+				 (int64_t)before_pos, (int64_t)after_pos);
 		} else {
 			tst_resm(TPASS, "functionality of sendfile() is "
 				 "correct");
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 16bf0ce..ce0ee43 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -41,6 +41,7 @@
  * RESTRICTIONS
  *	NONE
  */
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -109,15 +110,15 @@ void do_sendfile(void)
 		shutdown(s, SHUT_RDWR);
 		if (TEST_RETURN != sb.st_size) {
 			tst_resm(TFAIL, "sendfile(2) failed to return "
-				 "expected value, expected: %d, "
-				 "got: %d", sb.st_size, TEST_RETURN);
+				 "expected value, expected: %"PRId64", "
+				 "got: %ld", (int64_t)sb.st_size, TEST_RETURN);
 			kill(child_pid, SIGKILL);
 		} else if (after_pos != sb.st_size) {
 			tst_resm(TFAIL, "sendfile(2) failed to update "
 				 " the file position of in_fd, "
-				 "expected file position: %d, "
-				 "actual file position %d",
-				 sb.st_size, after_pos);
+				 "expected file position: %"PRId64", "
+				 "actual file position %"PRId64,
+				 (int64_t)sb.st_size, (int64_t)after_pos);
 			kill(child_pid, SIGKILL);
 		} else {
 			tst_resm(TPASS, "functionality of sendfile() is "
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index fd15589..c628fa0 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -273,7 +273,7 @@ int main(int argc, char *argv[])
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
 				tst_resm(TFAIL, "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
+					 " %ld (expected %d), errno %d (expected"
 					 " %d)", tdat[testno].desc,
 					 TEST_RETURN, tdat[testno].retval,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c b/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c
index 0aaf2b6..3252363 100644
--- a/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c
+++ b/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c
@@ -115,17 +115,17 @@ int main(int argc, char **argv)
 		if (TEST_RETURN) {
 			if (TEST_ERRNO == EINVAL)
 				tst_resm(TPASS,
-					 "set_robust_list: retval = %d (expected %d), "
+					 "set_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EINVAL);
 			else
 				tst_resm(TFAIL,
-					 "set_robust_list: retval = %d (expected %d), "
+					 "set_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EINVAL);
 		} else {
 			tst_resm(TFAIL,
-				 "set_robust_list: retval = %d (expected %d), "
+				 "set_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, -1,
 				 TEST_ERRNO, EINVAL);
 		}
@@ -138,12 +138,12 @@ int main(int argc, char **argv)
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TPASS,
-				 "set_robust_list: retval = %d (expected %d), "
+				 "set_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, 0,
 				 TEST_ERRNO, 0);
 		} else {
 			tst_resm(TFAIL,
-				 "set_robust_list: retval = %d (expected %d), "
+				 "set_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, 0,
 				 TEST_ERRNO, 0);
 		}
diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index f74979a..07faeec 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -126,7 +126,7 @@ int main(int ac, char **av) {
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
                      TEST(syscall(__NR_set_tid_address, &newtid));     //call set_tid_address()
                      if(TEST_RETURN == getpid()) {
-        		tst_resm(TPASS, "set_tid_address call succeeded:  as expected %d",TEST_RETURN);
+        		tst_resm(TPASS, "set_tid_address call succeeded:  as expected %ld",TEST_RETURN);
                      }
                      else {
                  	   tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index 4fbe071..3214850 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "setdomainname() Failed, errno = %d :"
 				 " %s", TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-			tst_resm(TPASS, "setdomainname() returned %d, "
+			tst_resm(TPASS, "setdomainname() returned %ld, "
 				 "Domain name set to \"%s\"", TEST_RETURN,
 				 test_domain_name);
 		}
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid01.c b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
index e0796e7..348d437 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid01.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
@@ -94,7 +94,7 @@ int main(int ac, char **av)
 		}
 
 		if (TEST_RETURN != gid) {
-			tst_resm(TFAIL, "setfsgid() returned %d, expeceted %d",
+			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
 				 TEST_RETURN, gid);
 		} else {
 			tst_resm(TPASS, "setfsgid() returned expected value : "
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index 2687a16..b94b79d 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -101,11 +101,11 @@ int main(int ac, char **av)
 		}
 
 		if (TEST_RETURN == gid) {
-			tst_resm(TFAIL, "setfsgid() returned %d, expeceted %d",
+			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
 				 TEST_RETURN, gid);
 		} else {
 			tst_resm(TPASS, "setfsgid() returned expected value : "
-				 "%d", TEST_RETURN);
+				 "%ld", TEST_RETURN);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid03.c b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
index 2862882..8dc867d 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid03.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
@@ -104,11 +104,11 @@ int main(int ac, char **av)
 
 		if (TEST_RETURN == gid) {
 			tst_resm(TFAIL,
-				 "setfsgid() returned %d, expeceted anything but %d",
+				 "setfsgid() returned %ld, expected anything but %d",
 				 TEST_RETURN, gid);
 		} else {
 			tst_resm(TPASS, "setfsgid() returned expected value : "
-				 "%d", TEST_RETURN);
+				 "%ld", TEST_RETURN);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 7412e3e..fef0e5f 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 		}
 
 		if (TEST_RETURN != uid) {
-			tst_resm(TFAIL, "setfsuid() returned %d, expected %d",
+			tst_resm(TFAIL, "setfsuid() returned %ld, expected %d",
 				 TEST_RETURN, uid);
 		} else {
 			tst_resm(TPASS, "setfsuid() returned expected value : "
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index d5f51d0..1f83cb8 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -104,11 +104,11 @@ int main(int ac, char **av)
 		}
 
 		if (TEST_RETURN == uid) {
-			tst_resm(TFAIL, "setfsuid() returned %d, expected %d",
+			tst_resm(TFAIL, "setfsuid() returned %ld, expected %d",
 				 TEST_RETURN, uid);
 		} else {
 			tst_resm(TPASS, "setfsuid() returned expected value : "
-				 "%d", TEST_RETURN);
+				 "%ld", TEST_RETURN);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
index 3bbf645..52b578e 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
@@ -107,11 +107,11 @@ int main(int ac, char **av)
 
 		if (TEST_RETURN == uid) {
 			tst_resm(TFAIL,
-				 "setfsuid() returned %d, expected anything but %d",
+				 "setfsuid() returned %ld, expected anything but %d",
 				 TEST_RETURN, uid);
 		} else {
 			tst_resm(TPASS, "setfsuid() returned expected value : "
-				 "%d", TEST_RETURN);
+				 "%ld", TEST_RETURN);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/setgid/setgid01.c b/testcases/kernel/syscalls/setgid/setgid01.c
index a27e3f8..4766420 100644
--- a/testcases/kernel/syscalls/setgid/setgid01.c
+++ b/testcases/kernel/syscalls/setgid/setgid01.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "setgid(%d) returned %d", gid,
+				tst_resm(TPASS, "setgid(%d) returned %ld", gid,
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
index 423c3d7..241032f 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups01.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
@@ -175,7 +175,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setgroups(%d, list) returned %d", len,
+					 "setgroups(%d, list) returned %ld", len,
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 955cbab..baa8163 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -156,7 +156,7 @@ int main(int ac, char **av)
 
 			/* check return code of setgroups(2) */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "setgroups(%d) returned %d, "
+				tst_resm(TFAIL, "setgroups(%d) returned %ld, "
 					 "expected -1, errno=%d", gidsetsize,
 					 TEST_RETURN, Test_cases[i].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
index 1495cf2..09858c2 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
@@ -120,9 +120,9 @@ int main(int ac, char **av)
 		TEST(SETGROUPS(gidsetsize, sbrk(0)));
 		/* check return code of setgroups */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "setgroups() returned %d, "
+			tst_resm(TFAIL, "setgroups() returned %ld, "
 				 "expected -1, errno=%d", TEST_RETURN,
-				 exp_enos);
+				 exp_enos[0]);
 		} else {
 
 			TEST_ERROR_LOG(TEST_ERRNO);
diff --git a/testcases/kernel/syscalls/sethostname/sethostname01.c b/testcases/kernel/syscalls/sethostname/sethostname01.c
index f6a7bd9..8523628 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname01.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "sethostname() failed , errno=%d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-			tst_resm(TPASS, "sethostname() returned %d,"
+			tst_resm(TPASS, "sethostname() returned %ld,"
 				 " Hostname set to \"%s\"", TEST_RETURN,
 				 ltphost);
 		}
diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index 1fd2f38..e35abdf 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "setpgid(%d, %d) returned %d",
+				tst_resm(TPASS, "setpgid(%d, %d) returned %ld",
 					 pid, pgid, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setpgrp/setpgrp01.c b/testcases/kernel/syscalls/setpgrp/setpgrp01.c
index 9b3abc8..19af96a 100644
--- a/testcases/kernel/syscalls/setpgrp/setpgrp01.c
+++ b/testcases/kernel/syscalls/setpgrp/setpgrp01.c
@@ -175,7 +175,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setpgrp -  Call the setpgrp system call returned %d",
+					 "setpgrp -  Call the setpgrp system call returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
index 994e485..4ddd211 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setregid -  Dont change either real or effective gid returned %d",
+					 "setregid -  Dont change either real or effective gid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -205,7 +205,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setregid -  change effective to effective gid returned %d",
+					 "setregid -  change effective to effective gid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -231,7 +231,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setregid -  change real to real gid returned %d",
+					 "setregid -  change real to real gid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -257,7 +257,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setregid -  change effective to real gid returned %d",
+					 "setregid -  change effective to real gid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -283,7 +283,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setregid -  try to change real to current real returned %d",
+					 "setregid -  try to change real to current real returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index dff8144..7844381 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 				}
 			} else {
 				tst_resm(TFAIL, "setregid(%d, %d) "
-					 "did not fail (ret: %d) as expected (ret: -1).",
+					 "did not fail (ret: %ld) as expected (ret: -1).",
 					 *test_data[i].real_gid,
 					 *test_data[i].eff_gid, TEST_RETURN);
 			}
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index db1bc21..36be981 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -141,8 +141,8 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TBROK, "setregid(%d, %d) failed",
-					 test_data[i].real_gid,
-					 test_data[i].eff_gid);
+					 *test_data[i].real_gid,
+					 *test_data[i].eff_gid);
 			} else {
 				/*
 				 * Perform functional verification if test
diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
index 07986f0..61ced2e 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid01.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid01.c
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setreuid -  Don't change either real or effective uid returned %d",
+					 "setreuid -  Don't change either real or effective uid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -205,7 +205,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setreuid -  change effective to effective uid returned %d",
+					 "setreuid -  change effective to effective uid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -231,7 +231,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setreuid -  change real to real uid returned %d",
+					 "setreuid -  change real to real uid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -257,7 +257,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setreuid -  change effective to real uid returned %d",
+					 "setreuid -  change effective to real uid returned %ld",
 					 TEST_RETURN);
 			}
 		}
@@ -283,7 +283,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setreuid -  try to change real to current real returned %d",
+					 "setreuid -  try to change real to current real returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 033d23f..9b992cc 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -136,8 +136,8 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TBROK, "setreuid(%d, %d) failed",
-					 test_data[i].real_uid,
-					 test_data[i].eff_uid);
+					 *test_data[i].real_uid,
+					 *test_data[i].eff_uid);
 			} else {
 				/*
 				 * Perform functional verification if test
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index 3a513b1..ef52833 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -164,7 +164,7 @@ int main(int argc, char *argv[])
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
 				tst_resm(TFAIL, "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
+					 " %ld (expected %d), errno %d (expected"
 					 " %d)", tdat[testno].desc,
 					 TEST_RETURN, tdat[testno].retval,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index d2c850a..0b45187 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -175,7 +175,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setuid -  Set the effective user ID to the current real uid returned %d",
+					 "setuid -  Set the effective user ID to the current real uid returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/setuid/setuid02.c b/testcases/kernel/syscalls/setuid/setuid02.c
index d16611a..4e7140e 100644
--- a/testcases/kernel/syscalls/setuid/setuid02.c
+++ b/testcases/kernel/syscalls/setuid/setuid02.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "setuid -  Set the effective user ID to the current real uid returned %d",
+					 "setuid -  Set the effective user ID to the current real uid returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/sgetmask/sgetmask01.c b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
index 1188e58..6b9aa98 100644
--- a/testcases/kernel/syscalls/sgetmask/sgetmask01.c
+++ b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
@@ -140,12 +140,12 @@ int main(int ac, char **av) {
 
 			for (sig = -3; sig <= SIGRTMAX + 1; sig++){
 				TEST(syscall(__NR_ssetmask,sig));
-                		tst_resm(TINFO,"Setting signal : %d -- return of setmask : %d",sig,TEST_RETURN);     //call sgetmask()
+                		tst_resm(TINFO,"Setting signal : %d -- return of setmask : %ld",sig,TEST_RETURN);     //call sgetmask()
                      		TEST(syscall(__NR_sgetmask));     //call sgetmask()
                      		if(TEST_RETURN != sig) {
-        				tst_resm(TINFO,"Oops,setting sig %d, got %d",sig,TEST_RETURN);
+        				tst_resm(TINFO,"Oops,setting sig %d, got %ld",sig,TEST_RETURN);
                      		} else
-        				tst_resm(TPASS,"OK,setting sig %d, got %d",sig,TEST_RETURN);
+        				tst_resm(TPASS,"OK,setting sig %d, got %ld",sig,TEST_RETURN);
                      		if(sig == SIGRTMAX + 1){
 					cleanup();
 					tst_exit();
diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
index 1fb931a..0ac609b 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 						 "expected.");
 				}
 			} else {
-				tst_resm(TFAIL, "sigaltstack() returned %d, "
+				tst_resm(TFAIL, "sigaltstack() returned %ld, "
 					 "expected -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/signal/signal04.c b/testcases/kernel/syscalls/signal/signal04.c
index 2e3396b..024b16c 100644
--- a/testcases/kernel/syscalls/signal/signal04.c
+++ b/testcases/kernel/syscalls/signal/signal04.c
@@ -147,11 +147,11 @@ int main(int ac, char **av)
 				 */
 				if (rval == first) {
 					tst_resm(TPASS, "%s call succeeded "
-						 "received %d.", TCID, rval);
+						 "received %p.", TCID, rval);
 				} else {
 					tst_brkm(TFAIL, cleanup, "return "
 						 "values for signal(%d) don't "
-						 "match. Got %d, expected %d.",
+						 "match. Got %p, expected %p.",
 						 siglist[i], rval, first);
 				 /*NOTREACHED*/}
 			} else {
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index e2701d6..3ccd86e 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 		} else {
 			tst_brkm(TFAIL, cleanup,
 				 "sigpending() Failed, expected "
-				 "return value=-1, got %d", TEST_RETURN);
+				 "return value=-1, got %ld", TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
 
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index 818c0f1..abe9b05 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -159,9 +159,9 @@ int main(int ac, char **av)
 					 "Received expected return value.");
 			}
 		} else {
-			tst_resm(TFAIL,
-				 "sigsuspend() returned value %d, error:%d",
-				 TEST_RETURN, TEST_ERRNO);
+			tst_resm(TFAIL|TTERRNO,
+				 "sigsuspend() returned value %ld",
+				 TEST_RETURN);
 		}
 
 		Tst_count++;	/* incr TEST_LOOP counter */
diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index 3f15266..90ab18e 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -130,13 +130,12 @@ int main(int ac, char **av)
 
 			/* check return code */
 			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "socketcall() Failed with"
-					 " return=%d, errno=%d : %s",
-					 TEST_RETURN, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "socketcall() Failed with"
+					 " return=%ld",
+					 TEST_RETURN);
 			} else {
 				tst_resm(TPASS, "socketcall() passed for"
-					 " :%s with return=%d ",
+					 " :%s with return=%ld ",
 					 TC[i].desc, TEST_RETURN);
 				close(TEST_RETURN);
 			}
diff --git a/testcases/kernel/syscalls/socketcall/socketcall03.c b/testcases/kernel/syscalls/socketcall/socketcall03.c
index 9cc2de4..de63784 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall03.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall03.c
@@ -127,12 +127,12 @@ int main(int ac, char **av)
 		/* check return code */
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "socketcall() Failed "
-				 " with return=%d,errno=%d: %s",
-				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERNO, "socketcall() Failed "
+				 " with return=%ld",
+				 TEST_RETURN);
 		} else {
 			tst_resm(TPASS, "socketcall() passed "
-				 "for %s with return=%d ",
+				 "for %s with return=%ld ",
 				 TC.desc, TEST_RETURN);
 
 			close(s);
diff --git a/testcases/kernel/syscalls/socketcall/socketcall04.c b/testcases/kernel/syscalls/socketcall/socketcall04.c
index d496f48..45c06b9 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall04.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall04.c
@@ -126,12 +126,12 @@ int main(int ac, char **av)
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "socketcall() Failed "
-				 " with return=%d,errno=%d: %s",
-				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "socketcall() Failed "
+				 " with return=%ld",
+				 TEST_RETURN);
 		} else {
 			tst_resm(TPASS, "socketcall() passed "
-				 "for %s with return=%d ",
+				 "for %s with return=%ld ",
 				 TC.desc, TEST_RETURN);
 			close(s);
 		}
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index d239e93..aa66bc3 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -156,7 +156,7 @@ int main(int argc, char *argv[])
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
 				tst_resm(TFAIL, "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
+					 " %ld (expected %d), errno %d (expected"
 					 " %d)", tdat[testno].desc,
 					 TEST_RETURN, tdat[testno].retval,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index 86e6690..c1af020 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -133,7 +133,7 @@ int main(int ac, char **av)
 			 */
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "splice() returned %d",
+				tst_resm(TPASS, "splice() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 027f81e..db35bbb 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -203,7 +203,7 @@ int main(int ac, char **av)
 				}
 			} else {
 				tst_resm(TFAIL,
-					 "stat(2) returned %d, expected -1, errno:%d",
+					 "stat(2) returned %ld, expected -1, errno:%d",
 					 TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/stat/stat05.c b/testcases/kernel/syscalls/stat/stat05.c
index 0aaa59b..bfef104 100644
--- a/testcases/kernel/syscalls/stat/stat05.c
+++ b/testcases/kernel/syscalls/stat/stat05.c
@@ -176,7 +176,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "stat(%s, &statter) returned %d",
+					 "stat(%s, &statter) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/stat/stat06.c b/testcases/kernel/syscalls/stat/stat06.c
index a6a99e5..3a32888 100644
--- a/testcases/kernel/syscalls/stat/stat06.c
+++ b/testcases/kernel/syscalls/stat/stat06.c
@@ -257,7 +257,7 @@ int main(int ac, char **av)
 					Tst_count++;
 			} else {
 				tst_resm(TFAIL,
-					 "stat(<%s>, &stbuf) returned %d, expected -1, errno:%d",
+					 "stat(<%s>, &stbuf) returned %ld, expected -1, errno:%d",
 					 desc, TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/statfs/statfs01.c b/testcases/kernel/syscalls/statfs/statfs01.c
index 3c671ee..9ad50c6 100644
--- a/testcases/kernel/syscalls/statfs/statfs01.c
+++ b/testcases/kernel/syscalls/statfs/statfs01.c
@@ -183,7 +183,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "statfs(%s, &stats, sizeof(struct statfs), 0) returned %d",
+					 "statfs(%s, &stats, sizeof(struct statfs), 0) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/statfs/statfs03.c b/testcases/kernel/syscalls/statfs/statfs03.c
index 89fa6ff..d05049e 100644
--- a/testcases/kernel/syscalls/statfs/statfs03.c
+++ b/testcases/kernel/syscalls/statfs/statfs03.c
@@ -135,7 +135,7 @@ void setup()
 	/* make a temporary directory and cd to it */
 	tst_tmpdir();
 	if (chmod(TESTDIR, S_IRWXU) == -1)
-		tst_brkm(TBROK, cleanup, "chmod(%S,700) failed; errno %d: %s",
+		tst_brkm(TBROK, cleanup, "chmod(%s,700) failed; errno %d: %s",
 			 TESTDIR, errno, strerror(errno));
 
 	/* create a test file */
diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index e9510a7..d9867d1 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -38,6 +38,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sys/statvfs.h>
+#include <stdint.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -106,13 +107,13 @@ int main(int ac, char **av)
 	tst_resm(TINFO, "This call is similar to statfs");
 	tst_resm(TINFO, "Extracting info about the '%s' file system",
 		 TEST_PATH);
-	tst_resm(TINFO, "file system block size = %u bytes", buf.f_bsize);
-	tst_resm(TINFO, "file system fragment size = %u bytes", buf.f_frsize);
-	tst_resm(TINFO, "file system free blocks = %d", buf.f_bfree);
-	tst_resm(TINFO, "file system total inodes = %u", buf.f_files);
-	tst_resm(TINFO, "file system free inodes = %u", buf.f_ffree);
-	tst_resm(TINFO, "file system id = %u", buf.f_fsid);
-	tst_resm(TINFO, "file system max filename length = %u", buf.f_namemax);
+	tst_resm(TINFO, "file system block size = %lu bytes", buf.f_bsize);
+	tst_resm(TINFO, "file system fragment size = %lu bytes", buf.f_frsize);
+	tst_resm(TINFO, "file system free blocks = %ju", (uintmax_t)buf.f_bfree);
+	tst_resm(TINFO, "file system total inodes = %ju", (uintmax_t)buf.f_files);
+	tst_resm(TINFO, "file system free inodes = %ju", (uintmax_t)buf.f_ffree);
+	tst_resm(TINFO, "file system id = %lu", buf.f_fsid);
+	tst_resm(TINFO, "file system max filename length = %lu", buf.f_namemax);
 
     /***************************************************************
      * cleanup and exit
diff --git a/testcases/kernel/syscalls/stime/stime02.c b/testcases/kernel/syscalls/stime/stime02.c
index 1fdafc1..70bbd2f 100644
--- a/testcases/kernel/syscalls/stime/stime02.c
+++ b/testcases/kernel/syscalls/stime/stime02.c
@@ -132,7 +132,7 @@ int main(int ac, char **av)
 					 TEST_ERRNO, EPERM);
 			}
 		} else {
-			tst_resm(TFAIL, "stime(2) returned %d, expected -1, "
+			tst_resm(TFAIL, "stime(2) returned %ld, expected -1, "
 				 "errno:%d", TEST_RETURN, EPERM);
 		}
 		Tst_count++;	/* incr TEST_LOOP counter */
diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
index 30ba934..0f3aa39 100644
--- a/testcases/kernel/syscalls/symlink/symlink01.c
+++ b/testcases/kernel/syscalls/symlink/symlink01.c
@@ -213,6 +213,7 @@
 #include <utime.h>		/* utime(2) system call */
 #include <sys/param.h>
 #include <sys/stat.h>		/* stat(2) and lstat(2) system calls */
+#include <stdint.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -1408,28 +1409,28 @@ struct all_test_cases *tc_ptr;
 {
 	if (statter.st_dev != asymlink.st_dev)
 		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object device info %ld != stat of object file device info %ld",
-			 statter.st_dev, asymlink.st_dev);
+			 "stat of symbolic link reference to object device info %jd != stat of object file device info %jd",
+			 (intmax_t)statter.st_dev, (intmax_t)asymlink.st_dev);
 
 	else if (statter.st_mode != asymlink.st_mode)
 		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file permissions %ld != stat of object file permissions %ld",
-			 statter.st_mode, asymlink.st_mode);
+			 "stat of symbolic link reference to object file permissions %jd != stat of object file permissions %jd",
+			 (intmax_t)statter.st_mode, (intmax_t)asymlink.st_mode);
 
 	else if (statter.st_nlink != asymlink.st_nlink)
 		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file link count %ld != stat of object file link count %ld",
-			 statter.st_nlink, asymlink.st_nlink);
+			 "stat of symbolic link reference to object file link count %jd != stat of object file link count %jd",
+			 (intmax_t)statter.st_nlink, (intmax_t)asymlink.st_nlink);
 
 	else if (statter.st_uid != asymlink.st_uid)
 		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file uid %ld != stat of object file uid %ld",
-			 statter.st_uid, asymlink.st_uid);
+			 "stat of symbolic link reference to object file uid %jd != stat of object file uid %jd",
+			 (intmax_t)statter.st_uid, (intmax_t)asymlink.st_uid);
 
 	else if (statter.st_gid != asymlink.st_gid)
 		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file gid %ld != stat of object file gid %ld",
-			 statter.st_gid, asymlink.st_gid);
+			 "stat of symbolic link reference to object file gid %jd != stat of object file gid %jd",
+			 (intmax_t)statter.st_gid, (intmax_t)asymlink.st_gid);
 
 	else if (statter.st_size != asymlink.st_size)
 		tst_resm(TFAIL,
@@ -1559,8 +1560,8 @@ struct all_test_cases *tc_ptr;
 							 stbuf.st_nlink);
 					}
 				} else {
-					tst_resm(TFAIL, "%sA lstat of %s (ino:%d) and of\n\t\t\
-%s (ino:%d), does not show them being the same ino.", Buffer, tc_ptr->fn_arg[1], asymlink.st_ino, "nick", statter.st_ino);
+					tst_resm(TFAIL, "%sA lstat of %s (ino:%jd) and of\n\t\t\
+%s (ino:%jd), does not show them being the same ino.", Buffer, tc_ptr->fn_arg[1], (intmax_t)asymlink.st_ino, "nick", (intmax_t)statter.st_ino);
 				}
 			}
 		}
@@ -1691,10 +1692,10 @@ struct all_test_cases *tc_ptr;
 						Tst_count++;
 				else
 					tst_resm(TFAIL,
-						 "%s %s %d greater than original times",
+						 "%s %s %jd greater than original times",
 						 "utime(2) failed to change object file access and",
 						 "modify times through symbolic link to a value",
-						 a_time_value);
+						 (intmax_t)a_time_value);
 			}
 		}
 	}
diff --git a/testcases/kernel/syscalls/sync/sync01.c b/testcases/kernel/syscalls/sync/sync01.c
index 4d1df15..bff3d1c 100644
--- a/testcases/kernel/syscalls/sync/sync01.c
+++ b/testcases/kernel/syscalls/sync/sync01.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "sync() returned %d",
+				tst_resm(TPASS, "sync() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 6453a97..b10dfa8 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 			 */
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "tee() returned %d",
+				tst_resm(TPASS, "tee() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index 036e65f..1b1bfc4 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -168,7 +168,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "time(0) returned %d",
+				tst_resm(TPASS, "time(0) returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/time/time02.c b/testcases/kernel/syscalls/time/time02.c
index b479bb2..0d7c52b 100644
--- a/testcases/kernel/syscalls/time/time02.c
+++ b/testcases/kernel/syscalls/time/time02.c
@@ -73,6 +73,7 @@
 #include <signal.h>
 #include <time.h>
 #include <sys/types.h>
+#include <stdint.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -128,13 +129,13 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				if (tloc == TEST_RETURN) {
 					tst_resm(TPASS, "time() returned value "
-						 "%d, stored value %d are same",
-						 TEST_RETURN, tloc);
+						 "%ld, stored value %jd are same",
+						 TEST_RETURN, (intmax_t)tloc);
 				} else {
 					tst_resm(TFAIL, "time() returned value "
-						 "%d, stored value %d are "
+						 "%ld, stored value %jd are "
 						 "different", TEST_RETURN,
-						 tloc);
+						 (intmax_t)tloc);
 				}
 			} else {
 				tst_resm(TPASS, "call succeeded");
diff --git a/testcases/kernel/syscalls/times/times03.c b/testcases/kernel/syscalls/times/times03.c
index bb3d1eb..fcf0539 100644
--- a/testcases/kernel/syscalls/times/times03.c
+++ b/testcases/kernel/syscalls/times/times03.c
@@ -53,6 +53,7 @@
 #include <test.h>
 #include <usctest.h>
 #include <signal.h>
+#include <stdint.h>
 
 char *TCID = "times03";
 int TST_TOTAL = 1;
@@ -209,21 +210,21 @@ int main(int argc, char **argv)
 					 "user time(%ld) before child "
 					 "> parent's user time (%ld) "
 					 "after child",
-					 buf1.tms_utime, buf2.tms_utime);
+					 (intmax_t)buf1.tms_utime, (intmax_t)buf2.tms_utime);
 				fail = 1;
 			}
 			if (buf2.tms_cutime == 0) {
 				tst_resm(TFAIL, "Error: times() "
 					 "report %ld child user "
 					 "time should be > than "
-					 "zero", buf2.tms_cutime);
+					 "zero", (intmax_t)buf2.tms_cutime);
 				fail = 1;
 			}
 			if (buf2.tms_cstime == 0) {
 				tst_resm(TFAIL, "Error: times() "
 					 "report %ld child system time "
 					 "should be > than zero",
-					 buf2.tms_cstime);
+					 (intmax_t)buf2.tms_cstime);
 				fail = 1;
 			}
 			if (fail == 0) {
diff --git a/testcases/kernel/syscalls/truncate/truncate01.c b/testcases/kernel/syscalls/truncate/truncate01.c
index 78a39ca..9891187 100644
--- a/testcases/kernel/syscalls/truncate/truncate01.c
+++ b/testcases/kernel/syscalls/truncate/truncate01.c
@@ -74,6 +74,7 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+#include <inttypes.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -154,8 +155,8 @@ int main(int ac, char **av)
 				 */
 				if (file_length != TRUNC_LEN) {
 					tst_resm(TFAIL, "%s: Incorrect file "
-						 "size %d, Expected %d",
-						 TESTFILE, file_length,
+						 "size %"PRId64", Expected %d",
+						 TESTFILE, (int64_t)file_length,
 						 TRUNC_LEN);
 				} else {
 					tst_resm(TPASS, "Functionality of "
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 3aa729a..adb8f8b 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -200,7 +200,7 @@ int main(int ac, char **av)
 						 Test_cases[ind].exp_errno);
 				}
 			} else {
-				tst_resm(TFAIL, "truncate() returned %d, "
+				tst_resm(TFAIL, "truncate() returned %ld, "
 					 "expected -1, errno:%d",
 					 TEST_RETURN,
 					 Test_cases[ind].exp_errno);
diff --git a/testcases/kernel/syscalls/truncate/truncate04.c b/testcases/kernel/syscalls/truncate/truncate04.c
index db1ce4b..90034e7 100644
--- a/testcases/kernel/syscalls/truncate/truncate04.c
+++ b/testcases/kernel/syscalls/truncate/truncate04.c
@@ -142,10 +142,10 @@ int main(int ac, char **av)
 			} else {
 				tst_resm(TFAIL, "truncate() fails, %s, "
 					 "errno=%d, expected errno:%d",
-					 test_desc, TEST_ERRNO, exp_enos);
+					 test_desc, TEST_ERRNO, EISDIR);
 			}
 		} else {
-			tst_resm(TFAIL, "truncate() returned %d, "
+			tst_resm(TFAIL, "truncate() returned %ld, "
 				 "expected -1, errno EISDIR", TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/ulimit/ulimit01.c b/testcases/kernel/syscalls/ulimit/ulimit01.c
index 4d098ee..1955bde 100644
--- a/testcases/kernel/syscalls/ulimit/ulimit01.c
+++ b/testcases/kernel/syscalls/ulimit/ulimit01.c
@@ -196,25 +196,23 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				if (Scenarios[i].exp_fail) {
 					if (STD_FUNCTIONAL_TEST) {
-						tst_resm(TPASS,
-							 "ulimit(%d, %d) Failed, errno=%d : %s",
-							 cmd, limit, TEST_ERRNO,
-							 strerror(TEST_ERRNO));
+						tst_resm(TPASS|TTERRNO,
+							 "ulimit(%d, %ld) Failed expectedly",
+							 cmd, limit);
 					}
 				} else {
-					tst_resm(TFAIL,
-						 "ulimit(%d, %d) Failed, errno=%d : %s",
-						 cmd, limit, TEST_ERRNO,
-						 strerror(TEST_ERRNO));
+					tst_resm(TFAIL|TTERRNO,
+						 "ulimit(%d, %ld) Failed",
+						 cmd, limit);
 				}
 			} else {
 				if (Scenarios[i].exp_fail) {
 					tst_resm(TFAIL,
-						 "ulimit(%d, %d) returned %d",
+						 "ulimit(%d, %ld) returned %ld, succeeded unexpectedly",
 						 cmd, limit, TEST_RETURN);
 				} else if (STD_FUNCTIONAL_TEST) {
 					tst_resm(TPASS,
-						 "ulimit(%d, %d) returned %d",
+						 "ulimit(%d, %ld) returned %ld",
 						 cmd, limit, TEST_RETURN);
 				}
 
diff --git a/testcases/kernel/syscalls/umask/umask01.c b/testcases/kernel/syscalls/umask/umask01.c
index 5b66c25..451a412 100644
--- a/testcases/kernel/syscalls/umask/umask01.c
+++ b/testcases/kernel/syscalls/umask/umask01.c
@@ -169,7 +169,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "umask(022) returned %d",
+				tst_resm(TPASS, "umask(022) returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/umask/umask03.c b/testcases/kernel/syscalls/umask/umask03.c
index f5e2a7f..aec6da4 100644
--- a/testcases/kernel/syscalls/umask/umask03.c
+++ b/testcases/kernel/syscalls/umask/umask03.c
@@ -102,7 +102,7 @@ int main(int argc, char **argv)
 					low9mode = statbuf.st_mode & 0777;
 					if (low9mode != (~mskval & 0777)) {
 						tst_resm(TFAIL,
-							 "got %0 expected %o"
+							 "got %o expected %o"
 							 "mask didnot take",
 							 low9mode,
 							 (~mskval & 0777));
diff --git a/testcases/kernel/syscalls/uname/uname01.c b/testcases/kernel/syscalls/uname/uname01.c
index 86c384b..f3111f1 100644
--- a/testcases/kernel/syscalls/uname/uname01.c
+++ b/testcases/kernel/syscalls/uname/uname01.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "uname(&un) returned %d",
+				tst_resm(TPASS, "uname(&un) returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/unlink/unlink05.c b/testcases/kernel/syscalls/unlink/unlink05.c
index 3f84484..ede50fa 100644
--- a/testcases/kernel/syscalls/unlink/unlink05.c
+++ b/testcases/kernel/syscalls/unlink/unlink05.c
@@ -173,7 +173,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "unlink(%s) returned %d", fname,
+				tst_resm(TPASS, "unlink(%s) returned %ld", fname,
 					 TEST_RETURN);
 			}
 			/* recreate file for next loop */
diff --git a/testcases/kernel/syscalls/unlink/unlink06.c b/testcases/kernel/syscalls/unlink/unlink06.c
index e1a378b..18ab1ac 100644
--- a/testcases/kernel/syscalls/unlink/unlink06.c
+++ b/testcases/kernel/syscalls/unlink/unlink06.c
@@ -178,10 +178,10 @@ int main(int ac, char **av)
 		} else if (STD_FUNCTIONAL_TEST) {
 			if (access(Fname, F_OK) != -1) {
 				tst_resm(TFAIL,
-					 "unlink(%s) returned %d, but access says file still exists.",
+					 "unlink(%s) returned %ld, but access says file still exists.",
 					 Fname, TEST_RETURN);
 			} else {
-				tst_resm(TPASS, "unlink(%s) returned %d", Fname,
+				tst_resm(TPASS, "unlink(%s) returned %ld", Fname,
 					 TEST_RETURN);
 			}
 		} else
diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index d53470e..28c373a 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -235,7 +235,7 @@ int main(int ac, char **av)
 					Tst_count++;
 			} else {
 				tst_resm(TFAIL,
-					 "unlink(<%s>) returned %d, expected -1, errno:%d",
+					 "unlink(<%s>) returned %ld, expected -1, errno:%d",
 					 desc, TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index 9fc5129..da4da4b 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -229,12 +229,12 @@ int main(int ac, char **av)
 			} else {
 				if (Test_cases[ind].exp_ret == -1) {
 					tst_resm(TFAIL,
-						 "unlink(<%s>) returned %d, expected -1, errno:%d",
+						 "unlink(<%s>) returned %ld, expected -1, errno:%d",
 						 desc, TEST_RETURN,
 						 Test_cases[ind].exp_errno);
 				} else if (STD_FUNCTIONAL_TEST) {
 					tst_resm(TPASS,
-						 "unlink(<%s>) returned %d",
+						 "unlink(<%s>) returned %ld",
 						 desc, TEST_RETURN);
 				} else
 					Tst_count++;
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 44a5f6d..69c7dd3 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -197,7 +197,7 @@ int main(int ac, char **av)
 							 exp_errno);
 					}
 				} else {
-					tst_resm(TFAIL, "utime(2) returned %d, "
+					tst_resm(TFAIL, "utime(2) returned %ld, "
 						 "expected -1, errno:%d",
 						 TEST_RETURN,
 						 Test_cases[ind].exp_errno);
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 26a79a6..3a7d0b6 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 			 ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "vmsplice() returned %d",
+				tst_resm(TPASS, "vmsplice() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/wait4/wait401.c b/testcases/kernel/syscalls/wait4/wait401.c
index 6009ee8..5f23651 100644
--- a/testcases/kernel/syscalls/wait4/wait401.c
+++ b/testcases/kernel/syscalls/wait4/wait401.c
@@ -136,8 +136,8 @@ int main(int ac, char **av)
 					 "- %d", TCID, WIFEXITED(status));
 			} else if (TEST_RETURN != pid) {
 				tst_resm(TFAIL, "%s did not return the "
-					 "expected value. %d", TCID,
-					 TEST_RETURN);
+					 "expected value (%d), actual: %ld", TCID,
+					 pid, TEST_RETURN);
 			} else {
 
 				tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index 80ea42e..4aaff1e 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -182,7 +182,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "write(%s, F_CLRALF, 1) returned %d",
+					 "write(%s, F_CLRALF, 1) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/writev/writev06.c b/testcases/kernel/syscalls/writev/writev06.c
index 93b404f..ce39841 100644
--- a/testcases/kernel/syscalls/writev/writev06.c
+++ b/testcases/kernel/syscalls/writev/writev06.c
@@ -137,13 +137,13 @@ int main(int argc, char **argv)
 				tst_resm(TINFO, "writev returned %d as expected", 2);
 			} else {
 				tst_resm(TFAIL, "Expected nbytes = %d, got "
-					 "%d", 2, TEST_RETURN);
+					 "%ld", 2, TEST_RETURN);
 				fail = 1;
 			}
 		} else {
 			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL, "Error writev return value = %d,"
-				 " errno = %d", TEST_RETURN, TEST_ERRNO);
+			tst_resm(TFAIL|TTERRNO, "Error writev return value = %ld",
+				 TEST_RETURN);
 			fail = 1;
 		}
 		if (fail) {
diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
index 9a2a657..7638abd 100755
--- a/testcases/kernel/timers/clock_settime/clock_settime03.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
@@ -195,7 +195,7 @@ main(int ac, char **av)
 			} else {
 				tst_resm(TFAIL, "clock_settime(2) failed to"
 						" produce expected error; %d"
-						" , errno : %s and got %d",
+						" , errno : %s and got %ld",
 						testcase[i].exp_errno,
 						testcase[i].exp_errval,
 						TEST_RETURN);
diff --git a/testcases/network/lib6/asapi_04.c b/testcases/network/lib6/asapi_04.c
index fec0044..e29c81f 100644
--- a/testcases/network/lib6/asapi_04.c
+++ b/testcases/network/lib6/asapi_04.c
@@ -287,9 +287,9 @@ static int client(int prot, int sfd)
 		TEST(setsockopt(sd, IPPROTO_IPV6, IPV6_CHECKSUM, &offset,
 				sizeof(offset)));
 		if (TEST_RETURN != cstab[i].cs_setresult) {
-			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
-				"- result %d != %d errno %d", offset, len,
-				TEST_RETURN, cstab[i].cs_setresult, TEST_ERRNO);
+			tst_resm(TFAIL|TTERRNO, "IPV6_CHECKSUM offset %d len %d "
+				"- result %ld != %d", offset, len,
+				TEST_RETURN, cstab[i].cs_setresult);
 			continue;
 		}
 		if (TEST_RETURN < 0) {
@@ -308,9 +308,9 @@ static int client(int prot, int sfd)
 			sizeof(rsin6)));
 		xlen = (cstab[i].cs_sndresult < 0) ? -1 : len;
 		if (TEST_RETURN != xlen) {
-			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
-				"- sndresult %d != %d snderrno %d",
-				offset, len, TEST_RETURN, xlen, TEST_ERRNO);
+			tst_resm(TFAIL|TTERRNO, "IPV6_CHECKSUM offset %d len %d "
+				"- sndresult %ld != %d",
+				offset, len, TEST_RETURN, xlen);
 			continue;
 		}
 		if (TEST_RETURN < 0 && TEST_ERRNO != cstab[i].cs_snderrno) {
diff --git a/testcases/network/lib6/asapi_05.c b/testcases/network/lib6/asapi_05.c
index b521e18..526a813 100644
--- a/testcases/network/lib6/asapi_05.c
+++ b/testcases/network/lib6/asapi_05.c
@@ -389,8 +389,7 @@ icmp6_ft(void)
 		    ftab[i].ft_test != T_WILLPASS) {
 			if (setsockopt(sf, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
 					sizeof(i6f)) < 0) {
-				tst_resm(TFAIL, "%s: setsockopt ICMP6_FILTER:"
-					" %s\n", strerror(errno));
+				tst_resm(TFAIL|TERRNO, "setsockopt ICMP6_FILTER");
 				continue;
 			}
 			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
index 919bf93..cd42197 100644
--- a/testcases/network/lib6/getaddrinfo_01.c
+++ b/testcases/network/lib6/getaddrinfo_01.c
@@ -138,7 +138,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 basic lookup: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -149,7 +149,7 @@ gaiv4(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 basic "
-			"lookup (\"%s\") returns %d (\"%s\")", hostname,
+			"lookup (\"%s\") returns %ld (\"%s\")", hostname,
 			TEST_RETURN, gai_strerror(TEST_RETURN));
 
 	/* test 2, IPv4 canonical name */
@@ -173,7 +173,7 @@ gaiv4(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 "
-			"canonical name (\"%s\") returns %d (\"%s\")",
+			"canonical name (\"%s\") returns %ld (\"%s\")",
 			shortname, TEST_RETURN, gai_strerror(TEST_RETURN));
 
 	/* test 3, IPv4 host+service name */
@@ -206,7 +206,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 host+service: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -217,7 +217,7 @@ gaiv4(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 host+"
-			"service returns %d (\"%s\")", TEST_RETURN,
+			"service returns %ld (\"%s\")", TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
 	/* test 4, IPv4 hostname+service, AI_PASSIVE */
@@ -250,7 +250,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 host+service, PASSIVE"
-				": fam %d alen %d addr 0x%08X addr/fam %d "
+				": fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -261,7 +261,7 @@ gaiv4(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 host+"
-			"service, PASSIVE (\"%s\", \"%s\") returns %d (\"%s\")",
+			"service, PASSIVE (\"%s\", \"%s\") returns %ld (\"%s\")",
 			hostname, service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
@@ -275,7 +275,7 @@ gaiv4(void)
 	TEST(getaddrinfo(hostname, service, &hints, &aires));
 	if (TEST_RETURN != EAI_NONAME) {
 		tst_resm(TFAIL, "getaddrinfo IPv4 AI_NUMERICHOST w/ hostname: "
-				"returns %d expected %d (EAI_NONAME)",
+				"returns %ld expected %d (EAI_NONAME)",
 				TEST_RETURN, EAI_NONAME);
 	} else
 		tst_resm(TPASS, "getaddrinfo IPv4 AI_NUMERICHOST w/ hostname");
@@ -311,7 +311,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 0+service, PASSIVE:"
-				" fam %d alen %d addr 0x%08X addr/fam %d "
+				" fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -323,7 +323,7 @@ gaiv4(void)
 	} else
 		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
 			"getaddrinfo IPv4 0+service, PASSIVE (\"\", \"%s\") "
-			"returns %d (\"%s\")", service, TEST_RETURN,
+			"returns %ld (\"%s\")", service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
 
@@ -356,7 +356,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 0+service: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -367,7 +367,7 @@ gaiv4(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			"getaddrinfo IPv4 0+service (\"\", \"%s\") returns %d "
+			"getaddrinfo IPv4 0+service (\"\", \"%s\") returns %ld "
 			"(\"%s\")", service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
@@ -385,7 +385,7 @@ gaiv4(void)
 	TEST(getaddrinfo(hostname, service, &hints, &aires));
 	if (TEST_RETURN != EAI_NONAME) {
 		tst_resm(TFAIL,"getaddrinfo IPv4 host+service, AI_NUMERICSERV: "
-				"returns %d (\"%s\") expected %d (EAI_NONAME)",
+				"returns %ld (\"%s\") expected %d (EAI_NONAME)",
 				TEST_RETURN, gai_strerror(TEST_RETURN),
 				EAI_NONAME);
 	} else
@@ -444,7 +444,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 socktype 0,513: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -459,7 +459,7 @@ gaiv4(void)
 	} else
 		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
 			"getaddrinfo IPv4 socktype 0,513 (\"\", \"%s\") returns"
-			" %d (\"%s\")", service, TEST_RETURN,
+			" %ld (\"%s\")", service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
 	/* test 11, IPv4 AI_V4MAPPED */
@@ -487,7 +487,7 @@ gaiv4(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 AI_V4MAPPED: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin,
 				psin ? psin->sin_family : 0,
@@ -498,7 +498,7 @@ gaiv4(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 "
-			"AI_V4MAPPED (\"%s\") returns %d (\"%s\")", hostname,
+			"AI_V4MAPPED (\"%s\") returns %ld (\"%s\")", hostname,
 			TEST_RETURN, gai_strerror(TEST_RETURN));
 }
 /* getaddrinfo tests (v6) */
@@ -544,7 +544,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 basic lookup: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -555,7 +555,7 @@ gaiv6(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 basic "
-			"lookup (\"%s\") returns %d (\"%s\")", hostname,
+			"lookup (\"%s\") returns %ld (\"%s\")", hostname,
 			TEST_RETURN, gai_strerror(TEST_RETURN));
 
 	/* test 13, IPv6 canonical name */
@@ -579,7 +579,7 @@ gaiv6(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 "
-			"canonical name (\"%s\") returns %d (\"%s\")",
+			"canonical name (\"%s\") returns %ld (\"%s\")",
 			shortname, TEST_RETURN, gai_strerror(TEST_RETURN));
 
 	/* test 14, IPv6 host+service name */
@@ -612,7 +612,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 host+service: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -623,7 +623,7 @@ gaiv6(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 host+"
-			"service returns %d (\"%s\")", TEST_RETURN,
+			"service returns %ld (\"%s\")", TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
 	/* test 15, IPv6 hostname+service, AI_PASSIVE */
@@ -657,7 +657,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 host+service, PASSIVE"
-				": fam %d alen %d addr 0x%08X addr/fam %d "
+				": fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -668,7 +668,7 @@ gaiv6(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 host+"
-			"service, PASSIVE (\"%s\", \"%s\") returns %d (\"%s\")",
+			"service, PASSIVE (\"%s\", \"%s\") returns %ld (\"%s\")",
 			hostname, service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
@@ -682,7 +682,7 @@ gaiv6(void)
 	TEST(getaddrinfo(hostname, service, &hints, &aires));
 	if (TEST_RETURN != EAI_NONAME) {
 		tst_resm(TFAIL, "getaddrinfo IPv6 AI_NUMERICHOST w/ hostname: "
-				"returns %d expected %d (EAI_NONAME)",
+				"returns %ld expected %d (EAI_NONAME)",
 				TEST_RETURN, EAI_NONAME);
 	} else
 		tst_resm(TPASS, "getaddrinfo IPv6 AI_NUMERICHOST w/ hostname");
@@ -719,7 +719,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 0+service, PASSIVE:"
-				" fam %d alen %d addr 0x%08X addr/fam %d "
+				" fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -731,7 +731,7 @@ gaiv6(void)
 	} else
 		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
 			"getaddrinfo IPv6 0+service, PASSIVE (\"\", \"%s\") "
-			"returns %d (\"%s\")", service, TEST_RETURN,
+			"returns %ld (\"%s\")", service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
 
@@ -765,7 +765,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 0+service: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -776,7 +776,7 @@ gaiv6(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			"getaddrinfo IPv6 0+service (\"\", \"%s\") returns %d "
+			"getaddrinfo IPv6 0+service (\"\", \"%s\") returns %ld "
 			"(\"%s\")", service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
@@ -794,7 +794,7 @@ gaiv6(void)
 	TEST(getaddrinfo(hostname, service, &hints, &aires));
 	if (TEST_RETURN != EAI_NONAME) {
 		tst_resm(TFAIL,"getaddrinfo IPv6 host+service, AI_NUMERICSERV: "
-				"returns %d (\"%s\") expected %d (EAI_NONAME)",
+				"returns %ld (\"%s\") expected %d (EAI_NONAME)",
 				TEST_RETURN, gai_strerror(TEST_RETURN),
 				EAI_NONAME);
 	} else
@@ -854,7 +854,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 socktype 0,513: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -869,7 +869,7 @@ gaiv6(void)
 	} else
 		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
 			"getaddrinfo IPv6 socktype 0,513 (\"\", \"%s\") returns"
-			" %d (\"%s\")", service, TEST_RETURN,
+			" %ld (\"%s\")", service, TEST_RETURN,
 			gai_strerror(TEST_RETURN));
 
 	/* test 22, IPv6 AI_V4MAPPED */
@@ -896,7 +896,7 @@ gaiv6(void)
 		}
 		if (err) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 AI_V4MAPPED: "
-				"fam %d alen %d addr 0x%08X addr/fam %d "
+				"fam %d alen %d addr 0x%p addr/fam %d "
 				"addr/port %d H[%d]",
 				pai->ai_family, pai->ai_addrlen, psin6,
 				psin6 ? psin6->sin6_family : 0,
@@ -907,7 +907,7 @@ gaiv6(void)
 		freeaddrinfo(aires);
 	} else
 		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 "
-			"AI_V4MAPPED (\"%s\") returns %d (\"%s\")", hostname,
+			"AI_V4MAPPED (\"%s\") returns %ld (\"%s\")", hostname,
 			TEST_RETURN, gai_strerror(TEST_RETURN));
 }
 
diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index 9e20e64..da23fbc 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -117,25 +117,25 @@ n2itest()
 		TEST(if_nametoindex(n2i[i].name));
 		fail = !TEST_RETURN != !n2i[i].nonzero;
 		if (fail) {
-			tst_resm(TFAIL, "if_nametoindex(\"%s\") %d "
+			tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
 				"[should be %szero]", n2i[i].name,
 				TEST_RETURN, n2i[i].nonzero ? "non" : "");
 			continue;
 		}
 		if (!TEST_RETURN) {
-			tst_resm(TPASS, "if_nametoindex(\"%s\") %d",
+			tst_resm(TPASS, "if_nametoindex(\"%s\") %ld",
 				n2i[i].name, TEST_RETURN);
 			continue;
 		}
 
 		pifn = if_indextoname(TEST_RETURN, ifname);
 		if (!pifn || strcmp(n2i[i].name, pifn)) {
-			tst_resm(TFAIL, "if_nametoindex(\"%s\") %d doesn't "
-				"match if_indextoname(%d) \"%s\"", n2i[i].name,
+			tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld doesn't "
+				"match if_indextoname(%ld) \"%s\"", n2i[i].name,
 				TEST_RETURN, TEST_RETURN, pifn ? pifn : "");
 			continue;
 		}
-		tst_resm(TPASS, "if_nametoindex(\"%s\") %d", n2i[i].name,
+		tst_resm(TPASS, "if_nametoindex(\"%s\") %ld", n2i[i].name,
 			TEST_RETURN);
 	}
 }
@@ -149,7 +149,7 @@ i2ntest1(unsigned int if_index)
 	TEST((ifname == if_indextoname(if_index, ifname)));
 	if (!TEST_RETURN) {
 		if (TEST_ERRNO != ENXIO) {
-			tst_resm(TFAIL, "if_indextoname(%d) returns %d "
+			tst_resm(TFAIL, "if_indextoname(%d) returns %ld "
 				"but errno %d != ENXIO", if_index, TEST_RETURN,
 				TEST_ERRNO);
 			return 0;
@@ -160,9 +160,9 @@ i2ntest1(unsigned int if_index)
 	/* else, a valid interface-- double check name */
 	idx = if_nametoindex(ifname);
 	if (idx != if_index) {
-		tst_resm(TFAIL, "if_indextoname(%d) returns \"%s\" but "
-			"doesn't if_nametoindex(\"%s\") returns %d",
-			if_index, TEST_RETURN, TEST_RETURN, idx);
+		tst_resm(TFAIL, "if_indextoname(%u) returns \"%s\" but "
+			"doesn't if_nametoindex(\"%s\") returns %u",
+			if_index, ifname, ifname, idx);
 		return 0;
 	}
 	tst_resm(TPASS, "if_indextoname(%d) returns \"%s\"", if_index,
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
