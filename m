From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 15:26:44 +0100
Subject: [LTP] [PATCH] [COMMITTED] include/SAFE_IOCTL() fix return value type
Message-ID: <20190318142644.21176-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds the same trick we use for SAFE_FCNTL() to SAFE_IOCTL(), the
added coma + zero forces the return value to be numeric in all cases so
that compiler will work fine in cases that we want to store the
resulting value from SAFE_IOCTL().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Federico Bonfiglio <fedebonfi95@gmail.com>
---
 include/tst_safe_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d31762f4a..5e85abc9c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -221,7 +221,7 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 	({int tst_ret_ = ioctl(fd, request, ##__VA_ARGS__);  \
 	  tst_ret_ < 0 ?                                     \
 	   tst_brk(TBROK | TERRNO,                           \
-	            "ioctl(%i,%s,...) failed", fd, #request) \
+	            "ioctl(%i,%s,...) failed", fd, #request), 0 \
 	 : tst_ret_;})
 
 #define SAFE_FCNTL(fd, cmd, ...)                            \
-- 
2.19.2

