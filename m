From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Mon, 9 Nov 2020 07:34:13 -0500
Subject: [LTP] [PATCH v3] sycalls: select03: Make nfds use the correct value
Message-ID: <1604925253-4765-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running select03 with runltp in /opt/ltp, this case failed as below:
select03.c:52: TFAIL: Invalid readfds: select() passed unexpectedly with 0
select03.c:52: TFAIL: Invalid writefds: select() passed unexpectedly with 0
select03.c:52: TFAIL: Invalid exceptfds: select() passed unexpectedly with 0

ltp-pan will leak file descriptors for logfile, failcmdfile and tconfcmdfile, so
select() cannot monitor invalid file descriptors for test when nfds is set to 6.

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/select/select03.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index ca1b7a5..fb52284 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -16,34 +16,35 @@ static fd_set readfds_reg, writefds_reg, fds_closed;
 static fd_set *preadfds_reg = &readfds_reg, *pwritefds_reg = &writefds_reg;
 static fd_set *pfds_closed = &fds_closed, *nullfds = NULL, *faulty_fds;
 static int fd_closed, fd[2];
+static int negative_nfds = -1, maxfds;
 static struct timeval timeout = {.tv_sec = 0, .tv_usec = 100000};
 
 static struct timeval *valid_to = &timeout, *invalid_to;
 
 static struct tcases {
 	char *name;
-	int nfds;
+	int *nfds;
 	fd_set **readfds;
 	fd_set **writefds;
 	fd_set **exceptfds;
 	struct timeval **timeout;
 	int exp_errno;
 } tests[] = {
-	{ "Negative nfds", -1, &preadfds_reg, &pwritefds_reg, &nullfds, &valid_to, EINVAL },
-	{ "Invalid readfds", 6, &pfds_closed, &pwritefds_reg, &nullfds, &valid_to, EBADF },
-	{ "Invalid writefds", 6, &preadfds_reg, &pfds_closed, &nullfds, &valid_to, EBADF },
-	{ "Invalid exceptfds", 6, &preadfds_reg, &pwritefds_reg, &pfds_closed, &valid_to, EBADF },
-	{ "Faulty readfds", 6, &faulty_fds, &pwritefds_reg, &nullfds, &valid_to, EFAULT },
-	{ "Faulty writefds", 6, &preadfds_reg, &faulty_fds, &nullfds, &valid_to, EFAULT },
-	{ "Faulty exceptfds", 6, &preadfds_reg, &pwritefds_reg, &faulty_fds, &valid_to, EFAULT },
-	{ "Faulty timeout", 6, &preadfds_reg, &pwritefds_reg, &nullfds, &invalid_to, EFAULT },
+	{ "Negative nfds", &negative_nfds, &preadfds_reg, &pwritefds_reg, &nullfds, &valid_to, EINVAL },
+	{ "Invalid readfds", &maxfds, &pfds_closed, &pwritefds_reg, &nullfds, &valid_to, EBADF },
+	{ "Invalid writefds", &maxfds, &preadfds_reg, &pfds_closed, &nullfds, &valid_to, EBADF },
+	{ "Invalid exceptfds", &maxfds, &preadfds_reg, &pwritefds_reg, &pfds_closed, &valid_to, EBADF },
+	{ "Faulty readfds", &maxfds, &faulty_fds, &pwritefds_reg, &nullfds, &valid_to, EFAULT },
+	{ "Faulty writefds", &maxfds, &preadfds_reg, &faulty_fds, &nullfds, &valid_to, EFAULT },
+	{ "Faulty exceptfds", &maxfds, &preadfds_reg, &pwritefds_reg, &faulty_fds, &valid_to, EFAULT },
+	{ "Faulty timeout", &maxfds, &preadfds_reg, &pwritefds_reg, &nullfds, &invalid_to, EFAULT },
 };
 
 static void run(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
 
-	TEST(do_select_faulty_to(tc->nfds, *tc->readfds, *tc->writefds,
+	TEST(do_select_faulty_to(*tc->nfds, *tc->readfds, *tc->writefds,
 				 *tc->exceptfds, *tc->timeout,
 				 tc->timeout == &invalid_to));
 
@@ -81,6 +82,7 @@ static void setup(void)
 
 	SAFE_CLOSE(fd_closed);
 
+	maxfds = fd[1] + 1;
 	faulty_address = tst_get_bad_addr(NULL);
 	invalid_to = faulty_address;
 	faulty_fds = faulty_address;
-- 
1.8.3.1



