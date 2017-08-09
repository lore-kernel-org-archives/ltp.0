From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 9 Aug 2017 16:42:00 +0800
Subject: [LTP] [PATCH] mem/swapping: add missing .forks_child
Message-ID: <1502268120-3003-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 41a2561..5610806 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -154,5 +154,6 @@ static void check_swapping(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
+	.forks_child = 1,
 	.test_all = test_swapping,
 };
-- 
1.8.3.1



