From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 1 Apr 2021 05:00:08 +0000
Subject: [LTP] [PATCH v3] syscalls/ipc: Check that whether if kernel
 supports *_STAT_ANY
In-Reply-To: <20210330063200.23654-1-zhaogongyi@huawei.com>
References: <20210330063200.23654-1-zhaogongyi@huawei.com>
Message-ID: <60655364.3080900@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi

Merged with following changes, thanks!

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index badbaaede..6f5476383 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -152,10 +152,8 @@ static void setup(void)
  			tst_brk(TCONF, "kernel doesn't support MSG_STAT_ANY");
  		else
  			tst_brk(TBROK | TTERRNO,
-					"Current environment doesn't permit "
-					"MSG_STAT_ANY");
+				"Current environment doesn't permit MSG_STAT_ANY");
  	}
-
  }

  static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index b40f5ba8b..efbc67f33 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -196,18 +196,15 @@ static void setup(void)

  	TEST(do_semctl(sem_id, 0, SEM_STAT_ANY));
  	if (TST_RET == -1) {
-		if (errno == EFAULT)
-			tst_brk(TFAIL, "SEM_STAT_ANY doesn't pass the buffer "
-					"specified by the caller to kernel");
+		if (TST_ERR == EFAULT)
+			tst_brk(TFAIL,
+				"SEM_STAT_ANY doesn't pass the buffer specified by the caller to kernel");
  		if (TST_ERR == EINVAL)
-			tst_brk(TCONF, "kernel doesn't support "
-					"SEM_STAT_ANY");
+			tst_brk(TCONF, "kernel doesn't support SEM_STAT_ANY");
  		else
  			tst_brk(TBROK | TTERRNO,
-					"Current environment doesn't permit "
-					"SEM_STAT_ANY");
+				"Current environment doesn't permit SEM_STAT_ANY");
  	}
-
  }

  static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 9a60c5170..724610ef0 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -164,12 +164,10 @@ static void setup(void)
  	TEST(shmctl(shm_id, SHM_STAT_ANY,&temp_ds));
  	if (TST_RET == -1) {
  		if (TST_ERR == EINVAL)
-			tst_brk(TCONF, "kernel doesn't support "
-					"SHM_STAT_ANY");
+			tst_brk(TCONF, "kernel doesn't support SHM_STAT_ANY");
  		else
  			tst_brk(TBROK | TTERRNO,
-					"Current environment doesn't permit "
-					"SHM_STAT_ANY");
+				"Current environment doesn't permit SHM_STAT_ANY");
  	}
  }


