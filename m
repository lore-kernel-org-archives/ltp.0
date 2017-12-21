From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Dec 2017 20:27:37 +0100
Subject: [LTP] [RFC PATCH v2 2/4] lapi/socket.h: Move definitions from
	netstress.c
In-Reply-To: <20171221192739.4868-1-pvorel@suse.cz>
References: <20171221192739.4868-1-pvorel@suse.cz>
Message-ID: <20171221192739.4868-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and use lapi/socket.h in netstress.c.

+ include <sys/socket.h> in lapi/socket.h

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/socket.h                   | 18 ++++++++++++++++++
 testcases/network/netstress/netstress.c | 17 ++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 98263105e..d97d29f36 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -19,8 +19,26 @@
 #ifndef __LAPI_SOCKET_H__
 #define __LAPI_SOCKET_H__
 
+#include <sys/socket.h>
+
+#ifndef MSG_FASTOPEN
+# define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
+#endif
+
+#ifndef SO_BUSY_POLL
+# define SO_BUSY_POLL	46
+#endif
+
 #ifndef SOCK_CLOEXEC
 # define SOCK_CLOEXEC 02000000
 #endif
 
+#ifndef SOCK_DCCP
+# define SOCK_DCCP		6
+#endif
+
+#ifndef SOL_DCCP
+# define SOL_DCCP		269
+#endif
+
 #endif /* __LAPI_SOCKET_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index cc07e9fd5..6a6b57c1f 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -34,6 +34,7 @@
 #include <errno.h>
 
 #include "lapi/posix_clocks.h"
+#include "lapi/socket.h"
 #include "lapi/tcp.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_pthread.h"
@@ -42,28 +43,14 @@
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
 
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
2.15.1

