From: Jakub Racek <jracek@redhat.com>
Date: Mon,  6 Mar 2017 18:45:36 +0100
Subject: [LTP] [PATCH v2 2/6] Added memfd_create() lapi flags
In-Reply-To: <1488822340-29259-1-git-send-email-jracek@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
Message-ID: <1488822340-29259-3-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 include/lapi/memfd.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/lapi/memfd.h

diff --git a/include/lapi/memfd.h b/include/lapi/memfd.h
new file mode 100644
index 0000000..18ed40f
--- /dev/null
+++ b/include/lapi/memfd.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2017  Red Hat, Inc.
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
+ */
+
+#ifndef LAPI_MEMFD_H
+#define LAPI_MEMFD_H
+
+/* flags for memfd_create(2) (unsigned int) */
+#ifndef MFD_CLOEXEC
+# define MFD_CLOEXEC             0x0001U
+#endif
+#ifndef MFD_ALLOW_SEALING
+# define MFD_ALLOW_SEALING       0x0002U
+#endif
+
+#endif
-- 
1.8.3.1

