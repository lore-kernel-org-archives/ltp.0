From: zhao gongyi <zhaogongyi@huawei.com>
Date: Fri, 5 Feb 2021 09:16:35 +0800
Subject: [LTP] [PATCH] ttype: using TERRNO to macth errno
Message-ID: <20210205011635.177469-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use TERRNO because we're not using the TEST() macro.

Signed-off-by: zhao gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/prctl/prctl06.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
index d6517e6b1..21d336c07 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.c
+++ b/testcases/kernel/syscalls/prctl/prctl06.c
@@ -50,14 +50,14 @@ static void do_prctl(void)
 	if (childpid == 0) {
 		check_no_new_privs(1, "After fork, child process", proc_flag);
 		execve(BIN_PATH, childargv, envp);
-		tst_brk(TFAIL | TTERRNO,
+		tst_brk(TFAIL | TERRNO,
 			"child process failed to execute prctl_execve");

 	} else {
 		tst_reap_children();
 		check_no_new_privs(1, "parent process", proc_flag);
 		execve(BIN_PATH, argv, envp);
-		tst_brk(TFAIL | TTERRNO,
+		tst_brk(TFAIL | TERRNO,
 			"parent process failed to execute prctl_execve");
 	}
 }
--
2.17.1

