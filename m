From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Nov 2017 12:39:44 +0100
Subject: [LTP] [RFC PATCH 1/4] lapi: Add lapi/tcp.h with definitions moved
	from netstress.c
In-Reply-To: <20171109113947.24609-1-pvorel@suse.cz>
References: <20171109113947.24609-1-pvorel@suse.cz>
Message-ID: <20171109113947.24609-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/tcp.h                      | 25 +++++++++++++++++++++++++
 testcases/network/netstress/netstress.c |  6 +-----
 2 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100644 include/lapi/tcp.h

diff --git a/include/lapi/tcp.h b/include/lapi/tcp.h
new file mode 100644
index 000000000..44d75ab7b
--- /dev/null
+++ b/include/lapi/tcp.h
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
+#ifndef TCP_H__
+#define TCP_H__
+
+#ifndef TCP_FASTOPEN
+#define TCP_FASTOPEN	23
+#endif
+
+#endif	/* TCP_H__ */
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 4b211aa75..d45c858dc 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -33,6 +33,7 @@
 #include <errno.h>
 
 #include "lapi/posix_clocks.h"
+#include "lapi/tcp.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
 
@@ -51,11 +52,6 @@ static const int max_msg_len = (1 << 16) - 1;
 #define DCCP_SOCKOPT_SERVICE	2
 #endif
 
-/* TCP server requiers */
-#ifndef TCP_FASTOPEN
-#define TCP_FASTOPEN	23
-#endif
-
 #ifndef SO_BUSY_POLL
 #define SO_BUSY_POLL	46
 #endif
-- 
2.15.0

