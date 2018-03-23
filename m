From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Fri, 23 Mar 2018 19:34:48 +0800
Subject: [LTP] [PATCH 1/5] SAFE_MACROS: Add SAFE_SETREUID()/SAFE_SETREGID()
Message-ID: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 include/old/safe_macros.h |  6 ++++++
 include/safe_macros_fn.h  |  8 ++++++++
 include/tst_safe_macros.h |  6 ++++++
 lib/safe_macros.c         | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index e778d30..ad611f7 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -82,6 +82,12 @@
 #define SAFE_SETUID(cleanup_fn, uid) \
 	safe_setuid(__FILE__, __LINE__, cleanup_fn, (uid))
 
+#define SAFE_SETREGID(rgid, egid) \
+	safe_setregid(__FILE__, __LINE__, NULL, (rgid), (egid))
+
+#define SAFE_SETREUID(ruid, euid) \
+	safe_setreuid(__FILE__, __LINE__, NULL, (ruid), (euid))
+
 #define SAFE_GETRESUID(cleanup_fn, ruid, euid, suid) \
 	safe_getresuid(__FILE__, __LINE__, cleanup_fn, (ruid), (euid), (suid))
 
diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 3df9528..001f45c 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -83,6 +83,14 @@ int safe_setgid(const char *file, const int lineno,
 int safe_setuid(const char *file, const int lineno,
                 void (*cleanup_fn)(void), uid_t uid);
 
+int safe_setregid(const char *file, const int lineno,
+		  void (*cleanup_fn)(void),
+		  gid_t rgid, gid_t egid);
+
+int safe_setreuid(const char *file, const int lineno,
+		  void (*cleanup_fn)(void),
+		  uid_t ruid, uid_t euid);
+
 int safe_getresuid(const char *file, const int lineno,
                    void (*cleanup_fn)(void),
                    uid_t *ruid, uid_t *euid, uid_t *suid);
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f115a7b..e378c40 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -109,6 +109,12 @@ static inline int safe_dup(const char *file, const int lineno,
 #define SAFE_SETUID(uid) \
 	safe_setuid(__FILE__, __LINE__, NULL, (uid))
 
+#define SAFE_SETREGID(rgid, egid) \
+	safe_setregid(__FILE__, __LINE__, NULL, (rgid), (egid))
+
+#define SAFE_SETREUID(ruid, euid) \
+	safe_setreuid(__FILE__, __LINE__, NULL, (ruid), (euid))
+
 #define SAFE_GETRESUID(ruid, euid, suid) \
 	safe_getresuid(__FILE__, __LINE__, NULL, (ruid), (euid), (suid))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index abdeca0..0cf3a5f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -318,6 +318,38 @@ int safe_setuid(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
+int safe_setregid(const char *file, const int lineno, void (*cleanup_fn)(void),
+		   gid_t rgid, gid_t egid)
+{
+	int rval;
+
+	rval = setregid(rgid, egid);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: setregid(%p, %p) failed",
+			 file, lineno, rgid, egid);
+	}
+
+	return rval;
+}
+
+
+int safe_setreuid(const char *file, const int lineno, void (*cleanup_fn)(void),
+		   uid_t ruid, uid_t euid)
+{
+	int rval;
+
+	rval = setreuid(ruid, euid);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: setreuid(%p, %p) failed",
+			 file, lineno, ruid, euid);
+	}
+
+	return rval;
+}
+
+
 int safe_getresuid(const char *file, const int lineno, void (*cleanup_fn)(void),
 		   uid_t *ruid, uid_t *euid, uid_t *suid)
 {
-- 
1.8.3.1



