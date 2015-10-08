From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 8 Oct 2015 19:29:36 +0800
Subject: [LTP] [PATCH v8 2/7] SAFE_MACROS: Add socket(), bind(), listen(),
	connect() and getsockname()
In-Reply-To: <1444303781-18441-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <20151007132856.GD2608@rei.suse.cz>
 <1444303781-18441-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <1444303781-18441-2-git-send-email-zenglg.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/safe_macros.h |   1 +
 include/safe_net.h    |  60 ++++++++++++++++
 lib/safe_net.c        | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 include/safe_net.h
 create mode 100644 lib/safe_net.c

diff --git a/include/safe_macros.h b/include/safe_macros.h
index cd86931..e938f17 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -28,6 +28,7 @@
 #include <dirent.h>
 
 #include "safe_stdio.h"
+#include "safe_net.h"
 
 char*	safe_basename(const char *file, const int lineno,
 	    void (*cleanup_fn)(void), char *path);
diff --git a/include/safe_net.h b/include/safe_net.h
new file mode 100644
index 0000000..2f8811c
--- /dev/null
+++ b/include/safe_net.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef __SAFE_NET_H__
+#define __SAFE_NET_H__
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <sys/un.h>
+
+char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
+		    size_t len);
+
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
+#endif /* __SAFE_NET_H__ */
diff --git a/lib/safe_net.c b/lib/safe_net.c
new file mode 100644
index 0000000..5703b59
--- /dev/null
+++ b/lib/safe_net.c
@@ -0,0 +1,189 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <errno.h>
+#include "test.h"
+#include "safe_net.h"
+
+char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
+		    size_t len)
+{
+	char portstr[8];
+
+	switch (sa->sa_family) {
+
+	case AF_INET: {
+		struct sockaddr_in *sin = (struct sockaddr_in *)sa;
+
+		if (!inet_ntop(AF_INET, &sin->sin_addr, res, len))
+			return NULL;
+
+		if (ntohs(sin->sin_port) != 0) {
+			snprintf(portstr, sizeof(portstr), ":%d",
+				 ntohs(sin->sin_port));
+			strcat(res, portstr);
+		}
+
+		return res;
+	}
+
+	case AF_INET6: {
+		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
+
+		res[0] = '[';
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, res + 1, len - 1))
+			return NULL;
+
+		if (ntohs(sin6->sin6_port) != 0) {
+			snprintf(portstr, sizeof(portstr), "]:%d",
+				 ntohs(sin6->sin6_port));
+			strcat(res, portstr);
+			return res;
+		}
+
+		return res + 1;
+	}
+
+	case AF_UNIX: {
+		struct sockaddr_un *unp = (struct sockaddr_un *)sa;
+
+		if (unp->sun_path[0] == '\0')
+			strcpy(res, "(no pathname bound)");
+		else
+			snprintf(res, len, "%s", unp->sun_path);
+
+		return res;
+	}
+
+	default: {
+		snprintf(res, len,
+			 "sock_ntop: unknown AF_xxx: %d, len: %d",
+			 sa->sa_family, salen);
+
+		return res;
+	}
+
+	}
+
+	return NULL;
+}
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
+			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
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
+	int i;
+	char buf[128];
+
+	for (i = 0; i < 120; i++) {
+		if (!bind(socket, address, address_len)) {
+			tst_resm(TINFO, "bind is OK now");
+			return 0;
+		}
+
+		if (errno != EADDRINUSE) {
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				 "%s:%d: bind(%d, %s, %d) failed", file, lineno,
+				 socket, tst_sock_addr(address, address_len,
+						       buf, sizeof(buf)),
+				 address_len);
+		}
+
+		if ((i + 1) % 10 == 0) {
+			tst_resm(TINFO, "address is in use, waited %3i sec",
+				 i + 1);
+		}
+
+		sleep(1);
+	}
+
+	tst_brkm(TBROK | TERRNO, cleanup_fn,
+		 "%s:%d: Failed to bind(%d, %s, %d) after 120 retries", file,
+		 lineno, socket,
+		 tst_sock_addr(address, address_len, buf, sizeof(buf)),
+		 address_len);
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
+			 "%s:%d: listen(%d, %d) failed", file, lineno, socket,
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
+	char buf[128];
+
+	rval = connect(sockfd, addr, addrlen);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: connect(%d, %s, %d) failed", file, lineno,
+			 sockfd, tst_sock_addr(addr, addrlen, buf,
+					       sizeof(buf)), addrlen);
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
+	char buf[128];
+
+	rval = getsockname(sockfd, addr, addrlen);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: getsockname(%d, %s, %d) failed", file, lineno,
+			 sockfd, tst_sock_addr(addr, *addrlen, buf,
+					       sizeof(buf)), *addrlen);
+	}
+
+	return rval;
+}
-- 
1.9.3

