From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 15:31:00 -0700
Subject: [LTP] [PATCH] android: access02: fix the executable shell path
Message-ID: <20170828223100.66766-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test generated script used the hardcoded "/bin/sh" shell path
that doesn't exist on Android system. So fix that by using
"_PATH_BSHELL" variable defined in paths.h for both bionic and glibc.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---

FWIW, I tested this both with an Android system as well as on an x86, ubuntu
system to make sure this works with glibc as well as bionic.

 testcases/kernel/syscalls/access/access02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 0154b83a4..78449ca0b 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -38,6 +38,7 @@
 #include <pwd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <paths.h>
 #include "tst_test.h"
 
 #define FNAME_F	"file_f"
@@ -187,7 +188,7 @@ static void setup(void)
 	SAFE_TOUCH(FNAME_R, 0444, NULL);
 	SAFE_TOUCH(FNAME_W, 0222, NULL);
 	SAFE_TOUCH(FNAME_X, 0555, NULL);
-	SAFE_FILE_PRINTF(FNAME_X, "#!/bin/sh\n");
+	SAFE_FILE_PRINTF(FNAME_X, "#!%s\n", _PATH_BSHELL);
 
 	SAFE_SYMLINK(FNAME_F, SNAME_F);
 	SAFE_SYMLINK(FNAME_R, SNAME_R);
-- 
2.14.1.342.g6490525c54-goog

