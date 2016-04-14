From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Apr 2016 10:59:22 +0200
Subject: [LTP] [PATCH v2 2/4] m4: add a check for __sync_add_and_fetch
In-Reply-To: <7260589f891c8c60ada465b5086215c4eba8d346.1460622188.git.jstancek@redhat.com>
References: <7260589f891c8c60ada465b5086215c4eba8d346.1460622188.git.jstancek@redhat.com>
Message-ID: <57e43baa7463633bf01e477091502718d176dad3.1460622188.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilers older than gcc 4.1.2 do not provide __sync_add_and_fetch,
newer ones usually do, but it still may be missing for some targets.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 configure.ac                 |  1 +
 include/tst_atomic.h         | 14 +++++++++++++-
 m4/ltp-sync_add_and_fetch.m4 | 29 +++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 m4/ltp-sync_add_and_fetch.m4

Changes in v2:
- no changes. I kept single definition of tst_atomic_inc()
  out of all #ifdefs as opposed to making 2 definitions
  for both (!)HAVE_SYNC_ADD_AND_FETCH cases.
  Now that we have a more generic version (atomic_add_return),
  that is compiler/arch dependent, it seems more tidy to me to
  keep just one definition of atomic_inc.
  
diff --git a/configure.ac b/configure.ac
index 2fb1ebc4a9c1..92ed5ec0e500 100644
--- a/configure.ac
+++ b/configure.ac
@@ -185,5 +185,6 @@ LTP_CHECK_KCMP_TYPE
 LTP_CHECK_PREADV
 LTP_CHECK_PWRITEV
 LTP_CHECK_EPOLL_PWAIT
+LTP_CHECK_SYNC_ADD_AND_FETCH
 
 AC_OUTPUT
diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 2ec9f91318ea..046eb160ad28 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -18,9 +18,21 @@
 #ifndef TST_ATOMIC_H__
 #define TST_ATOMIC_H__
 
+#include "config.h"
+
+#if HAVE_SYNC_ADD_AND_FETCH == 1
+static inline __attribute__((always_inline)) int atomic_add_return(int i, int *v)
+{
+	return __sync_add_and_fetch(v, i);
+}
+#else
+#error Your compiler does not provide __sync_add_and_fetch and LTP\
+ implementation is missing for your architecture.
+#endif
+
 static inline int tst_atomic_inc(int *v)
 {
-	return __sync_add_and_fetch(v, 1);
+	return atomic_add_return(1, v);
 }
 
 #endif	/* TST_ATOMIC_H__ */
diff --git a/m4/ltp-sync_add_and_fetch.m4 b/m4/ltp-sync_add_and_fetch.m4
new file mode 100644
index 000000000000..b9e222589267
--- /dev/null
+++ b/m4/ltp-sync_add_and_fetch.m4
@@ -0,0 +1,29 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2016
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+
+AC_DEFUN([LTP_CHECK_SYNC_ADD_AND_FETCH],[dnl
+	AC_MSG_CHECKING([for __sync_add_and_fetch])
+	AC_LINK_IFELSE([AC_LANG_SOURCE([
+int main(void) {
+	int i = 0;
+	return __sync_add_and_fetch(&i, 1);
+}])],[has_saac="yes"])
+
+if test "x$has_saac" = xyes; then
+	AC_DEFINE(HAVE_SYNC_ADD_AND_FETCH,1,[Define to 1 if you have __sync_add_and_fetch])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
-- 
1.8.3.1

