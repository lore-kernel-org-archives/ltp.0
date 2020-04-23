From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Apr 2020 15:16:31 +0200
Subject: [LTP] [PATCH v5 1/2] net: Add SAFE_GETADDRINFO()
In-Reply-To: <20200423131632.20525-1-pvorel@suse.cz>
References: <20200423131632.20525-1-pvorel@suse.cz>
Message-ID: <20200423131632.20525-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

based on setup_addrinfo() from netstress.c.

Added only to new C API, thus code kept in tst_net.c, instead of safe_net.c,
which is also for legacy API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_net.h                       |  9 +++++++--
 include/tst_private.h                   |  1 +
 include/tst_safe_net.h                  |  6 ++++++
 lib/tst_net.c                           | 15 +++++++++++++++
 testcases/network/netstress/netstress.c | 20 ++++----------------
 5 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/include/tst_net.h b/include/tst_net.h
index 855f4fc13..daefdd9d9 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -7,9 +7,10 @@
 #define TST_NET_H_
 
 #include <arpa/inet.h>
-#include <sys/types.h>
+#include <netdb.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
+#include <sys/types.h>
 
 void tst_get_in_addr(const char *ip_str, struct in_addr *ip);
 void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6);
@@ -27,4 +28,8 @@ void tst_init_sockaddr_inet_bin(struct sockaddr_in *sa, uint32_t ip_val, uint16_
 void tst_init_sockaddr_inet6(struct sockaddr_in6 *sa, const char *ip_str, uint16_t port);
 void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct in6_addr *ip_val, uint16_t port);
 
-#endif
+void safe_getaddrinfo(const char *file, const int lineno, const char *src_addr,
+					  const char *port, const struct addrinfo *hints,
+					  struct addrinfo **addr_info);
+
+#endif /* TST_NET_H_ */
diff --git a/include/tst_private.h b/include/tst_private.h
index 00cd17fce..e30d34740 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -10,6 +10,7 @@
 #define TST_PRIVATE_H_
 
 #include <stdio.h>
+#include <netdb.h>
 
 #define MAX_IPV4_PREFIX 32
 #define MAX_IPV6_PREFIX 128
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index f31c8fe2f..78a488a18 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -12,6 +12,7 @@
 #include <sys/un.h>
 
 #include "safe_net_fn.h"
+#include "tst_net.h"
 
 #define SAFE_SOCKET(domain, type, protocol) \
 	safe_socket(__FILE__, __LINE__, NULL, domain, type, protocol)
@@ -70,4 +71,9 @@
 #define TST_GET_UNUSED_PORT(family, type) \
 	tst_get_unused_port(__FILE__, __LINE__, NULL, family, type)
 
+/* new API only */
+
+#define SAFE_GETADDRINFO(src_addr, port, hints, addr_info) \
+	safe_getaddrinfo(__FILE__, __LINE__, src_addr, port, hints, addr_info)
+
 #endif /* TST_SAFE_NET_H__ */
diff --git a/lib/tst_net.c b/lib/tst_net.c
index 22c990e62..8a589b0ad 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <netdb.h>
 #include <string.h>
 #include <stdlib.h>
 
@@ -204,3 +205,17 @@ void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct in6_addr
 	sa->sin6_port = htons(port);
 	memcpy(&sa->sin6_addr, ip_val, sizeof(struct in6_addr));
 }
+
+void safe_getaddrinfo(const char *file, const int lineno, const char *src_addr,
+					  const char *port, const struct addrinfo *hints,
+					  struct addrinfo **addr_info)
+{
+	int err = getaddrinfo(src_addr, port, hints, addr_info);
+
+	if (err)
+		tst_brk(TBROK, "%s:%d: getaddrinfo failed, %s", file, lineno,
+				gai_strerror(err));
+
+	if (!*addr_info)
+		tst_brk(TBROK, "%s:%d: failed to get the address", file, lineno);
+}
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 6797be018..c5da4d464 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -29,6 +29,7 @@
 #include "tst_safe_stdio.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
+#include "tst_safe_net.h"
 
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
@@ -441,19 +442,6 @@ static int parse_client_request(const char *msg)
 static struct timespec tv_client_start;
 static struct timespec tv_client_end;
 
-static void setup_addrinfo(const char *src_addr, const char *port,
-			   const struct addrinfo *hints,
-			   struct addrinfo **addr_info)
-{
-	int err = getaddrinfo(src_addr, port, hints, addr_info);
-
-	if (err)
-		tst_brk(TBROK, "getaddrinfo failed, %s", gai_strerror(err));
-
-	if (!*addr_info)
-		tst_brk(TBROK, "failed to get the address");
-}
-
 static void client_init(void)
 {
 	if (clients_num >= MAX_THREADS) {
@@ -471,8 +459,8 @@ static void client_init(void)
 	hints.ai_protocol = 0;
 
 	if (source_addr)
-		setup_addrinfo(source_addr, NULL, &hints, &local_addrinfo);
-	setup_addrinfo(server_addr, tcp_port, &hints, &remote_addrinfo);
+		SAFE_GETADDRINFO(source_addr, NULL, &hints, &local_addrinfo);
+	SAFE_GETADDRINFO(server_addr, tcp_port, &hints, &remote_addrinfo);
 
 	tst_res(TINFO, "Running the test over IPv%s",
 		(remote_addrinfo->ai_family == AF_INET6) ? "6" : "4");
@@ -667,7 +655,7 @@ static void server_init(void)
 
 	if (source_addr && !strchr(source_addr, ':'))
 		SAFE_ASPRINTF(&src_addr, "::ffff:%s", source_addr);
-	setup_addrinfo(src_addr ? src_addr : source_addr, tcp_port,
+	SAFE_GETADDRINFO(src_addr ? src_addr : source_addr, tcp_port,
 		       &hints, &local_addrinfo);
 	free(src_addr);
 
-- 
2.26.1

