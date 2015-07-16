Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZFbkU-0004oV-4I
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFbkR-0000of-Md
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:22 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 13:30:37 +0800
Message-ID: <1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <55A680FC.2010807@oracle.com>
References: <55A680FC.2010807@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 01/11] SAFE_MACROS: Add socket(), bind(), listen(),
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
 include/safe_macros.h |   1 +
 include/safe_net.h    |  54 +++++++++++++++++++++++
 lib/safe_net.c        | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 include/safe_net.h
 create mode 100644 lib/safe_net.c

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 0e7651d..1a09af6 100644
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
index 0000000..2c9ddb6
--- /dev/null
+++ b/include/safe_net.h
@@ -0,0 +1,54 @@
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
index 0000000..48c4056
--- /dev/null
+++ b/lib/safe_net.c
@@ -0,0 +1,119 @@
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
+	int err, ret, i;
+
+	for (i = 0; i < 30; i++) {
+		ret = bind(socket, address, address_len);
+		err = errno;
+
+		if (!ret)
+			return 0;
+
+		if (err != EADDRINUSE) {
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				 "%s:%d: bind(%d, %p, %d) failed", file, lineno,
+				 socket, address, address_len);
+		}
+
+		tst_resm(TINFO, "bind('%p') failed with %s, try %2i...",
+			 address, tst_strerrno(err), i+1);
+
+		if (i == 0 && err == EADDRINUSE)
+			tst_resm(TINFO, "The given address is already in use.");
+
+		usleep(1000000);
+	}
+
+	tst_brkm(TBROK | TERRNO, cleanup_fn,
+		 "%s:%d: Failed to bind(%d, %p, %d) after 30 retries",
+		 file, lineno, socket, address, address_len);
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
+
+	rval = connect(sockfd, addr, addrlen);
+
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: connect(%d, %p, %d) failed", file, lineno,
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
+			 "%s:%d: getsockname(%d, %p, %p) failed", file, lineno,
+			 sockfd, addr, addrlen);
+	}
+
+	return rval;
+}
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
