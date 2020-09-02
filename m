From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 2 Sep 2020 12:20:10 +0800
Subject: [LTP] [PATCH] security/dirtyc0w: Add CVE tag
Message-ID: <1599020410-17254-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also use correct fix commit id.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/security/dirtyc0w/dirtyc0w.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index 6455f9cc0..7924285a7 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -4,6 +4,8 @@
  */
 
 /*
+ * CVE-2016-5195
+ *
  * This is a regression test for write race that allows unprivileged programs
  * to change readonly files on the system.
  *
@@ -101,7 +103,8 @@ static struct tst_test test = {
 	.test_all = dirtyc0w_test,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4ceb5db9757a"},
-		{"linux-git", "9be0eaffa3ac"},
+		{"linux-git", "19be0eaffa3a"},
+		{"CVE", "2016-5195"},
 		{}
 	}
 };
-- 
2.23.0



