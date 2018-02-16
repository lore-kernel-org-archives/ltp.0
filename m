From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Feb 2018 14:42:45 +0100
Subject: [LTP] [COMMITTED] [PATCH] pids.sh: Fix spurious failures in test3
	cleanup.
Message-ID: <20180216134245.6499-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes the possitive testcases were failing in cleanup:

kill: (17773): No such process
 1 TBROK: kill -9 17773 failed

The reason is that when we fork pids_task1 the child is running in the
particual subgroup and hence it's pid is in the task file. And since the
child process did only exit(0) there was a race between the process exit
and the stop_pids_task function that read the tasks file.

The fix is obvious, we suspend the pids_task1 child to wait patiently
for it's execution.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/pids/pids_task1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/controllers/pids/pids_task1.c b/testcases/kernel/controllers/pids/pids_task1.c
index 7feae1e07..a7e5d92d3 100644
--- a/testcases/kernel/controllers/pids/pids_task1.c
+++ b/testcases/kernel/controllers/pids/pids_task1.c
@@ -56,5 +56,7 @@ int main(int argc, char **argv)
 		perror("fork() failed");
 		return 1;
 	}
+	if (newpid == 0)
+		pause();
 	return 0;
 }
-- 
2.13.6

