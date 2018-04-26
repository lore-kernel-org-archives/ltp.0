From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Apr 2018 12:52:12 +0200
Subject: [LTP] [PATCH] cve-2017-16939: drop linux/xfrm.h include
Message-ID: <d54cb909eacb6c2fe6b11f7e187862ef3070499c.1524739878.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Mixing libc and linux headers can cause conflicts on some
distros. Drop linux/xfrm.h include and add needed defines
to a new lapi header.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/xfrm.h            | 29 +++++++++++++++++++++++++++++
 testcases/cve/cve-2017-16939.c |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/xfrm.h

diff --git a/include/lapi/xfrm.h b/include/lapi/xfrm.h
new file mode 100644
index 000000000000..013199b1a092
--- /dev/null
+++ b/include/lapi/xfrm.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2018 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation
+ */
+
+#ifndef __XFRM_H__
+#define __XFRM_H__
+
+#ifndef XFRMNLGRP_NONE
+# define XFRMNLGRP_NONE 0
+#endif
+
+#ifndef XFRM_MSG_GETPOLICY
+# define XFRM_MSG_GETPOLICY 21
+#endif
+
+#endif
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index 223ca834b8db..a4a38ba34375 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -30,8 +30,8 @@
 #include <sys/wait.h>
 #include <netinet/in.h>
 #include <linux/netlink.h>
-#include <linux/xfrm.h>
 
+#include "lapi/xfrm.h"
 #include "tst_test.h"
 #include "tst_res_flags.h"
 #include "tst_safe_macros.h"
-- 
1.8.3.1

