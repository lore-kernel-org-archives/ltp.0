From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 12 Mar 2020 13:55:44 +0100
Subject: [LTP] [PATCH v3 2/3] Add socket address initialization functions to
 tst_net library
In-Reply-To: <20200312125545.3976-1-mdoucha@suse.cz>
References: <20200312125545.3976-1-mdoucha@suse.cz>
Message-ID: <20200312125545.3976-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- new patch

Changes since v2:
- Added tst_ prefix to the new functions

 include/tst_net.h | 16 +++++++++++
 lib/tst_net.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/tst_net.h b/include/tst_net.h
index 2e9c33dff..6a012cfe1 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -5,6 +5,9 @@
 
 #include <arpa/inet.h>
 #include <stdio.h>
+#include <sys/types.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
 
 #define MAX_IPV4_PREFIX 32
 #define MAX_IPV6_PREFIX 128
@@ -28,3 +31,16 @@ int tst_safe_atoi(const char *s, int *ret_i);
 int tst_get_prefix(const char *ip_str, int is_ipv6);
 void tst_get_in_addr(const char *ip_str, struct in_addr *ip);
 void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6);
+
+/*
+ * Find valid connection address for a given bound socket
+ */
+socklen_t tst_get_connect_address(int sock, struct sockaddr_storage *addr);
+
+/*
+ * Initialize AF_INET/AF_INET6 socket address structure with address and port
+ */
+void tst_init_sockaddr_inet(struct sockaddr_in *sa, const char *ip_str, uint16_t port);
+void tst_init_sockaddr_inet_bin(struct sockaddr_in *sa, uint32_t ip_val, uint16_t port);
+void tst_init_sockaddr_inet6(struct sockaddr_in6 *sa, const char *ip_str, uint16_t port);
+void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct in6_addr *ip_val, uint16_t port);
diff --git a/lib/tst_net.c b/lib/tst_net.c
index bd4396a06..1ab0635be 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 2019 Martin Doucha <mdoucha@suse.cz>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -144,3 +145,73 @@ void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6)
 	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
 		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
 }
+
+socklen_t tst_get_connect_address(int sock, struct sockaddr_storage *addr)
+{
+	struct sockaddr_in *inet_ptr;
+	struct sockaddr_in6 *inet6_ptr;
+	size_t tmp_size;
+	socklen_t ret = sizeof(*addr);
+
+	SAFE_GETSOCKNAME(sock, (struct sockaddr*)addr, &ret);
+
+	/* Sanitize wildcard addresses */
+	switch (addr->ss_family) {
+	case AF_INET:
+		inet_ptr = (struct sockaddr_in*)addr;
+
+		switch (ntohl(inet_ptr->sin_addr.s_addr)) {
+		case INADDR_ANY:
+		case INADDR_BROADCAST:
+			inet_ptr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+			break;
+		}
+
+		break;
+
+	case AF_INET6:
+		inet6_ptr = (struct sockaddr_in6*)addr;
+		tmp_size = sizeof(struct in6_addr);
+
+		if (!memcmp(&inet6_ptr->sin6_addr, &in6addr_any, tmp_size)) {
+			memcpy(&inet6_ptr->sin6_addr, &in6addr_loopback,
+				tmp_size);
+		}
+
+		break;
+	}
+
+	return ret;
+}
+
+void tst_init_sockaddr_inet(struct sockaddr_in *sa, const char *ip_str, uint16_t port)
+{
+	memset(sa, 0, sizeof(struct sockaddr_in));
+	sa->sin_family = AF_INET;
+	sa->sin_port = htons(port);
+	tst_get_in_addr(ip_str, &sa->sin_addr);
+}
+
+void tst_init_sockaddr_inet_bin(struct sockaddr_in *sa, uint32_t ip_val, uint16_t port)
+{
+	memset(sa, 0, sizeof(struct sockaddr_in));
+	sa->sin_family = AF_INET;
+	sa->sin_port = htons(port);
+	sa->sin_addr.s_addr = htonl(ip_val);
+}
+
+void tst_init_sockaddr_inet6(struct sockaddr_in6 *sa, const char *ip_str, uint16_t port)
+{
+	memset(sa, 0, sizeof(struct sockaddr_in6));
+	sa->sin6_family = AF_INET6;
+	sa->sin6_port = htons(port);
+	tst_get_in6_addr(ip_str, &sa->sin6_addr);
+}
+
+void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct in6_addr *ip_val, uint16_t port)
+{
+	memset(sa, 0, sizeof(struct sockaddr_in6));
+	sa->sin6_family = AF_INET6;
+	sa->sin6_port = htons(port);
+	memcpy(&sa->sin6_addr, ip_val, sizeof(struct in6_addr));
+}
-- 
2.25.1

