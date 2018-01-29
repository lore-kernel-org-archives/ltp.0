From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:08 +0300
Subject: [LTP] [PATCH 1/9] lib: add safe_sendmsg()
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of strict flag, it requires to pass the actual msg_len for the
sending buffers. In case of zero, the check is skipped similar to the
strict flag in safe_send() and safe_sendto().

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_net_fn.h  |    3 +++
 include/tst_safe_net.h |    3 +++
 lib/safe_net.c         |   22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index 75acf5e..ed81463 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -41,6 +41,9 @@ ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
 		    int sockfd, const void *buf, size_t len, int flags,
 		    const struct sockaddr *dest_addr, socklen_t addrlen);
 
+ssize_t safe_sendmsg(const char *file, const int lineno, size_t msg_len,
+		  int sockfd, const struct msghdr *msg, int flags);
+
 int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 	      int socket, const struct sockaddr *address,
 	      socklen_t address_len);
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 104184d..6c37143 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -45,6 +45,9 @@
 	safe_sendto(__FILE__, __LINE__, strict, fd, buf, len, flags, \
 		    dest_addr, addrlen)
 
+#define SAFE_SENDMSG(msg_len, fd, msg, flags) \
+	safe_sendmsg(__FILE__, __LINE__, msg_len, fd, msg, flags)
+
 #define SAFE_BIND(socket, address, address_len) \
 	safe_bind(__FILE__, __LINE__, NULL, socket, address, \
 		  address_len)
diff --git a/lib/safe_net.c b/lib/safe_net.c
index e48b06d..23f84fc 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -149,6 +149,28 @@ ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
 	return rval;
 }
 
+ssize_t safe_sendmsg(const char *file, const int lineno, size_t len,
+		     int sockfd, const struct msghdr *msg, int flags)
+{
+	ssize_t rval;
+
+	rval = sendmsg(sockfd, msg, flags);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: sendmsg(%d, %p, %d) failed",
+			 file, lineno, sockfd, msg, flags);
+	}
+
+	if (!len && (size_t)rval != len) {
+		tst_brkm(TBROK, NULL,
+			 "%s:%d: sendmsg(%d, %p, %d) ret(%zd) != len(%zu)",
+			 file, lineno, sockfd, msg, flags, rval, len);
+	}
+
+	return rval;
+}
+
 int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 	      int socket, const struct sockaddr *address,
 	      socklen_t address_len)
-- 
1.7.1

