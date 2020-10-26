From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:43 +0100
Subject: [LTP] [PATCH 06/19] Unify error handling in lib/safe_net.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-7-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid syscall return values
- Use safe_*() functions in tst_get_unused_port()

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/safe_net.c | 262 +++++++++++++++++++++++++++++--------------------
 1 file changed, 156 insertions(+), 106 deletions(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 499368007..1c486b209 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -18,6 +18,7 @@
 
 #include <errno.h>
 #include "test.h"
+#include "safe_macros_fn.h"
 #include "safe_net_fn.h"
 
 char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
@@ -111,7 +112,7 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	rval = socket(domain, type, protocol);
 
-	if (rval < 0) {
+	if (rval == -1) {
 		switch (errno) {
 		case EPROTONOSUPPORT:
 		case ESOCKTNOSUPPORT:
@@ -124,9 +125,12 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 			ttype = TBROK;
 		}
 
-		tst_brkm(ttype | TERRNO, cleanup_fn,
-			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
-			 domain, type, protocol);
+		tst_brkm_(file, lineno, ttype | TERRNO, cleanup_fn,
+			"socket(%d, %d, %d) failed", domain, type, protocol);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid socket(%d, %d, %d) return value %d", domain,
+			type, protocol, rval);
 	}
 
 	return rval;
@@ -139,7 +143,7 @@ int safe_socketpair(const char *file, const int lineno, int domain, int type,
 
 	rval = socketpair(domain, type, protocol, sv);
 
-	if (rval < 0) {
+	if (rval == -1) {
 		switch (errno) {
 		case EPROTONOSUPPORT:
 		case EOPNOTSUPP:
@@ -150,9 +154,13 @@ int safe_socketpair(const char *file, const int lineno, int domain, int type,
 			ttype = TBROK;
 		}
 
-		tst_brkm(ttype | TERRNO, NULL,
-			 "%s:%d: socketpair(%d, %d, %d, %p) failed",
-			 file, lineno, domain, type, protocol, sv);
+		tst_brkm_(file, lineno, ttype | TERRNO, NULL,
+			"socketpair(%d, %d, %d, %p) failed", domain, type,
+			protocol, sv);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid socketpair(%d, %d, %d, %p) return value %d",
+			domain, type, protocol, sv, rval);
 	}
 
 	return rval;
@@ -163,12 +171,16 @@ int safe_getsockopt(const char *file, const int lineno, int sockfd, int level,
 {
 	int rval = getsockopt(sockfd, level, optname, optval, optlen);
 
-	if (!rval)
-		return 0;
-
-	tst_brkm(TBROK | TERRNO, NULL,
-		 "%s:%d: getsockopt(%d, %d, %d, %p, %p) failed",
-		 file, lineno, sockfd, level, optname, optval, optlen);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"getsockopt(%d, %d, %d, %p, %p) failed",
+			sockfd, level, optname, optval, optlen);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid getsockopt(%d, %d, %d, %p, %p) return "
+			"value %d", sockfd, level, optname, optval, optlen,
+			rval);
+	}
 
 	return rval;
 }
@@ -180,10 +192,15 @@ int safe_setsockopt(const char *file, const int lineno, int sockfd, int level,
 
 	rval = setsockopt(sockfd, level, optname, optval, optlen);
 
-	if (rval) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: setsockopt(%d, %d, %d, %p, %d) failed",
-			 file, lineno, sockfd, level, optname, optval, optlen);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"setsockopt(%d, %d, %d, %p, %d) failed",
+			sockfd, level, optname, optval, optlen);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid setsockopt(%d, %d, %d, %p, %d) return "
+			"value %d", sockfd, level, optname, optval, optlen,
+			rval);
 	}
 
 	return rval;
@@ -197,9 +214,13 @@ ssize_t safe_send(const char *file, const int lineno, char len_strict,
 	rval = send(sockfd, buf, len, flags);
 
 	if (rval == -1 || (len_strict && (size_t)rval != len)) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: send(%d, %p, %zu, %d) failed",
-			 file, lineno, sockfd, buf, len, flags);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"send(%d, %p, %zu, %d) failed", sockfd, buf, len,
+			flags);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid send(%d, %p, %zu, %d) return value %zd",
+			sockfd, buf, len, flags, rval);
 	}
 
 	return rval;
@@ -215,11 +236,17 @@ ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
 	rval = sendto(sockfd, buf, len, flags, dest_addr, addrlen);
 
 	if (rval == -1 || (len_strict && (size_t)rval != len)) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: sendto(%d, %p, %zu, %d, %s, %d) failed",
