From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Mar 2018 15:54:26 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe_recvmsg
Message-ID: <20180314145427.2738-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Identical to safe_sendmsg except *msg is not const.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/safe_net_fn.h  |  3 +++
 include/tst_safe_net.h |  3 +++
 lib/safe_net.c         | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index 2a19be875..89e5bf0cc 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -49,6 +49,9 @@ ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
 ssize_t safe_sendmsg(const char *file, const int lineno, size_t msg_len,
 		  int sockfd, const struct msghdr *msg, int flags);
 
+ssize_t safe_recvmsg(const char *file, const int lineno, size_t msg_len,
+		  int sockfd, struct msghdr *msg, int flags);
+
 int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 	      int socket, const struct sockaddr *address,
 	      socklen_t address_len);
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 68e9f5cfb..d0c0a1dc5 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -54,6 +54,9 @@
 #define SAFE_SENDMSG(msg_len, fd, msg, flags) \
 	safe_sendmsg(__FILE__, __LINE__, msg_len, fd, msg, flags)
 
+#define SAFE_RECVMSG(msg_len, fd, msg, flags)		\
+	safe_recvmsg(__FILE__, __LINE__, msg_len, fd, msg, flags)
+
 #define SAFE_BIND(socket, address, address_len) \
 	safe_bind(__FILE__, __LINE__, NULL, socket, address, \
 		  address_len)
diff --git a/lib/safe_net.c b/lib/safe_net.c
index 9ea9d2b42..5ad478795 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -209,6 +209,29 @@ ssize_t safe_sendmsg(const char *file, const int lineno, size_t len,
 	return rval;
 }
 
+ssize_t safe_recvmsg(const char *file, const int lineno, size_t len,
+		     int sockfd, struct msghdr *msg, int flags)
+{
+	ssize_t rval;
+
+	rval = recvmsg(sockfd, msg, flags);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: recvmsg(%d, %p, %d) failed",
+			 file, lineno, sockfd, msg, flags);
+	}
+
+	if (len && (size_t)rval != len) {
+		tst_brkm(TBROK, NULL,
+			 "%s:%d: recvmsg(%d, %p, %d) ret(%zd) != len(%zu)",
+			 file, lineno, sockfd, msg, flags, rval, len);
+	}
+
+	return rval;
+
+}
+
 int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 	      int socket, const struct sockaddr *address,
 	      socklen_t address_len)
-- 
2.16.2

