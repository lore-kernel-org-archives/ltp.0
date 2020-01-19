From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Sun, 19 Jan 2020 15:49:58 +0800
Subject: [LTP] [PATCH 2/2] syscalls/add_key01: remove duplicated case
In-Reply-To: <1579420198-29651-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1579420198-29651-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1579420198-29651-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since add_key05.c has covered this test point, remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 -
 testcases/kernel/syscalls/add_key/.gitignore  |  1 -
 testcases/kernel/syscalls/add_key/add_key01.c | 26 -------------------
 3 files changed, 28 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/add_key/add_key01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 830dfc8b7..04db95cf5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -14,7 +14,6 @@ access04 access04
 acct01 acct01
 acct02 acct02
 
-add_key01 add_key01
 add_key02 add_key02
 add_key03 add_key03
 add_key04 add_key04
diff --git a/testcases/kernel/syscalls/add_key/.gitignore b/testcases/kernel/syscalls/add_key/.gitignore
index f57dc2228..49acda06b 100644
--- a/testcases/kernel/syscalls/add_key/.gitignore
+++ b/testcases/kernel/syscalls/add_key/.gitignore
@@ -1,4 +1,3 @@
-/add_key01
 /add_key02
 /add_key03
 /add_key04
diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
deleted file mode 100644
index 4fe97dac6..000000000
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) Crackerjack Project., 2007
- * Porting from Crackerjack to LTP is done by
- * Manas Kumar Nayak maknayak@in.ibm.com>
- *
- * Basic test for the add_key() syscall.
- */
-
-#include <errno.h>
-
-#include "tst_test.h"
-#include "lapi/keyctl.h"
-
-static void verify_add_key(void)
-{
-	TEST(add_key("keyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));
-	if (TST_RET == -1)
-		tst_res(TFAIL | TTERRNO, "add_key call failed");
-	else
-		tst_res(TPASS, "add_key call succeeded");
-}
-
-static struct tst_test test = {
-	.test_all = verify_add_key,
-};
-- 
2.18.0



