From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 17 Mar 2021 12:03:23 +0800
Subject: [LTP] [PATCH] cleanup: Unify the annotation style and remove
 Redundant code
Message-ID: <20210317040323.26899-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change 'Description' to 'DESCRIPTION' and change 'Algorithm' to
'ALGORITHM' and remove Redundant tst_reap_children since tst_reap_children
has been called in the test skeleton.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/containers/pidns/pidns13.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 12aee917b..72aefa82b 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -9,12 +9,12 @@
  */

 /*\
- * [Description]
+ * [DESCRIPTION]
  *
  * The pidns13.c testcase checks container init, for async I/O
  * triggered by peer namespace process.
  *
- * [Algorithm]
+ * [ALGORITHM]
  * * create a pipe in parent namespace
  * * create two PID namespace containers(cinit1 and cinit2)
  * * in cinit1, set pipe read end to send SIGUSR1 for asynchronous I/O
@@ -116,8 +116,6 @@ static void run(void)

 	SAFE_CLOSE(pipe_fd[0]);
 	SAFE_CLOSE(pipe_fd[1]);
-
-	tst_reap_children();
 }

 static struct tst_test test = {
--
2.17.1

