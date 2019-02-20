From: Daniel =?unknown-8bit?q?D=C3=ADaz?= <daniel.diaz@linaro.org>
Date: Wed, 20 Feb 2019 09:34:10 -0600
Subject: [LTP] [PATCH 1/3] Add header file lapi/signal.h
Message-ID: <20190220153412.18090-1-daniel.diaz@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Some libc implementations might differ in the definitions they
include. Exempli gratia: MUSL does not define __SIGRTMAX nor
__SIGRTMIN.

This header covers those differences for all tests that
require those definitions.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 include/lapi/signal.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/lapi/signal.h

diff --git a/include/lapi/signal.h b/include/lapi/signal.h
new file mode 100644
index 000000000..d22965a94
--- /dev/null
+++ b/include/lapi/signal.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Daniel Díaz <daniel.diaz@linaro.org>
+ */
+
+#ifndef LAPI_SIGNAL_H
+#define LAPI_SIGNAL_H
+
+#include <signal.h>
+
+/*
+ * Some libc implementations might differ in the definitions they include. This
+ * covers those differences for all tests to successfully build.
+ */
+
+#ifndef __SIGRTMIN
+# define __SIGRTMIN 32
+#endif
+#ifndef __SIGRTMAX
+# define __SIGRTMAX (_NSIG - 1)
+#endif
+
+#endif
-- 
2.17.1

