From: Li Wang <liwang@redhat.com>
Date: Sat,  7 Apr 2018 17:09:40 +0800
Subject: [LTP] [RFC PATCH] read_all: give more time to wait children finish
	read action
Message-ID: <1523092180-5365-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Some children are still working on the read I/O but parent trys to
stopping them after visit_dir() immediately. Although the stop_attemps
is 65535, it still sometimes fails, so we get the following worker
stalled messges in test.

 # uname -rm
   4.16.0-rc7 ppc64
 # ./read_all -d /sys -q -r 10
   tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
   read_all.c:280: BROK: Worker 26075 is stalled
   read_all.c:280: WARN: Worker 26075 is stalled
   read_all.c:280: WARN: Worker 26079 is stalled
   read_all.c:280: WARN: Worker 26087 is stalled

2. The sched_work() push action in a infinite loop, here I propose to let
it in limited times.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index b7ed540..ab206e7 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -280,6 +280,7 @@ static void stop_workers(void)
 						workers[i].pid);
 					break;
 				}
+				usleep(100);
 			}
 		}
 	}
@@ -306,9 +307,12 @@ static void sched_work(const char *path)
 		if (pushed)
 			break;
 
-		if (++push_attempts > worker_count) {
-			usleep(100);
-			push_attempts = 0;
+		usleep(100);
+		if (++push_attempts > 0xffff) {
+			tst_brk(TBROK,
+				"Attempts %d times but still failed to push %s",
+				push_attempts, path);
+			break;
 		}
 	}
 }
-- 
1.9.3