-			 file, lineno, sockfd, buf, len, flags,
-			 tst_sock_addr(dest_addr, addrlen, res, sizeof(res)),
-			 addrlen);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"sendto(%d, %p, %zu, %d, %s, %d) failed",
+			sockfd, buf, len, flags,
+			tst_sock_addr(dest_addr, addrlen, res, sizeof(res)),
+			addrlen);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid sendto(%d, %p, %zu, %d, %s, %d) return "
+			"value %zd", sockfd, buf, len, flags,
+			tst_sock_addr(dest_addr, addrlen, res, sizeof(res)),
+			addrlen, rval);
 	}
 
 	return rval;
@@ -233,15 +260,16 @@ ssize_t safe_sendmsg(const char *file, const int lineno, size_t len,
 	rval = sendmsg(sockfd, msg, flags);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: sendmsg(%d, %p, %d) failed",
-			 file, lineno, sockfd, msg, flags);
-	}
-
-	if (len && (size_t)rval != len) {
-		tst_brkm(TBROK, NULL,
-			 "%s:%d: sendmsg(%d, %p, %d) ret(%zd) != len(%zu)",
-			 file, lineno, sockfd, msg, flags, rval, len);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"sendmsg(%d, %p, %d) failed", sockfd, msg, flags);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid sendmsg(%d, %p, %d) return value %zd",
+			sockfd, msg, flags, rval);
+	} else if (len && (size_t)rval != len) {
+		tst_brkm_(file, lineno, TBROK, NULL,
+			 "sendmsg(%d, %p, %d) ret(%zd) != len(%zu)",
+			 sockfd, msg, flags, rval, len);
 	}
 
 	return rval;
@@ -255,15 +283,16 @@ ssize_t safe_recvmsg(const char *file, const int lineno, size_t len,
 	rval = recvmsg(sockfd, msg, flags);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: recvmsg(%d, %p, %d) failed",
-			 file, lineno, sockfd, msg, flags);
-	}
-
-	if (len && (size_t)rval != len) {
-		tst_brkm(TBROK, NULL,
-			 "%s:%d: recvmsg(%d, %p, %d) ret(%zd) != len(%zu)",
-			 file, lineno, sockfd, msg, flags, rval, len);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"recvmsg(%d, %p, %d) failed", sockfd, msg, flags);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid recvmsg(%d, %p, %d) return value %zd",
+			sockfd, msg, flags, rval);
+	} else if (len && (size_t)rval != len) {
+		tst_brkm_(file, lineno, TBROK, NULL,
+			"recvmsg(%d, %p, %d) ret(%zd) != len(%zu)",
+			sockfd, msg, flags, rval, len);
 	}
 
 	return rval;
@@ -274,35 +303,41 @@ int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 	      int socket, const struct sockaddr *address,
 	      socklen_t address_len)
 {
-	int i;
+	int i, ret;
 	char buf[128];
 
 	for (i = 0; i < 120; i++) {
-		if (!bind(socket, address, address_len))
+		ret = bind(socket, address, address_len);
+
+		if (!ret)
 			return 0;
 
-		if (errno != EADDRINUSE) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				 "%s:%d: bind(%d, %s, %d) failed", file, lineno,
-				 socket, tst_sock_addr(address, address_len,
-						       buf, sizeof(buf)),
-				 address_len);
-			return -1;
+		if (ret != -1) {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"Invalid bind(%d, %s, %d) return value %d",
+				socket, tst_sock_addr(address, address_len,
+				buf, sizeof(buf)), address_len, ret);
+			return ret;
+		} else if (errno != EADDRINUSE) {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"bind(%d, %s, %d) failed", socket,
+				tst_sock_addr(address, address_len, buf,
+				sizeof(buf)), address_len);
+			return ret;
 		}
 
 		if ((i + 1) % 10 == 0) {
-			tst_resm(TINFO, "address is in use, waited %3i sec",
-				 i + 1);
+			tst_resm_(file, lineno, TINFO,
+				"address is in use, waited %3i sec", i + 1);
 		}
 
 		sleep(1);
 	}
 
-	tst_brkm(TBROK | TERRNO, cleanup_fn,
-		 "%s:%d: Failed to bind(%d, %s, %d) after 120 retries", file,
-		 lineno, socket,
-		 tst_sock_addr(address, address_len, buf, sizeof(buf)),
-		 address_len);
+	tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+		"Failed to bind(%d, %s, %d) after 120 retries", socket,
+		tst_sock_addr(address, address_len, buf, sizeof(buf)),
+		address_len);
 	return -1;
 }
 
