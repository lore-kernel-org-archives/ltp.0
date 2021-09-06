From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  6 Sep 2021 14:19:54 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/mkdir02: Reformat the
 description comment
Message-ID: <20210906121954.11569-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So that it's picked up by doc parser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/mkdir/mkdir02.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index 2cb199c56..7fa055b8d 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -3,10 +3,12 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*  DESCRIPTION
- *  This test will verify that new directory created by mkdir(2) inherites
- *  the group ID from the parent directory and S_ISGID bit, if the S_ISGID
- *  bit is set in the parent directory.
+/*\
+ * [Description]
+ *
+ * Verify that new directory created by mkdir(2) inherites the group ID from
+ * the parent directory and S_ISGID bit, if the S_ISGID bit is set in the
+ * parent directory.
  */
 
 #include <sys/stat.h>
-- 
2.31.1

