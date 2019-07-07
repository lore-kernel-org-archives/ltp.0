From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun,  7 Jul 2019 21:00:13 +0200
Subject: [LTP] [PATCH 2/5] lapi: Add utsname.h
In-Reply-To: <20190707190016.27296-1-petr.vorel@gmail.com>
References: <20190707190016.27296-1-petr.vorel@gmail.com>
Message-ID: <20190707190016.27296-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Non-standard _UTSNAME_DOMAIN_LENGTH and _UTSNAME_LENGTH constants aren't
defined for MUSL and Bionic.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 configure.ac           |  1 +
 include/lapi/utsname.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 include/lapi/utsname.h

diff --git a/configure.ac b/configure.ac
index f78db90ce..97991e85f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,6 +57,7 @@ AC_CHECK_HEADERS([ \
     sys/prctl.h \
     sys/shm.h \
     sys/ustat.h \
+    sys/utsname.h \
     sys/xattr.h \
 ])
 
diff --git a/include/lapi/utsname.h b/include/lapi/utsname.h
new file mode 100644
index 000000000..6209eac47
--- /dev/null
+++ b/include/lapi/utsname.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+ */
+
+#ifdef HAVE_SYS_UTSNAME_H
+# include <sys/utsname.h>
+#endif
+
+#ifndef _UTSNAME_LENGTH
+# define _UTSNAME_LENGTH 65
+#endif
+
+#ifndef _UTSNAME_DOMAIN_LENGTH
+# define _UTSNAME_DOMAIN_LENGTH _UTSNAME_LENGTH
+#endif
-- 
2.20.1

