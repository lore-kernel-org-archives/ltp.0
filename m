From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  5 May 2021 10:18:42 +0200
Subject: [LTP] [PATCH v3 3/6] Add SAFE_IOCTL() variant for library code
In-Reply-To: <20210505081845.7024-1-mdoucha@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
Message-ID: <20210505081845.7024-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SAFE_IOCTL() cannot be implemented as a function due to the variadic argument
but the macro still needs a variant which accepts arbitrary file:line position
for error messages as arguments.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 include/tst_safe_macros.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d6f32ef4c..dcef58bda 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -211,13 +211,16 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 #define SAFE_READDIR(dirp) \
 	safe_readdir(__FILE__, __LINE__, NULL, (dirp))
 
-#define SAFE_IOCTL(fd, request, ...)                         \
+#define SAFE_IOCTL_(file, lineno, fd, request, ...)          \
 	({int tst_ret_ = ioctl(fd, request, ##__VA_ARGS__);  \
 	  tst_ret_ < 0 ?                                     \
-	   tst_brk(TBROK | TERRNO,                           \
+	   tst_brk_((file), (lineno), TBROK | TERRNO,        \
 	            "ioctl(%i,%s,...) failed", fd, #request), 0 \
 	 : tst_ret_;})
 
+#define SAFE_IOCTL(fd, request, ...) \
+	SAFE_IOCTL_(__FILE__, __LINE__, (fd), (request), ##__VA_ARGS__)
+
 #define SAFE_FCNTL(fd, cmd, ...)                            \
 	({int tst_ret_ = fcntl(fd, cmd, ##__VA_ARGS__);     \
 	  tst_ret_ == -1 ?                                  \
-- 
2.31.1

