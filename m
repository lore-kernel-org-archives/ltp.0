From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Dec 2017 20:27:36 +0100
Subject: [LTP] [RFC PATCH v2 1/4] lapi: Add lapi/tcp.h with definitions
	moved from netstress.c
In-Reply-To: <20171221192739.4868-1-pvorel@suse.cz>
References: <20171221192739.4868-1-pvorel@suse.cz>
Message-ID: <20171221192739.4868-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ include <netinet/tcp.h> in netstress.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/tcp.h                      | 31 +++++++++++++++++++++++++++++++
 testcases/network/netstress/netstress.c | 11 ++---------
 2 files changed, 33 insertions(+), 9 deletions(-)
 create mode 100644 include/lapi/tcp.h

diff --git a/include/lapi/tcp.h b/include/lapi/tcp.h
new file mode 100644
index 000000000..ebb0d79b2
--- /dev/null
+++ b/include/lapi/tcp.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef LAPI_TCP_H__
+#define LAPI_TCP_H__
+
+#include <netinet/tcp.h>
+
+#ifndef TCP_FASTOPEN
+# define TCP_FASTOPEN	23
+#endif
+
+#ifndef TCP_FASTOPEN_CONNECT
+# define TCP_FASTOPEN_CONNECT	30	/* Attempt FastOpen with connect */
+#endif
+
+#endif	/* LAPI_TCP_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index c6726306a..cc07e9fd5 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -25,6 +25,7 @@
 #include <sys/socket.h>
 #include <netdb.h>
 #include <netinet/in.h>
+#include <netinet/tcp.h>
 #include <arpa/inet.h>
 #include <poll.h>
 #include <time.h>
@@ -33,6 +34,7 @@
 #include <errno.h>
 
 #include "lapi/posix_clocks.h"
+#include "lapi/tcp.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
@@ -53,15 +55,6 @@ static const int min_msg_len = 5;
 #define DCCP_SOCKOPT_SERVICE	2
 #endif
 
-/* TCP server requiers */
-#ifndef TCP_FASTOPEN
-#define TCP_FASTOPEN	23
-#endif
-
-#ifndef TCP_FASTOPEN_CONNECT
-#define TCP_FASTOPEN_CONNECT	30	/* Attempt FastOpen with connect */
-#endif
-
 #ifndef SO_BUSY_POLL
 #define SO_BUSY_POLL	46
 #endif
-- 
2.15.1

