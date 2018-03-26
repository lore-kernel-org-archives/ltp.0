From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Mar 2018 14:49:31 +0800
Subject: [LTP] [PATCH] modify_ldt: remove two outdated files
Message-ID: <20180326064931.5595-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/modify_ldt/run-modify_ldt01.sh | 11 -----------
 testcases/kernel/syscalls/modify_ldt/run-modify_ldt02.sh | 11 -----------
 2 files changed, 22 deletions(-)
 delete mode 100755 testcases/kernel/syscalls/modify_ldt/run-modify_ldt01.sh
 delete mode 100755 testcases/kernel/syscalls/modify_ldt/run-modify_ldt02.sh

diff --git a/testcases/kernel/syscalls/modify_ldt/run-modify_ldt01.sh b/testcases/kernel/syscalls/modify_ldt/run-modify_ldt01.sh
deleted file mode 100755
index 78bf7a1..0000000
--- a/testcases/kernel/syscalls/modify_ldt/run-modify_ldt01.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-syscall=modify_ldt
-
-if [ -f $LTPROOT/testcases/bin/${syscall}01 ]; then
-         $LTPROOT/testcases/bin/${syscall}01
-else
-         echo "${syscall}01 0 CONF : System doesn't support execution of the test"
-
-fi
-
diff --git a/testcases/kernel/syscalls/modify_ldt/run-modify_ldt02.sh b/testcases/kernel/syscalls/modify_ldt/run-modify_ldt02.sh
deleted file mode 100755
index 0dd2e1f..0000000
--- a/testcases/kernel/syscalls/modify_ldt/run-modify_ldt02.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-syscall=modify_ldt
-
-if [ -f $LTPROOT/testcases/bin/${syscall}02 ]; then
-         $LTPROOT/testcases/bin/${syscall}02
-else
-         echo "${syscall}02 0 CONF : System doesn't support execution of the test"
-
-fi
-
-- 
2.9.3

