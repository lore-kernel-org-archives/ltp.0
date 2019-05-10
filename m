From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 May 2019 20:31:28 +0200
Subject: [LTP] [RFC PATCH v2 2/6] net: Introduce TST_GET_UNUSED_PORT() macro
	into C API
In-Reply-To: <20190510183132.31039-1-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
Message-ID: <20190510183132.31039-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

into both new and legacy API.
Therefore tst_get_unused_port() was ported into new C API.

Adding TST_GET_UNUSED_PORT() was needed to add support for printing
file and line in error messages passed tst_brkm().

+ deleted lib/tst_net.c (net functions for legacy C API).
+ move tst_* function prototypes in headers to the end
(partly sort alphabetically).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---

TST_GET_UNUSED_PORT() is used in route code, but that's not necessary
("0" would work as well).

 include/old/old_safe_net.h                    |  3 +
 include/old/test.h                            |  7 --
 include/safe_net_fn.h                         | 13 +--
 include/tst_safe_net.h                        |  9 +-
 lib/safe_net.c                                | 66 ++++++++++++++
 lib/tst_net.c                                 | 89 -------------------
 testcases/kernel/syscalls/bind/bind01.c       |  2 +-
 testcases/kernel/syscalls/connect/connect01.c |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |  2 +-
 tools/apicmds/ltpapicmd.c                     |  2 +-
 10 files changed, 87 insertions(+), 108 deletions(-)
 delete mode 100644 lib/tst_net.c

diff --git a/include/old/old_safe_net.h b/include/old/old_safe_net.h
index 609787b32..639094a94 100644
--- a/include/old/old_safe_net.h
+++ b/include/old/old_safe_net.h
@@ -44,4 +44,7 @@
 	safe_getsockname(__FILE__, __LINE__, (cleanup_fn), sockfd, addr, \
 			 addrlen)
 
+#define TST_GET_UNUSED_PORT(cleanup_fn, family, type) \
+	tst_get_unused_port(__FILE__, __LINE__, (cleanup_fn), family, type)
+
 #endif /* OLD_SAFE_NET_H__ */
diff --git a/include/old/test.h b/include/old/test.h
index 0738237e9..604254eea 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -195,13 +195,6 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *dev, const char *fs_type,
 	       const char *const fs_opts[], const char *const extra_opts[]);
 
-/* lib/tst_net.c
- *
- * Return unused port
- */
-unsigned short tst_get_unused_port(void (cleanup_fn)(void),
-	unsigned short family, int type);
-
 /* lib/tst_res.c
  * tst_strsig converts signal's value to corresponding string.
  * tst_strerrno converts errno to corresponding string.
diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index 3183b2a1c..fdbb3791c 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -25,11 +25,6 @@
 #include <arpa/inet.h>
 #include <sys/un.h>
 
-char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
-		    size_t len);
-
-int tst_getsockport(const char *file, const int lineno, int sockfd);
-
 int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 		int domain, int type, int protocol);
 
@@ -72,4 +67,12 @@ int safe_getsockname(const char *file, const int lineno,
 int safe_gethostname(const char *file, const int lineno,
 		     char *name, size_t size);
 
+int tst_getsockport(const char *file, const int lineno, int sockfd);
+
+unsigned short tst_get_unused_port(const char *file, const int lineno,
+	      void (cleanup_fn)(void), unsigned short family, int type);
+
+char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
+		    size_t len);
+
 #endif /* SAFE_NET_FN_H__ */
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 83a2f27bf..d49a36073 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -26,9 +26,6 @@
 
 #include "safe_net_fn.h"
 
-#define TST_GETSOCKPORT(sockfd) \
-	tst_getsockport(__FILE__, __LINE__, sockfd)
-
 #define SAFE_SOCKET(domain, type, protocol) \
 	safe_socket(__FILE__, __LINE__, NULL, domain, type, protocol)
 
@@ -77,4 +74,10 @@
 #define SAFE_GETHOSTNAME(name, size) \
 	safe_gethostname(__FILE__, __LINE__, name, size)
 
+#define TST_GETSOCKPORT(sockfd) \
+	tst_getsockport(__FILE__, __LINE__, sockfd)
+
+#define TST_GET_UNUSED_PORT(family, type) \
+	tst_get_unused_port(__FILE__, __LINE__, NULL, family, type)
+
 #endif /* TST_SAFE_NET_H__ */
diff --git a/lib/safe_net.c b/lib/safe_net.c
index e849d817a..970a2aba3 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -372,3 +372,69 @@ int safe_gethostname(const char *file, const int lineno,
 
 	return rval;
 }
