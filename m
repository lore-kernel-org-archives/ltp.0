Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Z4qV1-0007ph-7s
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:01:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z4qUu-0003pB-6m
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:01:55 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 16 Jun 2015 20:24:33 +0800
Message-ID: <1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <5572ED1E.1020203@oracle.com>
References: <5572ED1E.1020203@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/7] SAFE_MACROS: Add socket(), bind(), listen(),
	connect() and getsockname()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: alexey.kodanev@oracle.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/safe_macros.h | 29 ++++++++++++++++++
 lib/safe_macros.c     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 0e7651d..c8601de 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -433,5 +433,34 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 #define SAFE_READDIR(cleanup_fn, dirp) \
 	safe_readdir(__FILE__, __LINE__, (cleanup_fn), (dirp))
 
+int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
+		int domain, int type, int protocol);
+#define SAFE_SOCKET(cleanup_fn, domain, type, protocol) \
+	safe_socket(__FILE__, __LINE__, (cleanup_fn), domain, type, protocol)
+
+int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
+	      int socket, const struct sockaddr *address,
+	      socklen_t address_len);
+#define SAFE_BIND(cleanup_fn, socket, address, address_len) \
+	safe_bind(__FILE__, __LINE__, (cleanup_fn), socket, address, \
+		  address_len)
+
+int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
+		int socket, int backlog);
+#define SAFE_LISTEN(cleanup_fn, socket, backlog) \
+	safe_listen(__FILE__, __LINE__, (cleanup_fn), socket, backlog)
+
+int safe_connect(const char *file, const int lineno, void (cleanup_fn)(void),
+		 int sockfd, const struct sockaddr *addr, socklen_t addrlen);
+#define SAFE_CONNECT(cleanup_fn, sockfd, addr, addrlen) \
+	safe_connect(__FILE__, __LINE__, (cleanup_fn), sockfd, addr, addrlen)
+
+int safe_getsockname(const char *file, const int lineno,
+		     void (cleanup_fn)(void), int sockfd, struct sockaddr *addr,
+		     socklen_t *addrlen);
+#define SAFE_GETSOCKNAME(cleanup_fn, sockfd, addr, addrlen) \
+	safe_getsockname(__FILE__, __LINE__, (cleanup_fn), sockfd, addr, \
+			 addrlen)
+
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a3d997c..5a8e429 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -14,6 +14,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <malloc.h>
+#include <sys/socket.h>
 #include "test.h"
 #include "safe_macros.h"
 
@@ -759,3 +760,85 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 	errno = err;
 	return rval;
 }
+
+int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
+		int domain, int type, int protocol)
+{
+	int rval;
+
+	rval = socket(domain, type, protocol);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		         "%s:%d: socket(%d, %d, %d) failed", file, lineno,
+			 domain, type, protocol);
+	}
+
+	return rval;
+}
+
+int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
+	      int socket, const struct sockaddr *address,
+	      socklen_t address_len)
+{
+	int rval;
+
+	rval = bind(socket, address, address_len);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		         "%s:%d: bind(%d, %p, %d) failed", file, lineno, socket,
+			 address, address_len);
+	}
+
+	return rval;
+}
+
+int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
+		int socket, int backlog)
+{
+	int rval;
+
+	rval = listen(socket, backlog);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		         "%s:%d: listen(%d, %d) failed", file, lineno, socket,
+			 backlog);
+	}
+
+	return rval;
+}
+
+int safe_connect(const char *file, const int lineno, void (cleanup_fn)(void),
+		 int sockfd, const struct sockaddr *addr, socklen_t addrlen)
+{
+	int rval;
+
+	rval = connect(sockfd, addr, addrlen);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		         "%s:%d: connect(%d, %p, %d) failed", file, lineno,
+			 sockfd, addr, addrlen);
+	}
+
+	return rval;
+}
+
+int safe_getsockname(const char *file, const int lineno,
+		     void (cleanup_fn)(void), int sockfd, struct sockaddr *addr,
+		     socklen_t *addrlen)
+{
+	int rval;
+
+	rval = getsockname(sockfd, addr, addrlen);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+		         "%s:%d: getsockname(%d, %p, %p) failed", file, lineno,
+			 sockfd, addr, addrlen);
+	}
+
+	return rval;
+}
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
