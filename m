From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 29 Aug 2017 11:37:01 +0800
Subject: [LTP] [PATCH v4 1/3] lapi/keyctl.h: Add fallback definition of
	keyutil.h
In-Reply-To: <20170828110206.GA21355@rei.lan>
References: <20170828110206.GA21355@rei.lan>
Message-ID: <20170829033703.5772-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/keyctl.h | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index ed3b7bd..3e7ce47 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -19,9 +19,51 @@
 #define KEYCTL_H__
 
 #include "config.h"
-#ifdef HAVE_LINUX_KEYCTL_H
-# include <linux/keyctl.h>
-#endif /* HAVE_LINUX_KEYCTL_H */
+#ifdef HAVE_KEYUTILS_H
+# include <keyutils.h>
+#else
+# ifdef HAVE_LINUX_KEYCTL_H
+#  include <linux/keyctl.h>
+# endif /* HAVE_LINUX_KEYCTL_H */
+# include <stdarg.h>
+# include <stdint.h>
+# include "lapi/syscalls.h"
+typedef int32_t key_serial_t;
+
+static inline key_serial_t add_key(const char *type,
+				   const char *description,
+				   const void *payload,
+				   size_t plen,
+				   key_serial_t ringid)
+{
+	return tst_syscall(__NR_add_key,
+		type, description, payload, plen, ringid);
+}
+
+static inline key_serial_t request_key(const char *type,
+				       const char *description,
+				       const char *callout_info,
+				       key_serial_t destringid)
+{
+	return tst_syscall(__NR_request_key,
+		type, description, callout_info, destringid);
+}
+
+static inline long keyctl(int cmd, ...)
+{
+	va_list va;
+	unsigned long arg2, arg3, arg4, arg5;
+
+	va_start(va, cmd);
+	arg2 = va_arg(va, unsigned long);
+	arg3 = va_arg(va, unsigned long);
+	arg4 = va_arg(va, unsigned long);
+	arg5 = va_arg(va, unsigned long);
+	va_end(va);
+
+	return tst_syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
+}
+#endif /* HAVE_KEYUTILS_H */
 
 #ifndef KEYCTL_GET_KEYRING_ID
 # define KEYCTL_GET_KEYRING_ID 0
-- 
2.9.4



