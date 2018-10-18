From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 13:24:32 +0200
Subject: [LTP] [PATCH 5/6] kernel/pt_test: Add missing string.h header
In-Reply-To: <20181018112433.9554-1-pvorel@suse.cz>
References: <20181018112433.9554-1-pvorel@suse.cz>
Message-ID: <20181018112433.9554-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Fixes implicit declaration of function warnings on older compilers:

pt_test.c: In function ‘intel_pt_pmu_value’:
pt_test.c:67:6: warning: implicit declaration of function ‘strstr’ [-Wimplicit-function-declaration]
  if (strstr(value, delims) == NULL) {
      ^~~~~~
pt_test.c:67:6: warning: incompatible implicit declaration of built-in function ‘strstr’
pt_test.c:67:6: note: include ‘<string.h>’ or provide a declaration of ‘strstr’
pt_test.c:70:3: warning: implicit declaration of function ‘strsep’; did you mean ‘strlen’? [-Wimplicit-function-declaration]
   strsep(&value, delims);
   ^~~~~~

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/tracing/pt_test/pt_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
index abf575d37..fe5b1e914 100644
--- a/testcases/kernel/tracing/pt_test/pt_test.c
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -18,6 +18,7 @@
 #include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "config.h"
-- 
2.19.1

