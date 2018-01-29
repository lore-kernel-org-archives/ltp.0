From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:09 +0300
Subject: [LTP] [PATCH 2/9] lib: add safe_getsockopt() and tst_getsockport()
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_net_fn.h  |    5 +++++
 include/tst_safe_net.h |    6 ++++++
 lib/safe_net.c         |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index ed81463..2a19be8 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -28,9 +28,14 @@
 char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
 		    size_t len);
 
+int tst_getsockport(const char *file, const int lineno, int sockfd);
+
 int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 		int domain, int type, int protocol);
 
+int safe_getsockopt(const char *file, const int lineno, int sockfd, int level,
+		    int optname, void *optval, socklen_t *optlen);
+
 int safe_setsockopt(const char *file, const int lineno, int sockfd, int level,
 		    int optname, const void *optval, socklen_t optlen);
 
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 6c37143..68e9f5c 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -26,9 +26,15 @@
 
 #include "safe_net_fn.h"
 
+#define TST_GETSOCKPORT(sockfd) \
+	tst_getsockport(__FILE__, __LINE__, sockfd)
+
 #define SAFE_SOCKET(domain, type, protocol) \
 	safe_socket(__FILE__, __LINE__, NULL, domain, type, protocol)
 
+#define SAFE_GETSOCKOPT(fd, level, optname, optval, optlen) \
+	safe_getsockopt(__FILE__, __LINE__, fd, level, optname, optval, optlen)
+
 #define SAFE_SETSOCKOPT(fd, level, optname, optval, optlen) \
 	safe_setsockopt(__FILE__, __LINE__, fd, level, optname, optval, optlen)
 
diff --git a/lib/safe_net.c b/lib/safe_net.c
index 23f84fc..9ea9d2b 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -81,6 +81,29 @@ char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
 	}
 }
 
+int tst_getsockport(const char *file, const int lineno, int sockfd)
+{
+	struct sockaddr_storage ss;
+	socklen_t addrlen = sizeof(ss);
+	struct sockaddr *sa = (struct sockaddr *)&ss;
+
+	safe_getsockname(file, lineno, NULL, sockfd, sa, &addrlen);
+
+	switch (sa->sa_family) {
+	case AF_INET: {
+		struct sockaddr_in *sin = (struct sockaddr_in *)sa;
+
+		return ntohs(sin->sin_port);
+	}
+	case AF_INET6: {
+		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
+
+		return ntohs(sin6->sin6_port);
+	} }
+
+	return -1;
+}
+
 int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 		int domain, int type, int protocol)
 {
@@ -97,6 +120,21 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 	return rval;
 }
 
+int safe_getsockopt(const char *file, const int lineno, int sockfd, int level,
+		    int optname, void *optval, socklen_t *optlen)
+{
+	int rval = getsockopt(sockfd, level, optname, optval, optlen);
+
+	if (!rval)
+		return 0;
+
+	tst_brkm(TBROK | TERRNO, NULL,
+		 "%s:%d: getsockopt(%d, %d, %d, %p, %p) failed",
+		 file, lineno, sockfd, level, optname, optval, optlen);
+
+	return rval;
+}
+
 int safe_setsockopt(const char *file, const int lineno, int sockfd, int level,
 		    int optname, const void *optval, socklen_t optlen)
 {
-- 
1.7.1

