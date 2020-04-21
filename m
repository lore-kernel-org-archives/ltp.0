From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Apr 2020 14:21:46 +0800
Subject: [LTP] [PATCH 1/3] lib/safe_file_ops: print file info when
 file_lines_scanf parsed fail
Message-ID: <1587450108-31100-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/safe_file_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index b576cb97e..e8ac2fdb8 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -217,7 +217,7 @@ int file_lines_scanf(const char *file, const int lineno,
 
 	if (strict && ret != arg_count) {
 		tst_brkm(TBROK, cleanup_fn, "Expected %i conversions got %i"
-			" at %s:%d", arg_count, ret, file, lineno);
+			" in %s at %s:%d", arg_count, ret, path, file, lineno);
 		return 1;
 	}
 
-- 
2.23.0



