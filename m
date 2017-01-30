From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 30 Jan 2017 17:14:57 +0300
Subject: [LTP] [PATCH 1/2] lib: add safe_setsockopt/send/sendto functions
Message-ID: <1485785698-32053-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_net_fn.h  |   10 +++++++++
 include/tst_safe_net.h |   10 +++++++++
 lib/safe_net.c         |   52 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index 22a40d6..75acf5e 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -31,6 +31,16 @@ char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
 int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 		int domain, int type, int protocol);
 
+int safe_setsockopt(const char *file, const int lineno, int sockfd, int level,
+		    int optname, const void *optval, socklen_t optlen);
+
+ssize_t safe_send(const char *file, const int lineno, char len_strict,
+		  int sockfd, const void *buf, size_t len, int flags);
+
+ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
+		    int sockfd, const void *buf, size_t len, int flags,
+		    const struct sockaddr *dest_addr, socklen_t addrlen);
+
 int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 	      int socket, const struct sockaddr *address,
 	      socklen_t address_len);
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 3ba410a..1fdd5de 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -29,6 +29,16 @@
 #define SAFE_SOCKET(domain, type, protocol) \
 	safe_socket(__FILE__, __LINE__, NULL, domain, type, protocol)
 
+#define SAFE_SETSOCKOPT(fd, level, optname, optval, optlen) \
+	safe_setsockopt(__FILE__, __LINE__, fd, level, optname, optval, optlen)
+
+#define SAFE_SEND(strict, sockfd, buf, len, flags) \
+	safe_send(__FILE__, __LINE__, strict, sockfd, buf, len, flags)
+
+#define SAFE_SENDTO(strict, fd, buf, len, flags, dest_addr, addrlen) \
+	safe_sendto(__FILE__, __LINE__, strict, fd, buf, len, flags, \
+		    dest_addr, addrlen)
+
 #define SAFE_BIND(socket, address, address_len) \
 	safe_bind(__FILE__, __LINE__, NULL, socket, address, \
 		  address_len)
diff --git a/lib/safe_net.c b/lib/safe_net.c
index cae77b5..00149c4 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -97,6 +97,58 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 	return rval;
 }
 
+int safe_setsockopt(const char *file, const int lineno, int sockfd, int level,
+		    int optname, const void *optval, socklen_t optlen)
+{
+	int rval;
+
+	rval = setsockopt(sockfd, level, optname, optval, optlen);
+
+	if (rval) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: setsockopt(%d, %d, %d, %p, %d) failed",
+			 file, lineno, sockfd, level, optname, optval, optlen);
+	}
+
+	return rval;
+}
+
+ssize_t safe_send(const char *file, const int lineno, char len_strict,
+		  int sockfd, const void *buf, size_t len, int flags)
+{
+	ssize_t rval;
+
+	rval = send(sockfd, buf, len, flags);
+
+	if (rval == -1 || (len_strict && (size_t)rval != len)) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: send(%d, %p, %zu, %d) failed",
+			 file, lineno, sockfd, buf, len, flags);
+	}
+
+	return rval;
+}
+
+ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
+		    int sockfd, const void *buf, size_t len, int flags,
+		    const struct sockaddr *dest_addr, socklen_t addrlen)
+{
+	ssize_t rval;
+	char res[128];
+
+	rval = sendto(sockfd, buf, len, flags, dest_addr, addrlen);
+
+	if (rval == -1 || (len_strict && (size_t)rval != len)) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: sendto(%d, %p, %zu, %d, %s, %d) failed",
+			 file, lineno, sockfd, buf, len, flags,
+			 tst_sock_addr(dest_addr, addrlen, res, sizeof(res)),
+			 addrlen);
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

