From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  5 May 2021 10:18:41 +0200
Subject: [LTP] [PATCH v3 2/6] Add SAFE_RECV() helper function to LTP library
In-Reply-To: <20210505081845.7024-1-mdoucha@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
Message-ID: <20210505081845.7024-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

Changes since v1: None

 include/safe_net_fn.h  |  3 +++
 include/tst_safe_net.h |  3 +++
 lib/safe_net.c         | 25 +++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index 2fda11fab..ff81b1337 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -47,6 +47,9 @@ ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
 ssize_t safe_sendmsg(const char *file, const int lineno, size_t msg_len,
 		  int sockfd, const struct msghdr *msg, int flags);
 
+ssize_t safe_recv(const char *file, const int lineno, size_t len,
+	int sockfd, void *buf, size_t size, int flags);
+
 ssize_t safe_recvmsg(const char *file, const int lineno, size_t msg_len,
 		  int sockfd, struct msghdr *msg, int flags);
 
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 78a488a18..e85b79a3e 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -42,6 +42,9 @@
 #define SAFE_SENDMSG(msg_len, fd, msg, flags) \
 	safe_sendmsg(__FILE__, __LINE__, msg_len, fd, msg, flags)
 
+#define SAFE_RECV(msg_len, fd, buf, size, flags)		\
+	safe_recv(__FILE__, __LINE__, (msg_len), (fd), (buf), (size), (flags))
+
 #define SAFE_RECVMSG(msg_len, fd, msg, flags)		\
 	safe_recvmsg(__FILE__, __LINE__, msg_len, fd, msg, flags)
 
diff --git a/lib/safe_net.c b/lib/safe_net.c
index f9ebea610..211fd9b67 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -273,6 +273,31 @@ ssize_t safe_sendmsg(const char *file, const int lineno, size_t len,
 	return rval;
 }
 
+ssize_t safe_recv(const char *file, const int lineno, size_t len,
+	int sockfd, void *buf, size_t size, int flags)
+{
+	ssize_t rval;
+
+	rval = recv(sockfd, buf, size, flags);
+
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"recv(%d, %p, %zu, %d) failed", sockfd, buf, size,
+			flags);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid recv(%d, %p, %zu, %d) return value %zd",
+			sockfd, buf, size, flags, rval);
+	} else if (len && (size_t)rval != len) {
+		tst_brkm_(file, lineno, TBROK, NULL,
+			"recv(%d, %p, %zu, %d) ret(%zd) != len(%zu)",
+			sockfd, buf, size, flags, rval, len);
+	}
+
+	return rval;
+
+}
+
 ssize_t safe_recvmsg(const char *file, const int lineno, size_t len,
 		     int sockfd, struct msghdr *msg, int flags)
 {
-- 
2.31.1

