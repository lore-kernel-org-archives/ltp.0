From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Thu, 5 Nov 2020 06:17:14 -0500
Subject: [LTP] [PATCH v2] sycalls: select03: Make nfds use the correct value
Message-ID: <1604575034-17799-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running select03 with runltp in /opt/ltp, this case failed as below:
select03.c:52: TFAIL: Invalid readfds: select() passed unexpectedly with 0
select03.c:52: TFAIL: Invalid writefds: select() passed unexpectedly with 0
select03.c:52: TFAIL: Invalid exceptfds: select() passed unexpectedly with 0

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/select/select03.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index ca1b7a5..099b622 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -29,21 +29,21 @@ static struct tcases {
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
+	{ "Negative nfds", 0, &preadfds_reg, &pwritefds_reg, &nullfds, &valid_to, EINVAL },
+	{ "Invalid readfds", 1, &pfds_closed, &pwritefds_reg, &nullfds, &valid_to, EBADF },
+	{ "Invalid writefds", 1, &preadfds_reg, &pfds_closed, &nullfds, &valid_to, EBADF },
+	{ "Invalid exceptfds", 1, &preadfds_reg, &pwritefds_reg, &pfds_closed, &valid_to, EBADF },
+	{ "Faulty readfds", 1, &faulty_fds, &pwritefds_reg, &nullfds, &valid_to, EFAULT },
+	{ "Faulty writefds", 1, &preadfds_reg, &faulty_fds, &nullfds, &valid_to, EFAULT },
+	{ "Faulty exceptfds", 1, &preadfds_reg, &pwritefds_reg, &faulty_fds, &valid_to, EFAULT },
+	{ "Faulty timeout", 1, &preadfds_reg, &pwritefds_reg, &nullfds, &invalid_to, EFAULT },
 };
 
 static void run(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
 
-	TEST(do_select_faulty_to(tc->nfds, *tc->readfds, *tc->writefds,
+	TEST(do_select_faulty_to(tc->nfds ? fd[1] + 1 : -1, *tc->readfds, *tc->writefds,
 				 *tc->exceptfds, *tc->timeout,
 				 tc->timeout == &invalid_to));
 
-- 
1.8.3.1



