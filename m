From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:41:53 +0200
Subject: [LTP] [PATCH v4 02/14] syscalls/request_key: Port to use
	lapi/keyctl.h header
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ minor whitespace cleanup

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h                              |  9 +++
 .../kernel/syscalls/request_key/request_key01.c    | 62 +++++++++-----------
 .../kernel/syscalls/request_key/request_key02.c    | 68 +++++++++-------------
 3 files changed, 64 insertions(+), 75 deletions(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index f3fb0c347..07c6a6dce 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -86,11 +86,16 @@ static inline long keyctl(int cmd, ...)
 #ifndef KEY_SPEC_USER_SESSION_KEYRING
 # define KEY_SPEC_USER_SESSION_KEYRING -5
 #endif
+
 /* request-key default keyrings */
 #ifndef KEY_REQKEY_DEFL_THREAD_KEYRING
 # define KEY_REQKEY_DEFL_THREAD_KEYRING 1
 #endif
 
+#ifndef KEY_REQKEY_DEFL_DEFAULT
+# define KEY_REQKEY_DEFL_DEFAULT	0
+#endif
+
 /* keyctl commands */
 #ifndef KEYCTL_GET_KEYRING_ID
 # define KEYCTL_GET_KEYRING_ID 0
@@ -124,4 +129,8 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_SET_REQKEY_KEYRING 14
 #endif
 
+#ifndef KEYCTL_SET_TIMEOUT
+# define KEYCTL_SET_TIMEOUT 15
+#endif
+
 #endif	/* KEYCTL_H__ */
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index d46bafac0..d290a0de7 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -1,40 +1,36 @@
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
-*/
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
 
 /*
-* Test Name: request_key01
-*
-* Description:
-* The testcase checks basic functionality of the request_key(2).
-* request_key(2) asks the kernel to find a key which matches the
-* specified description. If successful, it attaches it to the
-* nominated keyring and returns its serial number.
-*
-*/
+ * Test Name: request_key01
+ *
+ * Description:
+ * The testcase checks basic functionality of the request_key(2).
+ * request_key(2) asks the kernel to find a key which matches the
+ * specified description. If successful, it attaches it to the
+ * nominated keyring and returns its serial number.
+ *
+ */
 
-#include "config.h"
 #include <errno.h>
-#include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
 
 #include "tst_test.h"
-
-#ifdef HAVE_KEYUTILS_H
+#include "lapi/keyctl.h"
 
 static int key;
 
@@ -64,9 +60,3 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_request_key,
 };
-
-#else
-
-TST_TEST_TCONF("keyutils.h was missing at compilation");
-
-#endif /* HAVE_LINUX_KEYCTL_H */
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
index 9bba24119..bde74c492 100644
--- a/testcases/kernel/syscalls/request_key/request_key02.c
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -1,43 +1,39 @@
 /*
-* Copyright (c) 2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
+ * Copyright (c) 2016 Fujitsu Ltd.
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
 */
 
 /*
-* Test Name: request_key02
-*
-* Description:
-* 1) request_key(2) fails if no matching key was found.
-* 2) request_key(2) fails if A revoked key was found.
-* 3) request_key(2) fails if An expired key was found.
-*
-* Expected Result:
-* 1) request_key(2) should return -1 and set errno to ENOKEY.
-* 2) request_key(2) should return -1 and set errno to EKEYREVOKED.
-* 3) request_key(2) should return -1 and set errno to EKEYEXPIRED.
-*
-*/
+ * Test Name: request_key02
+ *
+ * Description:
+ * 1) request_key(2) fails if no matching key was found.
+ * 2) request_key(2) fails if A revoked key was found.
+ * 3) request_key(2) fails if An expired key was found.
+ *
+ * Expected Result:
+ * 1) request_key(2) should return -1 and set errno to ENOKEY.
+ * 2) request_key(2) should return -1 and set errno to EKEYREVOKED.
+ * 3) request_key(2) should return -1 and set errno to EKEYEXPIRED.
+ */
 
-#include "config.h"
 #include <errno.h>
-#include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
-#include "tst_test.h"
 
-#ifdef HAVE_KEYUTILS_H
+#include "tst_test.h"
+#include "lapi/keyctl.h"
 
 static int key1;
 static int key2;
@@ -111,9 +107,3 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_request_key,
 };
-
-#else
-
-TST_TEST_TCONF("keyutils.h was missing at compilation");
-
-#endif /* HAVE_LINUX_KEYCTL_H */
-- 
2.14.2

