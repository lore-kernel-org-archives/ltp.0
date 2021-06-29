From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 18:44:45 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls: Use more accurate TST_EXP_FAIL2 macro
In-Reply-To: <YNHCQ8qWSBdHIAra@yuki>
References: <YNHCQ8qWSBdHIAra@yuki>
Message-ID: <1624963486-6614-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For these modified files, the return value is expected to be non-negative integer
if call passes. So they should use TST_EXP_FAIL2 macro.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/accept/accept01.c             | 2 +-
 testcases/kernel/syscalls/adjtimex/adjtimex02.c         | 2 +-
 testcases/kernel/syscalls/io_getevents/io_getevents01.c | 3 ++-
 testcases/kernel/syscalls/io_submit/io_submit03.c       | 2 +-
 testcases/kernel/syscalls/open/open02.c                 | 2 +-
 testcases/kernel/syscalls/open/open11.c                 | 2 +-
 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c         | 2 +-
 testcases/kernel/syscalls/sendfile/sendfile03.c         | 2 +-
 testcases/kernel/syscalls/sendfile/sendfile04.c         | 2 +-
 9 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 52234b792..85af0f8af 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -97,7 +97,7 @@ void verify_accept(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
 
-	TST_EXP_FAIL(accept(*tcase->fd, tcase->sockaddr, &tcase->salen),
+	TST_EXP_FAIL2(accept(*tcase->fd, tcase->sockaddr, &tcase->salen),
 	             tcase->experrno, "%s", tcase->desc);
 }
 
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 5d8d7019b..747d83254 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -110,7 +110,7 @@ static void verify_adjtimex(unsigned int i)
 		}
 	}
 
-	TST_EXP_FAIL(tv->adjtimex(bufp), tc[i].exp_err, "adjtimex() error");
+	TST_EXP_FAIL2(tv->adjtimex(bufp), tc[i].exp_err, "adjtimex() error");
 
 	if (tc[i].exp_err == EPERM)
 		SAFE_SETEUID(0);
diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents01.c b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
index 9dba4addf..e8a426ab6 100644
--- a/testcases/kernel/syscalls/io_getevents/io_getevents01.c
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
@@ -23,7 +23,8 @@ static void run(void)
 	aio_context_t ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
-	TST_EXP_FAIL(tst_syscall(__NR_io_getevents, ctx, 0, 0, NULL, NULL), EINVAL);
+	TST_EXP_FAIL2(tst_syscall(__NR_io_getevents, ctx, 0, 0, NULL, NULL), EINVAL,
+		"io_getevents syscall with invalid ctx");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/io_submit/io_submit03.c b/testcases/kernel/syscalls/io_submit/io_submit03.c
index 052b0c8cc..90780c0e4 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit03.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit03.c
@@ -103,7 +103,7 @@ static void cleanup(void)
 
 static void run(unsigned int i)
 {
-	TST_EXP_FAIL(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs),
+	TST_EXP_FAIL2(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs),
 		     tc[i].exp_errno, "io_submit() with %s", tc[i].desc);
 }
 
diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index ca9839c2d..67bf423ae 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -49,7 +49,7 @@ static void verify_open(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TST_EXP_FAIL(open(tc->filename, tc->flag, 0444),
+	TST_EXP_FAIL2(open(tc->filename, tc->flag, 0444),
 	             tc->exp_errno, "open() %s", tc->desc);
 }
 
diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index ded384fa8..3c3c11b84 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -278,7 +278,7 @@ static struct test_case {
 static void verify_open(unsigned int n)
 {
 	if (tc[n].err > 0) {
-		TST_EXP_FAIL(open(tc[n].path, tc[n].flags, tc[n].mode),
+		TST_EXP_FAIL2(open(tc[n].path, tc[n].flags, tc[n].mode),
 		             tc[n].err, "%s", tc[n].desc);
 	} else if (tc[n].err == 0) {
 		TST_EXP_FD(open(tc[n].path, tc[n].flags, tc[n].mode),
diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index 10eaa3dcd..fb21ea1e7 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -89,7 +89,7 @@ static void do_test(unsigned int i)
 	else
 		timeout = tst_ts_get(&ts);
 
-	TST_EXP_FAIL(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
+	TST_EXP_FAIL2(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
 	             tc->exp_errno, "recvmmsg() %s", tc->desc);
 }
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile03.c b/testcases/kernel/syscalls/sendfile/sendfile03.c
index dda651703..85a3b0f35 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile03.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile03.c
@@ -50,7 +50,7 @@ static void cleanup(void)
 
 static void run(unsigned int i)
 {
-	TST_EXP_FAIL(sendfile(*(tc[i].out_fd), *(tc[i].in_fd), NULL, 1),
+	TST_EXP_FAIL2(sendfile(*(tc[i].out_fd), *(tc[i].in_fd), NULL, 1),
 		     EBADF, "sendfile(..) with %s", tc[i].desc);
 }
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 8ebeb3c10..9a8ec08b9 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -58,7 +58,7 @@ static void run(unsigned int i)
 	if (tc[i].pass_unmapped_buffer)
 		SAFE_MUNMAP(protected_buffer, sizeof(*protected_buffer));
 
-	TST_EXP_FAIL(sendfile(out_fd, in_fd, protected_buffer, 1),
+	TST_EXP_FAIL2(sendfile(out_fd, in_fd, protected_buffer, 1),
 		     EFAULT, "sendfile(..) with %s, protection=%d",
 		     tc[i].desc, tc[i].protection);
 
-- 
2.23.0

