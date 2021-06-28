From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Jun 2021 17:05:05 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/shmget*: Convert into new api
In-Reply-To: <1624512827-3256-3-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YNM4rlDJLzb4xk6v@yuki>
 <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624512827-3256-3-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YNnlIVB9M4/11JmT@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes, thanks.

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index 81841788c..efbc465e1 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -41,7 +41,6 @@ static void setup(void)
 
        queues = SAFE_MALLOC(maxshms * sizeof(int));
        for (num = 0; num < maxshms; num++) {
-               queues[num] = -1;
                res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
                if (res == -1)
                        tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
@@ -59,10 +58,8 @@ static void cleanup(void)
        if (!queues)
                return;
 
-       for (num = 0; num < queue_cnt; num++) {
-               if (queues[num] != -1)
-                       SAFE_SHMCTL(queues[num], IPC_RMID, NULL);
-       }
+       for (num = 0; num < queue_cnt; num++)
+               SAFE_SHMCTL(queues[num], IPC_RMID, NULL);
 
        free(queues);
 }

As there is no need to check for -1 and pre-initialize the array
anymore.

-- 
Cyril Hrubis
chrubis@suse.cz
