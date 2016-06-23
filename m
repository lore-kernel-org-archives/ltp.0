From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 23 Jun 2016 10:41:44 +0800
Subject: [LTP] [PATCH] syscalls/waitpid12: break test if fork() failed
Message-ID: <20160623024144.GA29032@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Or this test case will kill a lot of processes on the system (when -1 ends up
passed as a pid to kill()).

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid12.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid12.c b/testcases/kernel/syscalls/waitpid/waitpid12.c
index bf64662..a09323b 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid12.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid12.c
@@ -132,7 +132,7 @@ int main(int argc, char **argv)
 		}
 
 		if (ret_val < 0)
-			tst_resm(TFAIL | TERRNO, "forking kid %d failed",
+			tst_brkm(TFAIL | TERRNO, NULL, "forking kid %d failed",
 				 kid_count);
 
 		/* parent */
-- 
2.5.5

