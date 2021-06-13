From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Sun, 13 Jun 2021 23:19:46 +0530
Subject: [LTP] [PATCH v3] ipc/shmctl02: Make use of TST_EXP_FAIL()
In-Reply-To: <20210609173601.29352-10-vinay.m.engg@gmail.com>
References: <20210609173601.29352-10-vinay.m.engg@gmail.com>
Message-ID: <20210613174946.9804-1-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to simplify the code a bit.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index b9a71722d..9841d3a86 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -96,21 +96,8 @@ static void verify_shmctl(unsigned int i)
 		return;
 	}
 
-	TEST(tv->shmctl(*(tc[i].shm_id), tc[i].cmd, tc[i].buf));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "shmctl() returned %li", TST_RET);
-		return;
-	}
-
-	if (TST_ERR == tc[i].error) {
-		tst_res(TPASS | TTERRNO, "shmctl(%i, %i, %p)",
-				*tc[i].shm_id, tc[i].cmd, tc[i].buf);
-		return;
-	}
-
-	tst_res(TFAIL | TTERRNO, "shmctl(%i, %i, %p) expected %s",
-		*tc[i].shm_id, tc[i].cmd, tc[i].buf, tst_strerrno(tc[i].error));
+	TST_EXP_FAIL(tv->shmctl(*(tc[i].shm_id), tc[i].cmd, tc[i].buf),
+		tc[i].error, "shmctl(%i, %i, %p)", *(tc[i].shm_id), tc[i].cmd, tc[i].buf);
 }
 
 static void setup(void)
-- 
2.17.1

