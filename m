From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 26 Nov 2019 13:02:39 +0100
Subject: [LTP] [PATCH 1/3] Add SAFE_ACCEPT() to LTP safe net library
In-Reply-To: <20191126120241.5460-1-mdoucha@suse.cz>
References: <20191126120241.5460-1-mdoucha@suse.cz>
Message-ID: <20191126120241.5460-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/safe_net_fn.h  |  3 +++
 include/tst_safe_net.h |  3 +++
 lib/safe_net.c         | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index fdbb3791c..2fda11fab 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -57,6 +57,9 @@ int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
 		int socket, int backlog);
 
+int safe_accept(const char *file, const int lineno, void (cleanup_fn)(void),
+		int sockfd, struct sockaddr *addr, socklen_t *addrlen);
+
 int safe_connect(const char *file, const int lineno, void (cleanup_fn)(void),
 		 int sockfd, const struct sockaddr *addr, socklen_t addrlen);
 
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index d49a36073..9bc257ce8 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -64,6 +64,9 @@
 #define SAFE_LISTEN(socket, backlog) \
 	safe_listen(__FILE__, __LINE__, NULL, socket, backlog)
 
+#define SAFE_ACCEPT(sockfd, addr, addrlen) \
+	safe_accept(__FILE__, __LINE__, NULL, sockfd, addr, addrlen)
+
 #define SAFE_CONNECT(sockfd, addr, addrlen) \
 	safe_connect(__FILE__, __LINE__, NULL, sockfd, addr, addrlen)
 
diff --git a/lib/safe_net.c b/lib/safe_net.c
index abebd1899..499368007 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -322,6 +322,22 @@ int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
 	return rval;
 }
 
+int safe_accept(const char *file, const int lineno, void (cleanup_fn)(void),
+		int sockfd, struct sockaddr *addr, socklen_t *addrlen)
+{
+	int rval;
+
+	rval = accept(sockfd, addr, addrlen);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"%s:%d: accept(%d, %p, %d) failed", file, lineno,
+			sockfd, addr, *addrlen);
+	}
+
+	return rval;
+}
+
 int safe_connect(const char *file, const int lineno, void (cleanup_fn)(void),
 		 int sockfd, const struct sockaddr *addr, socklen_t addrlen)
 {
-- 
2.24.0

