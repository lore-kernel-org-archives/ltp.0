From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 28 Aug 2018 14:16:54 -0300
Subject: [LTP] [PATCH v2] fs/read_all: define FNM_EXTMATCH if needed
In-Reply-To: <20180723130146.GA2983@dell5510>
References: <20180723130146.GA2983@dell5510>
Message-ID: <20180828171654.532-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

FNM_EXTMATCH is not defined in musl libc:

| read_all.c: In function 'read_test':
| read_all.c:201:41: error: 'FNM_EXTMATCH' undeclared (first use in this function); did you mean 'FNM_NOMATCH'?
|   if (exclude && !fnmatch(exclude, path, FNM_EXTMATCH)) {
|                                          ^~~~~~~~~~~~
|                                          FNM_NOMATCH
| read_all.c:201:41: note: each undeclared identifier is reported only once for each function it appears in
| <builtin>: recipe for target 'read_all' failed
| make[4]: *** [read_all] Error 1

Even not being 100% musl ready at the moment, this seems a trivial fix
to allow LTP to be built with musl libc.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Tested-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 include/lapi/fnmatch.h                  | 14 ++++++++++++++
 testcases/kernel/fs/read_all/read_all.c |  1 +
 2 files changed, 15 insertions(+)
 create mode 100644 include/lapi/fnmatch.h

diff --git a/include/lapi/fnmatch.h b/include/lapi/fnmatch.h
new file mode 100644
index 000000000..9628ac440
--- /dev/null
+++ b/include/lapi/fnmatch.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+#ifndef FNMATCH_H__
+#define FNMATCH_H__
+
+#ifndef FNM_EXTMATCH
+#define FNM_EXTMATCH 0
+#endif
+
+#endif
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index ac463dba9..1f0b315a1 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -40,6 +40,7 @@
  */
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <lapi/fnmatch.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <dirent.h>
-- 
2.18.0

