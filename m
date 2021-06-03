From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Jun 2021 14:07:52 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/fchown04: Make output nicer
Message-ID: <20210603120752.9110-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Print values not variable names in the TST_EXP_PASS()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fchown/fchown04.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index b2dbbc2cb..a7af3aae7 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -62,7 +62,8 @@ static void run(unsigned int i)
 	UID16_CHECK((uid = geteuid()), "fchown");
 	GID16_CHECK((gid = getegid()), "fchown");
 
-	TST_EXP_FAIL(FCHOWN(*tc[i].fd, uid, gid), tc[i].exp_errno);
+	TST_EXP_FAIL(FCHOWN(*tc[i].fd, uid, gid), tc[i].exp_errno,
+	             "fchown(%i, %i, %i)", *tc[i].fd, uid, gid);
 }
 
 static void cleanup(void)
-- 
2.31.1

