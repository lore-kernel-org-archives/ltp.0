From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 30 Jan 2019 12:28:24 +0100
Subject: [LTP] [PATCH 1/3] lib: Add missing <string.h> and <strings.h>
	includes
In-Reply-To: <20190130112826.7157-1-petr.vorel@gmail.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
Message-ID: <20190130112826.7157-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/newlib_tests/tst_strstatus.c     | 1 +
 lib/tst_kconfig.c                    | 1 +
 lib/tst_sys_conf.c                   | 1 +
 lib/tst_timer_test.c                 | 1 +
 utils/sctp/func_tests/test_getname.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/lib/newlib_tests/tst_strstatus.c b/lib/newlib_tests/tst_strstatus.c
index b35ea8ce3..ca6be49cc 100644
--- a/lib/newlib_tests/tst_strstatus.c
+++ b/lib/newlib_tests/tst_strstatus.c
@@ -20,6 +20,7 @@
  * Basic unit test for the tst_strstatus() function.
  */
 
+#include <string.h>
 #include "tst_test.h"
 
 static struct tcase {
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 3683f48c4..4b51413e5 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -5,6 +5,7 @@
 
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <ctype.h>
 #include <sys/utsname.h>
 
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 9eccfbd55..e767856ec 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -7,6 +7,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <string.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 2aa27920e..8ad831cab 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -19,6 +19,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <limits.h>
+#include <string.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
diff --git a/utils/sctp/func_tests/test_getname.c b/utils/sctp/func_tests/test_getname.c
index 0d4d080d2..ffc47357c 100644
--- a/utils/sctp/func_tests/test_getname.c
+++ b/utils/sctp/func_tests/test_getname.c
@@ -41,6 +41,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <strings.h>
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-- 
2.20.1

