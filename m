From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Fri, 23 Mar 2018 19:42:57 +0800
Subject: [LTP] [PATCH] syscalls/rmdir02: Use tst_get_bad_addr()
Message-ID: <1521805377-6825-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/rmdir/rmdir02.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index e12f3ee..55123c7 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -98,9 +98,7 @@ static void setup(void)
 
 	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
 		if (tcases[i].exp_errno == EFAULT) {
-			tcases[i].dir = SAFE_MMAP(0, 1, PROT_NONE,
-			                          MAP_PRIVATE | MAP_ANONYMOUS,
-			                          0, 0);
+			tcases[i].dir = tst_get_bad_addr(NULL);
 		}
 	}
 
-- 
1.8.3.1



