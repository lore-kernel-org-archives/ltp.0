From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Apr 2017 15:37:16 +0200
Subject: [LTP] [COMMITTED] [PATCH] move_pages12: Fix undefined reference to
	WIFEXITED()
Message-ID: <20170427133716.28276-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test failed to compile on slightly older glibc due to missing
reference to WIFEXITED() caused by missing <sys/wait.h> include.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 44a7777..eeec489 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -36,6 +36,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 
 #include "tst_test.h"
 #include "move_pages_support.h"
-- 
2.10.2

