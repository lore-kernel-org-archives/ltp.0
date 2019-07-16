From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 12:40:16 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/prctl06: Remove sys/capability.h
 include
Message-ID: <20190716104016.19983-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This breaks build on system without libcap installed and the test
compiles cleanly without that include as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/prctl/prctl06.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl06.h b/testcases/kernel/syscalls/prctl/prctl06.h
index f5c66e809..7f5be20bb 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.h
+++ b/testcases/kernel/syscalls/prctl/prctl06.h
@@ -13,7 +13,6 @@
 #include <pwd.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/capability.h>
 #include <lapi/prctl.h>
 #include "tst_test.h"
 
-- 
2.21.0

