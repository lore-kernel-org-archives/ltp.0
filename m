From: Ramon Pantin <pantin@google.com>
Date: Thu, 6 Dec 2018 14:58:25 -0800
Subject: [LTP] added SAFE_SOCKETPAIR()
Message-ID: <515a2ca2-1f68-d2d1-524d-f4fc89be337d@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Ramon Pantin <pantin@google.com>
---
  include/safe_net_fn.h  |  3 +++
  include/tst_safe_net.h |  3 +++
  lib/safe_net.c         | 28 ++++++++++++++++++++++++++++
  3 files changed, 34 insertions(+)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index 89e5bf0cc..3183b2a1c 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -33,6 +33,9 @@ int tst_getsockport(const char *file, const int lineno, int sockfd);
  int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
  		int domain, int type, int protocol);
  
+int safe_socketpair(const char *file, const int lineno, int domain, int type,
+		    int protocol, int sv[]);
+
  int safe_getsockopt(const char *file, const int lineno, int sockfd, int level,
  		    int optname, void *optval, socklen_t *optlen);
  
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index d0c0a1dc5..83a2f27bf 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -32,6 +32,9 @@
  #define SAFE_SOCKET(domain, type, protocol) \
  	safe_socket(__FILE__, __LINE__, NULL, domain, type, protocol)
  
+#define SAFE_SOCKETPAIR(domain, type, protocol, sv) \
+	safe_socketpair(__FILE__, __LINE__, domain, type, protocol, sv)
+
  #define SAFE_GETSOCKOPT(fd, level, optname, optval, optlen) \
  	safe_getsockopt(__FILE__, __LINE__, fd, level, optname, optval, optlen)
  
diff --git a/lib/safe_net.c b/lib/safe_net.c
index 64e2cbcf6..4ab6ae48e 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -132,6 +132,34 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
  	return rval;
  }
  
+int safe_socketpair(const char *file, const int lineno, int domain, int type,
+		    int protocol, int sv[])
+{
+	int rval, ttype;
+
+	rval = socketpair(domain, type, protocol, sv);
+
+	if (rval < 0) {
+		switch (errno) {
+		case EPROTONOSUPPORT:
+		case ESOCKTNOSUPPORT:
+		case EOPNOTSUPP:
+		case EPFNOSUPPORT:
+		case EAFNOSUPPORT:
+			ttype = TCONF;
+			break;
+		default:
+			ttype = TBROK;
+		}
+
+		tst_brkm(ttype | TERRNO, NULL,
+			 "%s:%d: socketpair(%d, %d, %d, %p) failed",
+			 file, lineno, domain, type, protocol, sv);
+	}
+
+	return rval;
+}
+
  int safe_getsockopt(const char *file, const int lineno, int sockfd, int level,
  		    int optname, void *optval, socklen_t *optlen)
  {
-- 
2.20.0.rc2.403.gdbc3b29805-goog


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181206/712d4e6f/attachment.html>
