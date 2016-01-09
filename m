From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:14 +0000
Subject: [LTP] [PATCH V2 26/32] crash01: Define _GNU_SOURCE
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-26-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes musl build errors like
error: 'SA_NOMASK' undeclared (first use in this function)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/misc/crash/crash01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/misc/crash/crash01.c b/testcases/misc/crash/crash01.c
index 0574521..08a02e7 100644
--- a/testcases/misc/crash/crash01.c
+++ b/testcases/misc/crash/crash01.c
@@ -49,7 +49,7 @@ stress test at the same time you run other tests, like a multi-user
 benchmark.
 
 */
-
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.7.0

