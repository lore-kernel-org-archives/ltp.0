From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 21:28:17 +0800
Subject: [LTP] [PATCH v2 1/2] lapi/keyctl.h: Add fallback definition of
	keyutil.h
In-Reply-To: <ac931c16-d892-fb72-0ac5-83655c116cad@cn.fujitsu.com>
References: <ac931c16-d892-fb72-0ac5-83655c116cad@cn.fujitsu.com>
Message-ID: <20170824132818.14260-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/keyctl.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index ed3b7bd..e761be8 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -23,6 +23,55 @@
 # include <linux/keyctl.h>
 #endif /* HAVE_LINUX_KEYCTL_H */
 
+#ifdef HAVE_KEYUTILS_H
+# include <keyutils.h>
+#else
+# include <stdarg.h>
+# include <stdint.h>
+# include "lapi/syscalls.h"
+# ifdef __TEST_H__
+#  define TST_SYSCALL_WRAPPER ltp_syscall
+# else
+#  define TST_SYSCALL_WRAPPER tst_syscall
+# endif /* __TEST_H__ */
+typedef int32_t key_serial_t;
+
+static inline key_serial_t add_key(const char *type,
+				   const char *description,
+				   const void *payload,
+				   size_t plen,
+				   key_serial_t ringid)
+{
+	return TST_SYSCALL_WRAPPER(__NR_add_key,
+		type, description, payload, plen, ringid);
+}
+
+static inline key_serial_t request_key(const char *type,
+				       const char *description,
+				       const char *callout_info,
+				       key_serial_t destringid)
+{
+	return TST_SYSCALL_WRAPPER(__NR_request_key,
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
+	return TST_SYSCALL_WRAPPER(__NR_keyctl,
+		cmd, arg2, arg3, arg4, arg5);
+}
+#endif /* HAVE_KEYUTILS_H */
+
 #ifndef KEYCTL_GET_KEYRING_ID
 # define KEYCTL_GET_KEYRING_ID 0
 #endif
-- 
2.9.4



