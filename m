From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 2 Mar 2017 18:37:34 +0800
Subject: [LTP] [PATCH 1/3] safe_macros: remove unused code in xattr related
	functions
Message-ID: <1488451056-24535-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/safe_macros.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 42e7d98..6476246 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -803,7 +803,6 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 			tst_brkm(TCONF, NULL,
 				 "%s:%d: no xattr support in fs or mounted "
 				 "without user_xattr option", file, lineno);
-			return rval;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: setxattr() failed",
@@ -825,7 +824,6 @@ int safe_lsetxattr(const char *file, const int lineno, const char *path,
 			tst_brkm(TCONF, NULL,
 				 "%s:%d: no xattr support in fs or mounted "
 				 "without user_xattr option", file, lineno);
-			return rval;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: lsetxattr() failed",
@@ -847,7 +845,6 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 			tst_brkm(TCONF, NULL,
 				 "%s:%d: no xattr support in fs or mounted "
 				 "without user_xattr option", file, lineno);
-			return rval;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: fsetxattr() failed",
-- 
1.8.3.1



