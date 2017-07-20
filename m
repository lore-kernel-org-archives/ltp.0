From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 20 Jul 2017 15:17:25 +0800
Subject: [LTP] [PATCH] syscalls/clone09.c: Fix typo
Message-ID: <20170720071725.3275-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/clone/clone09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index 870c225..629e6c4 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -56,7 +56,7 @@ static long clone_child(void)
 {
 	TEST(ltp_clone(flags, newnet, NULL, CHILD_STACK_SIZE, child_stack));
 
-	if (TEST_RETURN == -1 && TTERRNO == EINVAL)
+	if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL)
 		tst_brk(TCONF, "CLONE_NEWNET not supported, CONFIG_NET_NS?");
 
 	if (TEST_RETURN == -1)
-- 
2.9.4



