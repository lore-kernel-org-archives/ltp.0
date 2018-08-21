From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 21 Aug 2018 17:38:57 +0800
Subject: [LTP] [PATCH 2/4] safe_macros: Add SAFE_MLOCK() and SAFE_MUNLOCK()
	macros
In-Reply-To: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1534844339-8655-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  8 ++++++++
 lib/safe_macros.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index a754399..dc6c1f7 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -482,6 +482,14 @@ int safe_mknod(const char *file, const int lineno, const char *pathname,
 #define SAFE_MKNOD(pathname, mode, dev) \
 	safe_mknod(__FILE__, __LINE__, (pathname), (mode), (dev))
 
+int safe_mlock(const char *file, const int lineno, const char *addr,
+	size_t len);
+#define SAFE_MLOCK(addr, len) safe_mlock(__FILE__, __LINE__, (addr), (len))
+
+int safe_munlock(const char *file, const int lineno, const char *addr,
+	size_t len);
+#define SAFE_MUNLOCK(addr, len) safe_munlock(__FILE__, __LINE__, (addr), (len))
+
 int safe_fanotify_init(const char *file, const int lineno,
 	unsigned int flags, unsigned int event_f_flags);
 #define SAFE_FANOTIFY_INIT(fan, mode)  \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 03bd7aa..fa92a6f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1006,3 +1006,31 @@ int safe_mknod(const char *file, const int lineno, const char *pathname,
 
 	return rval;
 }
+
+int safe_mlock(const char *file, const int lineno, const void *addr,
+	size_t len)
+{
+	int rval;
+
+	rval = mlock(addr, len);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: mlock() failed", file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_munlock(const char *file, const int lineno, const void *addr,
+	size_t len)
+{
+	int rval;
+
+	rval = munlock(addr, len);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: munlock() failed", file, lineno);
+	}
+
+	return rval;
+}
-- 
1.8.3.1



