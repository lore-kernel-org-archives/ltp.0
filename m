From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Jun 2016 19:00:54 +0300
Subject: [LTP] [PATCH v2 1/2] lib: add safe_gethostname()
Message-ID: <1467129655-9110-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: remove cleanup()

 include/safe_net_fn.h  |    3 +++
 include/tst_safe_net.h |    3 +++
 lib/safe_net.c         |   14 ++++++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index e85842b..22a40d6 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -45,4 +45,7 @@ int safe_getsockname(const char *file, const int lineno,
 		     void (cleanup_fn)(void), int sockfd, struct sockaddr *addr,
 		     socklen_t *addrlen);
 
+int safe_gethostname(const char *file, const int lineno,
+		     char *name, size_t size);
+
 #endif /* SAFE_NET_FN_H__ */
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 98dcfa5..3ba410a 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -43,4 +43,7 @@
 	safe_getsockname(__FILE__, __LINE__, NULL, sockfd, addr, \
 			 addrlen)
 
+#define SAFE_GETHOSTNAME(name, size) \
+	safe_gethostname(__FILE__, __LINE__, name, size)
+
 #endif /* TST_SAFE_NET_H__ */
diff --git a/lib/safe_net.c b/lib/safe_net.c
index 98a79cf..cae77b5 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -183,3 +183,17 @@ int safe_getsockname(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_gethostname(const char *file, const int lineno,
+		     char *name, size_t size)
+{
+	int rval = gethostname(name, size);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: gethostname(%p, %zu) failed",
+			 file, lineno, name, size);
+	}
+
+	return rval;
+}
-- 
1.7.1

