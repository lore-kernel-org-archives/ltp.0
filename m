From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Dec 2017 20:27:39 +0100
Subject: [LTP] [RFC PATCH v2 4/4] lapi: Add lapi/dccp.h with definition
	moved from netstress.c
In-Reply-To: <20171221192739.4868-1-pvorel@suse.cz>
References: <20171221192739.4868-1-pvorel@suse.cz>
Message-ID: <20171221192739.4868-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and use lapi/dccp.h in netstress.c.

+ include <linux/dccp.h> in netstress.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/dccp.h                     | 27 +++++++++++++++++++++++++++
 testcases/network/netstress/netstress.c |  6 ++----
 2 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/dccp.h

diff --git a/include/lapi/dccp.h b/include/lapi/dccp.h
new file mode 100644
index 000000000..1d7fa0522
--- /dev/null
+++ b/include/lapi/dccp.h
@@ -0,0 +1,27 @@
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
+#ifndef LAPI_DCCP_H__
+#define LAPI_DCCP_H__
+
+#include <linux/dccp.h>
+
+#ifndef DCCP_SOCKOPT_SERVICE
+# define DCCP_SOCKOPT_SERVICE	2
+#endif
+
+#endif	/* LAPI_DCCP_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index ccf5af24c..66efb50b2 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -21,6 +21,7 @@
 #include <pthread.h>
 #include <stdlib.h>
 #include <limits.h>
+#include <linux/dccp.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netdb.h>
@@ -33,6 +34,7 @@
 #include <unistd.h>
 #include <errno.h>
 
+#include "lapi/dccp.h"
 #include "lapi/in.h"
 #include "lapi/posix_clocks.h"
 #include "lapi/socket.h"
@@ -44,10 +46,6 @@
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
 
-#ifndef DCCP_SOCKOPT_SERVICE
-#define DCCP_SOCKOPT_SERVICE	2
-#endif
-
 enum {
 	SERVER_HOST = 0,
 	CLIENT_HOST,
-- 
2.15.1

