From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Nov 2017 12:39:45 +0100
Subject: [LTP] [RFC PATCH 2/4] lapi/socket.h: Move definitions from
	netstress.c
In-Reply-To: <20171109113947.24609-1-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
Message-ID: <20171109113947.24609-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ remove sys/socket.h from netstress.c

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/socket.h                   | 18 +++++++++++++++++-
 testcases/network/netstress/netstress.c | 18 ++----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 98263105e..af9448804 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -19,8 +19,24 @@
 #ifndef __LAPI_SOCKET_H__
 #define __LAPI_SOCKET_H__
 
+#ifndef MSG_FASTOPEN
+#define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
+#endif
+
+#ifndef SO_BUSY_POLL
+#define SO_BUSY_POLL	46
+#endif
+
 #ifndef SOCK_CLOEXEC
-# define SOCK_CLOEXEC 02000000
+#define SOCK_CLOEXEC 02000000
+#endif
+
+#ifndef SOCK_DCCP
+#define SOCK_DCCP		6
+#endif
+
+#ifndef SOL_DCCP
+#define SOL_DCCP		269
 #endif
 
 #endif /* __LAPI_SOCKET_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index d45c858dc..790a76e20 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -22,7 +22,6 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <sys/types.h>
-#include <sys/socket.h>
 #include <netdb.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
@@ -33,34 +32,21 @@
 #include <errno.h>
 
 #include "lapi/posix_clocks.h"
+#include "lapi/socket.h"
 #include "lapi/tcp.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
 
 static const int max_msg_len = (1 << 16) - 1;
 
-#ifndef SOCK_DCCP
-#define SOCK_DCCP		6
-#endif
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP		33
 #endif
-#ifndef SOL_DCCP
-#define SOL_DCCP		269
-#endif
+
 #ifndef DCCP_SOCKOPT_SERVICE
 #define DCCP_SOCKOPT_SERVICE	2
 #endif
 
-#ifndef SO_BUSY_POLL
-#define SO_BUSY_POLL	46
-#endif
-
-/* TCP client requiers */
-#ifndef MSG_FASTOPEN
-#define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
-#endif
-
 enum {
 	SERVER_HOST = 0,
 	CLIENT_HOST,
-- 
2.15.0

