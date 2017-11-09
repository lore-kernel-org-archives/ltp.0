From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Nov 2017 12:39:47 +0100
Subject: [LTP] [RFC PATCH 4/4] lapi: Add lapi/dccp.h with definition moved
	from netstress.c
In-Reply-To: <20171109113947.24609-1-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
Message-ID: <20171109113947.24609-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/dccp.h                     | 25 +++++++++++++++++++++++++
 testcases/network/netstress/netstress.c |  5 +----
 2 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/dccp.h

diff --git a/include/lapi/dccp.h b/include/lapi/dccp.h
new file mode 100644
index 000000000..e4b19f240
--- /dev/null
+++ b/include/lapi/dccp.h
@@ -0,0 +1,25 @@
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
+#ifndef DCCP_H__
+#define DCCP_H__
+
+#ifndef DCCP_SOCKOPT_SERVICE
+#define DCCP_SOCKOPT_SERVICE	2
+#endif
+
+#endif	/* DCCP_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 8a9736a71..53a43fbef 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <errno.h>
 
+#include "lapi/dccp.h"
 #include "lapi/in.h"
 #include "lapi/posix_clocks.h"
 #include "lapi/socket.h"
@@ -39,10 +40,6 @@
 
 static const int max_msg_len = (1 << 16) - 1;
 
-#ifndef DCCP_SOCKOPT_SERVICE
-#define DCCP_SOCKOPT_SERVICE	2
-#endif
-
 enum {
 	SERVER_HOST = 0,
 	CLIENT_HOST,
-- 
2.15.0

