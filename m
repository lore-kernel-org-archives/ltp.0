From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon,  5 Jun 2017 10:48:10 -0700
Subject: [LTP] [PATCH 1/2] syscalls/add_key02: remove test
In-Reply-To: <20170605174811.95267-1-ebiggers3@gmail.com>
References: <20170605174811.95267-1-ebiggers3@gmail.com>
Message-ID: <20170605174811.95267-2-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

add_key02 was supposed to be a "Basic test for the add_key() syscall",
but it actually happened to test the obscure case of passing a NULL
payload with nonzero length.  This case was mishandled by the kernel,
which either returned EINVAL or crashed with a NULL pointer dereference,
depending on the key type.  (The former applied to the test, as it used
the "user" key type.)  The expected behavior is that the syscall fail
with EFAULT.

As this is being fixed by the kernel patch "KEYS: fix dereferencing NULL
payload with nonzero length", the test needed to be updated.  To avoid
making it appear as a regression, just remove the test; the next patch
will add a replacement test as add_key03.  The new test will also be
more thorough as it will test other key types besides "user", including
ones that cause a NULL pointer dereference in unfixed kernels.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                              |  1 -
 testcases/kernel/syscalls/.gitignore          |  1 -
 testcases/kernel/syscalls/add_key/add_key02.c | 74 ---------------------------
 3 files changed, 76 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/add_key/add_key02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fe5227290..0c3c46e57 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -12,7 +12,6 @@ access04 access04
 acct01 acct01
 
 add_key01 add_key01
-add_key02 add_key02
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index c14c4e66b..5b8df06f5 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -7,7 +7,6 @@
 /access/access04
 /acct/acct01
 /add_key/add_key01
-/add_key/add_key02
 /adjtimex/adjtimex01
 /adjtimex/adjtimex02
 /alarm/alarm01
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
deleted file mode 100644
index 866800d6f..000000000
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007				      *
- *									      *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or	      *
- * (at your option) any later version.					      *
- *									      *
- * This program is distributed in the hope that it will be useful,	      *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of	      *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      *
- * the GNU General Public License for more details.			      *
- *									      *
- * You should have received a copy of the GNU General Public License	      *
- * along with this program;  if not, write to the Free Software	Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *									      *
- ******************************************************************************/
-
-/*
- * Basic test for the add_key() syscall.
- *
- * History:   Porting from Crackerjack to LTP is done by
- *	      Manas Kumar Nayak maknayak@in.ibm.com>
- */
-
-#include "config.h"
-#ifdef HAVE_LINUX_KEYCTL_H
-# include <linux/keyctl.h>
-#endif
-#include "tst_test.h"
-#include "linux_syscall_numbers.h"
-
-#ifdef HAVE_LINUX_KEYCTL_H
-struct tcase {
-	char *type;
-	char *desc;
-	void *payload;
-	int plen;
-	int exp_errno;
-} tcases[] = {
-	{"user", "firstkey", NULL, 1, EINVAL}
-};
-#endif /* HAVE_LINUX_KEYCTL_H */
-
-static void verify_add_key(unsigned int i)
-{
-#ifdef HAVE_LINUX_KEYCTL_H
-	TEST(tst_syscall(__NR_add_key, tcases[i].type, tcases[i].desc,
-	                 tcases[i].payload, tcases[i].plen,
-	                 KEY_SPEC_USER_KEYRING));
-
-	if (TEST_RETURN != -1) {
-		tst_res(TFAIL, "add_key() passed unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == tcases[i].exp_errno) {
-		tst_res(TPASS | TTERRNO, "add_key() failed expectedly");
-		return;
-	}
-
-	tst_res(TFAIL | TTERRNO,
-	        "add_key() failed unexpectedly, expected %s",
-	        tst_strerrno(tcases[i].exp_errno));
-#else
-	tst_brk(TCONF, "linux/keyctl.h was missing upon compilation.");
-#endif /* HAVE_LINUX_KEYCTL_H */
-}
-
-static struct tst_test test = {
-	.tcnt = ARRAY_SIZE(tcases),
-	.test = verify_add_key,
-};
-- 
2.13.0.506.g27d5fe0cd-goog