+
+unsigned short tst_get_unused_port(const char *file, const int lineno,
+	      void (cleanup_fn)(void), unsigned short family, int type)
+{
+	int sock;
+	socklen_t slen;
+	struct sockaddr_storage _addr;
+	struct sockaddr *addr = (struct sockaddr *)&_addr;
+	struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
+
+	switch (family) {
+	case AF_INET:
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = 0;
+		addr4->sin_addr.s_addr = INADDR_ANY;
+		slen = sizeof(*addr4);
+		break;
+
+	case AF_INET6:
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = 0;
+		addr6->sin6_addr = in6addr_any;
+		slen = sizeof(*addr6);
+		break;
+
+	default:
+		tst_brkm(TBROK, cleanup_fn,
+			"%s:%d: unknown family", file, lineno);
+		return -1;
+	}
+
+	sock = socket(addr->sa_family, type, 0);
+	if (sock < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: socket failed", file, lineno);
+		return -1;
+	}
+
+	if (bind(sock, addr, slen) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: bind failed", file, lineno);
+		return -1;
+	}
+
+	if (getsockname(sock, addr, &slen) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: getsockname failed", file, lineno);
+		return -1;
+	}
+
+	if (close(sock) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: close failed", file, lineno);
+		return -1;
+	}
+
+	switch (family) {
+	case AF_INET:
+		return addr4->sin_port;
+	case AF_INET6:
+		return addr6->sin6_port;
+	default:
+		return -1;
+	}
+}
diff --git a/lib/tst_net.c b/lib/tst_net.c
deleted file mode 100644
index f842e94a6..000000000
--- a/lib/tst_net.c
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * Copyright (C) 2014 Linux Test Project, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation, Inc.
- */
-
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-
-#include "test.h"
-
-unsigned short tst_get_unused_port(void (cleanup_fn)(void),
-	unsigned short family, int type)
-{
-	int sock;
-	socklen_t slen;
-	struct sockaddr_storage _addr;
-	struct sockaddr *addr = (struct sockaddr *)&_addr;
-	struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
-	struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
-
-	switch (family) {
-	case AF_INET:
-		addr4->sin_family = AF_INET;
-		addr4->sin_port = 0;
-		addr4->sin_addr.s_addr = INADDR_ANY;
-		slen = sizeof(*addr4);
-		break;
-
-	case AF_INET6:
-		addr6->sin6_family = AF_INET6;
-		addr6->sin6_port = 0;
-		addr6->sin6_addr = in6addr_any;
-		slen = sizeof(*addr6);
-		break;
-
-	default:
-		tst_brkm(TBROK, cleanup_fn,
-			"tst_get_unused_port unknown family");
-		return -1;
-	}
-
-	sock = socket(addr->sa_family, type, 0);
-	if (sock < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "socket failed");
-		return -1;
-	}
-
-	if (bind(sock, addr, slen) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "bind failed");
-		return -1;
-	}
-
-	if (getsockname(sock, addr, &slen) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "getsockname failed");
-		return -1;
-	}
-
-	if (close(sock) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "close failed");
-		return -1;
-	}
-
-	switch (family) {
-	case AF_INET:
-		return addr4->sin_port;
-	case AF_INET6:
-		return addr6->sin6_port;
-	default:
-		return -1;
-	}
-}
diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 868749368..d2f50e806 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -152,7 +152,7 @@ void setup(void)
 	/* initialize sockaddr's */
 	sin1.sin_family = AF_INET;
 	/* this port must be unused! */
-	sin1.sin_port = tst_get_unused_port(NULL, AF_INET, SOCK_STREAM);
+	sin1.sin_port = TST_GET_UNUSED_PORT(NULL, AF_INET, SOCK_STREAM);
 	sin1.sin_addr.s_addr = INADDR_ANY;
 
 	sin2.sin_family = AF_INET;
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 34e260f59..0d7d15a83 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -184,7 +184,7 @@ void setup(void)
 
 	sin2.sin_family = AF_INET;
 	/* this port must be unused! */
-	sin2.sin_port = tst_get_unused_port(NULL, AF_INET, SOCK_STREAM);
+	sin2.sin_port = TST_GET_UNUSED_PORT(NULL, AF_INET, SOCK_STREAM);
 	sin2.sin_addr.s_addr = INADDR_ANY;
 
 	sin3.sin_family = AF_INET;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 36f6914ff..cf6e74289 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -662,7 +662,7 @@ static void setup5(void)
 	 * 5-tuple than already connected
 	 */
 	sin2 = sin1;
-	sin2.sin_port = tst_get_unused_port(cleanup, AF_INET, SOCK_STREAM);
+	sin2.sin_port = TST_GET_UNUSED_PORT(cleanup, AF_INET, SOCK_STREAM);
 }
 
 static void setup6(void)
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 4b66c4226..d94061242 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -213,7 +213,7 @@ unsigned short apicmd_get_unused_port(int argc, char *argv[])
 		if (!p[i]->cmd)
 			goto err;
 	}
-	return  tst_get_unused_port(NULL, p[0]->value, p[1]->value);
+	return  TST_GET_UNUSED_PORT(NULL, p[0]->value, p[1]->value);
 
 err:
 	fprintf(stderr, "Usage: tst_get_unused_port FAMILY TYPE\n"
-- 
2.21.0

