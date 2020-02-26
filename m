From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 26 Feb 2020 18:26:20 +0100
Subject: [LTP] [PATCH v1] Stringify flags to improve error msg of unshare()
Message-ID: <20200226172620.29815-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If your test has multiple calls of unshare() it is hard to read which
unshare() call really failed. With this we improve the error message to
something like this:

  sendmsg03.c:43: CONF: unshare(CLONE_NEWUSER) unsupported: EINVAL (22)

Instead of having a hard to understand number like:

  sendmsg03.c:43: CONF: unshare(268435456) unsupported: EINVAL (22)

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_safe_macros.h | 5 +++--
 lib/tst_safe_macros.c     | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 80c4d9cb9..f2f8bd10f 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -544,7 +544,8 @@ int safe_personality(const char *filename, unsigned int lineno,
 	}							\
 	} while (0)
 
-void safe_unshare(const char *file, const int lineno, int flags);
-#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
+void safe_unshare(const char *file, const int lineno, const char *flags_str,
+	int flags);
+#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, #flags, (flags))
 
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index f5413a18e..01270de2b 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -187,7 +187,8 @@ int safe_chroot(const char *file, const int lineno, const char *path)
 	return rval;
 }
 
-void safe_unshare(const char *file, const int lineno, int flags)
+void safe_unshare(const char *file, const int lineno, const char *flags_str,
+		  int flags)
 {
 	int res;
 
@@ -195,10 +196,10 @@ void safe_unshare(const char *file, const int lineno, int flags)
 	if (res == -1) {
 		if (errno == EINVAL) {
 			tst_brk_(file, lineno, TCONF | TERRNO,
-				 "unshare(%d) unsupported", flags);
+				 "unshare(%s) unsupported", flags_str);
 		} else {
 			tst_brk_(file, lineno, TBROK | TERRNO,
-				 "unshare(%d) failed", flags);
+				 "unshare(%s) failed", flags_str);
 		}
 	}
 }
-- 
2.16.4

