From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Nov 2017 12:39:46 +0100
Subject: [LTP] [RFC PATCH 3/4] lapi: Add lapi/in.h with definition moved
	from netstress.c
In-Reply-To: <20171109113947.24609-1-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
Message-ID: <20171109113947.24609-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ remove now unused include netinet/in.h

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/in.h                       | 25 +++++++++++++++++++++++++
 testcases/network/netstress/netstress.c |  6 +-----
 2 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100644 include/lapi/in.h

diff --git a/include/lapi/in.h b/include/lapi/in.h
new file mode 100644
index 000000000..9e623fa61
--- /dev/null
+++ b/include/lapi/in.h
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
+#ifndef IN_H__
+#define IN_H__
+
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP		33
+#endif
+
+#endif	/* IN_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 790a76e20..8a9736a71 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -23,7 +23,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <netdb.h>
-#include <netinet/in.h>
 #include <arpa/inet.h>
 #include <poll.h>
 #include <time.h>
@@ -31,6 +30,7 @@
 #include <unistd.h>
 #include <errno.h>
 
+#include "lapi/in.h"
 #include "lapi/posix_clocks.h"
 #include "lapi/socket.h"
 #include "lapi/tcp.h"
@@ -39,10 +39,6 @@
 
 static const int max_msg_len = (1 << 16) - 1;
 
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP		33
-#endif
-
 #ifndef DCCP_SOCKOPT_SERVICE
 #define DCCP_SOCKOPT_SERVICE	2
 #endif
-- 
2.15.0

