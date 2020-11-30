From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 30 Nov 2020 10:51:55 +0800
Subject: [LTP] [COMMITTED] docparse/README.md: Fix root uid value typo
Message-ID: <1606704715-2344-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 docparse/README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/README.md b/docparse/README.md
index 7e4847ba2..2c2541760 100644
--- a/docparse/README.md
+++ b/docparse/README.md
@@ -130,7 +130,7 @@ bitflags, integers or arrays of strings:
 ```c
 struct tst_test test = {
 	...
-	/* tests needs to run with UID=1 */
+	/* tests needs to run with UID=0 */
 	.needs_root = 1,
 
 	/*
-- 
2.23.0



