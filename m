From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Aug 2020 15:09:00 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/utimensat01: Use lapi/utime.h
 for fallback definitions
Message-ID: <20200810130900.14986-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes build failures on musl.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/utimensat/utimensat01.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 17d2abd74..901f59c0e 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -16,11 +16,9 @@
 #include <string.h>
 #include <sys/stat.h>
 #include "lapi/fs.h"
+#include "lapi/utime.h"
 #include "tst_timer.h"
 
-#define UTIME_NOW	((1l << 30) - 1l)
-#define UTIME_OMIT	((1l << 30) - 2l)
-
 #define TEST_FILE	"test_file"
 #define TEST_DIR	"test_dir"
 
-- 
2.26.2

