From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Dec 2017 20:27:38 +0100
Subject: [LTP] [RFC PATCH v2 3/4] lapi: Add lapi/in.h with definition moved
	from netstress.c
In-Reply-To: <20171221192739.4868-1-pvorel@suse.cz>
References: <20171221192739.4868-1-pvorel@suse.cz>
Message-ID: <20171221192739.4868-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and use lapi/in.h in netstress.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/in.h                       | 27 +++++++++++++++++++++++++++
 testcases/network/netstress/netstress.c |  5 +----
 2 files changed, 28 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/in.h

diff --git a/include/lapi/in.h b/include/lapi/in.h
new file mode 100644
index 000000000..84aca4d2a
--- /dev/null
+++ b/include/lapi/in.h
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
+#ifndef LAPI_IN_H__
+#define LAPI_IN_H__
+
+#include <netinet/in.h>
+
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP		33
+#endif
+
+#endif	/* LAPI_IN_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 6a6b57c1f..ccf5af24c 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 #include <errno.h>
 
+#include "lapi/in.h"
 #include "lapi/posix_clocks.h"
 #include "lapi/socket.h"
 #include "lapi/tcp.h"
@@ -43,10 +44,6 @@
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
 
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP		33
-#endif
-
 #ifndef DCCP_SOCKOPT_SERVICE
 #define DCCP_SOCKOPT_SERVICE	2
 #endif
-- 
2.15.1

