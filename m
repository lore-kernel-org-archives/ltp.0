From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Jan 2017 15:26:22 +0100
Subject: [LTP] [COMMITTED] [PATCH] aio-stress: Fix segfaults
Message-ID: <1485786382-25722-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the memory returned from malloc() contains some garbage, the
t[0].active_opers is not initialized to zero and the testcase segfaults
in oper_list_add() while trying to insert into the linked list:

Program received signal SIGSEGV, Segmentation fault.
0x0000000000401807 in oper_list_add (oper=0x607220, list=0x6070a0) at aio-stress.c:315
315             oper->prev = (*list)->prev;

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 67d8acb..d6d7b08 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1453,6 +1453,7 @@ int main(int ac, char **av)
 		perror("malloc");
 		exit(1);
 	}
+	memset(t, 0, num_threads * sizeof(*t));
 	global_thread_info = t;
 
 	/* by default, allow a huge number of iocbs to be sent towards
-- 
2.7.3

