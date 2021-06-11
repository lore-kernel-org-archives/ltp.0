From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 16:18:24 +0200
Subject: [LTP] [PATCH] [COMMITTED] ipc/msgctl04: Make use of TST_EXP_FAIL()
Message-ID: <20210611141824.9625-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to simplify the code a bit.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/ipc/msgctl/msgctl04.c     | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index b52ec5636..4b62896fb 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -76,21 +76,10 @@ static void verify_msgctl(unsigned int i)
 		return;
 	}
 
-	TEST(tv->msgctl(*(tc[i].msg_id), tc[i].cmd, tc[i].buf));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgctl() returned %li", TST_RET);
-		return;
-	}
-
-	if (TST_ERR == tc[i].error) {
-		tst_res(TPASS | TTERRNO, "msgctl(%i, %i, %p)",
-			*tc[i].msg_id, tc[i].cmd, tc[i].buf);
-		return;
-	}
-
-	tst_res(TFAIL | TTERRNO, "msgctl(%i, %i, %p) expected %s",
-		*tc[i].msg_id, tc[i].cmd, tc[i].buf, tst_strerrno(tc[i].error));
+	TST_EXP_FAIL(tv->msgctl(*(tc[i].msg_id), tc[i].cmd, tc[i].buf),
+	             tc[i].error,
+	             "msgctl(%i, %i, %p)",
+	             *(tc[i].msg_id), tc[i].cmd, tc[i].buf);
 }
 
 static void setup(void)
-- 
2.31.1

