From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  2 Sep 2016 15:24:02 +0300
Subject: [LTP] [PATCH] memcg_process: cleanup the SHM segment
Message-ID: <1472819042-25151-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Let's mark the segment for removal right after we attach it.
This way memcg* test cases will no longer leave unused
segments after they finish.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../controllers/memcg/functional/memcg_process.c   |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index fbb76e2..e2c60de 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -234,9 +234,6 @@ static void shm(void)
 		if (key == -1)
 			err(1, "ftok() failed");
 
-		shmid = shmget(key, memsize, flag);
-		if (shmid == -1)
-			err(1, "shmget() failed");
 		shmctl(shmid, IPC_RMID, NULL);
 
 		shmid = shmget(key, memsize, flag);
@@ -248,12 +245,14 @@ static void shm(void)
 			shmctl(shmid, IPC_RMID, NULL);
 			err(1, "shmat() failed");
 		}
+
+		if (shmctl(shmid, IPC_RMID, NULL) == -1)
+			err(1, "shmctl() failed");
+
 		touch_memory(p, memsize);
 	} else {
 		if (shmdt(p) == -1)
 			err(1, "shmdt() failed");
-		if (shmctl(shmid, IPC_RMID, NULL) == -1)
-			err(1, "shmctl() failed");
 	}
 }
 
-- 
1.7.1

