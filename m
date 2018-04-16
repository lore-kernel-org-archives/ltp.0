From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Apr 2018 16:51:39 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] tst_safe_macros: SAFE_{IOCTL,
	FCNTL} prefix variable
Message-ID: <20180416145140.10547-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Prefix local variable ret with tst_ to avoid accidental aliasing.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f115a7baf..b4aa46705 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -201,18 +201,18 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 	safe_readdir(__FILE__, __LINE__, NULL, (dirp))
 
 #define SAFE_IOCTL(fd, request, ...)                         \
-	({int ret = ioctl(fd, request, ##__VA_ARGS__);       \
-	  ret < 0 ?                                          \
+	({int tst_ret_ = ioctl(fd, request, ##__VA_ARGS__);  \
+	  tst_ret_ < 0 ?                                     \
 	   tst_brk(TBROK | TERRNO,                           \
 	            "ioctl(%i,%s,...) failed", fd, #request) \
-	 : ret;})
+	 : tst_ret_;})
 
 #define SAFE_FCNTL(fd, cmd, ...)                            \
-	({int ret = fcntl(fd, cmd, ##__VA_ARGS__);          \
-	  ret == -1 ?                                       \
+	({int tst_ret_ = fcntl(fd, cmd, ##__VA_ARGS__);     \
+	  tst_ret_ == -1 ?                                  \
 	   tst_brk(TBROK | TERRNO,                          \
 	            "fcntl(%i,%s,...) failed", fd, #cmd), 0 \
-	 : ret;})
+	 : tst_ret_;})
 
 /*
  * following functions are inline because the behaviour may depend on
-- 
2.13.6