@@ -313,10 +348,13 @@ int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	rval = listen(socket, backlog);
 
-	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: listen(%d, %d) failed", file, lineno, socket,
-			 backlog);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"listen(%d, %d) failed", socket, backlog);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid listen(%d, %d) return value %d", socket,
+			backlog, rval);
 	}
 
 	return rval;
@@ -329,10 +367,13 @@ int safe_accept(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	rval = accept(sockfd, addr, addrlen);
 
-	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"%s:%d: accept(%d, %p, %d) failed", file, lineno,
-			sockfd, addr, *addrlen);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"accept(%d, %p, %d) failed", sockfd, addr, *addrlen);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid accept(%d, %p, %d) return value %d", sockfd,
+			addr, *addrlen, rval);
 	}
 
 	return rval;
@@ -346,11 +387,16 @@ int safe_connect(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	rval = connect(sockfd, addr, addrlen);
 
-	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: connect(%d, %s, %d) failed", file, lineno,
-			 sockfd, tst_sock_addr(addr, addrlen, buf,
-					       sizeof(buf)), addrlen);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"connect(%d, %s, %d) failed", sockfd,
+			tst_sock_addr(addr, addrlen, buf, sizeof(buf)),
+			addrlen);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid connect(%d, %s, %d) return value %d", sockfd,
+			tst_sock_addr(addr, addrlen, buf, sizeof(buf)),
+			addrlen, rval);
 	}
 
 	return rval;
@@ -365,11 +411,16 @@ int safe_getsockname(const char *file, const int lineno,
 
 	rval = getsockname(sockfd, addr, addrlen);
 
-	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getsockname(%d, %s, %d) failed", file, lineno,
-			 sockfd, tst_sock_addr(addr, *addrlen, buf,
-					       sizeof(buf)), *addrlen);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"getsockname(%d, %s, %d) failed", sockfd,
+			tst_sock_addr(addr, *addrlen, buf, sizeof(buf)),
+			*addrlen);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid getsockname(%d, %s, %d) return value %d",
+			sockfd, tst_sock_addr(addr, *addrlen, buf,
+			sizeof(buf)), *addrlen, rval);
 	}
 
 	return rval;
@@ -380,10 +431,13 @@ int safe_gethostname(const char *file, const int lineno,
 {
 	int rval = gethostname(name, size);
 
-	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: gethostname(%p, %zu) failed",
-			 file, lineno, name, size);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"gethostname(%p, %zu) failed", name, size);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid gethostname(%p, %zu) return value %d", name,
+			size, rval);
 	}
 
 	return rval;
@@ -395,7 +449,7 @@ int safe_gethostname(const char *file, const int lineno,
 unsigned short tst_get_unused_port(const char *file, const int lineno,
 	      void (cleanup_fn)(void), unsigned short family, int type)
 {
-	int sock;
+	int sock, ret;
 	socklen_t slen;
 	struct sockaddr_storage _addr;
 	struct sockaddr *addr = (struct sockaddr *)&_addr;
@@ -418,35 +472,31 @@ unsigned short tst_get_unused_port(const char *file, const int lineno,
 		break;
 
 	default:
-		tst_brkm(TBROK, cleanup_fn,
-			"%s:%d: unknown family", file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"%s(): Unsupported socket family %d", __func__,
+			family);
 		return -1;
 	}
 
-	sock = socket(addr->sa_family, type, 0);
-	if (sock < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: socket failed", file, lineno);
-		return -1;
-	}
+	sock = safe_socket(file, lineno, cleanup_fn, addr->sa_family, type, 0);
 
-	if (bind(sock, addr, slen) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: bind failed", file, lineno);
-		return -1;
-	}
+	if (sock < 0)
+		return sock;
 
-	if (getsockname(sock, addr, &slen) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getsockname failed", file, lineno);
-		return -1;
-	}
+	ret = safe_bind(file, lineno, cleanup_fn, sock, addr, slen);
 
-	if (close(sock) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: close failed", file, lineno);
-		return -1;
-	}
+	if (ret)
+		return ret;
+
+	ret = safe_getsockname(file, lineno, cleanup_fn, sock, addr, &slen);
+
+	if (ret)
+		return ret;
+
+	ret = safe_close(file, lineno, cleanup_fn, sock);
+
+	if (ret)
+		return ret;
 
 	switch (family) {
 	case AF_INET:
-- 
2.28.0

