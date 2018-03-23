From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 23 Mar 2018 18:37:28 +0300
Subject: [LTP] [PATCH v2 1/2] include/lapi: add sctp.h
In-Reply-To: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
References: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1521819449-27489-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: include linux/sctp.h header and check it in the configure

 configure.ac        |    1 +
 include/lapi/sctp.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 include/lapi/sctp.h

diff --git a/configure.ac b/configure.ac
index 85426ad..97d643b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,6 +44,7 @@ AC_CHECK_HEADERS([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    linux/sctp.h \
     mm.h \
     pthread.h \
     sys/epoll.h \
diff --git a/include/lapi/sctp.h b/include/lapi/sctp.h
new file mode 100644
index 0000000..69adc7a
--- /dev/null
+++ b/include/lapi/sctp.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2018 Oracle and/or its affiliates.
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
+#ifndef LAPI_SCTP_H__
+#define LAPI_SCTP_H__
+
+#ifdef HAVE_LINUX_SCTP_H
+# include <linux/sctp.h>
+#endif
+
+#ifndef SCTP_SOCKOPT_BINDX_ADD
+# define SCTP_SOCKOPT_BINDX_ADD	100
+#endif
+
+#endif	/* LAPI_SCTP_H__ */
-- 
1.7.1

